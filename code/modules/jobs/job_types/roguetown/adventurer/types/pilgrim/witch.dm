/datum/advclass/witch
	name = "Witch"
	tutorial = "tba"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/witch
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	traits_applied = list(TRAIT_RITUALIST, TRAIT_DEATHSIGHT)
	cmode_music = 'sound/music/combat_cult.ogg'

/datum/outfit/job/roguetown/adventurer/witch/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/witchhat
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/phys
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/rogueweapon/huntingknife
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
						/obj/item/ritechalk = 1,
						)
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/armor/corset
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
		pants = /obj/item/clothing/under/roguetown/skirt/red
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("fortune", 1)
		GLOB.excommunicated_players += H.real_name
		if(H.age == AGE_OLD)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
		
	switch(H.patron?.type)
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/combat_cult.ogg'
			neck = /obj/item/roguekey/inhumen
