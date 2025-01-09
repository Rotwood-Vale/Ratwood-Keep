/datum/job/roguetown/guild_clerk
	title = "Guild Clerk"
	flag = MERC_CLERK
	department_flag = MERCENARIES
	tutorial = "Опрятный. Грубый. Неистовый. Это первые слова, которые приходят на ум для невоспетых героев - контрактников гильдии наемников. \
	Средство, через которое проходят наемники, чтобы обычный горожанин мог найти себе наёмника и получить за него справедливую цену. \
	Вы отвечаете не только за организацию контрактов для наёмников, но и за правильное использование и доставку вознаграждений из эксидиума. \
	Это неблагодарная работа, но кто-то должен ее выполнять. Возможно, это будешь ты."
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
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
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
