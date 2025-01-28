/atom/movable/screen/storage/Click(location, control, params)
	var/list/modifiers = params2list(params)
	if(modifiers["right"])
		if(master)
			var/obj/item/flipper = usr.get_active_held_item()
			if((!usr.Adjacent(flipper) && !usr.DirectAccess(flipper)) || !isliving(usr) || usr.incapacitated())
				return
			var/old_width = flipper.grid_width
			var/old_height = flipper.grid_height
			flipper.grid_height = old_width
			flipper.grid_width = old_height
			update_hovering(location, control, params)
			return
	. = ..()
