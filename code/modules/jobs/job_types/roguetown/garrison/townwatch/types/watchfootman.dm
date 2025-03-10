/datum/subclass/manorguard/watchfootman
	name = "Watch Footman"
	tutorial = "Responsible for the safety of the city and the enforcement of the law, \
				you walk among the downtrodden, delivering justice and protecting the innocent. \
				Your loyalty lies in the Bailiff and the city, for neither clergy nor nobility understand the hardships of a commoner. \
				In your pursuits, you've specialized with maces and your trusty shield."
	outfit = /datum/outfit/job/roguetown/manorguard/watchfootman
	category_tags = list(CTAG_TOWNWATCH)
	maximum_possible_slots = 6

/datum/outfit/job/roguetown/manorguard/watchfootman/pre_equip(mob/living/carbon/human/H)
	..()
	r_hand = /obj/item/rogueweapon/mace/steel
	l_hand = /obj/item/rogueweapon/shield/tower
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 2)
