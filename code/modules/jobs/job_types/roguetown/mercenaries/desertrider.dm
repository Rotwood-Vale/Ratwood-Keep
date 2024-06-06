/datum/job/roguetown/mercenary/desert_rider
	title = "Desert Rider Mercenary"
	flag = DESERT_RIDER
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = CLOTHED_RACES_TYPES
	department_flag = MERCENARIES
	tutorial = "Blood, like the desert sand, stains your hands, a crimson testament to the gold you covet. A desert rider, renowned mercenary of the far east, your scimitar whispers tales of centuries-old tradition. Your loyalty, a fleeting mirage in the shifting sands, will yield to the allure of fortune."
	outfit = /datum/outfit/job/roguetown/mercenary/desert_rider
	display_order = JDO_DESERT_RIDER
	selection_color = JCOLOR_MERCENARY
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	give_bank_account = 3
	min_pq = 2 //good fragger role
	max_pq = null
	cmode_music = 'sound/music/combat_desertrider.ogg' //GREATEST COMBAT TRACK IN THE GAME SO FAR BESIDES MAYBE MANIAC2.OGG

/datum/outfit/job/roguetown/mercenary/desert_rider/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	head = /obj/item/clothing/head/roguetown/roguehood/shalal
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather/shalal
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/sword/long/rider
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	neck = /obj/item/clothing/neck/roguetown/shalal

	var/obj/item/flashlight/flare/torch/T = new()
	T.spark_act()
	H.put_in_hands(T,forced=TRUE)

	// A quick check to make sure the desert rider is canonical
	var/static/list/canonical_heritage_check_list = list(
	SKIN_COLOR_GIZA,
	SKIN_COLOR_LALVESTINE,
	SKIN_COLOR_SHALVISTINE,
	SKIN_COLOR_EBON
	)
	if(ishumannorthern(H) && !(H.skin_tone in canonical_heritage_check_list))
		H.skin_tone = pick(canonical_heritage_check_list)
		H.update_body()

	if(H.gender == FEMALE)
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()
	backpack_contents = list(/obj/item/roguekey/mercenary)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 3)
		H.change_stat("constitution", 2)
		H.change_stat("perception", 2)
		H.change_stat("speed", 3)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
