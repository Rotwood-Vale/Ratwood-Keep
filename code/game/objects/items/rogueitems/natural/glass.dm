/obj/item/natural/glass/shard
	name = "shard"
	desc = "A sharp shard of glass."
	icon = 'icons/obj/shards.dmi'
	icon_state = "large"
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/stab)
	force = 3
	throwforce = 5
	item_state = "shard-glass"
	resistance_flags = null
	w_class = WEIGHT_CLASS_TINY
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	attack_verb = list("stabbed", "slashed", "sliced", "cut")
	max_integrity = 40
	sharpness = IS_SHARP
	smeltresult = /obj/item/natural/glass
	pickup_sound = 'sound/items/glass_pick_up.ogg'
	drop_sound = 'sound/items/glass_drop.ogg'

/obj/item/natural/glass/shard/Initialize()
	. = ..()
	AddComponent(/datum/component/caltrop, force)
	AddComponent(/datum/component/butchering, 150, 65)

/obj/item/natural/glass/shard/Crossed(mob/living/L)
	if(istype(L) && has_gravity(loc))
		playsound(loc, 'sound/foley/glass_step.ogg', HAS_TRAIT(L, TRAIT_LIGHT_STEP) ? 30 : 50, TRUE)
	return ..()
