#define RUNELOCK_DAMAGE		120 // Пистолет по стандарту всего один и он у Инквизитора. Ещё два может быть по Трейту.
#define LEAD_DAMAGE			150 // Аркебуза - смертельное оружие для своего времени.
#define GRAPE_DAMAGE		45  // Дробовик, ебать.
#define ARROW_DAMAGE		33
#define ARROW_PENETRATION	10
#define BOLT_DAMAGE			44
#define BOLT_PENETRATION	50

/obj/projectile/bullet/reusable/runelock
	damage = RUNELOCK_DAMAGE

/obj/projectile/bullet/lead
	damage = LEAD_DAMAGE

/obj/projectile/bullet/grapeshot	
	damage = GRAPE_DAMAGE

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

/obj/projectile/bullet/reusable/bolt
	damage = BOLT_DAMAGE
	armor_penetration = BOLT_PENETRATION

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
