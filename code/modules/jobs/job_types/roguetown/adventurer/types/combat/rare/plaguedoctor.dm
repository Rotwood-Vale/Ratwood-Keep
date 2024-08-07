/datum/advclass/towndoctor
	name = "Plague Doctor"
		tutorial = "You're a Doctor from another land \
		Healing soldiers on the front lines you turned your attention to \
		villages soaked in sickness and grief. Despite being a healer, you've \
		sometimes has found brigands and rogues much more deadly than festering \
		sickness, forcing you to explosive violence."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	pickprob = 11
	outfit = /datum/outfit/job/roguetown/adventurer/doctor
	category_tags = list(CTAG_ADVENTURER)
	
	traits_applied = list(TRAIT_EMPATH, TRAIT_NOSTINK, TRAIT_ROT_EATER, TRAIT_MEDIUMARMOR, TRAIT_STEELHEARTED) // , TRAIT_DODGEEXPERT) leaving dodge expert off for now, add in for balance later
	cmode_music = 'sound/music/combat_physician.ogg'

/datum/outfit/job/roguetown/adventurer/doctor
	allowed_patrons = list(/datum/patron/divine/pestra, /datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/adventurer/doctor/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/mask/rogue/physician //hopefully the physician doesn't accuse them of stealing it
	neck = /obj/item/clothing/neck/roguetown/psicross/wood
	belt = /obj/item/storage/belt/rogue/leather 
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid 
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel //for when a scalpel fails
	gloves = /obj/item/clothing/gloves/roguetown/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather/mourning
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1, //a quick way to heal
		/datum/crafting_recipe/roguetown/alchemy/bbomb = 2, //advanced self defense
		/obj/item/rogueweapon/surgery/scalpel = 1,
		/obj/item/rogueweapon/surgery/saw = 1,
		/obj/item/rogueweapon/surgery/hemostat = 2,
		/obj/item/rogueweapon/surgery/retractor = 1,
		/obj/item/rogueweapon/surgery/bonesetter = 1,
		/obj/item/rogueweapon/surgery/cautery = 1,
		/obj/item/natural/worms/leech/cheele = 1, //your poison sucking friend
		/obj/item/needle = 1,
		/obj/item/natural/cloth = 2,
	)
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/armor/leather //to protect them in the wild
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
		head = /obj/item/clothing/head/roguetown/nightman
	else
		armor = /obj/item/clothing/suit/roguetown/armor/leather //to protect them in the wild
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		head = /obj/item/clothing/head/roguetown/armingcap

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(5,6), TRUE) //student of medicine in and out of the classroom
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, pick(3,4,5), TRUE) //long time student of alchemy
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("fortune", 1)
		H.change_stat("endurance", 1)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)