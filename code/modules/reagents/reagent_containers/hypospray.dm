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
