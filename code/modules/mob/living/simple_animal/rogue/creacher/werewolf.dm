
/mob/living/simple_animal/hostile/retaliate/rogue/werewolf
	name = "Werewolf"
	desc = ""
	icon = 'icons/roguetown/mob/monster/werewolf.dmi'
	icon_state = "wwolf_m"
	icon_living = "wwolf_m"
	icon_dead = "wwolf_m"
	gender = MALE
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	STASTR = 20
	STAPER = 16
	STAINT = 4
	STACON = 20
	STAEND = 20
	STASPD = 16
	speak_chance = 80
	maxHealth = 800
	health = 800
	melee_damage_lower = 15
	melee_damage_upper = 45
	obj_damage = 40
	simpmob_attack = 65
	simpmob_defend = 15
	defdrain = 45
	environment_smash = ENVIRONMENT_SMASH_WALLS
	attack_sound = list('sound/vo/mobs/vw/attack (1).ogg','sound/vo/mobs/vw/attack (2).ogg','sound/vo/mobs/vw/attack (3).ogg','sound/vo/mobs/vw/attack (4).ogg')
	base_intents = list(/datum/intent/simple/wereclaw, /datum/intent/simple/werebite)
	faction = list("wolves")
	stat_attack = UNCONSCIOUS
	footstep_type = FOOTSTEP_MOB_HEAVY

/mob/living/simple_animal/hostile/retaliate/rogue/werewolf/Initialize()
	. = ..()
	gender = MALE
	if(prob(33))
		gender = FEMALE
	update_icon()
	STASTR += rand(0, 5)
	STAPER += rand(-4, 4)
	STAINT += rand(-1, 1)
	STACON += rand(-1, 4)
	STAEND += rand(-1, 3)
	STASPD += rand(-1, 5)
	regenerate_icons()
	ADD_TRAIT(src, TRAIT_SIMPLE_WOUNDS, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/werewolf/regenerate_icons()
	if(gender == MALE)
		icon_state = "wwolf_m"
	else
		icon_state = "wwolf_f"
	update_inv_hands()
	update_damage_overlays()

/mob/living/simple_animal/hostile/retaliate/rogue/werewolf/update_damage_overlays()
	remove_overlay(DAMAGE_LAYER)
	testing("dambegin")
	var/list/hands = list()
	var/mutable_appearance/inhand_overlay = mutable_appearance("[icon_state]-dam", layer=-DAMAGE_LAYER)
	var/numba = 255 * (health / maxHealth)
	inhand_overlay.alpha = 255 - numba
	testing("damalpha [inhand_overlay.alpha]")
	hands += inhand_overlay

	overlays_standing[DAMAGE_LAYER] = hands
	apply_overlay(DAMAGE_LAYER)

/mob/living/simple_animal/hostile/retaliate/rogue/werewolf/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/werewolf/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/werewolf/find_food()
	. = ..()
	if(!.)
		return eat_bodies()

/mob/living/simple_animal/hostile/retaliate/rogue/werewolf/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "eye"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "eye"
		if(BODY_ZONE_PRECISE_NOSE)
			return "snout"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "jaw"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "hand"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "hand"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "foot"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "foot"
		if(BODY_ZONE_CHEST)
			return "body"
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
			return "arm"
		if(BODY_ZONE_L_ARM)
			return "arm"
		else
			return "body"
	return ..()