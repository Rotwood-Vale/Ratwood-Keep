//predominantly positive traits
//this file is named weirdly so that positive traits are listed above negative ones

/datum/quirk/alcohol_tolerance
	name = "Alcohol Tolerance"
	desc = ""
	value = 1
	mob_trait = TRAIT_ALCOHOL_TOLERANCE
	gain_text = span_notice("I feel like you could drink a whole keg!")
	lose_text = span_danger("I don't feel as resistant to alcohol anymore. Somehow.")
	medical_record_text = "Patient demonstrates a high tolerance for alcohol."

/datum/quirk/apathetic
	name = "Apathetic"
	desc = ""
	value = 1
	mood_quirk = TRUE
	medical_record_text = "Patient was administered the Apathy Evaluation Scale but did not bother to complete it."

/datum/quirk/apathetic/add()
	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	if(mood)
		mood.mood_modifier -= 0.2

/datum/quirk/apathetic/remove()
	if(quirk_holder)
		var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
		if(mood)
			mood.mood_modifier += 0.2

/datum/quirk/drunkhealing
	name = "Drunken Resilience"
	desc = ""
	value = 2
	mob_trait = TRAIT_DRUNK_HEALING
	gain_text = span_notice("I feel like a drink would do you good.")
	lose_text = span_danger("I no longer feel like drinking would ease your pain.")
	medical_record_text = "Patient has unusually efficient liver metabolism and can slowly regenerate wounds by drinking alcoholic beverages."

/datum/quirk/drunkhealing/on_process()
	var/mob/living/carbon/C = quirk_holder
	switch(C.drunkenness)
		if (6 to 40)
			C.adjustBruteLoss(-0.1, FALSE)
			C.adjustFireLoss(-0.05, FALSE)
		if (41 to 60)
			C.adjustBruteLoss(-0.4, FALSE)
			C.adjustFireLoss(-0.2, FALSE)
		if (61 to INFINITY)
			C.adjustBruteLoss(-0.8, FALSE)
			C.adjustFireLoss(-0.4, FALSE)

/datum/quirk/empath
	name = "Empath"
	desc = ""
	value = 2
	mob_trait = TRAIT_EMPATH
	gain_text = span_notice("I feel in tune with those around you.")
	lose_text = span_danger("I feel isolated from others.")
	medical_record_text = "Patient is highly perceptive of and sensitive to social cues, or may possibly have ESP. Further testing needed."

/datum/quirk/freerunning
	name = "Freerunning"
	desc = ""
	value = 2
	mob_trait = TRAIT_FREERUNNING
	gain_text = span_notice("I feel lithe on your feet!")
	lose_text = span_danger("I feel clumsy again.")
	medical_record_text = "Patient scored highly on cardio tests."

/datum/quirk/friendly
	name = "Friendly"
	desc = ""
	value = 1
	mob_trait = TRAIT_FRIENDLY
	gain_text = span_notice("I want to hug someone.")
	lose_text = span_danger("I no longer feel compelled to hug others.")
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates low-inhibitions for physical contact and well-developed arms. Requesting another doctor take over this case."

/datum/quirk/jolly
	name = "Jolly"
	desc = ""
	value = 1
	mob_trait = TRAIT_JOLLY
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates constant euthymia irregular for environment. It's a bit much, to be honest."

/datum/quirk/jolly/on_process()
	if(prob(0.05))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "jolly", /datum/mood_event/jolly)

/datum/quirk/light_step
	name = "Light Step"
	desc = ""
	value = 1
	mob_trait = TRAIT_LIGHT_STEP
	gain_text = span_notice("I walk with a little more litheness.")
	lose_text = span_danger("I start tromping around like a barbarian.")
	medical_record_text = "Patient's dexterity belies a strong capacity for stealth."

/datum/quirk/night_vision
	name = "Night Vision"
	desc = ""
	value = 1
	mob_trait = TRAIT_NIGHT_VISION
	gain_text = span_notice("The shadows seem a little less dark.")
	lose_text = span_danger("Everything seems a little darker.")
	medical_record_text = "Patient's eyes show above-average acclimation to darkness."

/datum/quirk/night_vision/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/organ/eyes/eyes = H.getorgan(/obj/item/organ/eyes)
	if(!eyes || eyes.lighting_alpha)
		return
	eyes.Insert(H) //refresh their eyesight and vision

/datum/quirk/selfaware
	name = "Self-Aware"
	desc = ""
	value = 2
	mob_trait = TRAIT_SELF_AWARE
	medical_record_text = "Patient demonstrates an uncanny knack for self-diagnosis."

/datum/quirk/skittish
	name = "Skittish"
	desc = ""
	value = 2
	mob_trait = TRAIT_SKITTISH
	medical_record_text = "Patient demonstrates a high aversion to danger and has described hiding in containers out of fear."

/datum/quirk/spiritual
	name = "Spiritual"
	desc = ""
	value = 1
	mob_trait = TRAIT_SPIRITUAL
	gain_text = span_notice("I have faith in a higher power.")
	lose_text = span_danger("I lose faith!")
	medical_record_text = "Patient reports a belief in a higher power."

/datum/quirk/spiritual/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.equip_to_slot_or_del(new /obj/item/storage/fancy/candle_box(H), SLOT_IN_BACKPACK)

/datum/quirk/voracious
	name = "Voracious"
	desc = ""
	value = 1
	mob_trait = TRAIT_VORACIOUS
	gain_text = span_notice("I feel HONGRY.")
	lose_text = span_danger("I no longer feel HONGRY.")
