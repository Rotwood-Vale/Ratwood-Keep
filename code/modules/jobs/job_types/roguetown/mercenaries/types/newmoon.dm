/datum/subclass/newmoon
	name = "New Moon Spellblade"
	tutorial = "The New Moon Spellblades of Zybantia are the remnants of a fallen Nocite monastery in an unknown region of Lalvestine, the last major stronghold of the Ten in the Zybantian Empire. Their monastic lyfestyle and devotion collapsed quickly under the weight of the Rot, and they were forced from a lyfe of devout solitude into that of a common sellsword; Noc’s blessings proving rather useful when slaying monsters and Men alike. For whatever reason, you find yourself in Rockhill, offering your skills to the highest bidder. Knowledge is power, or so She says."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/tabaxi,
		/datum/species/elf/wood,
		/datum/species/demihuman,
		/datum/species/tieberian
	)
	outfit = /datum/outfit/job/roguetown/mercenary/newmoon
	maximum_possible_slots = 10
	min_pq = 4
	torch = FALSE
	cmode_music = 'sound/music/combat_desertrider.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/newmoon
	allowed_patrons = list(/datum/patron/divine/noc)

/datum/outfit/job/roguetown/mercenary/newmoon/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/armor
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	head = /obj/item/clothing/head/roguetown/roguehood/reinforced/newmoon
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/newmoon
	armor = /obj/item/clothing/suit/roguetown/armor/leather/newmoon_jacket
	beltr = /obj/item/storage/keyring/mercenary
	beltl = /obj/item/rogueweapon/huntingknife/idagger
	backpack_contents = list(/obj/item/book/granter/spellbook/mid = 1, /obj/item/reagent_containers/glass/bottle/rogue/lessermanapot)
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/sword/sabre_freeze
	wrists = /obj/item/clothing/neck/roguetown/psicross/noc

	if(iself(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Timberborn"]
		H.update_body()
	if(isdemihuman(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Lalvestine"]
		H.update_body()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.mind.adjust_spellpoints(3)
		if(H.age == AGE_OLD)
			H.change_stat("intelligence", 4)
			H.change_stat("strength", -2)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", -2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 2)
		H.mind.AddSpell(new SPELL_LEARNSPELL)
		H.mind.AddSpell(new SPELL_SUMMON_WEAPON)
		H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
