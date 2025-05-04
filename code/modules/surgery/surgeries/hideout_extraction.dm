/datum/surgery/hideout_extraction
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/hideout_extraction,
		/datum/surgery_step/cauterize,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_HEAD)

/datum/surgery_step/hideout_extraction
	name = "hideout extraction"
	implements = list(
		TOOL_SCALPEL = 80,
		TOOL_SAW = 60,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 1 SECONDS
	repeating = TRUE
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED
	skill_min = SKILL_LEVEL_MASTER

/datum/surgery_step/hideout_extraction/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE

/datum/surgery_step/hideout_extraction/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target,
		span_warning("You begin torturous probing into [target]'s skull..."),
		"[user] starts pressing into [target]'s head with cruel intent.",
		"[user] begins torturing [target]'s mind.")
	return TRUE

/datum/surgery_step/hideout_extraction/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/intent/intent)
	target.adjustCloneLoss(40)
	target.emote("screams")

	var/hideout_msg
	var/trait_to_reveal
	var/traveltype

	if(HAS_TRAIT(target, TRAIT_BANDITCAMP) && prob(30))
		hideout_msg = pick("THE ABANDONED MINESHAFT!", "THE OLD CHAPEL!", "THE DERELICT TUNNELS!")
		trait_to_reveal = TRAIT_BANDITCAMP
		traveltype = /obj/structure/fluff/traveltile/bandit
	else if(HAS_TRAIT(target, TRAIT_GOBLINCAMP) && prob(30))
		hideout_msg = pick("THE ROTTING SEWERS!", "THE SHIT PIT!", "THE SLIME HOLE!")
		trait_to_reveal = TRAIT_GOBLINCAMP
		traveltype = /obj/structure/fluff/traveltile/goblin
	else if(HAS_TRAIT(target, TRAIT_VAMPMANSION) && prob(10))
		hideout_msg = pick("THE BLOOD MANOR!", "THE OLD CRYPT!", "THE SHADOWED VILLA!")
		trait_to_reveal = TRAIT_VAMPMANSION
		traveltype = /obj/structure/fluff/traveltile/vampire
	else
		target.say("I... I don't know anything! Please, stop!")
		display_results(user, target,
			span_warning("[target] resists your efforts. Nothing useful is learned."),
			"[user] digs into [target]'s head but finds no information.",
			"[user] tortures [target], but they scream in ignorance.")
		return TRUE

	// Say the hideout location
	target.say("STOP IT! I'LL TALK! IT'S IN [hideout_msg]")

	for(var/mob/living/carbon/human/H in view(7, target))
		ADD_TRAIT(H, trait_to_reveal, TRAIT_GENERIC)
		for(var/obj/structure/fluff/traveltile/tile in GLOB.traveltiles)
			if(istype(tile, traveltype))
				tile.show_travel_tile(H)

	display_results(user, target,
		span_warning("You wrench the truth from [target]'s tortured mind."),
		"[user] extracts a painful confession from [target].",
		"[user] digs deeper into [target]'s head.")
	return TRUE

/datum/surgery_step/hideout_extraction/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/intent/intent, success_prob)
	target.adjustCloneLoss(40)
	target.emote("screams")

	display_results(user, target,
		span_warning("Your blade bites deep, but no secrets spill..."),
		"[user] cuts deep but [target] resists giving up anything.",
		"[user] digs into [target]'s skull with no result.")
	return TRUE
