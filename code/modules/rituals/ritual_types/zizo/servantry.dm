// Servantry, mostly to do with minions, their enhancement etc..

/// Checks if all bodyparts of a carbon are skeletonized, returns TRUE or FALSE
mob/living/carbon/proc/check_skeletonized() 
    for(var/obj/item/bodypart/B in bodyparts)
        if(!B.skeletonized)
            return FALSE
    return TRUE

/datum/ritual/zizo/riteofboneremembrance
	name = "Rite of Bone Remembrance"
	circle = "Servantry"
	difficulty = 3 
	favor_cost = 100
	center_requirement = /mob/living/carbon/human //skeleton, technically
	n_req = /obj/item/natural/infernalash
	s_req = /obj/item/natural/infernalash

	function = /proc/riteofboneremembrance

proc/riteofboneremembrance(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H.check_skeletonized())
			var/choice = input(H, "Visions of your past life flash before you. What fragment of your past life shall help you serve?", "Ritual of Remembrance") in list("Blacksmith", "Carpenter", "Mason", "Soilson", "Seamster")
			switch(choice)
				if("Blacksmith")
					H.mind.adjust_skillrank_up_to(/datum/skill/craft/blacksmithing, 3, TRUE)
					H.mind.adjust_skillrank_up_to(/datum/skill/labor/mining, 2, TRUE)
					H.say(pick("Hammers, Tongs - The heat of the forge..", "My apron burned, but I never flinched...","I shaped iron like it was clay... once."))
					return TRUE
				if("Carpenter")
					H.mind.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 3, TRUE)
					H.mind.adjust_skillrank_up_to(/datum/skill/labor/lumberjacking, 2, TRUE)
					H.say(pick("Wood grain and sawdust... it comes back to me.", "My hands remember the saw, and the axe...", "Joists, beams... I built homes once."))
					return TRUE
				if("Mason")
					H.mind.adjust_skillrank_up_to(/datum/skill/craft/masonry, 3, TRUE)
					H.mind.adjust_skillrank_up_to(/datum/skill/labor/mining, 2, TRUE)
					H.say(pick("Stone and mortar... my old companions.", "Stone walls rose by my hands, silent and strong.", "I once stacked bricks taller than men..."))
					return TRUE
				if("Soilson")
					H.mind.adjust_skillrank_up_to(/datum/skill/labor/farming, 3, TRUE)
					H.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 2, TRUE)
					H.say(pick("The soil... I tilled it, fed it, lived by it.", "Harvests and hearths... it's all faint, but I remember...", "I can almost smell the stews I once stirred inside my own farms hearth."))
					return TRUE
				if("Seamster")
					H.mind.adjust_skillrank_up_to(/datum/skill/misc/sewing, 3, TRUE)
					H.mind.adjust_skillrank_up_to(/datum/skill/craft/hunting, 2, TRUE)
					H.say(pick("Needle and thread... my fingertips ache with memory.", "I remember stitching the retinues gambesons, after so many fierce battles...", "So many patterns and colors... I remember them still."))
					return TRUE
			//gonna start to actually implement the choice mechanic here then
	return FALSE

/datum/ritual/zizo/zizobargain //bargain with somebody to change their patron to zizo, a good way to prevent frags of captives
	name = "Zizos Bargain"
	circle = "Servantry"
	difficulty = 1 // We want to encourage this happening
	favor_cost = 150 //Underpriced for a new ally, but again this being "meta" is good for the gameplay
	center_requirement = /mob/living/carbon/human

	function = /proc/zizobargain

proc/zizobargain(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H.patron?.type == /datum/patron/zizo)
			to_chat(user.mind, span_danger("\"They already serve Her!\""))
			return FALSE
		else
			var/choice = input(H, "Zizo offers you Her bargain. Will you abandon all that is good for a speck of power?", "Zizo's Bargain") in list("Yes", "No")
			if(choice == "Yes")
				H.patron = new /datum/patron/zizo
				H.faction += "undead"
				to_chat(H, span_notice("You feel Her cold embrace settle into your soul..."))
				var/secondchoice = input(H, "Zizo offers you Her gift. Was it worth it?", "Zizo's Gift") in list("Strength", "Speed", "Intellect", "Perception", "Endurance", "Constitution")
				switch (secondchoice)
					if("Strength")
						H.change_stat("strength", 1)
					if("Speed")
						H.change_stat("speed", 1)
					if("Intelligence")
						H.change_stat("intelligence", 1)
					if("Perception")
						H.change_stat("perception", 1)
					if("Endurance")
						H.change_stat("endurance", 1)
					if("Constitution")
						H.change_stat("constitution", 1)

				to_chat(user, span_notice("[H.real_name] has accepted the bargain."))
				H.say("PRAISE ZIZO!!!")
			else
				to_chat(user, span_warning("[H.real_name] refuses Zizo's gift. Such INSOLENCE!"))
				C.visible_message(span_danger("[H.real_name] is thrown into the air, their body wracked with spasms as invisible forces tear at their flesh for their defiance!"))
				H.emote("painscream")	
				to_chat(H.mind, span_notice("THE PAIN!! IT'S TOO MUCH!!!"))
				playsound(C,pick('sound/combat/hits/bladed/genslash (1).ogg','sound/combat/hits/bladed/genslash (2).ogg','sound/combat/hits/bladed/genslash (3).ogg'), 100, FALSE)
		return TRUE
	return FALSE



/datum/ritual/zizo/voiceofzizo
	name = "Voice of Zizo"
	circle = "Servantry"
	difficulty = 1 // We want to encourage this
	favor_cost = 50
	center_requirement = /mob/living/carbon/human

	function = /proc/voiceofzizo


proc/voiceofzizo(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		H.apply_status_effect(/datum/status_effect/debuff/zizovoice, H, user)
		user.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
		return TRUE
	return FALSE

/datum/ritual/zizo/bonemastery //Increases A Necromancers Skeleton Cap by 1
	name = "Ritual of Bone Mastery"
	circle = "Servantry"
	difficulty = 3
	favor_cost = 250
	center_requirement = /mob/living/carbon/human
	n_req = /obj/item/natural/infernalash //the necromancer will have to do their own work getting this
	s_req = /obj/item/natural/infernalash
	w_req = /obj/item/natural/infernalash
	e_req = /obj/item/natural/infernalash

	function = /proc/bonemastery

/proc/bonemastery(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if (user.mind.get_skill_level(/datum/skill/magic/unholy)> H.mind.bonemax)
			H.mind.bonemax += 1
			return TRUE
		else
			to_chat(user.mind, span_danger("\"I am not powerful enough to grant them a closer connection to Zizo...\""))
			to_chat(H.mind, span_danger("\"That cultist is not powerful enough to grant me a closer connection to Zizo...\""))
			return TRUE
	return FALSE
/datum/ritual/zizo/convert
	name = "Convert"
	circle = "Servantry"
	difficulty = 5
	favor_cost = 150
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
	difficulty = 4
	favor_cost = 150
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
		//H.verbs |= /mob/living/carbon/human/proc/communicate

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
		return TRUE

/datum/ritual/zizo/thecall
	name = "The Call"
	circle = "Servantry"
	difficulty = 5
	favor_cost = 250
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
	difficulty = 2
	favor_cost = 100
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
	difficulty = 5
	favor_cost = 100
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
