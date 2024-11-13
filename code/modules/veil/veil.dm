/// veil overlay 
/datum/atom_hud/alternate_appearance/basic/veil/mobShouldSee(mob/M)
	if(M.type == /mob/dead/observer/rogue)
		return TRUE
	return FALSE

/// Applies the veil overlay
/proc/apply_veil(image/I, atom/A)
	I.override = TRUE
	A.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/veil, "veil", I)
