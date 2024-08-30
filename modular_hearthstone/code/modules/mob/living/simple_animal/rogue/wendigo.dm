/mob/living/simple_animal/hostile/retaliate/rogue/wendigo
	icon = 'icons/roguetown/mob/monster/giantmobs.dmi'
	name = "Wendigo"
	icon_state = "wendigo_noblood"
	icon_living = "wendigo_noblood"
	icon_dead = "wendigo_dead"
	speak_emote = list("speaks")
	emote_hear = list("speaks.")
	emote_see = list("speaks.")
	gender = MALE
	emote_hear = null
	emote_see = null
	turns_per_move = 3
	see_in_dark = 10
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 13,
						/obj/item/natural/hide = 15, /obj/item/natural/bundle/bone/full = 3)
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 400
	maxHealth = 500
	melee_damage_lower = 35
	melee_damage_upper = 50
	vision_range = 6
	aggro_vision_range = 5
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 15
	STASTR = 15
	STASPD = 5
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 10 SECONDS
	retreat_health = 0
	food = 0
	attack_sound = list('sound/vo/mobs/wendigo/wendigoattack1.ogg','sound/vo/mobs/wendigo/wendigoattack2.ogg')
	dodgetime = 0
	aggressive = 1
//	stat_attack = UNCONSCIOUS

/mob/living/simple_animal/hostile/retaliate/rogue/wendigo/get_sound(input)
	switch(input)
		if("idle")
			return pick('sound/vo/mobs/wendigo/wendigoidle1.ogg','sound/vo/mobs/wendigo/wendigoidle2.ogg','sound/vo/mobs/wendigo/wendigoidle3.ogg')
		if("aggro")
			return pick('sound/vo/mobs/wendigo/wendigoaggro1.ogg','sound/vo/mobs/wendigo/wendigoaggro2.ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/wendigo/death(gibbed)
	..()
	update_icon()

/mob/living/simple_animal/hostile/retaliate/rogue/wendigo/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/wendigo/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/wendigo/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()
