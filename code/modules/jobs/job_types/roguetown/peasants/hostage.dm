/datum/job/roguetown/hostage
	title = "Hostage"
	flag = HOSTAGE
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 2

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	tutorial = "Вы слишком ценны, чтобы вас убивать, но при этом не свободны. \
	Вы либо очень сильно облажались, либо вам очень не повезло. \
	В любом случае герцог или герцогиня держит вас в заложниках до тех пор, пока ваша родина не заплатит за вас выкуп, как будто это когда-нибудь случится. \
	С таким же успехом можно начать молиться любому богу, в котором вы находите утешение."

	outfit = /datum/outfit/job/roguetown/hostage
	banned_leprosy = FALSE
	display_order = JDO_HOSTAGE
	give_bank_account = 10
	min_pq = -14
	max_pq = null
	can_random = FALSE

/datum/outfit/job/roguetown/hostage/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/collar/leather/cursed
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	id = /obj/item/clothing/ring/gold
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("fortune", 2)
		var/datum/antagonist/new_antag = new /datum/antagonist/prisoner()
		H.mind.add_antag_datum(new_antag)
	ADD_TRAIT(H, TRAIT_BANDITCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	if(H.gender == FEMALE)
		H.change_stat("strength", -1)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
		head = /obj/item/clothing/head/roguetown/hatblu
	if(H.gender == MALE)
		H.change_stat("strength", -1)
		pants = /obj/item/clothing/under/roguetown/tights/purple
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/blue
		head = /obj/item/clothing/head/roguetown/fancyhat
