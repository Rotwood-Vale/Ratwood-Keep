/mob/dead/observer/rogue/veil
	name = "veil ghost"

	/// Tracks if the user has collected a toll from the ground
	var/collected_toll = FALSE

	/// Tracks if the user has paid the toll to the carriageman
	var/paid_toll = FALSE

/mob/dead/observer/rogue/veil/Initialize(mapload)
	. = ..()
	GLOB.veil_ghost_list += src

	// give them a toll after 15 minutes
	addtimer(CALLBACK(src, PROC_REF(get_toll)), 15 MINUTES)

/mob/dead/observer/rogue/veil/Destroy()
	GLOB.veil_ghost_list -= src
	return ..()

/// Gives the user a toll
/mob/dead/observer/rogue/veil/proc/get_toll()
	src << sound('sound/misc/carriage4.ogg', 0, 0 ,0, 50)
	to_chat(src, span_bold("Necra extends a dying arm to give you a toll."))
	collected_toll = TRUE


/**
 * This overlay should only be used for entities that have one appearance in the living world, and another in the veil.
 * The Carriage is a such example.
 * For entities that are only visible to ghosts, like tolls, use invisibility = INVISIBILITY_OBSERVER.
 */
/datum/atom_hud/alternate_appearance/basic/veil/mobShouldSee(mob/M)

	if(M.type == /mob/dead/observer/rogue/veil || M.type == /mob/dead/observer/admin)
		return TRUE

	return FALSE

/// Applies the veil overlay
/proc/apply_veil(image/I, atom/A)
	I.override = TRUE
	A.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/veil, "veil", I)


/// Proc that will search inside a given atom for any corpses, and send the associated ghost to the lobby if possible
/proc/pacify_coffin(atom/movable/coffin, mob/user, deep = TRUE, give_pq = PQ_GAIN_BURIAL)
	if(!coffin)
		return FALSE
	var/success = FALSE
	if(isliving(coffin))
		if(process_buried_corpse(coffin, user))
			success = TRUE
	for(var/mob/living/corpse in coffin)
		if(process_buried_corpse(corpse, user))
			success = TRUE
		// no break. mass graves ahoy!
	//if this is a deep search, we will also search the FIRST closet immediately inside the coffin and pacify the occupants
	if(deep)
		for(var/obj/structure/closet/stuffing in coffin.contents)
			if(pacify_coffin(stuffing, user, deep = FALSE, give_pq = FALSE))
				success = TRUE
			break // only the first
	// Success is actually the ckey of the last attacker so we can prevent PQ farming from fragging people // DOESNT WORK "success" is not a ckey, just a bool for now
	if(success && deep) // deep is here for no double-message
		if(give_pq && user?.ckey && (user.ckey != success))
			adjust_playerquality(give_pq, user.ckey)
	return success


/**
 * This proc is called on each individual corpse after being buried
 */
/proc/process_buried_corpse(mob/living/corpse, mob/user, coin_pq = PQ_GAIN_BURIAL)

	if(QDELETED(corpse) || QDELETED(corpse.mind) || (corpse.stat != DEAD))
		return FALSE

	if(copytext(corpse.key, 1, 2) == "@") // lazy version of IsMobAdminGhosted()
		return FALSE
		
	if(corpse.mind.funeral)
		to_chat(user, span_red("This one has already been buried."))
		return FALSE

	// save the last attacker ckey so we can prevent PQ farming from fragging people
	var/attacker_ckey = corpse.lastattackerckey || TRUE

	var/mob/living/carbon/human/human_corpse = corpse
	if(!human_corpse)
		return FALSE

	// if buried with a coin, reward player
	if(istype(human_corpse.mouth, /obj/item/roguecoin) && !HAS_TRAIT(corpse, TRAIT_BURIED_COIN_GIVEN))
		var/obj/item/roguecoin/coin = human_corpse.mouth
		if(coin.quantity >= 1) // one is as good as a hundred
			ADD_TRAIT(human_corpse, TRAIT_BURIED_COIN_GIVEN, TRAIT_GENERIC)
			if(coin_pq && user?.ckey && (user.ckey != attacker_ckey))
				adjust_playerquality(coin_pq, user.ckey)
			qdel(human_corpse.mouth)
			human_corpse.update_inv_mouth()

	corpse.mind.remove_antag_datum(/datum/antagonist/zombie)
	corpse.mind.funeral = TRUE
	var/corpse_name = corpse.real_name || "*no name*"
	var/corpse_key = corpse.mind.key || "*no key*"
	testing("pacify_corpse success ([corpse_name], [corpse_key])")
	user.log_message("memorialized [corpse_name][corpse.mind.name ? " (mind-name [corpse.mind.name])" : ""], played by [corpse_key].", LOG_GAME)


	// if player is not a ghost, ghostize them
	if(!corpse.get_veil_ghost())
		corpse.ghostize(can_reenter_corpses = FALSE) //They are buried, they are not re-entering it.
	
	var/mob/dead/observer/rogue/veil/ghost = corpse.get_veil_ghost()

	to_chat(ghost, span_rose("My body has been buried. I gain a faint sense of peace."))

	if(HAS_TRAIT(corpse, TRAIT_BURIED_COIN_GIVEN))
		to_chat(ghost, span_rose("I have been buried with a coin. My passage has been paid."))
		ghost.collected_toll = TRUE

	return TRUE

///Get the veil ghost associated with this mob (from the mind)
/mob/proc/get_veil_ghost()

	var/mind_key = key || mind?.key

	if(!mind_key)
		return FALSE

	// look for a ghost with the same key
	for(var/mob/dead/observer/rogue/veil/ghost in GLOB.veil_ghost_list)
		if((ckey(ghost.key) == ckey(mind_key)) || (ckey(ghost.mind?.key) == ckey(mind_key)))
			if(!mind) // prior respawn detection
				return ghost
			break

	return FALSE

/mob/dead/observer/rogue/veil/get_veil_ghost()
	return src
