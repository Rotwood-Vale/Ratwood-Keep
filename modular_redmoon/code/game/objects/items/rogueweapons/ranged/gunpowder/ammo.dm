#define RUNELOCK_DAMAGE		120 // Пистолет по стандарту всего один и он у Инквизитора. Ещё два может быть по Трейту.
#define LEAD_DAMAGE			225 // Аркебуза - смертельное оружие для своего времени.
#define GRAPE_DAMAGE		45  // Дробовик, ебать.
#define BULLET_PENETRATION	60
#define ARROW_DAMAGE		33
#define ARROW_PENETRATION	25
#define BOLT_DAMAGE			44
#define BOLT_PENETRATION	50

/obj/projectile/bullet/reusable/bolt
	damage = BOLT_DAMAGE
	armor_penetration = BOLT_PENETRATION

/obj/projectile/bullet/reusable/runelock
	damage = RUNELOCK_DAMAGE
	armor_penetration = BULLET_PENETRATION

/obj/projectile/bullet/lead
	damage = LEAD_DAMAGE
	armor_penetration = BULLET_PENETRATION

/obj/projectile/bullet/grapeshot	
	damage = GRAPE_DAMAGE
	armor_penetration = BULLET_PENETRATION

/obj/projectile/bullet/reusable/arrow
	damage = ARROW_DAMAGE
	armor_penetration = ARROW_PENETRATION

/obj/projectile/bullet/reusable/arrow/iron
	name = "iron arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/iron

/obj/projectile/bullet/reusable/arrow/stone
	embedchance = 80
	armor_penetration = 0
	damage = ARROW_DAMAGE-2

/obj/projectile/bullet/reusable/arrow/ancient
	damage = 10
	damage_type = BRUTE
	armor_penetration = 25
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "piercing"
	speed = 2

//................ Pyro Bolt ............... //
/obj/item/ammo_casing/caseless/rogue/bolt/pyro
	name = "pyroclastic bolt"
	desc = "A bolt smeared with a flammable tincture."
	projectile_type = /obj/projectile/bullet/bolt/pyro
	possible_item_intents = list(/datum/intent/mace/strike)
	icon_state = "bolt_pyroclastic"

/obj/item/ammo_casing/caseless/rogue/bolt/pyro/Initialize()
	. = ..()
	RemoveElement(/datum/element/tipped_item)
	qdel(reagents)

/obj/projectile/bullet/bolt/pyro
	name = "pyroclastic bolt"
	desc = "A bolt smeared with a flammable tincture."
	damage = BOLT_DAMAGE-20
	icon_state = "boltpyro_proj"
	range = 15
	hitsound = 'sound/blank.ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	armor_penetration = BOLT_PENETRATION-30
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

//explosion values
	var/exp_heavy = 0
	var/exp_light = 0
	var/exp_flash = 0
	var/exp_fire = 1

/obj/projectile/bullet/bolt/pyro/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		M.fire_act(6)
//		M.take_overall_damage(0,10) //between this 10 burn, the 10 brute, the explosion brute, and the onfire burn, my at about 65 damage if you stop drop and roll immediately
	var/turf/T
	if(isturf(target))
		T = target
	else
		T = get_turf(target)
	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = explode_sound)

//................ Pyro Arrow ............... //
/obj/item/ammo_casing/caseless/arrow/pyro
	name = "pyroclastic arrow"
	desc = "An arrow with its tip smeared with a flammable tincture."
	projectile_type = /obj/projectile/bullet/arrow/pyro
	possible_item_intents = list(/datum/intent/mace/strike)
	icon_state = "arrow_pyroclastic"
	max_integrity = 10
	force = 8

/obj/item/ammo_casing/caseless/arrow/pyro/Initialize()
	. = ..()
	RemoveElement(/datum/element/tipped_item)
	qdel(reagents)

/obj/projectile/bullet/arrow/pyro
	name = "pyroclastic arrow"
	desc = "An arrow with its tip smeared with a flammable tincture."
	icon_state = "arrowpyro_proj"
	damage = ARROW_DAMAGE-15
	range = 15
	hitsound = 'sound/blank.ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	armor_penetration = ARROW_PENETRATION-15
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

//explosion values
	var/exp_heavy = 0
	var/exp_light = 0
	var/exp_flash = 0
	var/exp_fire = 1

/obj/projectile/bullet/arrow/pyro/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		M.fire_act(6)
//		M.take_overall_damage(0,10) //between this 10 burn, the 10 brute, the explosion brute, and the onfire burn, my at about 65 damage if you stop drop and roll immediately
	var/turf/T
	if(isturf(target))
		T = target
	else
		T = get_turf(target)
	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = explode_sound)
