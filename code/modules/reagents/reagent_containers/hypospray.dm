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
	inject(M, user)
	..()

/obj/item/reagent_containers/hypospray/medipen/sealbottle/inject(mob/living/M, mob/user)
	return ..(M, user, src, drinking = TRUE)  // Call parent, but mark as drinking

/obj/item/reagent_containers/hypospray/medipen/sty/inject(mob/living/M, mob/user)
	return ..(M, user, src)  // Call parent with normal injection behavior

/obj/item/reagent_containers/hypospray/proc/inject(mob/living/M, mob/user, obj/item/reagent_containers/hypospray/this, drinking = FALSE)
	if(!this.reagents.total_volume)
		to_chat(user, span_warning("[this] is empty!"))
		return FALSE
	if(!iscarbon(M))
		to_chat(user, span_warning("You can't use that on this!"))
		return FALSE
	if(!M)
		return FALSE
	var/list/injected = list()
	for(var/datum/reagent/R in this.reagents.reagent_list)
		injected += R.name
	var/contained = english_list(injected)

	log_combat(user, M, "attempted to [drinking ? "force-feed" : "inject"]", this, "([contained])")
	log_admin(user, M, "attempted to [drinking ? "force-feed" : "inject"]", this, "([contained])")

	if(!do_after(user, 2 SECONDS, M))  // Can be interrupted if user moves, gets stunned, etc.
		to_chat(user, span_warning("Your [drinking ? "feeding" : "injection"] attempt was interrupted!"))
		return FALSE

	if(this.reagents.total_volume && (this.ignore_flags || !M.stat || M.can_inject(user, 1)))
		to_chat(M, span_warning("I feel a [drinking ? "bit of liquid forced into my mouth" : "tiny prick"]!"))
		to_chat(user, span_notice("You [drinking ? "force [M] to drink" : "inject[M] with"]  [this]."))

		var/fraction = min(this.amount_per_transfer_from_this / this.reagents.total_volume, 1)
		this.reagents.reaction(M, INJECT, fraction)

		if(M.reagents)
			var/trans = 0
			if(!this.infinite)
				trans = this.reagents.trans_to(M, this.amount_per_transfer_from_this, transfered_by = user)
			else
				trans = this.reagents.copy_to(M, this.amount_per_transfer_from_this)

			to_chat(user, span_notice("[trans] unit\s [drinking ? "swallowed" : "injected"]. [this.reagents.total_volume] unit\s remaining in [this]."))

			log_combat(user, M, "[drinking ? "force-fed" : "successfully injected"]", this, "([contained])")
			log_admin(user, M, "[drinking ? "force-fed" : "successfully injected"]", this, "([contained])")

		// **Play correct sound**
		var/sound = drinking ? 'modular/Smoker/sound/chug.ogg' : 'modular/Smoker/sound/inject.ogg'
		playsound(src, sound, 100, TRUE)

		return TRUE
	return FALSE

/obj/item/reagent_containers/hypospray/medipen/attack_self(mob/user)
	if(!has_cap)
		to_chat(user, span_warning("[src] doesn't have a [istype(src, /obj/item/reagent_containers/hypospray/medipen/sealbottle) ? "cork" : "cap"]."))
		return

	has_cap = FALSE
	icon_state = "[icon_state]_nocap"  // Update icon state for no cap

	if(istype(src, /obj/item/reagent_containers/hypospray/medipen/sealbottle))
		to_chat(user, span_notice("You thumb off the cork from [src]."))
		playsound(src, 'modular/Smoker/sound/corkpop.ogg', 100, TRUE)
	else
		to_chat(user, span_notice("You bite the cap off [src] and spit it out."))
		playsound(src, 'modular/Smoker/sound/capoff.ogg', 100, TRUE)

/obj/item/reagent_containers/hypospray/medipen/update_icon()
	if(reagents.total_volume > 0)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]0"


/obj/item/reagent_containers/hypospray/medipen/sealbottle
	name = "sealed bottle item"
	desc = "If you see this, call an admin."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "THEbottle"

/obj/item/reagent_containers/hypospray/medipen/sty
	name = "sealed sty"
	desc = "If you see this, call an admin."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "sty"

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
