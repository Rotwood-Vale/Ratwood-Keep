/datum/job/roguetown/wapprentice
	title = "Magicians Apprentice"
	flag = MAGEAPPRENTICE
	department_flag = APPRENTICES
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_ALL_KINDSPLUS
	allowed_ages = list(AGE_ADULT)

	tutorial = "Your master once saw potential in you, something you are uncertain if they still do with your recent studies. The path to using magic is something treacherous and untamed, and you are still decades away from calling yourself even a journeyman in the field. Listen and serve, and someday you will earn your hat."

	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation, /obj/effect/proc_holder/spell/invoked/projectile/fetch, /obj/effect/proc_holder/spell/invoked/projectile/spitfire)
	outfit = /datum/outfit/job/roguetown/wapprentice
	
	display_order = JDO_MAGEAPPRENTICE
	give_bank_account = TRUE

	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/wapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
		H.mind.adjust_spellpoints(1)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/roguekey/tower
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		backr = /obj/item/storage/backpack/rogue/satchel
	else
		pants = /obj/item/clothing/under/roguetown/tights/random
		shoes = /obj/item/clothing/shoes/roguetown/sandals
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/roguekey/tower
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		backr = /obj/item/storage/backpack/rogue/satchel

	H.change_stat("intelligence", 2)
	H.change_stat("speed", -1)
	if(isseelie(H))
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/seelie_dust)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/summon_rat)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/strip)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/seelie_kiss)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/splash)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/roustame)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/animate_object)

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
