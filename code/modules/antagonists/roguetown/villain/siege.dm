/datum/antagonist/siege
	name = "Siege"
	roundend_category = "siege"
	antagpanel_category = "Siege"
	job_rank = ROLE_SIEGE
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "sieger"
	confess_lines = list(
		"FOR THE BARON!!!",
		"WE WILL RULE THIS LAND!",
		"NO MERCY FOR THE BARONS ENEMIES!",
	)
	var/tri_amt
	var/contrib

/datum/antagonist/siege/examine_friendorfoe(datum/antagonist/examined_datum, mob/examiner, mob/examined)
	if(istype(examined_datum, /datum/antagonist/siege))
		return span_boldnotice("Another of the barons men. My ally.")

/datum/antagonist/siege/on_gain()
	owner.special_role = "Sieger"
	owner.assigned_role = "Sieger"
	owner.current.job = null
	forge_objectives()
	. = ..()
	equip_siege()
	move_to_spawnpoint()
	finalize_siege()

/datum/antagonist/siege/proc/finalize_siege()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/traitor.ogg', 80, FALSE, pressure_affected = FALSE)
	var/mob/living/carbon/human/H = owner.current
	ADD_TRAIT(H, TRAIT_SIEGECAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_TOLERANT, TRAIT_GENERIC)
	to_chat(H, span_alertsyndie("I live to serve the baron!"))
	to_chat(H, span_boldwarning("Our beloved baron has come to claim this land, I must see to it he succeeds!"))

/datum/antagonist/siege/proc/forge_objectives()
	return

/datum/antagonist/siege/proc/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.siege_starts))

/datum/antagonist/siege/proc/equip_siege()

	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Sieger"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	var/mob/living/carbon/human/H = owner.current
	H.cmode_music = 'sound/music/combat_bandit2.ogg'

	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "SIEGE"), 5 SECONDS)
	H.equipOutfit(/datum/outfit/job/roguetown/siege)

	return TRUE

/datum/outfit/job/roguetown/siege/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	cloak = /obj/item/clothing/cloak/tabard/barontabard
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)
	neck = /obj/item/clothing/neck/roguetown/coif
	head = /obj/item/clothing/head/roguetown/armingcap
	if(prob(40))
		neck = /obj/item/clothing/neck/roguetown/chaincoif
	if(prob(23))
		gloves = /obj/item/clothing/gloves/roguetown/leather
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	else
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	var/static/hedge_knight_picked = FALSE
	var/loadoutm

	if(!hedge_knight_picked)
		loadoutm = 16
			hedge_knight_picked = TRUE
	else
		loadoutm = rand(1, 15)

	switch(loadoutm)
		if(1 to 7) // sword soldier
			beltr = /obj/item/rogueweapon/sword/iron
			if(prob(40))
				backl = /obj/item/rogueweapon/shield/wood
			H.change_stat("endurance", 1)
		if(7 to 10) // ranged soldier
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			beltl = /obj/item/quiver/arrows
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			H.change_stat("perception", 3)
		if(10 to 15) // spear soldier
			r_hand = /obj/item/rogueweapon/spear
			if(prob(40))
				backl = /obj/item/rogueweapon/shield/wood
			H.change_stat("endurance", 1)
		if(16) // baron
			r_hand = /obj/item/rogueweapon/greatsword/zwei
			beltr = /obj/item/rogueweapon/sword
			beltl = /obj/item/flashlight/flare/torch/lantern
			pants = /obj/item/clothing/under/roguetown/platelegs
			neck = /obj/item/clothing/neck/roguetown/bervor
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			armor = /obj/item/clothing/suit/roguetown/armor/plate/full
			gloves = /obj/item/clothing/gloves/roguetown/plate
			head = /obj/item/clothing/head/roguetown/helmet/heavy/pigface
			cloak = /obj/item/clothing/cloak/baron_cloak
			H.mind.adjust_skillrank(/datum/skill/combat/swords, rand(5,6), TRUE)
			H.change_stat("strength", 3)
			H.change_stat("constitution", 3)
			H.change_stat("intelligence", 3)
			H.change_stat("endurance", 3)
			H.change_stat("speed", -1)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("intelligence", -1)

	H.ambushable = FALSE

/datum/objective/siege
	name = "Siege"
	explanation_text = "Put the baron on the throne and rule rockhill."
	team_explanation_text = "Put the baron on the throne and rule rockhill."

/datum/antagonist/siege/roundend_report()
	if(owner?.current)
		var/amt = tri_amt
		var/the_name = owner.name
		if(ishuman(owner.current))
			var/mob/living/carbon/human/H = owner.current
			the_name = H.real_name
		if(!amt)
			to_chat(world, "[the_name] was a sieger.")
		else
			to_chat(world, "[the_name] was a sieger. He stole [amt] triumphs worth of loot.")
	return

	var/traitorwin = TRUE

	var/count = 0
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(!objective.check_completion())
				traitorwin = FALSE
			count += objective.triumph_count

	if(!count)
		count = 1

	if(traitorwin)
		owner.adjust_triumphs(count)
		to_chat(owner.current, span_greentext("I've TRIUMPHED!"))
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(owner.current, span_redtext("I've failed to satisfy my greed."))
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)
