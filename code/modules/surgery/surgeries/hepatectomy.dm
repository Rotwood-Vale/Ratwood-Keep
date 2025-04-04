/datum/surgery/hepa
	name = "Hepatectomy"
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_PRECISE_STOMACH)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/incise,
		/datum/surgery_step/resection,
		/datum/surgery_step/cauterize,
	)

/datum/surgery_step/resection
	name = "Perform Liver Rejuvination"
	time = 20 SECONDS
	accept_hand = FALSE
	possible_locs = list(BODY_ZONE_PRECISE_STOMACH)
	implements = list(
		TOOL_SCALPEL = 60,
		TOOL_SHARP = 40,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	surgery_flags = SURGERY_INCISED | SURGERY_RETRACTED
	skill_min = SKILL_LEVEL_EXPERT
	skill_median = SKILL_LEVEL_MASTER

/datum/surgery_step/resection/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(target.has_status_effect(/datum/status_effect/debuff/wliver))
		to_chat(user, "Their liver is too weak")
		return FALSE
	else
		display_results(user, target, span_notice("I begin a resection on [target]'s liver..."),
			span_notice("[user] begins to carve into [target]'s liver."),
			span_notice("[user] begins to carve into [target]'s liver."))
		return TRUE

/datum/surgery_step/resection/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I successfully resect damaged and infected portions of [target]'s liver."),
		span_notice("[user] successfully carves out chunks of [target]'s liver, restoring its function!"),
		span_notice("[user] successfully carves out chunks of [target]'s liver, restoring its function!"))
	var/obj/item/organ/liver/liver = target.getorganslot(ORGAN_SLOT_LIVER)
	if(liver)
		liver.Remove(target)
		QDEL_NULL(liver)
		liver = new /obj/item/organ/liver/weak
		liver.Insert(target)
		return TRUE
