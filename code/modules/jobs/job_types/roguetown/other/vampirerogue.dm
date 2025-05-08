/datum/subclass/vampirerogue
	name = "Rogue"
	tutorial = "A life of crime has led you to wander from city to city, always looking for an opportunity to \
				make a quick buck at someone else's expense. That is, until your master found you. Now you serve the vampire lord whom holds your soul."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_ANTAG)

	cmode_music = 'sound/music/combat_duelist.ogg'

	maximum_possible_slots = 8

	outfit = /datum/outfit/job/roguetown/vampirerogue

/datum/outfit/job/roguetown/vampirerogue
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/vampirerogue/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		shoes = /obj/item/clothing/shoes/roguetown/armor
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		pants = /obj/item/clothing/under/roguetown/trou/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		armor = /obj/item/clothing/suit/roguetown/armor/leather
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
		belt = /obj/item/storage/belt/rogue/leather
		cloak = /obj/item/clothing/cloak/raincloak/mortus
		backl = /obj/item/storage/backpack/rogue/satchel
		beltl = /obj/item/rogueweapon/huntingknife/idagger
		beltr = /obj/item/ammo_holder/bomb/smokebombs
		backpack_contents = list(/obj/item/lockpickring/mundane = 1)
		H.change_stat("strength", -1)
		H.change_stat("perception", 1)
		H.change_stat("speed", 3)
		H.change_stat("intelligence", 1)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)