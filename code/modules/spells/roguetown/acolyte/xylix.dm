/obj/effect/proc_holder/spell/invoked/mockery
	name = "Vicious Mockery"
	releasedrain = 50
	associated_skill = /datum/skill/misc/music
	charge_max = 10 MINUTES
	range = 7

/obj/effect/proc_holder/spell/invoked/mockery/cast(list/targets, mob/living/user)
	playsound(get_turf(user), 'sound/magic/mockery.ogg', 40, FALSE)
	for(var/mob/living/listener in hearers(7))
		if(listener.can_hear()) // Vicious mockery requires people to be able to hear you.
			listener.apply_status_effect(/datum/status_effect/debuff/viciousmockery)
		else
			return // No debuff for good guys

/obj/effect/proc_holder/spell/invoked/mockery/invocation(mob/user = usr)
	if(ishuman(user))
		var/mob/living/carbon/human/B = user
			switch(pick(1,2,3,4,5))
				if(1)
					user.say("Your mother was a Rous, and your father smelled of jacksberries!", forced = "spell")
				if(2)
					user.say("What are you going to do for a face when the monkey wants his arse back?!", forced = "spell")
				if(3)
					user.say("Wandought thine blades stand, much like thine loving parts!", forced = "spell")
				if(4)
					user.say("That's a face not even Eora could love!", forced = "spell")
				if(5)
					user.say("I shall ne'er desist from thee, nor shall I ever disappoint thee much.", forced = "spell")

/datum/status_effect/debuff/viciousmockery
	id = "viciousmockery"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/viciousmockery
	duration = 600 // One minute
	effectedstats = list("strength" = -2, "speed" = -2,"endurance" = -2)

/atom/movable/screen/alert/status_effect/debuff/viciousmockery
	name = "Vicious Mockery"
	desc = "<span class='warning'>THAT SPOONY BARD! ARGH!</span>\n"
	icon_state = "muscles"
