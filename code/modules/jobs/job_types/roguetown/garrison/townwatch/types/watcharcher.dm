/datum/subclass/manorguard/watcharcher
	name = "Watch Bowman"
	tutorial = "Responsible for the safety of the city and the enforcement of the law, \
				you walk among the downtrodden, delivering justice and protecting the innocent. \
				Your loyalty lies in the Bailiff and the city, for neither clergy nor nobility understand the hardships of a commoner. \
				In your pursuits, you've specialized with archery and your trusty bow."
	outfit = /datum/outfit/job/roguetown/manorguard/watcharcher
	category_tags = list(CTAG_TOWNWATCH)
	maximum_possible_slots = 6

/datum/outfit/job/roguetown/manorguard/watcharcher/pre_equip(mob/living/carbon/human/H)
	..()
	beltr = /obj/item/ammo_holder/quiver/arrows
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.change_stat("perception", 3)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 2)
