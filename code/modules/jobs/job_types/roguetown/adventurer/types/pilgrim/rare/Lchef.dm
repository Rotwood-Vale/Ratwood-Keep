//human master chef

/datum/advclass/masterchef
	name = "Master Chef"
	tutorial = "A master chef, one of the best cooks to ever live. \
	With noble origins, you were taught by cooking masters in the secretive League of Fine Dining in exotic meals from all around the world \
	Now you wander, free to experiment, cook exotic dishes and gourmet meals, worthy for a king"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/masterchef

	maximum_possible_slots = 1
	pickprob = 5
	category_tags = list(CTAG_PILGRIM)

/datum/outfit/job/roguetown/adventurer/masterchef/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 6, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/rope
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	cloak = /obj/item/clothing/cloak/apron
	head = /obj/item/clothing/head/roguetown/chef
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backr = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	beltr = /obj/item/cooking/pan
	mouth = /obj/item/rogueweapon/huntingknife
	beltl = /obj/item/flint
	backpack_contents = list(/obj/item/reagent_containers/powder/flour/salt = 1,/obj/item/reagent_containers/food/snacks/rogue/cheese=1,/obj/item/reagent_containers/food/snacks/rogue/cheddar=1)
	H.change_stat("intelligence", 3)
	H.change_stat("constitution", 2)
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
