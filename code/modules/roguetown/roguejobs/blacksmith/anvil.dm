
/obj/machinery/anvil
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "iron anvil"
	desc = "It's surface is marred by countless hammer strikes."
	icon_state = "anvil"
	var/hott = null
	var/obj/item/ingot/hingot
	max_integrity = 500
	density = TRUE
	damage_deflection = 25
	climbable = TRUE
	var/previous_material_quality = 0

/obj/machinery/anvil/crafted
	icon_state = "caveanvil"

/obj/machinery/anvil/examine(mob/user)
	. = ..()
	if(hingot && hott)
		. += span_warning("[hingot] is too hot to touch.")

/obj/machinery/anvil/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/rogueweapon/tongs))
		var/obj/item/rogueweapon/tongs/T = W
		if(hingot)
			if(T.hingot)
				..()
				return
			else
				hingot.forceMove(T)
				T.hingot = hingot
				hingot = null
				T.hott = null
				hott = null
				T.update_icon()
				update_icon()
				return
		else
			if(T.hingot && istype(T.hingot, /obj/item/ingot))
				T.hingot.forceMove(src)
				hingot = T.hingot
				T.hingot = null
				hott = T.hott
				if(hott)
					START_PROCESSING(SSmachines, src)
				T.update_icon()
				update_icon()
				return

	if(istype(W, /obj/item/ingot))
		if(!hingot)
			W.forceMove(src)
			hingot = W
			hott = null
			update_icon()
			return

	if(istype(W, /obj/item/rogueweapon/hammer))
		user.changeNext_move(CLICK_CD_MELEE)
		if(!hingot)
			return
		if(!hott)
			to_chat(user, span_warning("It's too cold."))
			return
		if(!hingot.currecipe)
			if(!choose_recipe(user))
				return
			user.flash_fullscreen("whiteflash")
			shake_camera(user, 1, 1)
			playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
		var/used_str = user.STASTR
		if(iscarbon(user))
			var/mob/living/carbon/carbon_user = user
			if(carbon_user.domhand)
				used_str = carbon_user.get_str_arms(carbon_user.used_hand)
			carbon_user.rogfat_add(max(30 - (used_str * 3), 0))
		var/total_chance = 7 * user.mind.get_skill_level(hingot.currecipe.appro_skill)
		var/breakthrough = 0
		if(prob(1 + total_chance)) //Small chance to flash
			user.flash_fullscreen("whiteflash")
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_turf(src)
			S.set_up(1, 1, front)
			S.start()
			breakthrough = 1

		if(!hingot.currecipe.advance(user, breakthrough))
			shake_camera(user, 1, 1)
			playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
		playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

		return

	if(hingot && hingot.currecipe && hingot.currecipe.needed_item && istype(W, hingot.currecipe.needed_item))
		hingot.currecipe.item_added(user)
		if(istype(W, /obj/item/ingot))
			var/obj/item/ingot/I = W
			hingot.currecipe.material_quality += I.quality
			previous_material_quality = I.quality
		else
			hingot.currecipe.material_quality += previous_material_quality
		hingot.currecipe.num_of_materials += 1 
		qdel(W)
		return

	if(W.anvilrepair)
		user.visible_message(span_info("[user] places [W] on the anvil."))
		W.forceMove(src.loc)
		return
	..()

/obj/machinery/anvil/proc/choose_recipe(user)
	if(!hingot || !hott)
		return
	
	var/list/valid_types = list()
	
	for(var/datum/anvil_recipe/R in GLOB.anvil_recipes)
		if(istype(hingot, R.req_bar))
			if(!valid_types.Find(R.i_type))
				valid_types += R.i_type
	
	if(!valid_types.len)
		return
	
	var/i_type_choice = input(user, "Choose a type", "Anvil") as null|anything in valid_types
	if(!i_type_choice)
		return
	
	var/list/appro_recipe = list()
	for(var/datum/anvil_recipe/R in GLOB.anvil_recipes)
		if(R.i_type == i_type_choice && istype(hingot, R.req_bar))
			appro_recipe += R
	
	for(var/I in appro_recipe)
		var/datum/anvil_recipe/R = I
		if(!R.req_bar)
			appro_recipe -= R
		if(!istype(hingot, R.req_bar))
			appro_recipe -= R
	
	if(appro_recipe.len)
		var/datum/chosen_recipe = input(user, "Choose A Creation", "Anvil") as null|anything in sortNames(appro_recipe.Copy())
		if(!hingot.currecipe && chosen_recipe)
			hingot.currecipe = new chosen_recipe.type(hingot)
			hingot.currecipe.material_quality += hingot.quality
			previous_material_quality = hingot.quality
			return TRUE
	
	return FALSE

/obj/machinery/anvil/attack_hand(mob/user, params)
	if(hingot)
		if(hott)
			to_chat(user, span_warning("It's too hot."))
			return
		else
			var/obj/item/I = hingot
			hingot = null
			I.loc = user.loc
			user.put_in_active_hand(I)
			update_icon()

/obj/machinery/anvil/process()
	if(hott)
		if(world.time > hott + 10 SECONDS)
			hott = null
			STOP_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSmachines, src)
	update_icon()

/obj/machinery/anvil/update_icon()
	cut_overlays()
	if(hingot)
		var/obj/item/I = hingot
		I.pixel_x = 0
		I.pixel_y = 0
		var/mutable_appearance/M = new /mutable_appearance(I)
		if(hott)
			M.filters += filter(type="color", color = list(3,0,0,1, 0,2.7,0,0.4, 0,0,1,0, 0,0,0,1))
		M.transform *= 0.5
		M.pixel_y = 5
		M.pixel_x = 3
		add_overlay(M)
