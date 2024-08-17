/mob/living/simple_animal/hostile/rogue/ghost/cursed
	name = "cursed soul"
	desc = ""
	icon = 'modular_hearthstone/icons/mob/wraiths.dmi'
	icon_state = "cursed"
	icon_living = "cursed"
	icon_dead = null
	mob_biotypes = MOB_UNDEAD|MOB_SPIRIT
	movement_type = FLYING
	incorporeal_move = INCORPOREAL_MOVE_JAUNT
	layer = GHOST_LAYER
	environment_smash = ENVIRONMENT_SMASH_NONE
	pass_flags = PASSTABLE|PASSGRILLE
	base_intents = list(/datum/intent/simple/claw/skeleton_unarmed)
/*	emote_see = list("floats hauntingly","weeps mourningly", "laments vengefully")*/
	gender = FEMALE
	speak_chance = 100
	turns_per_move = 2
	response_help_continuous = "passes through"
	response_help_simple = "pass through"
	dodging = TRUE
	dodge_prob = 10
	maxHealth = 200
	health = 200
	layer = 16
	plane = 16
	spacewalk = TRUE
	stat_attack = UNCONSCIOUS
	robust_searching = 1
	speed = -5
	move_to_delay = 2 //delay for the automated movement.
	harm_intent_damage = 1
	obj_damage = 1
	melee_damage_lower = 15
	melee_damage_upper = 25
	attack_same = FALSE
	attack_sound = 'sound/combat/wooshes/bladed/wooshmed (1).ogg'
	dodge_sound = 'sound/combat/dodge.ogg'
	parry_sound = "bladedmedium"
	d_intent = INTENT_DODGE
	speak_emote = list("laments", "cries", "whimpers")
	del_on_death = TRUE
	STALUC = 20
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	loot = list(/obj/item/soul_fragment)
	minbodytemp = 0
	faction = list("undead")
	footstep_type = null
	defprob = 20 //decently skilled
	defdrain = 20
	dodgetime = 10
	canparry = TRUE
	retreat_health = null

/mob/living/simple_animal/hostile/rogue/ghost/cursed/cursed2
	icon_state = "cursed2"
	icon_living = "cursed2"

/mob/living/simple_animal/hostile/rogue/ghost/cursed/get_sound(input)
	switch(input)
		if("laugh")
			return pick('sound/vo/mobs/ghost/laugh (1).ogg','sound/vo/mobs/ghost/laugh (2).ogg','sound/vo/mobs/ghost/laugh (3).ogg','sound/vo/mobs/ghost/laugh (4).ogg','sound/vo/mobs/ghost/laugh (5).ogg','sound/vo/mobs/ghost/laugh (6).ogg')
		if("moan")
			return pick('sound/vo/mobs/ghost/moan (1).ogg','sound/vo/mobs/ghost/laugh (2).ogg','sound/vo/mobs/ghost/laugh (3).ogg')
		if("death")
			return 'sound/vo/mobs/ghost/death.ogg'
		if("whisper")
			return pick('sound/vo/mobs/ghost/whisper (1).ogg','sound/vo/mobs/ghost/whisper (2).ogg','sound/vo/mobs/ghost/whisper (3).ogg')
		if("aggro")
			return pick('sound/vo/mobs/ghost/aggro (1).ogg','sound/vo/mobs/ghost/aggro (2).ogg','sound/vo/mobs/ghost/aggro (3).ogg','sound/vo/mobs/ghost/aggro (4).ogg','sound/vo/mobs/ghost/aggro (5).ogg','sound/vo/mobs/ghost/aggro (6).ogg')

/mob/living/simple_animal/hostile/rogue/ghost/cursed/AttackingTarget()
	. = ..()
	emote("aggro")
	if(. && prob(8) && iscarbon(target))
		var/mob/living/carbon/C = target
		C.Immobilize(50)
		C.visible_message(span_danger("\The [src] paralyzes \the [C] in fear!"), \
				span_danger("\The [src] paralyzes me!"))
		emote("laugh")


/mob/living/simple_animal/hostile/rogue/ghost/cursed/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	return FALSE

/mob/living/simple_animal/hostile/rogue/ghost/cursed/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "head"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "head"
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
			return "tail"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "tail"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "body"
		if(BODY_ZONE_PRECISE_GROIN)
			return "body"
		if(BODY_ZONE_PRECISE_R_INHAND)
			return "body"
		if(BODY_ZONE_PRECISE_L_INHAND)
			return "body"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "tail"
		if(BODY_ZONE_L_LEG)
			return "tail"
		if(BODY_ZONE_R_ARM)
			return "arm"
		if(BODY_ZONE_L_ARM)
			return "arm"
		if(BODY_ZONE_CHEST)
			return "chest"

	return ..()

/mob/living/simple_animal/hostile/rogue/ghost/cursed/death(gibbed)
	emote("death")
	..()

/mob/living/simple_animal/hostile/rogue/ghost/cursed/Life()
	. = ..()
	if(!target)
		if(prob(90))
			emote(pick("moan", "whisper"), TRUE)


/mob/living/simple_animal/hostile/rogue/ghost/cursed/taunted(mob/user)
	emote("aggro")
	GiveTarget(user)
	return

