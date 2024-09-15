
/obj/item/clothing/proc/step_action() //this was made to rewrite clown shoes squeaking
	SEND_SIGNAL(src, COMSIG_CLOTHING_STEP_ACTION)

/obj/item/clothing/suit/roguetown/armor
	slot_flags = ITEM_SLOT_ARMOR
	body_parts_covered = CHEST
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	equip_sound = 'sound/blank.ogg'
	drop_sound = 'sound/blank.ogg'
	pickup_sound =  'sound/blank.ogg'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	sleevetype = "shirt"
	edelay_type = 1
	equip_delay_self = 25
	bloody_icon_state = "bodyblood"
	boobed = TRUE
	resistance_flags = FIRE_PROOF
	blocksound = PLATEHIT
	sellprice = 1
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	experimental_onhip = TRUE
	nodismemsleeves = TRUE
	flags_inv = HIDEBOOB|HIDECROTCH

//Handles debuff from wearing armor. This is slop, it just makes it so you can't put it on.
//Preferably - make a way to check when armor is on apply status effect of a debuff to stats, on remove, remove debuff. - Tried it a few ways, kept breaking.
/obj/item/clothing/suit/roguetown/armor/mob_can_equip(mob/user, mob/equipper, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(armor_class == ARMOR_CLASS_HEAVY)
		if(!HAS_TRAIT(H,TRAIT_HEAVYARMOR))
			to_chat(user, span_warning("You lack the training to wear this armor!"))
			return FALSE
		else
			return
	if(armor_class == ARMOR_CLASS_MEDIUM)	//Armor class medium
		if(!HAS_TRAIT(H,TRAIT_HEAVYARMOR))	//First check if heavy armor training; if so, no need to check further. Heavy training = medium training
			if(!HAS_TRAIT(H,TRAIT_MEDIUMARMOR))		//If no heavy training, check medium training
				to_chat(user, span_warning("You lack the training to wear this armor!"))	//boo-womp
				return FALSE
			else
				return
		else
			return
	if(armor_class == ARMOR_CLASS_LIGHT)	//No perk check on this one; doing this to avoid future issues.
		return

/obj/item/clothing/suit/roguetown/armor/chainmail
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "haubergeon"
	desc = "A steel maille shirt."
	body_parts_covered = CHEST|GROIN|ARMS|VITALS
	icon_state = "haubergeon"
	armor = list("blunt" = 60, "slash" = 100, "stab" = 80, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	blocksound = CHAINHIT
	var/do_sound = FALSE
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/chainmail/Initialize()
	. = ..()
	if(do_sound)
		AddComponent(/datum/component/squeak, list('sound/foley/footsteps/armor/chain (1).ogg',\
													'sound/foley/footsteps/armor/chain (2).ogg',\
													'sound/foley/footsteps/armor/chain (3).ogg'), 100)

/obj/item/clothing/suit/roguetown/armor/chainmail/iron
	icon_state = "ichainmail"
	name = "chainmaille"
	desc = "A chain vest made of heavy iron rings."
	body_parts_covered = CHEST|GROIN|VITALS
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/iron
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "hauberk"
	desc = "A longer steel maille that protects the legs."
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "hauberk"
	item_state = "hauberk"
	armor = list("blunt" = 60, "slash" = 100, "stab" = 80, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	do_sound = TRUE
	armor_class = ARMOR_CLASS_MEDIUM
	max_integrity = 300

/obj/item/clothing/suit/roguetown/armor/chainmail/bikini
	name = "chainmail bikini"
	desc = "Not very comfortable against the skin."
	icon_state = "chainkini"
	item_state = "chainkini"
	allowed_sex = list(FEMALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/carapace
	slot_flags = ITEM_SLOT_ARMOR
	name = "carapace armor"
	desc = "Full carapace plate. Leg protecting tassets, groin cup, armored vambraces."
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	icon_state = "carapace"
	item_state = "carapace"
	blocksound = PLATEHIT
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	armor = list("blunt" = 60, "slash" = 100, "stab" = 0, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	max_integrity = 175
	allowed_sex = list(MALE, FEMALE)
	var/do_sound = TRUE
	sewrepair = TRUE
	smeltresult = /obj/item/ash
	equip_delay_self = 60
	nodismemsleeves = TRUE
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/carapace/Initialize()
	. = ..()
	if(do_sound)
		AddComponent(/datum/component/squeak, list('sound/foley/footsteps/armor/chain (1).ogg',\
													'sound/foley/footsteps/armor/chain (2).ogg',\
													'sound/foley/footsteps/armor/chain (3).ogg'), 70)		
									
/obj/item/clothing/suit/roguetown/armor/carapace/cuirass
	name = "carapace cuirass"
	desc = "vest styled watery shell chest armor sown in layers."
	body_parts_covered = CHEST|GROIN|VITALS
	icon_state = "carapacecuirass"
	item_state = "carapacecuirass"
	max_integrity = 150
	equip_delay_self = 30

/obj/item/clothing/suit/roguetown/armor/plate
	slot_flags = ITEM_SLOT_ARMOR
	name = "steel half-plate"
	desc = "\'Adventurer-fit\' plate armor with pauldrons."
	body_parts_covered = CHEST|GROIN|VITALS
	icon_state = "halfplate"
	item_state = "halfplate"
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	nodismemsleeves = TRUE
	max_integrity = 500
	allowed_sex = list(MALE, FEMALE)
	var/do_sound = TRUE
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 40
	armor_class = ARMOR_CLASS_HEAVY

/obj/item/clothing/suit/roguetown/armor/plate/Initialize()
	. = ..()
	if(do_sound)
		AddComponent(/datum/component/squeak, list('sound/foley/footsteps/armor/plate (1).ogg',\
													'sound/foley/footsteps/armor/plate (2).ogg',\
													'sound/foley/footsteps/armor/plate (3).ogg'), 100)

/obj/item/clothing/suit/roguetown/armor/plate/half
	slot_flags = ITEM_SLOT_ARMOR
	name = "steel cuirass"
	desc = "A basic cuirass of steel. Lightweight and durable."
	body_parts_covered = CHEST|VITALS
	icon_state = "cuirass"
	item_state = "cuirass"
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 300
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/graggaritearmorleader
	slot_flags = ITEM_SLOT_ARMOR
	name = "graggarite leader cuirass"
	desc = "Armor worn by leaders of northmen warbands. A status symbol if ever there was one."
	body_parts_covered = CHEST|VITALS
	icon_state = "graggaritechestplateleader"
	item_state = "graggaritechestplateleader"
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 500
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM	

/obj/item/clothing/suit/roguetown/armor/plate/ironarmor
	slot_flags = ITEM_SLOT_ARMOR
	name = "iron chestplate"
	desc = "A basic cuirass of iron. Lightweight and durable."
	body_parts_covered = CHEST|VITALS
	icon_state = "ironarmor"
	item_state = "ironarmor"
	armor = list("blunt" = 80, "slash" = 60, "stab" = 20, "bullet" = 50, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 100
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/iron
	armor_class = ARMOR_CLASS_MEDIUM	

/obj/item/clothing/suit/roguetown/armor/plate/halfplateroyalguard
	slot_flags = ITEM_SLOT_ARMOR
	name = "royal halfplate"
	desc = "A basic cuirass of steel, decorated with gold."
	body_parts_covered = CHEST|VITALS
	icon_state = "royal"
	item_state = "royal"
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 300
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM	

/obj/item/clothing/suit/roguetown/armor/plate/bikini
	name = "plate bikini"
	desc = "Half plate in bikini form, still just as protective somehow."
	icon_state = "halfplatekini"
	item_state = "halfplatekini"
	allowed_sex = list(FEMALE)
	anvilrepair = /datum/skill/craft/armorsmithing
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/full
	name = "plate armor"
	desc = "Full plate. Leg protecting tassets, groin cup, armored vambraces."
	icon_state = "plate"
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	equip_delay_self = 80

/obj/item/clothing/suit/roguetown/armor/plate/full/bikini
	name = "fullplate bikini"
	desc = "Full plate in bikini form, full package and full exposure."
	icon_state = "platekini"
	allowed_sex = list(FEMALE)
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	equip_delay_self = 80

/obj/item/clothing/suit/roguetown/armor/plate/half/iron
	name = "iron breastplate"
	desc = "Solid iron to protect the torso."
	icon_state = "ibreastplate"
	max_integrity = 200
	smeltresult = /obj/item/ingot/iron
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/shortbrigandine
	name = "fancy brigandine"
	desc = "A coat with plates concealed inside an exterior fabric. This one is a bit nicer looking than most others and the fabric on the exterior of the armor better conceals the plate beneath."
	body_parts_covered = CHEST|VITALS
	icon_state = "oa_short"
	item_state = "oa_short"
	boobed = TRUE
	max_integrity = 200
	smeltresult = /obj/item/ingot/iron
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/half/ironharness
	name = "iron harness"
	desc = "A lightweight piece of protection centered around the belly."
	icon_state = "metal_vest"
	item_state = "metal_vest"
	max_integrity = 150
	smeltresult = /obj/item/ingot/iron
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/plate/scale
	slot_flags = ITEM_SLOT_ARMOR
	name = "scalemail"
	desc = "Metal scales interwoven intricately to form flexible protection!"
	body_parts_covered = CHEST|VITALS|GROIN|LEGS
	allowed_sex = list(MALE, FEMALE)
	icon_state = "lamellar"
	max_integrity = 250
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 40
	armor_class = ARMOR_CLASS_MEDIUM			

/obj/item/clothing/suit/roguetown/armor/heartfelt/lord
	slot_flags = ITEM_SLOT_ARMOR
	name = "coat of armor"
	desc = "A lordly coat of armor."
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	icon_state = "heartfelt"
	item_state = "heartfelt"
	armor = list("blunt" = 90, "slash" = 90, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	allowed_sex = list(MALE, FEMALE)
	nodismemsleeves = TRUE
	blocking_behavior = null
	max_integrity = 400
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_HEAVY

/obj/item/clothing/suit/roguetown/armor/heartfelt/hand
	slot_flags = ITEM_SLOT_ARMOR
	name = "coat of armor"
	desc = "A lordly coat of armor."
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	icon_state = "heartfelt_hand"
	item_state = "heartfelt_hand"
	armor = list("blunt" = 90, "slash" = 90, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	allowed_sex = list(MALE, FEMALE)
	nodismemsleeves = TRUE
	blocking_behavior = null
	max_integrity = 400
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_HEAVY

/obj/item/clothing/suit/roguetown/armor/brigandine
	slot_flags = ITEM_SLOT_ARMOR
	name = "brigandine"
	desc = "A coat with plates concealed inside an exterior fabric."
	icon_state = "brigandine"
	blocksound = SOFTHIT
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	armor = list("blunt" = 90, "slash" = 60, "stab" = 70, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	allowed_sex = list(MALE, FEMALE)
	nodismemsleeves = TRUE
	max_integrity = 350
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 40
	armor_class = ARMOR_CLASS_HEAVY

/obj/item/clothing/suit/roguetown/armor/brigandine/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/foley/footsteps/armor/coatplates (1).ogg',\
												'sound/foley/footsteps/armor/coatplates (2).ogg',\
												'sound/foley/footsteps/armor/coatplates (3).ogg'), 100)

/obj/item/clothing/suit/roguetown/armor/brigandine/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/lordcolor(primary,secondary)
	detail_tag = "_det"
	detail_color = primary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	slot_flags = ITEM_SLOT_ARMOR
	name = "coat of plates"
	desc = "A leather coat with plates attached to it to increase protection while retaining mobility"
	icon_state = "coat_of_plates"
	blocksound = PLATEHIT
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	max_integrity = 250
	armor_class = ARMOR_CLASS_HEAVY

/obj/item/clothing/suit/roguetown/armor/armordress
	slot_flags = ITEM_SLOT_ARMOR
	name = "padded dress"
	desc = "This dress has been padded with leather for extra protection."
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|VITALS
	icon_state = "armordress"
	armor = list("blunt" = 60, "slash" = 40, "stab" = 50, "bullet" = 10, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT)
	blocksound = SOFTHIT
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/armordress/alt
	icon_state = "armordressalt"

/obj/item/clothing/suit/roguetown/armor/gambeson
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "gambeson"
	desc = "A large shirt meant to be worn below armor."
	icon_state = "gambeson"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|VITALS
	armor = list("blunt" = 60, "slash" = 40, "stab" = 50, "bullet" = 25, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT,BCLASS_BLUNT)
	blocksound = SOFTUNDERHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/gambeson/councillor
	color = "#646464"

/obj/item/clothing/suit/roguetown/armor/gambeson/lord
	name = "arming jacket"
	desc = "Similar to a gambeson, it is meant to be used under armor."
	icon_state = "dgamb"
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/suit/roguetown/armor/leather
	name = "leather armor"
	desc = "Flexible cowhide armor. Lightweight, better than nothing."
	icon_state = "leather"
//	color = "#514339"
	body_parts_covered = CHEST|GROIN|VITALS
	armor = list("blunt" = 50, "slash" = 25, "stab" = 40, "bullet" = 10, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT,BCLASS_BLUNT)
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	nodismemsleeves = TRUE
	max_integrity = 150
	sellprice = 20
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/leather/hide
	name = "hide armor"
	desc = "A light armor of wildbeast hide. Far more durable than leather."
	icon_state = "hidearmor"
	max_integrity = 230
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/leather/studded
	name = "studded leather armor"
	desc = "Studded leather is the most durable of all hides and leathers and about as light."
	icon_state = "studleather"
	item_state = "studleather"
	blocksound = SOFTHIT
	armor = list("blunt" = 70, "slash" = 50, "stab" = 60, "bullet" = 15, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_CHOP)
	nodismemsleeves = TRUE
	body_parts_covered = CHEST|GROIN|VITALS
	max_integrity = 300
	sellprice = 25
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/leather/bikini
	name = "leather bikini"
	desc = "Flexible cowhide armor. Lightweight, better than nothing. Now in tasteful bikini shape."
	icon_state = "leatherkini"
	item_state = "leatherkini"
	allowed_sex = list(FEMALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini
	name = "studded leather bikini"
	desc = "Studded leather is the most durable of all hides and leathers and about as light. This one is in bikini form."
	icon_state = "studleatherkini"
	item_state = "studleatherkini"
	allowed_sex = list(FEMALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/hide/bikini
	name = "hide bikini"
	desc = "A light armor of wildbeast hide. Far more durable than leather. This will not keep a person warm though..."
	icon_state = "hidearmorkini"
	item_state = "hidearmorkini"
	allowed_sex = list(FEMALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/vest
	name = "leather vest"
	desc = "A leather vest. Not very protective, but fashion."
	icon_state = "vest"
	item_state = "vest"
	color = "#514339"
	armor = list("blunt" = 30, "slash" = 10, "stab" = 20, "bullet" = 5, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT)
	blocksound = SOFTHIT
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = CHEST|VITALS|LEGS
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	sleevetype = null
	sleeved = null
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	name = "sea jacket"
	desc = "A sailor's garb."
	icon_state = "sailorvest"
	color = null
	slot_flags = ITEM_SLOT_ARMOR
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	sleevetype = "shirt"

/obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 2
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 1

/obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

/obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/nightman
	name = "silk jacket"
	desc = "A soft and comfortable jacket."
	icon_state = "nightman"
	sleeved = 'icons/roguetown/clothing/onmob/armor.dmi'
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES


/obj/item/clothing/suit/roguetown/armor/leather/vest/hand
	name = "Hand's vest"
	desc = "A soft vest of finest fabric."
	icon_state = "handcoat"
	color = null
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/vest/black
	color = "#3c3a38"

/obj/item/clothing/suit/roguetown/armor/workervest
	name = "striped tunic"
	desc = "This cheap tunic is often used by sturdy laborous men and women."
	icon_state = "workervest"
	armor = null
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = CHEST|VITALS
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	sleevetype = null
	sleeved = null
	nodismemsleeves = TRUE
	boobed = TRUE

/obj/item/clothing/suit/roguetown/armor/workervest/Initialize()
	color = pick("#94b4b6", "#ba8f9e", "#bd978c", "#92bd8c", "#c7c981")
	..()

/obj/item/clothing/suit/roguetown/armor/silkcoat
	name = "silk coat"
	desc = "A padded dressing made from the finest silks."
	icon_state = "bliaut"
	color = null
	armor = list("blunt" = 70, "slash" = 35, "stab" = 60, "bullet" = 7, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_TWIST)
	blocksound = SOFTHIT
	slot_flags = ITEM_SLOT_ARMOR
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = CHEST|LEGS|VITALS|GROIN
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	sleevetype = "shirt"
	max_integrity = 100
	sellprice = 50
	armor_class = ARMOR_CLASS_LIGHT
	allowed_sex = list(MALE, FEMALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/silkcoat/Initialize()
	. = ..()
	color = pick(CLOTHING_PURPLE, null,CLOTHING_GREEN, CLOTHING_RED)

/obj/item/clothing/suit/roguetown/armor/plate/half/grenzelhoft
	slot_flags = ITEM_SLOT_ARMOR
	name = "Grenzelhoft cuirass"
	desc = "A basic cuirass built from black-steel. It's somewhat more durable than regular steel."
	icon_state = "grenzelcuirass"
	item_state = "grenzelcuirass"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	boobed = TRUE
	max_integrity = 400

/obj/item/clothing/suit/roguetown/armor/plate/half/footmanchestplate
	slot_flags = ITEM_SLOT_ARMOR
	name = "footman cuirass"
	desc = "A basic iron cuirass worn by soldiers in Grenzelhoft."
	icon_state = "footmanchestplate"
	item_state = "footmanchestplate"
	max_integrity = 200
	smeltresult = /obj/item/ingot/iron
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/half/graggaritearmor
	slot_flags = ITEM_SLOT_ARMOR
	name = "graggarite armor"
	desc = "Armor worn by Graggarite fanatics in battle."
	icon_state = "graggaritechestplate"
	item_state = "graggaritechestplate"
	max_integrity = 200
	smeltresult = /obj/item/ingot/iron
	armor_class = ARMOR_CLASS_MEDIUM	

/obj/item/clothing/suit/roguetown/armor/barrelarmor
	slot_flags = ITEM_SLOT_ARMOR
	name = "Barrel Armor"
	desc = "Makeshift armor made using a barrel with two holes made for the hands to fit through."
	icon_state = "barrelarmor"
	item_state = "barrelarmor"
	armor = list("blunt" = 5, "slash" = 1, "stab" = 1, "bullet" = 1, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	blocksound = SOFTHIT
	prevent_crits = list(BCLASS_CUT,BCLASS_TWIST)
	break_sound = 'sound/combat/hits/onwood/woodimpact (1).ogg'
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	sleeved = FALSE
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = CHEST|VITALS|ARMS
	boobed = FALSE
	max_integrity = 300

/obj/item/clothing/suit/roguetown/armor/plate/half/katefractoiichestplate
	slot_flags = ITEM_SLOT_ARMOR
	name = "katefractoii chestplate"
	desc = "Lamellar armor worn by the elite Katefractoii heavy cavalry."
	icon_state = "katefractoiichestplate"
	item_state = "katefractoiichestplate"
	max_integrity = 200
	smeltresult = /obj/item/ingot/iron
	armor_class = ARMOR_CLASS_MEDIUM	

/obj/item/clothing/suit/roguetown/armor/plate/dwarffull
	name = "dwarven fullarmor"
	desc = "An extremely heavy set of armor in the Dwarven style, cumbersome to use but provides some of the best protection in the world."
	icon_state = "dwarvenchestplate"
	item_state = "dwarvenchestplate"
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	equip_delay_self = 80

/obj/item/clothing/suit/roguetown/armor/plate/darkelfchestplate
	slot_flags = ITEM_SLOT_ARMOR
	name = "raider chestplate"
	desc = "Steel chestplate in the Dark Elf style, commmonly worn by surface raiders."
	body_parts_covered = CHEST|VITALS
	icon_state = "darkelfchestplate"
	item_state = "darkelfchestplate"
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 300
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/half/foresterarmor
	slot_flags = ITEM_SLOT_ARMOR
	name = "forester chestplate"
	desc = "Wooden armor worn by those who inhabit the forests."
	icon_state = "foresterchestplate"
	item_state = "foresterchestplate"
	max_integrity = 100
	smeltresult = /obj/item/ash
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/fancycuirass
	slot_flags = ITEM_SLOT_ARMOR
	name = "fancy cuirass"
	desc = "A basic cuirass, padded with leather and decorated with a gold trim."
	body_parts_covered = CHEST|VITALS
	icon_state = "fancy_cuirass"
	item_state = "fancy_cuirass"
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	boobed = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 300
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/noblecuirass
	slot_flags = ITEM_SLOT_ARMOR
	name = "noble cuirass"
	desc = "A decorated cuirass underneath a thin layer of cloth for decoration."
	body_parts_covered = CHEST|VITALS
	icon_state = "oa_fancy_long"
	item_state = "oa_fancy_long"
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	boobed = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 300
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/spellslingerarmor
	slot_flags = ITEM_SLOT_ARMOR
	name = "spellslinger cuirass"
	desc = "Armor of a spellslinger. Studded with a variety of sapphiras and other prized gizaels; this is truly the armor of a magician. Known to cause a heavy toll on the user..."
	body_parts_covered = CHEST|VITALS|GROIN|NECK
	icon_state = "spellslingerarmor"
	item_state = "spellslingerarmor"
	armor = list("blunt" = 30, "slash" = 50, "stab" = 45, "bullet" = 50, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 150 //Studded with gems means 'lots of weak points'.
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_LIGHT //Designed for the infirm.
	var/active_item = FALSE //Prevents issues like dragon ring giving negative str instead

/obj/item/clothing/suit/roguetown/armor/plate/spellslingerarmor/equipped(mob/living/user, slot) //I forgor.
	. = ..()
	if(active_item)
		return
	else
		if(slot != SLOT_ARMOR) //Hopefully stops one part of the bug, but won't fix the other. TODO: Rework equip and de-equip.
			return //No.
		if(user.mind.get_skill_level(/datum/skill/magic/arcane))
			active_item = TRUE
			user.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			to_chat(user, span_notice("Magicks flow throughout your body."))
			user.change_stat("intelligence", 3) //Additional cooldown (scales with int)
			return
		else
			to_chat(user, span_warning("The curiass feels cold and dead."))

/obj/item/clothing/suit/roguetown/armor/plate/spellslingerarmor/dropped(mob/living/user) //Remove some bugfixing stuff in exchange for stricter checks.
	if(active_item)
		if(user.mind.get_skill_level(/datum/skill/magic/arcane))
			var/mob/living/carbon/human/H = user
			if(H.get_item_by_slot(SLOT_ARMOR) == src) //Hopefully fixes this last issue.
				to_chat(H, span_notice("Gone is the arcane magicks enhancing thine abilities..."))
				H.change_stat("intelligence", -3) //Ensure to not give inf intelligence.
				H.mind.adjust_skillrank(/datum/skill/magic/arcane, -1, TRUE)
				active_item = FALSE
				return
		else
			to_chat(user, span_warning("The feeling of death and decay departs the moment you leave the curiass be."))


/obj/item/clothing/suit/roguetown/armor/plate/psydonianknightarmor
	slot_flags = ITEM_SLOT_ARMOR
	name = "psydonian knight cuirass"
	desc = "PSYDON's heart still beats."
	body_parts_covered = CHEST|VITALS
	icon_state = "psydonianknightarmor"
	item_state = "psydonianknightarmor"
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 300
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/zybantinearmor
	slot_flags = ITEM_SLOT_ARMOR
	name = "zybantinearmor"
	desc = "Medium armor worn by Zybantine soldiers."
	body_parts_covered = CHEST|VITALS
	icon_state = "zybantinearmor"
	item_state = "zybantinearmor"
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 300
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/rustedarmor
	slot_flags = ITEM_SLOT_ARMOR
	name = "rusted cuirass"
	desc = "A rusted, battered chestplate from a bygone era. Are you sure you want to wear this?"
	body_parts_covered = CHEST|VITALS
	icon_state = "rustplate"
	item_state = "rustplate"
	armor = list("blunt" = 100, "slash" = 55, "stab" = 15, "bullet" = 30, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	do_sound = FALSE
	blocking_behavior = null
	smeltresult = /obj/item/ash
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/nephilimchest
	slot_flags = ITEM_SLOT_ARMOR
	name = "nephilim armor"
	desc = "Armor once worn by the descendents of giants."
	body_parts_covered = CHEST|VITALS
	icon_state = "nephilimplate"
	item_state = "nephilimplate"
	armor = list("blunt" = 90, "slash" = 100, "stab" = 85, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 350
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/heavyplateroyalguard
	slot_flags = ITEM_SLOT_ARMOR
	name = "royal heavyplate"
	desc = "An extremely heavy piece of armor made of steel and decorated with golden pauldrons."
	body_parts_covered = CHEST|VITALS
	icon_state = "heavyroyalplate"
	item_state = "heavyroyalplate"
	armor = list("blunt" = 100, "slash" = 100, "stab" = 100, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 350
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_HEAVY

/obj/item/clothing/suit/roguetown/armor/leathervest
	name = "leather vest"
	desc = "A simple vest made of leather, provides poor protection."
	icon_state = "leathervest"
	item_state = "leathervest"
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/valorianarmor
	name = "valorian armor"
	desc = "Valorian armor made using heavy cloth."
	icon_state = "valorian_armor"
	item_state = "valorian_armor"
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/plate/scaled
	slot_flags = ITEM_SLOT_ARMOR
	name = "scaled armor"
	desc = "Thin metal plates layered over one another to provide protection."
	body_parts_covered = CHEST|VITALS
	allowed_sex = list(MALE, FEMALE)
	icon_state = "scale_armor"
	max_integrity = 250
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/iron
	equip_delay_self = 20
	armor_class = ARMOR_CLASS_LIGHT	

/obj/item/clothing/suit/roguetown/armor/plate/vikingbodyguardchestplate
	slot_flags = ITEM_SLOT_ARMOR
	name = "bodyguard armor"
	desc = "Lamellar armor worn by Viking bodyguards."
	body_parts_covered = CHEST|VITALS|GROIN|LEGS
	allowed_sex = list(MALE, FEMALE)
	icon_state = "vikingbodyguardc"
	max_integrity = 250
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 40
	armor_class = ARMOR_CLASS_MEDIUM		

/obj/item/clothing/suit/roguetown/armor/goldchestplate
	slot_flags = ITEM_SLOT_ARMOR
	name = "golden chestplate"
	desc = "A cuirass made of pure gold."
	body_parts_covered = CHEST|VITALS
	icon_state = "gold_chestplate"
	item_state = "gold_chestplate"
	armor = list("blunt" = 80, "slash" = 60, "stab" = 20, "bullet" = 50, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	blocking_behavior = null
	max_integrity = 450
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/gold
	armor_class = ARMOR_CLASS_MEDIUM	

/obj/item/clothing/suit/roguetown/armor/bone/chestplate
	name = "bone chestplate"
	desc = "A chestplate made using bone."
	body_parts_covered = CHEST
	icon_state = "bonearmor"
	item_state = "bonrearmor"
	smeltresult = /obj/item/ash
	equip_delay_self = 15

/obj/item/clothing/suit/roguetown/armor/hide/bearfur
	name = "bear fur"
	desc = "Thick and warm."
	body_parts_covered = CHEST|VITALS
	icon_state = "bearfur"
	item_state = "bearfur"
	smeltresult = /obj/item/ash
