
/mob/living/simple_animal/hostile/retaliate/rogue/minotaur
	icon = 'icons/mob/newminotaur.dmi'
	name = "Minotaur"
	icon_state = "MinotaurMale"
	icon_living = "MinotaurMale"
	icon_dead = "MinotaurMale_dead"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 2
	see_in_dark = 10
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/minotaur_unarmed)

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 5, 
						/obj/item/natural/fur = 2)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 7,
						/obj/item/natural/hide = 5,
						/obj/item/natural/fur = 2)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 10,
						/obj/item/natural/hide = 7,
						/obj/item/natural/fur = 3)

	faction = list("caves")
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
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 19
	STASTR = 16
	STASPD = 5
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	retreat_health = 0
	food = 0
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')
	dodgetime = 0
	aggressive = 1
	
	ai_controller = /datum/ai_controller/minotaur
	AIStatus = AI_OFF
	can_have_ai = FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_BASHDOORS, TRAIT_GENERIC)

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
	defprob = 20
	defdrain = 15
	del_on_deaggro = 99 SECONDS
	retreat_health = 0
	food = 0
	dodgetime = 20
	aggressive = TRUE
	
	ai_controller = /datum/ai_controller/minotaur
	AIStatus = AI_OFF
	can_have_ai = FALSE


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

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/female
	icon_state = "MinotaurFem"
	icon_living = "MinotaurFem"
	icon_dead = "MinotaurFem_dead"

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/axe
	icon_state = "MinotaurMale_Axe"
	icon_living = "MinotaurMale_Axe"
	icon_dead = "MinotaurMale_dead"
	base_intents = list(/datum/intent/simple/minotaur_axe)
	melee_damage_lower = 65
	melee_damage_upper = 85

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/axe/female
	icon_state = "MinotaurFem_Axe"
	icon_living = "MinotaurFem_Axe"
	icon_dead = "MinotaurFem_dead"

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

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/minotaur/minoroar.ogg','sound/vo/mobs/minotaur/minoroar2.ogg','sound/vo/mobs/minotaur/minoroar3.ogg','sound/vo/mobs/minotaur/minoroar4.ogg')
		if("pain")
			return pick('sound/vo/mobs/minotaur/minopain.ogg', 'sound/vo/mobs/minotaur/minopain2.ogg')
		if("death")
			return pick('sound/vo/mobs/minotaur/minodie.ogg', 'sound/vo/mobs/minotaur/minodie2.ogg')
		if("idle")
			return pick('sound/vo/mobs/minotaur/minoidle.ogg', 'sound/vo/mobs/minotaur/minoidle2.ogg')


/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/simple_limb_hit(zone)
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

/datum/intent/simple/minotaur_unarmed
	name = "minotaur unarmed"
	icon_state = "instrike"
	attack_verb = list("punches", "strikes", "kicks", "steps on", "crushes", "bites")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 5
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE

/datum/intent/simple/minotaur_axe
	name = "minotaur axe"
	icon_state = "instrike"
	attack_verb = list("hacks at", "slashes", "chops", "steps on", "crushes", "bites")
	animname = "blank22"
	blade_class = BCLASS_CHOP
	hitsound = "genchop"
	chargetime = 20
	penfactor = 5
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE
