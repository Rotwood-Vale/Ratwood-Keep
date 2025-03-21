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
	tutorial = "Whether you are a crooked politician or a true benefactor, the cityfolk now turn to you for guidance on smaller matters. \
				The Duke may hold the official title, but with the Sheriff under your command, will you submit to the weight of tradition or reshape the very idea of authority?"
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/mayor
	display_order = JDO_MAYOR
	min_pq = 5
	max_pq = null
	give_bank_account = 35
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/citizenship)

	//cmode_music = 'sound/music/combat_bog.ogg'

/datum/outfit/job/roguetown/mayor
	name = "Mayor"
	jobtype = /datum/job/roguetown/mayor

/datum/outfit/job/roguetown/mayor/pre_equip(mob/living/carbon/human/H)
	..()
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw_mayor, /mob/living/carbon/human/proc/mayor_announcement)
	r_hand = /obj/item/gun/ballistic/firearm/arquebus_pistol
	head = /obj/item/clothing/head/roguetown/nightman //will do for now
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
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
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("perception", 4)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -3)
		H.change_stat("intelligence", 5)


// Use find "mayor_update"
//
// didn't used dmm map, used math
#define NOT_IN_MAYOR_OFFICE(target) ((target.z != (4 || 5)) || !(185 >= target.x && target.x >= 179) || !(332 >= target.y && target.y >= 328))

/obj/effect/proc_holder/spell/self/convertrole/proc/tf_special_check(mob/living/carbon/human/recruit)
	return TRUE

/mob/living/carbon/human/proc/mayor_announcement()
	set name = "Announcement"
	set category = "Mayor"

	if(stat)
		return FALSE

	if(mob_timers["mayor_announcement"] > world.time)
		to_chat(src, span_warning("I should wait..."))
		return

	if(NOT_IN_MAYOR_OFFICE(src))
		to_chat(src, span_warning("I need to do this from my office."))
		return FALSE

	var/inputty = input("Make an announcement", "And they shall listen") as text|null
	if(!inputty)
		return FALSE

	mob_timers["mayor_announcement"] = world.time + 2 MINUTES

	priority_announce("[inputty]", title = "The Mayor Speaks", sound = 'sound/misc/rebel.ogg')

/*
 * CITIZENSHIP
 */

/mob/living/carbon/human
	var/granted_citizenship = FALSE

/obj/effect/proc_holder/spell/self/convertrole/citizenship
	name = "Grant Citizenship"
	overlay_state = "recruit_titlegrant"
	new_role = "Towner"
	recruitment_faction = "Citizen"
	recruitment_message = "Become a citizen, %RECRUIT!"
	accept_message = "I will!"
	refuse_message = "I refuse."
	charge_max = 100

/obj/effect/proc_holder/spell/self/convertrole/citizenship/can_convert(mob/living/carbon/human/recruit)
	//wtf
	if(QDELETED(recruit))
		return FALSE
	//need a mind
	if(!recruit.mind)
		return FALSE
	//only migrants
	if(!(recruit.job in GLOB.foreigner_positions))
		return FALSE
	//need to see their damn face
	if(!recruit.get_face_name(null))
		return FALSE
	if(!tf_special_check(recruit))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/convertrole/citizenship/tf_special_check(mob/living/carbon/human/recruit)
	if(NOT_IN_MAYOR_OFFICE(recruit))
		to_chat(usr, span_warning("I need to do this from my office."))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/convertrole/citizenship/convert(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter)
	if(!(. = ..()))
		return
	recruit.granted_citizenship = TRUE
	recruit.advjob = "Newcomer"

/*
 * DECLEAR OUTLAW LIKE ROYAL MARSHAL
 */

/mob/living/carbon/human/proc/request_outlaw_mayor()
	set name = "Request Outlaw"
	set category = "Mayor"

	if(stat)
		return

	if(NOT_IN_MAYOR_OFFICE(src)) // Дом мэра, чтобы не нужно было изменять карту
		to_chat(src, span_warning("I need to do this from my office."))
		return FALSE

	var/inputty = input("Outlaw a person", "By the power of people") as text|null
	if(inputty)
		if(hasomen(OMEN_NOLORD))
			make_outlaw(inputty)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_outlaw_requested_from_mayor), src, lord, inputty)
			else
				make_outlaw(inputty)

/proc/lord_outlaw_requested_from_mayor(mob/living/mayor, mob/living/carbon/human/lord, requested_outlaw)
	var/choice = alert(lord, "The Mayor requests to outlaw someone!\n[requested_outlaw]", "MAYOR OUTLAW REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(mayor)
			to_chat(mayor, span_warning("The Duke has denied the request for declaring an outlaw!"))
		return
	make_outlaw(requested_outlaw)

/obj/item/storage/belt/rogue/pouch/coins/rich_mayor/Initialize()
	. = ..()
	var/obj/item/roguecoin/gold/pile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	if(prob(50))
		H = new(loc)
		if(istype(H))
			if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
				qdel(H)

#undef NOT_IN_MAYOR_OFFICE
