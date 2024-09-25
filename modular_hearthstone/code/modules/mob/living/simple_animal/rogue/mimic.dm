/mob/living/simple_animal/hostile/rogue/mimic
	icon = 'modular_hearthstone/icons/mob/mimic.dmi'
	name = "Mimic"
	icon_state = "mimic"
	icon_living = "mimic"
	icon_dead = null
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 1
	see_in_dark = 10
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/mimic)
	faction = list("undead")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 200
	maxHealth = 200
	melee_damage_lower = 35
	melee_damage_upper = 45
	vision_range = 3
	aggro_vision_range = 8
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	obj_damage = 1
	retreat_distance = 0
	minimum_distance = 0
	footstep_type = FOOTSTEP_HARD_CLAW
	STACON = 12
	STASTR = 5
	STASPD = 15
	defprob = 40
	defdrain = 10
	retreat_health = 0
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')
	loot = list(/obj/item/organ/eyes/mimic, /obj/item/organ/tongue/mimic, /obj/effect/gibspawner/human/bodypartless, /obj/structure/closet/crate/chest/reward)
	dodgetime = 0
//	stat_attack = UNCONSCIOUS
	patron = /datum/patron/inhumen/zizo		//So they can be hurt by holy fire/healing


/obj/item/organ/eyes/mimic
	icon = 'modular_hearthstone/icons/mob/mimic_drop.dmi'
	icon_state = "mimic's eye"
	desc = "A meaty bloodshot eye of a mimic."

/obj/item/organ/tongue/mimic
	icon = 'modular_hearthstone/icons/mob/mimic_drop.dmi'
	icon_state = "mimic's tongue"
	desc = "The long and slithery tongue of a mimic."

/mob/living/simple_animal/hostile/rogue/mimic/death(gibbed)
	emote("death")
	..()

/mob/living/simple_animal/hostile/rogue/mimic/taunted(mob/user)
	emote("aggro")
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/rogue/mimic/Life()
	..()
	if(pulledby)
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/rogue/mimic/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/mimic/mimic_attack.ogg','sound/vo/mobs/mimic/mimic_attack2.ogg','sound/vo/mobs/mimic/mimic_attack3.ogg')
		if("death")
			return pick('sound/vo/mobs/mimic/mimic_death.ogg')
		if("idle")
			return pick('sound/vo/mobs/mimic/mimic_idle.ogg', 'sound/vo/mobs/mimic/mimic_idle2.ogg')


/mob/living/simple_animal/hostile/rogue/mimic/simple_limb_hit(zone)
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

/mob/living/simple_animal/hostile/rogue/mimic/AttackingTarget()
	. = ..()
	emote("aggro")
	if(. && prob(60) && iscarbon(target))
		var/mob/living/carbon/C = target
		C.Immobilize(50)
		C.visible_message(span_danger("\The [src] grips onto \the [C]"), \
				span_danger("\The [src] grips onto me!"))
		emote("aggro")



/datum/intent/simple/mimic
	name = "mimic"
	icon_state = "instrike"
	attack_verb = list("lacerates", "bites", "claws", "slashes")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "genchop"
	chargetime = 20
	penfactor = 10
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE
	item_d_type = "stab"
