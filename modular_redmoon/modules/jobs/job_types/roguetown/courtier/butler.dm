/datum/job/roguetown/butler
	ru_title = "Дворецкий"
	ru_f_title = "Старшая Горничная"
	ru_tutorial = "Служение до смерти - это ваш девиз. \
	Имея многолетний опыт ухода за королевским двором, вы – Дворецкий самого Герцога и никто меньше. \
	Вы командуете всем сервисным персоналом Замка."

/datum/outfit/job/roguetown/butler/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	backpack_contents = list(/obj/item/rogueweapon/whip = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		head = /obj/item/clothing/head/roguetown/fancyhat
	if(H.gender == FEMALE)
		switch(H.patron?.type)
			if(/datum/patron/divine/eora) // Eoran loadout
				armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy/black
				pants = /obj/item/clothing/under/roguetown/tights/stockings/fishnet/black
				gloves = /obj/item/clothing/gloves/roguetown/leather/black
			else
				pants = pick(/obj/item/clothing/under/roguetown/tights/stockings/silk/black, /obj/item/clothing/under/roguetown/tights/stockings/silk/white)
				armor = /obj/item/clothing/suit/roguetown/shirt/dress/maiddress
		head = /obj/item/clothing/head/roguetown/maidhead
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		cloak = /obj/item/clothing/cloak/apron/waist/maid
		belt = /obj/item/storage/belt/rogue/leather/cloth
	beltr = /obj/item/storage/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backr = /obj/item/storage/backpack/rogue/satchel