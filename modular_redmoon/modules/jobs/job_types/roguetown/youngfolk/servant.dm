/datum/job/roguetown/servant
	ru_title = "Лакей"
	ru_f_title = "Горничная"
	ru_tutorial = "Вы были награждены прекрасной должностью слуги в доме лорда.\
	Вы слушаете приказы дворецкого и проводите день, выполняя необходимые, но рутинные задания."

/datum/outfit/job/roguetown/servant/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
	if(H.gender == FEMALE)
		head = /obj/item/clothing/head/roguetown/maidhead
		pants = pick(/obj/item/clothing/under/roguetown/tights/stockings/silk/black, /obj/item/clothing/under/roguetown/tights/stockings/silk/white)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/maiddress
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		cloak = /obj/item/clothing/cloak/apron/waist/maid
		belt = /obj/item/storage/belt/rogue/leather/cloth