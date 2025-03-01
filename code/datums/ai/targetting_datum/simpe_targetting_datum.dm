///Datum for basic mobs to define what they can attack.
/datum/targetting_datum

///Returns true or false depending on if the target can be attacked by the mob
/datum/targetting_datum/proc/can_attack(mob/living/living_mob, atom/target)
	return

///Returns something the target might be hiding inside of
/datum/targetting_datum/proc/find_hidden_mobs(mob/living/living_mob, atom/target)
	var/atom/target_hiding_location
	if(istype(target.loc, /obj/structure/closet))
		target_hiding_location = target.loc
	return target_hiding_location

/datum/targetting_datum/basic

/datum/targetting_datum/basic/can_attack(mob/living/living_mob, atom/the_target)
	if(isturf(the_target) || !the_target ) // bail out on invalids
		return FALSE
	if(isanimal(living_mob)) // REDMOON ADD - ai_fixes - для NPC под управлением некроманта
		var/mob/living/simple_animal/attacker = living_mob
		if(attacker.binded == TRUE)
			return FALSE

	if(ismob(the_target)) //Target is in godmode, ignore it.
		var/mob/M = the_target
		if(M.status_flags & GODMODE)
			return FALSE
		// REDMOON ADD START - ai_fixes - фикс атаки призываемого волка по своему хозяину
		if(living_mob.summoner == M.real_name) // запрещаем саммонам даже думать об атаке хозяина
			return FALSE 
		// REDMOON ADD END

	if(living_mob.see_invisible < the_target.invisibility)//Target's invisible to us, forget it
		return FALSE

	if(isturf(the_target.loc) && living_mob.z != the_target.z)
		return FALSE

	if(isliving(the_target)) //Targetting vs living mobs
		var/mob/living/L = the_target
		if(faction_check(living_mob, L) || L.stat)
			if(living_mob.ai_controller.ordered_to_attack != the_target) // REDMOON ADD - ai_fixes - позволяет атаковать персонажа той же фракции по приказу хозяина
				return FALSE
		return TRUE

	return FALSE

/datum/targetting_datum/basic/proc/faction_check(mob/living/living_mob, mob/living/the_target)
	return living_mob.faction_check_mob(the_target, exact_match = FALSE)

/// Subtype which doesn't care about faction
/// Mobs which retaliate but don't otherwise target seek should just attack anything which annoys them
/datum/targetting_datum/basic/ignore_faction

/datum/targetting_datum/basic/ignore_faction/faction_check(mob/living/living_mob, mob/living/the_target)
	return FALSE
