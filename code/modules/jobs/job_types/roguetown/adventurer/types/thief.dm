/datum/subclass/Theif
	name = "Theif"
	tutorial = "Rogues are men of shadows, and commonly associated with banditry. Most are usually akin to criminals, \
	and those who aren't are usually treated as such anyway, \
	they are most commonly associated with the god Xylix due to their skills in thievery."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	outfit = /datum/outfit/job/roguetown/adventurer/rogue
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/rogue

/datum/outfit/job/roguetown/adventurer/rogue/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Thief","Swashbuckler",)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Thief")
			H.set_blindness(0)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/armor
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			gloves = /obj/item/clothing/gloves/roguetown/leather
			if(prob(30))
				gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			beltl = /obj/item/rogueweapon/huntingknife/idagger
			backpack_contents = list(/obj/item/lockpickring/mundane = 1)
			H.change_stat("strength", -1)
			H.change_stat("perception", 1)
			H.change_stat("speed", 3)
			H.change_stat("intelligence", 1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		if("Swashbuckler") //A swashbuckler is a heroic protagonist stock character who is skilled in swordsmanship, acrobatics, and guile. A little less sneaky, a little more en garde-y
			H.set_blindness(0)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/helmet/tricorn
			shoes = /obj/item/clothing/shoes/roguetown/armor
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			gloves = /obj/item/clothing/gloves/roguetown/leather/black
			if(prob(15))
				gloves = /obj/item/clothing/gloves/roguetown/leather/angle
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			cloak = /obj/item/clothing/cloak/cape/black
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/rogueweapon/sword/rapier
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			H.change_stat("intelligence", 1)
			H.change_stat("speed", 3)
			H.change_stat("endurance", 1)
			H.cmode_music = 'sound/music/combat_duelist.ogg'
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
