/**
 * Special runelock ammo
 * Meant to be LIMITED, but reusable
 */
/obj/item/ammo_casing/caseless/runelock
	name = "runed sphere"
	desc = "A small iron ball, perfectly round and covered in Psydonite runes. Deadly when projected at very high velocity."
	projectile_type = /obj/projectile/bullet/reusable/runelock
	caliber = "runed_sphere"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	possible_item_intents = list(/datum/intent/use)
	max_integrity = 0
	w_class = WEIGHT_CLASS_TINY
	smeltresult = /obj/item/rogueore/iron


/obj/projectile/bullet/reusable/runelock
	name = "runed sphere"
	damage = 40
	armor_penetration = 50
	speed = 0.6
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	ammo_type = /obj/item/ammo_casing/caseless/runelock
	smeltresult = /obj/item/rogueore/iron
	range = 30
	hitsound = 'sound/combat/hits/hi_bolt (2).ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"

/**
 * Generic ammo used by handgonnes and arquebuses
 */

/obj/projectile/bullet/lead
	name = "lead sphere"
	damage = 75	//higher damage than crossbow
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
	ammo_type = /obj/item/ammo_casing/caseless/lead
	range = 25		//Higher than arrow, but not halfway through the entire town.
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	armor_penetration = 75 
	speed = 0.1		

/obj/projectile/bullet/rogue/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/M = target
		var/list/screams = list("painscream", "paincrit")
		var/check = rand(1, 20)
		if(isliving(target))
			if(check > M.STACON)
				M.emote(screams)
				M.Knockdown(rand(15,30))
				M.Immobilize(rand(30,60))


/obj/item/ammo_casing/caseless/lead
	name = "lead sphere"
	desc = "A small lead sphere. This should go well with gunpowder."
	projectile_type = /obj/projectile/bullet/lead
	caliber = "lead_sphere"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	dropshrink = 0.5
	max_integrity = 0.1
