/datum/subclass/Apothecary
	name = "Apothecary"
	tutorial = "You are an apothecary, a potion maker, a shaman. You have the know how to make life saving remedies and the deadliest of poisons and you make a living off of selling them."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/towner/doctor
	category_tags = list(CTAG_TOWNER)
	traits_applied = list(TRAIT_EMPATH, TRAIT_NOSTINK)
	cmode_music = 'sound/music/combat_physician.ogg'

/datum/outfit/job/roguetown/towner/doctor/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	pants = /obj/item/clothing/under/roguetown/tights
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	belt = /obj/item/storage/belt/rogue/leather/rope
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	beltr = /obj/item/rogueweapon/huntingknife
	backr = /obj/item/rogueweapon/woodstaff
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list( /obj/item/reagent_containers/glass/bottle = 2, /obj/item/reagent_containers/glass/mortar = 1,  /obj/item/reagent_containers/glass/alembic = 1, /obj/item/thermometer = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/reagent_containers/food/snacks/grown/marigold = 2, /obj/item/reagent_containers/food/snacks/grown/nettle = 1, /obj/item/hourglass/alchemy = 1)
	H.change_stat("intelligence", 2)
	H.change_stat("fortune", 1)
	H.change_stat("strength", -1)
