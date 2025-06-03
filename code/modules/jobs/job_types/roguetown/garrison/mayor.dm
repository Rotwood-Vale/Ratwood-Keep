/datum/job/roguetown/mayor
	title = "Mayor"
	flag = ELDER
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = JCOLOR_YEOMAN
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Whether you are a crooked politician or a true benefactor, you are the Mayor of the city of Rockhill and oversees both Lowtown and Hightown, the cityfolk now turn to you for guidance on smaller matters. \
				The Duke may hold the official title, but with the Sheriff under your command, will you submit to the weight of tradition or reshape the very idea of authority?"
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/mayor
	display_order = JDO_MAYOR
	min_pq = 5
	max_pq = null
	give_bank_account = 100
	can_leave_round = FALSE

	//cmode_music = 'sound/music/combat_bog.ogg'

/datum/outfit/job/roguetown/mayor
	name = "Mayor"
	jobtype = /datum/job/roguetown/mayor

/datum/outfit/job/roguetown/mayor/pre_equip(mob/living/carbon/human/H)
	..()
	r_hand = /obj/item/gun/ballistic/firearm/arquebus_pistol
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/armor
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/ammo_holder/bullet/lead
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/powderflask = 1, /obj/item/storage/keyring/mayor = 1, /obj/item/storage/belt/rogue/pouch/coins/rich = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("perception", 4)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -3)
		H.change_stat("intelligence", 5)
		ADD_TRAIT(H, TRAIT_WANTED_POSTER_READ, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_BOGVULNERABLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw_mayor)

/mob/living/carbon/human/proc/request_outlaw_mayor()
	set name = "Request Outlaw"
	set category = "Juris Civilis"
	if(stat)
		return
	var/inputty = input("Outlaw a person", "JURIS CIVILIS") as text|null
	if(inputty)
		if(hasomen(OMEN_NOLORD))
			make_outlaw(inputty)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(mayor_outlaw_requested), src, lord, inputty)
			else
				make_outlaw(inputty)
				

/proc/mayor_outlaw_requested(mob/living/mayor, mob/living/carbon/human/lord, requested_outlaw)
	var/choice = alert(lord, "The Mayor requests to outlaw someone!\n[requested_outlaw]", "MAYOR OUTLAW REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(mayor)
			to_chat(mayor, span_warning("The Duke has denied the request for declaring an outlaw!"))
		return
	make_outlaw(requested_outlaw)
