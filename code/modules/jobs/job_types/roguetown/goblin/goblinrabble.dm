/datum/job/roguetown/goblinrabble
	title = "Goblin Rabble"
	flag = GOBLINRABBLE
	department_flag = GOBLIN
	faction = "Station"
	total_positions = 6
	spawn_positions = 6
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp)
	allowed_patrons = list(/datum/patron/inhumen/graggar)
	tutorial = "You're the lowest of the low. A goblin among many other goblins. \
	There's little to say about you, aside from your Chief deeming you less than fit for service. \
	For now, you're locked out of the main fort. See if you can change that by finding something shiny."
	outfit = /datum/outfit/job/roguetown/goblinrabble
	display_order = JDO_GOBLINRABBLE
	min_pq = 1
	max_pq = null
	always_show_on_latechoices = TRUE

/datum/outfit/job/roguetown/goblinrabble/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/goblin
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	l_hand = /obj/item/rogueweapon/huntingknife/stoneknife
	belt = /obj/item/storage/belt/rogue/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/keyring/goblin = 1)
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, round(rand(1,5)), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, round(rand(1,5)), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.change_stat("fortune", 2)
