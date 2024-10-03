/datum/job/roguetown/magician
	title = "Court Magician"
	flag = WIZARD
	department_flag = COURTIERS
	selection_color = JCOLOR_COURTIER
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation, /obj/effect/proc_holder/spell/invoked/projectile/fetch, /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt, /obj/effect/proc_holder/spell/invoked/projectile/fireball, /obj/effect/proc_holder/spell/invoked/projectile/fireball/greater)
	display_order = JDO_MAGICIAN
	tutorial = "Your creed is one dedicated to the conquering of the arcane arts and the constant thrill of knowledge. \
		You owe your life to the Lord, for it was his coin that allowed you to continue your studies in these dark times. \
		In return, you have proven time and time again as justicar and trusted advisor to their reign."
	outfit = /datum/outfit/job/roguetown/magician
	whitelist_req = TRUE
	give_bank_account = 47
	min_pq = 2
	max_pq = null

/datum/outfit/job/roguetown/magician

/datum/outfit/job/roguetown/magician/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/talkstone
	cloak = /obj/item/clothing/cloak/black_cloak
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/storage/keyring/mage
	id = /obj/item/clothing/ring/gold
	r_hand = /obj/item/rogueweapon/woodstaff
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/slimepotion/lovepotion,/obj/item/reagent_containers/glass/bottle/rogue/poison,/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	ADD_TRAIT(H, TRAIT_SEEPRICES, "[type]")
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("intelligence", 4)
		H.mind.adjust_spellpoints(3)
	if(H.age == AGE_OLD)
		if(H.mind)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.mind.adjust_spellpoints(1)
		belt = /obj/item/storage/belt/rogue/leather/plaquegold
		cloak = null
		head = /obj/item/clothing/head/roguetown/wizhat
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/wizard
		if(ishumannorthern(H))
			H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
	switch(H.patron?.type)
		if(/datum/patron/divine/pestra)
			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		else if(/datum/patron/divine/ravox || /datum/patron/inhumen/graggar) //raises the pick(1,2) weapon skills to 2 if they weren't there already
			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, max((2 - H.mind.get_skill_level(/datum/skill/combat/knives)), 0), TRUE) //basically, (2 - current skill) is added to the total skill value.   
				H.mind.adjust_skillrank(/datum/skill/combat/swords, max((2 - H.mind.get_skill_level(/datum/skill/combat/swords)), 0), TRUE)
		else
			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)

	// TODO: GLOBAL LISTS OF SPELLS, THIS IS PAINFUL
	// THIS IS WHERE SPELL SELECTION HAPPENS AT ROUND START
	var/list/combat_spells = list(/obj/effect/proc_holder/spell/invoked/projectile/fireball,/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt,/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e,/obj/effect/proc_holder/spell/invoked/projectile/fetch,/obj/effect/proc_holder/spell/invoked/projectile/spitfire,/obj/effect/proc_holder/spell/invoked/projectile/firebolt5e,/obj/effect/proc_holder/spell/invoked/projectile/rayoffrost5e,/obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e,/obj/effect/proc_holder/spell/invoked/blade_burst,/obj/effect/proc_holder/spell/invoked/frostbite5e,/obj/effect/proc_holder/spell/invoked/poisonspray5e,/obj/effect/proc_holder/spell/invoked/arcyne_storm,/obj/effect/proc_holder/spell/invoked/chilltouch5e,/obj/effect/proc_holder/spell/invoked/infestation5e,/obj/effect/proc_holder/spell/invoked/mindsliver5e,/obj/effect/proc_holder/spell/targeted/lightninglure5e,/obj/effect/proc_holder/spell/invoked/greenflameblade5e,)
	var/list/defense_spells = list(/obj/effect/proc_holder/spell/invoked/forcewall_weak,/obj/effect/proc_holder/spell/self/bladeward5e,)
	var/list/utility_spells = list(/obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe,/obj/effect/proc_holder/spell/invoked/message,/obj/effect/proc_holder/spell/invoked/push_spell,/obj/effect/proc_holder/spell/invoked/longjump,/obj/effect/proc_holder/spell/aoe_turf/conjure/Wolf,/obj/effect/proc_holder/spell/targeted/guidance5e,/obj/effect/proc_holder/spell/targeted/encodethoughts5e,/obj/effect/proc_holder/spell/invoked/magicstone5e,/obj/effect/proc_holder/spell/invoked/mending5e,/obj/effect/proc_holder/spell/self/light5e,/obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e,)
	
	var/categories = list("Combat", "Defense", "Utility", "End Spell Selection (You will lose all points not spent)")
	
	while(H.mind.used_spell_points < H.mind.spell_points)
		var/magichoice = input("Choose your spells", "Available categories") as anything in categories
		switch(magichoice)
			if("Combat")
				choose_magic(combat_spells,H)

			if("Defense")
				choose_magic(defense_spells,H)

			if("Utility")
				choose_magic(utility_spells,H)
					
			if("End Spell Selection (You will lose all points not spent)") // In case someone doesn't want to spend every point they have and plays a gimped mage, for whatever reason
				H.mind.spell_points = H.mind.used_spell_points
	
	H.verbs += list(/mob/living/carbon/human/proc/magicreport, /mob/living/carbon/human/proc/magiclearn)
	

	
		
	
	
