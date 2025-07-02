/mob/living/simple_animal/hostile/retaliate/rogue/spider
	icon = 'icons/roguetown/mob/monster/spider.dmi'
	name = "spider"
	desc = "Swamp-lurking creachers with a wicked bite."
	icon_state = "spider"
	icon_living = "spider"
	icon_dead = "spider-dead"

	faction = list("bugs", "spiders")
	turns_per_move = 4
	move_to_delay = 2
	vision_range = 5
	aggro_vision_range = 9
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE

	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/spider = 1,
							/obj/item/reagent_containers/food/snacks/rogue/honey = 1,
							/obj/item/natural/silk = 2)

	health = SPIDER_HEALTH
	maxHealth = SPIDER_HEALTH
	food_type = list(/obj/item/bodypart,
					/obj/item/organ,
					/obj/item/reagent_containers/food/snacks/rogue/meat)

	base_intents = list(/datum/intent/simple/bite)
	attack_sound = list('sound/vo/mobs/spider/attack (1).ogg','sound/vo/mobs/spider/attack (2).ogg','sound/vo/mobs/spider/attack (3).ogg','sound/vo/mobs/spider/attack (4).ogg')
	melee_damage_lower = 20
	melee_damage_upper = 25

	STACON = 6
	STASTR = 9
	STASPD = 10

	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	attack_same = FALSE
	retreat_health = 0.2

	aggressive = TRUE
	stat_attack = UNCONSCIOUS
	body_eater = TRUE
/*										///Disables new AI for spiders till we can have them able to respect being friendly to player and tameable.
	ai_controller = /datum/ai_controller/spider
	AIStatus = AI_OFF
	can_have_ai = FALSE
*/

	language_known = list(/datum/language/beast)
	language_not_known = list(/datum/language/common)

/mob/living/simple_animal/hostile/retaliate/rogue/spider/mutated
	icon = 'icons/roguetown/mob/monster/spider.dmi'
	name = "skallax spider"
	icon_state = "skallax"
	icon_living = "skallax"
	icon_dead = "skallax-dead"

	health = SPIDER_HEALTH+10
	maxHealth = SPIDER_HEALTH+10

	base_intents = list(/datum/intent/simple/bite)

/mob/living/simple_animal/hostile/retaliate/rogue/spider/druid
	icon = 'icons/roguetown/mob/monster/spider.dmi'
	name = "tamed honey spider"
	desc = "Swamp-lurking creachers with a wicked bite."
	icon_state = "honeys"
	icon_living = "honeys"
	icon_dead = "honeys-dead"

	faction = list("bugs", "Station")
	aggressive = FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/spider/Initialize()
	. = ..()
	gender = MALE
	if(prob(33))
		gender = FEMALE
	update_icon()
/*
	AddElement(/datum/element/ai_flee_while_injured, 0.75, retreat_health)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, food_type)*/
	ADD_TRAIT(src, TRAIT_WEBWALK, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/spider/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(L.reagents)
			L.reagents.add_reagent(/datum/reagent/toxin/venom, 1)

/mob/living/simple_animal/hostile/retaliate/rogue/spider/find_food()
	. = ..()
	if(!.)
		return eat_bodies()

/mob/living/simple_animal/hostile/retaliate/rogue/spider/death(gibbed)
	..()
	update_icon()


/mob/living/simple_animal/hostile/retaliate/rogue/spider/update_icon()
	cut_overlays()
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/spider/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/spider/aggro (1).ogg','sound/vo/mobs/spider/aggro (2).ogg','sound/vo/mobs/spider/aggro (3).ogg')
		if("pain")
			return pick('sound/vo/mobs/spider/pain.ogg')
		if("death")
			return pick('sound/vo/mobs/spider/death.ogg')
		if("idle")
			return pick('sound/vo/mobs/spider/idle (1).ogg','sound/vo/mobs/spider/idle (2).ogg','sound/vo/mobs/spider/idle (3).ogg','sound/vo/mobs/spider/idle (4).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/spider/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/spider/Life()
	..()
	if(stat == CONSCIOUS)
		if(!target)
			if(production >= 100)
				production = 0
				visible_message(span_alertalien("[src] creates some honey."))
				var/turf/T = get_turf(src)
				playsound(T, pick('sound/vo/mobs/spider/speak (1).ogg','sound/vo/mobs/spider/speak (2).ogg','sound/vo/mobs/spider/speak (3).ogg','sound/vo/mobs/spider/speak (4).ogg'), 100, TRUE, -1)
				new /obj/item/reagent_containers/food/snacks/rogue/honey(T)
	if(pulledby && !tame)
		if(HAS_TRAIT(pulledby, TRAIT_WEBWALK))
			return
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/spider/simple_limb_hit(zone)
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
			return "stomach"
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

