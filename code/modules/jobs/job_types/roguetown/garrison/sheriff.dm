/datum/job/roguetown/sheriff
	title = "Town Sheriff"
	flag = SHERIFF
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TOLERATED_UP
	allowed_sexes = list(MALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	display_order = JDO_SHERIFF
	tutorial = "Crime has always been a constant of your life, and you always chose the side of justice. \
	You rose up through the ranks as a watchman, and now rule over them - Ensure that they enforce the laws of this land properly. \
	Just make sure not to discard ALL of the Marshal's orders, Xylix knows they get upset about it."
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/sheriff
	give_bank_account = 26
	min_pq = 8
	max_pq = null

/datum/outfit/job/roguetown/sheriff/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/citywatch
	pants = /obj/item/clothing/under/roguetown/chainlegs
	armor = /obj/item/clothing/suit/roguetown/armor/citywatch
	neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	shoes = /obj/item/clothing/shoes/roguetown/armor
	backr = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltl = /obj/item/rogueweapon/sword/sabre
	beltr = /obj/item/rogueweapon/mace/stunmace
	cloak = /obj/item/clothing/cloak/cape/black
	backpack_contents = list(/obj/item/keyring/sheriff = 1)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/convertrole/guard)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(5,6), TRUE)//The boss of this gym. :)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell
