#define MAXIMUM_TOTAL_COMPOST 2000
#define COMPOST_PER_PRODUCED_ITEM 100

/obj/structure/composter
	name = "composter"
	desc = "A wooden fencing with space for discarded produce to turn into compost."
	icon = 'icons/obj/structures/composter.dmi'
	icon_state = "composter"
	density = FALSE
	max_integrity = 200
	anchored = TRUE
	var/unflipped_compost = 0
	var/flipped_compost = 0
	var/ready_compost = 0

/obj/structure/composter/halffull
	ready_compost = MAXIMUM_TOTAL_COMPOST * 0.5

/obj/structure/composter/full
	ready_compost = MAXIMUM_TOTAL_COMPOST

/obj/structure/composter/examine(mob/user)
	. = ..()
	var/show_dry = (unflipped_compost > flipped_compost)
	if(ready_compost > COMPOST_PER_PRODUCED_ITEM)
		. += span_info("There is some ready compost.")
	if(show_dry && unflipped_compost >= COMPOST_PER_PRODUCED_ITEM)
		. += span_warning("The compost requires flipping!")

/obj/structure/composter/update_icon()
	. = ..()
	update_overlays()

/obj/structure/composter/Initialize()
	START_PROCESSING(SSprocessing, src)
	update_icon()
	. = ..()

/obj/structure/composter/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	. = ..()

#define COMPOST_PROCESS_RATE 300 / (1 MINUTES)

/obj/structure/composter/process()
	var/dt = 10
	var/compost_to_process = min(dt * COMPOST_PROCESS_RATE, flipped_compost)
	// Change flipped compost into most processed compost, and some back unflipped
	flipped_compost -= compost_to_process
	unflipped_compost += compost_to_process * 0.25
	ready_compost += compost_to_process * 0.75

/obj/structure/composter/proc/get_total_compost()
	return unflipped_compost + flipped_compost + ready_compost

/obj/structure/composter/proc/try_handle_flipping_compost(obj/item/attacking_item, mob/user, params)
	var/using_tool = FALSE
	if(attacking_item)
		if(istype(attacking_item, /obj/item/rogueweapon/pitchfork) || istype(attacking_item, /obj/item/rogueweapon/shovel))
			using_tool = TRUE
	var/do_time = using_tool ? 4 SECONDS : 7 SECONDS
	var/fatigue = using_tool ? 10 : 20
	if(do_after(user, get_farming_do_time(user, do_time), target = src))
		apply_farming_fatigue(user, fatigue)
		to_chat(user, span_notice("I flip the compost."))
		if(using_tool)
			playsound(src,'sound/items/dig_shovel.ogg', 100, TRUE)
		flip_compost()
	return TRUE

/obj/structure/composter/proc/flip_compost()
	var/flip_amount = unflipped_compost
	unflipped_compost -= flip_amount
	flipped_compost += flip_amount
	update_icon()

/obj/structure/composter/proc/try_handle_adding_compost(obj/item/attacking_item, mob/user, params)
	var/compost_value = 0
	if(istype(attacking_item, /obj/item/reagent_containers/food/snacks))
		compost_value = 150
	if(istype(attacking_item, /obj/item/natural/chaff))
		compost_value = 150
	if(istype(attacking_item, /obj/item/trash/applecore))
		compost_value = 50
	if(compost_value > 0)
		if(compost_value + get_total_compost() >= MAXIMUM_TOTAL_COMPOST)
			to_chat(user, span_warning("There's too much compost!"))
			return TRUE
		unflipped_compost += compost_value
		to_chat(user, span_notice("I add \the [attacking_item] to \the [src]"))
		qdel(attacking_item)
		update_icon()
		return TRUE
	return FALSE

/obj/structure/composter/proc/try_handle_removing_compost(obj/item/attacking_item, mob/living/user, params)
	if(ready_compost < COMPOST_PER_PRODUCED_ITEM)
		to_chat(user, span_warning("There's not enough processed compost!"))
		return TRUE
	apply_farming_fatigue(user, 5)
	to_chat(user, span_notice("I take out some ready compost."))
	var/obj/item/compost/compost = take_out_compost()
	if(compost)
		user.put_in_active_hand(compost)
	return TRUE

/obj/structure/composter/proc/take_out_compost()
	if(ready_compost < COMPOST_PER_PRODUCED_ITEM)
		return
	ready_compost -= COMPOST_PER_PRODUCED_ITEM
	. = new /obj/item/compost(get_turf(src))
	update_icon()

/obj/structure/composter/attackby(obj/item/attacking_item, mob/user, params)
	user.changeNext_move(CLICK_CD_FAST)
	if(try_handle_adding_compost(attacking_item, user, params))
		return
	. = ..()

/obj/structure/composter/attack_hand(mob/user)
	user.changeNext_move(CLICK_CD_FAST)
	if(try_handle_removing_compost(null, user, null))
		return
	. = ..()

/obj/structure/composter/attack_right(mob/user)
	user.changeNext_move(CLICK_CD_FAST)
	var/obj/item = user.get_active_held_item()
	if(try_handle_flipping_compost(item, user, null))
		return
	return ..()

/obj/structure/composter/update_overlays()
	. = ..()
	var/total_unprocessed = unflipped_compost + flipped_compost
	var/total_processed = ready_compost
	var/show_dry = (unflipped_compost > flipped_compost)
	var/unprocesed_dry_overlay_name
	if(total_unprocessed >= MAXIMUM_TOTAL_COMPOST * 0.60)
		unprocesed_dry_overlay_name = "pre_compost_heavy_dry"
		. += "pre_compost_heavy"
	else if(total_unprocessed >= MAXIMUM_TOTAL_COMPOST * 0.30)
		unprocesed_dry_overlay_name = "pre_compost_mid_dry"
		. += "pre_compost_mid"
	else if (total_unprocessed >= COMPOST_PER_PRODUCED_ITEM)
		unprocesed_dry_overlay_name = "pre_compost_low_dry"
		. += "pre_compost_low"

	if(show_dry && unprocesed_dry_overlay_name)
		var/mutable_appearance/dry_ma = mutable_appearance(icon, unprocesed_dry_overlay_name)
		dry_ma.color = "#ffbb6d"
		dry_ma.alpha = 40
		. += dry_ma

	if(total_processed >= MAXIMUM_TOTAL_COMPOST * 0.60)
		. += "post_compost_heavy"
	else if(total_processed >= MAXIMUM_TOTAL_COMPOST * 0.30)
		. += "post_compost_mid"
	else if (total_processed >= COMPOST_PER_PRODUCED_ITEM)
		. += "post_compost_low"

/obj/item/compost
	name = "compost"
	desc = "Decomposed produce ready to give life to plants."
	icon = 'icons/obj/objects.dmi'
	icon_state = "ash"
	color = "#ffac38"
	w_class = WEIGHT_CLASS_SMALL
