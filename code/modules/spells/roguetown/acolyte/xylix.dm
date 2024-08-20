// Xylixan
/obj/effect/proc_holder/spell/invoked/Joy_takes_flight
	name = "Joy takes flight"
	overlay_state = "Joy Takes Flight"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 0
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/webspin.ogg'
	invocation = "My trick is done, I'll speed from sight! I'll move so fast that joy takes flight!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 5 SECONDS
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/Joy_takes_flight/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.apply_status_effect(/datum/status_effect/buff/Speedy)
		target.visible_message("<span class='info'>The feet of [target] begin to glow gold!</span>", "<span class='notice'>I feel much faster.</span>")
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/Laughing_god
	name = "Laughing god"
	desc = ""
	overlay_state = "Laughing God"
	releasedrain = 30
	chargedrain = 0
	chargetime = 5
	range = 5
	warnie = "sydwarning"
	movement_interrupt = FALSE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/webspin.ogg'
	invocation = "The Trickster skirts the edges of the rule, whilst witless louts are made to act the fool!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/Laughing_god/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		if(prob(75))
			var/mob/living/target = targets[1]
			var/giggle_to_public = pick("[target] giggles!", "[target] struggles to not chuckle!", "[target] starts to laugh!", "[target] frowns, as if they don't get the joke")
			var/giggle_to_target = pick("That is so funny!", "You start to giggle!", "Your mouth turns upwards in a smile!", "What a horrible thing to say...")
			target.visible_message(span_warning("[giggle_to_public]"), span_warning("[giggle_to_target]"))
			target.Stun(10)
			target.Jitter(rand(5))
			if(prob(66))
				target.emote(pick("giggle","laugh","chuckle"))
		else 
			user.Stun(40) 
			user.visible_message(span_userdanger("Looks like I am the fool..."))


/obj/effect/proc_holder/spell/invoked/Smokebomb
	name = "Smoke Bomb"
	overlay_state = "Smoke Bomb"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	charge_max = 30 SECONDS
	range = 0
	warnie = "sydwarning"
	movement_interrupt = FALSE
	invocation = "The Trickster is a clever chap, it's time to hide under his cap!"
	invocation_type = "whisper"
	sound = 'sound/misc/area.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	miracle = TRUE
	devotion_cost = 40

/obj/effect/proc_holder/spell/invoked/Smokebomb/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message(span_warning("[target] vanishes in a puff of smoke!"), span_notice("You vanish in a puff of smoke!"))
		animate(target, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
		target.mob_timers[MT_INVISIBILITY] = world.time + 20 SECONDS
		addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 20 SECONDS)
		addtimer(CALLBACK(target, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[target] fades back into view."), span_notice("You become visible again.")), 20 SECONDS)
	return FALSE
