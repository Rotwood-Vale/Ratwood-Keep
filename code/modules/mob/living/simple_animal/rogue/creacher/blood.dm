/mob/living/simple_animal/hostile/retaliate/rogue/blood
	name = "FLESH HOMUNCULUS"
	desc = null
	hud_type = /datum/hud/human
	icon_state = "FLESH"
	icon_living = "FLESH"
	icon = 'icons/mob/mob.dmi'
	mob_biotypes = MOB_EPIC
	footstep_type = FOOTSTEP_MOB_HEAVY
	vision_range = 6
	aggro_vision_range = 6
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	retreat_distance = 0
	minimum_distance = 0

	health = 900
	maxHealth = 900
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat,
					/obj/item/bodypart,
					/obj/item/organ)

	base_intents = list(/datum/intent/unarmed/claw)
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')
	melee_damage_lower = 40
	melee_damage_upper = 60
	STACON = 15
	STASTR = 16
	STASPD = 2
	STAEND = 16
	deaggroprob = 0
	simpmob_attack = 25
	simpmob_defend = 20
	defdrain = 15
	del_on_deaggro = 99 SECONDS
	retreat_health = 0
	food = 0
	dodgetime = 20
	aggressive = TRUE
//	stat_attack = UNCONSCIOUS


/mob/living/simple_animal/hostile/retaliate/rogue/blood/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_BLOODLOSS_IMMUNE, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/blood/ascended
	name = "???"
	desc = ""
	hud_type = /datum/hud/human
	icon_state = "ascend"
	icon_living = "ascend"
	icon = 'icons/mob/32x64.dmi'
	move_to_delay = 0
	base_intents = list(/datum/intent/unarmed/ascendedclaw)
	melee_damage_lower = 250
	melee_damage_upper = 550
	health = 666666
	maxHealth = 666666
	STACON = 66
	STASTR = 66
	STASPD = 66
	STAEND = 66

/mob/living/simple_animal/hostile/retaliate/rogue/blood/ascended/examine(mob/user)
	. = ..()
	. += "<span class='narsiesmall'>It is impossible to comprehend such a thing.</span>"

/mob/living/simple_animal/hostile/retaliate/rogue/blood/ascended/Initialize()
	. = ..()
	set_light(5,5, LIGHT_COLOR_RED)
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_BLOODLOSS_IMMUNE, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/blood/ascended/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/misc/HL (1).ogg','sound/misc/HL (2).ogg','sound/misc/HL (3).ogg','sound/misc/HL (4).ogg','sound/misc/HL (5).ogg','sound/misc/HL (6).ogg')
		if("pain")
			return pick('sound/misc/HL (1).ogg','sound/misc/HL (2).ogg','sound/misc/HL (3).ogg','sound/misc/HL (4).ogg','sound/misc/HL (5).ogg','sound/misc/HL (6).ogg')
		if("death")
			return pick('sound/misc/HL (1).ogg','sound/misc/HL (2).ogg','sound/misc/HL (3).ogg','sound/misc/HL (4).ogg','sound/misc/HL (5).ogg','sound/misc/HL (6).ogg')
		if("idle")
			return pick('sound/misc/HL (1).ogg','sound/misc/HL (2).ogg','sound/misc/HL (3).ogg','sound/misc/HL (4).ogg','sound/misc/HL (5).ogg','sound/misc/HL (6).ogg')
		if("cidle")
			return pick('sound/misc/HL (1).ogg','sound/misc/HL (2).ogg','sound/misc/HL (3).ogg','sound/misc/HL (4).ogg','sound/misc/HL (5).ogg','sound/misc/HL (6).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/blood/death(gibbed)
	. = ..()
	gib()
	qdel(src)

/mob/living/simple_animal/hostile/retaliate/rogue/death(gibbed)
	..()
	update_icon()