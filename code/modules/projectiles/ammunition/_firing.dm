/obj/item/ammo_casing/proc/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from)
	distro += variance
	for (var/i = max(1, pellets), i > 0, i--)
		var/targloc = get_turf(target)
		ready_proj(target, user, quiet, zone_override, fired_from)
		if(distro) //We have to spread a pixel-precision bullet. throw_proj was called before so angles should exist by now...
			// REDMOON ADD START - ranged_weapon_balancing - нулевой разброс при хорошей удаче и максимальный при плохой
			if(user.goodluck(4))
				to_chat(user, "LUCKY SHOT! Right in the spot!")
				spread = 0
			else if(user.badluck(4))
				to_chat(user, "DAMN! UNLUCK, HAND SLIPPED!")
				spread = 10 // сильно в бок
			else
			// REDMOON ADD END
				if(randomspread)
					spread = rand(0, distro) // REDMOON EDIT - изменяем механику разброса - WAS round((my_spread - 0.5) * distro)		
				else //Smart spread
					spread = round((i / pellets - 0.5) * distro)
				// REDMOON ADD START
				// ranged_weapon_balancing - снижение разброса в зависимости от навыков стреляющего
				if(user.buckled)
					if(isanimal(user.buckled)) // TODO: добавить сюда обходку для набегателей с конными лучниками
						to_chat(user, span_warning("It's hard to shoot accurate while mounting!"))
						spread += 4.5
				// ranged_weapon_balancing - снижение разброса в зависимости от навыков стреляющего
				var/obj/item/weapon = fired_from
				spread = max(0, spread - user.mind.get_skill_level(weapon.associated_skill) * 3)
				// REDMOON ADD END
		if(!throw_proj(target, targloc, user, params, spread))
			return 0
		if(i > 1)
			newshot()
	if(click_cooldown_override)
		user.changeNext_move(click_cooldown_override)
	else
		user.changeNext_move(CLICK_CD_RANGE)
	user.newtonian_move(get_dir(target, user))
	update_icon()
	return TRUE

/obj/item/ammo_casing/proc/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", atom/fired_from)
	if (!BB)
		return
	BB.original = target
	BB.firer = user
	BB.arcshot = user?.used_intent?.arc_check()
	if(BB.arcshot)
		BB.range = get_dist_euclidian(target, user)
	BB.fired_from = fired_from
	if (zone_override)
		BB.def_zone = zone_override
	else
		BB.def_zone = user.zone_selected
	BB.suppressed = quiet

	if(reagents && BB.reagents)
		reagents.trans_to(BB, reagents.total_volume, transfered_by = user) //For chemical darts/bullets
		qdel(reagents)

/obj/item/ammo_casing/proc/throw_proj(atom/target, turf/targloc, mob/living/user, params, spread)
	var/turf/curloc = get_turf(user)
	if (!istype(targloc) || !istype(curloc) || !BB)
		return FALSE

	var/firing_dir
	if(BB.firer)
		firing_dir = BB.firer.dir
	if(!BB.suppressed && firing_effect_type)
		new firing_effect_type(get_turf(src), firing_dir)

	var/direct_target
	if(targloc == curloc)
		if(target) //if the target is right on our location we'll skip the travelling code in the proj's fire()
			direct_target = target
	if(!direct_target)
		BB.preparePixelProjectile(target, user, params, spread)
	BB.fire(null, direct_target)
	BB = null
	return TRUE

/obj/item/ammo_casing/proc/spread(turf/target, turf/current, distro)
	var/dx = abs(target.x - current.x)
	var/dy = abs(target.y - current.y)
	return locate(target.x + round(gaussian(0, distro) * (dy+2)/8, 1), target.y + round(gaussian(0, distro) * (dx+2)/8, 1), target.z)
