/obj/item/clothing/suit/roguetown/shirt/robe/newmage
	name = "mage robe"
	desc = "base mage robe"
	icon_state = "adept-red"
	icon = 'icons/roguetown/clothing/mage.dmi'
	color = null
	slot_flags = ITEM_SLOT_ARMOR
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/mage.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/mage.dmi'
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	allowed_race = NON_DWARVEN_RACE_TYPES	//I don't have the sprites for these, so no shortfolk until a spriter can do it for me.
	boobed = FALSE
	toggle_icon_state = TRUE
	armor = list("blunt" = 15, "slash" = 15, "stab" = 15, "bullet" = 5, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	max_integrity = 200
	color = null
	hoodtype = /obj/item/clothing/head/hooded/magehood
	salvage_result = /obj/item/natural/cloth
	var/picked
	var/newicon
	var/robe_count = 0	/// This var basicly counts the numbers of times this robe has changes its appearence

/obj/item/clothing/suit/roguetown/shirt/robe/newmage/ToggleHood()
	if(!hoodtoggled)
		if(ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			if(slot_flags == ITEM_SLOT_ARMOR)
				if(H.wear_armor != src)
					to_chat(H, span_warning("I should put that on first."))
					return
			if(slot_flags == ITEM_SLOT_CLOAK)
				if(H.cloak != src)
					to_chat(H, span_warning("I should put that on first."))
					return
			if(H.head)
				to_chat(H, span_warning("I'm already wearing something on my head."))
				return

			else if(H.equip_to_slot_if_possible(hood,SLOT_HEAD,0,0,1))
				testing("begintog")
				hoodtoggled = TRUE
				if(!picked)
					if(toggle_icon_state)
						src.icon_state = "[initial(icon_state)]-hood"
				else
					if(toggle_icon_state)
						src.icon_state = "[newicon]-hood"
						hood.icon_state = newicon
				H.update_inv_wear_suit()
				H.update_inv_cloak()
				H.update_inv_neck()
				H.update_inv_pants()
				H.update_fov_angles()

	else
		RemoveHood()
	testing("endtoggle")

/obj/item/clothing/suit/roguetown/shirt/robe/newmage/RemoveHood()
	if(!hood)
		return
	if(!picked)
		src.icon_state = "[initial(icon_state)]"
	else
		src.icon_state = newicon
		hood.icon_state = newicon
	hoodtoggled = FALSE
	if(ishuman(hood.loc))
		var/mob/living/carbon/H = hood.loc
		H.transferItemToLoc(hood, src, TRUE)
		hood.moveToNullspace()
		H.update_inv_wear_suit()
		H.update_inv_cloak()
		H.update_inv_neck()
		H.update_inv_pants()
		H.update_fov_angles()
	else
		hood.moveToNullspace()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/suit/roguetown/shirt/robe/newmage/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 3
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 1

/obj/item/clothing/suit/roguetown/shirt/robe/newmage/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

/obj/item/clothing/suit/roguetown/shirt/robe/newmage/adept
	name = "adept robe"
	desc = "Standard robes for an arcane adept."
	icon_state = "adept-red"
	item_state = "adept-red"
	hoodtype = /obj/item/clothing/head/hooded/magehood/adept



/obj/item/clothing/suit/roguetown/shirt/robe/newmage/adept/MiddleClick(mob/user, params)
	. = ..()
	if(!do_after(user, 20, target = user))
		return
	if(robe_count == 0)
		icon_state = "adept-blue"
		hood.icon_state = "adept-blue"
		newicon = "adept-blue"
		robe_count += 1
	else if(robe_count == 1)
		icon_state = "adept-green"
		hood.icon_state = "adept-green"
		newicon = "adept-green"
		robe_count += 1
	else if(robe_count == 2)
		icon_state = "adept-gray"
		hood.icon_state = "adept-gray"
		newicon = "adept-gray"
		robe_count += 1
	else if(robe_count == 3)
		icon_state = "adept-red"
		hood.icon_state = "adept-red"
		newicon = "adept-red"
		robe_count = 0
	picked = TRUE
	to_chat(user, span_info("[src] magically changes it's colours!"))
	playsound(src, 'sound/magic/swap.ogg', 50, TRUE)


/obj/item/clothing/suit/roguetown/shirt/robe/newmage/sorcerer
	name = "sorcerer robe"
	desc = "Standard robes for an arcane sorcerer."
	icon_state = "sorcerer-red"
	item_state = "sorcerer-red"
	hoodtype = /obj/item/clothing/head/hooded/magehood/sorcerer

/obj/item/clothing/suit/roguetown/shirt/robe/newmage/sorcerer/MiddleClick(mob/user, params)
	. = ..()
	if(!do_after(user, 20, target = user))
		return
	if(robe_count == 0)
		icon_state = "sorcerer-blue"
		hood.icon_state = "sorcerer-blue"
		newicon = "sorcerer-blue"
		robe_count += 1
	else if(robe_count == 1)
		icon_state = "sorcerer-green"
		hood.icon_state = "sorcerer-green"
		newicon = "sorcerer-green"
		robe_count += 1
	else if(robe_count == 2)
		icon_state = "sorcerer-gray"
		hood.icon_state = "sorcerert-gray"
		newicon = "sorcerer-gray"
		robe_count += 1
	else if(robe_count == 3)
		icon_state = "sorcerer-red"
		hood.icon_state = "sorcerer-red"
		newicon = "sorcerer-red"
		robe_count = 0
	picked = TRUE
	to_chat(user, span_info("[src] magically changes it's colours!"))
	playsound(src, 'sound/magic/swap.ogg', 50, TRUE)


/obj/item/clothing/suit/roguetown/shirt/robe/newmage/warlock
	name = "warlock robe"
	desc = "Standard robes for an arcane sorcerer."
	icon_state = "vizier-red"
	item_state = "vizier-red"
	sleevetype = "shirt"
	hoodtype = null

/obj/item/clothing/suit/roguetown/shirt/robe/newmage/warlock/MiddleClick(mob/user, params)
	. = ..()
	if(!do_after(user, 20, target = user))
		return
	if(robe_count == 0)
		icon_state = "vizier-blue"
		newicon = "vizier-blue"
		robe_count += 1
	else if(robe_count == 1)
		icon_state = "vizier-green"
		newicon = "vizier-green"
		robe_count += 1
	else if(robe_count == 2)
		icon_state = "vizier-gray"
		newicon = "vizier-gray"
		robe_count += 1
	else if(robe_count == 3)
		icon_state = "vizier-red"
		newicon = "vizier-red"
		robe_count = 0
	picked = TRUE
	to_chat(user, span_info("[src] magically changes it's colours!"))
	playsound(src, 'sound/magic/swap.ogg', 50, TRUE)


/obj/item/clothing/head/hooded/magehood
	name = "hood"
	desc = ""
	color = null
	icon_state = "adept-red"
	item_state = "adept-red"
	icon = 'icons/roguetown/clothing/magehead.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/magehead.dmi' //Overrides slot icon behavior
	body_parts_covered = NECK
	armor = list("blunt" = 15, "slash" = 15, "stab" = 15, "bullet" = 5, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	max_integrity = 100
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	sleevetype = null
	sleeved = null
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	salvage_amount = 1
	salvage_result = /obj/item/natural/cloth
	flags_inv = HIDEHAIR|HIDEFACIALHAIR//|HIDEEARS
	block2add = FOV_BEHIND
	var/newicon
	var/robe_count = 0	/// This var basicly counts the numbers of times this robe has changes its appearence

/obj/item/clothing/head/hooded/magehood/adept
	name = "hood"
	icon_state = "adept-red"
	item_state = "adept-red"


/obj/item/clothing/head/hooded/magehood/sorcerer
	name = "hood"
	icon_state = "sorcerer-red"
	item_state = "sorcerert-red"
