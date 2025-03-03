/obj/item/clothing/head/roguetown
	name = "hat"
	desc = ""
	icon = 'icons/roguetown/clothing/head.dmi'
	icon_state = "top_hat"
	item_state = "that"
	body_parts_covered = HEAD|HAIR
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	dynamic_hair_suffix = "+generic"
	bloody_icon_state = "helmetblood"
	experimental_onhip = TRUE
	w_class = WEIGHT_CLASS_SMALL
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/equipped(mob/user, slot)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/head/roguetown/dropped(mob/user)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/head/roguetown/roguehood
	name = "hood"
	desc = ""
	color = CLOTHING_BROWN
	icon_state = "basichood"
	item_state = "basichood"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	sleevetype = null
	sleeved = null
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100
	salvage_amount = 1
	salvage_result = /obj/item/natural/cloth

/obj/item/clothing/head/roguetown/roguehood/reinforced
	name = "hood"
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	armor = list("blunt" = 47, "slash" = 27, "stab" = 37, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	max_integrity = 150
	blocksound = SOFTHIT
	sewrepair = TRUE
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/head/roguetown/roguehood/reinforced/newmoon
	color = "#78a3c9"


/obj/item/clothing/head/roguetown/roguehood/shalal
	name = "keffiyeh"
	desc = "A protective covering worn by those native to the desert."
	color = null
	icon_state = "shalal"
	item_state = "shalal"
	flags_inv = HIDEHAIR
	sleevetype = null
	sleeved = null
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	alternate_worn_layer  = 8.9 //On top of helmet
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	armor = list("blunt" = 20, "slash" = 20, "stab" = 15, "bullet" = 1, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	blocksound = SOFTHIT
	max_integrity = 100

/obj/item/clothing/head/roguetown/roguehood/shalal/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "shalal_t"
			body_parts_covered = HEAD|EARS|HAIR|NECK|NOSE|MOUTH
			flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
			flags_cover = null
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)

/obj/item/clothing/head/roguetown/roguehood/shalalz
	name = "zybantine keffiyeh"
	desc = "A protective covering worn by those native to the deserts of Zybantine."
	color = null
	icon_state = "shalal_z"
	item_state = "shalal_z"
	flags_inv = HIDEHAIR
	sleevetype = null
	sleeved = null
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	alternate_worn_layer  = 8.9 //On top of helmet
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	armor = list("blunt" = 20, "slash" = 20, "stab" = 15, "bullet" = 1, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	blocksound = SOFTHIT
	max_integrity = 100

/obj/item/clothing/head/roguetown/roguehood/shalalz/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "shalal_zt"
			body_parts_covered = HEAD|EARS|HAIR|NECK|NOSE|MOUTH
			flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
			flags_cover = null
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)


/obj/item/clothing/head/roguetown/eoramask
	name = "eoran mask"
	desc = "A silver opera mask worn by the faithful of Eora, usually during their rituals."
	icon_state = "eoramask"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	dynamic_hair_suffix = ""
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	resistance_flags = FIRE_PROOF // Made of metal

/obj/item/clothing/head/roguetown/roguehood/astrata
	name = "sun hood"
	desc = "A hood worn by those who favor Astrata. Praise the firstborn sun!"
	color = null
	icon_state = "astratahood"
	item_state = "astratahood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/roguehood/nochood
	name = "moon hood"
	desc = "A hood worn by those who favor Noc with a mask in the shape of a crescent."
	color = null
	icon_state = "nochood"
	item_state = "nochood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/necrahood
	name = "death shroud"
	color = null
	icon_state = "necrahood"
	item_state = "necrahood"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""

/obj/item/clothing/head/roguetown/dendormask
	name = "briarmask"
	desc = "A mask of wood worn by druids in service to Dendor."
	color = null
	icon_state = "dendormask"
	item_state = "dendormask"
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	dynamic_hair_suffix = ""

/obj/item/clothing/head/roguetown/necromhood
	name = "necromancers hood"
	color = null
	icon_state = "necromhood"
	item_state = "necromhood"
	body_parts_covered = NECK
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""

/obj/item/clothing/head/roguetown/priestmask
	name = "solar visage"
	desc = "The sanctified helm of the most devoted. Thieves beware."
	color = null
	icon_state = "priesthead"
	item_state = "priesthead"
	body_parts_covered = HEAD|HAIR|EARS|NECK
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("blunt" = 20, "slash" = 20, "stab" = 20, "bullet" = 15, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_ASSASSIN)
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""

/obj/item/clothing/head/roguetown/priestmask/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_CHOSEN))
		to_chat(user, "<font color='yellow'>UNWORTHY HANDS TOUCH THE VISAGE, CEASE OR BE PUNISHED</font>")
		spawn(30)
			if(loc == user)
				user.adjust_fire_stacks(5)
				user.IgniteMob()

/obj/item/clothing/head/roguetown/roguehood/red
	color = CLOTHING_RED

/obj/item/clothing/head/roguetown/roguehood/black
	color = CLOTHING_BLACK

/obj/item/clothing/head/roguetown/roguehood/random/Initialize()
	color = pick("#544236", "#435436", "#543836", "#79763f")
	return ..()

/obj/item/clothing/head/roguetown/roguehood/mage/Initialize()
	color = pick("#4756d8", "#759259", "#bf6f39", "#c1b144", "#b8252c")
	return ..()

/obj/item/clothing/head/roguetown/roguehood/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
			body_parts_covered = NECK|HAIR|EARS|HEAD
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
				H.update_inv_wear_mask() //Snowflake case for Desert Merc hood
			block2add = FOV_BEHIND
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = null
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
					H.update_inv_wear_mask() //Snowflake case for Desert Merc hood
		user.update_fov_angles()


/obj/item/clothing/head/roguetown/menacing
	name = "sack hood"
	desc = "A hood commonly worn by executioners. Hides the face, the stigma of pulling that lever makes many executioners outcasts in their own right."
	icon_state = "menacing"
	item_state = "menacing"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	fiber_salvage = FALSE

/obj/item/clothing/head/roguetown/menacing/bandit
	icon_state = "bandithood"
	desc = "A hood worn by the freemen of the wood. It is lined with extra padding, offering modest protection."
	body_parts_covered = HEAD|HAIR|EARS|NECK|EYES|NOSE|MOUTH
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_NECK
	armor = list("blunt" = 50, "slash" = 30, "stab" = 40, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_CUT)
	anvilrepair = null
	max_integrity = 200
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/jester
	name = "jester's hat"
	desc = "A funny looking hat with jingly bells attached to it."
	icon_state = "jester"
	item_state = "jester"
	do_sound_bell = TRUE
	bell = TRUE
	dynamic_hair_suffix = "+generic"
	flags_inv = HIDEEARS

/obj/item/clothing/head/roguetown/strawhat
	name = "straw hat"
	desc = "Keeps the sun off your head while toiling the fields."
	icon_state = "strawhat"
	salvage_result = /obj/item/natural/fibers

/obj/item/clothing/head/roguetown/puritan
	name = "buckled hat"
	icon_state = "puritan_hat"

/obj/item/clothing/head/roguetown/nightman
	name = "teller's hat"
	icon_state = "tophat"
	color = CLOTHING_BLACK

/obj/item/clothing/head/roguetown/bardhat
	name = "hat"
	icon_state = "bardhat"

/obj/item/clothing/head/roguetown/fancyhat
	name = "fancy hat"
	desc = "A fancy looking hat with colorful feathers sticking out of it."
	icon_state = "fancy_hat"
	item_state = "fancyhat"

/obj/item/clothing/head/roguetown/hatfur
	name = "fur hat"
	desc = "A comfortable warm hat lined with fur."
	icon_state = "hatfur"

/obj/item/clothing/head/roguetown/hatblu
	name = "fur hat"
	desc = "A blue hat lined with fur."
	icon_state = "hatblu"

/obj/item/clothing/head/roguetown/fisherhat
	name = "straw hat"
	desc = "A hat worn by fishermen to protect from the sun."
	icon_state = "fisherhat"
	item_state = "fisherhat"

/obj/item/clothing/head/roguetown/flathat
	name = "flat hat"
	icon_state = "flathat"
	item_state = "flathat"

/obj/item/clothing/head/roguetown/chaperon
	name = "chaperon hat"
	desc = "A fancy hat worn by nobles."
	icon_state = "chaperon"
	item_state = "chaperon"

/obj/item/clothing/head/roguetown/cookhat
	name = "cook hat"
	desc = "A hat which signifies one as well versed in the arts of cooking."
	icon_state = "chef"
	item_state = "chef"

/obj/item/clothing/head/roguetown/chaperon/greyscale
	icon_state = "chap_alt"
	item_state = "chap_alt"
	color = "#cf99e3"

/obj/item/clothing/head/roguetown/chef
	name = "chef's hat"
	desc = "A hat which signifies one as well versed in the arts of cooking."
	icon_state = "chef"

/obj/item/clothing/head/roguetown/armingcap
	name = "cap"
	desc = "A light cap made of cloth, usually worn under a helmet."
	icon_state = "armingcap"
	item_state = "armingcap"
	flags_inv = HIDEEARS

/obj/item/clothing/head/roguetown/knitcap
	name = "knit cap"
	desc = "A simple knitted cap."
	icon_state = "knitcap"

/obj/item/clothing/head/roguetown/armingcap/dwarf
	color = "#cb3434"

/obj/item/clothing/head/roguetown/headband
	name = "headband"
	desc = "A simple headband to keep sweat out of your eyes."
	icon_state = "headband"
	item_state = "headband"
	fiber_salvage = FALSE
	salvage_amount = 1
	dynamic_hair_suffix = null

/obj/item/clothing/head/roguetown/headband/red
	color = CLOTHING_RED

/obj/item/clothing/head/roguetown/crown //Holds vars for children
	name = "crown of rockhill"
	desc = ""
	icon_state = "serpcrown"
	dynamic_hair_suffix = null
	sellprice = 200
	resistance_flags = FIRE_PROOF | ACID_PROOF
	anvilrepair = /datum/skill/craft/blacksmithing
	sewrepair = FALSE

/obj/item/clothing/head/roguetown/crown/serpcrown
	visual_replacement = /obj/item/clothing/head/roguetown/crown/fakecrown

/obj/item/clothing/head/roguetown/crown/serpcrown/Initialize()
	. = ..()
	SSroguemachine.crown = src
	visual_replacement = /obj/item/clothing/head/roguetown/crown/fakecrown

/obj/item/clothing/head/roguetown/crown/serpcrown/proc/anti_stall()
	src.visible_message(span_warning("The Crown of Rockhill crumbles to dust, the ashes spiriting away in the direction of the Keep."))
	SSroguemachine.crown = null //Do not harddel.
	qdel(src) //Anti-stall

/obj/item/clothing/head/roguetown/crown/fakecrown
	name = "fake crown"
	desc = "You shouldn't be seeing this."
	icon_state = "serpcrown"

/obj/item/clothing/head/roguetown/crown/surplus
	name = "crown"
	icon_state = "serpcrowno"
	sellprice = 100
	allowed_race = list(/datum/species/goblinp)

/obj/item/clothing/head/roguetown/crown/sparrowcrown
	name = "champion's circlet"
	icon_state = "sparrowcrown"
	sellprice = 50

/obj/item/clothing/head/roguetown/priesthat
	name = "priest's hat"
	desc = ""
	icon_state = "priest"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	dynamic_hair_suffix = "+generic"
	sellprice = 77
	worn_x_dimension = 64
	worn_y_dimension = 64

/obj/item/clothing/head/roguetown/reqhat
	name = "serpent crown"
	desc = ""
	icon_state = "reqhat"
	sellprice = 100
	anvilrepair = /datum/skill/craft/blacksmithing
	sewrepair = FALSE

/obj/item/clothing/head/roguetown/headdress
	name = "foreign headdress"
	desc = ""
	icon_state = "headdress"
	sellprice = 10

/obj/item/clothing/head/roguetown/headdress/alt
	icon_state = "headdressalt"

/obj/item/clothing/head/roguetown/nun
	name = "nun's habit"
	icon_state = "nun"
	sellprice = 5

/obj/item/clothing/head/roguetown/hennin
	name = "hennin"
	desc = "A hat typically worn by women in nobility."
	icon_state = "hennin"
	sellprice = 19
	dynamic_hair_suffix = "+generic"

/obj/item/clothing/head/roguetown/paddedcap
	name = "padded cap"
	desc = "A modest arming cap"
	icon_state = "armingcap"
	item_state = "armingcap"
	sleevetype = null
	sleeved = null
	body_parts_covered = HEAD|HAIR|EARS
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	armor = list("blunt" = 35, "slash" = 15, "stab" = 25, "bullet" = 1, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_SMASH)
	blocksound = SOFTHIT
	max_integrity = 75
	color = "#463C2B"

/obj/item/clothing/head/roguetown/helmet
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "helmet"
	desc = "A helmet that doesn't get any more simple in design."
	body_parts_covered = HEAD|HAIR|NOSE
	icon_state = "nasal"
	sleevetype = null
	sleeved = null
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	dynamic_hair_suffix = "+generic"
	bloody_icon_state = "helmetblood"
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	blocksound = PLATEHIT
	max_integrity = 200
	w_class = WEIGHT_CLASS_NORMAL
	armor_class = ARMOR_CLASS_LIGHT
	resistance_flags = FIRE_PROOF
	clothing_flags = CANT_SLEEP_IN
	sewrepair = FALSE

/obj/item/clothing/head/roguetown/helmet/skullcap
	name = "skull cap"
	desc = "A helmet which covers the top of the head."
	icon_state = "skullcap"
	body_parts_covered = HEAD|HAIR
	max_integrity = 200
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/horned
	name = "horned cap"
	desc = "A helmet with two horns poking out of the sides."
	icon_state = "hornedcap"
	max_integrity = 225
	body_parts_covered = HEAD|HAIR

/obj/item/clothing/head/roguetown/helmet/winged
	name = "winged cap"
	desc = "A helmet with two wings on its sides."
	icon_state = "wingedcap"
	max_integrity = 225
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	body_parts_covered = HEAD|HAIR

/obj/item/clothing/head/roguetown/helmet/kettle
	desc = "A steel helmet which protects the whole of the head."
	icon_state = "kettle"
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEEARS
	body_parts_covered = HEAD|HAIR

/obj/item/clothing/head/roguetown/helmet/kettle/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Orle") as anything in colors
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		detail_color = colors[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/kettle/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

//................ CULTIST HOOD ............... //
/obj/item/clothing/head/roguetown/helmet/leather/cult_hood
	name = "cultist hood"
	desc = "It echoes with ominous laughter."
	icon_state = "warlockhood"
	dynamic_hair_suffix = ""
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	body_parts_covered = NECK|HAIR|EARS|HEAD

//................ Sallet ............... //
/obj/item/clothing/head/roguetown/helmet/sallet
	name = "sallet"
	icon_state = "sallet"
	desc = "A steel helmet which protects the ears."
	smeltresult = /obj/item/ingot/steel
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEEARS

/obj/item/clothing/head/roguetown/helmet/sallet/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Orle") as anything in colors
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		detail_color = colors[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/sallet/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/sallet/visored
	name = "visored sallet"
	desc = "A steel helmet which protects the ears, eyes and nose."
	icon_state = "sallet_visor"
	max_integrity = 275
	adjustable = CAN_CADJUST
	flags_inv = HIDEFACE|HIDEEARS
	flags_cover = HEADCOVERSEYES
	armor_class = ARMOR_CLASS_MEDIUM
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/sallet/visored/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Orle") as anything in colors
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		detail_color = colors[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/sallet/visored/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/sallet/visored/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "[initial(icon_state)]_raised"
			body_parts_covered = HEAD|EARS|HAIR
			flags_cover = null
			flags_inv = null
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEFACE
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()

//................ Volf Helm ............... //

/obj/item/clothing/head/roguetown/helmet/volfplate // Was originally a heavy helm, but now mercs can only use medium armor
	name = "volf-face helm"
	desc = "A steel bascinet helmet with a volfish visor protecting the head, ears, eyes, nose and mouth."
	body_parts_covered = FULL_HEAD
	icon_state = "volfplate"
	item_state = "volfplate"
	adjustable = CAN_CADJUST
	max_integrity = 300
	emote_environment = 3
	armor_class = ARMOR_CLASS_MEDIUM
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/volfplate/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "volfplate_visor_raised"
			body_parts_covered = HEAD|EARS|HAIR
			flags_inv = HIDEEARS
			flags_cover = null
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()

/obj/item/clothing/head/roguetown/helmet/heavy
	name = "barbute"
	desc = "A simple helmet with a visor in the shape of a Y."
	body_parts_covered = FULL_HEAD
	icon_state = "barbute"
	item_state = "barbute"
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST)
	block2add = FOV_RIGHT|FOV_LEFT
	armor_class = ARMOR_CLASS_HEAVY
	max_integrity = 400

/obj/item/clothing/head/roguetown/helmet/heavy/guard
	name = "savoyard"
	desc = "A helmet with a menacing visage."
	icon_state = "guardhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_RIGHT|FOV_LEFT
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/heavy/gate
	name = "barred helmet"
	desc = "A helmet which offers good protection to the face. The bars resemble the gates of the manor, closed and protecting the gatemaster's identity."
	icon_state = "gatehelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
	armor_class = ARMOR_CLASS_MEDIUM	//breaks the 'scheme' of armor class, because it's a unqiue helm, that can't be remade. Go forth, gatemaster.
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/knight
	name = "knight's helmet"
	desc = "A noble knight's helmet."
	icon_state = "knight"
	item_state = "knight"
	adjustable = CAN_CADJUST
	emote_environment = 3
	block2add = FOV_RIGHT|FOV_LEFT
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/knight/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)
		var/choice = input(user, "Choose a color.", "Plume") as anything in colors
		detail_color = colors[choice]
		detail_tag = "_detail"
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
/obj/item/clothing/head/roguetown/helmet/heavy/knight/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/knight/black
	color = CLOTHING_BLACK

/obj/item/clothing/head/roguetown/helmet/heavy/knight/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "knightum"
			body_parts_covered = HEAD|HAIR|EARS
			flags_inv = HIDEEARS
			flags_cover = null
			emote_environment = 0
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			emote_environment = 3
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()

/obj/item/clothing/head/roguetown/helmet/heavy/bucket
	name = "bucket helmet"
	desc = "A helmet which covers the whole of the head. Offers excellent protection."
	icon_state = "topfhelm"
	item_state = "topfhelm"
	max_integrity = 435
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_RIGHT|FOV_LEFT
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/bucket/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)
		var/choice = input(user, "Choose a color.", "Orle") as anything in colors
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		detail_color = colors[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
/obj/item/clothing/head/roguetown/helmet/heavy/bucket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
	desc = "A helmet which covers the whole of the head. Offers excellent protection. This one has a golden cross-shaped brow."
	icon_state = "topfhelm_gold"
	item_state = "topfhelm_gold"

/obj/item/clothing/head/roguetown/helmet/heavy/pigface
	name = "pigface bascinet"
	desc = "A steel bascinet helmet with a pigface visor protecting the head, ears, nose, mouth, and eyes. Add a feather to show the colors of your family or allegiance."
	icon_state = "hounskull"
	item_state = "hounskull"
	adjustable = CAN_CADJUST
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_RIGHT|FOV_LEFT
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/pigface/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "hounskull_visor_raised"
			body_parts_covered = HEAD|EARS|HAIR
			flags_inv = HIDEEARS
			flags_cover = null
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()

/obj/item/clothing/head/roguetown/helmet/heavy/pigface/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)
		var/choice = input(user, "Choose a color.", "Plume") as anything in colors
		detail_color = colors[choice]
		detail_tag = "_detail"
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
/obj/item/clothing/head/roguetown/helmet/heavy/pigface/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/frogmouth
	name = "froggemund helmet"
	desc = "A tall and imposing frogmouth-style helm popular in the highest plateaus of Otava. Covers not just the head, but the neck as well. Add a cloth to show the colors of your family or allegiance."
	icon_state = "frogmouth"
	item_state = "frogmouth"
	emote_environment = 3
	body_parts_covered = FULL_HEAD|NECK
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_RIGHT|FOV_LEFT
	smeltresult = /obj/item/ingot/steel
/obj/item/clothing/head/roguetown/helmet/heavy/frogmouth/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)
		var/choice = input(user, "Choose a color.", "Orle") as anything in colors
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		detail_color = colors[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
/obj/item/clothing/head/roguetown/helmet/heavy/frogmouth/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/bascinet
	name = "bascinet"
	desc = "A steel bascinet helmet without a visor protecting the the head and ears."
	icon_state = "bascinet_novisor"
	item_state = "bascinet_novisor"
	max_integrity = 235
	emote_environment = 3
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR|HIDEEARS
	armor_class = ARMOR_CLASS_MEDIUM
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/leather
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "leather helmet"
	desc = "A helmet made of leather."
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	icon_state = "leatherhelm"
	armor = list("blunt" = 47, "slash" = 27, "stab" = 37, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	smeltresult = null
	blocksound = SOFTHIT
	clothing_flags = null
	sewrepair = TRUE
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/head/roguetown/helmet/leather/advanced
	name = "hardened leather helmet"
	desc = "Sturdy, durable, flexible. A confortable and reliable hood made of hardened leather."
	icon_state = "alhelmet"
	max_integrity = 250
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = list("blunt" = 70, "slash" = 60, "stab" = 30, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/roguetown/helmet/leather/masterwork
	name = "masterwork leather helmet"
	desc = "This helmet is a craftsmanship marvel. Made with the finest leather. Strong, nimible, reliable."
	max_integrity = 300
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_CHOP) //we're adding chop here!
	armor = list("blunt" = 100, "slash" = 70, "stab" = 40, "bullet" = 10, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(218, 165, 32))

/obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "volf helmet"
	desc = "Bandit initiation rites involve the slaying of a volf."
	body_parts_covered = HEAD|HAIR|EARS
	icon_state = "volfhead"
	item_state = "volfhead"
	armor = list("blunt" = 47, "slash" = 27, "stab" = 37, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	blocksound = SOFTHIT
	clothing_flags = null

/obj/item/clothing/head/roguetown/wizhat
	name = "wizard hat"
	desc = "Used to distinguish dangerous wizards from senile old men."
	icon_state = "wizardhat"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	dynamic_hair_suffix = "+generic"
	worn_x_dimension = 64
	worn_y_dimension = 64

	/// This var basicly counts the numbers of times this hat has changes its appearence
	var/hat_count = 0

/obj/item/clothing/head/roguetown/wizhat/MiddleClick(mob/user, params)
	. = ..()
	if(!do_after(user, 20, target = user))
		return
	if(hat_count == 0)
		icon_state = "wizardhatred"
		hat_count += 1
	else if(hat_count == 1)
		icon_state = "wizardhatyellow"
		hat_count += 1
	else if(hat_count == 2)
		icon_state = "wizardhatgreen"
		hat_count += 1
	else if(hat_count == 3)
		icon_state = "wizardhatblack"
		hat_count += 1
	else if(hat_count == 4)
		icon_state = "wizardhatgen"
		hat_count += 1
	else if(hat_count == 5)
		icon_state = "wizardhat"
		hat_count = 0
	to_chat(user, span_info("The wizard hat magically changes it's colours!"))
	playsound(src, 'sound/magic/swap.ogg', 50, TRUE)

/obj/item/clothing/head/roguetown/wizhat/red
	icon_state = "wizardhatred"

/obj/item/clothing/head/roguetown/wizhat/yellow
	icon_state = "wizardhatyellow"

/obj/item/clothing/head/roguetown/wizhat/green
	icon_state = "wizardhatgreen"

/obj/item/clothing/head/roguetown/wizhat/black
	icon_state = "wizardhatblack"

/obj/item/clothing/head/roguetown/wizhat/gen
	icon_state = "wizardhatgen"

/obj/item/clothing/head/roguetown/wizhat/gen/wise
	name = "wise hat"
	sellprice = 100
	desc = "Only the wisest of nimrods wear this."

/obj/item/clothing/head/roguetown/wizhat/gen/wise/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/wise = user
	if(slot == SLOT_HEAD)
		wise.change_stat("intelligence", 2, "wisehat")
		to_chat(wise, span_green("I gain wisdom."))

/obj/item/clothing/head/roguetown/wizhat/gen/wise/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/wise = user
	if(wise.get_item_by_slot(SLOT_HEAD) == src)
		wise.change_stat("intelligence", -2, "wisehat")
		to_chat(wise, span_red("I lose wisdom."))

/obj/item/clothing/head/roguetown/physician
	name = "doctor's hat"
	desc = "My cure is most effective."
	icon_state = "physhat"

/obj/item/clothing/head/roguetown/nyle
	name = "jewel of nyle"
	icon_state = "nile"
	body_parts_covered = null
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = null
	sellprice = 100
	resistance_flags = FIRE_PROOF
	anvilrepair = /datum/skill/craft/blacksmithing
	sewrepair = FALSE

/obj/item/clothing/head/roguetown/grenzelhofthat
	name = "grenzelhoft plume hat"
	desc = "Slaying monsters or fair maidens: Grenzelhoft stands."
	icon_state = "grenzelhat"
	item_state = "grenzelhat"
	icon = 'icons/roguetown/clothing/head.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	slot_flags = ITEM_SLOT_HEAD
	detail_tag = "_detail"
	dynamic_hair_suffix = ""
	max_integrity = 150
	colorgrenz = TRUE

/obj/item/clothing/head/roguetown/grenzelhofthat/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/peaceflower
	name = "eoran bud"
	desc = "A flower of gentle petals, associated with Eora or Necra. Usually adorned as a headress or laid at graves as a symbol of love or peace."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "peaceflower"
	item_state = "peaceflower"
	slot_flags = ITEM_SLOT_HEAD
	body_parts_covered = NONE
	dynamic_hair_suffix = ""
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3

/obj/item/clothing/head/peaceflower/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_HEAD)
		ADD_TRAIT(user, TRAIT_PACIFISM, "peaceflower_[REF(src)]")
		user.add_stress(/datum/stressevent/eora)

/obj/item/clothing/head/peaceflower/dropped(mob/living/carbon/human/user)
	..()
	REMOVE_TRAIT(user, TRAIT_PACIFISM, "peaceflower_[REF(src)]")
	user.remove_stress(/datum/stressevent/eora)

/obj/item/clothing/head/peaceflower/proc/peace_check(mob/living/user)
	// return true if we should be unequippable, return false if not
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.head)
			to_chat(user, span_warning("I feel at peace. <b style='color:pink'>Why would I want anything else?</b>"))
			return TRUE
	return FALSE

/obj/item/clothing/head/peaceflower/MouseDrop(atom/over_object)
	if (!peace_check(usr))
		return ..()

/obj/item/clothing/head/peaceflower/attack_hand(mob/user)
	if (!peace_check(user))
		return ..()

/obj/item/clothing/head/roguetown/helmet/tricorn
	slot_flags = ITEM_SLOT_HEAD
	name = "tricorn"
	desc = ""
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	icon_state = "tricorn"
	armor = list("blunt" = 47, "slash" = 27, "stab" = 37, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	smeltresult = null
	blocksound = SOFTHIT
	clothing_flags = null
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/head/roguetown/helmet/tricorn/skull
	icon_state = "tricorn_skull"
	desc = "It has a skull sewn onto it. Clear sign of piracy"

/obj/item/clothing/head/roguetown/helmet/tricorn/lucky
	name = "lucky tricorn"
	desc = "A weathered tricorn that has seen many skirmishes. You'd feel lucky with this on your head."
	armor = list("blunt" = 60, "slash" = 40, "stab" = 45, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/roguetown/helmet/bandana
	slot_flags = ITEM_SLOT_HEAD
	name = "bandana"
	desc = ""
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	icon_state = "bandana"
	armor = list("blunt" = 47, "slash" = 27, "stab" = 37, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	smeltresult = null
	blocksound = SOFTHIT
	clothing_flags = null
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/head/roguetown/inqhat
	name = "inquisitorial hat"
	desc = "Redemption is your currency."
	icon_state = "inqhat"
	item_state = "inqhat"
	sewrepair = TRUE

//Gronn
/obj/item/clothing/head/roguetown/helmet/nomadhelmet
	name = "nomad helmet"
	desc = "An iron helmet with leather to help protect the neck."
	icon_state = "nomadhelmet"
	item_state = "nomadhelmet"
	flags_inv = HIDEHAIR
	body_parts_covered = HEAD|HAIR|EARS|NOSE|NECK
	armor = list("blunt" = 50, "slash" = 30, "stab" = 40, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	max_integrity = 250
	anvilrepair = TRUE
	smeltresult = /obj/item/ingot/iron

//----------------- BLACKSTEEL ---------------------

/obj/item/clothing/head/roguetown/helmet/blacksteel/bucket
	name = "Blacksteel Bucket Helm"
	desc = "A bucket helmet forged of durable blacksteel. None shall pass.."
	body_parts_covered = FULL_HEAD
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bkhelm"
	item_state = "bkhelm"
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST, BCLASS_PICK)
	block2add = FOV_RIGHT|FOV_LEFT
	max_integrity = 425
	smeltresult = /obj/item/ingot/blacksteel

/obj/item/clothing/head/roguetown/helmet/heavy/crusader
	name = "bucket helm"
	icon_state = "crusader_helm"
	icon = 'icons/roguetown/clothing/special/crusader.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/crusader.dmi'

/obj/item/clothing/head/roguetown/helmet/heavy/crusader/t
	icon_state = "crusader_helmt2"

//----------------- SAILOR.DM ---------------------

/obj/item/clothing/head/roguetown/helmet/tricorn
	slot_flags = ITEM_SLOT_HEAD
	name = "tricorn"
	desc = ""
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	icon_state = "tricorn"
	armor = list("blunt" = 47, "slash" = 27, "stab" = 37, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	smeltresult = null
	sewrepair = TRUE
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/helmet/tricorn/skull
	icon_state = "tricorn_skull"
	desc = "It has a skull sewn onto it. Clear sign of piracy"

/obj/item/clothing/head/roguetown/helmet/tricorn/lucky
	name = "lucky tricorn"
	desc = "A weathered tricorn that has seen many skirmishes. You feel lucky and safe with it on your head."
	armor = list("blunt" = 60, "slash" = 40, "stab" = 45, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/roguetown/helmet/bandana
	slot_flags = ITEM_SLOT_HEAD
	name = "bandana"
	desc = ""
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	icon_state = "bandana"
	armor = list("blunt" = 47, "slash" = 27, "stab" = 37, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	smeltresult = null
	sewrepair = TRUE
	blocksound = SOFTHIT

//----------------- TEMPLAR.DM ---------------------

/obj/item/clothing/head/roguetown/helmet/heavy/templar
	emote_environment = 3
	adjustable = CAN_CADJUST
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)

/obj/item/clothing/head/roguetown/helmet/heavy/templar/astrata
	name = "astratan helmet"
	desc = "Headwear commonly worn by Templars in service to Astrata. The firstborn child's light will forever shine on within its crest."
	icon_state = "astratahelm"
	item_state = "astratahelm"

/obj/item/clothing/head/roguetown/helmet/heavy/templar/astrata/alt
	desc = "Gilded gold and silvered metal, the bright, vibrant colors of an Astratan crusader radiate from this blessed helmet."
	icon_state = "astratahelm_alt"
	item_state = "astratahelm_alt"
	adjustable = CANT_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/templar/necra
	name = "necran helmet"
	desc = "Headwear commonly worn by Templars in service to Necra. Let its skeletal features remind you of the only thing which is guaranteed in life. You will die."
	icon_state = "necrahelm"
	item_state = "necrahelm"

/obj/item/clothing/head/roguetown/helmet/heavy/templar/necra/alt
	desc = "The darkest of blacks, this hooded helm is reminiscent of an executioner's head, striking fear into those who look upon it that they too may soon face the undermaiden."
	icon_state = "necrahelm_alt"
	item_state = "necrahelm_alt"
	adjustable = CANT_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/templar/malum
	name = "malummite helmet"
	desc = "Forged in a coal-black, this helmet carries a sigiled blade upon it's visor, ever reminding it's wearer of Malum's powerful gaze."
	icon_state = "malumhelm"
	item_state = "malumhelm"
	adjustable = CANT_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/templar/noc
	name = "noctian helmet"
	desc = "Hearwear commonly worn by Templars in service to Noc. Without the night there can be no day, without Noc there can be no light in the dark hours."
	icon_state = "nochelm"
	item_state = "nochelm"

/obj/item/clothing/head/roguetown/helmet/heavy/templar/dendor
	name = "dendorite helmet"
	desc = "Headwear commonly worn by Templars in service to Dendor. Its protrusions almost resemble branches. Take root in the earth, and you will never be moved."
	icon_state = "dendorhelm"
	item_state = "dendorhelm"
	adjustable = CANT_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/templar/ravox
	name = "ravoxian helmet"
	desc = "Headwear commonly worn by Templars in service to Ravox. It resembles an heavily adorned visored sallet."
	icon_state = "ravoxhelm"
	item_state = "ravoxhelm"

/obj/item/clothing/head/roguetown/helmet/sallet/eoran
	name = "eora helmet"
	desc = "A standard helmet forged in the style typical of Eoran worshippers, a simple yet practical protective piece of equipment. Upon it lays several laurels of flowers and other colorful ornaments, followed by several symbols and standards of the user's chapter, accomplishments or even punishment"
	icon_state = "eorahelm"
	item_state = "eorahelm"

/obj/item/clothing/head/roguetown/helmet/heavy/templar/AdjustClothes(mob/user)
	playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)

	if(adjustable == CAN_CADJUST)
		adjustable = CADJUSTED
		icon_state = "[initial(icon_state)]_raised"
		body_parts_covered = HEAD|HAIR|EARS
		flags_inv = HIDEEARS|HIDEHAIR
		flags_cover = null
		if(ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
		block2add = FOV_DEFAULT
	else if(adjustable == CADJUSTED)
		ResetAdjust(user)

	if(user)
		if(ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
	user.update_fov_angles()

//----------------- INFAREDBARON/HATS.DM ---------------------

/obj/item/clothing/head/roguetown/helmet/citywatch
	name = "city watch helmet"
	desc = "A heavy helmet. Incredibly resilient to all forms of damage. Issued to the Citywatch."
	icon = 'icons/roguetown/clothing/licensed-infraredbaron/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/licensed-infraredbaron/onmob/armor.dmi'
	icon_state = "citywatch_helmet"
	item_state = "citywatch_helmet"
	max_integrity = 225
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	armor_class = ARMOR_CLASS_MEDIUM
	smeltresult = /obj/item/ingot/steel
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR
	clothing_flags = CANT_SLEEP_IN
	anvilrepair = /datum/skill/craft/blacksmithing
	sewrepair = FALSE

/obj/item/clothing/head/roguetown/duchess_hood
	name = "duchess hood"
	icon = 'icons/roguetown/clothing/licensed-infraredbaron/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/licensed-infraredbaron/onmob/head.dmi'
	icon_state = "duchess_hood"
	item_state = "duchess_hood"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

//----------------- MORE AZURE SPRITEWORK ---------------------

/obj/item/clothing/head/roguetown/witchhat
	name = "witch hat"
	desc = ""
	icon_state = "witch"
	item_state = "witch"
	icon = 'icons/roguetown/clothing/head.dmi'
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/duelhat //lifeweb sprite
	name = "duelist's hat"
	desc = "A feathered leather hat, to show them all your superiority."
	icon_state = "duelhat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/helmet/heavy/psydonbarbute
	name = "psydonian barbute"
	desc = "A ceremonial barbute, masterfully forged to represent Psydon's divine authority. The Order of Saint Malum's artisans have chiseled this pronged visage into more statues than you could possibly imagine."
	icon_state = "psydonbarbute"
	item_state = "psydonbarbute"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

/obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm
	name = "psydonian armet"
	desc = "An ornate helmet, whose visor has been bound shut with blacksteel chains. The Order of Saint Eora often decorates these armets with flowers - not only as a lucky charm gifted to them by fair maidens and family, but also as a vibrant reminder that 'happiness has to be fought for.'" 
	icon_state = "psydonarmet"
	item_state = "psydonarmet"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

/obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Orle") as anything in colors
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colors[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/roguehood/psydon
	name = "psydonian hood"
	desc = "A hood worn by Psydon's disciples, oft-worn in conjunction with its matching tabard."
	icon_state = "psydonhood"
	item_state = "psydonhood"
	color = null
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/roguehood/abyssor
	name = "depths hood"
	desc = "A hood worn by the followers of Abyssor, with a unique, coral-shaped mask. How do they even see out of this?"
	color = null
	icon_state = "abyssorhood"
	item_state = "abyssorhood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/roguehood/shalal/hijab
	name = "hijab"
	flags_inv = null
	desc = "Flowing like blood from a wound, this tithe of cloth-and-silk spills out to the shoulders. It carries the telltale mark of Naledian stitcheries."
	item_state = "hijab"
	icon_state = "deserthood"

/obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood
	name = "heavy hood"
	flags_inv = null
	desc = "This thick lump of burlap completely shrouds your head, protecting it from harsh weather and nosey protagonists alike."
	color = CLOTHING_BROWN
	item_state = "heavyhood"
	icon_state = "heavyhood"

/obj/item/clothing/head/roguetown/padded/briarthorns
	name = "briar thorns"
	desc = "The pain it causes perhaps can distract from the whispers of a mad God overpowering your sanity..."
	icon_state = "briarthorns"

/obj/item/clothing/head/roguetown/padded/briarthorns/pickup(mob/living/user)
	. = ..()
	to_chat(user, span_warning ("The thorns prick me."))
	user.adjustBruteLoss(4)

/obj/item/clothing/head/roguetown/articap
	desc = "A sporting cap with a small gear adornment. Popular fashion amongst engineers."
	icon_state = "articap"

/obj/item/clothing/head/roguetown/brimmed
	desc = "A simple brimmed hat that provides some relief from the sun."
	icon_state = "brimmed"

/obj/item/clothing/head/roguetown/roguehood/phys
	name = "physicker's hood"
	desc = "My cure is mostly effective."
	icon_state = "surghood"
	item_state = "surghood"
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	color = null

/obj/item/clothing/head/roguetown/nyle/consortcrown
	name = "consort crown"
	icon_state = "consortcrown"
	item_state = "consortcrown"
	sellprice = 100

/obj/item/clothing/head/roguetown/circlet
	name = "golden circlet"
	icon_state = "circlet"
	item_state = "circlet"
	sellprice = 50

/obj/item/clothing/head/roguetown/helmet/otavan
	name = "otavan helmet"
	desc = ""
	icon_state = "otavahelm"
	item_state = "otavahelm"
	adjustable = CAN_CADJUST
	emote_environment = 3
	body_parts_covered = FULL_HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/otavan/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "otavahelm_raised"
			body_parts_covered = HEAD|EARS|HAIR
			flags_inv = HIDEEARS
			flags_cover = null
			emote_environment = 0
			update_icon()
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			emote_environment = 3
			update_icon()
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()

/obj/item/clothing/head/roguetown/necramask
	name = "death mask"
	desc = "A hood with a decorated jaw bone at the chin,normally worn by some followers of Necra as a form of devotion"
	color = null
	icon_state = "deathface"
	item_state = "deathface"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	body_parts_covered = NECK|MOUTH //Jaw bone
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/helmet/heavy/abyssorgreathelm
	name = "abyssorite helmet"
	desc = "A helmet commonly worn by Templars in service to Abyssor. It evokes imagery of the sea with a menacing crustacean visage."
	icon_state = "abyssorgreathelm"
	item_state = "abyssorgreathelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/roguehood/feld
	name = "feldsher's hood"
	desc = "My cure is most effective."
	icon_state = "feldhood"
	item_state = "feldhood"
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	color = null

/obj/item/clothing/head/roguetown/helmet/overseer
    name = "Confessor mask"
    desc = "An iconic brass-colored metallic mask depicting visage of the Crying God. Too bulky to be worn with helmets."
    icon_state = "overseermask"
    item_state = "overseermask"
    icon = 'icons/roguetown/clothing/inquisition_overseers/overseer.dmi'
    mob_overlay_icon = 'icons/roguetown/clothing/inquisition_overseers/onmob/overseer_onmob.dmi'
    max_integrity = 150
    flags_inv = HIDEFACE
    body_parts_covered = FACE|HEAD|HAIR|EARS|NOSE
    flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
    block2add = FOV_BEHIND
    slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
    sellprice = 25

/obj/item/clothing/head/roguetown/helmet/overseer/vice
    name = "Lord Inquisitor mask"
    desc = "Silver-colored metallic mask covered in protective runes, depicting visage of the Crying God. Too bulky to be worn with helmets."
    icon_state = "viceseermask"
    item_state = "viceseermask"
    sellprice = 40
