/datum/job/roguetown/mercenary/grenzelhoft
	title = "Grenzelhoft Mercenary"
	flag = GRENZELHOFT
	department_flag = MERCENARIES
	tutorial = "Experts, Professionals, Expensive. Those are the first words that come to mind when the emperiate Grenzelhoft mercenary guild is mentioned. While you may work for coin like any common sellsword, mantaining the prestige of the guild will be of utmost priority."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = CLOTHED_RACES_TYPES
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft
	display_order = JDO_GRENZELHOFT
	selection_color = JCOLOR_MERCENARY
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	min_pq = 2 //good fragger role
	max_pq = null
	cmode_music = 'sound/music/combat_grenzelhoft.ogg'

/datum/outfit/job/roguetown/mercenary/grenzelhoft/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/stabard/grenzelhoft
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/trou/leather
	neck = /obj/item/clothing/neck/roguetown/gorget
	head = /obj/item/clothing/head/roguetown/chaperon

	//quick and gay way to do random loadouts
	var/equipment = rand(1, 2)
	if(equipment == 1)
		r_hand = /obj/item/rogueweapon/spear/billhook
	else if (equipment == 2)
		r_hand = /obj/item/rogueweapon/halberd
	var/obj/item/flashlight/flare/torch/T = new()
	T.spark_act()
	H.put_in_hands(T,forced=TRUE)

	if(H.gender == FEMALE)
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()
	//Humie grenzelhofts are always set to be, well, grenzelhoft
	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 3)
		H.change_stat("perception", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
