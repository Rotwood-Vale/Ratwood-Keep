/datum/job/roguetown/shepherd
	subclass_cat_rolls = list(CTAG_CONFESSOR = 20)
	visuals_only_outfit = /datum/outfit/job/roguetown/shepherd
	outfit = null
	advjob_examine = TRUE // Use subclass name on examine
	foreign_examine = TRUE

/datum/job/roguetown/shepherd/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

// Basic confessor class, no changes.
// Proficient with whips and crossbow.
/datum/subclass/shepherd/confessor
	name = "Confessor"
	tutorial = "After all this time, Inquisition is still waging its endless war against Archnemesis, and you are ready to help it. \
	Innocents may suffer, but it is a small price for safety."
	outfit = /datum/outfit/job/roguetown/shepherd
	category_tags = list(CTAG_CONFESSOR)
	allowed_races = RACES_TOLERATED_UP
	maximum_possible_slots = 2

// Better-armored with gambeson and a de facto full helmet.
// Trades whips and crossbow skills to swords and firearms.
/datum/subclass/shepherd/overseer
	name = "Faith Overseer"
	tutorial = "Militant arm of the Psydonian Church you found yourself part of was established quite recently, but has already become infamous. \
	It is time again to prove your reputation true."
	outfit = /datum/outfit/job/roguetown/shepherd/overseer
	category_tags = list(CTAG_CONFESSOR)
	allowed_races = RACES_TOLERATED_UP
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/shepherd/overseer/pre_equip(mob/living/carbon/human/H)
	..()
	backl = null
	cloak = null
	neck = null
	head = /obj/item/clothing/head/roguetown/helmet/overseer
	belt = /obj/item/storage/belt/rogue/leather/overseer
	shoes = /obj/item/clothing/shoes/roguetown/armor
	pants = /obj/item/clothing/under/roguetown/trou/overseer
	mask = /obj/item/clothing/mask/rogue/overseer
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/overseer
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/overseer
	gloves = /obj/item/clothing/gloves/roguetown/leather/overseer
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/mace/cudgel
	backpack_contents = list(/obj/item/storage/keyring/shepherd = 1, /obj/item/lockpick = 1)
	if(H.mind)
		H.change_stat("speed", -1)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 2, TRUE)

		// Decrease crossbows by 3 levels:
		var/datum/skill/Crossbows = GetSkillRef(/datum/skill/combat/crossbows)
		var current_level = H.mind.get_skill_level(/datum/skill/combat/crossbows)
		var new_level = current_level - 3
		if(new_level < SKILL_LEVEL_NONE)
			new_level = SKILL_LEVEL_NONE
		H.mind.known_skills[Crossbows] = new_level

		// Decrease whips/flails by 3 levels:
		var/datum/skill/WhipsFlails = GetSkillRef(/datum/skill/combat/whipsflails)
		var current_level_w = H.mind.get_skill_level(/datum/skill/combat/whipsflails)
		var new_level_w = current_level_w - 3
		if(new_level_w < SKILL_LEVEL_NONE)
			new_level_w = SKILL_LEVEL_NONE
		H.mind.known_skills[WhipsFlails] = new_level_w