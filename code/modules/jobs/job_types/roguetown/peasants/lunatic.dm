/datum/job/roguetown/lunatic
	title = "Lunatic"
	flag = LUNATIC
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 50 //shitcode solution until overflow roles are fixed
	spawn_positions = 50

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half Orc",
	)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	outfit = /datum/outfit/job/roguetown/lunatic
	bypass_lastclass = TRUE
	bypass_jobban = FALSE
	min_pq = null //This role is meant to be locked to only those with -50 PQ, then be unrollable once they hit -49 so they can roll Prisoner, don't fuck with this.
	max_pq = -50
	tutorial = "The Lunatic, shunned by society and a magnet for misfortune. Your task is simple yet perilous: survive by any means, though your very existence invites danger from every corner. Seek redemption through kindness and camaraderie; it's your quickest escape from this cursed plight. Tread carefully, for trust is hard-won and easily lost."
	display_order = JDO_LUNATIC

/datum/outfit/job/roguetown/lunatic/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
	armor = /obj/item/clothing/suit/roguetown/shirt/rags
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	pants = /obj/item/clothing/under/roguetown/tights/vagrant
	H.change_stat("strength", -4)
	H.change_stat("intelligence", -4)
	H.change_stat("constitution", -4)
	H.change_stat("endurance", -4)
	H.change_stat("speed", -4)
