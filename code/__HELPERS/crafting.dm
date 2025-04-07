
/**
 *  Globalized procs from the crafting component to be used outside of it.
 */

/// Takes a recipe and a key-type list and checks if said recipe can be done with available stuff.
proc/check_contents(datum/crafting_recipe/R, list/contents)
	contents = contents["other"]
	main_loop:
		for(var/A in R.reqs)
			var/needed_amount = R.reqs[A]
			for(var/B in contents)
				if(ispath(B, A))
					if(!R.subtype_reqs && B in subtypesof(A))
						continue
					if (R.blacklist.Find(B))
						testing("foundinblacklist")
						continue
					if(contents[B] >= R.reqs[A])
						continue main_loop
					else
						testing("removecontent")
						needed_amount -= contents[B]
						if(needed_amount <= 0)
							continue main_loop
						else
							continue
			return FALSE
	for(var/A in R.chem_catalysts)
		if(contents[A] < R.chem_catalysts[A])
			return FALSE
	return TRUE

/// Gets a list of things accessable for crafting by user.
proc/get_environment(mob/user)
	var/enviroment = list()
	for(var/obj/item/I in user.held_items)
		enviroment += I
	if(!isturf(user.loc))
		return
	var/list/L = block(get_step(user, SOUTHWEST), get_step(user, NORTHEAST))
	for(var/A in L)
		var/turf/T = A
		if(T.Adjacent(user))
			for(var/B in T)
				var/atom/movable/AM = B
				if(AM.flags_1 & HOLOGRAM_1)
					continue
				enviroment += AM
	for(var/slot in list(SLOT_R_STORE, SLOT_L_STORE))
		enviroment += user.get_item_by_slot(slot)
	return enviroment

/// Takes a list of things and makes a list of key-types to values-amounts of said type in the list.
proc/get_surroundings(mob/user)
	var/surroundings = list()
	surroundings["tool_behaviour"] = list()
	surroundings["other"] = list()
	for(var/obj/item/I in get_environment(user))
		if(!I.can_craft_with())
			continue
		if(I.flags_1 & HOLOGRAM_1)
			continue
		if(istype(I, /obj/item/stack))
			var/obj/item/stack/S = I
			surroundings["other"][I.type] += S.amount
		else if(istype(I, /obj/item/natural/bundle))
			var/obj/item/natural/bundle/B = I
			surroundings["other"][B.stacktype] += B.amount
		else if(I.tool_behaviour)
			surroundings["tool_behaviour"] += I.tool_behaviour
			surroundings["other"][I.type] += 1
		else
			if(istype(I, /obj/item/reagent_containers))
				var/obj/item/reagent_containers/RC = I
				if(RC.is_drainable())
					for(var/datum/reagent/A in RC.reagents.reagent_list)
						surroundings["other"][A.type] += A.volume
			surroundings["other"][I.type] += 1
	return surroundings

/// Takes recipe, a key-type list, and a user and checks if there are enough tools to do the stuff, checks bugs one level deep.
proc/check_tools(mob/user, datum/crafting_recipe/R, list/contents)
	if(!R.tools.len)
		return TRUE
	var/list/possible_tools = list()
	var/list/present_qualities = list()
	present_qualities |= contents["tool_behaviour"]
	for(var/obj/item/I in user.contents)
		if(istype(I, /obj/item/storage))
			for(var/obj/item/SI in I.contents)
				possible_tools += SI.type
				if(SI.tool_behaviour)
					present_qualities.Add(SI.tool_behaviour)

		possible_tools += I.type

		if(I.tool_behaviour)
			present_qualities.Add(I.tool_behaviour)

	possible_tools |= contents["other"]

	main_loop:
		for(var/A in R.tools)
			if(A in present_qualities)
				continue
			else
				for(var/I in possible_tools)
					if(ispath(I, A))
						continue main_loop
			return FALSE
	return TRUE

/// Attempts to build the result of a recipe.
proc/construct_item(mob/user, datum/crafting_recipe/R)
	if(user.doing)
		return
	var/list/contents = get_surroundings(user)
	var/turf/T = get_step(user, user.dir)
	var/obj/N
	var/result_name

	if(islist(R.result))
		N = R.result[1]
	else
		N = R.result
	result_name = N.name

	if(isopenturf(T) && R.wallcraft)
		to_chat(user, span_warning("Need to craft this on a wall."))
		return
	if(!isopenturf(T) || R.ontile)
		T = get_turf(user.loc)
	if(!R.TurfCheck(user, T))
		to_chat(user, span_warning("I can't craft here."))
		return
	if(isturf(R.result))
		for(var/obj/structure/fluff/traveltile/TT in range(7, user))
			to_chat(user, span_warning("I can't craft here."))
			return
	if(ispath(R.result, /obj/structure) || ispath(R.result, /obj/machinery))
		for(var/obj/structure/fluff/traveltile/TT in range(7, user))
			to_chat(user, span_warning("I can't craft here."))
			return
		for(var/obj/structure/S in T)
			if(R.buildsame && istype(S, R.result))
				if(user.dir == S.dir)
					to_chat(user, span_warning("Something is in the way."))
					return
				continue
			if(R.structurecraft && istype(S, R.structurecraft))
				testing("isstructurecraft")
				continue
			if(S.density)
				to_chat(user, span_warning("Something is in the way."))
				return
		for(var/obj/machinery/M in T)
			if(M.density)
				to_chat(user, span_warning("Something is in the way."))
				return
	if(R.req_table)
		if(!(locate(/obj/structure/table) in T))
			to_chat(user, span_warning("I need to make this on a table."))
			return
	if(R.structurecraft)
		if(!(locate(R.structurecraft) in T))
			to_chat(user, span_warning("I'm missing a structure I need."))
			return
	if(check_contents(R, contents))
		if(check_tools(user, R, contents))
			if(R.craftsound)
				playsound(T, R.craftsound, 100, TRUE)
			var/time2use = 10
			for(var/i = 1 to 100)
				if(do_after(user, time2use, target = user))
					contents = get_surroundings(user)
					if(!check_contents(R, contents))
						return ", missing component."
					if(!check_tools(user, R, contents))
						return ", missing tool."

					var/prob2craft = 25
					if(R.skill_level)
						prob2craft -= (25*R.skill_level)
					if(R.skillcraft)
						if(user.mind)
							prob2craft += (user.mind.get_skill_level(R.skillcraft) * 25)
					else
						prob2craft = 100
					if(isliving(user))
						var/mob/living/L = user
						if(L.STAINT > 10)
							prob2craft += ((10-L.STAINT)*-1)*2
					prob2craft = CLAMP(prob2craft, 0, 99)
					if(!prob(prob2craft))
						if(user.client?.prefs.showrolls)
							to_chat(user, span_danger("I've failed to craft \the [result_name]... [prob2craft]%"))
							continue
						to_chat(user, span_danger("I've failed to craft \the [result_name]."))
						continue
					var/list/parts = del_reqs(R, user)

					if(islist(R.result))
						var/list/L = R.result
						for(var/IT in L)
							var/atom/movable/I = new IT(T)
							I.CheckParts(parts, R)
							I.OnCrafted(user.dir, user)
					else
						if(ispath(R.result, /turf))
							var/turf/X = T.PlaceOnTop(R.result)
							if(X)
								X.OnCrafted(user.dir, user)
						else
							var/atom/movable/I = new R.result (T)
							I.CheckParts(parts, R)
							I.OnCrafted(user.dir, user)
					user.visible_message(span_notice("[user] [R.verbage] \a [result_name]!"), \
										span_notice("I [R.verbage_simple] \a [result_name]!"))
					if(user.mind && R.skillcraft && R.xpgain)	//Most recipes give xp, but those that don't should not
						if(isliving(user))
							var/mob/living/L = user
							var/amt2raise = L.STAINT * 2// its different over here
							if(R.skill_level > 0) //difficult recipe
								amt2raise += (R.skill_level * 10) // also gets more
							if(amt2raise > 0)
								user.mind.add_sleep_experience(R.skillcraft, amt2raise, FALSE)
					return TRUE
				return 0
			return "."
		to_chat(usr, span_warning("I'm missing a tool."))
		return
	return ", missing component."


// Used for multi-stage structures.
/// Checks if the user can craft the given recipe.
proc/check_constructability(mob/user, datum/crafting_recipe/R)

	R = new R()

	if(user.doing)
		return
	var/list/contents = get_surroundings(user)
	var/turf/T = get_step(user, user.dir)
	var/result_name

	if(check_contents(R, contents))
		if(check_tools(user, R, contents))
			if(R.craftsound)
				playsound(T, R.craftsound, 100, TRUE)
			var/time2use = 10
			for(var/i = 1 to 100)
				if(do_after(user, time2use, target = user))
					contents = get_surroundings(user)
					if(!check_contents(R, contents))
						to_chat(usr, span_warning("I'm missing a component."))
						return FALSE
					if(!check_tools(user, R, contents))
						to_chat(usr, span_warning("I'm missing a tool."))
						return FALSE

					var/prob2craft = 25
					if(R.skill_level)
						prob2craft -= (25*R.skill_level)
					if(R.skillcraft)
						if(user.mind)
							prob2craft += (user.mind.get_skill_level(R.skillcraft) * 25)
					else
						prob2craft = 100
					if(isliving(user))
						var/mob/living/L = user
						if(L.STAINT > 10)
							prob2craft += ((10-L.STAINT)*-1)*2
					prob2craft = CLAMP(prob2craft, 0, 99)
					if(!prob(prob2craft))
						if(user.client?.prefs.showrolls)
							to_chat(user, span_danger("I've failed to craft \the [result_name]... [prob2craft]%"))
							continue
						to_chat(user, span_danger("I've failed to craft \the [result_name]."))
						continue
					del_reqs(R, user)

					if(user.mind && R.skillcraft)
						if(isliving(user))
							var/mob/living/L = user
							var/amt2raise = L.STAINT * 2// its different over here
							if(R.skill_level > 0) //difficult recipe
								amt2raise += (R.skill_level * 10) // also gets more
							if(amt2raise > 0)
								user.mind.add_sleep_experience(R.skillcraft, amt2raise, FALSE)
					return TRUE
				return FALSE
			return FALSE
		to_chat(usr, span_warning("I'm missing a tool."))
		return FALSE
	to_chat(usr, span_warning("I'm missing a component."))
	return FALSE

/*Del reqs works like this:

	Loop over reqs var of the recipe
	Set var amt to the value current cycle req is pointing to, its amount of type we need to delete
	Get var/surroundings list of things accessable to crafting by get_environment()
	Check the type of the current cycle req
		If its reagent then do a while loop, inside it try to locate() reagent containers, inside such containers try to locate needed reagent, if there isnt remove thing from surroundings
			If there is enough reagent in the search result then delete the needed amount, create the same type of reagent with the same data var and put it into deletion list
			If there isnt enough take all of that reagent from the container, put into deletion list, substract the amt var by the volume of reagent, remove the container from surroundings list and keep searching
			While doing above stuff check deletion list if it already has such reagnet, if yes merge instead of adding second one
		If its stack check if it has enough amount
			If yes create new stack with the needed amount and put in into deletion list, substract taken amount from the stack
			If no put all of the stack in the deletion list, substract its amount from amt and keep searching
			While doing above stuff check deletion list if it already has such stack type, if yes try to merge them instead of adding new one
		If its anything else just locate() in in the list in a while loop, each find --s the amt var and puts the found stuff in deletion loop

	Then do a loop over parts var of the recipe
		Do similar stuff to what we have done above, but now in deletion list, until the parts conditions are satisfied keep taking from the deletion list and putting it into parts list for return

	After its done loop over deletion list and delete all the shit that wasnt taken by parts loop

	del_reqs return the list of parts resulting object will receive as argument of CheckParts proc, on the atom level it will add them all to the contents, on all other levels it calls ..() and does whatever is needed afterwards but from contents list already
*/

/// Takes recipe and a user, loops over the recipes reqs var and tries to find everything in the list make by get_environment and delete it/add to parts list, then returns the said list.
proc/del_reqs(datum/crafting_recipe/R, mob/user)
	var/list/surroundings
	var/list/Deletion = list()
	. = list()
	var/data
	var/amt
	main_loop:
		for(var/A in R.reqs)
			amt = R.reqs[A]
			surroundings = get_environment(user)
			surroundings -= Deletion
			if(ispath(A, /datum/reagent))
				var/datum/reagent/RG = new A
				var/datum/reagent/RGNT
				while(amt > 0)
					var/obj/item/reagent_containers/RC = locate() in surroundings
					RG = RC.reagents.get_reagent(A)
					if(RG)
						if(!locate(RG.type) in Deletion)
							Deletion += new RG.type()
						if(RG.volume > amt)
							RG.volume -= amt
							data = RG.data
							RC.reagents.conditional_update(RC)
							RG = locate(RG.type) in Deletion
							RG.volume = amt
							RG.data += data
							continue main_loop
						else
							surroundings -= RC
							amt -= RG.volume
							RC.reagents.reagent_list -= RG
							RC.reagents.conditional_update(RC)
							RGNT = locate(RG.type) in Deletion
							RGNT.volume += RG.volume
							RGNT.data += RG.data
							qdel(RG)
						RC.on_reagent_change()
					else
						surroundings -= RC
			else if(ispath(A, /obj/item/stack))
				var/obj/item/stack/S
				var/obj/item/stack/SD
				while(amt > 0)
					S = locate(A) in surroundings
					if(S.amount >= amt)
						if(!locate(S.type) in Deletion)
							SD = new S.type()
							Deletion += SD
						S.use(amt)
						SD = locate(S.type) in Deletion
						SD.amount += amt
						continue main_loop
					else
						amt -= S.amount
						if(!locate(S.type) in Deletion)
							Deletion += S
						else
							data = S.amount
							S = locate(S.type) in Deletion
							S.add(data)
						surroundings -= S
			else if(ispath(A, /obj/item/natural) || A == /obj/item/grown/log/tree/stick)
				while(amt > 0)
					for(var/obj/item/natural/bundle/B in get_environment(user))
						if(B.stacktype == A)
							if(B.amount > amt)
								B.amount -= amt
								B.update_bundle()
								switch(B.amount)
									if(1)
										var/mob/living/carbon/old_loc = B.loc
										qdel(B)
										var/new_item = new B.stacktype(old_loc)
										// Put in the person's hands if there were holding it.
										if(ishuman(old_loc))
											old_loc.put_in_hands(new_item)
									if(0)
										qdel(B)
								amt = 0
								continue main_loop
							else
								qdel(B)
								amt -= B.amount
						else
							continue
					var/atom/movable/I
					while(amt > 0)
						I = locate(A) in surroundings
						Deletion += I
						surroundings -= I
						amt--
			else
				var/atom/movable/I
				while(amt > 0)
					I = locate(A) in surroundings
					Deletion += I
					surroundings -= I
					amt--
	var/list/partlist = R.parts.Copy()
	for(var/A in R.parts)
		if(istype(A, /datum/reagent))
			var/datum/reagent/RG = locate(A) in Deletion
			if(RG.volume > partlist[A])
				RG.volume = partlist[A]
			. += RG
			Deletion -= RG
			continue
		else if(istype(A, /obj/item/stack))
			var/obj/item/stack/ST = locate(A) in Deletion
			if(ST.amount > partlist[A])
				ST.amount = partlist[A]
			. += ST
			Deletion -= ST
			continue
		else
			while(partlist[A] > 0)
				var/atom/movable/AM = locate(A) in Deletion
				. += AM
				Deletion -= AM
				partlist[A] -= 1
	while(Deletion.len)
		var/DL = Deletion[Deletion.len]
		Deletion.Cut(Deletion.len)
		qdel(DL)

proc/roguecraft(location, control, params, mob/user)
	if(user.doing)
		return
	var/area/A = get_area(user)
	if(!A.can_craft_here())
		to_chat(user, span_warning("I can't craft here."))
		return
	var/list/data = list()
	var/list/catty = list()
	var/list/surroundings = get_surroundings(user)
	for(var/rec in GLOB.crafting_recipes)
		var/datum/crafting_recipe/R = rec
		if(!R.always_available && !(R.type in user?.mind?.learned_recipes)) //User doesn't actually know how to make this.
			continue

		if(check_contents(R, surroundings))
			if(R.name)
				data += R
				if(R.skillcraft)
					var/datum/skill/S = new R.skillcraft()
					catty |= S.name
				else
					catty |= "Other"
	if(!data.len)
		to_chat(user, span_warning("There is nothing I can craft."))
		return
	if(!catty.len)
		return
	var/t
	if(catty.len > 1)
		t=input(user, "CHOOSE SKILL") as null|anything in catty
	else
		t=pick(catty)
	if(t)
		var/list/realdata = list()
		for(var/datum/crafting_recipe/X in data)
			if(X.skillcraft)
				var/datum/skill/S = new X.skillcraft()
				if(t == S.name)
					realdata += X
			else
				if(t == "Other")
					realdata += X
		if(realdata.len)
			var/r = input(user, "What should I craft?") as null|anything in realdata
			if(r)
				construct_item(user, r)
				user.mind.lastrecipe = r
