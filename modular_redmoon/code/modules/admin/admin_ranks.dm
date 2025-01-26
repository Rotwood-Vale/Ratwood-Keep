/datum/admin_rank
	var/list/admin_flags = list()

/datum/admin_rank/New(init_name, init_rights, init_exclude_rights, init_edit_rights)
	. = ..()
	admin_flags |= list(FLAG_GIB, FLAG_JUMP, FLAG_JUMP_GHOST, FLAG_PM, FLAG_SM, FLAG_PP, FLAG_VV)
