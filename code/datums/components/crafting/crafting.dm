/datum/component/personal_crafting/Initialize()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/L = parent
	L.craftingthing = src

/datum/component/personal_crafting
	var/busy
	var/viewing_category = 1 //typical powergamer starting on the Weapons tab
	var/viewing_subcategory = 1
	var/list/categories = list(
				CAT_NONE = CAT_NONE,
			)

	var/cur_category = CAT_NONE
	var/cur_subcategory = CAT_NONE
	var/datum/action/innate/crafting/button
	var/display_craftable_only = TRUE
	var/display_compact = TRUE

/obj/item/proc/can_craft_with()
	return TRUE

/atom/proc/OnCrafted(dirin, user)
	dir = dirin
	return

/atom/proc/post_craft()
	return


/obj/item/OnCrafted(dirin)
	. = ..()

/turf/open/OnCrafted(dirin)
	. = ..()
	START_PROCESSING(SSweather,src)
	var/turf/belo = get_step_multiz(src, DOWN)
	for(var/x in 1 to 5)
		if(belo)
			START_PROCESSING(SSweather,belo)
			belo = get_step_multiz(belo, DOWN)
		else
			break

/datum/crafting_recipe/proc/TurfCheck(mob/user, turf/T)
	return TRUE


/datum/component/personal_crafting/proc/component_ui_interact(atom/movable/screen/craft/image, location, control, params, user)
	if(user == parent)
		ui_interact(user)

/datum/component/personal_crafting/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.not_incapacitated_turf_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		cur_category = categories[1]
		if(islist(categories[cur_category]))
			var/list/subcats = categories[cur_category]
			cur_subcategory = subcats[1]
		else
			cur_subcategory = CAT_NONE
		ui = new(user, src, ui_key, "personal_crafting", "Crafting Menu", 700, 800, master_ui, state)
		ui.open()

/datum/component/personal_crafting/ui_data(mob/user)
	var/list/data = list()
	data["busy"] = busy
	data["category"] = cur_category
	data["subcategory"] = cur_subcategory
	data["display_craftable_only"] = display_craftable_only
	data["display_compact"] = display_compact

	var/list/surroundings = get_surroundings(user)
	var/list/craftability = list()
	for(var/rec in GLOB.crafting_recipes)
		var/datum/crafting_recipe/R = rec

		if(!R.always_available && !(R.type in user?.mind?.learned_recipes)) //User doesn't actually know how to make this.
			continue

		if((R.category != cur_category) || (R.subcategory != cur_subcategory))
			continue

		craftability["[REF(R)]"] = check_contents(R, surroundings)

	data["craftability"] = craftability
	return data

/datum/component/personal_crafting/ui_static_data(mob/user)
	var/list/data = list()

	var/list/crafting_recipes = list()
	for(var/rec in GLOB.crafting_recipes)
		var/datum/crafting_recipe/R = rec

		if(R.name == "") //This is one of the invalid parents that sneaks in
			continue

		if(!R.always_available && !(R.type in user?.mind?.learned_recipes)) //User doesn't actually know how to make this.
			continue

		if(isnull(crafting_recipes[R.category]))
			crafting_recipes[R.category] = list()

		if(R.subcategory == CAT_NONE)
			crafting_recipes[R.category] += list(build_recipe_data(R))
		else
			if(isnull(crafting_recipes[R.category][R.subcategory]))
				crafting_recipes[R.category][R.subcategory] = list()
				crafting_recipes[R.category]["has_subcats"] = TRUE
			crafting_recipes[R.category][R.subcategory] += list(build_recipe_data(R))

	data["crafting_recipes"] = crafting_recipes
	return data


/datum/component/personal_crafting/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("make")
			var/datum/crafting_recipe/TR = locate(params["recipe"]) in GLOB.crafting_recipes
			busy = TRUE
			ui_interact(usr)
			var/fail_msg = construct_item(usr, TR)
			if(!fail_msg)
				to_chat(usr, span_notice("[TR.name] crafted."))
			else
				to_chat(usr, span_warning("craft failed: [fail_msg]"))
			busy = FALSE
		if("toggle_recipes")
			display_craftable_only = TRUE
			. = TRUE
		if("toggle_compact")
			display_compact = TRUE
			. = TRUE
		if("set_category")
			if(!isnull(params["category"]))
				cur_category = params["category"]
			if(!isnull(params["subcategory"]))
				if(params["subcategory"] == "0")
					cur_subcategory = ""
				else
					cur_subcategory = params["subcategory"]
			. = TRUE

/datum/component/personal_crafting/proc/build_recipe_data(datum/crafting_recipe/R)
	var/list/data = list()
	data["name"] = R.name
	data["ref"] = "[REF(R)]"
	var/req_text = ""
	var/tool_text = ""
	var/catalyst_text = ""

	for(var/a in R.reqs)
		//We just need the name, so cheat-typecast to /atom for speed (even tho Reagents are /datum they DO have a "name" var)
		//Also these are typepaths so sadly we can't just do "[a]"
		var/atom/A = a
		req_text += " [R.reqs[A]] [initial(A.name)],"
	req_text = replacetext(req_text,",","",-1)
	data["req_text"] = req_text

	for(var/a in R.chem_catalysts)
		var/atom/A = a //cheat-typecast
		catalyst_text += " [R.chem_catalysts[A]] [initial(A.name)],"
	catalyst_text = replacetext(catalyst_text,",","",-1)
	data["catalyst_text"] = catalyst_text

	for(var/a in R.tools)
		if(ispath(a, /obj/item))
			var/obj/item/b = a
			tool_text += " [initial(b.name)],"
		else
			tool_text += " [a],"
	tool_text = replacetext(tool_text,",","",-1)
	data["tool_text"] = tool_text

	return data

//Mind helpers

/datum/mind/proc/teach_crafting_recipe(R)
	if(!learned_recipes)
		learned_recipes = list()
	learned_recipes |= R

/datum/mind/proc/forget_crafting_recipe(R)
	if(!learned_recipes)
		return
	learned_recipes -= R
