/obj/item/clothing/neck/roguetown
	name = "necklace"
	desc = ""
	icon = 'icons/roguetown/clothing/neck.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/neck.dmi'
	bloody_icon_state = "bodyblood"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/neck/roguetown/coif
	name = "coif"
	icon_state = "coif"
	item_state = "coif"
	desc = "A coif made either of leather or cloth that is comfortable enough to sleep in that protects the head, ears and neck, while providing no protection from arrows and bolts and sadly enough, too soft to prevent chops from decapitating."
	flags_inv = HIDEHAIR
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	blocksound = SOFTHIT
	body_parts_covered = NECK|HAIR|EARS|HEAD
	armor = list("blunt" = 33, "slash" = 12, "stab" = 22, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	max_integrity = 125
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT)
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	sewrepair = TRUE

/obj/item/clothing/neck/roguetown/coif/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = null
			body_parts_covered = NECK
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_neck()
				H.update_inv_head()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEHAIR
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_neck()
					H.update_inv_head()



/obj/item/clothing/neck/roguetown/chaincoif
	name = "chain coif"
	icon_state = "chaincoif"
	item_state = "chaincoif"
	desc = "A steel chain coif, composed of interlinked metal rings that barely absorb impacts from arrows and bolts that protects the head, ears and neck, and is sadly too uncomfortable to sleep in."
	flags_inv = HIDEHAIR
	resistance_flags = FIRE_PROOF
	armor = list("blunt" = 30, "slash" = 60, "stab" = 45, "bullet" = 10, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	max_integrity = 200
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	body_parts_covered = NECK|HAIR|EARS|HEAD
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_ASSASSIN)
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	blocksound = CHAINHIT
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/neck/roguetown/chaincoif/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = null
			body_parts_covered = NECK
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_neck()
				H.update_inv_head()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEHAIR
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_neck()
					H.update_inv_head()


/obj/item/clothing/neck/roguetown/chaincoif/iron
	icon_state = "ichaincoif"
	anvilrepair = /datum/skill/craft/blacksmithing
	desc = "An iron chain coif, composed of interlinked metal rings, that barely absorb impacts from arrows that protects the head, ears and neck, and is sadly too uncomfortable to sleep in."
	smeltresult = /obj/item/ingot/iron
	max_integrity = 150

/obj/item/clothing/neck/roguetown/chaincoif/ironb
	icon_state = "ichaincoif"
	anvilrepair = /datum/skill/craft/blacksmithing
	desc = "An iron chain coif, composed of interlinked metal rings, that barely absorb impacts from arrows that protects the head, ears and neck, and is sadly too uncomfortable to sleep in. blackened iron."
	smeltresult = /obj/item/ingot/iron
	color = "#151615"
	max_integrity = 150

/obj/item/clothing/neck/roguetown/bervor
	name = "bevor"
	desc = "A steel bevor that protects the lower part of the head, that being the neck, mouth and nose."
	icon_state = "bervor"
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	max_integrity = 300
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK|MOUTH|NOSE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT

/obj/item/clothing/neck/roguetown/gorget
	name = "gorget"
	desc = "An iron gorget to protect the neck."
	icon_state = "gorget"
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	smeltresult = /obj/item/ingot/iron
	anvilrepair = /datum/skill/craft/blacksmithing
	max_integrity = 150
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT


/obj/item/clothing/neck/roguetown/gorget/oring
	name = "ringed gorget"
	desc = "An iron gorget to protect the neck, this one has an odd ring mounted on the front."
	leashable = TRUE
	icon_state = "ironcollargorget"

/obj/item/clothing/neck/roguetown/gorget/steel
	name ="steel gorget"
	desc = "A steel gorget to protect the neck."
	smeltresult = /obj/item/ingot/steel
	max_integrity = 300
	icon_state = "sgorget"

/obj/item/clothing/neck/roguetown/gorget/steel/oring
	desc = "A steel gorget to protect the neck, this one has an odd ring mounted on the front."
	name ="ringed steel gorget"
	leashable = TRUE
	icon_state = "steelcollargorget"

/obj/item/clothing/neck/roguetown/leather
	name = "hardened leather gorget"
	desc = "Sturdy, durable, flexible. Will protect your neck from some good lumbering."
	icon_state = "lgorget"
	armor = list("blunt" = 70, "slash" = 60, "stab" = 30, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	max_integrity = 150
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST) //This one will help against chopping
	blocksound = SOFTHIT
	sewrepair = TRUE
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/neck/roguetown/gorget/alt
	name = "vreccale"
	desc = "Nature knows not of mercy."
	icon_state = "iwolfcollar"
	leashable = TRUE

/obj/item/clothing/neck/roguetown/psicross
	name = "psycross"
	desc = "An iron cross of PSYDON, whose will is like tempered metal and lives on in the eternal war of his Inquisition. In His final moments, He struck a bargain with mankind: never allow His name to fade from the earth, and He will one day return."
	icon_state = "psicross"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/neck.dmi'
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	sellprice = 10
	experimental_onhip = TRUE
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/clothing/neck/roguetown/psicross/astrata
	name = "amulet of Astrata"
	desc = "A golden medallion, warm to the touch even in the dead of night. The sigil of the Queen of the Gods resembles the Psycross of her Father, and symbolizes her inheritance of His will. Blessed be Astrata, whose light banishes shadow and whose law shapes the world."
	icon_state = "astrata"

/obj/item/clothing/neck/roguetown/psicross/silver/astrata
	name = "imbued amulet of Astrata"
	desc = "Similar to a normal amulet of Astrata. This one is blessed and made of silver. A queen does not bargain; she does not relent. Neither shall her followers - least of all the members of her clergy - for with PSYDON gone, Astrata bears the burden of His lineage. All of creation is within her scope, and so too is all of Rockhill within yours. Stay the course, lest she turn her gaze and everything falls to the scourge of heresy."
	icon_state = "astrata"

/obj/item/clothing/neck/roguetown/psicross/noc
	name = "amulet of Noc"
	desc = "A pale silver moon, shimmering like starlight. To walk the Mentor's path is to open oneself to the mysteries of the cosmos, and seek the truth without hesitation. This amulet stares back at you, as if awaiting a question yet unasked."
	icon_state = "noc"

/obj/item/clothing/neck/roguetown/psicross/dendor
	name = "amulet of Dendor"
	desc = "A crude, twisted effigy of bone, root, and sinew. A reminder that these cobbled streets you walk are not truly of Dendor, lest you forget. Your heart longs for the shaded canopies of his domain, and to shed the pretenses of this grave mistake: civilization."
	icon_state = "dendor"

/obj/item/clothing/neck/roguetown/psicross/necra
	name = "amulet of Necra"
	desc = "The mark of Necra, the Undermaiden, who carries souls to their final rest. To wear it is to walk beside the shroud between life and death, and to ease the passage of the dying. What comes next is unknown - even to you - though you are certain Necra will judge them unerringly."
	icon_state = "necra"

/obj/item/clothing/neck/roguetown/psicross/pestra
	name = "amulet of Pestra"
	desc = "A symbol of mercy and selflessness, of Pestra, Our Lady in Agony. In wearing it, you vow to emulate her self-sacrifice: for as she saved Astrata, so too must you save Astrata's people. For without your wisdom - and her guidance - this world will end."
	icon_state = "pestra"

/obj/item/clothing/neck/roguetown/psicross/ravox
	name = "amulet of Ravox"
	desc = "A steel pendant - weathered by age - for the god of war and justice bears no gilded ornaments, only the steel and sweat of battle. Ravox's disciples forge these amulets from the blades of heroes slain in combat; you can feel the weight of their expectations hanging around your neck."
	icon_state = "ravox"

/obj/item/clothing/neck/roguetown/psicross/malum
	name = "amulet of Malum"
	icon_state = "malum"
	desc = "An anvil inlaid with gold, each mark of Malum is a masterwork in earnest. He crafts wonders for gods and men alike, yet seeks neither praise nor devotion - only the perfection of his art. There is virtue in dedication, labor, and toil, for they are the fires that spur the forge of Astrata's civilization."

/obj/item/clothing/neck/roguetown/psicross/pearl //put it as a psycross so it can be used for miracles
	name = "pearl amulet"
	icon_state = "pearlcross"
	desc = "An amulet made of white pearls, usually worn by fishers or sailors."
	sellprice = 80

/obj/item/clothing/neck/roguetown/psicross/bpearl
	name = "blue pearl amulet"
	icon_state = "bpearlcross"
	desc = "An amulet made of rare blue pearls, usually worn by priests and worshippers of Abyssor, or as lucky charms for captains of ships."
	sellprice = 220
	
/obj/item/clothing/neck/roguetown/psicross/shell
	name = "oyster shell necklace"
	icon_state = "oyster_necklace"
	desc = "A necklace of strung-up sea shells, the calming noise they make when they clack together is reminiscent of a shellfish's claws. They remind you that while men no longer live in water, Abyssor will always remember our origins."
	sellprice = 25

/obj/item/clothing/neck/roguetown/psicross/shell/bracelet
	name = "shell bracelet"
	icon_state = "oyster_bracelet"
	desc = "A beaded bracelet made from sea shells, their rough exterior and glossy interior reminding you that Abyssor's children hide the best gifts at the deepest spots beneath the waves."
	sellprice = 15
	slot_flags = ITEM_SLOT_WRISTS

/obj/item/clothing/neck/roguetown/psicross/eora
	name = "amulet of Eora"
	desc = "A heart, for Eora so loved the world she taught us to love ourselves. Wearing it is to feel the warmth of a lover's embrace, and to carry the weight of a bond that even death cannot sever. In showing kindness, one creates a world - scoured as it is with evil and rot - worth saving."
	icon_state = "eora"

/obj/item/clothing/neck/roguetown/psicross/wood
	name = "wooden psycross"
	desc = "So zealous are PSYDON's followers that they will carve his symbol into everything they can reach, even wood, lest their descendants forget their covenant: to make war eternal against the Archenemy, Zizo."
	icon_state = "psicrossw"
	sellprice = 0

/obj/item/clothing/neck/roguetown/psicross/silver
	name = "silver psycross"
	desc = "Make no mistake, son of PSYDON, this amulet is as valuable as any blade in your crusade. Inhumen monsters and cultists shrink at the sight of silver, for it is the All-Father's blood made manifest. So hoist it high, scream his name, and bathe this world in blood so that it might be redeemed."
	icon_state = "psicrossiron"
	sellprice = 50

/obj/item/clothing/neck/roguetown/psicross/silver/pickup(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(!H.mind)
		return
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	if(ishuman(H))
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(20)
			H.adjustFireLoss(60)
			H.Paralyze(20)
			H.fire_act(1,5)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
				H.Knockdown(10)
				H.Paralyze(10)
		if(W && W.transformed == TRUE)
			to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
			H.Knockdown(20)
			H.Paralyze(20)

/obj/item/clothing/neck/roguetown/psicross/silver/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.mind)
			return TRUE
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
			H.Knockdown(20)
			H.adjustFireLoss(60)
			H.Paralyze(20)
			H.fire_act(1,5)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
				H.Knockdown(10)
				H.Paralyze(10)
		if(W && W.transformed == TRUE)
			to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
			H.Knockdown(20)
			H.Paralyze(20)

/obj/item/clothing/neck/roguetown/psicross/g
	name = "golden psycross"
	desc = "A golden cross of PSYDON, the antithesis to heresy and patron of mankind. The Ten carry His will, yet His followers understand that their virtues stem from one single source, and that they must prepare the world for His inevitable return."
	icon_state = "psicrossg"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 100

/obj/item/clothing/neck/roguetown/talkstone
	name = "talkstone"
	desc = ""
	icon_state = "talkstone"
	item_state = "talkstone"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	leashable = TRUE
	allowed_race = CLOTHED_RACES_TYPES
	sellprice = 98
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/clothing/neck/roguetown/horus
	name = "eye of horuz"
	desc = ""
	icon_state = "horus"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 30
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/clothing/neck/roguetown/shalal
	name = "desert rider medal"
	desc = ""
	icon_state = "shalal"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 15
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/clothing/neck/roguetown/collar
	name = "rope collar"
	desc = "This is for debug and item inheritance. If you are seeing this, bug a coder!"
	icon = 'modular/icons/obj/items/leashes_collars.dmi'
	mob_overlay_icon = 'modular/icons/mob/collars_leashes.dmi'
	icon_state = "collar_rope"
	color = "#d7bb9f"
	allowed_race = CLOTHED_RACES_TYPES
	allowed_sex = list(MALE,FEMALE)
	leashable = TRUE
	do_sound_bell = FALSE
	slot_flags = ITEM_SLOT_NECK
	salvage_amount = 1
	salvage_result = /obj/item/rope

/obj/item/clothing/neck/roguetown/collar/leather
	name = "leather collar"
	desc = "A comfortable collar made of leather."
	icon_state = "leathercollar"
	color = null
	slot_flags = ITEM_SLOT_NECK
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/neck/roguetown/collar/leather/cursed/Initialize(mapload)
	. = ..()
	name = "cursed collar"
	resistance_flags = FIRE_PROOF
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)
	clothing_flags = ITEM_SLOT_NECK
	icon = 'modular/icons/obj/items/leashes_collars.dmi'
	mob_overlay_icon = 'modular/icons/mob/collars_leashes.dmi'
	icon_state = "leathercollar"

/obj/item/clothing/neck/roguetown/collar/leather/cursed/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/neck/roguetown/collar/leather/bell
	name = "jingly leather collar"
	desc = "A comfortable collar made of leather, this one has a jingly little catbell!"
	icon_state = "catbellcollar"
	slot_flags = ITEM_SLOT_NECK
	do_sound_bell = TRUE
	bell = TRUE
	salvage_result = list(/obj/item/natural/hide/cured = 1, /obj/item/catbell = 1)

/obj/item/clothing/neck/roguetown/collar/leather/bell/cow
	name = "jingly leather collar"
	desc = "A comfortable collar made of leather, this one has a jingly little cowbell!"
	icon_state = "cowbellcollar"
	slot_flags = ITEM_SLOT_NECK
	salvage_result = list(/obj/item/natural/hide/cured = 1, /obj/item/catbell/cow = 1)

//----------------- MORE AZURE SPRITEWORK ---------------------

/obj/item/clothing/neck/roguetown/ornateamulet
	name = "Ornate Amulet"
	desc = "A beautiful amulet, made of solid gold."
	icon_state = "ornateamulet"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 100
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/clothing/neck/roguetown/skullamulet
	name = "Skull Amulet"
	desc = "Gold shaped into the form of a skull, made into an amulet."
	icon_state = "skullamulet"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 100
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/clothing/neck/roguetown/gorget/forlorncollar
	name = "forlorn collar"
	desc = "A old reminder."
	icon_state = "iwolfcollaralt"

/obj/item/clothing/neck/roguetown/psicross/abyssor
	name = "amulet of Abyssor"
	desc = ""
	icon_state = "abyssor"

/obj/item/clothing/neck/roguetown/fencerguard
	name = "fencer neckguard"
	icon_state = "fencercollar"
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "piercing" = 100, "fire" = 0, "acid" = 0)
	smeltresult = /obj/item/ingot/iron
	anvilrepair = /datum/skill/craft/blacksmithing
	max_integrity = 150
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT
	allowed_race = NON_DWARVEN_RACE_TYPES
