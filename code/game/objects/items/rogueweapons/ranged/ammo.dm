/obj/item/ammo_casing/caseless/rogue/bolt
	name = "bolt"
	desc = "A durable iron bolt that will pierce a skull easily."
	projectile_type = /obj/projectile/bullet/reusable/bolt
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	caliber = "regbolt"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt"
	dropshrink = 0.6
	max_integrity = 10
	force = 10
/*
/obj/item/ammo_casing/caseless/rogue/bolt/poison
	name = "poisoned bolt"
	desc = "A durable iron bolt that will pierce a skull easily. This one is coated in a clear liquid."
	projectile_type = /obj/projectile/bullet/reusable/bolt/poison
	icon_state = "arrow_poison"
*/
/obj/projectile/bullet/reusable/bolt
	name = "bolt"
	damage = 35
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bolt
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	speed = 0.3
/*
/obj/projectile/bullet/reusable/bolt/poison
	name = "poisoned bolt"
	damage = 50
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bolt/poison


/obj/projectile/bullet/reusable/bolt/poison/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.reagents.add_reagent(/datum/reagent/toxin/mutetoxin, 7) //not gonna kill anyone, but they will be quite quiet
*/
/obj/item/ammo_casing/caseless/rogue/arrow
	name = "arrow"
	desc = "A wooden shaft with a pointy iron end."
	projectile_type = /obj/projectile/bullet/reusable/arrow
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow"
	force = 30
	dropshrink = 0.6
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	max_integrity = 20

/obj/projectile/bullet/reusable/arrow
	name = "arrow"
	damage = 35
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	speed = 0.4

/obj/item/ammo_casing/caseless/rogue/arrow/stone
	name = "stone arrow"
	desc = "A wooden shaft with a jagged rock on the end."
	icon_state = "stonearrow"
	max_integrity = 5
/*
/obj/item/ammo_casing/caseless/rogue/arrow/poison
	name = "poisoned arrow"
	desc = "A wooden shaft with a pointy iron end. This one is coated in a clear liquid."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison
	icon_state = "arrow_poison"
	max_integrity = 10

/obj/projectile/bullet/reusable/arrow/poison
	name = "arrow"
	damage = 35
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'


/obj/projectile/bullet/reusable/arrow/poison/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.reagents.add_reagent(/datum/reagent/toxin/drow, 5) //a REALLY slow burn for this arrow, and its lasting
*/
/obj/projectile/bullet/reusable/bullet
	name = "lead ball"
	damage = 50
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bullet
	range = 30
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	armor_penetration = 200
	speed = 0.1

/obj/item/ammo_casing/caseless/rogue/bullet
	name = "lead sphere"
	desc = "A small lead sphere. This should go well with gunpowder."
	projectile_type = /obj/projectile/bullet/reusable/bullet
	caliber = "musketball"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	dropshrink = 0.5
	possible_item_intents = list(/datum/intent/use)
	max_integrity = 0
