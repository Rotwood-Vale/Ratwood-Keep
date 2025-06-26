/datum/job/roguetown/prisonert
	title = "Prisoner (Tribe)"
	flag = PRISONERT
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 4

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/aasimar, /datum/species/axian, /datum/species/demihuman, /datum/species/dwarf, /datum/species/elf, /datum/species.human, /datum/species/lizardfolk, /datum/species/lupian, /datum/species/moth, /datum/species/vulpkanin, /datum/species/tabaxi, /datum/species/seelie, /datum/species/anthromorph, /datum/species/tieberian, /datum/species/human/halfelf)
	tutorial = "How does it feel to be the rat in the cage? You're alone and at the mercy of your captors, kept around as a hostage. You spend your days waiting for the oft chance someone comes to this accursed island to rescue you. Might as well start praying to whatever god you find solace in."
	seelie_tutorial = "Thrown in this accursed place, the collar around your neck prevents any and all magic you might've had. You waste away here, no mischief to be made or people to assist. Your life as a caged fae is miserable indeed."

	outfit = /datum/outfit/job/roguetown/prisonert
	banned_leprosy = FALSE
	display_order = JDO_PRISONERT
	give_bank_account = 10
	min_pq = -14
	max_pq = null
	can_random = FALSE
	allowed_maps = list("Build Your Settlement")

	cmode_music = 'sound/music/combat_bum.ogg'

/datum/outfit/job/roguetown/prisonert/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/collar/leather/cursed
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("fortune", 2)
		var/datum/antagonist/new_antag = new /datum/antagonist/prisoner()
		H.mind.add_antag_datum(new_antag)
	if(H.gender == FEMALE)
		H.change_stat("strength", -1)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
	if(H.gender == MALE)
		H.change_stat("strength", -1)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/random

