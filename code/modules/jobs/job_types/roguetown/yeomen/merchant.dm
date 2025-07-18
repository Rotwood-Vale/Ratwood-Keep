/datum/job/roguetown/merchant
	title = "Merchant"
	flag = MERCHANT
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = JCOLOR_YEOMAN
	allowed_races = RACES_SHUNNED_UP
	tutorial = "You were born into wealth, learning from before you could talk about the basics of mathematics. \
	Counting coins is a simple pleasure for any person, but you've made it an artform. \
	These people are addicted to your wares and you are the literal beating heart of this economy along with your business partner, the steward. Command your ship's crew to peddle your wares and protect the thing you hold dearest, your assets."

	display_order = JDO_MERCHANT

	outfit = /datum/outfit/job/roguetown/merchant
	give_bank_account = 22
	min_pq = 1
	max_pq = null
	required = TRUE

	cmode_music = 'sound/music/combat_giza.ogg'

/datum/outfit/job/roguetown/merchant/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 2, TRUE)
	ADD_TRAIT(H, TRAIT_SEEPRICES, type)

	head = /obj/item/clothing/head/roguetown/chaperon
	neck = /obj/item/clothing/neck/roguetown/horus
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	pants = /obj/item/clothing/under/roguetown/tights/sailor
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/gun/ballistic/firearm/arquebus_pistol //merchant usually gets his pistol from the map, but it's currently broken and doesn't appear, and also gets stolen often when latejoining
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backl = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/clothing/ring/gold
	backpack_contents = list(/obj/item/storage/keyring/merchant)
	if(isdarkelf(H))
		backpack_contents.Add(/obj/item/clothing/mask/rogue/spectacles/delf)
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
	else
		shoes = /obj/item/clothing/shoes/roguetown/gladiator
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 3)
	H.change_stat("strength", -1)

