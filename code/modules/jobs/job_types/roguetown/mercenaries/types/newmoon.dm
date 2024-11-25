/datum/advclass/newmoon
	name = "New Moon Spellblade"
	tutorial = "Knowledge is power.. You and your masters in the New Moon holy order took it to heart as you and all acolytes like you were forced to study countless text of both arcane and war to make yourself worthy a worthy emissary. Then it all crumbled, the news came while you were on your voyage; the bastion fell to the rot as only a small ammount of acolytes and spellblades escaped, most forced to retreat to this god forsaken swamp while others searched for something better."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/tabaxi)
	outfit = /datum/outfit/job/roguetown/mercenary/newmoon
	maximum_possible_slots = 10
	min_pq = 4
	torch = FALSE
	cmode_music = 'sound/music/combat_desertrider.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/newmoon/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/armor
	neck = /obj/item/clothing/neck/roguetown/psicross/noc
	head = /obj/item/clothing/head/roguetown/roguehood/reinforced/newmoon
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	armor = /obj/item/clothing/suit/roguetown/shirt/tunic/newmoon
	beltr = /obj/item/keyring/mercenary
	beltl = /obj/item/rogueweapon/huntingknife/idagger
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/sword/sabre
	backpack_contents = /obj/item/storage/belt/rogue/pouch/coins/poor

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_spellpoints(4)
		if(H.age == AGE_OLD)
			head = /obj/item/clothing/head/roguetown/wizhat/gen
			H.change_stat("intelligence", 4)
			H.change_stat("strength", -2)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", -2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 2)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
