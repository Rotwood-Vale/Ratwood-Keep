#define BULLET_DAMAGE		120
#define ARROW_DAMAGE		33
#define ARROW_PENETRATION	25
#define BOLT_DAMAGE			44
#define BOLT_PENETRATION	50

/obj/projectile/bullet/reusable/runelock
	damage = BULLET_DAMAGE

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
