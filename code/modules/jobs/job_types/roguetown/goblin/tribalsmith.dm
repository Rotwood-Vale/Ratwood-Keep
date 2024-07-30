/datum/job/roguetown/tribalsmith
	title = "Tribal Smith"
	flag = TRIBALSMITH
	department_flag = TRIBAL
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	tutorial = "Tribal smith responsible for forging weapons, armor, and tools for the tribe."
	display_order = JDO_TRIBALSMITH
	outfit = /datum/outfit/job/roguetown/tribalsmith
	min_pq = 0
	max_pq = null
	cmode_music = 'sound/music/combat_tribal.ogg'

/datum/outfit/job/roguetown/tribalsmith/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/goblin
	shirt = /obj/item/clothing/suit/roguetown/shirt/tribalrag
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/apron/blacksmith
	backl = /obj/item/storage/backpack/rogue/satchel
	shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/smelting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", -2)
