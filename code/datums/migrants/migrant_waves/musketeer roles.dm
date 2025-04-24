/datum/migrant_role/musketeer/musketeer
	name = "Musketeer"
	greet_text = "A merry musketman seeking to save the girl and the day! Don't lose sight of your two companions, you're inseperable!"
	outfit = /datum/outfit/job/roguetown/musketeer/musketeer
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE

/datum/outfit/job/roguetown/musketeer/musketeer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/tricorn
	shoes = /obj/item/clothing/shoes/roguetown/armor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	if(prob(15))
		gloves = /obj/item/clothing/gloves/roguetown/leather/angle
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/cloak/tabard/musketeer
	backl = /obj/item/storage/backpack/rogue/satchel/musketeer
	backr = /obj/item/gun/ballistic/firearm/arquebus
	beltr = /obj/item/rogueweapon/sword/rapier
	beltl = /obj/item/ammo_holder/bullet/lead
	backpack_contents = list(/obj/item/flashlight/flare/torch = 1, /obj/item/flint = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("intelligence", pick(0,1,1))
		H.change_stat("speed", 2)
		H.change_stat("endurance", 1)
		H.change_stat("perception", 3)
		H.cmode_music = 'sound/music/combat_duelist.ogg'

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
