/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/red/Initialize()
	. = ..()
	REMOVE_TRAIT(src, TRAIT_ANTIMAGIC, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/red	//subtype for dragon-kobold event, requested by Mario
	name = "red dragon"
	desc = "An ancient creature from a bygone age. Now would be a good time to run."
	health = 2500
	maxHealth = 2500
	attack_verb_continuous = "gouges"
	attack_verb_simple = "gouge"
	attack_sound = 'sound/misc/demon_attack1.ogg'
	icon = 'modular/icons/mob/96x96/ratwood_dragon.dmi'
	icon_state = "dragon_red"
	icon_living = "dragon_red"
	icon_dead = "dragon_red_dead_redemption"
	speak_emote = list("roars")
	emote_hear = null
	emote_see = null
	base_intents = list(/datum/intent/unarmed/dragonclaw)
	faction = list("kobold")
	melee_damage_lower = 40
	melee_damage_upper = 40
	retreat_distance = 0
	minimum_distance = 0
	STASTR = 20
	aggressive = 1
	speed = 5
	move_to_delay = 7
	ranged = TRUE
	pixel_x = -32
	pixel_y = -32
	deathmessage = "collapses to the floor with a final roar, the impact rocking the ground."
	footstep_type = FOOTSTEP_MOB_HEAVY
