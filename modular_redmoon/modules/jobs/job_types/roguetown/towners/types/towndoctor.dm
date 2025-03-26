/datum/subclass/towndoctor
	ru_name = "Городоской Лекарь"
	ru_tutorial = "Вы местный врач, что несёт бремя лечению недугов людей. \
	Это неблагодарная работа и в большинство случаев она будет забесплатно, но вы \
	все равно делаете то, что делаете, потому что знаете: в один из разов вас отблагодарят."

/datum/outfit/job/roguetown/towner/doctor/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/doublet/random
