/obj/item/boulder
	name = "boulder"
	icon = 'icons/obj/structures/siege/onager/onager.dmi'
	icon_state = "boulder"
	w_class = 5
	var/launched = FALSE
	var/travel_time = 0
	var/incoming = list('sound/catapult/incoming.ogg', 'sound/catapult/incoming2.ogg', 'sound/catapult/incoming3.ogg')

/obj/item/boulder/Bump(atom/A)
	if(launched)
		playsound(get_turf(src), pick(incoming), 100, FALSE)
		spawn(travel_time * 6)
			explosion(get_turf(src), 1, -1, 2, 0)
			do_shrapnel_effect(get_turf(src))
			qdel(src)

/obj/item/boulder/onZImpact(turf/T, levels)
	if(launched)
		playsound(get_turf(src), pick(incoming), 100, FALSE)
		spawn(travel_time * 6)
			explosion(get_turf(src), 1, -1, 2, 0)
			do_shrapnel_effect(get_turf(src))

			qdel(src)

/obj/item/boulder/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(launched)
		if(!istype(hit_atom, /turf/open/space))
			playsound(get_turf(src), pick(incoming), 100, FALSE)
			spawn(travel_time * 6)
				explosion(get_turf(src), 1, -1, 2, 0)
				do_shrapnel_effect(get_turf(src))
				qdel(src)

// The runtime maker
/obj/item/boulder/proc/do_shrapnel_effect(atom/target)
    // Create a shrapnel component for this instance of the boulder
	var/datum/component/shrapnel/shrapnel_effect = new /datum/component/shrapnel()
	var/turf/origin_turf = get_turf(src)
	//var/boomchannel = SSsounds.random_available_channel() //enable this when TG sound gets added
	var/sound/far_explosion_sound = sound(pick('sound/catapult/explosion_distant.ogg',
	'sound/catapult/explosion_distant2.ogg','sound/catapult/explosion_distant3.ogg', 'sound/catapult/explosion_distant4.ogg'))
	shrapnel_effect.projectile_type = /obj/projectile/rock_shard // Define the type of shrapnel
	shrapnel_effect.radius = 3 // Define the explosion radius
	shrapnel_effect.override_projectile_range = 5 // Optional: specify the max range of each projectile
	shrapnel_effect.do_shrapnel(src, target) // Activate shrapnel
	for(var/mob/M in urange(20, src))
		if(!M.stat)
			shake_camera(M, 3, 1)
	for(var/mob/living/L in range(6, src))
		if(!L.stat)
			L.Knockdown(1)
			L.Jitter(30)
	for(var/mob/living/player in GLOB.player_list)
		var/distance = get_dist(player, origin_turf)
		if(player.stat == DEAD)
			continue
		if(isbrain(player))
			continue
		if(distance > 20)
			//player.playsound_local(get_turf(player), far_explosion_sound, 100, FALSE, pressure_affected = FALSE, channel = boomchannel) //enable this when TG sound gets added
			player.playsound_local(get_turf(player), far_explosion_sound, 100, FALSE, pressure_affected = FALSE)

/obj/projectile/rock_shard
	name = "rock shard"
	icon_state = "bullet"
	damage = 15
	range = 8
	pass_flags = PASSTABLE | PASSGRILLE
	armor_penetration = 15
	damage_type = BRUTE
	nodamage = FALSE
	embedchance = 20
	woundclass = BCLASS_BLUNT
	flag = "bullet"
	hitsound_wall = "ricochet"
	speed = 2
	impact_effect_type = /obj/effect/temp_visual/impact_effect
