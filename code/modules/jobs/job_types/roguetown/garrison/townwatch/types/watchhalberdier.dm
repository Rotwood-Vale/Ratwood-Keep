/datum/subclass/townwatch/watchhalberdier
	name = "Watch Halberdier"
	tutorial = "Responsible for the safety of the city and the enforcement of the law, \
				you walk among the downtrodden, delivering justice and protecting the innocent. \
				Your loyalty lies in the Bailiff and the city, for neither clergy nor nobility understand the hardships of a commoner. \
				In your pursuits, you've specialized with polearms and your trusty halberd."
	outfit = /datum/outfit/job/roguetown/townwatch/watchhalberdier
	category_tags = list(CTAG_TOWNWATCH)
	maximum_possible_slots = 6

/datum/outfit/job/roguetown/townwatch/watchhalberdier/pre_equip(mob/living/carbon/human/H)
	..()
	r_hand = /obj/item/rogueweapon/halberd
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
