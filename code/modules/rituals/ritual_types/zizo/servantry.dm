/datum/ritual/zizo/convert
	name = "Convert"
	circle = "Servantry"
	center_requirement = /mob/living/carbon/human

	function = /proc/convert

/proc/convert(mob/user, turf/C)
	var/datum/game_mode/chaosmode/M = SSticker.mode

	for(var/mob/living/carbon/human/H in C.contents)
		if(H != user)
			if(iszizocultist(H) || iszizolackey(H))
				return
			if(!H.client)
				return
			if(H.anchored) // a way to bind the person to the rune if they choose to resist converting
				return
			if(istype(H.wear_neck, /obj/item/clothing/neck/roguetown/psicross))
				to_chat(user.mind, span_danger("\"They are wearing my bane...\""))
				return
			if(M.cultists.len >= 10)
				to_chat(user.mind, span_danger("\"The veil is too strong to support more than ten cultists.\""))
				return
			var/datum/antagonist/zizocultist/PR = user.mind.has_antag_datum(/datum/antagonist/zizocultist)
			var/alert = alert(H, "YOU WILL BE SHOWN THE TRUTH. DO YOU RESIST? (Resisting: 1 TRI)", "RATWOOD", "Yield", "Resist")
			H.anchored = TRUE
			if(alert == "Yield")
				to_chat(H.mind, span_notice("I see the truth now! It all makes so much sense! They aren't HERETICS! They want the BEST FOR US!"))
				PR.add_cultist(H.mind)
				H.praise()
				H.anchored = FALSE
			else
				H.adjust_triumphs(-1)
				H.visible_message(span_danger("\The [H] thrashes around, unyielding!"))
				to_chat(H.mind, span_danger("\"Yield.\""))
				if(H.electrocute_act(10, user))
					H.emote("painscream")
				sleep(2 SECONDS)
				H.anchored = FALSE

/datum/ritual/zizo/skeletaljaunt
	name = "Skeletal Jaunt"
	circle = "Servantry"
	center_requirement = /mob/living/carbon/human

	n_req = /obj/item/organ/heart

	function = /proc/skeletaljaunt

/proc/skeletaljaunt(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H == user)
			return
		if(iszizocultist(H))
			to_chat(user.mind, span_danger("\"I'm not gonna let my strongest follower become a mindless brute.\""))
			return
		if(H.mind)
			H.mind.special_role = "Cult Summon"
			H.mind.assigned_role = "Cult Summon"
			H.mind.current.job = null
		H.dna.species.species_traits |= NOBLOOD
		H.dna.species.soundpack_m = new /datum/voicepack/skeleton()
		H.dna.species.soundpack_f = new /datum/voicepack/skeleton()
		var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_R_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		O = H.get_bodypart(BODY_ZONE_L_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		H.regenerate_limb(BODY_ZONE_R_ARM)
		H.regenerate_limb(BODY_ZONE_L_ARM)
		for(var/obj/item/bodypart/BP in H.bodyparts)
			BP.skeletonize()
		H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/simple/claw)
		H.update_a_intents()
		H.cmode_music = 'sound/music/combatcult.ogg'
		H.patron = GLOB.patronlist[/datum/patron/zizo]
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		H.ambushable = FALSE
		H.underwear = "Nude"
		if(H.charflaw)
			QDEL_NULL(H.charflaw)
		H.update_body()
		H.mob_biotypes |= MOB_UNDEAD
		H.faction = list("undead")

		H.STASPD = rand(7,10)
		H.STAINT = 1
		H.STACON = 3
		H.STASTR = rand(8,17)

		H.verbs |= /mob/living/carbon/human/proc/praise
		H.verbs |= /mob/living/carbon/human/proc/communicate

		ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSTAMINA, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSLEEP, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
		to_chat(H, span_userdanger("I am returned to serve. I will obey, so that I may return to rest."))
		to_chat(H, span_userdanger("My master is [user]."))
		break

/datum/ritual/zizo/thecall
	name = "The Call"
	circle = "Servantry"
	center_requirement = /obj/item/bedsheet/rogue

	w_req = /obj/item/bodypart/l_leg
	e_req = /obj/item/bodypart/r_leg

	function = /proc/thecall

/proc/thecall(mob/user, turf/C)
	for(var/obj/item/paper/P in C.contents)
		if(!user.mind || !user.mind.do_i_know(name=P.info))
			to_chat(user.mind, span_warning("I don't know anyone by that name."))
			return
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.real_name == P.info)
				if(HL.has_status_effect(/datum/status_effect/debuff/sleepytime))
					if(HL.mind.assigned_role in GLOB.church_positions)
						to_chat(HL.mind, span_warning("I sense an unholy presence loom near my soul."))
						return
					if(HL == SSticker.rulermob)
						return
					if(istype(HL.wear_neck, /obj/item/clothing/neck/roguetown/psicross))
						return
					if(HAS_TRAIT(HL, TRAIT_NOSLEEP) || HAS_TRAIT(HL, TRAIT_NOSTAMINA))
						return
					to_chat(HL.mind, span_warning("I'm so sleepy..."))
					HL.SetSleeping(30)
					spawn(10 SECONDS)
						to_chat(HL.mind, span_warning("This isn't my bed... Where am I?!"))
						HL.playsound_local(HL.loc, pick('sound/misc/jumphumans (1).ogg','sound/misc/jumphumans (2).ogg','sound/misc/jumphumans (3).ogg'), 100)
						HL.forceMove(C)
					qdel(P)

/datum/ritual/zizo/falseappearance
	name = "Falsified Appearance"
	circle = "Servantry"
	center_requirement = /mob/living/carbon/human

	n_req = /obj/item/bodypart/head
	s_req = /obj/item/shard
	e_req = /obj/item/shard
	w_req = /obj/item/shard

	function = /proc/falseappearance

/proc/falseappearance(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		var/datum/preferences/A = new()//Randomize appearance for the guy
		var/first_names = GLOB.first_names
		if(H.gender == FEMALE)
			first_names = GLOB.first_names_female
		else
			first_names = GLOB.first_names_male
		A.real_name = "[pick(first_names)]"
		A.copy_to(H)
		H.dna.update_dna_identity()
		break

/obj/item/pactofunity // Not paper because I don't fuck with that.
	name = "pact of unity"
	desc = "Write down your name and about your fiendish ways."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "confession"
	var/mob/living/carbon/human/signed

/obj/item/pactofunity/examine(mob/user)
	. = ..()
	if(signed)
		to_chat(user, "It is bound to [signed.real_name].")

/obj/item/pactofunity/attack_self(mob/user)
	. = ..()
	var/alert = alert(user, "Rip up the pact of unity?", "RATWOOD", "RIP", "Cancel")
	if(alert == "RIP")
		user.playsound_local(user, 'sound/foley/cloth_rip.ogg', 50)
		to_chat(signed.mind, span_userdanger("I FAILED! MY LIFE DWINDLES!"))
		sleep(2 MINUTES)
		if(istype(signed.wear_neck, /obj/item/clothing/neck/roguetown/psicross))
			return
		signed.dust(drop_items=TRUE)

/obj/item/pactofunity/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!ishuman(M))
		return
	var/mob/living/carbon/human/H = M
	if(signed)
		return ..()
	if(!H.get_bleed_rate())
		to_chat(user, span_warning("No. They must be bleeding."))
		return
	if(!H.stat)
		to_chat(user, span_info("I courteously offer \the [src] to [H]."))
		if(alert(H, "Sign the pact with your blood?", "RATWOOD", "Yes", "No") != "Yes")
			return
		if(H.stat)
			return
		if(signed)
			return
		to_chat(H, span_info("I signed the paper, hopefully I won't regret this."))
		signed = H

/proc/pactofunity(mob/user, turf/C)
	new /obj/item/pactofunity(C)
	to_chat(user.mind, span_notice("The Pact of Unity. When a person willingly signs their name on this they become my pawn. When I rip up the paper their soul is good as dead."))

/datum/ritual/zizo/heartache
	name = "Heartache"
	circle = "Servantry"
	center_requirement = /obj/item/organ/heart

	n_req = /obj/item/natural/worms/leech

	function = /proc/heartache

/proc/heartache(mob/user, turf/C)
	new /obj/item/corruptedheart(C)
	to_chat(user.mind, span_notice("A corrupted heart. When used on a non-enlightened mortal their heart shall ache and they will be immobilized and too stunned to speak. Perfect for getting new soon-to-be enlightened. Now, just don't use it at the combat ready."))

/obj/item/corruptedheart
	name = "corrupted heart"
	desc = "It sparkles with forbidden magic energy. It makes all the heart aches go away."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "heart-on"

/obj/item/corruptedheart/attack(mob/living/M, mob/living/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(iszizocultist(H) || iszizolackey(H))
			H.fully_heal()
			to_chat(H, span_notice("My elixir of life is stagnant once again."))
			qdel(src)
		else
			if(!do_mob(user, H, 2 SECONDS))
				return
			if(M.cmode)
				user.electrocute_act(30)
			H.electrocute_act(20)
			H.Stun(10 SECONDS)
			H.silent += 30
			qdel(src)
