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

/obj/item/clothing/head/roguetown/equipped(mob/user, slot)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/head/roguetown/dropped(mob/user)
	. = ..()
	user.update_fov_angles()


/obj/item/clothing/head/roguetown/antlerhood
	name = "antlerhood"
	desc = "A hood suited for druids and shamans."
	color = null
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "antlerhood"
	item_state = "antlerhood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	max_integrity = 100
	armor = list("blunt" = 16, "slash" = 19, "stab" = 15, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_TWIST)
	anvilrepair = null
	sewrepair = TRUE
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/tribalskull
	name = "wendigo skull"
	desc = "The skull of a terrifying wendigo repurposed into a helmet."
	color = null
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACE|HIDEFACIALHAIR
	icon_state = "tribeskull"
	item_state = "tribeskull"
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	armor = list("blunt" = 20, "slash" = 25, "stab" = 20, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_TWIST)
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/sackhood
	name = "sackhood"
	desc = "A simple sack repurposed into a mask."
	color = null
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACE
	icon_state = "sackhood"
	item_state = "sackhood"
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	max_integrity = 100
	armor = list("blunt" = 16, "slash" = 19, "stab" = 15, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_TWIST)
	anvilrepair = null
	sewrepair = TRUE
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/roguehood
	name = "hood"
	desc = ""
	color = CLOTHING_BROWN
	icon_state = "basichood"
	item_state = "basichood"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_CLOAK
	sleevetype = null
	sleeved = null
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/roguehood/shalal
	name = "keffiyeh"
	desc = "A protective covering worn by those native to the desert."
	color = null
	icon_state = "shalal"
	item_state = "shalal"
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR
	sleevetype = null
	sleeved = null
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	alternate_worn_layer  = 8.9 //On top of helmet
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	armor = list("blunt" = 15, "slash" = 20, "stab" = 15, "bullet" = 1, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	blocksound = SOFTHIT
	max_integrity = 100
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/roguehood/shalal/AdjustClothes(mob/user)
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
				H.update_inv_cloak()
			block2add = FOV_BEHIND
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEEARS|HIDEHAIR
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
					H.update_inv_wear_mask() //Snowflake case for Desert Merc hood
					H.update_inv_cloak()
		user.update_fov_angles()

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
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/roguehood/tricksterhood
	name = "trickster hood"
	desc = "A hood worn by those who favor Xylix the trickster. And strange and unusual garment, as befits the wearer no doubt, complete with a rope around the neck to fit it into place."
	color = null
	icon_state = "tricksterhood"
	item_state = "tricksterhood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
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
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/psydonhood
	name = "psydon hood"
	desc = "Blood of Psydon preserve me."
	color = null
	icon_state = "psydonhood"
	item_state = "psydonhood"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/dendormask
	name = "briarmask"
	desc = "A mask of wood worn by druids in service to Dendor."
	color = null
	icon_state = "dendormask"
	item_state = "dendormask"
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
	dynamic_hair_suffix = ""
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/necromhood
	name = "necromancers hood"
	color = null
	icon_state = "necromhood"
	item_state = "necromhood"
	body_parts_covered = NECK
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/priestmask
	name = "solar visage"
	desc = "The sanctified helm of the most devoted. Thiefs beware."
	color = null
	icon_state = "priesthead"
	item_state = "priesthead"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/priestmask/pickup(mob/living/user)
	if((user.job != "Priest") && (user.job != "Priestess"))
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
				H.update_inv_cloak()
			block2add = FOV_BEHIND
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = null
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
					H.update_inv_wear_mask() //Snowflake case for Desert Merc hood
					H.update_inv_cloak()
		user.update_fov_angles()


/obj/item/clothing/head/roguetown/menacing
	name = "executioner hood"
	desc = "A hood commonly worn by executioners. Hides the face, the stigma of pulling that lever makes many executioners outcasts in their own right."
	icon_state = "menacing"
	item_state = "menacing"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	sewrepair = TRUE
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/menacing/bandit
	icon_state = "bandithood"

/obj/item/clothing/head/roguetown/jester
	name = "jester's hat"
	desc = "A funny looking hat with jingly bells attached to it."
	icon_state = "jester"
	item_state = "jester"
	dynamic_hair_suffix = "+generic"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/strawhat
	name = "straw hat"
	desc = "Keeps the sun off your head while toiling the fields."
	icon_state = "strawhat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/puritan
	name = "buckled hat"
	icon_state = "puritan_hat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/nightman
	name = "teller's hat"
	icon_state = "tophat"
	color = CLOTHING_BLACK
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/bardhat
	name = "hat"
	icon_state = "bardhat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/fancyhat
	name = "fancy hat"
	desc = "A fancy looking hat with colorful feathers sticking out of it."
	icon_state = "fancy_hat"
	item_state = "fancyhat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/hatfur
	name = "fur hat"
	desc = "A comfortable warm hat lined with fur."
	icon_state = "hatfur"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/papakha
	name = "papakha"
	icon_state = "papakha"
	item_state = "papakha"
	sewrepair = TRUE
	flags_inv = HIDEEARS

/obj/item/clothing/head/roguetown/hatblu
	name = "fur hat"
	desc = "A blue hat lined with fur."
	icon_state = "hatblu"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/fisherhat
	name = "straw hat"
	desc = "A hat worn by fishermen to protect from the sun."
	icon_state = "fisherhat"
	item_state = "fisherhat"
	sewrepair = TRUE
//	color = "#fbc588"
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/flathat
	name = "flat hat"
	icon_state = "flathat"
	item_state = "flathat"
	sewrepair = TRUE


/obj/item/clothing/head/roguetown/chaperon
	name = "chaperon hat"
	desc = "A fancy hat worn by nobles."
	icon_state = "chaperon"
	item_state = "chaperon"
	flags_inv = HIDEEARS
	sewrepair = TRUE
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/cookhat
	name = "cook hat"
	desc = "A hat which signifies one as well versed in the arts of cooking."
	icon_state = "chef"
	item_state = "chef"
	flags_inv = HIDEEARS
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/chaperon/greyscale
	name = "chaperon hat"
	desc = "A fancy hat worn by nobles."
	icon_state = "chap_alt"
	item_state = "chap_alt"
	flags_inv = HIDEEARS
	color = "#cf99e3"

/obj/item/clothing/head/roguetown/chaperon/old
	name = "chaperon hat"
	desc = "A fancy hat worn by nobles."
	icon_state = "chap_alt"
	item_state = "chap_alt"
	flags_inv = HIDEEARS
	color = "#C0392B"

/obj/item/clothing/head/roguetown/chaperon/councillor
	name = "chaperon hat"
	desc = "A fancy hat worn by nobles."
	icon_state = "chap_alt"
	item_state = "chap_alt"
	flags_inv = HIDEEARS
	color = "#7dcea0"

/obj/item/clothing/head/roguetown/chef
	name = "chef's hat"
	desc = "A hat which signifies one as well versed in the arts of cooking."
	icon_state = "chef"
	sewrepair = TRUE
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/armingcap
	name = "cap"
	desc = "A light cap made of leather, usually worn under a helmet."
	icon_state = "armingcap"
	item_state = "armingcap"
	flags_inv = HIDEEARS
	sewrepair = TRUE
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/knitcap
	name = "knit cap"
	desc = "A simple knitted cap."
	icon_state = "knitcap"
	sewrepair = TRUE
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/armingcap/dwarf
	color = "#cb3434"

/obj/item/clothing/head/roguetown/headband
	name = "headband"
	desc = "A simple headband to keep sweat out of your eyes."
	icon_state = "headband"
	item_state = "headband"
	sewrepair = TRUE
	//dropshrink = 0.75
	dynamic_hair_suffix = null

/obj/item/clothing/head/roguetown/headband/red
	color = CLOTHING_RED

/obj/item/clothing/head/roguetown/crown/serpcrown
	name = "crown of rockhill"
	desc = ""
	icon_state = "serpcrown"
	//dropshrink = 0
	dynamic_hair_suffix = null
	sellprice = 200
	resistance_flags = FIRE_PROOF | ACID_PROOF
	anvilrepair = /datum/skill/craft/armorsmithing

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
	desc = ""
	icon_state = "sparrowcrown"
	//dropshrink = 0
	dynamic_hair_suffix = null
	resistance_flags = FIRE_PROOF | ACID_PROOF
	sellprice = 50
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/head/roguetown/priesthat
	name = "priest's hat"
	desc = ""
	icon_state = "priest"
	//dropshrink = 0
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	dynamic_hair_suffix = "+generic"
	sellprice = 77
	worn_x_dimension = 64
	worn_y_dimension = 64
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/reqhat
	name = "serpent crown"
	desc = ""
	icon_state = "reqhat"
	flags_inv = HIDEEARS
	sellprice = 100
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/head/roguetown/headdress
	name = "foreign headdress"
	desc = ""
	icon_state = "headdress"
	sellprice = 10
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/headdress/alt
	icon_state = "headdressalt"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/nun
	name = "nun's habit"
	icon_state = "nun"
	sellprice = 5
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/hennin
	name = "hennin"
	desc = "A hat typically worn by women in nobility."
	icon_state = "hennin"
	sellprice = 19
	dynamic_hair_suffix = "+generic"
	sewrepair = TRUE

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
	sewrepair = TRUE

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
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	blocksound = PLATEHIT
	max_integrity = 200

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
	max_integrity = 200
	body_parts_covered = HEAD|HAIR

/obj/item/clothing/head/roguetown/helmet/winged
	name = "winged cap"
	desc = "A helmet with two wings on its sides."
	icon_state = "wingedcap"
	max_integrity = 200
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	body_parts_covered = HEAD|HAIR

/obj/item/clothing/head/roguetown/helmet/kettle
	desc = "A steel helmet which protects the top and sides of the head."
	icon_state = "kettle"
	body_parts_covered = HEAD|HAIR|EARS
	armor = list("blunt" = 80, "slash" = 90, "stab" = 70, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	flags_inv = HIDEEARS

/obj/item/clothing/head/roguetown/helmet/sallet
	name = "sallet"
	icon_state = "sallet"
	desc = "A steel helmet which protects the ears."
	smeltresult = /obj/item/ingot/steel
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEEARS

/obj/item/clothing/head/roguetown/helmet/sallet/visored
	name = "visored sallet"
	desc = "A steel helmet which protects the ears, nose, and eyes."
	icon_state = "sallet_visor"
	adjustable = CAN_CADJUST
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	body_parts_covered = FULL_HEAD
	block2add = FOV_BEHIND
	max_integrity = 400

/obj/item/clothing/head/roguetown/helmet/sallet/visored/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "[initial(icon_state)]_raised"
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
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	max_integrity = 400

/obj/item/clothing/head/roguetown/helmet/elfbarbute
	name = "elven barbute"
	desc = "A graceful helmet in an Elven design."
	body_parts_covered = FULL_HEAD
	icon_state = "elven_barbute_full"
	item_state = "elven_barbute_full"
	flags_inv = HIDEEARS|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST)
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	max_integrity = 400

/obj/item/clothing/head/roguetown/helmet/elfbarbutewings
	name = "winged elven barbute"
	desc = "A graceful helmet in the Elven design, this one has a set of wings decorating it."
	body_parts_covered = FULL_HEAD
	icon_state = "elven_barbute_winged"
	item_state = "elven_barbute_winged"
	flags_inv = HIDEEARS|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST)
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	max_integrity = 400	

/obj/item/clothing/head/roguetown/helmet/heavy/guard
	name = "savoyard"
	desc = "A helmet with a menacing visage."
	icon_state = "guardhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/sheriff
	name = "barred helmet"
	desc = "A helmet which offers good protection to the face at the expense of vision."
	icon_state = "gatehelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/knight
	name = "knight's helmet"
	desc = "A noble knight's helm in the current style popular with nobility. Add a feather to show the colors of your family or allegiance."
	icon_state = "knight"
	item_state = "knight"
	adjustable = CAN_CADJUST
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
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
			flags_inv = HIDEEARS|HIDEHAIR
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
		qdel(W)
		user.visible_message(span_warning("[user] adds [W] to [src]."))

		var/mob/living/carbon/human/L = loc
		var/choice = input(L, "Choose a color.", "Knight's Plume") as anything in colors
		var/playerchoice = colors[choice]
		detail_color = playerchoice
		detail_tag = "_detail"
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

/obj/item/clothing/head/roguetown/helmet/heavy/royalknight
	name = "royal guard's helmet"
	desc = "A helmet worn by those in the royal guard. Decorated with gold, its white feathers a sign of the oath made to protect the royals until death."
	icon_state = "royalh"
	item_state = "royalh"
	adjustable = CAN_CADJUST
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/royalknight/black
	color = CLOTHING_BLACK

/obj/item/clothing/head/roguetown/helmet/heavy/royalknight/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "royalhum"
			body_parts_covered = HEAD|HAIR|EARS
			flags_inv = HIDEEARS|HIDEHAIR
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

/obj/item/clothing/head/roguetown/helmet/heavy/royalknight/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet
	name = "armet helmet"
	desc = "A closed-face plate helmet with two movable cheek pieces and a faceplate. Add a feather to show the colors of your family or allegiance."
	icon_state = "armet"
	item_state = "armet"

/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "armetum"
			body_parts_covered = HEAD|HAIR|EARS
			flags_inv = HIDEEARS|HIDEHAIR
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

/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet/attackby(obj/item/W, mob/living/user, params)
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
		qdel(W)
		user.visible_message(span_warning("[user] adds [W] to [src]."))

		var/mob/living/carbon/human/L = loc
		var/choice = input(L, "Choose a color.", "Knight's Plume") as anything in colors
		var/playerchoice = colors[choice]
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/bucket
	name = "bucket helmet"
	desc = "A helmet which covers the whole of the head. Offers excellent protection."
	icon_state = "topfhelm"
	item_state = "topfhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/astratahelm
	name = "astrata helmet"
	desc = "Headwear commonly worn by Templars in service to Astrata. The firstborn child's light will forever shine on within its crest."
	icon_state = "astratahelm"
	item_state = "astratahelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/psyhelm
	name = "psydon helmet"
	desc = "A helmet formerly worn by those who were templars in service to Psydon. The time where Psydon once had templars is long passed now, but these relics still remain."
	icon_state = "psydonhelm"
	item_state = "psydonhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel	

/obj/item/clothing/head/roguetown/helmet/heavy/eorahelm
    name = "eora helmet"
    desc = "Headwear commonly worn by Templars in service to Eora. The chained heart on its front demonstrates its wearer's commitment to protect unbound love, even at ones own expense."
    icon_state = "eorahelm"
    item_state = "eorahelm"
    emote_environment = 3
    flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
    block2add = FOV_BEHIND
    smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/nochelm
	name = "noc helmet"
	desc = "Hearwear commonly worn by Templars in service to Noc. Without the night there can be no day, without Noc there can be no light in the dark hours."
	icon_state = "nochelm"
	item_state = "nochelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/necrahelm
	name = "necra helmet"
	desc = "Headwear commonly worn by Templars in service to Necra. Let its skeletal features remind you of the only thing which is guaranteed in life. You will die."
	icon_state = "necrahelm"
	item_state = "necrahelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
	name = "dendor helmet"
	desc = "Headwear commonly worn by Templars in service to Dendor. Its protrusions almost resemble branches. Take root in the earth, and you will never be moved."
	icon_state = "dendorhelm"
	item_state = "dendorhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/bascinet
	name = "bascinet"
	desc = "A steel bascinet helmet without a visor protecting the the head and ears."
	icon_state = "bascinet_novisor"
	item_state = "bascinet_novisor"
	emote_environment = 3
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEEARS|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/bascinet/helmetbars
	name = "helmetbars"
	desc = "A steel bascinet helmet with metal bars protecting the face"
	icon_state = "helmetbars"
	item_state = "helmetbars"
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	flags_inv = HIDEEARS|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel	

/obj/item/clothing/head/roguetown/helmet/bascinet/pigface
	name = "pigface bascinet"
	desc = "A steel bascinet helmet with an elongated visor protecting the head, ears, nose, mouth, and eyes. Add a feather to show the colors of your family or allegiance."
	icon_state = "hounskull"
	item_state = "hounskull"
	adjustable = CAN_CADJUST
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	max_integrity = 400

/obj/item/clothing/head/roguetown/helmet/bascinet/pigface/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "hounskull_um"
			item_state = "hounskull_um"
			body_parts_covered = HEAD|EARS|HAIR
			flags_inv = HIDEEARS|HIDEHAIR
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
			update_icon("hounskull")
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()

/obj/item/clothing/head/roguetown/helmet/bascinet/pigface/attackby(obj/item/W, mob/living/user, params)
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
		qdel(W)
		user.visible_message(span_warning("[user] adds [W] to [src]."))

		var/mob/living/carbon/human/L = loc
		var/choice = input(L, "Choose a color.", "Bascinet plume") as anything in colors
		var/playerchoice = colors[choice]
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/bascinet/pigface/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

// Snowflake helmet for the royal guard; guess we're making them stand out now. Same stats as normal bascinet.
/obj/item/clothing/head/roguetown/helmet/bascinet/royalguard
	name = "royal guard bascinet"
	desc = "A steel bascinet helmet, without a visor, protecting the the head and ears. This helmet has a royal ploom atop of it!"
	icon_state = "bascinet_royalguard"
	item_state = "bascinet_royalguard"

/obj/item/clothing/head/roguetown/helmet/heavy/beakhelmet
	name = "beak helmet"
	desc = "Odd spherical helmet with a beaklike visor."
	icon_state = "beakhelmet"
	item_state = "beakhelmet"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel	

/obj/item/clothing/head/roguetown/helmet/heavy/blacksunhelm
	name = "black sun helmet"
	desc = "Headwear worn by those who lead Graggarite fanatics. A twisted depiction of the black sun, a single hate-filled eye peers out of its grinning face."
	icon_state = "blacksunhelm"
	item_state = "blacksunhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/graggaritehelmet
	name = "Graggarite Helmet"
	desc = "A helmet worn by Graggarite fanatics, designed in such a way to terrify victims."
	icon_state = "graggaritehelmet"
	item_state = "graggaritehelmet"
	flags_inv = HIDEEARS|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/carapacecap
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "carapace cap"
	desc = "Watery armored plates sown together to protect your head."
	body_parts_covered = HEAD|HAIR
	icon_state = "carapacecap"
	item_state = "carapacecap"
	armor = list("blunt" = 60, "slash" = 60, "stab" = 60, "bullet" = 60, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT)
	max_integrity = 100
	anvilrepair = null
	sewrepair = TRUE
	blocksound = PLATEHIT
	smeltresult = /obj/item/ash
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'

/obj/item/clothing/head/roguetown/helmet/carapacehelm
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "carapace helmet"
	desc = "Tightly sealed plates of aquatic armor."
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	icon_state = "carapacehelm"
	item_state = "carapacehelm"
	armor = list("blunt" = 60, "slash" = 100, "stab" = 60, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	max_integrity = 150
	anvilrepair = null
	sewrepair = TRUE
	blocksound = PLATEHIT
	smeltresult = /obj/item/ash
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'

/obj/item/clothing/head/roguetown/helmet/leather
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "leather helmet"
	desc = "A helmet made of leather."
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	icon_state = "leatherhelm"
	armor = list("blunt" = 47, "slash" = 27, "stab" = 37, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	smeltresult = null
	sewrepair = TRUE
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "volf helmet"
	desc = "A helmet made using the remains of a volf, surprisingly comfortable."
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR|HIDEEARS
	icon_state = "volfhelm"
	item_state = "volfhelm"
	armor = list("blunt" = 47, "slash" = 27, "stab" = 37, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	sewrepair = TRUE
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/helmet/leather/volfhead
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "volf head"
	desc = "A helmet made using the head of a volf."
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR|HIDEEARS
	icon_state = "volfhead"
	item_state = "volfhead"
	armor = list("blunt" = 45, "slash" = 25, "stab" = 35, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	sewrepair = TRUE
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/helmet/leather/bearhead
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "bear head"
	desc = "Upon closer inspection, this is made of volf fur, not bear fur, but who will know the difference?"
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR|HIDEEARS
	icon_state = "bearpelt"
	item_state = "bearpelt"
	armor = list("blunt" = 50, "slash" = 30, "stab" = 40, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	sewrepair = TRUE
	blocksound = SOFTHIT	

/obj/item/clothing/head/roguetown/wizhat
	name = "wizard hat"
	desc = "Used to distinguish dangerous wizards from senile old men."
	icon_state = "wizardhat"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	dynamic_hair_suffix = "+generic"
	worn_x_dimension = 64
	worn_y_dimension = 64
	sewrepair = TRUE

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
	anvilrepair = /datum/skill/craft/armorsmithing

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
	armor = list("blunt" = 15, "slash" = 20, "stab" = 15, "bullet" = 1, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	var/picked = FALSE

/obj/item/clothing/head/roguetown/grenzelhofthat/attack_right(mob/user)
	..()
	if(!picked)
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

		var/choice = input(user, "Choose a color.", "Grenzelhoft colors") as anything in colors
		var/playerchoice = colors[choice]
		picked = TRUE
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/grenzelhofthat/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/footmanhelmet
	name = "footman helmet"
	desc = "A helmet worn in Grenzelhoft by rank and file soldiery. The color of the plume is often used to specify a soldier's batallion, making it easier to coordinate in battle."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "footmanhelmet"
	item_state = "footmanhelmet"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/footmanhelmet/attack_right(mob/user)
	..()
	if(!picked)
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

		var/choice = input(user, "Choose a color.", "Grenzelhoft colors") as anything in colors
		var/playerchoice = colors[choice]
		picked = TRUE
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/footmanhelmet/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)		

/obj/item/clothing/head/roguetown/helmet/grenzknighthelmet
	name = "grenzelhoft knight helmet"
	desc = "A helmet worn by Grenzelhoft knights, made of black-steel. The feathers on the back of it can be colored to show off ones noble house or allegiance."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACE|HIDEFACIALHAIR
	icon_state = "grenzkhelm"
	item_state = "grenzkhelm"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/grenzknighthelmet/attack_right(mob/user)
	..()
	if(!picked)
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

		var/choice = input(user, "Choose a color.", "Grenzelhoft colors") as anything in colors
		var/playerchoice = colors[choice]
		picked = TRUE
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/grenzknighthelmet/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)				
//Eora content from Stonekeep

/obj/item/clothing/head/roguetown/eoramask
	name = "eoran mask"
	desc = "A silver rabbet mask worn by the faithful of Eora, usually during their rituals."
	color = null
	icon_state = "eoramask"
	item_state = "eoramask"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
	dynamic_hair_suffix = ""
	resistance_flags = FIRE_PROOF // Made of metal

/obj/item/clothing/head/roguetown/helmet/katefractoiihelmet
	name = "katefractoii helmet"
	desc = "A tall helmet worn by the elite Katefractoii heavy cavalry."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "katefractoiihelmet"
	item_state = "katefractoiihelmet"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	smeltresult = /obj/item/ingot/iron	

/obj/item/clothing/head/roguetown/helmet/heavy/dwarfhelm
	name = "dwarven helmet"
	desc = "A heavy helmet in the iconic Dwarven style. It is made in such a way to allow ones beard to be visible even while wearing it."
	icon_state = "dwarvenhelmet"
	item_state = "dwarvenhelmet"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/darkelfhelmet
	name = "raider helmet"
	desc = "A helmet worn by Dark Elf surface raiders."
	icon_state = "darkelfhelmet"
	item_state = "darkelfhelmet"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	emote_environment = 3
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEEARS|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/foresterhelmet
	name = "forester helmet"
	desc = "A helmet worn by those who dwell in the forests of the world."
	icon_state = "foresterhelmet"
	item_state = "foresterhelmet"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	emote_environment = 3
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	smeltresult = /obj/item/ash

/obj/item/clothing/head/roguetown/helmet/heavy/spellslingerhelm
	name = "spellslinger helmet"
	desc = "A helmet commonly worn by those with a mastery of both swordsmanship and magic." //Maybe give this armor set antimagic in the future?
	icon_state = "spellslingerhelmet"
	item_state = "spellslingerhelmet"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/cage
	name = "cage"
	desc = "A cage worn by criminals as punishment."
	icon_state = "cage"
	item_state = "cage"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/heavy/psydonianknighthelm
	name = "psydonian knight helmet"
	desc = "PSYDON lives."
	icon_state = "psydonianknighthelm"
	item_state = "psydonianknighthelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/zealothelm
	name = "zealot helmet"
	desc = "A helmet designed to reflect the face of those whom its wearer is tormenting. Commonly worn by the underlings of Inquisitors."
	icon_state = "zealotshelmet"
	item_state = "zealotshelmet"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/zybantinehelm
	name = "zybantine helmet"
	desc = "A helmet worn by soldiers of the Zybantine Empire."
	icon_state = "zybantinehelm"
	item_state = "zybantinehelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/xylixcagehelm
	name = "xylix cage helmet"
	desc = "Headwear commonly worn by acolytes who worship Xylix. Life is a cage and we must all do our time."
	icon_state = "xylixcagehelm"
	item_state = "xylixcagehelm"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	emote_environment = 3
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/ravoxhelm
	name = "ravox helmet"
	desc = "Headwear commonly worn by Templars in service to Ravox. This helmet is a testament to the martial prowess of those who worship Ravox, the bull headed son of Psydon."
	icon_state = "ravoxhelm"
	item_state = "ravoxhelm"
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
	emote_environment = 3
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel	

/obj/item/clothing/head/roguetown/helmet/heavy/malumhelm
	name = "malum fullmask"
	desc = "Headwear commonly worn by acolytes in service to Malum. Like Malum, they are shackled to this world with not a care for how they suffer. Such is the way of the children of the opinionless god."
	icon_state = "malumhelm"
	item_state = "malumhelm"
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEHAIR
	emote_environment = 3
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel	

/obj/item/clothing/head/roguetown/helmet/heavy/abyssorhelm
	name = "abyssor helmet"
	desc = "Headwear commonly worn by Templars in service to Abyssor. This helmet somewhat resembles some of the stranger fish that have been dragged up from the depths of the ocean."
	icon_state = "abyssorhelm"
	item_state = "abyssorhelm"
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
	emote_environment = 3
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel		

/obj/item/clothing/head/roguetown/helmet/heavy/xylixhelm
	name = "xylix helmet"
	desc = "Headwear commonly worn by Templars in service to Xylix. Can you see it yet? If not it might be best to add more eyes."
	icon_state = "xylixhelm"
	item_state = "xylixhelm"
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
	emote_environment = 3
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel	

/obj/item/clothing/head/roguetown/helmet/heavy/pestrahelm
	name = "pestra helmet"
	desc = "Headwear commonly worn by Templars in service to Pestra. This helmet has a decorated mask attached to it, tears running down its eye slits. To some, Pestra's fate is a tragedy worthy of tears. To be both the disease and the cure.."
	icon_state = "pestrahelm"
	item_state = "pestrahelm"
	flags_inv = HIDEFACE|HIDEHAIR
	emote_environment = 3
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel	

/obj/item/clothing/head/roguetown/helmet/ironpothelmet
	name = "iron pot helmet"
	desc = "A simple iron helmet which protects the head well."
	block2add = FOV_BEHIND
	flags_inv = HIDEHAIR
	icon_state = "pothelm"
	item_state = "pothelm"
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/zybanturiflehelm
	name = "janissary helmet"
	desc = "A helmet commonly worn by janissary slave soldiers in the Zybantine Empire."
	icon_state = "zybanturiflemanhelm"
	item_state = "zybanturiflemanhelm"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	emote_environment = 3
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR|HIDEEARS
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel	

/obj/item/clothing/head/roguetown/helmet/nephilhelm
	name = "nephilim helmet"
	desc = "A helmet once worn by the descendents of giants."
	icon_state = "nephilimhelm"
	item_state = "nephilimhelm"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	emote_environment = 3
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ash

/obj/item/clothing/head/roguetown/helmet/ironplatehelmet
	name = "iron plate helmet"
	desc = "An iron helmet which fully covers the head, cheap and gets the job done."
	block2add = FOV_BEHIND
	flags_inv = HIDEHAIR|HIDEFACE|HIDEFACIALHAIR
	icon_state = "ironplate"
	item_state = "ironplate"
	smeltresult = /obj/item/ingot/iron	

/obj/item/clothing/head/roguetown/helmet/malumhelmet
	name = "malum helmet"
	desc = "Headwear commonly worn by Templars in service to Malum. It resembles the helmet worn by slaves sent to death in gladiatorial bouts."
	block2add = FOV_BEHIND
	flags_inv = HIDEHAIR|HIDEFACE|HIDEFACIALHAIR
	icon_state = "slavehelm"
	item_state = "slavehelm"
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/roguehood/feldhood
	name = "heavy hood"
	desc = "A heavy hood."
	color = null
	icon_state = "feldhood"
	item_state = "feldhood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/roguehood/surghood
	name = "heavy hood"
	desc = "A heavy hood."
	color = null
	icon_state = "surghood"
	item_state = "surghood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/helmet/dendorculthelm
	name = "dendorite fanatic helmet"
	desc = "A depiction of Dendor before madness struck him. It could not have happened to a less deserving child of Psydon. The tragedy is knowing that there was once a point in time where he was not wracked with madness, and so many are willing to forget."
	icon_state = "dendor"
	item_state = "dendor"
	emote_environment = 3
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	smeltresult = /obj/item/ash

/obj/item/clothing/head/roguetown/helmet/valorianhelmet
	name = "valorian helmet"
	desc = "A helmet worn by the soldiers of Valoria, somewhat lightweight."
	block2add = FOV_BEHIND
	flags_inv = HIDEHAIR
	icon_state = "valorianhelm"
	item_state = "valorianhelm"
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/valoriandecoratedhelm
	name = "valorian decorated helm"
	desc = "A helmet worn by the soldiers of Valoria. This one is decorated with a cloth wrapping."
	block2add = FOV_BEHIND
	flags_inv = HIDEHAIR
	icon_state = "valoriandecoratedhelm"
	item_state = "valoriandecoratedhelm"
	smeltresult = /obj/item/ingot/iron	

/obj/item/clothing/head/roguetown/helmet/vikinghelmet
	name = "viking helmet"
	desc = "A helmet commonly worn by vikings. Before Graggar infested the hearts of the Frost Landers, this was the go to helmet of the northman. It still sees some use by those vikings who migrated from the Frost Lands before Graggar worship became more commonplace."
	block2add = FOV_BEHIND
	flags_inv = HIDEHAIR|HIDEFACE|HIDEFACIALHAIR
	icon_state = "vikinghelm"
	item_state = "vikinghelm"
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/vikingbodyguardhelmet
	name = "bodyguard helmet"
	desc = "A steel helmet with a coif commonly worn by viking bodyguards, a highly valued profession, which sees some of the northmen travelling far to find work."
	icon_state = "vikingbodyguardh"
	item_state = "vikingbodyguardh"
	emote_environment = 3
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACE|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/spellcasterhat
	name = "spellcaster hat"
	desc = "An oddly shaped hat commonly worn by journeymen wizards."
	icon_state = "spellcasterhat"
	item_state = "spellcasterhat"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/judgehat
	name = "judge hat"
	desc = "A hat worn by judges. Practical while also providing a level of warmth thanks to the attached coif."
	icon_state = "judgehat"
	item_state = "judgehat"
	flags_inv = HIDEEARS|HIDEHAIR
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/flophat
	name = "flop hat"
	desc = "A large hat that's become popular with the peasantry."
	icon_state = "flophat"
	item_state = "flophat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/fancycap
	name = "fancy cap"
	desc = "A cap with a feather in it."
	icon_state = "fancycap"
	item_state = "fancycap"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/roguehood/flagellanthood
	name = "ravox hood"
	desc = "Headwear commonly worn by Acolytes who worship Ravox. The most fanatical of Ravox's followers are known to flagellate themselves, in an attempt to purge any weakness from their mortal body. As such, the robes help to hide the blood somewhat."
	icon_state = "ravoxhood"
	item_state = "ravoxhood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	color = null
	slot_flags = ITEM_SLOT_HEAD
	flags_inv = HIDEHAIR|HIDEEARS
	dynamic_hair_suffix = ""
	edelay_type = 1

/obj/item/clothing/head/roguetown/roguehood/necracolytehood
	name = "necran hood"
	desc = "Headwear commonly worn by Acolytes who worship Necra. It is similar to a veil worn by mourners, it is in that same way that Necrans mourn the dead. The most fanatical of them long to join them, even though they know suicide is a grave sin in the eyes of the gods, one which could even see you posthumously excommunicated."
	icon_state = "necacohood"
	item_state = "necacohood"
	color = null
	slot_flags = ITEM_SLOT_HEAD
	flags_inv = HIDEHAIR|HIDEEARS
	dynamic_hair_suffix = ""
	edelay_type = 1

/obj/item/clothing/head/roguetown/headscarf
	name = "headscarf"
	desc = "A simple white headbanned tied around the head to keep sweat out of the eyes."
	icon_state = "headscarf"
	item_state = "headscarf"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/helmet/rustedhelmet
	name = "rusted helmet"
	desc = "A rusted, battered helmet from a bygone era. Are you sure you want to wear this?"
	block2add = FOV_BEHIND
	flags_inv = HIDEHAIR
	icon_state = "rustbarbuta"
	item_state = "rustbarbuta"
	smeltresult = /obj/item/ash

/obj/item/clothing/head/roguetown/helmet/abyssorhat
	name = "abyssor hood"
	desc = "A hood worn by worhippers of Abyssor. Those who worship Abyssor peer through the eyeslits of this hood with glassy, fishlike eyes, as though they long to be under the waves."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "abyssorhood"
	item_state = "abyssorhood"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	smeltresult = /obj/item/ash

/obj/item/clothing/head/roguetown/helmet/decoratedknighthelm
	name = "decorated knight helmet"
	desc = "A lavish knight's helmet which allows a crest to be mounted on top."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	icon_state = "decorated_knight"
	item_state = "decorated_knight"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/decoratedknighthelm/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = list(
		"Basic"="basic_decoration",
		"Blue"="blue_decoration",
		"Stripes"="stripes_decoration",
		"Red Castle"="castle_red_decoration",
		"White Castle"="castle_white_decoration",
		"Graggar"="graggar_decoration",
		"Efreet"="efreet_decoration",
		"Sun"="sun_decoration",
		"Feathers"="feathers_decoration",
		"Lion"="lion_decoration",
		"Red Dragon"="dragon_red_decoration",
		"Green Dragon"="dragon_green_decoration",
		"Horns"="horns_decoration",
		"Swan"="swan_decoration",
		"Fish"="fish_decoration",
		"Oathtaker"="oathtaker_decoration",
		"Skull"="skull_decoration")

		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/decoratedknighthelm/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)		

/obj/item/clothing/head/roguetown/helmet/decoratedhounskull
	name = "decorated hounskull"
	desc = "A lavish hounskull which allows a crest to be mounted on top."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	icon_state = "decorated_hounskull"
	item_state = "decorated_hounskull"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/decoratedhounskull/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = list(
		"Basic"="basic_houndecoration",
		"Blue"="blue_houndecoration",
		"Stripes"="stripes_houndecoration",
		"Red Castle"="castle_red_houndecoration",
		"White Castle"="castle_white_houndecoration",
		"Graggar"="graggar_houndecoration",
		"Efreet"="efreet_houndecoration",
		"Sun"="sun_houndecoration",
		"Feathers"="feathers_houndecoration",
		"Lion"="lion_houndecoration",
		"Red Dragon"="dragon_red_houndecoration",
		"Green Dragon"="dragon_green_houndecoration",
		"Horns"="horns_houndecoration",
		"Swan"="swan_houndecoration",
		"Fish"="fish_houndecoration",
		"Oathtaker"="oathtaker_houndecoration",
		"Skull"="skull_houndecoration")

		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/decoratedhounskull/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)		

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedbucket
	name = "decorated greathelm"
	desc = "A lavish greathelm which allows a crest to be mounted on top."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	icon_state = "decorated_bucket"
	item_state = "decorated_bucket"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedbucket/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = list(
		"Basic"="basic_bucket",
		"Blue"="blue_bucket",
		"Stripes"="stripes_bucket",
		"Red Castle"="castle_red_bucket",
		"White Castle"="castle_white_bucket",
		"Graggar"="graggar_bucket",
		"Efreet"="efreet_bucket",
		"Sun"="sun_bucket",
		"Feathers"="feathers_bucket",
		"Lion"="lion_bucket",
		"Red Dragon"="dragon_red_bucket",
		"Green Dragon"="dragon_green_bucket",
		"Horns"="horns_bucket",
		"Swan"="swan_bucket",
		"Fish"="fish_bucket",
		"Oathtaker"="oathtaker_bucket",
		"Skull"="skull_bucket")

		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedbucket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)		

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedgbucket
	name = "decorated goldhelm"
	desc = "A lavish gold-trimmed greathelm which allows a crest to be mounted on top."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	icon_state = "decorated_gbucket"
	item_state = "decorated_gbucket"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedgbucket/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = list(
		"Basic"="basic_gbucket",
		"Blue"="blue_gbucket",
		"Stripes"="stripes_gbucket",
		"Red Castle"="castle_red_gbucket",
		"White Castle"="castle_white_gbucket",
		"Graggar"="graggar_gbucket",
		"Efreet"="efreet_gbucket",
		"Sun"="sun_gbucket",
		"Feathers"="feathers_gbucket",
		"Lion"="lion_gbucket",
		"Red Dragon"="dragon_red_gbucket",
		"Green Dragon"="dragon_green_gbucket",
		"Horns"="horns_gbucket",
		"Swan"="swan_gbucket",
		"Fish"="fish_gbucket",
		"Oathtaker"="oathtaker_gbucket",
		"Skull"="skull_gbucket")

		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedgbucket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)		
