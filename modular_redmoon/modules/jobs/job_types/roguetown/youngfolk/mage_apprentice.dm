/datum/job/roguetown/wapprentice
	ru_title = "Гильдейский маг"
	ru_f_title = "Гильдейский маг"
	ru_tutorial = "Вы гильдейский маг. Ваша гильдия магов молода. Корона арендовала вам ветхое здание в порту, чтобы вы делом доказали свою пользу городу и право в нём находиться."
	title = "Guild mage"
	department_flag = YEOMEN
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "You are a guild mage. Your guild of mages is young. The crown rented you a dilapidated building in the port so that you could prove your usefulness to the city and your right to be there."
/datum/outfit/job/roguetown/wapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/magebag/apprentice
	beltl = /obj/item/key/mage_guild
	r_hand = /obj/item/rogueweapon/woodstaff
	backpack_contents = list(/obj/item/chalk = 1, /obj/item/book/granter/spellbook/apprentice = 1)
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/newmage/adept
		backr = /obj/item/storage/backpack/rogue/satchel
	else
		shoes = /obj/item/clothing/shoes/roguetown/sandals
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/newmage/adept
		backr = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)	//they get potion crafting round start now.
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_spellpoints(3)
		H.change_stat("intelligence", 3)
		H.change_stat("strength", -1)
	if(istype(H.dna.species, /datum/species/dwarf) || istype(H.dna.species,/datum/species/anthromorphsmall)|| istype(H.dna.species, /datum/species/kobold))
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
