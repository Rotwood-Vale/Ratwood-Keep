/// veil overlay. This makes sure only veil spirits and admins can see veil entities.
/datum/atom_hud/alternate_appearance/basic/veil/mobShouldSee(mob/M)

	if(M.type == /mob/dead/observer/rogue/veil || M.type == /mob/dead/observer/admin)
		return TRUE

	return FALSE

/// Applies the veil overlay
/proc/apply_veil(image/I, atom/A)
	I.override = TRUE
	A.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/veil, "veil", I)


/**
 * Transfers the user to a veil ghost.
 * Inspired from the original ghostize for TG observers, except we dont use observers.
 * Called when someone physically moves from their dead body.
 */

/mob/proc/veil_ghostize()

	if(!key)
		return FALSE

	if(client)
		SSdroning.kill_rain(client)
		SSdroning.kill_loop(client)
		SSdroning.kill_droning(client)

	var/mob/dead/observer/rogue/veil/S = new /mob/dead/observer/rogue/veil(src.loc)

	S.ckey = ckey
	S.real_name = real_name
	S.livingname = real_name
	S.add_client_colour(/datum/client_colour/monochrome)

	return TRUE
