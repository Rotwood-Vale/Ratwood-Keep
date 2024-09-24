/datum/reagent/medicine/minorhealthpot
	name = "Minor Health Potion"
	description = "Gradually regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff9494"
	taste_description = "tangy sweetness"
	overdose_threshold = 0
	metabolization_rate = 1 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/minorhealthpot/on_mob_life(mob/living/carbon/M) // Heals half as much as health potion, but not wounds.
	M.adjustBruteLoss(-0.5*REM, 0) // 20u = 25 points of healing
	M.adjustFireLoss(-0.5*REM, 0)
	M.adjustOxyLoss(-1, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1*REM)
	M.adjustCloneLoss(-1*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/healthpot
	name = "Health Potion"
	description = "Regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff5151"
	taste_description = "warm oil and flesh"
	overdose_threshold = 0
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/healthpot/on_mob_life(mob/living/carbon/M)
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+50, BLOOD_VOLUME_MAXIMUM)
	else
		//can overfill you with blood, but at a slower rate
		M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)	
		//some peeps dislike the church, this allows an alternative thats not a doctor or sleep. 
		M.heal_wounds(2) //at a motabalism of .5 U a tick this translates to 80WHP healing with 20 U Most wounds are unsewn 15-100. This is powerful on single wounds but rapidly weakens at multi wounds.
		M.update_damage_overlays()
	M.adjustBruteLoss(-0.5*REM, 0) // 20u = 50 points of healing
	M.adjustFireLoss(-0.5*REM, 0)
	M.adjustOxyLoss(-1, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1*REM)
	M.adjustCloneLoss(-1*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/majorhealthpot
	name = "Major Health Potion"
	description = "Quickly regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff4800"
	taste_description = "red"
	overdose_threshold = 20 // Means you'll end up in critical condition and need outside help if you over do it.
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/majorhealthpot/on_mob_life(mob/living/carbon/M) // Triple the healing of regular health pots.
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+100, BLOOD_VOLUME_MAXIMUM)
	else
		M.blood_volume = min(M.blood_volume+20, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)	
		M.heal_wounds(4)
		M.update_damage_overlays()
	M.adjustBruteLoss(-1.5*REM, 0) // 20u = 150 points of healing.
	M.adjustFireLoss(-1.5*REM, 0)
	M.adjustOxyLoss(-3, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -3*REM)
	M.adjustCloneLoss(-3*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/majorhealthpot/overdose_process(mob/living/carbon/M) // Savor your supreme healing, or else.
	M.add_nausea(15)
	M.adjustBruteLoss(1*REM, 0)
	M.adjustToxLoss(3, 0)
	M.blood_volume = min(M.blood_volume+100, BLOOD_VOLUME_MAXIMUM) // Full to bursting.

/datum/chemical_reaction/sublime_ambrosia
	name = "Sublime Ambrosia"
	id = /datum/reagent/medicine/sublimeambrosia
	results = list(/datum/reagent/medicine/sublimeambrosia = 5)
	required_reagents = list (/datum/reagent/medicine/healthpot = 45, /datum/reagent/medicine/minorhealthpot = 45, /datum/reagent/medicine/majorhealthpot = 45)

/datum/reagent/medicine/sublimeambrosia
	name = "Sublime Ambrosia"
	description = "Rapidly regenerates all types of damage, and reverses death."
	reagent_state = LIQUID
	color = "#b89c2b"
	taste_description = "magical apoptosis"
	overdose_threshold = 6 // Small doses...
	metabolization_rate = 0.3 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/sublimeambrosia/on_mob_life(mob/living/carbon/M)
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+200, BLOOD_VOLUME_MAXIMUM)
	else
		M.blood_volume = min(M.blood_volume+20, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)	
		M.heal_wounds(6)
		M.update_damage_overlays()
	M.adjustBruteLoss(-4.5*REM, 0)
	M.adjustFireLoss(-4.5*REM, 0)
	M.adjustOxyLoss(-9, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -9*REM)
	M.adjustCloneLoss(-9*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/sublimeambrosia/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	if(iscarbon(M) && M.stat == DEAD)
		if(M.mob_biotypes & MOB_UNDEAD)
			return FALSE
		if(!M.revive(full_heal = FALSE))
			M.visible_message(span_notice("[M]'s body does not seem to react to the ambrosia..."))
			return FALSE
		if(method == INGEST)
			var/mob/living/carbon/spirit/underworld_spirit = M.get_spirit()
			if(underworld_spirit)
				var/mob/dead/observer/ghost = underworld_spirit.ghostize()
				qdel(underworld_spirit)
				ghost.mind.transfer_to(M, TRUE)
			M.grab_ghost(force = TRUE) // even suicides
			M.emote("breathgasp")
			M.Jitter(100)
			M.update_body()
			M.visible_message(span_notice("[M]'s body convulses as they're ripped from death's embrace by ambrosia!"), span_green("I awake from the void."))
			if(M.mind)
				if(!HAS_TRAIT(M, TRAIT_IWASREVIVED))
					ADD_TRAIT(M, TRAIT_IWASREVIVED, "[type]")
		return TRUE
	..()

/datum/reagent/medicine/sublimeambrosia/overdose_process(mob/living/carbon/M) // This is meant for the dead, or near dead. Imbibe at own risk.
	M.add_nausea(25)
	M.adjustBruteLoss(3*REM, 0)
	M.dizziness += 2
	M.confused += 2
	M.adjustToxLoss(15, 0)
	M.blood_volume = min(M.blood_volume+100, BLOOD_VOLUME_MAXIMUM)

/datum/reagent/medicine/shroomt
	name = "Shroom Tea"
	description = "Extremely slowly regenerates all types of damage. long lasting."
	reagent_state = LIQUID
	color = "#476e4d"
	taste_description = "dirt"
	overdose_threshold = 25 // cups hold 24 so even one sip more from tanakrd is OD
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/shroomt/on_mob_life(mob/living/carbon/M)
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+50, BLOOD_VOLUME_MAXIMUM)
	else
		M.blood_volume = min(M.blood_volume+2, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)
		M.heal_wounds(1)
		M.update_damage_overlays()
	M.adjustBruteLoss(-0.2*REM, 0)
	M.adjustToxLoss(-0.2*REM, 0)
	M.adjustFireLoss(-0.2*REM, 0)
	M.adjustOxyLoss(-1, 0)
	M.rogstam_add(25)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1*REM)
	M.adjustCloneLoss(-1*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/shroomt/overdose_process(mob/living/carbon/M)
	M.add_nausea(15)

/datum/reagent/medicine/manapot
	name = "Mana Potion"
	description = "Gradually regenerates stamina."
	reagent_state = LIQUID
	color = "#0000ff"
	taste_description = "manna"
	overdose_threshold = 0
	metabolization_rate = 20 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/manapot/on_mob_life(mob/living/carbon/M)
	M.rogstam_add(100)
	..()
	. = 1

/datum/reagent/medicine/antipoisonpot
	name = "Anti Poison Potion"
	description = "Quickly nullifies toxins."
	reagent_state = LIQUID
	color = "#64bf49"
	taste_description = "ashes"
	overdose_threshold = 60
	metabolization_rate = REAGENTS_METABOLISM
	alpha = 200

/datum/reagent/medicine/antipoisonpot/on_mob_life(mob/living/carbon/M)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.type,0.5)
	M.adjustToxLoss(-0.5*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/antipoisonpot/overdose_process(mob/living/carbon/M)
	M.add_nausea(9)
	M.adjustToxLoss(3, 0)

/datum/reagent/berrypoison
	name = "Berry Poison"
	description = "Contains a poisonous thick, dark purple liquid."
	reagent_state = LIQUID
	color = "#00B4FF"
	metabolization_rate = 0.1

/datum/reagent/berrypoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER || TRAIT_WILD_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()

/datum/reagent/organpoison
	name = "Organ Poison"
	description = "A viscous black liquid clings to the glass."
	reagent_state = LIQUID
	color = "#ff2f00"
	metabolization_rate = 0.1

/datum/reagent/organpoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER) && !HAS_TRAIT(M, TRAIT_ORGAN_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()
