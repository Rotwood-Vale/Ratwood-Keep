/obj/item/clothing/cloak
	name = "cloak"
	icon = 'icons/roguetown/clothing/cloaks.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	slot_flags = ITEM_SLOT_CLOAK
	desc = "Protects you from the weather and your identity from everyone else."
	edelay_type = 1
	equip_delay_self = 10
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE //Vrell - AFAIK, all cloaks are cloth ATM. Technically semi-less future-proof, but it removes a line of code from every subtype, which is worth it IMO.
	w_class = WEIGHT_CLASS_NORMAL


//////////////////////////
/// TABARD
////////////////////////

/obj/item/clothing/cloak/tabard
	name = "tabard"
	desc = "A long vest meant for knights."
	color = null
	icon_state = "tabard"
	item_state = "tabard"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/detailed/tabards.dmi'
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	boobed = TRUE
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_CLOAK
	flags_inv = HIDECROTCH|HIDEBOOB
	var/picked

/obj/item/clothing/cloak/tabard/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/tabard/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("None", "Symbol", "Split", "Quadrants", "Boxes", "Diamonds")
	if(!design)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	var/symbol_chosen = FALSE
	if(design == "Symbol")
		design = null
		design = input(user, "Select a symbol.","Tabard Design") as null|anything in list("chalice","psy","peace","z","imp","skull","widow","arrow")
		if(!design)
			return
		design = "_[design]"
		symbol_chosen = TRUE
	var/colorone = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
	if(!colorone)
		return
	var/colortwo
	if(design != "None")
		colortwo = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
		if(!colortwo)
			return
	if(world.time > (the_time + 30 SECONDS))
		return
	if(design != "None")
		detail_tag = design
	switch(design)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	boobed_detail = !symbol_chosen
	color = clothing_color2hex(colorone)
	if(colortwo)
		detail_color = clothing_color2hex(colortwo)
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_color = initial(detail_color)
		color = initial(color)
		boobed_detail = initial(boobed_detail)
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/tabard/knight
	color = CLOTHING_PURPLE

/obj/item/clothing/cloak/tabard/knight/attack_right(mob/user)
	return

/obj/item/clothing/cloak/tabard/knight/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/tabard/knight/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/tabard/crusader
	detail_tag = "_psy"
	boobed_detail = FALSE

/obj/item/clothing/cloak/tabard/crusader/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/cloak/tabard/crusader/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("Default", "Gold Cross", "Jeruah", "BlackGold", "BlackWhite")
	if(!design)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	if(design == "Gold Cross")
		detail_color = "#b5b004"
	if(design == "Jeruah")
		detail_color = "#b5b004"
		color = "#249589"
	if(design == "BlackGold")
		detail_color = CLOTHING_YELLOW
		color = CLOTHING_BLACK
	if(design == "BlackWhite")
		detail_color = CLOTHING_WHITE
		color = CLOTHING_BLACK
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_color = initial(detail_color)
		color = initial(color)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/tabard/crusader/tief
	color = CLOTHING_RED
	detail_color = CLOTHING_WHITE

/obj/item/clothing/cloak/tabard/crusader/dendor
	name = "surcoat of the dendorian order"
	icon_state = "tabard_dendor"
	item_state = "tabard_dendor"

/obj/item/clothing/cloak/tabard/crusader/pestra
	name = "surcoat of the pestran order"
	icon_state = "tabard_pestra"
	item_state = "tabard_pestra"

/obj/item/clothing/cloak/tabard/crusader/noc
	name = "surcoat of the lunar order"
	icon_state = "tabard_noc"
	item_state = "tabard_noc"

/obj/item/clothing/cloak/tabard/crusader/noc/alt
	icon_state = "tabard_noc_alt"
	item_state = "tabard_noc_alt"

/obj/item/clothing/cloak/tabard/crusader/eora
	name = "surcoat of the eoran order"
	icon_state = "tabard_eora"
	item_state = "tabard_eora"

/obj/item/clothing/cloak/tabard/crusader/pestra
	name = "surcoat of the pestran order"
	icon_state = "tabard_pestra"
	item_state = "tabard_pestra"

/obj/item/clothing/cloak/tabard/crusader/abyssor
	name = "surcoat of the abyssal order"
	icon_state = "tabard_abyssor"
	item_state = "tabard_abyssor"

/obj/item/clothing/cloak/tabard/crusader/ravox
	name = "surcoat of the ravoxian order"
	icon_state = "tabard_ravox"
	item_state = "tabard_ravox"

/obj/item/clothing/cloak/tabard/crusader/xylix
	name = "surcoat of the xylixian order"
	icon_state = "tabard_xylix"
	item_state = "tabard_xylix"

/obj/item/clothing/cloak/tabard/crusader/tief/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("Default", "RedBlack", "BlackRed")
	if(!design)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	if(design == "RedBlack")
		detail_color = CLOTHING_BLACK
		color = CLOTHING_RED
	if(design == "BlackRed")
		detail_color = CLOTHING_RED
		color = CLOTHING_BLACK
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_color = initial(detail_color)
		color = initial(color)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/tabard/knight/guard
	desc = "A tabard with the lord's heraldic colors."
	color = CLOTHING_RED
	detail_tag = "_spl"
	detail_color = CLOTHING_PURPLE

/obj/item/clothing/cloak/tabard/knight/guard/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/chosen = input(user, "Select a design.","Tabard Design") as null|anything in list("Split", "Quadrants", "Boxes", "Diamonds")
	if(world.time > (the_time + 10 SECONDS))
		return
	if(!chosen)
		return
	switch(chosen)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/tabard/knight/guard/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/tabard/knight/guard/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/tabard/knight/guard/lordcolor(primary,secondary)
	color = primary
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/tabard/knight/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/tabard/musketeer
	detail_tag = "_psy"
	color = CLOTHING_BLUE
	detail_color = CLOTHING_WHITE


//////////////////////////
/// SOLDIER TABARD
////////////////////////

/obj/item/clothing/cloak/stabard
	name = "surcoat"
	desc = "A medieval overcoat meant to be used over the armor."
	icon_state = "stabard"
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	boobed = TRUE
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/detailed/tabards.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/detailed/tabards.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_CLOAK
	flags_inv = HIDECROTCH|HIDEBOOB
	var/picked

/obj/item/clothing/cloak/stabard/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("None","Split", "Quadrants", "Boxes", "Diamonds")
	if(!design)
		return
	var/colorone = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
	if(!colorone)
		return
	var/colortwo
	if(design != "None")
		colortwo = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
		if(!colortwo)
			return
	if(world.time > (the_time + 30 SECONDS))
		return
	switch(design)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	color = clothing_color2hex(colorone)
	if(colortwo)
		detail_color = clothing_color2hex(colortwo)
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_color = initial(detail_color)
		color = initial(color)
		boobed_detail = initial(boobed_detail)
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/stabard/guard
	name = "guard tabard"
	desc = "A tabard with the lord's heraldic colors."
	color = CLOTHING_RED
	detail_tag = "_spl"
	detail_color = CLOTHING_PURPLE

/obj/item/clothing/cloak/stabard/guard/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/chosen = input(user, "Select a design.","Tabard Design") as null|anything in list("Split", "Quadrants", "Boxes", "Diamonds")
	if(world.time > (the_time + 10 SECONDS))
		return
	if(!chosen)
		return
	switch(chosen)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/stabard/guard/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/stabard/guard/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/stabard/guard/lordcolor(primary,secondary)
	color = primary
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/stabard/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/raincloak/vanguard
	name = "vanguard cloak"
	desc = "A nightly cloak worn by those that protect the citizenry from what lurks beyond" // THE BOG DESERVES A BETTER DESCRIPTION!
	color = CLOTHING_VANGUARD
	detail_color = CLOTHING_VANGUARD_DETAIL


/obj/item/clothing/cloak/stabard/grenzelhoft
	name = "grenzelhoft mercenary tabard"
	desc = "A tabard bearing the colors of the Grenzelhoft Free Corps"
	color = CLOTHING_YELLOW
	detail_color = CLOTHING_RED
	detail_tag = "_box"

/obj/item/clothing/cloak/stabard/dungeon
	color = CLOTHING_BLACK

/obj/item/clothing/cloak/stabard/dungeon/attack_right(mob/user)
	return

/obj/item/clothing/cloak/stabard/mercenary
	detail_tag = "_quad"

/obj/item/clothing/cloak/stabard/mercenary/Initialize()
	. = ..()
	detail_tag = pick("_quad", "_spl", "_box", "_dim")
	color = clothing_color2hex(pick(CLOTHING_COLOR_NAMES))
	detail_color = clothing_color2hex(pick(CLOTHING_COLOR_NAMES))
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

//////////////////////////
/// SURCOATS
////////////////////////

/obj/item/clothing/cloak/stabard/surcoat
	name = "jupon"
	icon_state = "surcoat"

/obj/item/clothing/cloak/stabard/surcoat/marshal
	color = "#641E16"

/obj/item/clothing/cloak/stabard/surcoat/councillor
	color = "#2d2d2d"

/obj/item/clothing/cloak/stabard/surcoat/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("None","Split", "Quadrants", "Boxes", "Diamonds")
	if(!design)
		return
	var/colorone = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
	if(!colorone)
		return
	var/colortwo
	if(design != "None")
		colortwo = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
		if(!colortwo)
			return
	if(world.time > (the_time + 30 SECONDS))
		return
	switch(design)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	color = clothing_color2hex(colorone)
	if(colortwo)
		detail_color = clothing_color2hex(colortwo)
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_color = initial(detail_color)
		color = initial(color)
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/stabard/surcoat/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/stabard/surcoat/guard
	desc = "A surcoat with the lord's heraldic colors."
	color = CLOTHING_RED
	detail_tag = "_quad"
	detail_color = CLOTHING_PURPLE

/obj/item/clothing/cloak/stabard/surcoat/guard/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/chosen = input(user, "Select a design.","Tabard Design") as null|anything in list("Split", "Quadrants", "Boxes", "Diamonds")
	if(world.time > (the_time + 10 SECONDS))
		return
	if(!chosen)
		return
	switch(chosen)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE


/obj/item/clothing/cloak/stabard/surcoat/guard/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/stabard/surcoat/guard/lordcolor(primary,secondary)
	color = primary
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/stabard/surcoat/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/lordcloak
	name = "lordly cloak"
	desc = "Ermine trimmed, handed down."
	color = null
	icon_state = "lord_cloak"
	item_state = "lord_cloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	boobed = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = TRUE
//	allowed_sex = list(MALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	detail_tag = "_det"
	detail_color = CLOTHING_PURPLE

/obj/item/clothing/cloak/lordcloak/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/lordcloak/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/lordcloak/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/lordcloak/Destroy()
	GLOB.lordcolor -= src
	return ..()


/obj/item/clothing/cloak/lordcloak/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 4
		STR.max_w_class = WEIGHT_CLASS_BULKY
		STR.max_items = 1

/obj/item/clothing/cloak/lordcloak/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

/obj/item/clothing/cloak/apron
	name = "apron"
	desc = "An apron used by many workshop workers."
	color = null
	icon_state = "apron"
	item_state = "apron"
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	boobed = TRUE
	allowed_race = CLOTHED_RACES_TYPES
	flags_inv = HIDECROTCH|HIDEBOOB
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/cloak/apron/blacksmith
	name = "leather apron"
	desc = "A leather apron used by those who temper metals and work forges."
	color = null
	icon_state = "leather_apron"
	item_state = "leather_apron"
	body_parts_covered = CHEST|GROIN
	armor = list("blunt" = 25, "slash" = 5, "stab" = 15, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 24, "acid" = 0)
	boobed = TRUE
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/cloak/apron/brown
	color = CLOTHING_BROWN

/obj/item/clothing/cloak/apron/waist
	name = "apron"
	desc = "An apron used by many workshop workers."
	color = null
	icon_state = "waistpron"
	item_state = "waistpron"
	body_parts_covered = null
	boobed = FALSE
	flags_inv = HIDECROTCH

/obj/item/clothing/cloak/apron/waist/brown
	color = CLOTHING_BROWN

/obj/item/clothing/cloak/apron/waist/bar
	color = "#251f1d"


/obj/item/clothing/cloak/apron/cook
	name = "cook apron"
	desc = "An apron meant to show how clean the cook is."
	color = null
	icon_state = "aproncook"
	item_state = "aproncook"
	body_parts_covered = CHEST
	boobed = FALSE
	flags_inv = HIDECROTCH|HIDEBOOB

/*
/obj/item/clothing/cloak/apron/waist/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 21
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.max_items = 1

/obj/item/clothing/cloak/apron/waist/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	CP.on_attack_hand(CP, user)
	return TRUE*/

/obj/item/clothing/cloak/raincloak
	name = "cloak"
	desc = "This one will help against the rainy weather."
	color = null
	icon_state = "rain_cloak"
	item_state = "rain_cloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
//	body_parts_covered = ARMS|CHEST
	boobed = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = TRUE
	hoodtype = /obj/item/clothing/head/hooded/rainhood
	toggle_icon_state = FALSE
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/wash_act(clean)
	. = ..()
	if(hood)
		wash_atom(hood,clean)

/obj/item/clothing/cloak/raincloak/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 3
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 1

/obj/item/clothing/cloak/raincloak/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))



/obj/item/clothing/cloak/raincloak/red
	color = CLOTHING_RED

/obj/item/clothing/cloak/raincloak/mortus
	name = "funeral cloak"
	desc = "A cloak worn by morticians on their solemn task of putting the dead to rest."
	color = CLOTHING_BLACK

/obj/item/clothing/cloak/raincloak/brown
	color = CLOTHING_BROWN

/obj/item/clothing/cloak/raincloak/green
	color = CLOTHING_GREEN

/obj/item/clothing/cloak/raincloak/blue
	color = CLOTHING_BLUE

/obj/item/clothing/cloak/raincloak/purple
	color = CLOTHING_PURPLE

/obj/item/clothing/head/hooded/rainhood
	name = "hood"
	desc = "This one will shelter you from the weather and hide your identity too."
	icon_state = "rain_hood"
	item_state = "rain_hood"
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	edelay_type = 1
	body_parts_covered = HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDETAIL
	block2add = FOV_BEHIND

/obj/item/clothing/head/hooded/equipped(mob/user, slot)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/head/hooded/dropped(mob/user)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/cloak/raincloak/furcloak
	name = "fur cloak"
	desc = "This glorious cloak is made of animal fur. Very soft and warm."
	icon_state = "furgrey"
	inhand_mod = FALSE
	hoodtype = /obj/item/clothing/head/hooded/rainhood/furhood
	salvage_amount = 1
	salvage_result = /obj/item/natural/fur

/obj/item/clothing/cloak/raincloak/furcloak/crafted/Initialize()
	. = ..()
	if(prob(50))
		color = pick("#685542","#66564d")

/obj/item/clothing/cloak/raincloak/furcloak/brown
	color = "#685542"

/obj/item/clothing/cloak/raincloak/furcloak/black
	color = "#66564d"

/obj/item/clothing/head/hooded/rainhood/furhood
	icon_state = "fur_hood"
	block2add = FOV_BEHIND

/obj/item/clothing/cloak/cape
	name = "cape"
	desc = "A beautiful, flowing cape. Too bad it tangles too much on the vegetation."
	color = null
	icon_state = "cape"
	item_state = "cape"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	boobed = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = FALSE
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK

/obj/item/clothing/cloak/cape/purple
	color = "#801380"

/obj/item/clothing/cloak/cape/knight
	color = CLOTHING_PURPLE

/obj/item/clothing/cloak/cape/guard
	color = CLOTHING_RED

/obj/item/clothing/cloak/cape/black
	color = CLOTHING_BLACK

/obj/item/clothing/cloak/cape/guard/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src
/obj/item/clothing/cloak/cape/guard/lordcolor(primary,secondary)
	color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
/obj/item/clothing/cloak/cape/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()


/obj/item/clothing/cloak/cape/puritan
	icon_state = "puritan_cape"
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/cloak/cape/archivist
	icon_state = "puritan_cape"
	color = CLOTHING_BLACK
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/cloak/cape/rogue
	name = "cape"
	icon_state = "roguecape"
	item_state = "roguecape"

/obj/item/clothing/cloak/cape/hood
	name = "hooded cape"
	icon_state = "hoodcape"
	item_state = "hoodcape"

/obj/item/clothing/cloak/cape/fur
	name = "fur cape"
	icon_state = "furcape"
	item_state = "furcape"
	inhand_mod = TRUE

/obj/item/clothing/cloak/chasuble
	name = "chasuble"
	desc = ""
	icon_state = "chasuble"
	body_parts_covered = CHEST|GROIN|ARMS
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	slot_flags = ITEM_SLOT_CLOAK
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	nodismemsleeves = TRUE


/obj/item/clothing/cloak/stole
	name = "stole"
	desc = "Garments of a priest, usually worn when giving mass to the people."
	icon_state = "stole_gold"
	sleeved = null
	sleevetype = null
	body_parts_covered = null
	flags_inv = null

/obj/item/clothing/cloak/stole/red
	icon_state = "stole_red"

/obj/item/clothing/cloak/stole/purple
	icon_state = "stole_purple"

/obj/item/clothing/cloak/black_cloak
	name = "fur coat"
	desc = ""
	icon_state = "black_cloak"
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	slot_flags = ITEM_SLOT_CLOAK
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	sellprice = 50
	nodismemsleeves = TRUE

/obj/item/clothing/cloak/heartfelt
	name = "red cloak"
	desc = ""
	icon_state = "heartfelt_cloak"
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	slot_flags = ITEM_SLOT_CLOAK
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	sellprice = 50
	nodismemsleeves = TRUE

/obj/item/clothing/cloak/half
	name = "halfcloak"
	desc = "A cloak designed to cover one half of the body predominantly over the other."
	color = null
	icon_state = "halfcloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
//	body_parts_covered = ARMS|CHEST
	boobed = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = TRUE
	hoodtype = null
	toggle_icon_state = FALSE
	color = CLOTHING_BLACK
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	flags_inv = null
	w_class = WEIGHT_CLASS_SMALL
	salvage_amount = 1

/obj/item/clothing/cloak/half/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 3
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 1

/obj/item/clothing/cloak/half/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

/obj/item/clothing/cloak/half/brown
	color = CLOTHING_BROWN

/obj/item/clothing/cloak/half/red
	color = CLOTHING_RED

/obj/item/clothing/cloak/half/orange
	color = CLOTHING_ORANGE

/obj/item/clothing/cloak/half/vet
	name = "town watch cloak"
	icon_state = "guardcloak"
	color = CLOTHING_RED
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	inhand_mod = FALSE

/obj/item/clothing/cloak/half/vet/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/half/vet/Destroy()
	GLOB.lordcolor -= src
	return ..()

// Dumping old black knight stuff here
/obj/item/clothing/cloak/cape/blkknight
	name = "blood cape"
	icon_state = "bkcape"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'

/obj/item/clothing/head/roguetown/helmet/heavy/blkknight
	name = "blacksteel helmet"
	icon_state = "bkhelm"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/clothing/cloak/tabard/blkknight
	name = "blood sash"
	icon_state = "bksash"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/clothing/under/roguetown/platelegs/blk
	name = "blacksteel legs"
	icon_state = "bklegs"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	w_class = WEIGHT_CLASS_BULKY

/obj/item/clothing/gloves/roguetown/plate/blk
	name = "blacksteel gaunties"
	icon_state = "bkgloves"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/neck/roguetown/blkknight
	name = "dragonscale necklace"
	desc = ""
	icon_state = "bktrinket"
	max_integrity = 100000
	armor = list("blunt" = 100, "slash" = 100, "stab" = 100, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0)
	prevent_crits = list(BCLASS_CUT,BCLASS_BLUNT)
	blocksound = PLATEHIT
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 666
	static_price = TRUE
	var/active_item = FALSE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/neck/roguetown/blkknight/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	active_item = TRUE
	if(user.mind.special_role == "Bandit")
		to_chat(user, span_notice("I feel bolstered by Matthios Power!..."))
		user.change_stat("strength", 2)
		user.change_stat("perception", 2)
		user.change_stat("intelligence", 2)
		user.change_stat("constitution", 2)
		user.change_stat("endurance", 2)
		user.change_stat("speed", 2)
		armor = getArmor("blunt" = 100, "slash" = 100, "stab" = 100, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0)
	else
		to_chat(user, span_notice("I feel an evil power about that necklace.."))
		armor = getArmor("blunt" = 0, "slash" = 0, "stab" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/neck/roguetown/blkknight/dropped(mob/living/user)
	if(!active_item)
		return
	active_item = FALSE
	if(user.mind.special_role == "Bandit")
		to_chat(user, span_notice("I've removed the necklace of Matthios..."))
		user.change_stat("strength", -2)
		user.change_stat("perception", -2)
		user.change_stat("intelligence", -2)
		user.change_stat("constitution", -2)
		user.change_stat("endurance", -2)
		user.change_stat("speed", -2)
	else
		to_chat(user, span_notice("Strange, I don't feel that power anymore.."))
		armor = getArmor("blunt" = 100, "slash" = 100, "stab" = 100, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0)

/obj/item/clothing/suit/roguetown/armor/plate/blkknight
	slot_flags = ITEM_SLOT_ARMOR
	name = "blacksteel plate"
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	icon_state = "bkarmor"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	w_class = WEIGHT_CLASS_BULKY

/obj/item/clothing/shoes/roguetown/armor/steel/blkknight
	name = "blacksteel boots"
	icon_state = "bkboots"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	w_class = WEIGHT_CLASS_SMALL

//Short hoods for guards

/obj/item/clothing/cloak/stabard/guardhood
	name = "guard hood"
	desc = "A hood with the lord's heraldic colors."
	color = CLOTHING_RED
	detail_tag = "_spl"
	detail_color = CLOTHING_PURPLE
	icon_state = "guard_hood"
	body_parts_covered = CHEST

/obj/item/clothing/cloak/stabard/guardhood/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/chosen = input(user, "Select a design.","Tabard Design") as null|anything in list("Split")
	if(world.time > (the_time + 10 SECONDS))
		return
	if(!chosen)
		return
	switch(chosen)
		if("Split")
			detail_tag = "_spl"
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/stabard/guardhood/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/stabard/guardhood/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/stabard/guardhood/lordcolor(primary,secondary)
	color = primary
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/stabard/guardhood/Destroy()
	GLOB.lordcolor -= src
	return ..()

///////////////////////////
///                     ///
///   TEMPLAR CLOAKS    ///
///                     ///
///////////////////////////

/obj/item/clothing/cloak/templar/astratan
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	alternate_worn_layer = TABARD_LAYER
	boobed = FALSE
	name = "astratan tabard"
	desc = "The washed out golds of an asratan crusader adorn these fine robes."
	icon_state = "astratatabard"

/obj/item/clothing/cloak/templar/malummite
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	alternate_worn_layer = TABARD_LAYER
	boobed = FALSE
	name = "malummite tabard"
	desc = "Light blacks and greys, with a tinge of red, the everlasting fire of Malum's iron hammer as it strikes."
	icon_state = "malumtabard"

/obj/item/clothing/cloak/templar/necran
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	alternate_worn_layer = TABARD_LAYER
	boobed = FALSE
	name = "necran tabard"
	desc = "Deep dark blacks, swallowing all light as if the night itself."
	icon_state = "necratabard"

//Below are a couple tabards from Azure

/obj/item/clothing/cloak/templar/pestran
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	alternate_worn_layer = TABARD_LAYER
	boobed = FALSE
	name = "pestran tabard"
	desc = "An earthly green."
	icon_state = "pestratabard"

/obj/item/clothing/cloak/templar/psydon
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	alternate_worn_layer = TABARD_LAYER
	boobed = FALSE
	name = "psydon tabard"
	desc = "Fading tabard, still serving his will."
	icon_state = "psydontabard"

/obj/item/clothing/cloak/templar/abyssor
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	alternate_worn_layer = TABARD_LAYER
	boobed = FALSE
	name = "abyssor tabard"
	desc = "Flowing in the colors of the great sea."
	icon_state = "abyssortabard"

/obj/item/clothing/cloak/fauld
	name = "fauld"
	desc = "A piece of cloth usually worn to cover the hips and part of the legs."
	color = null
	icon_state = "faulds"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = LEGS|GROIN
	slot_flags = ITEM_SLOT_CLOAK|ITEM_SLOT_PANTS
	flags_inv = HIDECROTCH
	detail_tag = "_belt"

/obj/item/clothing/cloak/fauld/update_icon()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/fauld/battleskirt
	name = "battle skirt"
	desc = "A skirt usually worn on battle with the colors of the wearer."
	icon_state = "battleskirt"

/obj/item/clothing/cloak/fauld/battleskirt/update_icon()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/stabard/crusader
	name = "surcoat of the golden order"
	icon_state = "crusader_surcoat"
	icon = 'icons/roguetown/clothing/special/crusader.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/crusader.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/crusader.dmi'

/obj/item/clothing/cloak/stabard/crusader/t
	name = "surcoat of the silver order"
	icon_state = "crusader_surcoatt2"

/obj/item/clothing/cloak/cape/crusader
	name = "desert cape"
	icon_state = "crusader_cloak"
	icon = 'icons/roguetown/clothing/special/crusader.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/crusader.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/crusader.dmi'

/obj/item/clothing/cloak/cape/crusader/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 3
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 1

/obj/item/clothing/cloak/cape/crusader/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE
	..()

/obj/item/clothing/cloak/cape/crusader/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

//----------------- NEW/CLOAKS.DM ---------------------

/obj/item/clothing/cloak/shadow
	name = "vanguard cloak"
	desc = "A nightly cloak worn by those that protect the citizenry from what lurks beyond."
	icon = 'icons/roguetown/clothing/cloaks.dmi'
	icon_state = "shadowcloak"
	item_state = "shadowcloak"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	nodismemsleeves = TRUE
	inhand_mod = TRUE
	toggle_icon_state = FALSE
	salvage_result = /obj/item/natural/silk

/obj/item/clothing/cloak/shadow/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 3
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 1

/obj/item/clothing/cloak/shadow/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

//----------------- INFAREDBARON/CLOAKS.DM ---------------------

/obj/item/clothing/cloak/citywatch
	name = "citywatch cape"
	desc = ""
	icon = 'icons/roguetown/clothing/licensed-infraredbaron/cloaks.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/licensed-infraredbaron/onmob/cloaks.dmi'
	icon_state = "citywatch_cape"
	item_state = "citywatch_cape"

//----------------- MORE AZURE SPRITEWORK ---------------------

/obj/item/clothing/cloak/hierophant
	name = "hierophant's sash"
	icon_state = "naledisash"
	item_state = "naledisash"
	desc = "A limp piece of fabric traditionally used to fasten bags that are too baggy, but in modern days has become more of a fashion statement than anything."

/obj/item/clothing/cloak/lordcloak/ladycloak // Another with _detail will need aid on this one
	name = "ladylike shortcloak"
	desc = "Ermine trimmed, handed down."
	color = null
	icon_state = "shortcloak"
	item_state = "shortcloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	boobed = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	detail_tag = "_detail"
	detail_color = CLOTHING_BLACK

/obj/item/clothing/cloak/matron
	name = "matron cloak"
	desc = "A cloak that only the meanest of old crones bother to wear."
	icon_state = "matroncloak"
	icon = 'icons/roguetown/clothing/cloaks.dmi'
	mob_overlay_icon ='icons/roguetown/clothing/onmob/cloaks.dmi'
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	slot_flags = ITEM_SLOT_CLOAK
	nodismemsleeves = TRUE
	sleevetype = "shirt"
	slot_flags = ITEM_SLOT_CLOAK

/obj/item/clothing/cloak/wickercloak
	name = "wicker cloak"
	desc = "A makeshift cloak constructed with mud, sticks and fibers."
	icon_state = "wicker_cloak"
	item_state = "wicker_cloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	allowed_sex = list(MALE, FEMALE)
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = TRUE

/obj/item/clothing/cloak/cape/inquisitor
	name = "inquisitors cloak"
	desc = "A time honored cloak Valorian design, used by founding clans of the Valorian Lodge"
	icon_state = "inquisitor_cloak"
	icon = 'icons/roguetown/clothing/cloaks.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'

/obj/item/clothing/cloak/tribal
	name = "tribal pelt"
	desc = "A haphazardly cured pelt of a creecher, thrown on top of one's body or armor, to serve as additional protection against the cold. Itchy."
	icon_state = "tribal"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	body_parts_covered = CHEST|GROIN|VITALS
	allowed_sex = list(MALE, FEMALE)
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	nodismemsleeves = TRUE
	boobed = FALSE
	sellprice = 10

/obj/item/clothing/cloak/battlenun
	name = "nun vestments"
	desc = "Chaste, righteous, merciless to the wicked."
	color = null
	icon_state = "battlenun"
	allowed_sex = list(FEMALE)
	item_state = "battlenun"
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_CLOAK

/obj/item/clothing/cloak/volfmantle
	name = "volf mantle"
	desc = "A warm cloak made using the hide and head of a slain volf. A status symbol if ever there was one."
	color = null
	icon_state = "volfpelt"
	item_state = "volfpelt"
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = FALSE
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	flags_inv = HIDECROTCH|HIDEBOOB
