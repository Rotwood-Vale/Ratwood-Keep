/obj/item/storage/belt/rogue
	name = ""
	desc = ""
	icon = 'icons/roguetown/clothing/belts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/belts.dmi'
	icon_state = ""
	item_state = ""
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("whips", "lashes")
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	content_overlays = FALSE
	bloody_icon_state = "bodyblood"
	var/heldz_items = 3

/obj/item/storage/belt/rogue/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 6
		STR.max_w_class = WEIGHT_CLASS_SMALL
		STR.max_items = heldz_items

/obj/item/storage/belt/rogue/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE
	..()

/obj/item/storage/belt/rogue/leather
	name = "belt"
	desc = "A leather belt."
	icon_state = "leather"
	item_state = "leather"
	equip_sound = 'sound/blank.ogg'
	heldz_items = 3
	sewrepair = TRUE

/obj/item/storage/belt/rogue/leather/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

/obj/item/storage/belt/rogue/leather/plaquegold
	name = "plaque belt"
	desc = "A belt with a golden plate on its front."
	icon_state = "goldplaque"
	sellprice = 50
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/shalal
	name = "shalal belt"
	icon_state = "shalal"
	sellprice = 5

/obj/item/storage/belt/rogue/leather/shalalz
	name = "zybantine shalal belt"
	icon_state = "shalal_z"
	sellprice = 5

/obj/item/storage/belt/rogue/leather/black
	name = "black belt"
	icon_state = "blackbelt"
	sellprice = 10

/obj/item/storage/belt/rogue/leather/plaquesilver
	name = "plaque belt"
	desc = "A belt with a silver plate on its front."
	icon_state = "silverplaque"
	sellprice = 30
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/hand
	name = "steel belt"
	desc = "A belt with a steel plate on its front."
	icon_state = "steelplaque"
	sellprice = 30
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/rope
	name = "rope belt"
	desc = "A simple belt made of rope."
	icon_state = "rope"
	item_state = "rope"
	color = "#b9a286"
	heldz_items = 1

/obj/item/storage/belt/rogue/leather/cloth
	name = "cloth sash"
	desc = "A simple cloth sash."
	icon_state = "cloth"
	heldz_items = 1

/obj/item/storage/belt/rogue/leather/cloth/lady
	color = "#575160"

/obj/item/storage/belt/rogue/leather/cloth/bandit
	color = "#ff0000"

/obj/item/storage/belt/rogue/pouch
	name = "pouch"
	desc = "Usually used for holding coins."
	icon = 'icons/roguetown/clothing/storage.dmi'
	mob_overlay_icon = null
	icon_state = "pouch"
	item_state = "pouch"
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("whips", "lashes")
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	content_overlays = FALSE
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE

/obj/item/storage/belt/rogue/pouch/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 6
		STR.max_w_class = WEIGHT_CLASS_SMALL
		STR.max_items = 3
		STR.not_while_equipped = FALSE

/obj/item/storage/belt/rogue/pouch/coins/mid/Initialize()
	. = ..()
	var/obj/item/roguecoin/silver/pile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	var/obj/item/roguecoin/copper/pile/C = new(loc)
	if(istype(C))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, C, null, TRUE, TRUE))
			qdel(C)

/obj/item/storage/belt/rogue/pouch/coins/poor/Initialize()
	. = ..()
	var/obj/item/roguecoin/copper/pile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	if(prob(50))
		H = new(loc)
		if(istype(H))
			if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
				qdel(H)

/obj/item/storage/belt/rogue/pouch/coins/rich/Initialize()
	. = ..()
	var/obj/item/roguecoin/silver/pile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	if(prob(50))
		H = new(loc)
		if(istype(H))
			if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
				qdel(H)

/obj/item/storage/belt/rogue/pouch/food/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)

/obj/item/storage/backpack/rogue/satchel
	name = "satchel"
	desc = "A bulky bag worn over the shoulder which can be used to hold many things."
	icon_state = "satchel"
	item_state = "satchel"
	icon = 'icons/roguetown/clothing/storage.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = NONE
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	alternate_worn_layer = UNDER_CLOAK_LAYER
	sewrepair = TRUE

/obj/item/storage/backpack/rogue/satchel/heartfelt/PopulateContents()
	new /obj/item/natural/feather(src)
	new /obj/item/paper(src)

/obj/item/storage/backpack/rogue/satchel/mule/PopulateContents()
	for(var/i in 1 to 3)
		switch(rand(1,4))
			if(1)	
				new /obj/item/reagent_containers/powder/moondust_purest(src)
			if(2)
				new /obj/item/reagent_containers/powder/moondust_purest(src)
			if(3)
				new /obj/item/reagent_containers/powder/ozium(src)
			if(4)
				new /obj/item/reagent_containers/powder/spice(src)


/obj/item/storage/backpack/rogue/satchel/black
	color = CLOTHING_BLACK

/obj/item/storage/backpack/rogue/satchel/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 18
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 4

/obj/item/storage/backpack/rogue/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE


/obj/item/storage/backpack/rogue/backpack
	name = "backpack"
	desc = "A bulky backpack worn on the back which can store many items."
	icon_state = "backpack"
	item_state = "backpack"
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK_L
	resistance_flags = NONE
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE

/obj/item/storage/backpack/rogue/backpack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 42
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 14
		STR.not_while_equipped = TRUE

/obj/item/storage/belt/rogue/pickles
	name = "jar of pickles"
	desc = "Briney goodness!"
	icon = 'icons/roguetown/clothing/storage.dmi'
	icon_state = "pickles"
	slot_flags = null
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 100
	content_overlays = FALSE
	heldz_items = 4

/obj/item/storage/belt/rogue/pickles/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 8
		STR.max_w_class = WEIGHT_CLASS_SMALL
		STR.max_items = 4
		STR.not_while_equipped = FALSE

/obj/item/storage/belt/rogue/pickles/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/grown/pickle(src)
	new /obj/item/reagent_containers/food/snacks/grown/pickle(src)
	new /obj/item/reagent_containers/food/snacks/grown/pickle(src)
	new /obj/item/reagent_containers/food/snacks/grown/pickle(src)
