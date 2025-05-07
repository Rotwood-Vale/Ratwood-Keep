/obj/item/grown/log/tree
	icon = 'icons/roguetown/items/natural.dmi'
	name = "log"
	desc = "A big tree log. It's very heavy and cumbersome, best cut into pieces for more uses."
	icon_state = "log"
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
//	attacked_sound = 'sound/misc/woodhit.ogg'
	blade_dulling = DULLING_CUT
	max_integrity = 30
	static_debris = list(/obj/item/grown/log/tree/small = 2)
	obj_flags = CAN_BE_HIT
	resistance_flags = FLAMMABLE
	twohands_required = TRUE
	gripped_intents = list(/datum/intent/hit)
	possible_item_intents = list(/datum/intent/hit)
	w_class = WEIGHT_CLASS_HUGE
	var/lumber = /obj/item/grown/log/tree/small //These are solely for lumberjack calculations
	var/lumber_amount = 2
	metalizer_result = /obj/item/rogueore/iron

/obj/item/grown/log/tree/attacked_by(obj/item/I, mob/living/user) //This serves to reward woodcutting
	user.changeNext_move(CLICK_CD_MELEE)
	var/skill_level = user.mind.get_skill_level(/datum/skill/labor/lumberjacking)
	var/planking_time = (40 - (skill_level * 5))
	if(lumber_amount && I.tool_behaviour == TOOL_SAW || I.tool_behaviour == TOOL_IMPROVSAW)
		playsound(get_turf(src.loc), 'sound/foley/sawing.ogg', 100)
		user.visible_message("<span class='notice'>[user] starts sawing [src] to smaller pieces.</span>")
		if(do_after(user, planking_time))
			new /obj/item/grown/log/tree/small(get_turf(src.loc))
			new /obj/item/grown/log/tree/small(get_turf(src.loc))
			if(prob(skill_level + user.goodluck(2)))	// when sawing instead of essence you get extra small log
				new /obj/item/grown/log/tree/small(get_turf(src.loc))
			if(user.is_holding(src))
				user.dropItemToGround(src)
			user.mind.add_sleep_experience(/datum/skill/labor/lumberjacking, (user.STAINT*0.5))
			new /obj/effect/decal/cleanable/debris/woody(get_turf(src))
			qdel(src)
			return
	if(user.used_intent.blade_class == BCLASS_CHOP && lumber_amount)
		var/lumber_time = (40 - (skill_level * 5))
		var/minimum = 2
		playsound(src, 'sound/misc/woodhit.ogg', 100, TRUE)
		if(!do_after(user, lumber_time, target = user))
			return
		lumber_amount = rand(minimum, max(round(skill_level), minimum))
		var/essence_sound_played = FALSE //This is here so the sound wont play multiple times if the essence itself spawns multiple times
		for(var/i = 0; i < lumber_amount; i++)
			if(prob(skill_level + user.goodluck(2)))
				new /obj/item/grown/log/tree/small/essence(get_turf(src))
				if(!essence_sound_played)
					essence_sound_played = TRUE
					to_chat(user, span_warning("Dendor watches over us..."))
					playsound(src,pick('sound/items/gem.ogg'), 100, FALSE)
			else
				new lumber(get_turf(src))
		if(!skill_level)
			to_chat(user, span_info("I could have gotten more timber were I more skilled..."))
		user.mind.add_sleep_experience(/datum/skill/labor/lumberjacking, (user.STAINT*0.5))
		playsound(src, destroy_sound, 100, TRUE)
		qdel(src)
		return TRUE
	..()

//................	Small log	............... //
/obj/item/grown/log/tree/small
	name = "small log"
	desc = "Piece of lumber cut from a larger log. Suitable for building."
	icon_state = "logsmall"
	max_integrity = 30
	static_debris = list(/obj/item/grown/log/tree/stick = 3)
	firefuel = 20 MINUTES
	twohands_required = FALSE
	gripped_intents = null
	w_class = WEIGHT_CLASS_BULKY
	smeltresult = /obj/item/rogueore/coal
	lumber_amount = 0
	metalizer_result = /obj/item/rogueore/copper


/obj/item/grown/log/tree/small/attackby(obj/item/I, mob/living/user, params)
	if(item_flags & IN_STORAGE)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	var/skill_level = user.mind.get_skill_level(/datum/skill/craft/carpentry)
	var/planking_time = (45 - (skill_level * 5))
	if(I.tool_behaviour == TOOL_SAW || I.tool_behaviour == TOOL_IMPROVSAW)
		playsound(get_turf(src.loc), 'sound/foley/sawing.ogg', 100)
		user.visible_message("<span class='notice'>[user] starts sawing planks from [src].</span>")
		if(do_after(user, planking_time))
			var/obj/item/natural/wood/plank/S = new /obj/item/natural/wood/plank(get_turf(src.loc))
			if(user.is_holding(src))
				user.dropItemToGround(src)
				user.put_in_hands(S)
			user.mind.add_sleep_experience(/datum/skill/craft/carpentry, (user.STAINT*0.5))
			new /obj/effect/decal/cleanable/debris/woody(get_turf(src))
			qdel(src)
			return
	..()


//................	Lumber essence	............... //
/obj/item/grown/log/tree/small/essence
	name = "essence of lumber"
	desc = "A mystical essence embued with the power of Dendor. Very good source of fuel."
	icon_state = "lessence"
	static_debris = null
	firefuel = 60 MINUTES // Extremely poweful fuel.
	w_class = WEIGHT_CLASS_SMALL
	metalizer_result = /obj/item/rogueore/gold

//................	Unstrung bow	............... //
/obj/item/grown/log/tree/bowpartial
	name = "unstrung bow"
	desc = "A partially completed bow, still waiting to be strung."
	icon_state = "bowpartial"
	max_integrity = 30
	firefuel = 10 MINUTES
	twohands_required = FALSE
	gripped_intents = null
	w_class = WEIGHT_CLASS_BULKY
	smeltresult = /obj/item/rogueore/coal
	lumber_amount = 0
	metalizer_result = null

//................	Stick	............... //
/obj/item/grown/log/tree/stick
	name = "stick"
	icon_state = "stick1"
	item_state = "stick"
	desc = "A tree branch perhaps."
	blade_dulling = 0
	max_integrity = 20
	static_debris = null
	firefuel = 5 MINUTES
	w_class = WEIGHT_CLASS_NORMAL
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	lumber_amount = 0
	metalizer_result = /obj/item/needle

/obj/item/grown/log/tree/stick/Crossed(mob/living/L)
	. = ..()
	if(istype(L))
		var/prob2break = 33
		if(L.m_intent == MOVE_INTENT_SNEAK)
			prob2break = 0
		if(L.m_intent == MOVE_INTENT_RUN)
			prob2break = 100
		if(prob(prob2break))
			playsound(src,'sound/items/seedextract.ogg', 100, FALSE)
			qdel(src)
			if (L.alpha == 0 && L.rogue_sneaking) // not anymore you're not
				L.update_sneak_invis(TRUE)
			L.consider_ambush()

/obj/item/grown/log/tree/stick/Initialize()
	icon_state = "stick[rand(1,2)]"
	. = ..()

/obj/item/grown/log/tree/stick/attack_self(mob/living/user)
	user.visible_message(span_warning("[user] snaps [src]."))
	playsound(user,'sound/items/seedextract.ogg', 100, FALSE)
	qdel(src)

/obj/item/grown/log/tree/stick/attack_right(mob/living/user)
	. = ..()
	if(user.get_active_held_item())
		return
	to_chat(user, span_warning("I start to collect [src]..."))
	if(move_after(user, 4 SECONDS, target = src))
		var/stackcount = 0
		for(var/obj/item/grown/log/tree/stick/F in get_turf(src))
			stackcount++
		while(stackcount > 0)
			if(stackcount == 1)
				var/obj/item/grown/log/tree/stick/S = new(get_turf(user))
				user.put_in_hands(S)
				stackcount--
			else if(stackcount >= 2)
				var/obj/item/natural/bundle/stick/B = new(get_turf(user))
				B.amount = clamp(stackcount, 2, 6)
				B.update_bundle()
				stackcount -= clamp(stackcount, 2, 6)
				user.put_in_hands(B)
		for(var/obj/item/grown/log/tree/stick/F in get_turf(src))
			playsound(get_turf(user.loc), 'sound/foley/dropsound/wooden_drop.ogg', 100)
			qdel(F)

/obj/item/grown/log/tree/stick/attackby(obj/item/I, mob/living/user, params)
	var/mob/living/carbon/human/H = user
	user.changeNext_move(CLICK_CD_MELEE)
	if(user.used_intent?.blade_class == BCLASS_CUT)
		playsound(get_turf(src.loc), 'sound/items/wood_sharpen.ogg', 100)
		user.visible_message(span_notice("[user] starts sharpening [src]."))
		if(do_after(user, 4 SECONDS))
			var/obj/item/grown/log/tree/stake/S = new /obj/item/grown/log/tree/stake(get_turf(src.loc))
			if(user.is_holding(src))
				user.dropItemToGround(src)
				user.put_in_hands(S)
			qdel(src)
		return
	if(istype(I, /obj/item/grown/log/tree/stick))
		var/obj/item/natural/bundle/stick/F = new(src.loc)
		qdel(I)
		H.put_in_hands(F)
		H.visible_message("[user] ties the sticks into a bundle.")
		qdel(src)
	if(istype(I, /obj/item/natural/bundle/stick))
		var/obj/item/natural/bundle/stick/B = I
		if(B.amount < B.maxamount)
			H.visible_message("[user] adds the [src] to the bundle.")
			B.amount += 1
			B.update_bundle()
			qdel(src)
	..()

//................	Stake	............... //
/obj/item/grown/log/tree/stake
	name = "stake"
	icon_state = "stake"
	desc = "A sharpened piece of wood, fantastic for piercing"
	force = 10
	throwforce = 5
	possible_item_intents = list(/datum/intent/stab, /datum/intent/pick)
	firefuel = 1 MINUTES
	blade_dulling = 0
	max_integrity = 20
	static_debris = null
	w_class = WEIGHT_CLASS_SMALL
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	lumber_amount = 0
	metalizer_result = /obj/item/ammo_casing/caseless/rogue/arrow/iron


/obj/item/grown/log/tree/stake/Initialize()
	if (!embedding)
		embedding = getEmbeddingBehavior(
			embed_chance = 25,                        // Guaranteed to embed
			embedded_fall_chance = 0,                  // Never falls out
			embedded_pain_chance = 15,                // hurts every so often to prevent spamage
			embedded_pain_multiplier = 20,            // Customize pain as needed
			embedded_fall_pain_multiplier = 0.0,       // No fallout pain (since it never falls)
			embedded_impact_pain_multiplier = 2.0,
			embedded_unsafe_removal_pain_multiplier = 5.0, // Extremely painful to remove
			embedded_unsafe_removal_time = 300,         // Takes time to pull out
			embedded_ignore_throwspeed_threshold = TRUE,
			embedded_bloodloss = 1.0,                  // Moderate blood loss
			retract_limbs = FALSE,
			clamp_limbs = FALSE
		)
	. = ..()

/obj/item/grown/log/tree/stake/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/M = target

	if(!istype(M))
		return

	if(M.checkarmor(BODY_ZONE_CHEST, BCLASS_STAB))
		to_chat(user, "The stake can't pierce through [M]'s armor!")
		return FALSE
	if(!M.resting)
		to_chat(user, "[M] can't be staked while standing!")
		return

	to_chat(user, "You begin driving the stake into [M]'s chest...")
	user.visible_message(span_warning("[user] begins staking [M]!"))
	if(do_after(user, 30, M))
		to_chat(user, "You drive the stake into [M]!")
		embed_in_target(M, user)

	else
		to_chat(user, "You were interrupted!")


/obj/item/grown/log/tree/stake/attackby(obj/item/I, mob/user, params)
	return

/obj/item/grown/log/tree/stake/proc/embed_in_target(mob/living/carbon/human/M, mob/user)
	if(!(src in M.simple_embedded_objects))
		var/obj/item/bodypart/bodypart = M.get_bodypart(BODY_ZONE_CHEST)
		bodypart.add_embedded_object(src, silent = FALSE, crit_message = FALSE)

	if(M.mind && M.mind.has_antag_datum(/datum/antagonist/vampirelord))
		to_chat(M, span_danger("Pain erupts in your chest as the stake pierces your undead heart!"))
		var/datum/antagonist/vampirelord/lord = M.mind.has_antag_datum(/datum/antagonist/vampirelord)
		lord.stake()

//................	Wooden planks	............... //
/obj/item/natural/wood/plank
	name = "wooden plank"
	desc = "A flat piece of wood, useful for flooring."
	icon = 'icons/roguetown/items/crafting.dmi'
	icon_state = "plank"
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	attacked_sound = 'sound/misc/woodhit.ogg'
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 6
	throwforce = 0
	obj_flags = null
	resistance_flags = FLAMMABLE
	slot_flags = null
	max_integrity = 20
	firefuel = 5 MINUTES
	w_class = WEIGHT_CLASS_BULKY
	bundletype = /obj/item/natural/bundle/plank
	smeltresult = /obj/item/ash
/obj/item/natural/wood/plank/attack_right(mob/living/user)
	if(user.get_active_held_item())
		return
	to_chat(user, span_warning("I start to collect [src]..."))
	if(move_after(user, 4 SECONDS, target = src))
		var/stackcount = 0
		for(var/obj/item/natural/wood/plank/F in get_turf(src))
			stackcount++
		while(stackcount > 0)
			if(stackcount == 1)
				var/obj/item/natural/wood/plank/S = new(get_turf(user))
				user.put_in_hands(S)
				stackcount--
			else if(stackcount >= 2)
				var/obj/item/natural/bundle/plank/B = new(get_turf(user))
				B.amount = clamp(stackcount, 2, 6)
				B.update_bundle()
				stackcount -= clamp(stackcount, 2, 6)
				user.put_in_hands(B)
		for(var/obj/item/natural/wood/plank/F in get_turf(src))
			playsound(get_turf(user.loc), 'sound/foley/dropsound/wooden_drop.ogg', 80)
			qdel(F)

//................	Wooden plan stack	............... //
/obj/item/natural/bundle/plank
	name = "stack of wooden planks"
	desc = "Several planks in a neat pile."
	icon_state = "plankbundle1"
	item_state = "plankbundle"
	icon = 'icons/roguetown/items/crafting.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	throw_range = 2
	firefuel = 10 MINUTES
	w_class = WEIGHT_CLASS_BULKY
	stackname = "plank"
	stacktype = /obj/item/natural/wood/plank
	maxamount = 6
	icon1 = "plankbundle2"
	icon1step = 3
	icon2 = "plankbundle3"
	icon2step = 5
	smeltresult = /obj/item/ash

