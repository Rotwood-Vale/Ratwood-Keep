/obj/item/reagent_containers/hypospray               ////// I absolutely hate this stupid retarded shit why the fuck is TG garbage even in this stupid fucking indian built codebase. fuck you seth. fuck you.
	name = "hypospray"
	desc = ""
	icon = 'icons/roguetown/items/surgery.dmi'
	item_state = "sty"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "hypo"
	amount_per_transfer_from_this = 5
	volume = 30
	possible_transfer_amounts = list()
	resistance_flags = ACID_PROOF
	reagent_flags = OPENCONTAINER
	slot_flags = ITEM_SLOT_BELT
	var/ignore_flags = 0
	var/infinite = FALSE
	var/has_cap = TRUE

/obj/item/reagent_containers/hypospray/attack(mob/living/M, mob/user)
	if(has_cap)
		to_chat(user, span_warning("[src] has a cap on! You need to remove it first."))
		return FALSE
		playsound(src, 'modular/Smoker/sound/inject.ogg')
	inject(M, user)

///Handles all injection checks, injection and logging.
/obj/item/reagent_containers/hypospray/proc/inject(mob/living/M, mob/user)
	if(!reagents.total_volume)
		to_chat(user, span_warning("[src] is empty!"))
		return FALSE
	if(!iscarbon(M))
		return FALSE

	//Always log attemped injects for admins
	var/list/injected = list()
	for(var/datum/reagent/R in reagents.reagent_list)
		injected += R.name
	var/contained = english_list(injected)
	log_combat(user, M, "attempted to inject", src, "([contained])")

	if(reagents.total_volume && (ignore_flags || M.can_inject(user, 1))) // Ignore flag should be checked first or there will be an error message.
		to_chat(M, span_warning("I feel a tiny prick!"))
		to_chat(user, span_notice("I inject [M] with [src]."))
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)
		reagents.reaction(M, INJECT, fraction)

		if(M.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(M, amount_per_transfer_from_this, transfered_by = user)
			else
				trans = reagents.copy_to(M, amount_per_transfer_from_this)
			to_chat(user, span_notice("[trans] unit\s injected. [reagents.total_volume] unit\s remaining in [src]."))
			log_combat(user, M, "injected", src, "([contained])")
		return TRUE
	return FALSE


/obj/item/reagent_containers/hypospray/medipen/sealbottle
	name = "sealed bottle item"
	desc = "If you see this, call an admin."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "THEbottle"

/obj/item/reagent_containers/hypospray/medipen/sealbottle/attack_self(mob/user)
	if(has_cap)
		has_cap = FALSE
		icon_state = "[icon_state]_nocap"  // Update icon state for no cap
		to_chat(user, span_notice("You thumb off the cork from [src]."))
		playsound(src, 'modular/Smoker/sound/corkpop.ogg', 100, TRUE)
	else
		to_chat(user, span_warning("[src] doesn't have a cork."))

/obj/item/reagent_containers/hypospray/medipen/sealbottle/update_icon()
	if(reagents.total_volume > 0)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]0"

/obj/item/reagent_containers/hypospray/medipen/sealbottle/inject(mob/living/M, mob/user)
	if(reagents.total_volume <= 0)
		return FALSE
	if(!M)
		return FALSE
	if(user == M)
		to_chat(user, span_danger("You chug [src]!"))
	else
		to_chat(user, span_danger("You force [M] to swallow [src]."))
	reagents.trans_to(M, reagents.total_volume, transfered_by = user)  // Transfer all remaining reagents
	reagents.maximum_volume = 0  // Makes them useless afterwards
	reagents.flags = NONE  // Ensure reagents are deactivated
	update_icon()
	playsound(src, 'modular/Smoker/sound/chug.ogg', 100, TRUE)
	return TRUE

/obj/item/reagent_containers/hypospray/medipen/sealbottle/attack(mob/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		if(has_cap)
			to_chat(user, span_warning("[src] has a cork still! You need to remove it first."))
			return
		inject(user, user)

/obj/item/reagent_containers/hypospray/medipen/sealbottle/attack(mob/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		if(has_cap)
			to_chat(user, span_warning("[src] has a cork still! You need to remove it first."))
			return
		inject(user, user)

/obj/item/reagent_containers/hypospray/medipen/sty
	name = "sealed sty"
	desc = "If you see this, call an admin."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "sty"

/obj/item/reagent_containers/hypospray/medipen/sty/attack_self(mob/user)
	if(has_cap)
		has_cap = FALSE
		icon_state = "[icon_state]_nocap"  // Update icon state for no cap
		to_chat(user, span_notice("You bite the cap off [src] and spit it out."))
		playsound(src, 'modular/Smoker/sound/capoff.ogg', 100, TRUE)
	else
		to_chat(user, span_warning("[src] doesn't have a cap."))

/obj/item/reagent_containers/hypospray/medipen/sty/update_icon()
	if(reagents.total_volume > 0)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]0"

/obj/item/reagent_containers/hypospray/medipen/sty/inject(mob/living/M, mob/user)
	if(reagents.total_volume <= 0)
		return FALSE
	if(!M)
		return FALSE
	if(user == M)
		to_chat(user, span_danger("You inject yourself with [src]."))
	else
		to_chat(user, span_danger("You inject [M] with [src]!"))
	reagents.trans_to(M, reagents.total_volume, transfered_by = user)  // Transfer all remaining reagents
	reagents.maximum_volume = 0  // Makes them useless afterwards
	reagents.flags = NONE  // Ensure reagents are deactivated
	update_icon()
	playsound(src, 'modular/Smoker/sound/inject.ogg', 100, TRUE)
	return TRUE

/obj/item/reagent_containers/hypospray/medipen/sty/attack(mob/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		if(has_cap)
			to_chat(user, span_warning("[src] has a cap still! You need to remove it first."))
			return
		inject(user, user)

/obj/item/reagent_containers/hypospray/medipen/sty/detox
	name = "DETOX"
	desc = "Purges the body of all that is not natural."
	volume = 34
	amount_per_transfer_from_this = 34
	list_reagents = list(/datum/reagent/medicine/antihol = 10, /datum/reagent/medicine/pen_acid = 24)

/obj/item/reagent_containers/hypospray/medipen/sealbottle/reju
	name = "rejuv elixer"
	desc = "Restores blood, seals wounds, helps to stabalize breathing and lightly numbs pain."
	icon_state = "THEbottle"
	volume = 16
	amount_per_transfer_from_this = 16
	list_reagents = list(/datum/reagent/medicine/stimu = 15, /datum/reagent/medicine/caffeine = 1)

/obj/item/reagent_containers/hypospray/medipen/sealbottle/purify
	name = "purifying elixer"
	desc = "A powerful drug that purifies the blood and seals wounds on the body. Painfully."
	icon_state = "THEbottle"
	volume = 30
	amount_per_transfer_from_this = 30
	list_reagents = list(/datum/reagent/medicine/purify = 20, /datum/reagent/ozium = 5, /datum/reagent/consumable/ethanol/hooch = 5) // lil laudanum for your troubles
