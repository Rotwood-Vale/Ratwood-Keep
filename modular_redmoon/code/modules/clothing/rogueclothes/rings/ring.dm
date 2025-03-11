/obj/item/clothing/ring/silver/Initialize()
	. = ..()
	var/datum/magic_item/mundane/silver/effect = new
	AddComponent(/datum/component/magic_item, effect)
