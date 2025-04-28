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
	sewrepair = TRUE
	fiber_salvage = TRUE
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured
	var/datum/wound/artery/artery_wound

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

	// later...
/*
/obj/item/storage/belt/rogue
	var/datum/wound/artery/artery_wound

	// Other properties...

/obj/item/storage/belt/rogue/attack(mob/living/M, mob/user)
	if(!M.can_inject(user, TRUE)) return
	if(!ishuman(M)) return

	var/mob/living/carbon/human/H = M
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) return
	if(affecting.bandage)
		to_chat(user, "There is already a dressing.")
		return

	var/used_time = 10 // 1 second in deciseconds
	if(H.mind) used_time -= (H.mind.get_skill_level(/datum/skill/misc/treatment) * 10)

	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	if(!do_mob(user, M, used_time)) return
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	user.dropItemToGround(src)

	// Temporarily stop bleeding without removing the wound
	if(affecting.bleeding)
		affecting.try_bandage(src) // Handle standard wound bandaging

	if(affecting.artery_bleed)
		affecting.artery_bleed = FALSE
		artery_wound = affecting.get_wound(/datum/wound/artery) // Store the artery wound

	// Inflict continuous 0.5 brute damage every second while applied
	addtimer(CALLBACK(affecting, /proc/apply_continuous_brute_damage), 10, 10, TRUE)

	H.update_damage_overlays()
	to_chat(user, "You quickly slip and tourniquet the [src] to stop the bleeding on [M]'s [affecting.name]. you really shouldn't leave the on forever.")
	user.visible_message("You quickly tourniquet your [affecting.name]. with the [src]! you shouldn't leave this on too long.")

/obj/item/storage/belt/rogue/proc/apply_continuous_brute_damage()
	var/mob/living/carbon/human/H = M
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) return
	affecting.take_damage(1, "brute")
	H.update_damage_overlays()

/obj/item/storage/belt/rogue/remove(mob/living/M, mob/user)
	if(!M.can_inject(user, TRUE)) return
	if(!ishuman(M)) return

	var/mob/living/carbon/human/H = M
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) return

	// Stop the continuous brute damage timer
	addtimer(CALLBACK(affecting, /obj/item/storage/belt/rogue/proc/apply_continuous_brute_damage), 0, 0, FALSE)

	// Resume the bleeding when the belt is removed
	if(artery_wound)
		affecting.artery_bleed = TRUE
		artery_wound = null // Clear the reference

		// Resume standard bleeding
	if(affecting.bandage)
		affecting.bandage = FALSE
		affecting.bleeding = TRUE

	to_chat(user, "You remove the belt, and blood resumes squirting from [M]'s [affecting.name].") */

/obj/item/storage/belt/rogue/leather
	name = "belt"
	desc = "A leather belt."
	icon_state = "leather"
	item_state = "leather"
	equip_sound = 'sound/blank.ogg'
	heldz_items = 3

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
	smeltresult = /obj/item/ingot/gold
	anvilrepair = /datum/skill/craft/blacksmithing

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
	smeltresult = /obj/item/ingot/silver
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/storage/belt/rogue/leather/steel
	name = "steel belt"
	desc = "A belt with a steel plate on its front."
	icon_state = "steelplaque"
	sellprice = 30
	sewrepair = FALSE
	smeltresult = /obj/item/ingot/steel
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/storage/belt/rogue/leather/rope
	name = "rope belt"
	desc = "A simple belt made of rope."
	icon_state = "rope"
	item_state = "rope"
	color = "#b9a286"
	heldz_items = 1
	salvage_result = /obj/item/rope

/obj/item/storage/belt/rogue/leather/cloth
	name = "cloth sash"
	desc = "A simple cloth sash."
	icon_state = "cloth"
	heldz_items = 1
	salvage_result = /obj/item/natural/cloth

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
	fiber_salvage = FALSE

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
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)

/obj/item/storage/belt/rogue/pouch/ammo
	name = "sphere pouch"
	desc = "Usually used for holding runelock sphreres."

/obj/item/storage/belt/rogue/pouch/ammo/PopulateContents()
	new /obj/item/ammo_casing/caseless/runelock(src)
	new /obj/item/ammo_casing/caseless/runelock(src)
	new /obj/item/ammo_casing/caseless/runelock(src)

/obj/item/storage/backpack/rogue //holding salvage vars for children
	sewrepair = TRUE
	fiber_salvage = TRUE
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

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

/obj/item/storage/backpack/rogue/satchel/musketeer/PopulateContents()
	new /obj/item/powderflask(src)
	new /obj/item/storage/belt/rogue/pouch/coins/mid(src)

/obj/item/storage/backpack/rogue/satchel/black
	color = CLOTHING_BLACK

/obj/item/storage/backpack/rogue/satchel/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 18
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 4
		STR.click_gather = TRUE
		STR.allow_quick_empty = TRUE
		STR.allow_dump_out = TRUE


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

/obj/item/storage/backpack/rogue/backpack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 42
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 14
		STR.not_while_equipped = TRUE
		STR.allow_dump_out = TRUE

/obj/item/storage/backpack/rogue/backpack/rucksack
	name = "rucksack"
	desc = "A bulky backpack worn on the back which can store many items."
	icon_state = "rucksack"
	item_state = "rucksack"
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = NONE
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE

/obj/item/storage/backpack/rogue/backpack/rucksack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 42
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 10
		STR.not_while_equipped = TRUE

/obj/item/storage/backpack/rogue/backpack/artibackpack
	name = "Cooling backpack"
	desc = "A leather backpack with complex pipework coursing through it. It hums and vibrates constantly."
	icon_state = "artibackpack"
	item_state = "artibackpack"
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK_L
	resistance_flags = FIRE_PROOF
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	sewrepair = FALSE

/obj/item/storage/backpack/rogue/backpack/artibackpack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 42
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 10
		STR.not_while_equipped = TRUE
/obj/item/storage/belt/rogue/leather/exoticsilkbelt
	name = "exotic silk belt"
	desc = "A gold adorned belt with the softest of silks barely concealing one's bits."
	icon_state = "exoticsilkbelt"
	heldz_items = 1
	sewrepair = TRUE


/obj/item/storage/belt/rogue/leather/overseer
    name = "belt with pouches"
    desc = "Leather belt with some pouches attached."
    icon_state = "overseerbelt"
    item_state = "overseerbelt"
    icon = 'icons/roguetown/clothing/inquisition_overseers/overseer.dmi'
    mob_overlay_icon = 'icons/roguetown/clothing/inquisition_overseers/onmob/overseer_onmob.dmi'
    sellprice = 15
    w_class = WEIGHT_CLASS_BULKY

//----------------- MORE AZURE SPRITEWORK ---------------------

/obj/item/storage/belt/rogue/leather/plaquegold/steward
	name = "fancy gold belt"
	desc = "A dark belt with real gold making up the buckle and highlights. How bougie."
	icon_state = "stewardbelt"
	item_state = "stewardbelt"
	heldz_items = 3

/* Commented out as this knife belt is for "throwing knives" and I am unsure we have those here.

	name = "tossblade belt"
	desc = "A many-slotted belt meant for tossblades. Little room left over."
	icon_state = "knife"
	item_state = "knife"
	strip_delay = 20
	max_storage = 8
	var/list/arrows = list()
	sewrepair = TRUE
	component_type = /datum/component/storage/concrete/roguetown/belt/knife_belt

/obj/item/storage/belt/rogue/leather/knifebelt/attack_turf(turf/T, mob/living/user)
	if(arrows.len >= max_storage)
		to_chat(user, span_warning("Your [src.name] is full!"))
		return
	to_chat(user, span_notice("You begin to gather the ammunition..."))
	for(var/obj/item/rogueweapon/huntingknife/throwingknife/arrow in T.contents)
		if(do_after(user, 5))
			if(!eatarrow(arrow))
				break

/obj/item/storage/belt/rogue/leather/knifebelt/proc/eatarrow(obj/A)
	if(A.type in subtypesof(/obj/item/rogueweapon/huntingknife/throwingknife))
		if(arrows.len < max_storage)
			A.forceMove(src)
			arrows += A
			update_icon()
			return TRUE
		else
			return FALSE

/obj/item/storage/belt/rogue/leather/knifebelt/attackby(obj/A, loc, params)
	if(A.type in subtypesof(/obj/item/rogueweapon/huntingknife/throwingknife))
		if(arrows.len < max_storage)
			if(ismob(loc))
				var/mob/M = loc
				M.doUnEquip(A, TRUE, src, TRUE, silent = TRUE)
			else
				A.forceMove(src)
			arrows += A
			update_icon()
			to_chat(usr, span_notice("I discreetly slip [A] into [src]."))
		else
			to_chat(loc, span_warning("Full!"))
		return
	..()

/obj/item/storage/belt/rogue/leather/knifebelt/attack_right(mob/user)
	if(arrows.len)
		var/obj/O = arrows[arrows.len]
		arrows -= O
		O.forceMove(user.loc)
		user.put_in_hands(O)
		update_icon()
		return TRUE

/obj/item/storage/belt/rogue/leather/knifebelt/examine(mob/user)
	. = ..()
	if(arrows.len)
		. += span_notice("[arrows.len] inside.")

/obj/item/storage/belt/rogue/leather/knifebelt/iron/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/iron/A = new()
		arrows += A
	update_icon()


/obj/item/storage/belt/rogue/leather/knifebelt/black

	icon_state = "blackknife"
	item_state = "blackknife"

/obj/item/storage/belt/rogue/leather/knifebelt/black/iron/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/iron/A = new()
		arrows += A
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black/steel/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/steel/A = new()
		arrows += A
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black/psydon/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/psydon/A = new()
		arrows += A
	update_icon()

*/

/*
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
	sewrepair = FALSE

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

*/
