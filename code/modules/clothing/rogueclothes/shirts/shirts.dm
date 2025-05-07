/obj/item/clothing/suit/roguetown/shirt
	slot_flags = ITEM_SLOT_SHIRT
	body_parts_covered = CHEST|VITALS
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	equip_sound = 'sound/blank.ogg'
	drop_sound = 'sound/blank.ogg'
	pickup_sound =  'sound/blank.ogg'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts.dmi'
	sleevetype = "shirt"
	edelay_type = 1
	equip_delay_self = 25
	bloody_icon_state = "bodyblood"
	boobed = TRUE
	sewrepair = TRUE
	flags_inv = HIDEBOOB
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/suit/roguetown/shirt/undershirt
	name = "shirt"
	desc = ""
	icon_state = "undershirt"
	item_state = "undershirt"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	body_parts_covered = CHEST|ARMS|VITALS

/obj/item/clothing/suit/roguetown/shirt/undershirt/priest
	name = "undervestments"
	desc = ""
	icon_state = "priestunder"
	sleeved = null
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	// Has sprite without crop for hands AND no sleeves

/obj/item/clothing/suit/roguetown/shirt/undershirt/black
	color = CLOTHING_BLACK

/obj/item/clothing/suit/roguetown/shirt/undershirt/purple
	color = CLOTHING_PURPLE

/obj/item/clothing/suit/roguetown/shirt/undershirt/brown
	color = "#6b5445"

/obj/item/clothing/suit/roguetown/shirt/undershirt/lord
	desc = ""
	color = "#616898"

/obj/item/clothing/suit/roguetown/shirt/undershirt/red
	color = "#851a16"

/obj/item/clothing/suit/roguetown/shirt/undershirt/guard
	color = CLOTHING_RED

/obj/item/clothing/suit/roguetown/shirt/undershirt/guard/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/shirt/undershirt/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()


/obj/item/clothing/suit/roguetown/shirt/undershirt/guardsecond
	color = CLOTHING_PURPLE

/obj/item/clothing/suit/roguetown/shirt/undershirt/guardsecond/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/shirt/undershirt/guardsecond/lordcolor(primary,secondary)
	if(secondary)
		color = secondary

/obj/item/clothing/suit/roguetown/shirt/undershirt/guardsecond/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/suit/roguetown/shirt/undershirt/random/Initialize()
	color = pick("#6b5445", "#435436", "#704542", "#79763f")
	return ..()

/obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
	name = "formal silks"
	icon_state = "puritan_shirt"
	allowed_race = CLOTHED_RACES_TYPES
	salvage_result = /obj/item/natural/silk
	ignore_sleeves_code = TRUE // No sleeves, otherwise arms will be over the sprite

/obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	icon_state = "sailorblues"

/obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
	icon_state = "sailorreds"

/obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	r_sleeve_status = SLEEVE_TORN
	body_parts_covered = CHEST|ARM_LEFT|VITALS
	torn_sleeve_number = 1

/obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_TORN
	body_parts_covered = CHEST|ARM_RIGHT|VITALS

/obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/Initialize()
	color = pick("#6b5445", "#435436", "#704542", "#79763f")
	return ..()

/obj/item/clothing/suit/roguetown/shirt/shortshirt
	name = "shirt"
	desc = "A simple shirt."
	icon_state = "shortshirt"
	item_state = "shortshirt"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/shortshirt/random/Initialize()
	color = pick("#6b5445", "#435436", "#704542", "#79763f")
	return ..()

/obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	name = "shirt"
	desc = ""
	icon_state = "shortshirt"
	item_state = "shortshirt"
	r_sleeve_status = SLEEVE_TORN
	l_sleeve_status = SLEEVE_TORN
	body_parts_covered = CHEST|VITALS
	torn_sleeve_number = 2

/obj/item/clothing/suit/roguetown/shirt/shortshirt/bog
	color = "#9ac878"

/obj/item/clothing/suit/roguetown/shirt/rags
	slot_flags = ITEM_SLOT_ARMOR
	name = "rags"
	desc = "Better than going naked? You be the judge."
	body_parts_covered = CHEST|GROIN|VITALS
	color = "#b0b0b0"
	icon_state = "rags"
	item_state = "rags"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	flags_inv = HIDECROTCH|HIDEBOOB
	fiber_salvage = FALSE

/obj/item/clothing/suit/roguetown/shirt/tunic
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "tunic"
	desc = ""
	body_parts_covered = CHEST|GROIN|VITALS
	boobed = FALSE
	icon_state = "tunic"
	item_state = "undershirt"
	sleevetype = "tunic"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	flags_inv = HIDECROTCH|HIDEBOOB

/obj/item/clothing/suit/roguetown/shirt/tunic/green
	color = CLOTHING_GREEN

/obj/item/clothing/suit/roguetown/shirt/tunic/blue
	color = CLOTHING_BLUE

/obj/item/clothing/suit/roguetown/shirt/tunic/red
	color = CLOTHING_RED

/obj/item/clothing/suit/roguetown/shirt/tunic/purple
	color = CLOTHING_PURPLE

/obj/item/clothing/suit/roguetown/shirt/tunic/white
	color = CLOTHING_WHITE

/obj/item/clothing/suit/roguetown/shirt/tunic/ucolored
	color = COLOR_GRAY

/obj/item/clothing/suit/roguetown/shirt/tunic/newmoon
	color = "#78a3c9"

/obj/item/clothing/suit/roguetown/shirt/tunic/random/Initialize()
	color = pick(CLOTHING_PURPLE, CLOTHING_RED, CLOTHING_BLUE, CLOTHING_GREEN)
	return ..()

/obj/item/clothing/suit/roguetown/shirt/dress
	slot_flags = ITEM_SLOT_ARMOR
	name = "dress"
	desc = ""
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon_state = "dress"
	item_state = "dress"
	allowed_sex = list(MALE, FEMALE)
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	flags_inv = HIDECROTCH|HIDEBOOB

/obj/item/clothing/suit/roguetown/shirt/dress/gen
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "dress"
	desc = ""
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon_state = "dressgen"
	item_state = "dressgen"
	color = "#6b5445"

/obj/item/clothing/suit/roguetown/shirt/dress/gen/black
	color = CLOTHING_BLACK

/obj/item/clothing/suit/roguetown/shirt/dress/gen/blue
	color = CLOTHING_BLUE

/obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
	color = CLOTHING_PURPLE

/obj/item/clothing/suit/roguetown/shirt/dress/gen/random/Initialize()
	color = pick("#6b5445", "#435436", "#704542", "#79763f", CLOTHING_BLUE)
	return ..()

/obj/item/clothing/suit/roguetown/shirt/dress/silkdress
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "chemise"
	desc = "Comfortable yet elegant, it offers both style and comfort for everyday wear"
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon_state = "silkdress"
	item_state = "silkdress"
	color = "#e6e5e5"

/obj/item/clothing/suit/roguetown/shirt/dress/silkdress/black
	color = CLOTHING_BLACK

/obj/item/clothing/suit/roguetown/shirt/dress/silkdress/green
	color = CLOTHING_DARK_GREEN

/obj/item/clothing/suit/roguetown/shirt/dress/silkdress/random/Initialize()
	. = ..()
	color = pick("#e6e5e5", "#52BE80", "#C39BD3", "#EC7063","#5DADE2")

//
//   Velvet Dress
//

/obj/item/clothing/suit/roguetown/shirt/dress/velvetdress
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "velvet dress"
	desc = "A dress made with the finest velvet, befitting a person of high standing"
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	icon_state = "velvetdress"
	item_state = "velvetdress"
	ignore_sleeves_code = TRUE // No sleeves, otherwise arms will be over the sprite

/obj/item/clothing/suit/roguetown/shirt/dress/velvetdress/black
	color = CLOTHING_BLACK

/obj/item/clothing/suit/roguetown/shirt/dress/velvetdress/green
	color = CLOTHING_DARK_GREEN

/obj/item/clothing/suit/roguetown/shirt/dress/velvetdress/random/Initialize()
	. = ..()
	color = pick("#e6e5e5", "#52BE80", "#C39BD3", "#EC7063","#5DADE2")

//
//   Noble dress
//

/obj/item/clothing/suit/roguetown/shirt/dress/nobledress
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "noble dress"
	desc = "a noble dress, fit for a person of high standing"
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	icon_state = "nobledress"
	item_state = "nobledress"
	ignore_sleeves_code = TRUE // No sleeves, otherwise arms will be over the sprite

/obj/item/clothing/suit/roguetown/shirt/dress/nobledress/black
	color = CLOTHING_BLACK

/obj/item/clothing/suit/roguetown/shirt/dress/nobledress/green
	color = CLOTHING_DARK_GREEN

/obj/item/clothing/suit/roguetown/shirt/dress/nobledress/random/Initialize()
	. = ..()
	color = pick("#e6e5e5", "#52BE80", "#C39BD3", "#EC7063","#5DADE2")


/obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy
	name = "dress"
	desc = ""
	body_parts_covered = null
	icon_state = "sexydress"
	sleevetype = null
	sleeved = null
	color = "#a90707"

/obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy/Initialize()
	. = ..()
	color = pick("#a90707", "#16239a", "#d68fbd", CLOTHING_BLACK)

/obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy/black/Initialize()
	. = ..()
	color = CLOTHING_BLACK

/obj/item/clothing/suit/roguetown/shirt/undershirt/webs
	name = "webbed shirt"
	desc = "Exotic silk finely woven into.. this? Might as well be wearing a spiderweb"
	icon_state = "webs"
	item_state = "webs"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	body_parts_covered = CHEST|ARMS|VITALS
	color = null
	salvage_amount = 1
	salvage_result = /obj/item/natural/silk

/obj/item/clothing/suit/roguetown/shirt/jester
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "jester's tunick"
	desc = ""
	body_parts_covered = CHEST|GROIN|ARMS|VITALS
	icon_state = "jestershirt"
	do_sound_bell = FALSE
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/shirts.dmi'
	boobed = TRUE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	flags_inv = HIDECROTCH|HIDEBOOB

/obj/item/clothing/suit/roguetown/shirt/grenzelhoft
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "grenzelhoftian hip-shirt"
	desc = "Through the sands, dirt or rivers of blood: Always in style."
	body_parts_covered = CHEST|GROIN|ARMS|VITALS
	icon_state = "grenzelshirt"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	boobed = TRUE
	detail_tag = "_detail"
	detail_color = CLOTHING_WHITE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	var/picked = FALSE
	colorgrenz = TRUE

/obj/item/clothing/suit/roguetown/shirt/grenzelhoft/attack_right()
	..()
	if(!picked)
		var/list/colors = list(
		"PURPLE"="#865c9c",
		"RED"="#933030",
		"BROWN"="#685542",
		"GREEN"="#79763f",
		"BLUE"="#395480",
		"YELLOW"="#b5b004",
		"TEAL"="#249589",
		"WHITE"="#ffffff",
		"ORANGE"="#b86f0c",
		"MAJENTA"="#962e5c")

		var/mob/living/carbon/human/L = loc
		var/choice = input(L, "Choose a color.", "GRENZELHOFTIAN COLORPLEX") as anything in colors
		var/playerchoice = colors[choice]
		picked = TRUE
		detail_color = playerchoice
		update_icon()
		for(var/obj/item/clothing/V in L.get_equipped_items(FALSE))
			testing("clothes to color are [V]")
			if(V.colorgrenz)
				V.detail_color = playerchoice
				V.update_icon()
		L.regenerate_icons()



/obj/item/clothing/suit/roguetown/shirt/grenzelhoft/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/shirt/exoticsilkbra
	name = "exotic silks"
	desc = "Fanciful gold laced silks barely able to conceal what little it covers."
	icon_state = "exoticsilkbra"
	item_state = "exoticsilkbra"
	gender = PLURAL
	body_parts_covered = CHEST|ARMS|VITALS
	sewrepair = TRUE

//---------------- NEW/SHIRTS.DM--------------------

/obj/item/clothing/suit/roguetown/shirt/steward
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "steward's tunic"
	desc = "A more formal tunic made specially for the steward to wear when he isn't using his other garments."
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	boobed = FALSE
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts.dmi'
	icon_state = "stewardtunic"
	item_state = "stewardtunic"
	flags_inv = HIDECROTCH|HIDEBOOB
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/steward/dress
	name = "steward's dress"
	desc = "A more formal dress made specially for the steward to wear when she isn't using her other garments."
	icon_state = "stewarddress"
	item_state = "stewarddress"

/obj/item/clothing/suit/roguetown/shirt/shadow
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "vanguard uniform"
	desc = "A nightly uniform worn by those that protect the citizenry from what lurks beyond."
	body_parts_covered = CHEST|GROIN|VITALS|LEGS
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts.dmi'
	icon_state = "shadowrobe"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

//----------------- MORE AZURE SPRITEWORK ---------------------

/obj/item/clothing/suit/roguetown/shirt/robe/archivist
	name = "archivist's robe"
	desc = "Robes belonging to seekers of knowledge."
	icon_state = "archivist"
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts.dmi'
	body_parts_covered = CHEST|GROIN|ARMS|VITALS
	boobed = TRUE
	flags_inv = HIDECROTCH|HIDEBOOB
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	allowed_sex = list(MALE, FEMALE)
	color = null
	sellprice = 100

/obj/item/clothing/suit/roguetown/shirt/undershirt/artificer
	name = "tinker suit"
	desc = "Typical fashion of the best engineers."
	icon_state = "artishirt"
	resistance_flags = FIRE_PROOF	//Artificers contraptions set them on fire with regular intervals. Thus, Fire retardent clothing.

/obj/item/clothing/suit/roguetown/shirt/apothshirt
	name = "apothecary shirt"
	desc = "When trudging through late-autumn forests, one needs to keep warm."
	icon_state = "apothshirt"
	item_state = "apothshirt"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	body_parts_covered = CHEST|VITALS

/obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat
	name = "fancy coat"
	desc = "A fancy tunic and coat combo. How elegant."
	icon_state = "noblecoat"
	sleevetype = "noblecoat"
	color = CLOTHING_WHITE
	boobed = TRUE

/obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
	name = "low cut tunic"
	desc = "A tunic exposing much of the shoulders and neck. Shoulders?! How scandalous..."
	icon_state = "lowcut"

/obj/item/clothing/suit/roguetown/shirt/dress/royal/princess
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "pristine dress"
	desc = "A flowy, intricate dress made by the finest tailors in the land for the monarch's children."
	icon_state = "princess"
	boobed = TRUE
	detail_color = CLOTHING_WHITE

/obj/item/clothing/suit/roguetown/shirt/dress/royal/prince
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "gilded dress shirt"
	desc = "A gold-embroidered dress shirt specially tailored for the monarch's children."
	icon_state = "prince"
	boobed = TRUE
	detail_color = CLOTHING_WHITE

/obj/item/clothing/suit/roguetown/shirt/dress/royal
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	name = "royal gown"
	desc = "An elaborate ball gown, a favoured fashion of queens and elevated nobility in Enigma."
	body_parts_covered = CHEST|GROIN|ARMS|VITALS
	icon_state = "royaldress"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts.dmi'
	boobed = TRUE
	detail_tag = "_detail"
	detail_color = CLOTHING_BLACK
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/dress/royal/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/shirt/dress/royal/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/suit/roguetown/shirt/dress/royal/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/shirt/dress/royal/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/suit/roguetown/shirt/undershirt/overseer
    icon_state = "overseershirt"
    icon = 'icons/roguetown/clothing/inquisition_overseers/overseer.dmi'
    mob_overlay_icon = 'icons/roguetown/clothing/inquisition_overseers/onmob/overseer_onmob.dmi'
    sleeved = 'icons/roguetown/clothing/inquisition_overseers/onmob/overseer_onmob.dmi'
    color = null
