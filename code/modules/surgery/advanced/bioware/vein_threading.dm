/datum/surgery/advanced/bioware/vein_threading
	name = "Vein Threading"
	desc = ""
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/incise,
				/datum/surgery_step/incise,
				/datum/surgery_step/thread_veins,
				/datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)
	bioware_target = BIOWARE_CIRCULATION

/datum/surgery_step/thread_veins
	name = "thread veins"
	accept_hand = TRUE
	time = 125

/datum/surgery_step/thread_veins/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("I start weaving [target]'s circulatory system."),
		span_notice("[user] starts weaving [target]'s circulatory system."),
		span_notice("[user] starts manipulating [target]'s circulatory system."))

/datum/surgery_step/thread_veins/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("I weave [target]'s circulatory system into a resistant mesh!"),
		span_notice("[user] weaves [target]'s circulatory system into a resistant mesh!"),
		span_notice("[user] finishes manipulating [target]'s circulatory system."))
	new /datum/bioware/threaded_veins(target)
	return TRUE

/datum/bioware/threaded_veins
	name = "Threaded Veins"
	desc = ""
	mod_type = BIOWARE_CIRCULATION

/datum/bioware/threaded_veins/on_gain()
	..()
	owner.physiology.bleed_mod *= 0.25

/datum/bioware/threaded_veins/on_lose()
	..()
	owner.physiology.bleed_mod *= 4
