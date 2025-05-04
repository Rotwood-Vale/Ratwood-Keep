/datum/subclass/prince/sheltered
	name = "Political"
	tutorial = "Your fate was already defined the moment you were born. One dae you shall inherit the throne and your father's realm. \
	But for now, you can just enjoy your highborn lyfe."
	outfit = /datum/outfit/job/roguetown/prince/sheltered
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/prince/sheltered/pre_equip(mob/living/carbon/human/H)
	l_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
	r_hand = /obj/item/storage/belt/rogue/pouch/coins/rich_mayor
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 5, TRUE)
		H.change_stat("perception", 3)
		H.change_stat("speed", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("fortune", 2)
		H.change_stat("constitution", 1)
		H.change_stat("strength", -1)
		H.change_stat("endurance", -1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)

/datum/subclass/prince/militant
	name = "Martial"
	tutorial = "All this aristocratic haughtiness has never been for you, your heart desired battle instead. \
	Given the opportunity, you'd lead the retinue into battle personally."
	outfit = /datum/outfit/job/roguetown/prince/militant
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/prince/militant/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	r_hand = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	l_hand = /obj/item/rogueweapon/sword/sabre
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 34, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("Speed", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("fortune", 1)
		H.change_stat("constitution", 2)
		H.change_stat("strength", 3)
		H.change_stat("endurance", 2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

/datum/subclass/prince/bookworm
	name = "Gifted"
	tutorial = "You have never felt fancy about company of the others. Knowledge however is your desire. \
	Through the years you studied lots of arts and given the time you'd study a lot more."
	outfit = /datum/outfit/job/roguetown/prince/bookworm
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/prince/bookworm/pre_equip(mob/living/carbon/human/H)
	r_hand = /obj/item/book/granter/spellbook/adept
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
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
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
		H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
		H.mind.AddSpell(new SPELL_LEARNSPELL)
		H.mind.AddSpell(new SPELL_MESSAGE)
		H.mind.AddSpell(new SPELL_FETCH)
		H.mind.AddSpell(new SPELL_DARKVISION)
		H.mind.adjust_spellpoints(3)
		H.change_stat("intelligence", 3)
		H.change_stat("perception", 2)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 1)
		H.change_stat("constitution", -1)
		H.change_stat("strength", -2)
		H.change_stat("endurance", -2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

/datum/subclass/prince/inbred
	name = "Larcenous"
	tutorial = "Yoou always were more criminaly minded than others, lockpicnking, stealing, and all the other stuff is just so appealing for you now. \
	You were doomed to become a disgrace to your family, yet you still live in the manor. For now."
	outfit = /datum/outfit/job/roguetown/prince/inbred
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/prince/inbred/pre_equip(mob/living/carbon/human/H)
	backpack_contents = list(/obj/item/lockpickring/mundane = 1)
	l_hand = /obj/item/rogueweapon/huntingknife/idagger
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.change_stat("fortune", 1) // Xylix blessed you with great luck bro trust me
		H.change_stat("perception", 3)
		H.change_stat("Speed", 3)
		H.change_stat("constitution", -2)
		H.change_stat("strength", -1)
		H.change_stat("endurance", -1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
