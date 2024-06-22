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

#define COMPOST_PROCESS_RATE 100 / (1 MINUTES)

/obj/structure/composter/process()
	var/dt = 10
	var/compost_to_process = min(dt * COMPOST_PROCESS_RATE, flipped_compost)
	// Change flipped compost into half unflipped and half ready during process
	flipped_compost -= compost_to_process
	unflipped_compost += compost_to_process * 0.5
	ready_compost += compost_to_process * 0.5

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

/obj/structure/composter/proc/try_handle_adding_compost(obj/item/attacking_item, mob/user, params)
	var/compost_value = 0
	if(istype(attacking_item, /obj/item/reagent_containers/food/snacks/grown))
		compost_value = 100
	if(istype(attacking_item, /obj/item/trash/applecore))
		compost_value = 50
	if(compost_value > 0)
		if(get_total_compost() >= MAXIMUM_TOTAL_COMPOST)
			to_chat(user, span_warning("There's too much compost!"))
			return TRUE
		unflipped_compost += compost_value
		to_chat(user, span_notice("I add \the [attacking_item] to \the [src]"))
		qdel(attacking_item)
		update_icon()
		return TRUE
	return FALSE

/obj/structure/composter/proc/try_handle_removing_compost(obj/item/attacking_item, mob/user, params, allows_hand)
	var/using_tool = FALSE
	if(attacking_item)
		if(istype(attacking_item, /obj/item/rogueweapon/pitchfork) || istype(attacking_item, /obj/item/rogueweapon/shovel))
			using_tool = TRUE
	if(!allows_hand && !using_tool)
		return FALSE
	if(ready_compost < COMPOST_PER_PRODUCED_ITEM)
		to_chat(user, span_warning("There's not enough processed compost!"))
		return TRUE
	var/do_time = using_tool ? 2 SECONDS : 4 SECONDS
	var/fatigue = using_tool ? 0 : 5
	if(do_after(user, get_farming_do_time(user, do_time), target = src))
		apply_farming_fatigue(user, fatigue)
		to_chat(user, span_notice("I take out some ready compost."))
		if(using_tool)
			playsound(src,'sound/items/dig_shovel.ogg', 100, TRUE)
		take_out_compost()
	return TRUE

/obj/structure/composter/proc/take_out_compost()
	if(ready_compost < COMPOST_PER_PRODUCED_ITEM)
		return
	ready_compost -= COMPOST_PER_PRODUCED_ITEM
	new /obj/item/compost(get_turf(src))
	update_icon()

/obj/structure/composter/attackby(obj/item/attacking_item, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(try_handle_adding_compost(attacking_item, user, params))
		return
	if(try_handle_removing_compost(attacking_item, user, params, FALSE))
		return
	. = ..()

/obj/structure/composter/attack_hand(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	if(try_handle_removing_compost(null, user, null, TRUE))
		return
	. = ..()

/obj/structure/composter/attack_right(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	var/obj/item = user.get_active_held_item()
	if(try_handle_flipping_compost(item, user, null))
		return
	return ..()

/obj/structure/composter/update_overlays()
	. = ..()
	var/total = get_total_compost()
	if(total >= MAXIMUM_TOTAL_COMPOST * 0.60)
		. += "compost_heavy"
	else if(total >= MAXIMUM_TOTAL_COMPOST * 0.30)
		. += "compost_mid"
	else if (total >= COMPOST_PER_PRODUCED_ITEM)
		. += "compost_low"

/obj/item/compost
	name = "compost"
	desc = "Decomposed produce ready to give life to plants."
	icon = 'icons/obj/objects.dmi'
	icon_state = "ash"
	color = "#ffac38"
	w_class = WEIGHT_CLASS_SMALL
