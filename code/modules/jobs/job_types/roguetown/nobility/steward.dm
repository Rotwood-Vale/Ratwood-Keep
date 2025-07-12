/datum/job/roguetown/steward
	title = "Steward"
	flag = STEWARD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_TOLERATED_UP
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_STEWARD
	tutorial = "Coin, Coin, Coin! Oh beautiful coin: You're addicted to it, and you hold the position as the Duke's personal treasurer of both coin and information. You know the power silver and gold has on a man's mortal soul, and you know just what lengths they'll go to in order to get even more. Keep your festering economy alive along with your merchant business partner, they're the only two things you can weigh any trust into anymore."
	outfit = /datum/outfit/job/roguetown/steward
	give_bank_account = 17
	min_pq = 2
	max_pq = null

/datum/job/roguetown/steward/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
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

/datum/outfit/job/roguetown/steward/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/steward
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/red
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/steward
	backr = /obj/item/storage/backpack/rogue/satchel
	mask = /obj/item/clothing/mask/rogue/spectacles
	backpack_contents = list(/obj/item/clothing/mask/rogue/spectacles = 1)

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)


	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("perception", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/adjust_taxes

GLOBAL_VAR_INIT(steward_tax_cooldown, -50000) // Antispam
/mob/living/carbon/human/proc/adjust_taxes()
	set name = "Adjust Taxes"
	set category = "Stewardry"
	if(stat)
		return
	var/lord = find_lord()
	if(lord)
		to_chat(src, span_warning("You cannot adjust taxes while the [SSticker.rulertype] is present in the realm. Ask your liege."))
		return
	if(world.time < GLOB.steward_tax_cooldown + 600 SECONDS)
		to_chat(src, span_warning("You must wait [round((GLOB.steward_tax_cooldown + 600 SECONDS - world.time)/600, 0.1)] minutes before adjusting taxes again! Think of the realm."))
		return FALSE
	var/newtax = input(src, "Set a new tax percentage (1-99)", src, SStreasury.tax_value*100) as null|num
	if(newtax)
		if(findtext(num2text(newtax), "."))
			return
		newtax = CLAMP(newtax, 1, 99)
		if(stat)
			return
		SStreasury.tax_value = newtax / 100
		priority_announce("The new tax in Rockhill shall be [newtax] percent.", "The Steward Meddles", pick('sound/misc/royal_decree.ogg', 'sound/misc/royal_decree2.ogg'), "Captain")
		GLOB.steward_tax_cooldown = world.time