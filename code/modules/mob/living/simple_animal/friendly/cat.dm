//Cat
/mob/living/simple_animal/pet/cat
	name = "cat"
	desc = "A nuisance and a valued, pest-killing companion. Also symbols of the benevolent side of Saint Pestra for their enmity with vermin."
	icon = 'icons/mob/pets.dmi'
	icon_state = "cat2"
	icon_living = "cat2"
	icon_dead = "cat2_dead"
	gender = MALE
	speak = list("Meow!", "Esp!", "Purr!", "HSSSSS")
	speak_emote = list("purrs", "meows")
	emote_hear = list("meows.", "mews.")
	emote_see = list("shakes its head.", "shivers.")
	speak_chance = 1	
	turns_per_move = 5
	see_in_dark = 6
	ventcrawler = VENTCRAWLER_ALWAYS
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	density = FALSE // moveblocking cat is annoying as hell
	pass_flags = PASSMOB
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	minbodytemp = 200
	maxbodytemp = 400
	unsuitable_atmos_damage = 1
	animal_species = /mob/living/simple_animal/pet/cat
	childtype = list(/mob/living/simple_animal/pet/cat/kitten)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 1, /obj/item/organ/ears/cat = 1, /obj/item/organ/tail/cat = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	gold_core_spawnable = FRIENDLY_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW

	var/hates_vampires = TRUE

/mob/living/simple_animal/pet/cat/Initialize()
	. = ..()
	verbs += /mob/living/proc/lay_down

/mob/living/simple_animal/pet/cat/update_mobility()
	..()
	if(client && stat != DEAD)
		if (resting)
			icon_state = "[icon_living]_rest"
		else
			icon_state = "[icon_living]"
	regenerate_icons()


/mob/living/simple_animal/pet/cat/Crossed(mob/living/L) // Gato Basado - makes it leave when people step too close
	. = ..()
	if(L)
		if(health > 1)
			icon_state = "[icon_living]"
			set_resting(FALSE)
			update_mobility()
			if(isturf(loc))
				dir = pick(GLOB.cardinals)
				step(src, dir)
			if(!stat && resting && !buckled)
				return

/mob/living/simple_animal/proc/personal_space()
	if(locate(/mob/living/carbon) in get_turf(src))
		sleep(1)
		dir = pick(GLOB.alldirs)
		step(src, dir)
		personal_space()
	else
		return

/mob/living/simple_animal/pet/cat/black
	name = "black cat"
	desc = "Possessed of lamplike eyes and a meow that sounds like the rattle of bones. Black cats are sacred to Necra, said to bring wandering spirits to the Carriageman."
	gender = FEMALE
	icon = 'icons/roguetown/topadd/takyon/Cat.dmi'
	icon_state = "cat"
	icon_living = "cat"
	icon_dead = "cat_dead"
	hates_vampires = FALSE

/mob/living/simple_animal/pet/cat/original
	name = "Batsy"
	desc = ""
	gender = FEMALE
	icon_state = "original"
	icon_living = "original"
	icon_dead = "original_dead"
	unique_pet = TRUE

/mob/living/simple_animal/pet/cat/kitten
	name = "kitten"
	desc = ""
	icon_state = "kitten"
	icon_living = "kitten"
	icon_dead = "kitten_dead"
	density = FALSE
	pass_flags = PASSMOB
	mob_size = MOB_SIZE_SMALL

/mob/living/simple_animal/pet/cat/Proc
	name = "Proc"
	gender = MALE
	gold_core_spawnable = NO_SPAWN
	unique_pet = TRUE

/mob/living/simple_animal/pet/cat/Life()
	if(!stat && !buckled && !client)
		if(prob(1))
			emote("me", 1, pick("stretches out for a belly rub.", "wags its tail.", "lies down."))
			icon_state = "[icon_living]_rest"
			set_resting(TRUE)
		else if (prob(1))
			emote("me", 1, pick("sits down.", "crouches on its hind legs.", "looks alert."))
			icon_state = "[icon_living]_sit"
			set_resting(TRUE)
		else if (prob(2))
			if (resting)
				emote("me", 1, pick("gets up and meows.", "walks around.", "stops resting."))
				icon_state = "[icon_living]"
				set_resting(FALSE)
			else
				emote("me", 1, pick("grooms its fur.", "twitches its whiskers.", "shakes out its coat."))
	..()

	make_babies()

/mob/living/simple_animal/pet/cat/Life()
	..()
	// Catches rats too when not too lazy
	if((src.loc) && isturf(src.loc))
		if(!resting && !buckled && stat != DEAD)
			for(var/mob/living/simple_animal/mouse/M in view(1,src))
				if(Adjacent(M))
					if(M.stat != DEAD)
						walk_towards(src, M, 1)
						sleep(3)
						visible_message(span_notice("\The [src] eats the rat!"))
						M.death(gibbed = FALSE)
						stop_automated_movement = 0
						break

/mob/living/simple_animal/pet/cat/attack_hand(mob/living/carbon/human/M)
	. = ..()
	switch(M.used_intent.type)
		if(INTENT_HELP)
			wuv(1, M)
		if(INTENT_HARM)
			wuv(-1, M)

/mob/living/simple_animal/pet/cat/proc/wuv(change, mob/M)
	if(change)
		if(change > 0)
			if(M && stat != DEAD)
				new /obj/effect/temp_visual/heart(loc)
				emote("me", 1, "purrs!")
				if(flags_1 & HOLOGRAM_1)
					return
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, src, /datum/mood_event/pet_animal, src)
		else
			if(M && stat != DEAD)
				emote("me", 1, "hisses!")

/mob/living/simple_animal/pet/cat/attack_hand(mob/living/carbon/human/M)
	. = ..()
	if(stat != DEAD)
		if(hates_vampires && M.mind && M.mind.has_antag_datum(/datum/antagonist/vampirelord)) // Cats always hiss at vampires
			visible_message(span_notice("\The [src] hisses at [M] and recoils in disgust."))
			icon_state = "[icon_living]"
			set_resting(FALSE)
			update_mobility()
			dir = pick(GLOB.alldirs)
			step(src, dir)
			personal_space()
