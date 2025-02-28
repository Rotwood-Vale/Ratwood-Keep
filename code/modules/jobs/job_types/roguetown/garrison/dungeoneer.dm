/datum/job/roguetown/dungeoneer
	title = "Dungeoneer"
	flag = DUNGEONEER
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_sexes = list(MALE, FEMALE)

	display_order = JDO_DUNGEONEER

	tutorial = "Sometimes at night you stare into the vacant room and feel the loneliness of your existence crawl into whatever remains of your loathsome soul. \
	You will never know hunger, thirst or want as long as you stay obedient to your Lord: \
	Just as you’ll never forget the sounds a saw makes cutting through the bone, what a drowning man will gurgle out between the blood and teeth strangling his breath. \
	You’re a terrible person, and the carriagemen are going to enjoy walking you down that lonesome path to hell. \
	Only three things command you on this wretched plane, Necra, Mammon, and the Marshal. "

	outfit = /datum/outfit/job/roguetown/dungeoneer
	give_bank_account = 98
	min_pq = 2
	max_pq = null

	cmode_music = 'sound/music/combat_weird.ogg'

/datum/outfit/job/roguetown/dungeoneer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/menacing
	neck = /obj/item/clothing/neck/roguetown/coif
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather/angle
	armor = /obj/item/clothing/cloak/stabard/dungeon
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	shirt = /obj/item/clothing/suit/roguetown/armor/leather/vest
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/rogueweapon/whip/antique
	beltl = /obj/item/storage/keyring/dungeoneer
	backr = /obj/item/storage/backpack/rogue/satchel/black
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.change_stat("strength", 3)
	H.change_stat("intelligence", -2)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
