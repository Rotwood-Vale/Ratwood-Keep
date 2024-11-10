// Necrite
/obj/effect/proc_holder/spell/targeted/burialrite
	name = "Burial Rites"
	range = 5
	overlay_state = "consecrateburial"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "Undermaiden grant thee passage forth and spare the trials of the forgotten."
	invocation_type = "whisper" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 5 //very weak spell, you can just make a grave marker with a literal stick

/obj/effect/proc_holder/spell/targeted/burialrite/cast(list/targets, mob/user = usr)
	. = ..()
	var/target_turf = get_step(user, user.dir)
	var/obj/structure/closet/body_container
	for(var/obj/structure/closet/crate/coffin/coffin in target_turf)
		if(pacify_coffin(coffin, user))
			body_container = coffin
			break
	if(!body_container)
		for(var/obj/structure/closet/dirthole/hole in target_turf)
			if(pacify_coffin(hole, user))
				body_container = hole
				break
	if(body_container)
		user.visible_message("[user] consecrates [body_container]!", "I perform funeral rites on [body_container]!")
	else
		to_chat(user, span_red("I failed to perform the rites."))

/obj/effect/proc_holder/spell/targeted/churn
	name = "Churn Undead"
	range = 8
	overlay_state = "necra"
	releasedrain = 30
	charge_max = 30 SECONDS
	max_targets = 0
	cast_without_targets = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "The Undermaiden rebukes!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/targeted/churn/cast(list/targets,mob/living/user = usr)
	var/prob2explode = 100
	if(user && user.mind)
		prob2explode = 0
		for(var/i in 1 to user.mind.get_skill_level(/datum/skill/magic/holy))
			prob2explode += 30
	for(var/mob/living/L in targets)
		var/isvampire = FALSE
		var/iszombie = FALSE
		if(L.stat == DEAD)
			continue
		if(L.mind)
			var/datum/antagonist/vampirelord/lesser/V = L.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
			if(V)
				if(!V.disguised)
					isvampire = TRUE
			if(L.mind.has_antag_datum(/datum/antagonist/zombie))
				iszombie = TRUE
			if(L.mind.special_role == "Vampire Lord")
				user.visible_message(span_warning("[L] overpowers being churned!"), span_userdanger("[L] is too strong, I am churned!"))
				user.Stun(50)
				user.throw_at(get_ranged_target_turf(user, get_dir(user,L), 7), 7, 1, L, spin = FALSE)
				return
		if((L.mob_biotypes & MOB_UNDEAD) || isvampire || iszombie)
//			L.visible_message(span_warning("[L] is unmade by PSYDON!"), span_danger("I'm unmade by PSYDON!"))
			var/vamp_prob = prob2explode
			if(isvampire)
				vamp_prob -= 59
			if(prob(vamp_prob))
				explosion(get_turf(L), light_impact_range = 1, flame_range = 1, smoke = FALSE)
				L.Stun(50)
//				L.throw_at(get_ranged_target_turf(L, get_dir(user,L), 7), 7, 1, L, spin = FALSE)
			else
				L.visible_message(span_warning("[L] resists being churned!"), span_userdanger("I resist being churned!"))
	..()
	return TRUE

/obj/effect/proc_holder/spell/targeted/soulspeak
	name = "Speak with Soul"
	range = 5
	overlay_state = "speakwithdead"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "She-Below brooks thee respite. Be heard, wanderer."
	invocation_type = "whisper" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/targeted/soulspeak/cast(list/targets,mob/user = usr)
	var/mob/living/carbon/spirit/capturedsoul = null
	var/list/souloptions = list()
	var/list/itemstorestore = list()
	for(var/mob/living/carbon/spirit/S in GLOB.spirit_list)
		if(S.being_spoken_with)
			continue
		if(!S.client)
			continue
		if(S.prevmind)
			if(S.prevmind.funeral)
				continue // being funeralized gives you pull immunity
		else // likely an admin
			continue
		souloptions += S.livingname
	if(!length(souloptions))
		to_chat(user, span_warning("No souls are available for me to commune with."))
		return
	var/pickedsoul = input(user, "Which soul should I commune with?", "Available Souls") as null|anything in souloptions
	if(!pickedsoul)
		return
	var/hasabyssal = FALSE
	if(user.has_language(/datum/language_holder/abyssal))
		hasabyssal = TRUE
	for(var/mob/living/carbon/spirit/P in GLOB.spirit_list)
		if(P.livingname == pickedsoul)
			to_chat(P, span_red("You feel yourself being pulled out of the underworld."))
			sleep(2 SECONDS)
			P.loc = user.loc
			capturedsoul = P
			P.invisibility = INVISIBILITY_OBSERVER
			for(var/obj/item/I in P.held_items) // this is big ass, will revisit later
				. |= P.dropItemToGround(I)
				if(istype(I, /obj/item/underworld/coin))
					itemstorestore |= "token"
				if(istype(I, /obj/item/flashlight/lantern/shrunken))
					itemstorestore |= "lamp"
				qdel(I)
			break
		to_chat(P, "[itemstorestore]")
	if(capturedsoul)
		if(!hasabyssal)
			user.grant_language(/datum/language_holder/abyssal)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(soulspeak_return), capturedsoul, user, itemstorestore, hasabyssal), 120 SECONDS)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(soulspeak_timer_warning), capturedsoul, user), 115 SECONDS)
		to_chat(user, "<font color='blue'>I feel a cold chill run down my spine, a presence has arrived.</font>")
		capturedsoul.being_spoken_with = TRUE
		capturedsoul.speaking_with = user
		capturedsoul.Paralyze(2 MINUTES)

/proc/soulspeak_timer_warning(mob/living/carbon/spirit/capturedsoul, mob/summoner)
	if(!QDELETED(capturedsoul) && capturedsoul.being_spoken_with && !capturedsoul.prevmind?.funeral)
		to_chat(capturedsoul, span_warning("I'm starting to be pulled away..."))
		if(!QDELETED(summoner))
			to_chat(summoner, span_warning("The soul is being pulled away..."))

/proc/soulspeak_return(mob/living/carbon/spirit/capturedsoul, mob/summoner, list/itemstorestore, hasabyssal)
	if(!QDELETED(summoner) && !hasabyssal)
		summoner.remove_language(/datum/language_holder/abyssal)
	if(!QDELETED(capturedsoul) && capturedsoul.being_spoken_with && !capturedsoul.prevmind?.funeral) // pacify_corpse has its own stuff to teleport & unparalyze the spirit
		to_chat(summoner, "The soul returns to the underworld.")
		to_chat(capturedsoul, "You return to the underworld.")
		for(var/obj/effect/landmark/underworld/A in GLOB.landmarks_list)
			capturedsoul.loc = A.loc
			capturedsoul.invisibility = initial(capturedsoul.invisibility)
			capturedsoul.SetParalyzed(0)
			capturedsoul.being_spoken_with = FALSE
			capturedsoul.speaking_with = null
			capturedsoul.set_resting(FALSE)
			for(var/I in itemstorestore)
				if(I == "token")
					var/obj/item/underworld/coin/C = new
					capturedsoul.put_in_hands(C)
				if(I == "lamp")
					var/obj/item/flashlight/lantern/shrunken/L = new
					capturedsoul.put_in_hands(L)
