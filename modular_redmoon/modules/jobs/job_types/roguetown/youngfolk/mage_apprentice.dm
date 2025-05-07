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
	backpack_contents = list(/obj/item/chalk = 1, /obj/item/book/granter/spellbook/adept = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)