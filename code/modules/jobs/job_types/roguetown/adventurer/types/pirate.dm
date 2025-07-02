/datum/subclass/pirate
	name = "Pirate"
	tutorial = "You answered your patron's call when you were young, though in troublesome ways, \
	pilaging for treasury from anyone who'd cross your path, \
	The ocean was your home, and adventure was your constant companion. But now, the tides have turned, \
	As you find yourself on dry land, far from the sea."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	outfit = /datum/outfit/job/roguetown/adventurer/pirate
	category_tags = list(CTAG_ADVENTURER)
	pickprob = 75
	maximum_possible_slots = 5
	cmode_music = 'sound/music/combat_pirate.ogg'

/datum/outfit/job/roguetown/adventurer/pirate
	allowed_patrons =  list(/datum/patron/divine/abyssor, /datum/patron/inhumen/matthios)

/datum/outfit/job/roguetown/adventurer/pirate/pre_equip(mob/living/carbon/human/H)
	..()
	switch(rand(1,3))
		if(1)
			head = /obj/item/clothing/head/roguetown/helmet/tricorn/skull
		if(2)
			head = /obj/item/clothing/head/roguetown/helmet/tricorn
		if(3)
			head = /obj/item/clothing/head/roguetown/helmet/bandana
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/sword/cutlass
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel

	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("constitution", -1)
	H.change_stat("endurance", 1)
	H.change_stat("speed", 2)
	H.change_stat("fortune", 1)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
