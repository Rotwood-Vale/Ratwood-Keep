/datum/advclass/minstrel
	name = "Rapscallion"
	tutorial = "You are a merryman at heart, and find yourself superior to those so-called bards who traipse around in fancy cloth and swordfight in the woods. You know your way around the hearts and minds of people, and use it to get what you want, whether it's mammon, lust, or adoration."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	outfit = /datum/outfit/job/roguetown/adventurer/minstrel
	category_tags = list(CTAG_TOWNER, CTAG_PILGRIM)

/datum/outfit/job/roguetown/adventurer/minstrel
	allowed_patrons = list(/datum/patron/inhumen/baotha, /datum/patron/divine/xylix)

/datum/outfit/job/roguetown/adventurer/minstrel/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE) // Bar fights.
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	head = /obj/item/clothing/head/roguetown/bardhat //with this hat, they will get all the pussy(or dick depending on preference(or both ig))
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	cloak = /obj/item/clothing/cloak/half
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/white
	r_hand = /obj/item/rogue/instrument/accord
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/cloth
	beltr = /obj/item/rogueweapon/huntingknife/idagger
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/rogue/instrument/lute = 1, /obj/item/rogue/instrument/flute = 1, /obj/item/rogue/instrument/drum = 1,/obj/item/reagent_containers/powder/spice = 3, /obj/item/reagent_containers/glass/bottle/rogue/poison = 1,/obj/item/storage/pill_bottle/dice = 1, /obj/item/toy/cards/deck = 1, /obj/item/reagent_containers/glass/bottle/rogue/wine = 1)
	switch(H.patron?.type)
		if(/datum/patron/divine/xylix) // Trickster.
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.change_stat("perception", 1)
			H.change_stat("intelligence", 2)
			H.change_stat("speed", 3)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		if(/datum/patron/inhumen/baotha) // Drunkard.
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.change_stat("strength", 1)
			H.change_stat("intelligence", -1)
			H.change_stat("speed", 2)
			ADD_TRAIT(H, TRAIT_GOODRUNNER, TRAIT_GENERIC)	
	H.change_stat("fortune", 2)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRACKHEAD, TRAIT_GENERIC)
