/datum/migrant_role/warden/warden_overlord
	name = "Warden of the North"
	greet_text = "You are the champion of the woods who swore to protect the forest and guide the pack. \
	Your authority is based on your strength, anyone who dares to challenge you must be shown their place. \
	You must make sure the pack doesnt do anything stupid, as much as you loathe Rockhill, you still better keep somewhat warm relations with them."
	outfit = /datum/outfit/job/roguetown/warden/warden_overlord
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE
	cmode_music = 'sound/music/combat_warden.ogg'

/datum/outfit/job/roguetown/warden/warden_overlord/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/volfplate
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	cloak = /obj/item/clothing/cloak/warden
	shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/neck/roguetown/psicross/wood
	neck = /obj/item/clothing/neck/roguetown/gorget/steel
	belt = /obj/item/storage/belt/rogue/leather/steel
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/rogueweapon/shield/tower/metal
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/mid = 1, /obj/item/flint = 1)

var/weapons = list("battle axe", "bastard sword", "warhammer")
	var/weaponschoice = input("Choose your weapon", "Available weapons") as anything in weapons

	switch(weaponschoice)

		if("battle axe")
			beltr = /obj/item/rogueweapon/stoneaxe/battle
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
		if("bastard sword")
			beltr = /obj/item/rogueweapon/sword/long
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("warhammer")
			beltr = /obj/item/rogueweapon/mace/warhammer/steel
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		else
			beltr = /obj/item/rogueweapon/stoneaxe/battle
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.change_stat("strength", 4)
		H.change_stat("endurance", 3)
		H.change_stat("constitution", 3)
		H.change_stat("intelligence", -1)
		H.change_stat("speed", -2)
		if(H.race in list(/datum/species/lupian, /datum/species/halforc, /datum/species/lizardfolk, /datum/species/dwarf/mountain))
			H.change_stat("strength", -1)
			H.change_stat("speed", 1)
		if(H.race in list(/datum/species/anthromorphsmall, /datum/species/kobold, /datum/species/moth, /datum/species/elf/wood))
			H.change_stat("strength", 1)
			H.change_stat("speed", -1)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NORTHERNWARDEN, TRAIT_GENERIC)

/datum/migrant_role/warden/wraith
	name = "Wraith of the North"
	greet_text = "You are one of the best fighters in all of the north, trained to take down anyone who threatens the woods. \
	Some people treat you as dangerous heretics, while others believe you are just a confused dendorite. \
	A true volf is a cautious hunter, not a reckless fool. Those towners may be of good use for the pack; they will respect your way of life as long as you dont slay them."
	outfit = /datum/outfit/job/roguetown/warden/wraith
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE
	cmode_music = 'sound/music/combat_warden.ogg'

/datum/outfit/job/roguetown/warden/wraith/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/volfplate
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	cloak = /obj/item/clothing/cloak/warden
	shoes = /obj/item/clothing/shoes/roguetown/armor
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/neck/roguetown/psicross/wood
	neck = /obj/item/clothing/neck/roguetown/gorget
	belt = /obj/item/storage/belt/rogue/leather/steel
	beltl = obj/item/storage/belt/rogue/pouch/coins/poor
	backr = /obj/item/rogueweapon/shield/wood
	backl = /obj/item/storage/backpack/rogue/satchel

var/weapons = list("battle axe", "bastard sword", "warhammer")
	var/weaponschoice = input("Choose your weapon", "Available weapons") as anything in weapons

	switch(weaponschoice)

		if("battle axe")
			beltr = /obj/item/rogueweapon/stoneaxe/battle
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
		if("bastard sword")
			beltr = /obj/item/rogueweapon/sword/long
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("warhammer")
			beltr = /obj/item/rogueweapon/mace/warhammer/steel
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		else
			beltr = /obj/item/rogueweapon/stoneaxe/battle
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("intelligence", -1)
		H.change_stat("speed", -2)
		if(H.race in list(/datum/species/lupian, /datum/species/halforc, /datum/species/lizardfolk, /datum/species/dwarf/mountain))
			H.change_stat("strength", -1)
			H.change_stat("speed", 1)
		if(H.race in list(/datum/species/anthromorphsmall, /datum/species/kobold, /datum/species/moth, /datum/species/elf/wood))
			H.change_stat("strength", 1)
			H.change_stat("speed", -1)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NORTHERNWARDEN, TRAIT_GENERIC)

/datum/migrant_role/warden/warden_shaman
	name = "Shaman of the North"
	greet_text = "You are the wisest volf in the pack, who's duty is to look after the others and perform rituals in the name of the woods. \
	You must not let your pack go astray, they all are dependant on your teachings. The Warden is strong, but is still in need of your teachings."
	outfit = /datum/outfit/job/roguetown/warden/warden_shaman
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE
	cmode_music = 'sound/music/combat_warden.ogg'

/datum/outfit/job/roguetown/warden/warden_shaman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/volfplate
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/newmage/sorcerer
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	cloak = /obj/item/clothing/cloak/warden
	shoes = /obj/item/clothing/shoes/roguetown/armor
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/leather/advanced
	neck = /obj/item/clothing/neck/roguetown/psicross/wood
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/huntingknife
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/rogueweapon/woodstaff
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/mid = 1, /obj/item/flint = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("endurance", 1)
		H.change_stat("speed", -1)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NORTHERNWARDEN, TRAIT_GENERIC)

/datum/migrant_role/warden/forager
	name = "Forager of the North"
	greet_text = "Being the most agile member of the pack, you are responsible for the scout duty, hunting and stealthy operations. \
	The pack relies on your information as well as they await you every night, expecting some fresh meat of your preys."
	outfit = /datum/outfit/job/roguetown/warden/forager
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE
	cmode_music = 'sound/music/combat_warden.ogg'

/datum/outfit/job/roguetown/warden/warden_shaman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/volfplate
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	cloak = /obj/item/clothing/cloak/warden
	shoes = /obj/item/clothing/shoes/roguetown/armor
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/leather/advanced
	wrists = /obj/item/clothing/neck/roguetown/psicross/wood
	neck = /obj/item/clothing/neck/roguetown/gorget
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/ammo_holder/quiver/bolts
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/flint = 1, /obj/item/rogueweapon/huntingknife)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NORTHERNWARDEN, TRAIT_GENERIC)

/datum/migrant_role/warden/sheep
	name = "Captive"
	greet_text = "You've continiously refused to be a volf; on the contrary, you embraced your lyfe as a sheep. \
	 You were either enslaved by the pack during yet another raid or came willingly, now you live to please your new masters."
	outfit = /datum/outfit/job/roguetown/warden/sheep
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE
	cmode_music = 'sound/music/combat_warden.ogg'

/datum/outfit/job/roguetown/gronn/slave/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/collar/leather/cursed
	armor = /obj/item/clothing/suit/roguetown/shirt/tunic/random
	pants = /obj/item/clothing/under/roguetown/tights/random
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/storage/belt/rogue/pouch
	beltr = /obj/item/flint
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("speed", 1)
		H.change_stat("strength", -2)
		H.change_stat("constitution", -2)

	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)