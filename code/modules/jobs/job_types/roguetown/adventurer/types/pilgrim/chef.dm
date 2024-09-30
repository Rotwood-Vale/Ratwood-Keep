/datum/advclass/chef
	name = "Chef"
	tutorial = "A humble cook, looking for use of your services. Whether that be a cuisine-peddler, royal feast-maker, or devoted servant to the needy."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/chef

	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)

/datum/outfit/job/roguetown/adventurer/chef/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE) // Cookbooks.
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, 5, TRUE) // Same as butcher, but doesn't start with livestock.
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE) 
	belt = /obj/item/storage/belt/rogue/leather/rope
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	cloak = /obj/item/clothing/cloak/apron
	head = /obj/item/clothing/head/roguetown/chef
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backr = /obj/item/storage/backpack/rogue/backpack/sachel
	backl = /obj/item/storage/backpack/rogue/backpack/sachel
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltr = /obj/item/cooking/pan
	beltl = /obj/item/reagent_containers/glass/pot
	mouth = /obj/item/rogueweapon/huntingknife/cleaver
	backpack_contents = list(/obj/item/reagent_containers/powder/salt = 3,/obj/item/reagent_containers/food/snacks/butter = 1,/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 2, /obj/item/reagent_containers/food/snacks/egg = 2)
	H.change_stat("strength", 1) 
  	H.change_stat("perception", -2) // Anti-fragger stat
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 3) // Hearty diet
