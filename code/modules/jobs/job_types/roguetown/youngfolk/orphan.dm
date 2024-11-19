/datum/job/roguetown/orphan
	title = "Vagabond"
	flag = ORPHAN
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 12
	spawn_positions = 12

	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_ages = list(AGE_ADULT)

	tutorial = "Dozens of people end up down on their luck in the kingdom of Psydonia every day. They sometimes make something of themselves but much more often die in the streets."

	outfit = /datum/outfit/job/roguetown/orphan
	display_order = JDO_ORPHAN
	show_in_credits = FALSE
	min_pq = -30
	max_pq = null

	banned_leprosy = FALSE

	cmode_music = 'sound/music/combat_bum.ogg'

/datum/job/roguetown/orphan/New()
	. = ..()
	peopleknowme = list()

/datum/outfit/job/roguetown/orphan/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += "bums"
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
	else
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l
	if(prob(33))
		cloak = /obj/item/clothing/cloak/half/brown
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, round(rand(2,5)), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, round(rand(1,3)), TRUE)
		H.STALUC = rand(1, 20)
	if(prob(10))
		r_hand = /obj/item/rogue/instrument/flute
	H.change_stat("intelligence", round(rand(-4,4)))
	H.change_stat("constitution", -1)
	H.change_stat("endurance", -1)
