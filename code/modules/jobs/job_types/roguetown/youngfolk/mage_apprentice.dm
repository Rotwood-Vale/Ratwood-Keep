/datum/job/roguetown/wapprentice
	title = "Magicians Apprentice"
	flag = MAGEAPPRENTICE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_TOLERATED_UP_PLUS_SMOLFOLK
	allowed_ages = list(AGE_ADULT)

	tutorial = "Когда-то ваш учитель разглядел в вас потенциал, и вы не уверены, что он все еще видит в вас потенциал с учетом ваших последних исследований. \
	Путь к использованию магии - это нечто коварное и неизведанное, и вам еще не один десяток лет, чтобы назвать себя даже подмастерьем в этой области. \
	Слушайте и служите, и однажды вы заслужите свою шляпу."

	spells = list(/obj/effect/proc_holder/spell/invoked/learnspell)
	outfit = /datum/outfit/job/roguetown/wapprentice

	display_order = JDO_MAGEAPPRENTICE
	give_bank_account = TRUE

	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/wapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/keyring/mage
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	r_hand = /obj/item/rogueweapon/woodstaff
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		backr = /obj/item/storage/backpack/rogue/satchel
	else
		shoes = /obj/item/clothing/shoes/roguetown/sandals
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black //If girlmagi have to have sandals I'm giving them a dress
		backr = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_spellpoints(6)
	H.change_stat("intelligence", 2)
	H.change_stat("speed", -1)

