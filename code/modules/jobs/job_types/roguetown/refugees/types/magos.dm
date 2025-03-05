/datum/subclass/magos
	name = "Magos"
	tutorial = "Trained in the arcane or occult arts, you have fled from the rot looking for a place to continue your studies."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)

	outfit = /datum/outfit/job/roguetown/refugee/magos

/datum/outfit/job/roguetown/refugee/magos
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/magos/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Battle Magos", "Arcanist","Sorcerer", "Occultist", "Traveling Magos", "Sorcerer")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Battle Magos")	//sword mage. Starts with enough points for 1 combat spell. Has a lesser level book, is novice at reading and arcane.
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
			backr = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger,  /obj/item/book/granter/spellbook/apprentice = 1)
			gloves = /obj/item/clothing/gloves/roguetown/leather
			cloak = /obj/item/clothing/cloak/raincloak/blue
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/newmage/warlock
			shoes = /obj/item/clothing/shoes/roguetown/armor
			beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/sword/sabre
			head = /obj/item/clothing/head/roguetown/helmet/leather
			H.mind.adjust_spellpoints(2)
			H.change_stat("intelligence", 2)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)
			H.mind.AddSpell(new SPELL_LEARNSPELL)
			H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			if(istype(H.dna.species, /datum/species/dwarf) || istype(H.dna.species,/datum/species/anthromorphsmall)|| istype(H.dna.species, /datum/species/kobold))
				shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail

		if("Arcanist")	//slower casting roll, has better learning stats, and a better book.
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			head = /obj/item/clothing/head/roguetown/roguehood/mage
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/newmage/adept
			belt = /obj/item/storage/belt/rogue/leather/rope
			backpack_contents = list( /obj/item/book/granter/spellbook/adept = 1,/obj/item/chalk = 1)
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			r_hand = /obj/item/rogueweapon/woodstaff
			H.mind.adjust_spellpoints(3)
			H.change_stat("strength", -2)
			H.change_stat("intelligence", 2)
			H.change_stat("constitution", -2)
			H.change_stat("endurance", -1)
			H.mind.AddSpell(new SPELL_LEARNSPELL)
			H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
			H.set_patron(/datum/patron/divine/noc)
			if(istype(H.dna.species, /datum/species/dwarf) || istype(H.dna.species,/datum/species/anthromorphsmall)|| istype(H.dna.species, /datum/species/kobold))
				shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage

		if("Sorcerer")		//Faster casting roll, better arcana. Starts with more spell points. Has terrible learning stats, and a bad book. No chalk.
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane,3, TRUE)
			head = /obj/item/clothing/head/roguetown/roguehood/mage
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			belt = /obj/item/storage/belt/rogue/leather/rope
			backpack_contents = list(/obj/item/book/granter/spellbook/mid = 1 )
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			r_hand = /obj/item/rogueweapon/woodstaff
			H.mind.adjust_spellpoints(5)
			H.change_stat("strength", -2)
			H.change_stat("intelligence", 2)
			H.change_stat("constitution", -2)
			H.change_stat("endurance", -1)
			H.mind.AddSpell(new SPELL_LEARNSPELL)
			H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
			H.set_patron(/datum/patron/divine/noc)
			if(istype(H.dna.species, /datum/species/dwarf) || istype(H.dna.species,/datum/species/anthromorphsmall)|| istype(H.dna.species, /datum/species/kobold))
				shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage

		if("Occultist")
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
			H.mind.AddSpell(new SPELL_STRENGTHEN_UNDEAD)
			H.mind.AddSpell(new SPELL_SICKNESS)
			H.mind.AddSpell(new SPELL_EYEBITE)
			H.mind.AddSpell(new SPELL_RAISE_UNDEAD_LESSER)
			H.mind.AddSpell(new SPELL_REVOKE_UNLIFE)
			head = /obj/item/clothing/head/roguetown/necromhood
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/necromancer
			belt = /obj/item/storage/belt/rogue/leather/rope
			backpack_contents = list(/obj/item/chalk = 1)
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			beltl = /obj/item/rogueweapon/huntingknife
			r_hand = /obj/item/rogueweapon/woodstaff
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 3)
			H.change_stat("constitution", -2)
			H.change_stat("endurance", -1)
			H.change_stat("speed", -1)
			H.mind.adjust_spellpoints(-3) //no starting spellpoints, but they can make a spellbook to get some.
			H.mind.AddSpell(new SPELL_LEARNSPELL)
			H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
			H.set_patron(/datum/patron/zizo)
			H.faction += "undead"

		if("Traveling Magos")
			head = /obj/item/clothing/head/roguetown/roguehood/mage
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			r_hand = /obj/item/rogueweapon/woodstaff
			to_chat(H, span_warning("Magic is often times refered to as an art. At times it is treated as a primordial beast, chaos incarnate. To more learned men it is a precise science, to be studied and examined. In the end, magic is all three of the above. It is Art, Chaos, and Science: a blessing, a curse, and progress. It all depends on who calls upon it, and for what purpose."))
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(0,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(0,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(0,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
			if(H.age == AGE_OLD)
				head = /obj/item/clothing/head/roguetown/wizhat/gen
				armor = /obj/item/clothing/suit/roguetown/shirt/robe
				H.change_stat("intelligence", 4)
				H.change_stat("strength", -2)
				H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			H.mind.adjust_spellpoints(7)
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 3)
			H.change_stat("constitution", 1)
			H.change_stat("endurance", -1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)

		if("Sorcerer")
			to_chat(H, span_warning("In some places in Grimmoria, people are banned from the study of magic. Those that do even then are afforded the title Sorcerer in honor of their resolve."))
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			pants = /obj/item/clothing/under/roguetown/trou/leather
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
			belt = /obj/item/storage/belt/rogue/leather/rope
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			beltl = /obj/item/rogueweapon/huntingknife
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			r_hand = /obj/item/rogueweapon/woodstaff
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(0,1,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(0,1,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(0,1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/magic/arcane, pick(2,3,3), TRUE)
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 4)
			H.change_stat("speed", 1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)

	H.set_blindness(0)

//Decoupled occultist. For admin use.

/datum/outfit/job/roguetown/refugee/occultist/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
	H.mind.AddSpell(new SPELL_STRENGTHEN_UNDEAD)
	H.mind.AddSpell(new SPELL_SICKNESS)
	H.mind.AddSpell(new SPELL_EYEBITE)
	H.mind.AddSpell(new SPELL_RAISE_UNDEAD_LESSER)
	H.mind.AddSpell(new SPELL_REVOKE_UNLIFE)
	head = /obj/item/clothing/head/roguetown/necromhood
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/necromancer
	belt = /obj/item/storage/belt/rogue/leather/rope
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	beltl = /obj/item/rogueweapon/huntingknife
	r_hand = /obj/item/rogueweapon/woodstaff
	H.change_stat("strength", -1)
	H.change_stat("intelligence", 3)
	H.change_stat("constitution", -2)
	H.change_stat("endurance", -1)
	H.change_stat("speed", -1)
	H.mind.adjust_spellpoints(-3) //no starting spellpoints, but they can level arcane to get them
	H.mind.AddSpell(new SPELL_LEARNSPELL)
	H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
	H.set_patron(/datum/patron/zizo)
	H.faction += "undead"
