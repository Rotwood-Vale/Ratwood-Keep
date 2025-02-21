/datum/job/roguetown/rumacaptain
	title = "Dragon Head"
	flag = RUMACAPTAIN
	department_flag = RUMACLAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = EAST_GRONN_TYPES
	allowed_sexes = list(FEMALE) //mentor's male - think of it as a potential rp dynamic
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_patrons = ALL_NON_INHUMEN_PATRONS
	tutorial = "A local gang leader, originating from foreign lands; \
	Nobody but you knows that you were once a lowly thug's courtesan. Now, you are the current Captain of the Ruma Clan. You have total control over your underlings, and are infinitely above them.\
	You care only for mammon, strict martial prowess, and obedience. Enforce the Clan's incredibly strict heirarcy, cut off tongues if you have to. Rumor is - there's some new kids in town. Kick them out."
	display_order = JDO_RUMACAPTAIN
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/rumacaptain
	min_pq = 0 //turn into 8 after testing
	max_pq = null

	cmode_music = 'sound/music/combat_rumaclan.ogg'

/datum/outfit/job/roguetown/rumacaptain/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves2
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich/ //intended use is to pay off the keep
	shirt = /obj/item/clothing/suit/roguetown/shirt/easttats
	armor = /obj/item/clothing/suit/roguetown/armor/eastsuit4
	shoes = /obj/item/clothing/shoes/roguetown/armor/rumaclan
	beltr = /obj/item/rogueweapon/sword/sabre/mulyeog/rumacaptain
	beltl = /obj/item/ammo_holder/mulyeog/rumahcaptain
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/storage/keyring/nightman)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 2)

	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC) //it's not as good as it sounds i swear
