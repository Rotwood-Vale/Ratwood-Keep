
/mob/living/carbon/human
	var/datum/charflaw/charflaw

/mob/proc/sate_addiction()
	return

/mob/living/carbon/human/sate_addiction()
	if(istype(charflaw, /datum/charflaw/addiction))
		var/datum/charflaw/addiction/A = charflaw
		if(!A.sated)
			to_chat(src, span_blue(A.sated_text))
		A.sated = TRUE
		A.time = initial(A.time) //reset roundstart sate offset to standard
		A.next_sate = world.time + A.time
		remove_stress(/datum/stressevent/vice)
		if(A.debuff)
			remove_status_effect(A.debuff)

/datum/charflaw/addiction
	var/next_sate = 0
	var/sated = TRUE
	var/time = 5 MINUTES
	var/debuff = /datum/status_effect/debuff/addiction
	var/needsate_text
	var/sated_text = "That's much better..."
	var/unsate_time


/datum/charflaw/addiction/New()
	..()
	time = rand(6 MINUTES, 30 MINUTES)
	next_sate = world.time + time

/datum/charflaw/addiction/flaw_on_life(mob/user)
	if(!ishuman(user))
		return
	if(user.mind.antag_datums)
		for(var/datum/antagonist/D in user.mind.antag_datums)
			if(istype(D, /datum/antagonist/vampirelord) || istype(D, /datum/antagonist/werewolf) || istype(D, /datum/antagonist/skeleton) || istype(D, /datum/antagonist/zombie))
				return
	var/mob/living/carbon/human/H = user
	var/oldsated = sated
	if(oldsated)
		if(next_sate)
			if(world.time > next_sate)
				sated = FALSE
	if(sated != oldsated)
		unsate_time = world.time
		if(needsate_text)
			to_chat(user, span_boldwarning("[needsate_text]"))
	if(!sated)
		H.add_stress(/datum/stressevent/vice)
		if(debuff)
			H.apply_status_effect(debuff)



/datum/status_effect/debuff/addiction
	id = "addiction"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction
	effectedstats = list("endurance" = -1,"fortune" = -1)
	duration = 100


/atom/movable/screen/alert/status_effect/debuff/addiction
	name = "Addiction"
	desc = ""
	icon_state = "debuff"


/// ALCOHOLIC

/datum/charflaw/addiction/alcoholic
	name = "Alcoholic"
	desc = "Drinking alcohol is my favorite thing."
	time = 40 MINUTES
	needsate_text = "Time for a drink."


/// JUNKIE

/datum/charflaw/addiction/junkie
	name = "Junkie"
	desc = "I need a REAL high to take the pain of this rotten world away."
	time = 40 MINUTES
	needsate_text = "Time to get really high."

/// Smoker

/datum/charflaw/addiction/smoker
	name = "Smoker"
	desc = "I need to smoke something to take the edge off."
	time = 40 MINUTES
	needsate_text = "Time for a flavorful smoke."

/// GOD-FEARING

/datum/charflaw/addiction/godfearing
	name = "Devout Follower"
	desc = "I need to pray to my Patron, their blessings are stronger."
	time = 40 MINUTES
	needsate_text = "Time to pray."

/datum/outfit/job/roguetown/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE) // added since the previous way it was implemented caused a bunch of runtimes
	. = ..()
	if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser) || H.mind.has_antag_datum(/datum/antagonist/vampirelord)) // dont stunlock
		return
	if(!H.wear_neck)
		var/obj/item/clothing/neck/roguetown/psicross/crosstype
		switch(H.patron?.name)
			if("Astrata")
				crosstype = /obj/item/clothing/neck/roguetown/psicross/astrata
			if("Noc")
				crosstype = /obj/item/clothing/neck/roguetown/psicross/noc
			if("Dendor")
				crosstype = /obj/item/clothing/neck/roguetown/psicross/dendor
			if("Necra")
				crosstype = /obj/item/clothing/neck/roguetown/psicross/necra
			if("Ravox")
				crosstype = /obj/item/clothing/neck/roguetown/psicross/ravox
			else
				if(prob(1))
					crosstype = /obj/item/clothing/neck/roguetown/psicross/g
				else
					crosstype = /obj/item/clothing/neck/roguetown/psicross
		H.equip_to_slot_or_del(new crosstype(H), SLOT_NECK)

/// ALCOHOLIC

/datum/charflaw/addiction/lovefiend
	name = "Love-Fiend"
	desc = "I must make love!"
	time = 50 MINUTES
	needsate_text = "Time to get happy."
