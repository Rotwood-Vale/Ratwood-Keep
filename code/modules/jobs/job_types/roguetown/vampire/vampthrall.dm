/datum/job/roguetown/vampire/vampthrall
	title = "Vampire Thrall"
	flag = VAMPTHRALL
	department_flag = VAMPIRE
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_in_credits = FALSE		//Stops Scom from announcing their arrival.
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/vampire,
	/obj/effect/proc_holder/spell/targeted/shapeshift/bat)
	tutorial = "Outcasted from society and under rule of the Vampire Lord, either as a worshipping fanatic or a victim of circumstance, you are caught in the middle of two Lords. You are a lowly peasant who will choose their path in this world. Do you serve your Lord, or will you try to win over your abusors?"
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/vampthrall
	/* advclass_cat_rolls = list(CTAG_ADVENTURER = 20)
	PQ_boost_divider = 10 */ //Tried to give them adventure roles, but this doesn't work.

	display_order = JDO_VAMPTHRALL
	min_pq = 4
	max_pq = null
	cmode_music = 'sound/music/combat_vamp.ogg'

/datum/outfit/job/roguetown/vampthrall/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/farming, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/rope
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	pants = /obj/item/clothing/under/roguetown/trou
	head = /obj/item/clothing/head/roguetown/armingcap
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/storage/backpack/rogue/backpack/surgery
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	mouth = /obj/item/rogueweapon/huntingknife
	beltr = /obj/item/flint
	ADD_TRAIT(H, TRAIT_FAITHLESS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STRONGBITE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_VAMPMANSION, TRAIT_GENERIC)
	H.change_stat("strength", 1)
	H.change_stat("speed", 2)
	H.change_stat("intelligence", 2)
	/*if(H.mind)
		var/datum/antagonist/vampire/new_antag = new /datum/antagonist/vampirelord/lesser()
		H.mind.add_antag_datum(new_antag) */ //Functional Vampirism

	
/obj/effect/proc_holder/spell/self/convertrole/vampire
	name = "Recruit Ally"
	new_role = "Vampyre Sympathizer"
	recruitment_faction = "Vampire"
	recruitment_message = "Aid our cause, %RECRUIT!"
	accept_message = "For what is right."
	refuse_message = "I refuse."
