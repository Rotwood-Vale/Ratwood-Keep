/obj/item/storage/belt/rogue/surgery_bag
	name = "surgeon's bag"
	desc = "Made to hold everything a people-butcher will need. Contains a list of implements... what even IS a Sisrat?"
	icon = 'icons/roguetown/clothing/storage.dmi'
	mob_overlay_icon = null
	icon_state = "surgery_bag"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	content_overlays = FALSE
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE

/obj/item/storage/belt/rogue/surgery_bag/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 30
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 8
		STR.not_while_equipped = TRUE
		STR.set_holdable(list(/obj/item/rogueweapon/surgery, /obj/item/needle))

/obj/item/storage/belt/rogue/surgery_bag/pickup(mob/user)
	..()
	content_overlays = FALSE
	update_icon()

/obj/item/storage/belt/rogue/surgery_bag/dropped(mob/living/carbon/human/user)
	..()
	if (isturf(loc))
		content_overlays = TRUE
	update_icon()

/obj/item/storage/belt/rogue/surgery_bag/update_icon()
	cut_overlays()
	..()
	if (content_overlays)
		icon = 'icons/roguetown/items/surgery_bag.dmi'
		var/mutable_appearance/straps = mutable_appearance('icons/roguetown/items/surgery_bag.dmi', "straps")
		add_overlay(straps)
	else
		icon = 'icons/roguetown/clothing/storage.dmi'

/obj/item/storage/belt/rogue/surgery_bag/full/PopulateContents()
	new /obj/item/rogueweapon/surgery/scalpel(src)
	new /obj/item/rogueweapon/surgery/saw(src)
	new /obj/item/rogueweapon/surgery/hemostat/first(src)
	new /obj/item/rogueweapon/surgery/hemostat/second(src) //Different types, for the purpose of belt overlays.
	new /obj/item/rogueweapon/surgery/retractor(src)
	new /obj/item/rogueweapon/surgery/bonesetter(src)
	new /obj/item/rogueweapon/surgery/cautery(src)
	new /obj/item/needle(src)

/obj/item/storage/belt/rogue/surgery_bag/full/physician/PopulateContents()
	new /obj/item/rogueweapon/surgery/scalpel(src)
	new /obj/item/rogueweapon/surgery/saw(src)
	new /obj/item/rogueweapon/surgery/hemostat/first(src)
	new /obj/item/rogueweapon/surgery/hemostat/second(src)
	new /obj/item/rogueweapon/surgery/retractor(src)
	new /obj/item/rogueweapon/surgery/bonesetter(src)
	new /obj/item/rogueweapon/surgery/cautery(src)
	new /obj/item/needle/pestra(src) //Gets the special needle!