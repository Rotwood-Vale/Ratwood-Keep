/datum/wound/slash
	name = "slash"
	whp = 30
	sewn_whp = 10
	bleed_rate = 0.4
	sewn_bleed_rate = 0.02
	clotting_rate = 0.02
	sewn_clotting_rate = 0.02
	clotting_threshold = 0.2
	sewn_clotting_threshold = 0.1
	woundpain = 0
	sewn_woundpain = 0
	sew_threshold = 50
	mob_overlay = "cut"
	can_sew = TRUE
	can_cauterize = TRUE

/datum/wound/slash/small
	name = "small slash"
	whp = 15
	sewn_whp = 5
	bleed_rate = 0.2
	sewn_bleed_rate = 0.01
	clotting_rate = 0.02
	sewn_clotting_rate = 0.02
	clotting_threshold = 0.1
	sewn_clotting_threshold = 0.05
	sew_threshold = 25

/datum/wound/slash/large
	name = "gruesome slash"
	whp = 40
	sewn_whp = 12
	bleed_rate = 1
	sewn_bleed_rate = 0.05
	clotting_rate = 0.02
	sewn_clotting_rate = 0.02
	clotting_threshold = 0.4
	sewn_clotting_threshold = 0.1
	sew_threshold = 75

/datum/wound/slash/disembowel
	name = "disembowelment"
	check_name = span_userdanger("<B>GUTS</B>")
	severity = WOUND_SEVERITY_FATAL
	crit_message = list(
		"%VICTIM spills %P_THEIR organs!",
		"%VICTIM spills %P_THEIR entrails!",
	)
	sound_effect = 'sound/combat/crit2.ogg'
	whp = 100
	sewn_whp = 35
	bleed_rate = 20
	sewn_bleed_rate = 0.8
	clotting_rate = 0.02
	sewn_clotting_rate = 0.02
	clotting_threshold = 10
	sewn_clotting_threshold = 0.5
	sew_threshold = 150 //absolutely awful to sew up
	critical = TRUE
	/// Organs we can disembowel associated with chance to disembowel
	var/static/list/affected_organs = list(
		ORGAN_SLOT_STOMACH = 100,
		ORGAN_SLOT_LIVER = 50,
	)

/datum/wound/slash/disembowel/can_stack_with(datum/wound/other)
	if(istype(other, /datum/wound/slash/disembowel) && (type == other.type))
		return FALSE
	return TRUE

/datum/wound/slash/disembowel/on_mob_gain(mob/living/affected)
	. = ..()
	affected.emote("paincrit", TRUE)
	affected.Slowdown(20)
	shake_camera(affected, 2, 2)

/datum/wound/slash/disembowel/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	var/mob/living/carbon/gutted = affected.owner
	var/atom/drop_location = gutted.drop_location()
	var/list/spilled_organs = list()
	for(var/obj/item/organ/organ as anything in gutted.internal_organs)
		var/org_zone = check_zone(organ.zone)
		if(org_zone != BODY_ZONE_CHEST)
			continue
		if(!(organ.slot in affected_organs))
			continue
		var/spill_prob = affected_organs[organ.slot]
		if(prob(spill_prob))
			spilled_organs += organ
	for(var/obj/item/organ/spilled as anything in spilled_organs)
		spilled.Remove(owner)
		spilled.forceMove(drop_location)
	if(istype(affected, /obj/item/bodypart/chest))
		var/obj/item/bodypart/chest/cavity = affected
		if(cavity.cavity_item)
			cavity.cavity_item.forceMove(drop_location)
			cavity.cavity_item = null

/datum/wound/slash/incision
	name = "incision"
	check_name = span_bloody("<B>INCISION</B>")
	severity = WOUND_SEVERITY_SUPERFICIAL
	whp = 40
	sewn_whp = 12
	bleed_rate = 1
	sewn_bleed_rate = 0.05
	clotting_rate = null
	clotting_threshold = null
	sew_threshold = 75
	passive_healing = 0
	sleep_healing = 0

/datum/wound/slash/incision/sew_wound()
	qdel(src)
	return TRUE

/datum/wound/slash/incision/cauterize_wound()
	qdel(src)
	return TRUE
