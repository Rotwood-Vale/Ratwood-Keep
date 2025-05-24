/datum/subclass/sawbones // clergy class but they are EVIL
	name = "Defrocked"
	tutorial = "The TEN have lied to you! You have sought Matthios' refuge after your theological debates with your fellow clergy had gotten you chased out by the Inquisition."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/bandit/sawbones
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/combat_bandit2.ogg'
	maximum_possible_slots = 1
	
/datum/outfit/job/roguetown/adventurer/pirate
	allowed_patrons =  list(/datum/patron/inhumen/matthios)

/datum/outfit/job/roguetown/bandit/sawbones/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/mask/rogue/facemask/steel
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/hierophant // stolen monk robes
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/huntingknife/cleaver /// proper self defense an tree aquiring
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/rogueweapon/surgery/hemostat/improv = 1, /obj/item/rogueweapon/surgery/retractor/improv = 1, /obj/item/rogueweapon/surgery/saw/improv = 1, /obj/item/reagent_containers/glass/alembic = 1,)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE) //needed for getting into hideout
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE) //while treatment is useful, bandits are very mobile and surgical healing is not
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC) // Vital for any surgical role dealing in potentially decaying bodies.
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_WANTED, TRAIT_GENERIC)
	H.change_stat("strength", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 1)
	H.change_stat("fortune", 1)
	if(H.age == AGE_OLD)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_heretic(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	H.ambushable = FALSE
