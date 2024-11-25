////////////////////
//Clusterbang
////////////////////
/obj/item/grenade/clusterbuster
	desc = ""
	name = "clusterbang"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "clusterbang"
	var/base_state = "clusterbang"
	var/payload = /obj/item/grenade/flashbang/cluster
	var/payload_spawner = /obj/effect/payload_spawner
	var/prime_sound = 'sound/blank.ogg'
	var/min_spawned = 4
	var/max_spawned = 8
	var/segment_chance = 35

/obj/item/grenade/clusterbuster/prime()
	update_mob()
	var/numspawned = rand(min_spawned,max_spawned)
	var/again = 0

	for(var/more = numspawned,more > 0,more--)
		if(prob(segment_chance))
			again++
			numspawned--

	for(var/loop in 1 to again)
		new /obj/item/grenade/clusterbuster/segment(drop_location(), src)//Creates 'segments' that launches a few more payloads

	new payload_spawner(drop_location(), payload, numspawned)//Launches payload
	playsound(src, prime_sound, 75, TRUE, -3)
	qdel(src)

//////////////////////
//Clusterbang segment
//////////////////////
/obj/item/grenade/clusterbuster/segment
	desc = ""
	name = "clusterbang segment"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "clusterbang_segment"
	base_state = "clusterbang_segment"

/obj/item/grenade/clusterbuster/segment/Initialize(mapload, obj/item/grenade/clusterbuster/base)
	. = ..()
	if(base)
		name = "[base.name] segment"
		base_state = "[base.base_state]_segment"
		icon_state = base_state
		payload_spawner = base.payload_spawner
		payload = base.payload
		prime_sound = base.prime_sound
		min_spawned = base.min_spawned
		max_spawned = base.max_spawned
	icon_state = "[base_state]_active"
	active = TRUE
	var/steps = rand(1,4)
	for(var/i in 1 to steps)
		step_away(src,loc)
	addtimer(CALLBACK(src, PROC_REF(prime)), rand(15,60))

/obj/item/grenade/clusterbuster/segment/prime()
	new payload_spawner(drop_location(), payload, rand(min_spawned,max_spawned))
	playsound(src, prime_sound, 75, TRUE, -3)
	qdel(src)

//////////////////////////////////
//The payload spawner effect
/////////////////////////////////
/obj/effect/payload_spawner/Initialize(mapload, type, numspawned)
	..()
	spawn_payload(type, numspawned)
	return INITIALIZE_HINT_QDEL

/obj/effect/payload_spawner/proc/spawn_payload(type, numspawned)
	for(var/loop in 1 to numspawned)
		var/obj/item/grenade/P = new type(loc)
		if(istype(P))
			P.active = TRUE
			addtimer(CALLBACK(P, TYPE_PROC_REF(/obj/item/grenade, prime)), rand(15,60))
		var/steps = rand(1,4)
		for(var/i in 1 to steps)
			step_away(src,loc)

//////////////////////////////////
//Custom payload clusterbusters
/////////////////////////////////
/obj/item/grenade/flashbang/cluster
	icon_state = "flashbang_active"

/obj/item/grenade/clusterbuster/emp
	name = "Electromagnetic Storm"
	payload = /obj/item/grenade/empgrenade

/obj/item/grenade/clusterbuster/smoke
	name = "Ninja Vanish"
	payload = /obj/item/grenade/smokebomb

/obj/item/grenade/clusterbuster/syndieminibomb
	name = "SyndiWrath"
	payload = /obj/item/grenade/syndieminibomb

/obj/item/grenade/clusterbuster/spawner_manhacks
	name = "iViscerator"
	payload = /obj/item/grenade/spawnergrenade/manhacks

/obj/item/grenade/clusterbuster/spawner_spesscarp
	name = "Invasion of the Space Carps"
	payload = /obj/item/grenade/spawnergrenade/spesscarp

/obj/item/grenade/clusterbuster/soap
	name = "Slipocalypse"
	payload = /obj/item/grenade/spawnergrenade/syndiesoap

//random clusterbuster spawner
/obj/item/grenade/clusterbuster/random
	icon_state = "random_clusterbang"

/obj/item/grenade/clusterbuster/random/Initialize()
	..()
	var/real_type = pick(subtypesof(/obj/item/grenade/clusterbuster))
	new real_type(loc)
	return INITIALIZE_HINT_QDEL
