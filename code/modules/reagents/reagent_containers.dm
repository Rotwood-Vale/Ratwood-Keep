/obj/item/reagent_containers
	name = "Container"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	w_class = WEIGHT_CLASS_TINY
	var/amount_per_transfer_from_this = 5
	var/list/possible_transfer_amounts = list(5,10,15,20,25,30)
	var/volume = 30
	var/reagent_flags = null
	var/list/list_reagents = null
	var/disease_amount = 20
	var/spillable = FALSE
	var/list/fill_icon_thresholds = null
	var/fill_icon_state = null // Optional custom name for reagent fill icon_state prefix
	var/drinksounds = list('sound/items/drink_gen (1).ogg','sound/items/drink_gen (2).ogg','sound/items/drink_gen (3).ogg')
	var/fillsounds
	var/poursounds


/obj/item/reagent_containers/weather_trigger(W)
	if(W==/datum/weather/rain)
		START_PROCESSING(SSweather,src)

/obj/item/reagent_containers/Initialize(mapload, vol)
	. = ..()
	if(isnum(vol) && vol > 0)
		volume = vol
	create_reagents(volume, reagent_flags)

	add_initial_reagents()

/obj/item/reagent_containers/proc/add_initial_reagents()
	if(list_reagents)
		reagents.add_reagent_list(list_reagents)
/*
/obj/item/reagent_containers/attack_self(mob/user)
	if(possible_transfer_amounts.len)
		var/i=0
		for(var/A in possible_transfer_amounts)
			i++
			if(A == amount_per_transfer_from_this)
				if(i<possible_transfer_amounts.len)
					amount_per_transfer_from_this = possible_transfer_amounts[i+1]
				else
					amount_per_transfer_from_this = possible_transfer_amounts[1]
				to_chat(user, span_notice("[src]'s transfer amount is now [amount_per_transfer_from_this] units."))
				return*/

/obj/item/reagent_containers/attack(mob/M, mob/user, def_zone)
	return ..()

/obj/item/reagent_containers/proc/canconsume(mob/eater, mob/user, silent = FALSE)
	if(!iscarbon(eater))
		return 0
	var/mob/living/carbon/C = eater
	var/covered = ""
	if(C.is_mouth_covered(head_only = 1))
		covered = "headgear"
	else if(C.is_mouth_covered(mask_only = 1))
		covered = "mask"
	if(C != user)
		if(C.mobility_flags & MOBILITY_STAND)
			if(get_dir(eater, user) != eater.dir)
				to_chat(user, span_warning("I must stand in front of [C.p_them()]."))
				return 0
	if(covered)
		if(!silent)
			var/who = (isnull(user) || eater == user) ? "your" : "[eater.p_their()]"
			to_chat(user, span_warning("I have to remove [who] [covered] first!"))
		return 0
	return 1

/obj/item/reagent_containers/ex_act()
	if(reagents)
		for(var/datum/reagent/R in reagents.reagent_list)
			R.on_ex_act()
	if(!QDELETED(src))
		..()

/obj/item/reagent_containers/fire_act(added, maxstacks)
	reagents.expose_temperature(added)
	..()

/obj/item/reagent_containers/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	SplashReagents(hit_atom, TRUE)

/obj/item/reagent_containers/proc/bartender_check(atom/target)
	. = FALSE
	if(target.CanPass(src, get_turf(src)) && thrownby && HAS_TRAIT(thrownby, TRAIT_BOOZE_SLIDER))
		. = TRUE

/obj/item/reagent_containers/proc/SplashReagents(atom/target, thrown = FALSE)
	if(!reagents || !reagents.total_volume || !spillable)
		return

	if(ismob(target) && target.reagents)
		if(thrown)
			reagents.total_volume *= rand(5,10) * 0.1 //Not all of it makes contact with the target
		var/mob/M = target
		var/R
		target.visible_message(span_danger("[M] has been splashed with something!"), \
						span_danger("[M] has been splashed with something!"))
		for(var/datum/reagent/A in reagents.reagent_list)
			R += "[A.type]  ([num2text(A.volume)]),"

		if(thrownby)
			log_combat(thrownby, M, "splashed", R)
		reagents.reaction(target, TOUCH)

	else if(bartender_check(target) && thrown)
		visible_message(span_notice("[src] lands onto the [target.name] without spilling a single drop."))
		return

	else
		if(isturf(target) && reagents.reagent_list.len && thrownby)
			log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]", "in [AREACOORD(target)]")
			log_game("[key_name(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] in [AREACOORD(target)].")
		visible_message(span_notice("[src] spills its contents all over [target]."))
		reagents.reaction(target, TOUCH)
		if(QDELETED(src))
			return

	reagents.clear_reagents()

/obj/item/reagent_containers/heating_act()
	reagents.expose_temperature(1000)
	..()

/obj/item/reagent_containers/temperature_expose(exposed_temperature, exposed_volume)
	reagents.expose_temperature(exposed_temperature)

/obj/item/reagent_containers/on_reagent_change(changetype)
	update_icon()


///Can interact
// Checks if the containers are able to do their action first.
/obj/item/reagent_containers/proc/can_reagent_interact(obj/item/I, mob/living/carbon/human/user, datum/intent/i_action)
	var/state = TRUE
	var/failed_msg = ""
	
	/* == hard stops here == */
	//splash is sort of a special case so it happens early on.
	if(reagents.total_volume && i_action == INTENT_SPLASH)
		if(is_open_container())
			return TRUE
		else
			//tried a to_chat here but it didn't want work RIP
			return FALSE 

	if(!i_action)
		return FALSE
	if(!I.reagents || !reagents)
		return FALSE

	//soft stops here
	if(i_action == INTENT_FILL)

		if(!I.reagents.total_volume)
			to_chat(user, "\The [I] is empty!")
			state = FALSE
		if(reagents.holder_full())
			to_chat(user, "\The [src] is full.")
			state = FALSE

		//These checks come later to make failed message order work properly
		if(!is_refillable())
			failed_msg = "I can't fill this."
			state = FALSE
		if(!I.is_open_container())
			failed_msg = "\The [I] isn't open."
			state = FALSE
	
	if(i_action == INTENT_POUR)
		//Special case for adding to food.
		if(istype(I, /obj/item/reagent_containers/food/snacks))
			state = TRUE

		if(!reagents.total_volume)
			failed_msg = "\The [src] is empty!"
			state = FALSE
		if(I.reagents.holder_full())
			failed_msg = "\The [I] is full."
			state = FALSE

		//These checks come later to make failed message order work properly
		if(!I.is_refillable())
			failed_msg = "I can't fill \the [I]."
			state = FALSE
		if(!is_open_container())
			failed_msg = "\The [src] isn't open."
			state = FALSE
	if(!state)
		to_chat(user, failed_msg)
	return state

///Do interact
// Does the action based logic
/obj/item/reagent_containers/proc/do_reagent_interact(obj/item/I, mob/living/carbon/human/user, datum/intent/i_action, attempts = 100)
	if(user.m_intent != MOVE_INTENT_SNEAK)
		if(poursounds)
			playsound(user.loc, pick(poursounds), 100, TRUE)

	// INTENT POUR is FEED as in: feed INTO another object
	if(i_action == INTENT_POUR)
		user.visible_message(span_notice("[user] pours \the [src]'s contents into \the [I]."), \
		span_notice("I pour \the [src]'s contents into \the [I]."))

		for(var/i in 1 to attempts)
			if(do_after(user, 8, target = src))
				if(!reagents.total_volume)
					break
				if(I.reagents.holder_full())
					break
				if(!reagents.trans_to(I, amount_per_transfer_from_this, transfered_by = user))
					reagents.reaction(I, TOUCH, amount_per_transfer_from_this) //If it fails you try a generic reaction I think.
				I.onfill(src, user, silent = TRUE)
			else
				break
		return
	// INTENT FILL is FILL as in: fill ITSELF from another object
	if(i_action == INTENT_FILL)
		user.visible_message(span_notice("[user] fills \the [I]'s from \the [src]."), \
		span_notice("I fill \the [src] with \the [I]'s contents."))
		for(var/i in 1 to attempts)
			if(do_after(user, 8, target = src))
				if(reagents.holder_full())
					break
				if(!I.reagents.total_volume)
					break
				if(!I.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user))
					reagents.reaction(src, TOUCH, amount_per_transfer_from_this)
				onfill(I, user, silent = TRUE)
			else
				break
		return

	if(i_action == INTENT_SPLASH)
		user.visible_message(span_danger("[user] splashes the contents of [src] onto [I]!"), \
		span_notice("I splash the contents of [src] onto [I]."))
		reagents.reaction(I, TOUCH)
		reagents.clear_reagents()
		return


/*
/// Do careful transfer
// fires off a transfer 
/obj/item/reagent_containers/proc/do_careful_transfer(var/atom/A, var/amount = 3)
	if(reagents)
		reagents.trans_to(A, amount)
*/

/obj/item/reagent_containers/update_icon(dont_fill=FALSE)
	if(!fill_icon_thresholds || dont_fill)
		return ..()

	cut_overlays()

	if(reagents.total_volume)
		var/fill_name = fill_icon_state? fill_icon_state : icon_state
		var/mutable_appearance/filling = mutable_appearance('icons/obj/reagentfillings.dmi', "[fill_name][fill_icon_thresholds[1]]")

		var/percent = round((reagents.total_volume / volume) * 100)
		for(var/i in 1 to fill_icon_thresholds.len)
			var/threshold = fill_icon_thresholds[i]
			var/threshold_end = (i == fill_icon_thresholds.len)? INFINITY : fill_icon_thresholds[i+1]
			if(threshold <= percent && percent < threshold_end)
				filling.icon_state = "[fill_name][fill_icon_thresholds[i]]"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		add_overlay(filling)
	. = ..()
