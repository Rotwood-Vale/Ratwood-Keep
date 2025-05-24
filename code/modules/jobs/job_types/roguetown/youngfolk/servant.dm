/datum/job/roguetown/servant
	title = "Servant"
	f_title = "Maid"
	flag = SERVANT
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 6
	spawn_positions = 6

	allowed_races = RACES_SHUNNED_UP_PLUS_SEELIE
	allowed_ages = ALL_AGES_LIST
	subclass_cat_rolls = list(CTAG_SERVANT = 20)

	tutorial = "Granted a life of comfortable servitute in the Duke's manor, you follow the Head Butler/Maid's commands and spend your day performing necessary but menial tasks."
	seelie_tutorial = "Though once you were a mischievous fae, you've now accepted the comfort and security of service in the manor instead. Your spells may come in handy, but you've allowed the more chaotic ones to fade to memory."

	outfit = /datum/outfit/job/roguetown/servant
	display_order = JDO_SERVANT
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/job/roguetown/servant/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/outfit/job/roguetown/servant/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(H.gender == FEMALE)
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/black
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		cloak = /obj/item/clothing/cloak/apron/waist
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backr = /obj/item/storage/backpack/rogue/satchel

/datum/subclass/servant/groundkeeper
	name = "Groundkeeper"
	tutorial = "Cleaning, repairs, chores... The manor must always look great and presentable for the unexpected guests. \
	It is within your responsibility to make sure the keep stays in decent condition."
	outfit = /datum/outfit/job/roguetown/servant/groundkeeper
	category_tags = list(CTAG_SERVANT)
	allowed_races = RACES_SHUNNED_UP_PLUS_SEELIE
	maximum_possible_slots = 3

/datum/outfit/job/roguetown/servant/groundkeeper/pre_equip(mob/living/carbon/human/H)
	backpack_contents = list(/obj/item/needle = 1, /obj/item/soap = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		if(H.gender == MALE)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
		if(H.gender == FEMALE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		if(!isseelie(H))
			H.change_stat("strength", -1)
			H.change_stat("constitution", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("speed", 1)
		else
			H.mind.AddSpell(new SPELL_SPLASH)	//Splash now waters crops AND cleans blood, in a 3x3 area but only IF the water bolt hits something
			H.mind.AddSpell(new SPELL_SUMMON_RAT)			//Good for meat for cooking
			H.mind.AddSpell(new SPELL_ROUSTAME)			//Good for meat for cooking
			H.mind.AddSpell(new SPELL_REPLENISH)			//Replenish was a cut spell now being added for Seelie maids, will replenish EMPTY bushes with more berries
			H.mind.AddSpell(new SPELL_SATE_CROP)			//Different from Dendor spell, will satisfy crop hunger but not bless it

/datum/subclass/servant/chef
	name = "Chef"
	tutorial = "You are Their Lordship's favorite cook. Your task is simple: prepare feasts, feed the nobles and the retinue. \
	Why wouldnt you brew a barrel full of wine or something else as well? And remember... Do NOT put bad berries into your meals."
	outfit = /datum/outfit/job/roguetown/servant/chef
	category_tags = list(CTAG_SERVANT)
	allowed_races = RACES_SHUNNED_UP_PLUS_SEELIE
	maximum_possible_slots = 3

/datum/outfit/job/roguetown/servant/chef/pre_equip(mob/living/carbon/human/H)
	..()
	backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		if(!isseelie(H))
			H.change_stat("strength", -1)
			H.change_stat("constitution", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("speed", 1)
		else
			H.mind.AddSpell(new SPELL_SPLASH)
			H.mind.AddSpell(new SPELL_SUMMON_RAT)
			H.mind.AddSpell(new SPELL_ROUSTAME)
			H.mind.AddSpell(new SPELL_REPLENISH)
			H.mind.AddSpell(new SPELL_SATE_CROP)
	ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)

/datum/subclass/servant/bankrupt
	name = "Bankrupt Aristocrat"
	tutorial = "You were born into low nobility, but unfortunately for you your family has gone bankrupt. \
	The crown of Rockhill agreed to pay your debts off in return for your service, but you didnt expect them to make you a literal servant. \
	Now you must find your way back into the high society, as well as hide your shame of lowlife work."
	outfit = /datum/outfit/job/roguetown/servant/bankrupt
	category_tags = list(CTAG_SERVANT)
	allowed_races = RACES_TOLERATED_UP
	maximum_possible_slots = 1

/datum/outfit/job/roguetown/servant/bankrupt/pre_equip(mob/living/carbon/human/H)
	..()
	id = /obj/item/clothing/ring/silver
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", -1)
		H.change_stat("intelligence", 2)
		H.change_stat("perception", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
