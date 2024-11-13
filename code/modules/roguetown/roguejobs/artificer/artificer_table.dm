/obj/machinery/artificer_table
	name = "artificer table"
	desc = "An artificers wood work station, blessed by some odd machination, or perhaps... magic..."
	icon_state = "art_table"
	icon = 'icons/roguetown/misc/tables.dmi'
	var/obj/item/material
	damage_deflection = 25
	density = TRUE
	climbable = TRUE

/obj/item // This is probably a bad idea. Sorry...
	/// Artificers Recipe
	var/datum/artificer_recipe/artrecipe

/obj/machinery/artificer_table/examine(mob/user)
	. = ..()
	if(material)
		. += span_warning("There's a [initial(material.name)] ready to be worked.")

/obj/machinery/artificer_table/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/natural/wood/plank) || istype(I, /obj/item/ingot))
		if(!material)
			I.forceMove(src)
			material = I
			update_icon()
			return
	if(istype(I, /obj/item/rogueweapon/hammer))
		user.changeNext_move(CLICK_CD_RAPID)
		if(!material)
			return
		if(!material.artrecipe)
			if(!choose_recipe(user))
				return
		if(material.artrecipe.hammered || material.artrecipe.progress == 100)
			playsound(src,'sound/combat/hits/onmetal/sheet (2).ogg', 100, TRUE)
			shake_camera(user, 1, 1)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(src)
		S.set_up(1, 1, front)
		S.start()
		var/skill = user.mind.get_skill_level(material.artrecipe.appro_skill)
		if(material.artrecipe.progress == 100)
			if(islist(material.artrecipe.created_item))
				var/list/L = material.artrecipe.created_item
				for(var/IT in L)
					new IT(get_turf(src))
			else
				new material.artrecipe.created_item(get_turf(src))
			var/obj/item/created_item_instance = new(material.artrecipe.created_item)
			user.visible_message(span_info("[user] creates \a [created_item_instance.name]."))
			user.mind.add_sleep_experience(material.artrecipe.appro_skill, (user.STAINT * (material.artrecipe.craftdiff * 5))) //may need to be adjusted
			qdel(material)
			material = null
			update_icon()
			return
		if(skill < material.artrecipe.craftdiff)
			if(prob(max(0, 25 - user.goodluck(2) - (skill * 2))))
				to_chat(user, span_warning("Ah yes, my incompetence bears fruit."))
				playsound(src,'sound/combat/hits/onwood/destroyfurniture.ogg', 100, FALSE)
				user.mind.add_sleep_experience(material.artrecipe.appro_skill, (user.STAINT * material.artrecipe.craftdiff)) // Getting exp for failing
				qdel(material)
				material = null
				return
		if(!material.artrecipe.hammered)
			playsound(src, pick('sound/combat/hits/onwood/fence_hit1.ogg', 'sound/combat/hits/onwood/fence_hit2.ogg', 'sound/combat/hits/onwood/fence_hit3.ogg'), 100, FALSE)
			material.artrecipe.advance(I, user)
	if(material && material.artrecipe && material.artrecipe.hammered && istype(I, material.artrecipe.needed_item))
		material.artrecipe.item_added(user)
		qdel(I)
		return
	..()

/obj/machinery/artificer_table/proc/choose_recipe(user)
	if(!material)
		return

	var/list/valid_types = list()

	for(var/datum/artificer_recipe/R in GLOB.artificer_recipes)
		if(istype(material, R.required_item))
			if(!valid_types.Find(R.i_type))
				valid_types += R.i_type

	if(!valid_types.len)
		return

	var/i_type_choice = input(user, "Choose a type", "Artificer") as null|anything in valid_types
	if(!i_type_choice)
		return

	var/list/appro_recipe = list()
	for(var/datum/artificer_recipe/R in GLOB.artificer_recipes)
		if(R.i_type == i_type_choice && istype(material, R.required_item))
			appro_recipe += R

	for(var/I in appro_recipe)
		var/datum/artificer_recipe/R = I
		if(!R.required_item)
			appro_recipe -= R
		if(!istype(material, R.required_item))
			appro_recipe -= R

	if(appro_recipe.len)
		var/datum/chosen_recipe = input(user, "Choose A Creation", "Artificer") as null|anything in sortNames(appro_recipe.Copy())
		if(!material.artrecipe && chosen_recipe)
			material.artrecipe = new chosen_recipe.type(material)
			return TRUE

	return FALSE

/obj/machinery/artificer_table/attack_hand(mob/user, params)
	if(!material)
		return
	var/obj/item/I = material
	material = null
	I.loc = user.loc
	user.put_in_active_hand(I)
	update_icon()

/obj/machinery/artificer_table/update_icon()
	cut_overlays()
	if(!material)
		return
	var/obj/item/I = material
	I.pixel_x = 0
	I.pixel_y = 0
	var/mutable_appearance/M = new /mutable_appearance(I)
	M.transform *= 0.8
	M.pixel_y = 6
	M.pixel_x = 0
	add_overlay(M)
