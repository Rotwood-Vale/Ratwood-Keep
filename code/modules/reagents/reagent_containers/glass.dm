

/obj/item/reagent_containers/glass
	name = "glass"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	volume = 50
	reagent_flags = OPENCONTAINER|REFILLABLE
	obj_flags = CAN_BE_HIT
	spillable = TRUE
	possible_item_intents = list(/datum/intent/fill, INTENT_SPLASH, INTENT_POUR, INTENT_GENERIC)
	resistance_flags = ACID_PROOF
	w_class = WEIGHT_CLASS_SMALL

/datum/intent/fill
	name = "fill"
	icon_state = "infill"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0

/datum/intent/pour
	name = "feed"
	icon_state = "infeed"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0

/datum/intent/splash
	name = "splash"
	icon_state = "insplash"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0

/obj/item/reagent_containers/glass/attack(mob/M, mob/user, obj/target)
	testing("a1")
	if(istype(M))
		if(user.used_intent.type == INTENT_GENERIC)
			return ..()
		if(user.used_intent.type == /datum/intent/fill)
			if(ishuman(M))
				var/mob/living/carbon/human/humanized = M
				if(get_location_accessible(humanized, BODY_ZONE_CHEST))
					if(humanized.has_breasts() && humanized.getorganslot(ORGAN_SLOT_BREASTS).lactating)
						if(humanized.getorganslot(ORGAN_SLOT_BREASTS).milk_stored > 0)
							if(reagents.total_volume < volume)
								var/milk_to_take = min(humanized.getorganslot(ORGAN_SLOT_BREASTS).milk_stored, max(humanized.getorganslot(ORGAN_SLOT_BREASTS).breast_size, 1), volume - reagents.total_volume)
								if(do_after(user, 20, target = M))
									reagents.add_reagent(/datum/reagent/consumable/milk, milk_to_take)
									humanized.getorganslot(ORGAN_SLOT_BREASTS).milk_stored -= milk_to_take
									user.visible_message(span_notice("[user] milks [M] using \the [src]."), span_notice("I milk [M] using \the [src]."))
							else
								to_chat(user, span_warning("[src] is full."))
						else
							var/obj/item/organ/vagina/vagina = M.getorganslot(ORGAN_SLOT_VAGINA)
							if(vagina && vagina.pregnant)
								to_chat(user, span_warning("[M] is out of milk!"))
							else
								to_chat(user, span_warning("[M] Does not seem to be producing milk."))
					else
						to_chat(user, span_warning("[M] cannot be milked!"))
				else
					to_chat(user, span_warning("[M]'s chest must be exposed before I can milk them!"))
				return 1
		if(!spillable)
			return


		if(!reagents || !reagents.total_volume)
			to_chat(user, span_warning("[src] is empty!"))
			return
		if(user.used_intent.type == INTENT_SPLASH)
			var/R
			M.visible_message(span_danger("[user] splashes the contents of [src] onto [M]!"), \
							span_danger("[user] splashes the contents of [src] onto you!"))
			if(reagents)
				for(var/datum/reagent/A in reagents.reagent_list)
					R += "[A] ([num2text(A.volume)]),"

			if(isturf(target) && reagents.reagent_list.len && thrownby)
				log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]")
				message_admins("[ADMIN_LOOKUPFLW(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] at [ADMIN_VERBOSEJMP(target)].")
			reagents.reaction(M, TOUCH)
			log_combat(user, M, "splashed", R)
			reagents.clear_reagents()
			return
		else if(user.used_intent.type == INTENT_POUR)
			if(!canconsume(M, user))
				return
			if(M != user)
				M.visible_message(span_danger("[user] attempts to feed [M] something."), \
							span_danger("[user] attempts to feed you something."))
				if(!do_mob(user, M))
					return
				if(!reagents || !reagents.total_volume)
					return // The drink might be empty after the delay, such as by spam-feeding
				M.visible_message(span_danger("[user] feeds [M] something."), \
							span_danger("[user] feeds you something."))
				log_combat(user, M, "fed", reagents.log_list())
			else
				to_chat(user, span_notice("I swallow a gulp of [src]."))
			addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, trans_to), M, min(amount_per_transfer_from_this,5), TRUE, TRUE, FALSE, user, FALSE, INGEST), 5)
			playsound(M.loc,pick(drinksounds), 100, TRUE)
			return
/obj/item/reagent_containers/glass/attack_obj(obj/target, mob/living/user)
	if(user.used_intent.type == INTENT_GENERIC)
		return ..()

	testing("attackobj1")

	if(!spillable)
		return


	if(target.is_refillable() && (user.used_intent.type == INTENT_POUR)) //Something like a glass. Player probably wants to transfer TO it.
		testing("attackobj2")
		if(!reagents.total_volume)
			to_chat(user, span_warning("[src] is empty!"))
			return

		if(target.reagents.holder_full())
			to_chat(user, span_warning("[target] is full."))
			return
		user.visible_message(span_notice("[user] pours [src] into [target]."), \
						span_notice("I pour [src] into [target]."))
		if(user.m_intent != MOVE_INTENT_SNEAK)
			if(poursounds)
				playsound(user.loc,pick(poursounds), 100, TRUE)
		for(var/i in 1 to 22)
			if(do_after(user, 8, target = target))
				if(!reagents.total_volume)
					break
				if(target.reagents.holder_full())
					break
				if(!reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user))
					reagents.reaction(target, TOUCH, amount_per_transfer_from_this)
			else
				break
		return

	if(target.is_drainable() && (user.used_intent.type == /datum/intent/fill)) //A dispenser. Transfer FROM it TO us.
		testing("attackobj3")
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target] is empty!"))
			return

		if(reagents.holder_full())
			to_chat(user, span_warning("[src] is full."))
			return
		if(user.m_intent != MOVE_INTENT_SNEAK)
			if(fillsounds)
				playsound(user.loc,pick(fillsounds), 100, TRUE)
		user.visible_message(span_notice("[user] fills [src] with [target]."), \
							span_notice("I fill [src] with [target]."))
		for(var/i in 1 to 22)
			if(do_after(user, 8, target = target))
				if(reagents.holder_full())
					break
				if(!target.reagents.total_volume)
					break
				target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user)
			else
				break


		return

	if(reagents.total_volume && user.used_intent.type == INTENT_SPLASH)
		user.visible_message(span_danger("[user] splashes the contents of [src] onto [target]!"), \
							span_notice("I splash the contents of [src] onto [target]."))
		reagents.reaction(target, TOUCH)
		reagents.clear_reagents()
		return

/obj/item/reagent_containers/glass/afterattack(obj/target, mob/user, proximity)
	if(user.used_intent.type == INTENT_GENERIC)
		return ..()

	if((!proximity) || !check_allowed_items(target,target_self=1))
		return ..()

	if(!spillable)
		return

	if(isturf(target))
		if(reagents.total_volume && user.used_intent.type == INTENT_SPLASH)
			user.visible_message(span_danger("[user] splashes the contents of [src] onto [target]!"), \
								span_notice("I splash the contents of [src] onto [target]."))
			reagents.reaction(target, TOUCH)
			reagents.clear_reagents()
			return

/obj/item/reagent_containers/glass/attackby(obj/item/I, mob/user, params)
	var/hotness = I.get_temperature()
	if(hotness && reagents)
		src.reagents.expose_temperature(hotness)
		to_chat(user, span_notice("I heat [src] with [I]!"))

	if(istype(I, /obj/item/reagent_containers/food/snacks/egg)) //breaking eggs
		var/obj/item/reagent_containers/food/snacks/egg/E = I
		if(reagents)
			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, span_notice("[src] is full."))
			else
				to_chat(user, span_notice("I break [E] in [src]."))
				E.reagents.trans_to(src, E.reagents.total_volume, transfered_by = user)
				qdel(E)
			return
	..()

/obj/item/reagent_containers/glass/bucket/equipped(mob/user, slot)
	..()
	if (slot == SLOT_HEAD)
		if(reagents.total_volume)
			to_chat(user, span_danger("[src]'s contents spill all over you!"))
			reagents.reaction(user, TOUCH)
			reagents.clear_reagents()
		reagents.flags = NONE

/obj/item/reagent_containers/glass/bucket/dropped(mob/user)
	. = ..()
	reagents.flags = initial(reagent_flags)

/obj/item/reagent_containers/glass/bucket/equip_to_best_slot(mob/M)
	if(reagents.total_volume) //If there is water in a bucket, don't quick equip it to the head
		var/index = slot_equipment_priority.Find(SLOT_HEAD)
		slot_equipment_priority.Remove(SLOT_HEAD)
		. = ..()
		slot_equipment_priority.Insert(index, SLOT_HEAD)
		return
	return ..()

/obj/item/reagent_containers/glass/bucket
	name = "bucket"
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	icon_state = "woodbucket"
	item_state = "woodbucket"
	max_integrity = 300
	w_class = WEIGHT_CLASS_BULKY
	amount_per_transfer_from_this = 9
	possible_transfer_amounts = list(9)
	volume = 198
	flags_inv = HIDEHAIR
	reagent_flags = OPENCONTAINER
	obj_flags = CAN_BE_HIT
	gripped_intents = list(INTENT_POUR)
	resistance_flags = NONE
	armor = list("blunt" = 25, "slash" = 20, "stab" = 15, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 50) //Weak melee protection, because you can wear it on your head
	slot_equipment_priority = list( \
		SLOT_BACK, SLOT_RING,\
		SLOT_PANTS, SLOT_ARMOR,\
		SLOT_WEAR_MASK, SLOT_HEAD, SLOT_NECK,\
		SLOT_SHOES, SLOT_GLOVES,\
		SLOT_HEAD, SLOT_GLASSES,\
		SLOT_BELT, SLOT_S_STORE,\
		SLOT_L_STORE, SLOT_R_STORE,\
		SLOT_GENERC_DEXTROUS_STORAGE
	)

/obj/item/reagent_containers/glass/bucket/wooden
	name = "bucket"
	icon_state = "woodbucket"
	icon = 'icons/roguetown/items/misc.dmi'
	possible_item_intents = list(/datum/intent/fill, INTENT_POUR, INTENT_SPLASH, INTENT_GENERIC)
	force = 5
	throwforce = 10
	amount_per_transfer_from_this = 9
	volume = 300 //100 oz
	armor = list("blunt" = 25, "slash" = 20, "stab" = 15, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	dropshrink = 0.8
	slot_flags = null

/obj/item/reagent_containers/glass/bucket/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/natural/cloth))
		var/obj/item/natural/cloth/T = I
		if(T.wet && !T.return_blood_DNA())
			return
		var/removereg = /datum/reagent/water
		if(!reagents.has_reagent(/datum/reagent/water, 5))
			removereg = /datum/reagent/water/gross
			if(!reagents.has_reagent(/datum/reagent/water/gross, 5))
				to_chat(user, span_warning("No water to soak in."))
				return
		wash_atom(T)
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
		reagents.remove_reagent(removereg, 5)
		user.visible_message(span_info("[user] soaks [T] in [src]."))
		return
	..()

/obj/item/reagent_containers/glass/bucket/wooden/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -5,"sy" = -8,"nx" = 7,"ny" = -9,"wx" = -1,"wy" = -8,"ex" = -1,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)

/obj/item/reagent_containers/glass/bucket/wooden/update_icon(dont_fill=FALSE)
	if(dont_fill)
		testing("dontfull")
		return ..()

	cut_overlays()

	if(reagents.total_volume > 0)
		if(reagents.total_volume <= 200)
			var/mutable_appearance/filling = mutable_appearance('icons/roguetown/items/misc.dmi', "bucket_half")
			filling.color = mix_color_from_reagents(reagents.reagent_list)
			filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
			add_overlay(filling)

		if(reagents.total_volume > 200)
			var/mutable_appearance/filling = mutable_appearance('icons/roguetown/items/misc.dmi', "bucket_full")
			filling.color = mix_color_from_reagents(reagents.reagent_list)
			filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
			add_overlay(filling)

/obj/item/pestle
	name = "pestle"
	desc = "A small, round-end stone tool oft used by physicians to crush and mix medicine."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "pestle"
	dropshrink = 0.65
	force = 7
	w_class = WEIGHT_CLASS_SMALL


/obj/item/reagent_containers/glass/alembic  //this shit doesnt even use rogue bottles what the fuuuuuck
	name = "metal alembic"
	possible_item_intents = list(INTENT_POUR, INTENT_SPLASH, /datum/intent/fill) //It's janky and annoying to need to fill the alembic this way, but also Moricode is stupid and I'll refactor it later.
	desc = "so you're an alchemist then?"
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "alembic_empty"
	volume = 120
	reagent_flags = OPENCONTAINER|REFILLABLE|DRAINABLE|AMOUNT_VISIBLE
	var/speed_multiplier = 1 // How fast it brews. Defaults to 100% (1.0). Lower is better.
	var/list/active_brews = list()
	var/brewing_started = FALSE // Track if brewing has started
	var/datum/looping_sound/boilloop/boilloop

/obj/item
	var/can_brew = FALSE // If FALSE, this object cannot be brewed
	var/brew_reagent // If NULL and this object can be brewed, it uses a generic fruit_wine reagent and adjusts its variables
	var/brew_amt = 24
	var/brewing_time
	var/start_time
	var/mill_result = null

/obj/item/reagent_containers/glass/alembic/Initialize()
	create_reagents(100, REFILLABLE | DRAINABLE | AMOUNT_VISIBLE) // 2 Bottles capacity
	icon_state = "alembic_empty"
	boilloop = new(src, FALSE)
	. = ..()

/obj/item/reagent_containers/glass/alembic/examine(mob/user)
	. = ..()
	if (active_brews.len == 0)
		. += span_notice("The alembic is not brewing.")
	else
		. += span_notice("The alembic is brewing.")
		for (var/obj/item/I in active_brews)
			var/time_left = (I.brewing_time - (world.time - I.start_time)) / 10
			. += span_notice("[I]: [time_left] seconds left until completion.")

/obj/item/reagent_containers/glass/alembic/proc/makebrew(obj/item/I)
	if(I.reagents)
		I.reagents.remove_all_type(/datum/reagent, I.reagents.total_volume)
		I.reagents.trans_to(src, I.reagents.total_volume)
	if(I.brew_reagent)
		reagents.add_reagent(I.brew_reagent, I.brew_amt)
	qdel(I)
	active_brews -= I
	if(active_brews.len >= 2)
		icon_state = "alembic_full"
	else
		icon_state = "alembic_empty"
	playsound(src, "bubbles", 60, TRUE)
	boilloop.stop() // Stop the looping sound once brewing is done
	brewing_started = FALSE // Reset brewing status after brewing completes

/obj/item/reagent_containers/glass/alembic/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item))
		if(user.mind.get_skill_level(/datum/skill/misc/treatment) <= 2)
			to_chat(user, span_warning("I don't know how this works."))
			return TRUE
		if(!I.can_brew)
			to_chat(user, span_warning("I can't brew this into anything."))
			return TRUE
		else if(active_brews.len >= 2 || reagents.total_volume >= 99)
			to_chat(user, span_warning("I can only brew two items at a time or it is too full."))
			return TRUE
		else if(!user.transferItemToLoc(I, src))
			to_chat(user, span_warning("[I] is stuck to my hand!"))
			return TRUE
		to_chat(user, span_info("I place [I] into [src]."))
		I.start_time = world.time
		I.brewing_time = 600
		active_brews += I
		icon_state = "alembic_brew"
		boilloop.start()
		addtimer(CALLBACK(src, /obj/item/reagent_containers/glass/alembic/proc/makebrew, I), I.brewing_time)
		return TRUE
	return ..()

/obj/item/reagent_containers/glass/alembic/attack_self(mob/user)
	if(brewing_started)
		to_chat(user, span_warning("Brewing has started, you cannot remove items now."))
		return TRUE
	for(var/obj/item/I in active_brews)
		I.forceMove(drop_location())
	active_brews.Cut()
	icon_state = "alembic_empty"
	to_chat(user, span_notice("I remove the items inside."))



/obj/item/reagent_containers/glass/mortar
	name = "mortar"
	desc = "A small, thick-walled stone bowl made for grinding things up inside."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "mortar_empty"
	volume = 100
	reagent_flags = OPENCONTAINER|REFILLABLE|DRAINABLE
	spillable = FALSE
	var/obj/item/grinded
	var/grinding_started = FALSE

/obj/item/reagent_containers/glass/mortar/attack_self(mob/user)
	if(grinding_started)
		to_chat(user, "Grinding has started, you cannot remove items now.")
		return TRUE
	if(grinded)
		grinded.forceMove(drop_location())
		grinded = null
		icon_state = "mortar_empty"
		to_chat(user, "I eject the item inside.")

/obj/item/reagent_containers/glass/mortar/MiddleClick(mob/user, params)
	if(grinded)
		grinding_started = TRUE // Mark grinding as started
		to_chat(user, "I start grinding...")
		if((do_after(user, 25, target = src)) && grinded)
			if(grinded.mill_result && !istype(user.rmb_intent, /datum/rmb_intent/strong)) // This goes first. Strong intent to bypass.
				new grinded.mill_result(get_turf(src))
				QDEL_NULL(grinded)
				icon_state = reagents.total_volume > 0 ? "mortar_full" : "mortar_empty"
				grinding_started = FALSE // Reset grinding status
				return
			if(grinded.juice_results)
				grinded.on_juice()
				reagents.add_reagent_list(grinded.juice_results)
				to_chat(user, "I juice [grinded] into a fine liquid.")
			if(grinded.grind_results && !isemptylist(grinded.grind_results))
				grinded.on_grind()
				reagents.add_reagent_list(grinded.grind_results)
				to_chat(user, "I break [grinded] into powder.")
				QDEL_NULL(grinded)
				icon_state = reagents.total_volume > 0 ? "mortar_full" : "mortar_empty"
				grinding_started = FALSE // Reset grinding status
				return
			if(grinded.reagents) // Other stuff that might have reagents in them, let's not cause a runtime shall we?
				grinded.reagents.trans_to(src, grinded.reagents.total_volume, transfered_by = user)
				icon_state = reagents.total_volume > 0 ? "mortar_full" : "mortar_empty"
				to_chat(user, "I pound [grinded] into mush.")
				QDEL_NULL(grinded)
				grinding_started = FALSE // Reset grinding status
				return
			grinding_started = FALSE // Reset grinding status
			return
		else
			to_chat(user, "There is nothing to grind!")
			return

/obj/item/reagent_containers/glass/mortar/attackby(obj/item/I, mob/living/carbon/human/user)
	if(grinded)
		to_chat(user, "There is something inside already!")
		return TRUE
	if(istype(I, /obj/item/reagent_containers/glass))
		if(user.used_intent.type == INTENT_POUR)
			if(!I.reagents.total_volume)
				to_chat(user, "[I] is empty!")
				return TRUE
			if(reagents.holder_full())
				to_chat(user, "[src] is full.")
				return TRUE
			user.visible_message(span_notice("Starting the transfer"), span_notice("Completing the transfer"))
			if(user.m_intent != MOVE_INTENT_SNEAK)
				if(poursounds)
					playsound(user.loc, pick(poursounds), 100, TRUE)
			for(var/i in 1 to 10)
				if(do_after(user, 8, target = src))
					if(!I.reagents.total_volume) break
					if(reagents.holder_full()) break
					if(!I.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user))
						reagents.reaction(src, TOUCH, amount_per_transfer_from_this)
					else break
			return
		if(is_drainable() && (user.used_intent.type == /datum/intent/fill))
			if(!reagents.total_volume)
				to_chat(user, "[src] is empty!")
				return
			if(I.reagents.holder_full())
				to_chat(user, "[I] is full.")
				return
			if(user.m_intent != MOVE_INTENT_SNEAK)
				if(fillsounds)
					playsound(user.loc, pick(fillsounds), 100, TRUE)
			user.visible_message(span_notice("Starting the transfer"), span_notice("Completing the transfer"))
			for(var/i in 1 to 10)
				if(do_after(user, 8, target = src))
					if(I.reagents.holder_full()) break
					if(!reagents.total_volume) break
					reagents.trans_to(I, amount_per_transfer_from_this, transfered_by = user)
				else break
			return
	if(I.juice_results || I.grind_results || I.mill_result)
		I.forceMove(src)
		grinded = I
		icon_state = "mortar_grind"
		return
	to_chat(user, "I can't grind this!")
