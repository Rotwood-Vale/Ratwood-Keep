/datum/job/roguetown/magician
	title = "Court Magos"
	flag = WIZARD
	department_flag = NOBLEMEN
	selection_color = JCOLOR_NOBLE
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_TOLERATED_UP
	allowed_sexes = list(MALE, FEMALE)
	spells = list(/obj/effect/proc_holder/spell/invoked/learnspell, /obj/effect/proc_holder/spell/invoked/projectile/fireballgreater, /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	display_order = JDO_MAGICIAN
	tutorial = "Ваше кредо - покорение магических искусств и постоянное стремление к знаниям. \
		Вы обязаны жизнью герцогу, ибо именно его маммоны позволили вам продолжить обучение в эти темные времена. \
		Взамен вы снова и снова проявляете себя как справедливый судья и доверенный советник в его правлении."
	outfit = /datum/outfit/job/roguetown/magician
	whitelist_req = TRUE
	give_bank_account = 47
	min_pq = 2
	max_pq = null

/datum/outfit/job/roguetown/magician
	allowed_patrons = list(/datum/patron/divine/noc, /datum/patron/zizo)

/datum/outfit/job/roguetown/magician/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/talkstone
	armor = /obj/item/clothing/suit/roguetown/armor/leather/magos
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/mage
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	id = /obj/item/clothing/ring/gold
	r_hand = /obj/item/rogueweapon/woodstaff
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/lovepotion,/obj/item/reagent_containers/glass/bottle/rogue/poison,/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	ADD_TRAIT(H, TRAIT_SEEPRICES, "[type]")
	ADD_TRAIT(H, TRAIT_NOBLE, "[type]")
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("intelligence", 4)
		H.mind.adjust_spellpoints(8)
		if(H.age == AGE_OLD) //old wizards are wise and experienced they should not get arcane 1 for being old
			belt = /obj/item/storage/belt/rogue/leather/plaquegold //golden belt to show how valuable they are to the duke
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
		
		if(H.gender == MALE)
			H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
