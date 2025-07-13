/datum/job/roguetown/stowaway
	title = "Stowaway"
	flag = STOWAWAY
	department_flag = PEASANTS
	faction = "Station"
	total_positions = -1
	spawn_positions = -1

	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_ages = ALL_AGES_LIST
	outfit = /datum/outfit/job/roguetown/stowaway
	bypass_lastclass = TRUE
	banned_leprosy = FALSE
	min_pq = -30
	max_pq = null
	tutorial = "You are a stowaway on the Duchy's vessel, hidden away among the filth and forgotten cargo. The glances of disgust and suspicion from others will be part of your daily routine now, but you endure them for a chance at a new life. You're bound for a destination where you hope to finally find your place in the world, even if nobody else wants you there. In the darkness of your hiding spot, you managed to find something useful, learning to use it on the journey here; it might not be much, but it's more than what you had."
	display_order = JDO_STOWAWAY
	show_in_credits = FALSE
	can_random = FALSE
	allowed_maps = list("Build Your Settlement")
	cmode_music = 'sound/music/combat_bum.ogg'


/datum/job/roguetown/stowaway/New()
	. = ..()
	peopleknowme = list()

/datum/outfit/job/roguetown/stowaway/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += "bums"
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NASTY_EATER, TRAIT_GENERIC)
	belt = /obj/item/storage/belt/rogue/leather/rope
	if(prob(20))
		head = /obj/item/clothing/head/roguetown/knitcap
	else
		head = null

	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
	else
		armor = null
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, rand(1,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, rand(1,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, rand(1,5), TRUE)
		H.STALUC = rand(1, 20)
	// What did they find...?
		var/find = rand(1,5)
		switch(find)
			if(1)
				beltl = /obj/item/rogueweapon/sword/long/marlin
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.change_stat("strength", 4)
			if(2)
				r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
				beltl = /obj/item/ammo_holder/quiver/bolts
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.change_stat("perception", 2)
			if(3)
				r_hand = /obj/item/rogueweapon/huntingknife/idagger/silver
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
				H.change_stat("speed", 3)
			if(4)
				var/list/spells = list(SPELL_FIREBALL, SPELL_FINDFAMILIAR, SPELL_ARCANEBOLT)
				var/spelltype = pick(spells)
				H.mind.AddSpell(new spelltype)
				H.change_stat("intelligence", 4)
			if(5)
				beltl = /obj/item/storage/fancy/skit
				H.change_stat("intelligence", 4)
				H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.change_stat("strength", -1)
	H.change_stat("intelligence", -4)
	H.change_stat("constitution", -3)
	H.change_stat("endurance", -3)

