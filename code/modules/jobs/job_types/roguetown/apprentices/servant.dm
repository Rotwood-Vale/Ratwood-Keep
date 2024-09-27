/datum/job/roguetown/servant
	title = "Servant"
	flag = SERVANT
	department_flag = APPRENTICES
	faction = "Station"
	total_positions = 4
	spawn_positions = 4

	allowed_races = list(RACES_ALL_KINDS, /datum/species/seelie,)
	allowed_ages = list(AGE_ADULT)

	tutorial = "Granted a comfortable life in the Lord's manor as one of his servants! You will appreciate it more and more every day as you clean the floors and are beaten for nothing."

	outfit = /datum/outfit/job/roguetown/servant
	display_order = JDO_SERVANT
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/servant/pre_equip(mob/living/carbon/human/H)
	..()

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		backl = /obj/item/storage/backpack/rogue/satchel
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		belt = /obj/item/storage/belt/rogue/leather/rope
		neck = /obj/item/storage/belt/rogue/pouch
		beltr = /obj/item/storage/keyring/servant
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		H.change_stat("perception", 1)
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		neck = /obj/item/storage/belt/rogue/pouch
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/storage/keyring/servant
		H.change_stat("perception", 1)
	if(isseelie(H))
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/seelie_dust)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/summon_rat)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/strip)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/splash)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/roustame)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/animate_object)
