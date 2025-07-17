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
	w_class = WEIGHT_CLASS_SMALL

/obj/projectile/bullet/reusable/bolt
	name = "bolt"
	damage = 35
	damage_type = BRUTE
	armor_penetration = 35
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bolt
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	speed = 0.3


//................ Pyro Bolt ............... //
/obj/item/ammo_casing/caseless/rogue/bolt/pyro
	name = "pyroclastic bolt"
	desc = "A bolt smeared with a flammable tincture."
	projectile_type = /obj/projectile/bullet/bolt/pyro
	possible_item_intents = list(/datum/intent/mace/strike)
	icon_state = "bolt_pyroclastic"

/obj/projectile/bullet/bolt/pyro
	name = "pyroclastic bolt"
	desc = "A bolt smeared with a flammable tincture."
	damage = 35
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "boltpyro_proj"
	range = 15
	hitsound = 'sound/blank.ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	armor_penetration = 35
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

//explosion values
	var/exp_heavy = -1
	var/exp_light = -1
	var/exp_flash = 0
	var/exp_fire = 1

/obj/projectile/bullet/bolt/pyro/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		M.adjust_fire_stacks(6)
		M.IgniteMob()
	explosion(get_turf(target), -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = explode_sound)


/obj/item/ammo_casing/caseless/rogue/arrow
	name = "arrow"
	desc = "A wooden shaft with a pointy iron end."
	projectile_type = /obj/projectile/bullet/reusable/arrow
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow"
	force = 7
	dropshrink = 0.6
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	max_integrity = 20
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_casing/caseless/rogue/arrow/iron
	name = "iron arrow"
	desc = "A wooden shaft with a pointy iron end."
	projectile_type = /obj/projectile/bullet/reusable/arrow/iron
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow"
	force = 7
	dropshrink = 0.6
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	max_integrity = 20

/obj/projectile/bullet/reusable/arrow
	name = "arrow"
	damage = 35
	damage_type = BRUTE
	armor_penetration = 10
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	speed = 0.4

/obj/projectile/bullet/reusable/arrow/iron
	name = "iron arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/iron

/obj/projectile/bullet/reusable/arrow/stone
	name = "stone arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone

/obj/item/ammo_casing/caseless/rogue/arrow/stone
	name = "stone arrow"
	desc = "A wooden shaft with a jagged rock on the end."
	icon_state = "stonearrow"
	max_integrity = 5
	projectile_type = /obj/projectile/bullet/reusable/arrow/stone

/obj/item/ammo_casing/caseless/rogue/arrow/poison
	name = "poisoned arrow"
	desc = "A wooden shaft with a pointy iron end. This one is stained green with floral toxins."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison
	icon_state = "arrow_poison"
	max_integrity = 20 // same as normal arrow; usually breaks on impact with a mob anyway

/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison
	name = "poisoned stone arrow"
	desc = "A wooden shaft with a jagged rock on the end. This one is stained green with floral toxins."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison/stone
	icon_state = "stonearrow_poison"

/obj/projectile/bullet/reusable/arrow/poison
	name = "poison arrow"
	damage = 35
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/iron
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	poisontype = /datum/reagent/berrypoison //Support for future variations of poison for arrow-crafting
	poisonfeel = "burning" //Ditto
	poisonamount = 2 //Support and balance for bodkins, which will hold less poison due to how

/obj/projectile/bullet/reusable/arrow/poison/stone
	name = "stone arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone

/obj/projectile/bullet/reusable/arrow/poison/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(istype(target, /mob/living/simple_animal)) //On-hit for carbon mobs has been moved to projectile act in living_defense.dm, to ensure poison is not applied if armor prevents damage.
		var/mob/living/simple_animal/M = target
		M.show_message(span_danger("You feel an intense burning sensation spreading swiftly from the puncture!")) //In case a player is in control of the mob.
		addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living, adjustToxLoss), 50), 10 SECONDS)
		addtimer(CALLBACK(M, TYPE_PROC_REF(/atom, visible_message), span_danger("[M] appears greatly weakened by the poison!")), 10 SECONDS)

//................ Pyro Arrow ............... //
/obj/item/ammo_casing/caseless/rogue/arrow/pyro
	name = "pyroclastic arrow"
	desc = "An arrow with its tip drenched in a flammable tincture."
	projectile_type = /obj/projectile/bullet/arrow/pyro
	possible_item_intents = list(/datum/intent/mace/strike)
	icon_state = "arrow_pyroclastic"
	max_integrity = 10
	force = 10

/obj/projectile/bullet/arrow/pyro
	name = "pyroclastic arrow"
	desc = "An arrow with its tip drenched in a flammable tincture."
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrowpyro_proj"
	damage = 35
	range = 15
	hitsound = 'sound/blank.ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	armor_penetration = 10
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

//explosion values
	var/exp_heavy = -1
	var/exp_light = -1
	var/exp_flash = 0
	var/exp_fire = 1

/obj/projectile/bullet/arrow/pyro/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		M.adjust_fire_stacks(6)
		M.IgniteMob()
	explosion(get_turf(target), -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = explode_sound)

//sling bullets

/obj/item/ammo_casing/caseless/rogue/sling_bullet //parent of sling ammo and the temporary sling bullet for stones. shouldn't ever be seen
	name = "soaring stone"
	desc = "You shouldn't be seeing this."
	projectile_type = /obj/projectile/bullet/sling_bullet
	caliber = "slingbullet"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow"
	force = 5
	throwforce = 5 // You can still throw them, but shouldn't.
	dropshrink = 0.6
	possible_item_intents = list(INTENT_GENERIC) //not intended to attack with them
	max_integrity = 20

/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone //these should be seen
	name = "stone sling bullet"
	desc = "A stone refined for wrath."
	projectile_type = /obj/projectile/bullet/reusable/sling_bullet/stone
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "stone_sling_bullet"

/obj/projectile/bullet/sling_bullet //not reusable since stones will break on impact. i couldnt figure out how to prevent that
	name = "sling bullet"
	desc = "If you're reading this: duck."
	damage = 25
	damage_type = BRUTE
	armor_penetration = 0
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "stone1"
	range = 15
	hitsound = 'sound/combat/hits/blunt/bluntsmall (1).ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	flag = "piercing"
	speed = 0.4

/obj/projectile/bullet/sling_bullet/on_hit(atom/target)
	. = ..()

	var/mob/living/L = firer
	if(!L || !L.mind) return

	var/skill_multiplier = 0

	if(isliving(target)) // If the target theyre shooting at is a mob/living
		var/mob/living/T = target
		if(T.stat != DEAD) // If theyre alive
			skill_multiplier = 4

	if(skill_multiplier && can_train_combat_skill(L, /datum/skill/combat/slings, SKILL_LEVEL_LEGENDARY))
		L.mind.add_sleep_experience(/datum/skill/combat/slings, L.STAINT * skill_multiplier)

/obj/projectile/bullet/reusable/sling_bullet //parent for proper reusable sling bullets
	name = "sling bullet"
	desc = "If you're reading this: duck."
	damage = 25
	damage_type = BRUTE
	armor_penetration = 0
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "stone1"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/sling_bullet
	range = 15
	hitsound = 'sound/combat/hits/blunt/bluntsmall (1).ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	flag = "piercing"
	speed = 0.4

/obj/projectile/bullet/reusable/sling_bullet/on_hit(atom/target)
	. = ..()

	var/mob/living/L = firer
	if(!L || !L.mind) return

	var/skill_multiplier = 0

	if(isliving(target)) // If the target theyre shooting at is a mob/living
		var/mob/living/T = target
		if(T.stat != DEAD) // If theyre alive
			skill_multiplier = 4

	if(skill_multiplier && can_train_combat_skill(L, /datum/skill/combat/slings, SKILL_LEVEL_LEGENDARY))
		L.mind.add_sleep_experience(/datum/skill/combat/slings, L.STAINT * skill_multiplier)

/obj/projectile/bullet/reusable/sling_bullet/stone
	name = "stone sling bullet"
	damage = 30 //proper stones are better
	armor_penetration = 0
	ammo_type = /obj/item/ammo_casing/caseless/rogue/sling_bullet/stone
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
