/obj/item/grown/log/tree
	icon = 'icons/roguetown/items/natural.dmi'
	name = "log"
	desc = "A big tree log. It's very heavy, and huge."
	icon_state = "log"
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
	if(user.used_intent.blade_class == BCLASS_CHOP && lumber_amount)
		var/skill_level = user.mind.get_skill_level(/datum/skill/labor/lumberjacking)
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

/obj/item/grown/log/tree/small
	name = "small log"
	desc = "Smaller log that came from a larger log. Suitable for building."
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

/obj/item/natural/wood/plank
	name = "wood plank"
	desc = "A wooden plank ready to be worked."
	icon_state = "wplank"
	firefuel = 5 MINUTES
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = /obj/item/ash
	bundletype = /obj/item/natural/bundle/plank
	metalizer_result = /obj/item/rogueore/tin


/obj/item/natural/bundle/plank
	name = "wooden planks"
	icon_state = "planks1"
	possible_item_intents = list(/datum/intent/use)
	desc = "Wooden planks bundled together for easy handling."
	force = 0
	throwforce = 0
	maxamount = 10
	firefuel = 30 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_BULKY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/wood/plank
	stackname = "plank"
	icon1 = "planks1"
	icon1step = 5
	icon2 = "planks2"
	icon2step = 10
	smeltresult = /obj/item/ash

/obj/item/grown/log/tree/small/essence
	name = "essence of lumber"
	desc = "A mystical essence embued with the power of Dendor. Very good source of fuel."
	icon_state = "lessence"
	static_debris = null
	firefuel = 60 MINUTES // Extremely poweful fuel.
	w_class = WEIGHT_CLASS_SMALL
	metalizer_result = /obj/item/rogueore/gold

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

/obj/item/grown/log/tree/stick
	name = "stick"
	icon_state = "stick1"
	desc = "A dry stick from a tree branch."
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

/obj/item/grown/log/tree/stick/attackby(obj/item/I, mob/living/user, params)
	var/mob/living/carbon/human/H = user
	user.changeNext_move(CLICK_CD_MELEE)
	if(user.used_intent?.blade_class == BCLASS_CUT)
		playsound(get_turf(src.loc), 'sound/items/wood_sharpen.ogg', 100)
		if(do_after(user, 20))
			user.visible_message(span_notice("[user] sharpens [src]."))
			var/obj/item/grown/log/tree/stake/S = new /obj/item/grown/log/tree/stake(get_turf(src.loc))
			if(user.is_holding(src))
				user.dropItemToGround(src)
				user.put_in_hands(S)
			qdel(src)
		else
			user.visible_message(span_warning("[user] sharpens [src]."))
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

/obj/item/grown/log/tree/stake
	name = "stake"
	icon_state = "stake"
	desc = "A wooden stake, and it's pointy end!"
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
