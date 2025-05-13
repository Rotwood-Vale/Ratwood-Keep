GLOBAL_LIST_EMPTY(apostasy_players)
GLOBAL_LIST_EMPTY(excommunicated_players)
GLOBAL_LIST_EMPTY(heretical_players)

/datum/job/roguetown/priest
	title = "Priest"
	flag = PRIEST
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = JCOLOR_CHURCH
	f_title = "Priestess"
	allowed_races = RACES_TOLERATED_UP
	allowed_patrons = ALL_DIVINE_PATRONS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = ALL_AGES_LIST
	tutorial = "The Divine is all that matters in a world of the immoral. The Weeping God left his children to rule over us mortals and you will preach their wisdom to any who still heed their will. The faithless are growing in number, it is up to you to shepard them to a Gods-fearing future."
	whitelist_req = FALSE

	spells = list(SPELL_CONVERT_ROLE_TEMPLAR, SPELL_CONVERT_ROLE_MONK)
	outfit = /datum/outfit/job/roguetown/priest

	display_order = JDO_PRIEST
	give_bank_account = 115
	min_pq = 8
	max_pq = null

	cmode_music = 'sound/music/combat_clergy.ogg'

/datum/job/roguetown/priest/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/title = "Father"
		if(H.gender == FEMALE)
			title = "Mother"
		H.real_name = "[title] [prev_real_name]"
		H.name = "[title] [prev_name]"

/datum/outfit/job/roguetown/priest
	allowed_patrons = list(/datum/patron/divine/astrata)

/datum/outfit/job/roguetown/priest/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver/astrata
	head = /obj/item/clothing/head/roguetown/priestmask
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/rope
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	id = /obj/item/clothing/ring/active/nomag
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/priest
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/needle/pestra = 1,
		/obj/item/natural/worms/leech/cheele = 1, //little buddy
		/obj/item/storage/keyring/priest = 1,
	)
	ADD_TRAIT(H, TRAIT_CHOSEN, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", 1)

	var/datum/devotion/C = new /datum/devotion(H, H.patron) // This creates the cleric holder used for devotion spells
	C.grant_spells_priest(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

	H.verbs |= /mob/living/carbon/human/proc/coronate_lord
	H.verbs |= /mob/living/carbon/human/proc/churcheapostasy
	H.verbs |= /mob/living/carbon/human/proc/churchannouncement
	H.verbs |= /mob/living/carbon/human/proc/churchexcommunicate
	H.verbs |= /mob/living/carbon/human/proc/completesermon

/datum/outfit/job/roguetown/priest/post_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE

/mob/living/carbon/human/proc/coronate_lord()
	set name = "Coronate"
	set category = "Priest"
	if(!mind)
		return
	if(!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
		to_chat(src, span_warning("I need to do this in the chapel."))
		return FALSE
	for(var/mob/living/carbon/human/HU in get_step(src, src.dir))
		if(!HU.mind)
			continue
		if(HU.mind.assigned_role == "Duke")
			continue
		if(!HU.head)
			continue
		if(!istype(HU.head, /obj/item/clothing/head/roguetown/crown/serpcrown))
			continue

		//Abdicate previous Duke
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.mind)
				if(HL.mind.assigned_role == "Duke" || HL.mind.assigned_role == "Duke Consort")
					HL.mind.assigned_role = "Towner" //So they don't get the innate traits of the lord
			//would be better to change their title directly, but that's not possible since the title comes from the job datum
			if(HL.job == "Duke")
				HL.job = "Duke Emeritus"
			if(HL.job == "Duke Consort")
				HL.job = "Consort Dowager"
			SSjob.type_occupations[/datum/job/roguetown/ruler].remove_spells(HL)

		//Coronate new Lord (or Lady)
		HU.mind.assigned_role = "Duke"
		HU.job = "Duke"
		SSjob.type_occupations[/datum/job/roguetown/ruler].add_spells(HU)

		switch(HU.gender)
			if("male")
				SSticker.rulertype = "Duke"
			if("female")
				SSticker.rulertype = "Duchess"
		SSticker.rulermob = HU
		var/dispjob = mind.assigned_role
		removeomen(OMEN_NOLORD)
		say("By the authority of the gods, I pronounce you [SSticker.rulertype] of Rockhill!")
		priority_announce("[real_name] the [dispjob] has named [HU.real_name] the [SSticker.rulertype] of Rockhill!", title = "Long Live [HU.real_name]!", sound = 'sound/misc/bell.ogg')
		TITLE_LORD = SSticker.rulertype

/mob/living/carbon/human/proc/churcheapostasy()
	set name = "Apostasy"
	set category = "Priest"
	if(stat)
		return
	var/inputty = input("Put an apostasy on someone, removing their ability to use miracles... (apostasy them again to remove it)", "Sinner Name") as text|null
	if(inputty)
		if(!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
			to_chat(src, span_warning("I need to do this from the Church's chapel."))
			return FALSE
		if(inputty in GLOB.apostasy_players)
			GLOB.apostasy_players -= inputty
			priority_announce("[real_name] has forgiven [inputty]. Their patron hears their prayer once more!", title = "Hail the Ten!", sound = 'sound/misc/bell.ogg')
			for(var/mob/living/carbon/human/H in GLOB.player_list)
				if(H.real_name == inputty)
					H.devotion.recommunicate()
					spawn(1) //yes lmao. In other cases it will TOSS RECOMMUNICATE AT ANY PLAYER NOT CLERGY
						H.remove_status_effect (/datum/status_effect/debuff/apostasy)
						H.remove_stress(/datum/stressevent/apostasy)
			return
		var/found = FALSE
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			if(H.real_name == inputty)
				found = TRUE
				H.devotion.excommunicate() //and then the game will refuse TO PUT IT AWAY BECAUSE THEY HAVE NO DEVOTION??
				spawn(1)
					H.apply_status_effect (/datum/status_effect/debuff/apostasy)
					H.add_stress(/datum/stressevent/apostasy)
		if(!found)
			return FALSE

		GLOB.apostasy_players += inputty
		priority_announce("[real_name] has placed apostasy's mark upon [inputty]!", title = "SHAME", sound = 'sound/misc/excomm.ogg')

/mob/living/carbon/human/proc/churchexcommunicate()
	set name = "Excommunicate"
	set category = "Priest"
	if(stat)
		return
	var/inputty = input("Excommunicate someone, away from the Ten... Or show to their heretical gods that they are worthy... (excommunicate them again to remove it)", "Sinner Name") as text|null
	if(inputty)
		if(!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
			to_chat(src, span_warning("I need to do this from the Church."))
			return FALSE
		if(inputty in GLOB.excommunicated_players)
			GLOB.excommunicated_players -= inputty
			priority_announce("[real_name] has forgiven [inputty]. Their patron hears their prayer once more!", title = "Hail the Ten!", sound = 'sound/misc/bell.ogg')
			for(var/mob/living/carbon/human/H in GLOB.player_list)
				if(H.real_name == inputty)
					REMOVE_TRAIT(H, TRAIT_EXCOMMUNICATED, TRAIT_GENERIC)
					if(HAS_TRAIT(H, TRAIT_ORGAN_EATER) || HAS_TRAIT(H, TRAIT_COMMIE) || HAS_TRAIT(H, TRAIT_MATTHIOS_EYES) || HAS_TRAIT(H, TRAIT_CRACKHEAD) || HAS_TRAIT(H, TRAIT_ZIZO_MARKED))
						H.remove_stress(/datum/stressevent/gazeuponme)
						H.remove_status_effect(/datum/status_effect/buff/gazeuponme)
					else
						H.remove_stress(/datum/stressevent/excommunicated)
						H.remove_status_effect(/datum/status_effect/debuff/excomm)
			return
		var/found = FALSE
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			if(H == src)
				continue
			if(H.real_name == inputty)
				found = TRUE
				ADD_TRAIT(H, TRAIT_EXCOMMUNICATED, TRAIT_GENERIC)
				if(HAS_TRAIT(H, TRAIT_ORGAN_EATER) || HAS_TRAIT(H, TRAIT_COMMIE) || HAS_TRAIT(H, TRAIT_MATTHIOS_EYES) || HAS_TRAIT(H, TRAIT_CRACKHEAD) || HAS_TRAIT(H, TRAIT_ZIZO_MARKED))
					H.add_stress(/datum/stressevent/gazeuponme)
					H.apply_status_effect(/datum/status_effect/buff/gazeuponme)
				else
					H.add_stress(/datum/stressevent/excommunicated)
					H.apply_status_effect(/datum/status_effect/debuff/excomm)
		if(!found)
			return FALSE
		GLOB.excommunicated_players += inputty
		priority_announce("[real_name] has excommunicated [inputty]!", title = "SHAME", sound = 'sound/misc/excomm.ogg')

/mob/living/carbon/human
	COOLDOWN_DECLARE(church_announcement)

/mob/living/carbon/human/proc/churchannouncement()
	set name = "Announcement"
	set category = "Priest"

	if(!COOLDOWN_FINISHED(src, church_announcement))
		to_chat(src, span_warning("I should wait..."))
		return

	if(stat)
		return FALSE

	var/inputty = input("Make an announcement", "ROGUETOWN") as text|null
	if(!inputty)
		return FALSE

	if(!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
		to_chat(src, span_warning("I need to do this from the chapel."))
		return FALSE

	priority_announce("[inputty]", title = "The Priest Speaks", sound = 'sound/misc/bell.ogg')
	COOLDOWN_START(src, church_announcement, 30 SECONDS)

/obj/effect/proc_holder/spell/self/convertrole/templar
	name = "Recruit Templar"
	new_role = "Templar"
	overlay_state = "recruit_templar"
	recruitment_faction = "Templars"
	recruitment_message = "Serve the ten, %RECRUIT!"
	accept_message = "FOR THE TEN!"
	refuse_message = "I refuse."

/obj/effect/proc_holder/spell/self/convertrole/monk
	name = "Recruit Acolyte"
	new_role = "Acolyte"
	overlay_state = "recruit_acolyte"
	recruitment_faction = "Church"
	recruitment_message = "Serve the ten, %RECRUIT!"
	accept_message = "FOR THE TEN!"
	refuse_message = "I refuse."

/mob/living/carbon/human/proc/completesermon()
    set name = "Sermon"
    set category = "Priest"
    if(!mind)
        return
    if(!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
        to_chat(src, span_warning("I need to do this in the chapel."))
        return FALSE
    src.visible_message(span_notice("[src] begins preaching a sermon..."))
    if(!do_after(src, 1200, target = src)) // 120 seconds
        src.visible_message(span_warning("[src] stops preaching."))
        return

    src.visible_message(span_notice("[src] finishes the sermon, inspiring those nearby!"))
    for(var/mob/living/carbon/human/H in view(7, src)) // all mobs within 7 tiles
        if(HAS_TRAIT(H, TRAIT_ORGAN_EATER) || HAS_TRAIT(H, TRAIT_COMMIE) || HAS_TRAIT(H, TRAIT_MATTHIOS_EYES) || HAS_TRAIT(H, TRAIT_CRACKHEAD) || HAS_TRAIT(H, TRAIT_ZIZO_MARKED))
            H.add_stress(/datum/stressevent/heretic_on_sermon)
            H.apply_status_effect(/datum/status_effect/debuff/hereticsermon)
        else
            H.apply_status_effect(/datum/status_effect/buff/sermon)
            H.add_stress(/datum/stressevent/sermon)
