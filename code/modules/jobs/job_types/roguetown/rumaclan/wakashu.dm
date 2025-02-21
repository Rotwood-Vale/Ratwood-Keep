/datum/job/roguetown/wakashu
	title = "Wakashu"
	flag = WAKASHU
	department_flag = RUMACLAN
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	allowed_races = EAST_GRONN_TYPES
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_patrons = ALL_NON_INHUMEN_PATRONS
	tutorial = "A foreign henchman; \
	You joined the Clan not too long ago, whenever it was because of your novice skill with a sword or a desire to hurt people. If you do as you're told, kill as you're told, and survive.. Maybe you'll become a Kyodai. \
	You are dirt compared to those above you - but still better than the rest of this shithole. Act like it."
	display_order = JDO_WAKASHU
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/wakashu
	min_pq = 0 //turn into 3 after testing
	max_pq = null

	cmode_music = 'sound/music/combat_rumaclan.ogg'

/datum/outfit/job/roguetown/wakashu/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves2
	pants = /obj/item/clothing/under/roguetown/trou/eastpants1
	shirt = /obj/item/clothing/suit/roguetown/shirt/easttats
	armor = /obj/item/clothing/suit/roguetown/shirt/eastshirt1
	cloak = /obj/item/clothing/cloak/eastcloak2
	shoes = /obj/item/clothing/shoes/roguetown/armor
	beltr = /obj/item/rogueweapon/sword/sabre/mulyeog/rumahench
	beltl = /obj/item/ammo_holder/mulyeog/rumahench
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/storage/keyring/mulyeog)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)

