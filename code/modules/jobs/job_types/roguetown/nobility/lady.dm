/datum/job/roguetown/lady
	title = "Queen"
	flag = LADY
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(FEMALE)
	allowed_races = list(
		/datum/species/human/northern,
		/datum/species/human/halfelf,
		/datum/species/elf/wood,
		/datum/species/dwarf/mountain,
		/datum/species/aasimar,
	) //Picked for political value, could be anything. Make something up, or execute your wife if you're chudmaxxing that round.
	tutorial = "Picked out of your political value rather than likely any form of love, you have become the King's most trusted confidant and likely friend throughout your marriage. Your loyalty and, perhaps, love; will be tested this day. For the daggers that threaten your beloved are as equally pointed at your own throat."

	outfit = /datum/outfit/job/roguetown/lady

	display_order = JDO_LADY
	give_bank_account = TRUE
	min_pq = 2

/datum/outfit/job/roguetown/lady/pre_equip(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H, RTRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	beltl = /obj/item/roguekey/manor
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	belt = /obj/item/storage/belt/rogue/leather/cloth/lady
	armor = /obj/item/clothing/suit/roguetown/armor/armordress
	if(SSticker.rulertype == "Queen")
		head = /obj/item/clothing/head/roguetown/crown/serpcrown
		cloak = /obj/item/clothing/cloak/lordcloak
		belt = /obj/item/storage/belt/rogue/leather/plaquegold
		armor = /obj/item/clothing/suit/roguetown/armor/armordress/alt
		l_hand = /obj/item/rogueweapon/lordscepter
		if(H.mind)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/convertrole/bog)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/convertrole/guard)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.change_stat("intelligence", 3)
			H.change_stat("endurance", 3)
			H.change_stat("speed", 2)
			H.change_stat("perception", 2)
			H.change_stat("fortune", 5)
	else
		head = /obj/item/clothing/head/roguetown/hennin
//		SSticker.rulermob = H
	if(prob(66))
		armor = /obj/item/clothing/suit/roguetown/armor/armordress/alt
	id = /obj/item/clothing/ring/silver
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)

/datum/job/roguetown/lady/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(SSticker.rulertype == "Queen")
		SSticker.select_ruler()
		if(L)
			to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is Queen of Rockhill.</span></span></b>")
			addtimer(CALLBACK(L, TYPE_PROC_REF(/mob, lord_color_choice)), 50)
