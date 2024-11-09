
/obj/projectile/bullet/rogue
	name = "lead ball"
	damage = 75	//higher damage than crossbow
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/event/bullet
	range = 25		//Higher than arrow, but not halfway through the entire town.
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	armor_penetration = 75	//Crossbow-on-crack AP. Armor only goes up to 100 protection normally; so this ignores most of it but not all. Wear good armor!
	speed = 0.1		//ZOOM!!!!!

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


/obj/item/ammo_casing/caseless/rogue/event/bullet
	name = "lead sphere"
	desc = "A small lead sphere. This should go well with gunpowder."
	projectile_type = /obj/projectile/bullet/rogue
	caliber = "musketball"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	dropshrink = 0.5
	max_integrity = 0.1
