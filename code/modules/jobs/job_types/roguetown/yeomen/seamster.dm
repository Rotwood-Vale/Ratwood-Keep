/datum/job/roguetown/seamster
	title = "Seamster"
	f_title = "Seamstress"
	flag = SEAMSTER
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_NEARLY_ALL_PLUS_SEELIE
	tutorial = "Вы - швея. Будь то починка кожаных доспехов разбойника, плаща лорда, одежды простых людей и священнослужителей - вы делали все это. \
				За долгие бессонные ночи и в поте лица вы приобрели собственную мастерскую. \
				Что вы теперь будете делать, зависит только от вас, иголки и нитки..."
	outfit = /datum/outfit/job/roguetown/seamster
	display_order = JDO_SEAMSTER
	selection_color = JCOLOR_MERCENARY
	give_bank_account = 2
	max_pq = null

/datum/outfit/job/roguetown/seamster/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/white
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	beltr = /obj/item/rogueweapon/huntingknife/scissors
	beltl = /obj/item/key/seamster
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/needle = 1)
	if(H.gender == MALE) // We're givign males male specific clothes so they don't walk around in a dress
		belt = /obj/item/storage/belt/rogue/leather/cloth
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	else
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		armor = /obj/item/clothing/suit/roguetown/armor/armordress
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("speed", 2)
		H.change_stat("perception", 1)
		H.change_stat("strength", -1)
		if(isseelie(H))
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/summon_berry)
