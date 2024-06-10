/datum/advclass/seamstress
	name = "Seamstress"
	tutorial = "You are a mistress of the loom, capable of weaving wonders that have brought many nobles to your workshop. You arrive in Rockhill with some coin and your talent in the hopes of expanding your client base. By the looks of things these people are crying out for your aid!"
	allowed_sexes = list("female")
	allowed_races = CLOTHED_RACES_TYPES
	outfit = /datum/outfit/job/roguetown/adventurer/seamstress
	isvillager = TRUE
	ispilgrim = FALSE

/datum/outfit/job/roguetown/adventurer/seamstress/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/weaving, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	mouth = /obj/item/needle
	belt = /obj/item/storage/belt/rogue/leather/cloth/lady
	pants = /obj/item/clothing/under/roguetown/tights/random
	armor = /obj/item/clothing/suit/roguetown/armor/armordress
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backl = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	beltr = /obj/item/rogueweapon/huntingknife/idagger
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	beltl = /obj/item/needle
	backpack_contents = list(/obj/item/natural/cloth = 2, /obj/item/natural/bundle/fibers/full = 1)
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 2)  
	H.change_stat("perception", 1)
