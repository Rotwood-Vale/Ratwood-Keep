
/obj/item/reagent_containers/glass
	name = "glass"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	volume = 50
	reagent_flags = OPENCONTAINER|REFILLABLE
	spillable = TRUE
	possible_item_intents = list(INTENT_GENERIC, /datum/intent/fill, INTENT_POUR, INTENT_SPLASH)
	resistance_flags = ACID_PROOF

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
									reagents.add_reagent(/datum/reagent/consumable/breastmilk, milk_to_take)
									humanized.getorganslot(ORGAN_SLOT_BREASTS).milk_stored -= milk_to_take
									user.visible_message(span_notice("[user] milks [M] using \the [src]."), span_notice("I milk [M] using \the [src]."))
							else
								to_chat(user, span_warning("[src] is full."))
						else
							to_chat(user, span_warning("[M] is out of milk!"))
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
		for(var/i in 1 to 10)
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
		for(var/i in 1 to 10)
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
		reagents.expose_temperature(hotness)
		to_chat(user, span_notice("I heat [name] with [I]!"))

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


/obj/item/reagent_containers/glass/beaker
	name = "beaker"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "beaker"
	item_state = "beaker"
	custom_materials = list(/datum/material/glass=500)
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 80, 90)

/obj/item/reagent_containers/glass/beaker/Initialize()
	. = ..()
	update_icon()

/obj/item/reagent_containers/glass/beaker/get_part_rating()
	return reagents.maximum_volume

/obj/item/reagent_containers/glass/beaker/jar
	name = "honey jar"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "vapour"

/obj/item/reagent_containers/glass/beaker/large
	name = "large beaker"
	desc = ""
	icon_state = "beakerlarge"
	custom_materials = list(/datum/material/glass=2500)
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100)

/obj/item/reagent_containers/glass/beaker/plastic
	name = "x-large beaker"
	desc = ""
	icon_state = "beakerwhite"
	custom_materials = list(/datum/material/glass=2500, /datum/material/plastic=3000)
	volume = 120
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,60,120)

/obj/item/reagent_containers/glass/beaker/plastic/update_icon()
	icon_state = "beakerlarge" // hack to lets us reuse the large beaker reagent fill states
	..()
	icon_state = "beakerwhite"

/obj/item/reagent_containers/glass/beaker/meta
	name = "metamaterial beaker"
	desc = ""
	icon_state = "beakergold"
	custom_materials = list(/datum/material/glass=2500, /datum/material/plastic=3000, /datum/material/gold=1000, /datum/material/titanium=1000)
	volume = 180
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,60,120,180)

/obj/item/reagent_containers/glass/beaker/noreact
	name = "cryostasis beaker"
	desc = "A cryostasis beaker that allows for chemical storage without \
		reactions. Can hold up to 50 units."
	icon_state = "beakernoreact"
	custom_materials = list(/datum/material/iron=3000)
	reagent_flags = OPENCONTAINER | NO_REACT
	volume = 50
	amount_per_transfer_from_this = 10

/obj/item/reagent_containers/glass/beaker/bluespace
	name = "bluespace beaker"
	desc = "A bluespace beaker, powered by experimental bluespace technology \
		and Element Cuban combined with the Compound Pete. Can hold up to \
		300 units."
	icon_state = "beakerbluespace"
	custom_materials = list(/datum/material/glass = 5000, /datum/material/plasma = 3000, /datum/material/diamond = 1000, /datum/material/bluespace = 1000)
	volume = 300
	material_flags = MATERIAL_NO_EFFECTS
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100,300)

/obj/item/reagent_containers/glass/beaker/cryoxadone
	list_reagents = list(/datum/reagent/medicine/cryoxadone = 30)

/obj/item/reagent_containers/glass/beaker/sulphuric
	list_reagents = list(/datum/reagent/toxin/acid = 50)

/obj/item/reagent_containers/glass/beaker/slime
	list_reagents = list(/datum/reagent/toxin/slimejelly = 50)

/obj/item/reagent_containers/glass/beaker/large/libital
	name = "libital reserve tank (diluted)"
	list_reagents = list(/datum/reagent/medicine/C2/libital = 10,/datum/reagent/medicine/granibitaluri = 40)

/obj/item/reagent_containers/glass/beaker/large/aiuri
	name = "aiuri reserve tank (diluted)"
	list_reagents = list(/datum/reagent/medicine/C2/aiuri = 10, /datum/reagent/medicine/granibitaluri = 40)

/obj/item/reagent_containers/glass/beaker/large/multiver
	name = "multiver reserve tank (diluted)"
	list_reagents = list(/datum/reagent/medicine/C2/multiver = 10, /datum/reagent/medicine/granibitaluri = 40)

/obj/item/reagent_containers/glass/beaker/large/epinephrine
	name = "epinephrine reserve tank (diluted)"
	list_reagents = list(/datum/reagent/medicine/epinephrine = 50)

/obj/item/reagent_containers/glass/beaker/instabitaluri
	list_reagents = list(/datum/reagent/medicine/C2/instabitaluri = 50)

/obj/item/reagent_containers/glass/bucket
	name = "bucket"
	desc = ""
	icon = 'icons/obj/janitor.dmi'
	icon_state = "bucket"
	item_state = "bucket"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	custom_materials = list(/datum/material/iron=200)
	w_class = WEIGHT_CLASS_BULKY
	amount_per_transfer_from_this = 9
	possible_transfer_amounts = list(9)
	volume = 70
	flags_inv = HIDEHAIR
//	slot_flags = ITEM_SLOT_HEAD
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
	item_state = "woodbucket"
	icon = 'icons/roguetown/items/misc.dmi'
	custom_materials = null
	force = 5
	throwforce = 10
	amount_per_transfer_from_this = 9
	volume = 99
	armor = list("blunt" = 25, "slash" = 20, "stab" = 15, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	dropshrink = 0.8
	slot_flags = null

/obj/item/reagent_containers/glass/bucket/wooden/attackby(obj/item/I, mob/user, params)
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

	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('icons/roguetown/items/misc.dmi', "woodbucketfilling")

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
		add_overlay(filling)


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

/obj/item/reagent_containers/glass/waterbottle
	name = "bottle of water"
	desc = ""
	icon = 'icons/obj/drinks.dmi'
	icon_state = "smallbottle"
	item_state = "bottle"
	list_reagents = list(/datum/reagent/water = 49.5, /datum/reagent/fluorine = 0.5)//see desc, don't think about it too hard
	custom_materials = list(/datum/material/plastic=1000)
	volume = 50
	amount_per_transfer_from_this = 10
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 80, 90)

	// The 2 bottles have separate cap overlay icons because if the bottle falls over while bottle flipping the cap stays fucked on the moved overlay
	var/cap_icon_state = "bottle_cap_small"
	var/cap_on = TRUE
	var/cap_lost = FALSE
	var/mutable_appearance/cap_overlay
	var/flip_chance = 10

/obj/item/reagent_containers/glass/waterbottle/Initialize()
	. = ..()
	cap_overlay = mutable_appearance(icon, cap_icon_state)
	if(cap_on)
		spillable = FALSE
		add_overlay(cap_overlay, TRUE)

/obj/item/reagent_containers/glass/waterbottle/examine(mob/user)
	. = ..()
	if(cap_lost)
		. += span_notice("The cap seems to be missing.")
	else if(cap_on)
		. += span_notice("The cap is firmly on to prevent spilling. Alt-click to remove the cap.")
	else
		. += span_notice("The cap has been taken off. Alt-click to put a cap on.")

/obj/item/reagent_containers/glass/waterbottle/AltClick(mob/user)
	. = ..()
	if(cap_lost)
		to_chat(user, span_warning("The cap seems to be missing! Where did it go?"))
		return

	var/fumbled = HAS_TRAIT(user, TRAIT_CLUMSY) && prob(5)
	if(cap_on || fumbled)
		cap_on = FALSE
		spillable = TRUE
		cut_overlay(cap_overlay, TRUE)
		animate(src, transform = null, time = 2, loop = 0)
		if(fumbled)
			to_chat(user, span_warning("I fumble with [src]'s cap! The cap falls onto the ground and simply vanishes. Where the hell did it go?"))
			cap_lost = TRUE
		else
			to_chat(user, span_notice("I remove the cap from [src]."))
	else
		cap_on = TRUE
		spillable = FALSE
		add_overlay(cap_overlay, TRUE)
		to_chat(user, span_notice("I put the cap on [src]."))
	update_icon()

/obj/item/reagent_containers/glass/waterbottle/is_refillable()
	if(cap_on)
		return FALSE
	. = ..()

/obj/item/reagent_containers/glass/waterbottle/is_drainable()
	if(cap_on)
		return FALSE
	. = ..()

/obj/item/reagent_containers/glass/waterbottle/attack(mob/M, mob/user, obj/target)
	if(cap_on && reagents.total_volume && istype(M))
		to_chat(user, span_warning("I must remove the cap before you can do that!"))
		return
	. = ..()

/obj/item/reagent_containers/glass/waterbottle/afterattack(obj/target, mob/user, proximity)
	if(cap_on && (target.is_refillable() || target.is_drainable() || (reagents.total_volume && user.used_intent.type == INTENT_HARM)))
		to_chat(user, span_warning("I must remove the cap before you can do that!"))
		return

	else if(istype(target, /obj/item/reagent_containers/glass/waterbottle))
		var/obj/item/reagent_containers/glass/waterbottle/WB = target
		if(WB.cap_on)
			to_chat(user, span_warning("[WB] has a cap firmly twisted on!"))
	. = ..()

// heehoo bottle flipping
/obj/item/reagent_containers/glass/waterbottle/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(cap_on && reagents.total_volume)
		if(prob(flip_chance)) // landed upright
			src.visible_message(span_notice("[src] lands upright!"))
			SEND_SIGNAL(throwingdatum.thrower, COMSIG_ADD_MOOD_EVENT, "bottle_flip", /datum/mood_event/bottle_flip)
		else // landed on it's side
			animate(src, transform = matrix(prob(50)? 90 : -90, MATRIX_ROTATE), time = 3, loop = 0)

/obj/item/reagent_containers/glass/waterbottle/pickup(mob/user)
	. = ..()
	animate(src, transform = null, time = 1, loop = 0)

/obj/item/reagent_containers/glass/waterbottle/empty
	list_reagents = list()
	cap_on = FALSE

/obj/item/reagent_containers/glass/waterbottle/large
	desc = ""
	icon_state = "largebottle"
	custom_materials = list(/datum/material/plastic=3000)
	list_reagents = list(/datum/reagent/water = 100)
	volume = 100
	amount_per_transfer_from_this = 20
	cap_icon_state = "bottle_cap"

/obj/item/reagent_containers/glass/waterbottle/large/empty
	list_reagents = list()
	cap_on = FALSE

// Admin spawn
/obj/item/reagent_containers/glass/waterbottle/relic
	name = "mysterious bottle"
	desc = ""
	flip_chance = 100 // FLIPP

/obj/item/reagent_containers/glass/waterbottle/relic/Initialize()
	var/datum/reagent/random_reagent = get_random_reagent_id()
	list_reagents = list(random_reagent = 50)
	. = ..()
	desc +=  span_notice("The writing reads '[random_reagent.name]'.")

/obj/item/pestle
	name = "pestle"
	desc = "A small, round-end stone tool oft used by physicians to crush and mix medicine."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "pestle"
	dropshrink = 0.65
	force = 7

/obj/item/reagent_containers/glass/mortar
	name = "mortar"
	desc = "A small, thick-walled stone bowl made for grinding things up inside."
	icon_state = "mortar"
	dropshrink = 0.75
	amount_per_transfer_from_this = 9
	volume = 100
	reagent_flags = OPENCONTAINER|REFILLABLE|DRAINABLE
	spillable = TRUE
	var/obj/item/grinded

/obj/item/reagent_containers/glass/mortar/attack_self(mob/user)
	if(grinded)
		grinded.forceMove(drop_location())
		grinded = null
		to_chat(user, span_notice("I eject the item inside."))

/obj/item/reagent_containers/glass/mortar/attackby(obj/item/I, mob/living/carbon/human/user)
	..()
	if(istype(I,/obj/item/pestle))
		if(grinded)
			to_chat(user, span_notice("I start grinding..."))
			if((do_after(user, 25, target = src)) && grinded)
				if(grinded.juice_results) //prioritize juicing
					grinded.on_juice()
					reagents.add_reagent_list(grinded.juice_results)
					to_chat(user, span_notice("I juice [grinded] into a fine liquid."))
					if(grinded.reagents) //food and pills
						grinded.reagents.trans_to(src, grinded.reagents.total_volume, transfered_by = user)
					QDEL_NULL(grinded)
					return
				grinded.on_grind()
				reagents.add_reagent_list(grinded.grind_results)
				to_chat(user, span_notice("I break [grinded] into powder."))
				QDEL_NULL(grinded)
				return
			return
		else
			to_chat(user, span_warning("There is nothing to grind!"))
			return
	if(grinded)
		to_chat(user, span_warning("There is something inside already!"))
		return
	if(istype(I ,/obj/item/reagent_containers/glass))
		if(user.used_intent.type == INTENT_POUR) //Something like a glass. Player probably wants to transfer TO it.
			testing("attackobj2")
			if(!I.reagents.total_volume)
				to_chat(user, span_warning("[I] is empty!"))
				return

			if(reagents.holder_full())
				to_chat(user, span_warning("[src] is full."))
				return
			user.visible_message(span_notice("[user] pours [I] into [src]."), \
							span_notice("I pour [I] into [src]."))
			if(user.m_intent != MOVE_INTENT_SNEAK)
				if(poursounds)
					playsound(user.loc,pick(poursounds), 100, TRUE)
			for(var/i in 1 to 10)
				if(do_after(user, 8, target = src))
					if(!I.reagents.total_volume)
						break
					if(reagents.holder_full())
						break
					if(!I.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user))
						reagents.reaction(src, TOUCH, amount_per_transfer_from_this)
				else
					break
			return

		if(is_drainable() && (user.used_intent.type == /datum/intent/fill)) //A dispenser. Transfer FROM it TO us.
			testing("attackobj3")
			if(!reagents.total_volume)
				to_chat(user, span_warning("[src] is empty!"))
				return

			if(I.reagents.holder_full())
				to_chat(user, span_warning("[I] is full."))
				return
			if(user.m_intent != MOVE_INTENT_SNEAK)
				if(fillsounds)
					playsound(user.loc,pick(fillsounds), 100, TRUE)
			user.visible_message(span_notice("[user] fills [I] with [src]."), \
								span_notice("I fill [I] with [src]."))
			for(var/i in 1 to 10)
				if(do_after(user, 8, target = src))
					if(I.reagents.holder_full())
						break
					if(!reagents.total_volume)
						break
					reagents.trans_to(I, amount_per_transfer_from_this, transfered_by = user)
				else
					break

			return
	if(I.juice_results || I.grind_results)
		I.forceMove(src)
		grinded = I
		return
	to_chat(user, span_warning("I can't grind this!"))

/obj/item/reagent_containers/glass/saline
	name = "saline canister"
	volume = 5000
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 5000)

/obj/item/reagent_containers/glass/colocup
	name = "colo cup"
	desc = ""
	icon = 'icons/obj/drinks.dmi'
	icon_state = "colocup"
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	item_state = "colocup"
	custom_materials = list(/datum/material/plastic = 1000)
	possible_transfer_amounts = list(5, 10, 15, 20)
	volume = 20
	amount_per_transfer_from_this = 5

/obj/item/reagent_containers/glass/colocup/Initialize()
	.=..()
	icon_state = "colocup[rand(0, 6)]"
	pixel_x = rand(-4,4)
	pixel_y = rand(-4,4)
