/*
File to hold the equipment loadouts and antag datum for setting up players as deathsquad.
Easier this way, IMO.
*/

//Antag datum.
/datum/antagonist/deathsquad
	name = "deathsquad"
	increase_votepwr = FALSE

/datum/antagonist/deathsquad/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/deathsquad))
		return span_boldnotice("My ally.")

/datum/antagonist/deathsquad/on_gain()
	return ..()

/datum/antagonist/deathsquad/on_removal()
	return ..()

/datum/antagonist/deathsquad/roundend_report()
	return


//Actual outfits.
//General parent.
/datum/outfit/job/roguetown/deathsquad/pre_equip(mob/living/carbon/human/H)
	..()

	H.cmode_music = 'sound/music/combat_deathsquad.ogg'

//Don't want ambushes if they have to trek through the bog.
	H.ambushable = FALSE

//Hacky way of having them idenfity each other.
//Maybe expand this in the future and allow admins to give triumphs via a toggle if their objectives are complete.
	var/datum/antagonist/new_antag = new /datum/antagonist/deathsquad()
	H.mind.add_antag_datum(new_antag)


//Kingsfield Knights. Used for the worst of admin abuse.
/datum/outfit/job/roguetown/deathsquad/knightfield/pre_equip(mob/living/carbon/human/H)
	..()

	var/classes = list("Knight", "Infantry")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Knight")
			mask = /obj/item/clothing/mask/rogue/facemask/steel/hound
			head = /obj/item/clothing/head/roguetown/helmet/heavy/knight
			cloak = /obj/item/clothing/cloak/tabard
			gloves = /obj/item/clothing/gloves/roguetown/plate
			pants = /obj/item/clothing/under/roguetown/platelegs
			neck = /obj/item/clothing/neck/roguetown/bervor
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
			armor = /obj/item/clothing/suit/roguetown/armor/plate/full
			shoes = /obj/item/clothing/shoes/roguetown/armor/steel
			beltr = /obj/item/rogueweapon/sword/long
			beltl = /obj/item/rogueweapon/huntingknife/idagger/silver
			belt = /obj/item/storage/belt/rogue/leather/steel
			backr = /obj/item/storage/backpack/rogue/satchel/black
			if(prob(50))
				r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
			else
				r_hand = /obj/item/rogueweapon/mace/goden/steel
			backpack_contents = list(/obj/item/natural/feather = 1, /obj/item/natural/cloth = 1, /obj/item/needle = 1)

		if("Infantry")
			r_hand = /obj/item/rogueweapon/mace/warhammer/steel
			l_hand = /obj/item/rogueweapon/shield/tower/metal
			mask = /obj/item/clothing/mask/rogue/facemask/steel/hound
			head = /obj/item/clothing/head/roguetown/helmet/heavy/pigface
			cloak = /obj/item/clothing/cloak/tabard
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/armor/steel
			gloves = /obj/item/clothing/gloves/roguetown/chain
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/clothing/neck/roguetown/gorget
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			armor = /obj/item/clothing/suit/roguetown/armor/brigandine
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/rogueweapon/sword/long
			beltl = /obj/item/rogueweapon/huntingknife/idagger/silver
			backpack_contents = list(/obj/item/natural/feather = 1, /obj/item/natural/cloth = 1, /obj/item/needle = 1)

//Weapon skills across the board. All of them.
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/firearms, 5, TRUE)

//Misc skills across the board. Almost all.
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 5, TRUE)

//Extreme buff to stats.
	H.change_stat("strength", 6)
	H.change_stat("perception", 6)
	H.change_stat("intelligence", 6)
	H.change_stat("constitution", 6)
	H.change_stat("endurance", 6)
	H.change_stat("speed", 6)
	H.change_stat("fortune", 6)

	H.dna.species.soundpack_m = new /datum/voicepack/male/evil()
//Good enough.
	H.dna.species.soundpack_f = new /datum/voicepack/female/dwarf()


//Armour traits.
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
//Lack of armour traits.
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GOODRUNNER, TRAIT_GENERIC)
//Anti-Arcyne traits.
	ADD_TRAIT(H, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ANTISCRYING, TRAIT_GENERIC)
//Others.
	ADD_TRAIT(H, TRAIT_ZJUMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
