/obj/machinery/artificer_table
	name = "artificer table"
	desc = "An artificers wood work station, blessed by some odd machination, or perhaps... magic..."
	icon_state = "art_table"
	icon = 'icons/obj/smooth_structures/table.dmi'
	var/obj/item/grown/log/tree/small/plank/plank
	damage_deflection = 18
	density = TRUE
	climbable = TRUE

/obj/machinery/artificer_table/examine(mob/user)
	. = ..()
	if(plank)
		. += span_warning("There's a wood plank ready to be worked.")

/obj/machinery/artificer_table/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/grown/log/tree/small/plank))
		if(!plank)
			I.forceMove(src)
			plank = I
			update_icon()
			return
		else if(plank && plank.currecipe && plank.currecipe.hammered && plank.currecipe.extra_planks_needed > 0)
			plank.currecipe.plank_add(user)
			qdel(I)
			return
	if(istype(I, /obj/item/rogueweapon/hammer/wood))
		user.changeNext_move(CLICK_CD_RANGE)
		if(!plank)
			return
		if(!plank.currecipe)
			if(!choose_recipe(user))
				return
		to_chat(user, span_warning("This recipe requires [plank.currecipe.extra_planks_needed] extra planks."))
		playsound(src, 'sound/misc/woodhit.ogg', 100, TRUE)
		var/skill = user.mind.get_skill_level(plank.currecipe.appro_skill)
		if(plank.currecipe.progress == 100)
			new plank.currecipe.created_item(get_turf(src))
			qdel(plank)
			plank = null
			update_icon()
			user.visible_message(span_info("[user] creates a [initial(plank.currecipe.created_item.name)]."))
			user.mind.add_sleep_experience(plank.currecipe.appro_skill, (user.STAINT * (plank.currecipe.craftdiff * 10))) //may need to be adjusted
			return
		if(skill < plank.currecipe.craftdiff)
			if(prob(25))
				to_chat(user, span_warning("Ah yes, my incompetence bears fruit."))
				playsound(src,'sound/combat/hits/onwood/destroyfurniture.ogg', 100, FALSE)
				qdel(plank)
				plank = null
				user.mind.add_sleep_experience(plank.currecipe.appro_skill, (user.STAINT * plank.currecipe.craftdiff)) // Getting exp for failing
				return
			else
				plank.currecipe.advance(I, user)
				return
		plank.currecipe.advance(I, user)
	if(plank && plank.currecipe && plank.currecipe.hammered && istype(I, plank.currecipe.needed_item))
		plank.currecipe.item_added(user)
		qdel(I)
		return
	..()

/obj/machinery/artificer_table/proc/choose_recipe(user)
	if(!plank)
		return

	var/list/valid_types = list()

	for(var/datum/artificer_recipe/R in GLOB.artificer_recipes)
		if(istype(plank, R.required_item))
			if(!valid_types.Find(R.i_type))
				valid_types += R.i_type

	if(!valid_types.len)
		return

	var/i_type_choice = input(user, "Choose a type", "Artificer") as null|anything in valid_types
	if(!i_type_choice)
		return

	var/list/appro_recipe = list()
	for(var/datum/artificer_recipe/R in GLOB.artificer_recipes)
		if(R.i_type == i_type_choice && istype(plank, R.required_item))
			appro_recipe += R

	for(var/I in appro_recipe)
		var/datum/artificer_recipe/R = I
		if(!R.required_item)
			appro_recipe -= R
		if(!istype(plank, R.required_item))
			appro_recipe -= R

	if(appro_recipe.len)
		var/datum/chosen_recipe = input(user, "Choose A Creation", "Artificer") as null|anything in sortNames(appro_recipe.Copy())
		if(!plank.currecipe && chosen_recipe)
			plank.currecipe = new chosen_recipe.type(plank)
			return TRUE

	return FALSE

/obj/machinery/artificer_table/attack_hand(mob/user, params)
	if(plank)
		var/obj/item/I = plank
		plank = null
		I.loc = user.loc
		user.put_in_active_hand(I)
		update_icon()

/obj/machinery/artificer_table/update_icon()
	cut_overlays()
	if(plank)
		var/obj/item/I = plank
		I.pixel_x = 0
		I.pixel_y = 0
		var/mutable_appearance/M = new /mutable_appearance(I)
		M.transform *= 0.5
		M.pixel_y = 5
		M.pixel_x = 3
		add_overlay(M)
