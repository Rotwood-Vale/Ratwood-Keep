/mob/dead/observer/rogue/veil
	name = "veil ghost"

	/// Tracks if the user has collected a toll from the ground
	var/collected_toll = FALSE

	/// Tracks if the user has paid the toll to the carriageman
	var/paid_toll = FALSE

/// veil overlay. This makes sure only veil spirits and admins can see veil entities.
/datum/atom_hud/alternate_appearance/basic/veil/mobShouldSee(mob/M)

	if(M.type == /mob/dead/observer/rogue/veil || M.type == /mob/dead/observer/admin)
		return TRUE

	return FALSE

/// Applies the veil overlay
/proc/apply_veil(image/I, atom/A)
	I.override = TRUE
	A.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/veil, "veil", I)

