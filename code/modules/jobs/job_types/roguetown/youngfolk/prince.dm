/datum/job/roguetown/prince
	title = "Heir"
	f_title = "Heiress"
	flag = PRINCE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_TOLERATED_UP 
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)
	subclass_cat_rolls = list(CTAG_HEIR = 20)
	can_leave_round = FALSE

	tutorial = "You’ve never felt the gnawing of the winter, never known the bite of hunger and certainly have never known what the peasantry call a honest day's work. In your youth you were as free as any bird in the sky, but that is of the past. Your noble duties are fast approaching and you will soon have to choose: Continue to spend life leisurely, or stalwartly shoulder the duties you've been handed."

	outfit = /datum/outfit/job/roguetown/prince
	display_order = JDO_PRINCE
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/job/roguetown/prince/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/job/roguetown/prince/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	if(GLOB.lordsurname && H)
		give_lord_surname(H)
	if(ishuman(H))
		var/index = findtext(H.real_name, " ")
		if(index)
			index = copytext(H.real_name, 1,index)
		if(!index)
			index = H.real_name
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Lord"
		if(H.gender == FEMALE)
			honorary = "Lady"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"

/datum/outfit/job/roguetown/prince/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/armor/leather/heir
		belt = /obj/item/storage/belt/rogue/leather
		pants = /obj/item/clothing/under/roguetown/tights
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/armor/leather/heiress
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		pants = /obj/item/clothing/under/roguetown/tights/stockings/white
	beltl = /obj/item/storage/keyring/royal
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backr = /obj/item/storage/backpack/rogue/satchel
	shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot

/datum/subclass/prince/sheltered
	name = "Sheltered Successor"
	tutorial = "Your fate was already defined the moment you were born. One dae you shall inherit the throne and your father's realm. \
	But for now, you can just enjoy your highborn lyfe."
	outfit = /datum/outfit/job/roguetown/prince/sheltered
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 10

/datum/outfit/job/roguetown/prince/sheltered/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("speed", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("fortune", 1)
		H.change_stat("constitution", 1)
		H.change_stat("strength", -1)
		H.change_stat("endurance", -2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

/datum/subclass/prince/militant
	name = "Militant"
	tutorial = "All this aristocratic haughtiness has never been for you, your heart desired battle instead. \
	Given the opportunity, you'd lead the retinue into battle personally."
	outfit = /datum/outfit/job/roguetown/prince/militant
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 1

/datum/outfit/job/roguetown/prince/militant/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 1)
		H.change_stat("fortune", 1)
		H.change_stat("constitution", 1)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/subclass/prince/bookworm
	name = "Bookworm"
	tutorial = "You have never felt fancy about company of the others. Knowledge however is your desire. \
	Through the years you studied lots of arts and given the time you'd study a lot more."
	outfit = /datum/outfit/job/roguetown/prince/bookworm
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 1

/datum/outfit/job/roguetown/prince/bookworm/pre_equip(mob/living/carbon/human/H)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
		H.mind.AddSpell(new SPELL_MESSAGE)
		H.mind.AddSpell(new SPELL_FETCH)
		H.mind.AddSpell(new SPELL_DARKVISION)
		H.change_stat("intelligence", 3)
		H.change_stat("perception", 2)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 1)
		H.change_stat("constitution", -1)
		H.change_stat("strength", -2)
		H.change_stat("endurance", -2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)

/datum/subclass/prince/inbred
	name = "Inbred"
	tutorial = "You'd have had a beautiful lyfe without knowing a trouble, yet this world made a not so funny trick on you. \
	You were doomed to become a disgrace to your family, yet you still live in the manor. For now."
	outfit = /datum/outfit/job/roguetown/prince/inbred
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 1

/datum/outfit/job/roguetown/prince/inbred/pre_equip(mob/living/carbon/human/H)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.change_stat("fortune", 2) // Xylix blessed you with great luck bro trust me
		H.change_stat("perception", -2)
		H.change_stat("intelligence", -2)
		H.change_stat("constitution", -2)
		H.change_stat("strength", -2)
		H.change_stat("endurance", -2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NORUN, TRAIT_GENERIC) // no running is enough, dont change their speed
