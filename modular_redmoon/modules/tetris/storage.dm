/obj/item/storage
	var/list/populate_contents = list()

/obj/item/storage/PopulateContents()
	for(var/path in populate_contents)
		var/obj/item/new_item = new path(loc)
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, new_item, null, TRUE, TRUE))
			new_item.inventory_flip(null, TRUE)
			if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, new_item, null, TRUE, TRUE))
				testing("Deleting:[new_item] from [src]")
				qdel(new_item)

/obj/item/storage/belt/rogue/pouch/coins
	grid_height = 64
	grid_width = 32
