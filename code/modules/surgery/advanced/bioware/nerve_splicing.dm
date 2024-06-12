/datum/surgery/advanced/bioware/nerve_splicing
	name = "Nerve Splicing"
	desc = ""
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/incise,
				/datum/surgery_step/incise,
				/datum/surgery_step/splice_nerves,
				/datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)
	bioware_target = BIOWARE_NERVES

/datum/surgery_step/splice_nerves
	name = "splice nerves"
	accept_hand = TRUE
	time = 155

/datum/surgery_step/splice_nerves/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("I start splicing together [target]'s nerves."),
		span_notice("[user] starts splicing together [target]'s nerves."),
		span_notice("[user] starts manipulating [target]'s nervous system."))

/datum/surgery_step/splice_nerves/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("I successfully splice [target]'s nervous system!"),
		span_notice("[user] successfully splices [target]'s nervous system!"),
		span_notice("[user] finishes manipulating [target]'s nervous system."))
	new /datum/bioware/spliced_nerves(target)
	return TRUE

/datum/bioware/spliced_nerves
	name = "Spliced Nerves"
	desc = ""
	mod_type = BIOWARE_NERVES

/datum/bioware/spliced_nerves/on_gain()
	..()
	owner.physiology.stun_mod *= 0.5

/datum/bioware/spliced_nerves/on_lose()
	..()
	owner.physiology.stun_mod *= 2
