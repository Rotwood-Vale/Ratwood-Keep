/obj/structure/ritualcircle
	name = "ritual circle"
	desc = ""
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "ritual_base"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/ritualcircle/attack_right(mob/living/carbon/human/user)
	user.visible_message(span_warning("[user] begins wiping away the rune"))
	if(do_after(user, 15))
		playsound(loc, 'sound/foley/cloth_wipe (1).ogg', 100, TRUE)
		qdel(src)

// This'll be our tutorial ritual for those who want to make more later, let's go into details in comments, mm? - Onutsio
/obj/structure/ritualcircle/astrata
	name = "Rune of the Sun" // defines name of the circle itself
	icon_state = "astrata_chalky" // the icon state, so, the sprite the runes use on the floor. As of making, we have 6, each needs an active/inactive state.
	desc = "A Holy Rune of Astrata" // description on examine
	var/solarrites = list("Guiding Light") // This is important - This is the var which stores every ritual option available to a ritualist - Ideally, we'd have like, 3 for each God. Right now, just 1.

/obj/structure/ritualcircle/astrata/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/astrata)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this...")) // You need ritualist to use them
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more.")) // If you have already done a ritual in the last 30 minutes, you cannot do another.
		return

	var/riteselection = input(user, "Rituals of the Sun", src) as null|anything in solarrites

	switch(riteselection)
		if("Guiding Light")
			if(do_after(user, 5 SECONDS))
				user.say("I beseech the she-form of the Twinned God!!")
				if(do_after(user, 5 SECONDS))
					user.say("To bring Order to a world bereft!!")
					if(do_after(user, 5 SECONDS))
						user.say("Place your gaze upon me, oh Radiant one!!")
						user.visible_message(span_warning("[user] bursts into flames, wholly embraced by Her Warmth!"),
							span_danger("You feel the eye of Astrata turned upon you. Her warmth dances upon your cheek. You feel yourself warming up..."))
						icon_state = "astrata_active"
						loc.visible_message(span_warning("[user] bursts to flames! Embraced by Her Warmth wholly!"))
						playsound(loc, 'sound/combat/hits/burn (1).ogg', 100, FALSE, -1)
						user.adjust_fire_stacks(10)
						user.IgniteMob()
						user.flash_fullscreen("redflash3")
						user.emote("firescream")
						guidinglight(src)
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
						spawn(12 SECONDS)
							icon_state = "astrata_chalky"

/obj/structure/ritualcircle/astrata/proc/guidinglight(src)
	for(var/mob/living/carbon/human/target in view(7, src)) // defines the target as every human in 7 tiles of the circle
		target.apply_status_effect(/datum/status_effect/buff/guidinglight) // applies the status effect
		to_chat(target,span_cultsmall("Astrata's light guides me forward, drawn to me by the Ritualist's pyre!"))
		playsound(target, 'sound/magic/holyshield.ogg', 80, FALSE, -1) // Cool sound!
// If you want to review a more complicated one, Undermaiden's Bargain is probs the most complicated of the starting set. - Have fun! - Onutsio 🏳️‍⚧️


/obj/structure/ritualcircle/noc
	name = "Rune of the Moon"
	icon_state = "noc_chalky"
	desc = "A Holy Rune of Noc"
	var/lunarrites = list("Moonlight Dance") // list for more to be added later

/obj/structure/ritualcircle/noc/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/noc)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of the Moon", src) as null|anything in lunarrites
	switch(riteselection) // put ur rite selection here
		if("Moonlight Dance")
			if(do_after(user, 5 SECONDS))
				user.say("I beseech the he-form of the Twinned God!!")
				if(do_after(user, 5 SECONDS))
					user.say("To bring Wisdom to a world of naught!!")
					if(do_after(user, 5 SECONDS))
						user.say("Place your gaze upon me, oh wise one!!")
						to_chat(user,span_cultsmall("The waning half of the Twin-God carries but one eye. With some effort, it can be drawn upon supplicants."))
						playsound(loc, 'sound/magic/holyshield.ogg', 80, FALSE, -1)
						moonlightdance(src)
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)

/obj/structure/ritualcircle/noc/proc/moonlightdance(src)
	for(var/mob/living/carbon/human/target in view(7, src))
		target.apply_status_effect(/datum/status_effect/buff/moonlightdance)

/obj/structure/ritualcircle/xylix
	name = "Rune of Trickery"
	desc = "A Holy Rune of Xylix"

/obj/structure/ritualcircle/ravox
	name = "Rune of the Warrior"
	desc = "A Holy Rune of Ravox"

/obj/structure/ritualcircle/pestra
	name = "Rune of Plague"
	desc = "A Holy Rune of Pestra"
	icon_state = "pestra_chalky"
	var/plaguerites = list("Flylord's Triage")


/obj/structure/ritualcircle/pestra/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/pestra)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Plague", src) as null|anything in plaguerites
	switch(riteselection) // put ur rite selection here
		if("Flylord's Triage")
			if(do_after(user, 5 SECONDS))
				user.say("Buboes, phlegm, blood and guts!!")
				if(do_after(user, 5 SECONDS))
					user.say("Boils, bogeys, rots and pus!!")
					if(do_after(user, 5 SECONDS))
						user.say("Blisters, fevers, weeping sores!!")
						to_chat(user,span_danger("You feel something crawling up your throat, humming and scratching..."))
						if(do_after(user, 3 SECONDS))
							icon_state = "pestra_active"
							user.say("From your wounds, the fester pours!!")
							to_chat(user,span_cultsmall("My devotion to the Plague Queen allowing, her servants crawl up from my throat. Come now, father fly..."))
							loc.visible_message(span_warning("[user] opens their mouth, disgorging a great swarm of flies!"))
							playsound(loc, 'sound/misc/fliesloop.ogg', 100, FALSE, -1)
							flylordstriage(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							spawn(12 SECONDS)
								icon_state = "pestra_chalky"

/obj/structure/ritualcircle/pestra/proc/flylordstriage(src)
	for(var/mob/living/carbon/human/target in view(0, src))
		to_chat(target,span_userdanger("You feel them crawling into your wounds and pores. Their horrific hum rings through your ears as they do their work!"))
		target.flash_fullscreen("redflash3")
		target.emote("agony")
		target.Stun(200)
		target.Knockdown(200)
		to_chat(target, span_userdanger("UNIMAGINABLE PAIN!"))
		target.apply_status_effect(/datum/status_effect/buff/flylordstriage)

/obj/structure/ritualcircle/dendor
	name = "Rune of Beasts"
	desc = "A Holy Rune of Dendor"
	icon_state = "dendor_chalky"
	var/bestialrites = list("Rite of the Lesser Wolf")

/obj/structure/ritualcircle/dendor/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/dendor)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Beasts", src) as null|anything in bestialrites
	switch(riteselection) // put ur rite selection here
		if("Rite of the Lesser Wolf")
			if(do_after(user, 5 SECONDS))
				user.say("RRRGH GRRRHHHG GRRRRRHH!!")
				playsound(loc, 'sound/vo/mobs/vw/idle (1).ogg', 100, FALSE, -1)
				if(do_after(user, 5 SECONDS))
					user.say("GRRRR GRRRRHHHH!!")
					playsound(loc, 'sound/vo/mobs/vw/idle (4).ogg', 100, FALSE, -1)
					if(do_after(user, 5 SECONDS))
						loc.visible_message(span_warning("[user] snaps and snarls at the rune. Drool runs down their lip..."))
						playsound(loc, 'sound/vo/mobs/vw/bark (1).ogg', 100, FALSE, -1)
						if(do_after(user, 3 SECONDS))
							icon_state = "dendor_active"
							loc.visible_message(span_warning("[user] snaps their head upward, they let out a howl!"))
							playsound(loc, 'sound/vo/mobs/wwolf/howl (2).ogg', 100, FALSE, -1)
							lesserwolf(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							spawn(12 SECONDS)
								icon_state = "dendor_chalky"

/obj/structure/ritualcircle/dendor/proc/lesserwolf(src)
	for(var/mob/living/carbon/human/target in view(1, src))
		target.apply_status_effect(/datum/status_effect/buff/lesserwolf)


/obj/structure/ritualcircle/malum
	name = "Rune of Forge"
	desc = "A Holy Rune of Malum"

/obj/structure/ritualcircle/abyssor
	name = "Rune of Storm"
	desc = "A Holy Rune of Abyssor"

/obj/structure/ritualcircle/necra
	name = "Rune of Death"
	desc = "A Holy Rune of Necra"
	icon_state = "necra_chalky"
	var/deathrites = list("Undermaiden's Bargain")

/obj/structure/ritualcircle/necra/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/necra)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Death", src) as null|anything in deathrites
	switch(riteselection) // put ur rite selection here
		if("Undermaiden's Bargain")
			loc.visible_message(span_warning("[user] sways before the rune, they open their mouth, though no words come out..."))
			playsound(user, 'sound/vo/mobs/ghost/whisper (3).ogg', 100, FALSE, -1)
			if(do_after(user, 6 SECONDS))
				loc.visible_message(span_warning("[user] silently weeps, yet their tears do not flow..."))
				playsound(user, 'sound/vo/mobs/ghost/whisper (1).ogg', 100, FALSE, -1)
				if(do_after(user, 6 SECONDS))
					loc.visible_message(span_warning("[user] locks up, as though someone had just grabbed them..."))
					to_chat(user,span_danger("You feel cold breath on the back of your neck..."))
					playsound(user, 'sound/vo/mobs/ghost/death.ogg', 100, FALSE, -1)
					if(do_after(user, 2 SECONDS))
						icon_state = "necra_active"
						user.say("Forgive me, the bargain is intoned!!")
						to_chat(user,span_cultsmall("My devotion to the Undermaiden has allowed me to strike a bargain for these souls...."))
						playsound(loc, 'sound/vo/mobs/ghost/moan (1).ogg', 100, FALSE, -1)
						undermaidenbargain(src)
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
						spawn(12 SECONDS)
							icon_state = "necra_chalky"

/obj/structure/ritualcircle/necra/proc/undermaidenbargain(src)
	for(var/mob/living/carbon/human/target in view(7, src))
		target.apply_status_effect(/datum/status_effect/buff/undermaidenbargain)


/obj/structure/ritualcircle/eora
	name = "Rune of Love"
	desc = "A Holy Rune of Eora"
	icon_state = "eora_chalky"

	var/peacerites = list("Rite of Pacification")

/obj/structure/ritualcircle/eora/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/eora)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Love", src) as null|anything in peacerites
	switch(riteselection) // put ur rite selection here
		if("Rite of Pacification")
			if(do_after(user, 5 SECONDS))
				user.say("#Blessed be your weary head...")
				if(do_after(user, 5 SECONDS))
					user.say("#Full of strife and pain...")
					if(do_after(user, 5 SECONDS))
						user.say("#Let Her ease your fear...")
						if(do_after(user, 5 SECONDS))
							icon_state = "eora_active"
							pacify(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							spawn(12 SECONDS)
								icon_state = "eora_chalky"

/obj/structure/ritualcircle/eora/proc/pacify(src)
	for(var/mob/living/carbon/human/target in view(0, src))
		loc.visible_message(span_warning("[target] sways like windchimes in the wind..."))
		target.visible_message(span_green("I feel the burdens of my heart lifting. Something feels very wrong... I don't mind at all..."))
		target.apply_status_effect(/datum/status_effect/buff/calmed)
