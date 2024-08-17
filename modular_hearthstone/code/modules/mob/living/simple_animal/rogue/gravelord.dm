/mob/living/simple_animal/hostile/rogue/gravelord
	icon = 'modular_hearthstone/icons/mob/gravelord.dmi'
	name = "Gravelord"
	icon_state = "glord"
	icon_living = "glord"
	icon_dead = "glord_dead"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 2
	see_in_dark = 10
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/gravelord)
	faction = list("undead")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 500
	maxHealth = 600
	melee_damage_lower = 55
	melee_damage_upper = 80
	vision_range = 3
	aggro_vision_range = 8
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	obj_damage = 1
	retreat_distance = 0
	minimum_distance = 0
	footstep_type = FOOTSTEP_MOB_HEAVY
	STACON = 19
	STASTR = 16
	STASPD = 5
	defprob = 40
	defdrain = 10
	retreat_health = 0
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')
	loot = list(/obj/item/rogueweapon/sickle/scythe, /obj/item/natural/bundle/bone/full, /obj/item/natural/bundle/bone/full,
	/obj/item/soul_fragment, /obj/item/soul_fragment, /obj/item/soul_fragment, /obj/item/soul_fragment, /obj/item/soul_fragment,
	/obj/item/soul_fragment, /obj/item/skull, /obj/item/skull, /obj/item/skull, /obj/item/skull)
	dodgetime = 0
//	stat_attack = UNCONSCIOUS


/mob/living/simple_animal/hostile/rogue/gravelord/taunted(mob/user)
	emote("aggro")
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/rogue/gravelord/Life()
	..()
	if(pulledby)
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/rogue/gravelord/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/gravelord/glord_aggro.ogg','sound/vo/mobs/gravelord/glord_aggro2.ogg','sound/vo/mobs/gravelord/glord_aggro3.ogg')
		if("death")
			return pick('sound/vo/mobs/gravelord/glord_die.ogg')
		if("idle")
			return pick('sound/vo/mobs/gravelord/glord_idle.ogg', 'sound/vo/mobs/gravelord/glord_idle2.ogg', 'sound/vo/mobs/gravelord/glord_idle3.ogg')


/mob/living/simple_animal/hostile/rogue/gravelord/simple_limb_hit(zone)
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

/datum/intent/simple/gravelord
	name = "gravelord"
	icon_state = "instrike"
	attack_verb = list("strikes", "kicks", "crushes", "slashes")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "genchop"
	chargetime = 20
	penfactor = 10
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE
	item_d_type = "stab"