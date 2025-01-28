/mob/living/simple_animal/hostile/retaliate/rogue/leylinelycan
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "Leyline Lycan"
	desc = "A creature made of leyline energy. It is highly territorial and guards it's home leyline jealously."
	icon_state = "leycreature"
	icon_living = "leycreature"
	icon_dead = "leycreature"

	faction = list("leyline")
	emote_hear = null
	emote_see = null
	turns_per_move = 8
	see_in_dark = 9
	move_to_delay = 1
	vision_range = 9
	aggro_vision_range = 9

	butcher_results = list()

	health = 120
	maxHealth = 120
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat,
					/obj/item/bodypart,
					/obj/item/organ)

	base_intents = list(/datum/intent/simple/bite)
	attack_sound = list('sound/vo/mobs/vw/attack (1).ogg','sound/vo/mobs/vw/attack (2).ogg','sound/vo/mobs/vw/attack (3).ogg','sound/vo/mobs/vw/attack (4).ogg')
	melee_damage_lower = 15
	melee_damage_upper = 20

	STACON = 7
	STASTR = 7
	STASPD = 15

	simple_detect_bonus = 20
	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	defprob = 35
	defdrain = 5
	retreat_health = 0.4
	food = 0
	dodgetime = 17
	aggressive = 1
	remains_type = /obj/effect/decal/remains/wolf
	body_eater = FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/leylinelycan/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/rogue/leylinelycan/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	update_icon()