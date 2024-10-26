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
	salvage_result = /obj/item/natural/hide

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
	desc = "The sanctified helm of the most devoted. Thiefs beware."
	color = null
	icon_state = "priesthead"
	item_state = "priesthead"
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
	..()

/obj/item/clothing/head/roguetown/roguehood/mage/Initialize()
	color = pick("#4756d8", "#759259", "#bf6f39", "#c1b144", "#b8252c")
	..()

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

/obj/item/clothing/head/roguetown/chaperon/marshal
	name = "chaperon hat"
	desc = "A fancy hat worn by nobles."
	icon_state = "chap_alt"
	item_state = "chap_alt"
	color = "#C0392B"

/obj/item/clothing/head/roguetown/chaperon/councillor
	icon_state = "chap_alt"
	item_state = "chap_alt"
	color = "#7dcea0"

/obj/item/clothing/head/roguetown/chef
	name = "chef's hat"
	desc = "A hat which signifies one as well versed in the arts of cooking."
	icon_state = "chef"

/obj/item/clothing/head/roguetown/armingcap
	name = "cap"
	desc = "A light cap made of leather, usually worn under a helmet."
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
	clothing_flags = CANT_SLEEP_IN
	sewrepair = FALSE

/obj/item/clothing/head/roguetown/crown/serpcrown

/obj/item/clothing/head/roguetown/crown/serpcrown/Initialize()
	. = ..()
	SSroguemachine.crown = src

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
	prevent_crits = list(BCLASS_CUT)
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
	clothing_flags = CANT_SLEEP_IN
	resistance_flags = FIRE_PROOF
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
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64
	flags_inv = HIDEEARS
	smeltresult = /obj/item/ash
	body_parts_covered = HEAD|HAIR

//................ CULTIST HOOD ............... //
/obj/item/clothing/head/roguetown/helmet/leather/hood_ominous/cult
	name = "ominous hood"
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

/obj/item/clothing/head/roguetown/helmet/sallet/visored
	name = "visored sallet"
	desc = "A steel helmet which protects the ears, eyes and nose."
	icon_state = "sallet_visor"
	max_integrity = 275
	adjustable = CAN_CADJUST
	flags_inv = HIDEFACE
	flags_cover = HEADCOVERSEYES
	armor_class = ARMOR_CLASS_MEDIUM
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES
	block2add = FOV_BEHIND

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

/obj/item/clothing/head/roguetown/helmet/astratahelm
	name = "astrata helmet"
	desc = "Headwear commonly worn by Templars in service to Astrata. The firstborn child's light will forever shine on within its crest."
	icon_state = "astratahelm"
	item_state = "astratahelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	armor_class = ARMOR_CLASS_MEDIUM
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/nochelm
	name = "noc helmet"
	desc = "Hearwear commonly worn by Templars in service to Noc. Without the night there can be no day, without Noc there can be no light in the dark hours."
	icon_state = "nochelm"
	item_state = "nochelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	armor_class = ARMOR_CLASS_MEDIUM
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/necrahelm
	name = "necra helmet"
	desc = "Headwear commonly worn by Templars in service to Necra. Let its skeletal features remind you of the only thing which is guaranteed in life. You will die."
	icon_state = "necrahelm"
	item_state = "necrahelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	armor_class = ARMOR_CLASS_MEDIUM
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/dendorhelm
	name = "dendor helmet"
	desc = "Headwear commonly worn by Templars in service to Dendor. Its protrusions almost resemble branches. Take root in the earth, and you will never be moved."
	icon_state = "dendorhelm"
	item_state = "dendorhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	armor_class = ARMOR_CLASS_MEDIUM
	block2add = FOV_BEHIND

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

/obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
	desc = "A helmet which covers the whole of the head. Offers excellent protection. This one has a golden cross-shaped brow."
	icon_state = "topfhelm_gold"
	item_state = "topfhelm_gold"

/obj/item/clothing/head/roguetown/helmet/heavy/astratahelm
	name = "astrata helmet"
	desc = "Headwear commonly worn by Templars in service to Astrata. The firstborn child's light will forever shine on within its crest."
	icon_state = "astratahelm"
	item_state = "astratahelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/nochelm
	name = "noc helmet"
	desc = "Hearwear commonly worn by Templars in service to Noc. Without the night there can be no day, without Noc there can be no light in the dark hours."
	icon_state = "nochelm"
	item_state = "nochelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/necrahelm
	name = "necra helmet"
	desc = "Headwear commonly worn by Templars in service to Necra. Let its skeletal features remind you of the only thing which is guaranteed in life. You will die."
	icon_state = "necrahelm"
	item_state = "necrahelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
	name = "dendor helmet"
	desc = "Headwear commonly worn by Templars in service to Dendor. Its protrusions almost resemble branches. Take root in the earth, and you will never be moved."
	icon_state = "dendorhelm"
	item_state = "dendorhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/pigface
	name = "pigface bascinet"
	desc = "A steel bascinet helmet with a pigface visor protecting the head, ears, eyes, nose and mouth."
	icon_state = "hounskull"
	item_state = "hounskull"
	adjustable = CAN_CADJUST
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_RIGHT|FOV_LEFT

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

/obj/item/clothing/head/roguetown/helmet/heavy/volfplate
	name = "volf-face helm"
	desc = "A steel bascinet helmet with a volfish visor protecting the head, ears, eyes, nose and mouth."
	icon_state = "volfplate"
	item_state = "volfplate"
	adjustable = CAN_CADJUST
	emote_environment = 3
	armor_class = ARMOR_CLASS_MEDIUM
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/volfplate/AdjustClothes(mob/user)
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

/obj/item/clothing/head/roguetown/helmet/bascinet
	name = "bascinet"
	desc = "A steel bascinet helmet without a visor protecting the the head and ears."
	icon_state = "bascinet_novisor"
	item_state = "bascinet_novisor"
	max_integrity = 235
	emote_environment = 3
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR
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
	salvage_result = /obj/item/natural/hide

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
	salvage_result = /obj/item/natural/hide

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
	salvage_result = /obj/item/natural/hide
