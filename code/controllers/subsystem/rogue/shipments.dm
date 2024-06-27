#define MAX_SHIPMENT_CHESTS 5

SUBSYSTEM_DEF(shipments)
	name = "Shipments"
	wait = 5 SECONDS
	flags = SS_KEEP_TIMING
	var/chest_amount = MAX_SHIPMENT_CHESTS
	var/list/shipment_landmarks = list()
	var/list/shipments = list()
	var/list/water_noises = list(
		'sound/foley/footsteps/FTWAT_1.ogg',
		'sound/foley/footsteps/FTWAT_2.ogg',
		'sound/foley/footsteps/FTWAT_3.ogg',
		'sound/foley/footsteps/FTWAT_4.ogg',
		)

/datum/controller/subsystem/shipments/Initialize()
	. = ..()

/datum/controller/subsystem/shipments/fire(resumed = 0)
	process_shipments(5 SECONDS)
	process_empty_chest_consumption(5 SECONDS)

/datum/controller/subsystem/shipments/proc/do_transportation_effect(turf/place)
	playsound(place, pick(water_noises), 100)
	new /obj/effect/particle_effect/water(place)

/datum/controller/subsystem/shipments/proc/shipments_allowed()
	if(shipment_landmarks.len > 0)
		return TRUE
	return FALSE

/datum/controller/subsystem/shipments/proc/process_shipments(dt)
	for(var/datum/shipment/shipment as anything in shipments)
		shipment.time_remaining -= dt
		if(shipment.time_remaining > 0)
			continue
		var/turf/place = find_free_spawn_place()
		if(!place)
			continue
		// Spawning a shipment
		var/datum/supply_pack/rogue/pack = SSshuttle.supply_packs[shipment.supply_pack_type]
		var/atom/spawn_location
		if(pack.shipment_spawns_in_crate)
			if(SSshipments.chest_amount <= 0)
				continue
			SSshipments.chest_amount -= 1
			var/obj/structure/closet/crate/crate = new /obj/structure/closet/crate/chest(place)
			spawn_location = crate
		else
			spawn_location = place
		for(var/item_type in pack.contains)
			new item_type(spawn_location)
		shipments -= shipment
		do_transportation_effect(place)

/datum/controller/subsystem/shipments/proc/process_empty_chest_consumption(dt)
	if(chest_amount >= MAX_SHIPMENT_CHESTS)
		return
	for(var/obj/effect/landmark/shipping_point/landmark as anything in shipment_landmarks)
		var/turf/place = landmark.loc
		var/obj/structure/closet/crate/crate = locate(/obj/structure/closet/crate) in place
		if(!crate)
			continue
		if(!crate.opened)
			continue
		var/obj/item/item = locate(/obj/item) in place
		if(item)
			continue
		qdel(crate)
		do_transportation_effect(place)
		chest_amount += 1
		if(chest_amount >= MAX_SHIPMENT_CHESTS)
			return

/datum/controller/subsystem/shipments/proc/find_free_spawn_place()
	var/list/shuffled_marks = shuffle(shipment_landmarks)
	for(var/obj/effect/landmark/shipping_point/landmark as anything in shuffled_marks)
		var/turf/place = landmark.loc
		if(!turf_is_spawn_eligible(place))
			continue
		return place
	return null

/datum/controller/subsystem/shipments/proc/turf_is_spawn_eligible(turf/place)
	for(var/atom/movable/movable as anything in place.contents)
		if(movable_blocks_spawn(movable))
			return FALSE
	return TRUE

/datum/controller/subsystem/shipments/proc/movable_blocks_spawn(atom/movable/movable)
	if(istype(movable, /obj/structure/closet/crate))
		return TRUE
	return FALSE

/datum/controller/subsystem/shipments/proc/add_shipment(supply_pack_type)
	if(!supply_pack_type)
		return
	var/datum/shipment/shipment = new /datum/shipment
	shipment.supply_pack_type = supply_pack_type
	shipments += shipment

/datum/shipment
	var/supply_pack_type
	var/time_remaining = 60 SECONDS
