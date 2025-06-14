/datum/job/roguetown/hospitaller
	title = "Hospitaller"
	f_title = "Hospitaller"
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_patrons = ALL_ACOLYTE_PATRONS
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/hospitaller
	tutorial = "As an follower of Pestra, you have joined the Hospitallers, an order dedicated to counter the rot plague and treating the living. Your patron claims dominion over Decay, Disease and Medicine. With the Rot plague growing its up to you to help those stricken."

	display_order = JDO_HOSPITALLER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/hospitaller
	name = "Hospitaller"
	jobtype = /datum/job/roguetown/hospitaller
	allowed_patrons = list(/datum/patron/divine/pestra)

/datum/outfit/job/roguetown/hospitaller/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood/bloodred
	neck = /obj/item/clothing/neck/roguetown/psicross/pestra
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	gloves = /obj/item/clothing/gloves/roguetown/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/key/church
	cloak = /obj/item/clothing/cloak/tabard/crusader/pestra
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/woodstaff
	backpack_contents = list(/obj/item/clothing/mask/rogue/pestra, /obj/item/needle/pestra, /obj/item/natural/worms/leech/cheele, /obj/item/reagent_containers/lux, /obj/item/ritualfeather = 1 )
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)	//average wrestling, for wrestling down deadites
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)	//More treatment then acolytes
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)		// in between templar and acolyte for holy skill
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)	//below bog guard level of polearm skill
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat("strength", -1)		//too busy healing to get reps.
		H.change_stat("perception", 2)      //doctor's precision
		H.change_stat("intelligence", 2)	//physician smarts
		H.change_stat("endurance", 2)		//divine miracle take their toll
		ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/job/roguetown/hospitaller/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/title = "Brother"
		if(H.gender == FEMALE)
			title = "Sister"
		H.real_name = "[title] [prev_real_name]"
		H.name = "[title] [prev_name]"
