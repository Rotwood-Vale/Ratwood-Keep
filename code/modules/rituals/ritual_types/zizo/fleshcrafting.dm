// Fleshcrafting, everything to do with the mortal form mostly

//get yourself some stats..
/datum/ritual/zizo/riteofbodilyperfection
	name = "Rite of bodily Perfection"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human
	difficulty = 4
	favor_cost = 250
	n_req = /obj/item/reagent_containers/lux
	function = /proc/riteofbodilyperfection

proc/riteofbodilyperfection(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if("Rite of bodily Perfection" in H.mind.rituals_completed) // No doing this twice.
			to_chat(H.mind, span_notice("My body is already honed to perfection.."))
			to_chat(user.mind, span_notice("That ones body has already been perfected.."))
			break
		H.change_stat("strength", 1)
		H.change_stat("speed", 1)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		user.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
		H.mind.rituals_completed += "Rite of bodily Perfection"
		C.visible_message(span_danger("[H.real_name]s form begins to twist and contort violently as they are remade by Her hands."))
		H.emote("painscream")
		to_chat(H.mind, span_notice("By Zizos grace, my wretched mortal form twists into an idealized form of itself!"))

//Steal Lux from a living Creature
/datum/ritual/zizo/theftoflight 
	name = "Theft of the Light"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human
	difficulty = 1
	favor_cost = 25
	function = /proc/theftoflight

//if(target.has_status_effect(/datum/status_effect/debuff/death_weaken))
proc/theftoflight(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(!(H.mind) || H.has_status_effect(/datum/status_effect/debuff/death_weaken)) //fails if mindless/luxdrained, no farming from afk/dead
			to_chat(user.mind, span_notice("There is not a spark of thought inside this one.."))
			user.mind.zizofavor += 25 //refund
			return
		H.apply_status_effect(/datum/status_effect/debuff/death_weaken)
		H.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
		H.electrocute_act(30, src)
		new /obj/item/reagent_containers/lux(H.loc)
		




/datum/ritual/zizo/lesserfleshmend
	name = "Lesser Fleshmend"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human
	n_req =  /obj/item/reagent_containers/food/snacks/rogue/meat
	difficulty = 1
	favor_cost = 50
	function = /proc/lesserfleshmend

/proc/lesserfleshmend(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		H.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
		

		var/healing = (H.mind.get_skill_level(/datum/skill/magic/unholy))*20
		if(H.blood_volume < BLOOD_VOLUME_NORMAL)
			H.blood_volume = min(H.blood_volume+healing, BLOOD_VOLUME_NORMAL)
		if(length(H.get_wounds()))
			H.heal_wounds(healing)
			H.update_damage_overlays()
		H.adjustBruteLoss(-healing, 0)
		H.adjustFireLoss(-healing, 0)
		H.adjustOxyLoss(-healing, 0)
		H.adjustToxLoss(-healing, 0)
		H.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healing)
		H.adjustCloneLoss(-healing, 0)
		to_chat(H.mind, span_notice("Zizo deigns to pull my wretched body together once more!"))
		break

/datum/ritual/zizo/fleshmend
	name = "Fleshmend"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human
	n_req =  /obj/item/reagent_containers/food/snacks/rogue/meat
	e_req =  /obj/item/reagent_containers/food/snacks/rogue/meat
	w_req =  /obj/item/reagent_containers/food/snacks/rogue/meat
	s_req =  /obj/item/reagent_containers/food/snacks/rogue/meat
	difficulty = 4
	favor_cost = 150

	function = /proc/fleshmend

/proc/fleshmend(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		H.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
		H.fully_heal(admin_revive = TRUE)
		to_chat(H.mind, span_notice("ZIZO EMPOWERS ME!"))
		break

/datum/ritual/zizo/bunnylegs
	name = "Saliendo Pedes"
	circle = "Fleshcrafting"
	favor_cost = 150
	difficulty = 3
	center_requirement = /mob/living/carbon/human
	w_req = /obj/item/bodypart/l_leg
	e_req = /obj/item/bodypart/r_leg
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/bunnylegs

/proc/bunnylegs(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		ADD_TRAIT(H, TRAIT_ZJUMP, TRAIT_GENERIC)
		to_chat(H.mind, span_notice("I feel like my legs have become stronger."))
		break

/datum/ritual/zizo/darkeyes
	name = "Darkened Eyes"
	circle = "Fleshcrafting"
	difficulty = 2
	favor_cost = 100
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/organ/eyes
	e_req = /obj/item/organ/eyes
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/darkeyes

/proc/darkeyes(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		to_chat(H.mind, span_notice("I no longer fear the dark."))
		break

/datum/ritual/zizo/nopain
	name = "Painless Battle"
	circle = "Fleshcrafting"
	difficulty = 4
	favor_cost = 250
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/organ/heart
	e_req = /obj/item/organ/brain
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/nopain

/proc/nopain(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		ADD_TRAIT(user, TRAIT_NOPAIN, TRAIT_GENERIC)
		to_chat(H.mind, span_notice("I no longer feel pain, but it has come at a terrible cost."))
		H.change_stat("strength", -2)
		H.change_stat("constitution", -2)
		break

/datum/ritual/zizo/fleshform
	name = "Stronger Form"
	circle = "Fleshcrafting"
	difficulty = 4
	favor_cost = 250
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/bodypart/l_arm
	e_req = /obj/item/bodypart/r_arm
	n_req = /obj/item/organ/eyes
	s_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/fleshform

/proc/fleshform(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(iszizocultist(H))
			to_chat(user.mind, span_danger("\"I'm not letting my strongest follower become a mindless brute.\""))
			return
		to_chat(H.mind, span_danger("SOON I WILL BECOME A HIGHER FORM!!!"))
		sleep(5 SECONDS)
		var/mob/living/trl = new /mob/living/simple_animal/hostile/retaliate/rogue/blood(H)
		trl.forceMove(H)
		trl.ckey = H.ckey
		H.gib()

/datum/ritual/zizo/gutted
	name = "Gutted Fish"
	circle = "Fleshcrafting"
	difficulty = 1
	favor_cost = 10
	center_requirement = /mob/living/carbon/human // One to be gutted.human

	function = /proc/guttedlikeafish

/proc/guttedlikeafish(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H.stat == DEAD)
			H.take_overall_damage(500)
			C.visible_message(span_danger("[H.real_name] is lifted up into the air and multiple scratches, incisions and deep cuts start etching themselves into their skin as all of their internal organs spill on the floor below!"))

			var/atom/drop_location = H.drop_location()
			for(var/obj/item/organ/organ as anything in H.internal_organs)
				organ.Remove(H)
				organ.forceMove(drop_location)
			var/obj/item/bodypart/chest/cavity = H.get_bodypart(BODY_ZONE_CHEST)
			if(cavity.cavity_item)
				cavity.cavity_item.forceMove(drop_location)
				cavity.cavity_item = null
