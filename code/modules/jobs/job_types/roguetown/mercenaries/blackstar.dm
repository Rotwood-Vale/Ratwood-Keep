/datum/job/roguetown/mercenary/blackstar
	title = "Black Star Mercenary"
	flag = BLACKSTAR
	department_flag = MERCENARIES
	tutorial = ""
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/lupian, /datum/species/vulpkanin, /datum/species/anthromorph)
	outfit = /datum/outfit/job/roguetown/mercenary/blackstar
	display_order = JDO_BLACKSTAR
	selection_color = JCOLOR_MERCENARY
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	min_pq = null
	max_pq = null
	cmode_music = 'sound/music/combat_blackstar.ogg'
	advclass_cat_rolls = list(CTAG_MERCENARY = 20)
	always_show_on_latechoices = TRUE

/datum/outfit/job/roguetown/mercenary/blackstar/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/clothing/neck/roguetown/gorget
	mask = /obj/item/clothing/mask/rogue/facemask/steel/hound
	head = /obj/item/clothing/head/roguetown/helmet/bascinet
	pants = /obj/item/clothing/under/roguetown/tights/black
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("perception", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/job/roguetown/mercenary/blackstar/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/longsword
	name = "Longsword"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/lupian, /datum/species/vulpkanin, /datum/species/anthromorph)
	outfit = /datum/outfit/job/roguetown/mercenary/blackstar/longsword
	tutorial = "You are well versed in the ways of the longsword."
	category_tags = list(CTAG_MERCENARY)

/datum/advclass/sabre
	name = "Cavalry"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/lupian, /datum/species/vulpkanin, /datum/species/anthromorph)
	outfit = /datum/outfit/job/roguetown/mercenary/blackstar/sabre
	tutorial = "You are well versed in the ways of the sabre."
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/blackstar/longsword/pre_equip(mob/living/carbon/human/H)
	..()
	beltr = /obj/item/rogueweapon/sword/long
	backpack_contents = list(/obj/item/rogueweapon/huntingknife)

/datum/outfit/job/roguetown/mercenary/blackstar/sabre/pre_equip(mob/living/carbon/human/H)
	..()
	beltr = /obj/item/rogueweapon/sword/sabre
	l_hand = /obj/item/rogueweapon/shield/buckler
	backpack_contents = list(/obj/item/rogueweapon/huntingknife)
