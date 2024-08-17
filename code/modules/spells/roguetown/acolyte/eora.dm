//Eora content from Stonekeep

/obj/effect/proc_holder/spell/invoked/bud
	name = "Eoran Bloom"
	desc = ""
	clothes_req = FALSE
	range = 7
	overlay_state = "love"
	sound = list('sound/magic/magnet.ogg')
	req_items = list(/obj/item/clothing/neck/roguetown/psicross/eora)
	releasedrain = 40
	chargetime = 60
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/holy
	charge_max = 60 SECONDS

/obj/effect/proc_holder/spell/invoked/bud/cast(list/targets, mob/living/user)
	var/turf/T = get_turf(targets[1])
	if(!isclosedturf(T))
		new /obj/item/clothing/head/peaceflower(T)
		return TRUE
	to_chat(user, "<span class='warning'>The targeted location is blocked. The flowers of Eora refuse to grow.</span>")
	return FALSE

/obj/effect/proc_holder/spell/invoked/eoracurse
	name = "Eora's Curse"
	overlay_state = "curse2"
	releasedrain = 50
	chargetime = 30
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross/eora)
	sound = 'sound/magic/whiteflame.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	miracle = FALSE

/obj/effect/proc_holder/spell/invoked/eoracurse/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.apply_status_effect(/datum/status_effect/buff/druqks)
		target.apply_status_effect(/datum/status_effect/buff/drunk)
		target.visible_message("<span class='info'>A purple haze shrouds [target]!</span>", "<span class='notice'>I feel much calmer.</span>")
		target.blur_eyes(10)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/enrapture
	name = "Enrapture"
	desc = ""
	overlay_state = "bliss"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 5
	warnie = "sydwarning"
	movement_interrupt = FALSE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross/eora)
	sound = 'sound/magic/heal.ogg'
	invocation = "Embrace Eora's love!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	miracle = TRUE
	devotion_cost = 30

//Sex-pest spell; if you have ERP verbs on it lets you treat it as sexual stuff if opt in, otherwise spell of serenity/peace. 
/obj/effect/proc_holder/spell/invoked/enrapture/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		var/enrapture_to_public = pick("[target] muscle's visibly slacken!", "[target] appears weak!", "[target] freezes in place!", "[target]' eyes glaze over!")
		var/enrapture_to_target = pick("You feel a wave of serenity gloss over you!", "You feel.. at ease, why fight?", "You feel relaxed, your muscles soothed.. you can't move!")
		target.visible_message(span_warning("[enrapture_to_public]"), span_warning("[enrapture_to_target]"))
		target.Stun(rand(20))
		target.Jitter(20)
		target.add_stress(/datum/stressevent/enrapture)
		if(prob(33))
			target.emote(pick("twitch","shiver"))
		//LEWD PART WORKS ON NYMPOMANIACS ONLY
		if(user.has_flaw(/datum/charflaw/addiction/lovefiend))
			target.sate_addiction()
			//ONLY IF YOU HAVE ERP PANEL ON - YOU HAVE TWO OPTIONS
			if(target.client.prefs.sexable == TRUE)
				var/choice = alert(target, "Do you wish to give into bliss?", "", "Yes", "No")
				switch(choice)
					//IF YOU CHOOSE YES - YOU RECIEVE SOME PLEASURE
					if("Yes")
						target.sexcon.perform_sex_action(target, 5, 0, TRUE)
						target.visible_message(span_warning("[target] gives in to their desires!"), span_warning("I am overwhelmed by my desires!"))
						return TRUE
					if("No")
						target.visible_message(span_warning("[target] doesn't give in to their desires!"), span_warning("I won't give in!"))
						return TRUE
				return TRUE
			return TRUE
		return TRUE
	return FALSE

/datum/stressevent/enrapture
	timer = 5 MINUTES
	stressadd = -5
	desc = "<span class='green'>I felt Eora's serentity.</span>"
