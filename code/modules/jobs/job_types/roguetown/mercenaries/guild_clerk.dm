/datum/job/roguetown/guild_clerk
	title = "Guild Clerk"
	flag = MERC_CLERK
	department_flag = MERCENARIES
	tutorial = "Tidy. Crass. Foul mouthed. The first words that come to mind for the unsung hero of the mercenary guild's contract clerk. \
	The medium by which the mercenaries go through for the average town goer to secure a mercenary and a fair price to accompany. \
	Not only are you responsible for organizing contracts for the mercenaries, but also ensuring the proper use and delivery of the rewards from the excidium. \
	It's a thankless task, but someone has to do it. May as well be you."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_ages = ALL_AGES_LIST
	outfit = /datum/outfit/job/roguetown/mercenary/guild_clerk
	display_order = JDO_MERC_CLERK
	selection_color = JCOLOR_MERCENARY
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	min_pq = 6
	max_pq = null
	job_reopens_slots_on_death = TRUE

/datum/outfit/job/roguetown/mercenary/guild_clerk/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_SEEPRICES, type)

//More-or-less just combat clerk. DO YOUR JOB!!!!!!!
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("fortune", 1)

//Clerk stuff.
	if(H.gender == MALE)
		armor = /obj/item/clothing/cloak/tabard/knight
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		pants = /obj/item/clothing/under/roguetown/tights

	if(H.gender == FEMALE)
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/nobledress/green
		pants = /obj/item/clothing/under/roguetown/tights/stockings/white
//End of.

	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich//To pay out contracts, if the issuer flakes.
	backl = /obj/item/rogueweapon/mace
	beltl = /obj/item/storage/keyring/mercenary_boss//So they can access the Captain's office.
	backr = /obj/item/storage/backpack/rogue/satchel
