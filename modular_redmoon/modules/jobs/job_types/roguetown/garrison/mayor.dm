/datum/job/roguetown/mayor
	ru_title = "Бургмейстер"
	ru_tutorial = "Независимо от того, являетесь ли вы нечестным политиком или истинным благотворителем, \
			горожане теперь обращаются к вам за решением проблем в Рокхилле по вопросам малой важности. \
			Хоть Герцог и может носить свой титул, но, с вашим Шерифом, будете ли вы следовать традициям или переосмыслите нынешнюю идею власти?"
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/watchman_lesser, /obj/effect/proc_holder/spell/self/convertrole/vanguard_lesser, /obj/effect/proc_holder/spell/self/convertrole/citizenship)
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'

/datum/job/roguetown/mayor/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/title = "Mayor"
		H.real_name = "[title] [prev_real_name]"
		H.name = "[title] [prev_name]"

/datum/outfit/job/roguetown/mayor/pre_equip(mob/living/carbon/human/H)
	..()
	id = /obj/item/scomstone_rk
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/powderflask = 1, /obj/item/storage/keyring/mayor = 1, /obj/item/storage/belt/rogue/pouch/coins/rich_mayor = 1)
	if(H.mind)
		H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw_mayor, /mob/living/carbon/human/proc/mayor_announcement)

// Искать связанное по "mayor_update"

// Чтобы не нужно было изменять dmm карты, используем math
#define NOT_IN_MAYOR_OFFICE(target) ((target.z != (4 || 5)) || !(185 >= target.x && target.x >= 179) || !(332 >= target.y && target.y >= 328))

/*
 * АНОНС
 */

/mob/living/carbon/human/proc/mayor_announcement()
	set name = "Announcement"
	set category = "Mayor"

	if(stat)
		return FALSE

	if(mob_timers["mayor_announcement"] > world.time)
		to_chat(src, span_warning("I should wait..."))
		return

	if(NOT_IN_MAYOR_OFFICE(src)) // Дом мэра, чтобы не нужно было изменять карту
		to_chat(src, span_warning("I need to do this from my office."))
		return FALSE

	var/inputty = input("Make an announcement", "And they shall listen") as text|null
	if(!inputty)
		return FALSE

	mob_timers["mayor_announcement"] = world.time + 2 MINUTES

	priority_announce("[inputty]", title = "The Mayor Speaks", sound = 'sound/misc/rebel.ogg')

/*
 * НАБОР В СТРАЖУ
 */

/obj/effect/proc_holder/spell/self/convertrole/watchman_lesser
	name = "Recruit Watchman"
	new_role = "Watchman"
	overlay_state = "recruit_guard"
	recruitment_faction = "Watchman"
	recruitment_message = "Служи граду, %RECRUIT!"
	accept_message = "Есть!"
	refuse_message = "Я отказываюсь."
	charge_max = 100

/obj/effect/proc_holder/spell/self/convertrole/proc/redmoon_special_check(mob/living/carbon/human/recruit)
	return TRUE

/obj/effect/proc_holder/spell/self/convertrole/watchman_lesser/redmoon_special_check(mob/living/carbon/human/recruit)
	if(NOT_IN_MAYOR_OFFICE(recruit)) // Дом мэра, чтобы не нужно было изменять карту
		to_chat(usr, span_warning("I need to do this from my office."))
		return FALSE

	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(HL.mind)
			if(HL.mind.assigned_role == "Town Sheriff")
				to_chat(usr, span_warning("I cannot hire people in garnison without the sheriff's approval."))
				return FALSE
	return TRUE

/*
 * НАБОР В АВАНГАРД
 */

/obj/effect/proc_holder/spell/self/convertrole/vanguard_lesser
	name = "Recruit Vanguard"
	new_role = "Vanguard"
	overlay_state = "recruit_bog"
	recruitment_faction = "Vanguard"
	recruitment_message = "Служи деревне, %RECRUIT!"
	accept_message = "Есть!"
	refuse_message = "Я отказываюсь."
	charge_max = 100

/obj/effect/proc_holder/spell/self/convertrole/vanguard_lesser/redmoon_special_check(mob/living/carbon/human/recruit)
	if(NOT_IN_MAYOR_OFFICE(recruit)) // Дом мэра, чтобы не нужно было изменять карту
		to_chat(usr, span_warning("I need to do this from my office."))
		return FALSE

	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(HL.mind)
			if(HL.mind.assigned_role == "Warden")
				to_chat(usr, span_warning("I cannot hire people in vanguard without the warden's approval."))
				return FALSE
	return TRUE

/*
 * ДАРОВАНИЕ ГРАЖДАНСТВА
 */

/mob/living/carbon/human
	var/granted_citizenship = FALSE

/obj/effect/proc_holder/spell/self/convertrole/citizenship
	name = "Grant Citizenship"
	overlay_state = "recruit_titlegrant"
	new_role = "Towner"
	recruitment_faction = "Citizen"
	recruitment_message = "Становись гражданином, %RECRUIT!"
	accept_message = "Буду!"
	refuse_message = "Я отказываюсь."
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
	if(!redmoon_special_check(recruit))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/convertrole/citizenship/redmoon_special_check(mob/living/carbon/human/recruit)
	if(NOT_IN_MAYOR_OFFICE(recruit)) // Дом мэра, чтобы не нужно было изменять карту
		to_chat(usr, span_warning("I need to do this from my office."))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/convertrole/citizenship/convert(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter)
	if(!(. = ..()))
		return
	recruit.granted_citizenship = TRUE
	recruit.advjob = "Newcomer"

/*
 * ОБЪЯВЛЕНИЕ ВНЕ ЗАКОНА
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
