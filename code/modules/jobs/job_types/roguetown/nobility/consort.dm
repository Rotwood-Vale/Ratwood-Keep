/datum/job/roguetown/consort
	title = "Duke Consort"
	f_title = "Duchess Consort"
	flag = CONSORT
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	tutorial = "Picked out of your political value rather than likely any form of love, you have become the Ruler's most trusted confidant and likely friend throughout your marriage. Your loyalty and, perhaps, love; will be tested this day. For the daggers that threaten your beloved are as equally pointed at your own throat."

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/servant)
	outfit = /datum/outfit/job/roguetown/consort

	display_order = JDO_LADY
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

// Prevent same sex ruler-consorts
/datum/job/roguetown/consort/special_job_check(mob/dead/new_player/player)
	if(!player)
		return
	if(!player.ckey)
		return
	for(var/mob/dead/new_player/duke in GLOB.player_list)
		if(duke.mind.assigned_role == "Duke")
			if(duke.client.prefs.gender != player.client.prefs.gender)
				return TRUE

/datum/job/roguetown/consort_dowager//just used to change the consort title
	title = "Duke Dowager"
	f_title = "Duchess Dowager"
	flag = CONSORT
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_LADY
	give_bank_account = TRUE

/datum/job/roguetown/consort/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	if(GLOB.lordsurname && H)
		give_lord_surname(H, preserve_original = TRUE)

/datum/outfit/job/roguetown/consort/pre_equip(mob/living/carbon/human/H)
	. = ..()

	if(H.gender == FEMALE)
		beltl = /obj/item/storage/keyring/royal
		neck = /obj/item/storage/belt/rogue/pouch/coins/rich
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		head = /obj/item/clothing/head/roguetown/duchess_hood
		backl = /obj/item/clothing/suit/roguetown/armor/leather/duchess
		gloves = /obj/item/clothing/gloves/roguetown/leather/black

		id = /obj/item/clothing/ring/silver
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/white
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.change_stat("intelligence", 3)
			H.change_stat("endurance", 3)
			H.change_stat("speed", 2)
			H.change_stat("perception", 2)
			H.change_stat("fortune", 5)

		ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
		
	else
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/gun/ballistic/arquebus_pistol
		beltl = /obj/item/ammo_holder/bullet/lead
		r_hand = /obj/item/storage/keyring/royal
		neck = /obj/item/storage/belt/rogue/pouch/coins/rich
		backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/powderflask = 1)
		id = /obj/item/clothing/ring/active/nomag	
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/armor/leather/duke
		shoes = /obj/item/clothing/shoes/roguetown/armor
		
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.change_stat("strength", 1)
			H.change_stat("intelligence", 3)
			H.change_stat("endurance", 3)
			H.change_stat("speed", 1)
			H.change_stat("perception", 2)
			H.change_stat("fortune", 5)

			H.dna.species.soundpack_m = new /datum/voicepack/male/evil()

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/mask/rogue/lordmask
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch/left))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/mask/rogue/lordmask/l


		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

/datum/outfit/job/roguetown/lady/post_equip(mob/living/carbon/human/H)
	..()
	H.virginity = FALSE

/obj/effect/proc_holder/spell/self/convertrole/servant
	name = "Recruit Servant"
	new_role = "Servant"
	overlay_state = "recruit_servant"
	recruitment_faction = "Servants"
	recruitment_message = "Serve the duchy, %RECRUIT!"
	accept_message = "Yes, your highness!"
	refuse_message = "I refuse."
	charge_max = 100
