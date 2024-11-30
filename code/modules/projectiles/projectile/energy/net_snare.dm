/obj/projectile/energy/trap
	name = "energy snare"
	icon_state = "e_snare"
	nodamage = TRUE
	hitsound = 'sound/blank.ogg'
	range = 4

/obj/projectile/energy/trap/on_hit(atom/target, blocked = FALSE)
	if(!ismob(target) || blocked >= 100) //Fully blocked by mob or collided with dense object - drop a trap
		new/obj/item/restraints/legcuffs/beartrap/energy(get_turf(loc))
	else if(iscarbon(target))
		var/obj/item/restraints/legcuffs/beartrap/B = new /obj/item/restraints/legcuffs/beartrap/energy(get_turf(target))
		B.Crossed(target)
	..()

/obj/projectile/energy/trap/on_range()
	new /obj/item/restraints/legcuffs/beartrap/energy(loc)
	..()

/obj/projectile/energy/trap/cyborg
	name = "Energy Bola"
	icon_state = "e_snare"
	nodamage = TRUE
	paralyze = 0
	hitsound = 'sound/blank.ogg'
	range = 10

/obj/projectile/energy/trap/cyborg/on_hit(atom/target, blocked = FALSE)
	if(!ismob(target) || blocked >= 100)
		do_sparks(1, TRUE, src)
		qdel(src)
	if(iscarbon(target))
		var/obj/item/restraints/legcuffs/beartrap/B = new /obj/item/restraints/legcuffs/beartrap/energy/cyborg(get_turf(target))
		B.Crossed(target)
	QDEL_IN(src, 10)
	..()

/obj/projectile/energy/trap/cyborg/on_range()
	do_sparks(1, TRUE, src)
	qdel(src)
