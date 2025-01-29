/mob/living/simple_animal/hostile/retaliate/rogue/elemental/Initialize()
	. = ..()
/mob/living/simple_animal/hostile/retaliate/rogue/elemental/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/elemental/simple_limb_hit(zone)
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


/mob/living/simple_animal/hostile/retaliate/rogue/elemental/crawler
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "earthen crawler"
	icon_state = "crawler"
	icon_living = "crawler"
	icon_dead = "vvd"
	gender = MALE
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 3
	base_intents = list(/datum/intent/unarmed/claw)
	butcher_results = list()
	faction = list("elemental")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 120
	maxHealth = 120
	ranged = TRUE
	projectiletype = /obj/projectile/magic/firebolt
	melee_damage_lower = 15
	melee_damage_upper = 17
	vision_range = 8
	aggro_vision_range = 11
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 20
	retreat_distance = 6
	minimum_distance = 5
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 13
	STAEND = 13
	STASTR = 8
	STASPD = 8
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = 'sound/combat/hits/onstone/wallhit.ogg'
	attack_verb_continuous = "pounds"
	attack_verb_simple = "pounds"
	dodgetime = 0
	aggressive = 1


/mob/living/simple_animal/hostile/retaliate/rogue/elemental/crawler/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/rogue/elemental/crawler/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	update_icon()
	sleep(1)
	qdel(src)

/mob/living/simple_animal/hostile/retaliate/rogue/elemental/warden
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "earthen Warden"
	icon_state = "warden"
	icon_living = "warden"
	icon_dead = "vvd"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list()
	faction = list("infernal")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 240
	maxHealth = 240
	melee_damage_lower = 15
	melee_damage_upper = 17
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 20
	retreat_distance = 0
	minimum_distance = 0
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 15
	STAEND = 15
	STASTR = 10
	STASPD = 6
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = list('sound/vo/mobs/vw/attack (1).ogg','sound/vo/mobs/vw/attack (2).ogg','sound/vo/mobs/vw/attack (3).ogg','sound/vo/mobs/vw/attack (4).ogg')
	dodgetime = 30
	aggressive = 1
//	stat_attack = UNCONSCIOUS

/mob/living/simple_animal/hostile/retaliate/rogue/elemental/warden/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/rogue/elemental/warden/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/elementalshard(deathspot)
	new /obj/item/natural/elementalshard(deathspot)
	update_icon()
	qdel(src)

/mob/living/simple_animal/hostile/retaliate/rogue/elemental/warden/AttackingTarget()
	if(SEND_SIGNAL(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, target) & COMPONENT_HOSTILE_NO_PREATTACK)
		return FALSE //but more importantly return before attack_animal called
	SEND_SIGNAL(src, COMSIG_HOSTILE_ATTACKINGTARGET, target)
	in_melee = TRUE
	if(!target)
		return
	addtimer(CALLBACK(src,PROC_REF(yeet)), 1 SECONDS)
	return target.attack_animal(src)

/mob/living/simple_animal/hostile/retaliate/rogue/elemental/warden/proc/yeet(target)
	var/atom/throw_target = get_edge_target_turf(src, get_dir(src, target)) //ill be real I got no idea why this worked.
	if(isliving(target))
		var/mob/living/L = target
		L.throw_at(throw_target, 7, 4)
		L.adjustBruteLoss(30)
