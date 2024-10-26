/datum/advclass/towndoctor
	name = "Physician"
	tutorial = "You are the closest thing to a doctor that the townsfolk here will ever meet. Wielding crude tools and accumulated knowledge, you have probably cut into as many people as the average Knight."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/doctor
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	traits_applied = list(TRAIT_EMPATH, TRAIT_NOSTINK)
	cmode_music = 'sound/music/combat_physician.ogg'

/datum/outfit/job/roguetown/adventurer/doctor/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/mask/rogue/spectacles
	neck = /obj/item/clothing/neck/roguetown/psicross/wood
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltr = /obj/item/rogueweapon/huntingknife/idagger
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/storage/fancy/skit = 1, /obj/item/storage/fancy/ifak = 1,)
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
		pants = /obj/item/clothing/under/roguetown/trou
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
		head = /obj/item/clothing/head/roguetown/nightman
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		head = /obj/item/clothing/head/roguetown/armingcap

	ADD_TRAIT(H, TRAIT_STEELHEARTED, "[type]")
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 2, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("fortune", 2)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/docheal)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/stable)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/purge)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/debride)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/cpr)
		

