
/datum/antagonist/bandit
	name = "Bandit"
	roundend_category = "bandits"
	antagpanel_category = "Bandit"
	job_rank = ROLE_BANDIT
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "bandit"
	confess_lines = list(
		"FREEDOM!!!", 
		"I WILL NOT LIVE IN YOUR WALLS!",
		"I WILL NOT FOLLOW YOUR RULES!",
	)
	var/tri_amt
	var/contrib

/datum/antagonist/bandit/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/bandit))
		return "<span class='boldnotice'>Another free man. My ally.</span>"

/datum/antagonist/bandit/on_gain()
	owner.special_role = "Bandit"
	owner.assigned_role = "Bandit"
	owner.current.job = null
	forge_objectives()
	. = ..()
	equip_bandit()
	move_to_spawnpoint()
	finalize_bandit()

/datum/antagonist/bandit/proc/finalize_bandit()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/traitor.ogg', 80, FALSE, pressure_affected = FALSE)
	var/mob/living/carbon/human/H = owner.current
	ADD_TRAIT(H, TRAIT_BANDITCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.set_patron(/datum/patron/inhumen/matthios)
	to_chat(H, "<span class='alertsyndie'>I am a BANDIT!</span>")
	to_chat(H, "<span class='warning'>Long ago I did a crime worthy of my bounty being hung on the wall outside of the local inn. I must feed the idol money and valuable metals to satisfy my greed!</span>")

/* /datum/antagonist/bandit/greet()
	to_chat(owner.current, "<span class='alertsyndie'>I am a BANDIT!</span>")
	to_chat(owner.current, "<span class='info'>Long ago I did a crime worthy of my bounty being hung on the wall outside of the local inn. I must feed the idol money and valuable metals to satisfy my greed!</span>")
	owner.announce_objectives()
	..() */ //commenting out until they get a proper objective implementation or whatever.

/datum/antagonist/bandit/proc/forge_objectives()
	return
/*
	if(!(locate(/datum/objective/bandit) in objectives))
		var/datum/objective/bandit/bandit_objective = new
		bandit_objective.owner = owner
		objectives += bandit_objective
	if(!(locate(/datum/objective/escape) in objectives))
		var/datum/objective/escape/boat/escape_objective = new
		escape_objective.owner = owner
		objectives += escape_objective*/

/datum/antagonist/bandit/proc/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.bandit_starts))

/datum/antagonist/bandit/proc/equip_bandit()

	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Bandit"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	var/mob/living/carbon/human/H = owner.current
	if(H.mobid in GLOB.character_list)
		GLOB.character_list[H.mobid] = null
	GLOB.chosen_names -= H.real_name
	if((H.dna.species?.id != "humen"))
		H.age = AGE_ADULT
		H.set_species(/datum/species/human/northern) //setspecies randomizes body
		H.after_creation()
//		H.real_name = H.client.prefs.pref_species.random_name(MALE,1) //set_species randomizes name
	H.cmode_music = 'sound/music/combat_bandit2.ogg'

	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "BANDIT"), 5 SECONDS)
//	H.job = "Bandit"
//	H.advjob = pick("Cheesemaker", "Mercenary", "Barbarian", "Ranger", "Rogue")
	H.equipOutfit(/datum/outfit/job/roguetown/bandit)

	return TRUE

/datum/outfit/job/roguetown/bandit/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)
	mask = /obj/item/clothing/mask/rogue/facemask/steel
	head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	if(prob(40))
		neck = /obj/item/clothing/neck/roguetown/chaincoif
	if(prob(23))
		gloves = /obj/item/clothing/gloves/roguetown/leather
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	else
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		armor = /obj/item/clothing/suit/roguetown/armor/leather
	var/loadoutm = rand(1,16)
	switch(loadoutm)
		if(1 to 3) // sword bandit
			beltr = /obj/item/rogueweapon/sword/iron
			if(prob(40))
				backl = /obj/item/rogueweapon/shield/wood
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.change_stat("endurance", 1)
		if(4 to 6) // knife bandit - dodge maxing
			beltr = /obj/item/rogueweapon/huntingknife/cleaver
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.change_stat("speed", 3)
			H.change_stat("strength", -2)
		if(7 to 9) // flail bandit small chance to two handed flail
			if(prob(80))
				beltr = /obj/item/rogueweapon/flail
				H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			else
				r_hand = /obj/item/rogueweapon/flail/peasantwarflail
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.change_stat("strength", 1)
		if(10 to 12) // crossbow bandit
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltl = /obj/item/quiver/bolts
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.change_stat("perception", 3)
		if(13 to 15) // spear bandit
			r_hand = /obj/item/rogueweapon/spear
			if(prob(40))
				backl = /obj/item/rogueweapon/shield/wood
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.change_stat("endurance", 1)
		if(16) // hedge knight - give challenge to knights/templars ~6% chance 15-20 bandits roundstart average 1 hedge knight - lacks protection to hands or feet
			r_hand = /obj/item/rogueweapon/greatsword/zwei
			beltr = /obj/item/rogueweapon/sword
			beltl = /obj/item/flashlight/flare/torch/lantern
			armor = /obj/item/clothing/suit/roguetown/armor/plate/full
			gloves = /obj/item/clothing/gloves/roguetown/leather
			head = /obj/item/clothing/head/roguetown/helmet/heavy/pigface
			if(prob(30))
				neck = /obj/item/clothing/neck/roguetown/bervor
			else
				neck = /obj/item/clothing/neck/roguetown/gorget
			H.mind.adjust_skillrank(/datum/skill/combat/swords, rand(2,3), TRUE) // either expert or master skill - knights start with master and templars expert sword skill
			H.change_stat("strength", 1)
			H.change_stat("constitution", 1)
			H.change_stat("speed", -2)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.change_stat("strength", 3)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 1)
	H.change_stat("speed", 1)
	H.change_stat("intelligence", -3)

	H.ambushable = FALSE

/datum/antagonist/bandit/roundend_report()
	if(owner?.current)
		var/amt = tri_amt
		var/the_name = owner.name
		if(ishuman(owner.current))
			var/mob/living/carbon/human/H = owner.current
			the_name = H.real_name
		if(!amt)
			to_chat(world, "[the_name] was a bandit.")
		else
			to_chat(world, "[the_name] was a bandit. He stole [amt] triumphs worth of loot.")
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
		to_chat(owner.current, "<span class='greentext'>I've TRIUMPHED!</span>")
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(owner.current, "<span class='redtext'>I've failed to satisfy my greed.</span>")
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

