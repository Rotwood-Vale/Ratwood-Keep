/datum/migrant_role/gronn
	hidden_role = TRUE // all gronn roles are hidden from the actors list

/datum/migrant_role/gronn/chieftain
	name = "Gronn Chieftain"
	greet_text = "You are the leader of your tribe. Guide them to glory or try to survive."
	outfit = /datum/outfit/job/roguetown/gronn/chieftain
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/human/northern, /datum/species/halforc, /datum/species/goblinp)
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE

/datum/outfit/job/roguetown/gronn
	allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/gronn/chieftain/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/nomadhelmet
	shoes = /obj/item/clothing/shoes/roguetown/armor/nomadboots
	pants = /obj/item/clothing/under/roguetown/trou/nomadpants
	shirt = /obj/item/clothing/suit/roguetown/armor/leather/hatanga_degel_fur
	gloves =/obj/item/clothing/gloves/roguetown/leather/angle
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/kurche
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/huntingknife
	beltr = /obj/item/rogueweapon/stoneaxe/battle
	r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	l_hand = /obj/item/ammo_holder/quiver/arrows
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 3)
		H.change_stat("intelligence", -1)

	H.cmode_music = 'sound/music/combat_gronn.ogg'
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)

	if(!H.has_language(/datum/language/orcish))
		H.grant_language(/datum/language/orcish)
		to_chat(H, span_info("I can speak Orchish with ,o before my speech."))

//Shaman
/datum/migrant_role/gronn/shaman
	name = "Gronn Shaman"
	greet_text = "The wisest and likely oldest of the tribe. You commune with Graggah and unleash powers of the divine. Tending as well to the wounded of the tribe."
	outfit = /datum/outfit/job/roguetown/gronn/shaman
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/human/northern, /datum/species/halforc, /datum/species/goblinp)
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE

/datum/outfit/job/roguetown/gronn/shaman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/hatfur
	shoes = /obj/item/clothing/shoes/roguetown/armor/nomadboots
	pants = /obj/item/clothing/under/roguetown/trou/nomadpants
	shirt = /obj/item/clothing/suit/roguetown/armor/leather/chargah
	belt = /obj/item/storage/belt/rogue/leather
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/huntingknife
	backpack_contents = list(/obj/item/reagent_containers/glass/mortar)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("endurance", 2)
		H.change_stat("strength", 1)
		H.change_stat("constitution", 1)

	H.cmode_music = 'sound/music/combat_gronn.ogg'
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/message)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/lesser_heal)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells(H)//No real spells of Graggar, yet.
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

	if(!H.has_language(/datum/language/orcish))
		H.grant_language(/datum/language/orcish)
		to_chat(H, span_info("I can speak Orchish with ,o before my speech."))

//Warrior
/datum/migrant_role/gronn/warrior
	name = "Gronn Warrior"
	greet_text = "You are the elite, the best fighters of your tribe. You fight side by side with the Chieftain and ensure his survival."
	outfit = /datum/outfit/job/roguetown/gronn/warrior
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/human/northern, /datum/species/halforc, /datum/species/goblinp)
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE

/datum/outfit/job/roguetown/gronn/warrior/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/nomadhelmet
	shoes = /obj/item/clothing/shoes/roguetown/armor/nomadboots
	pants = /obj/item/clothing/under/roguetown/trou/nomadpants
	shirt = /obj/item/clothing/suit/roguetown/armor/leather/hatanga_degel
	gloves =/obj/item/clothing/gloves/roguetown/leather/angle
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/hudesutu_quyaq
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/huntingknife
	beltr = /obj/item/rogueweapon/stoneaxe/handaxe
	r_hand = /obj/item/rogueweapon/halberd/bardiche
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 1, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 2)
		H.change_stat("intelligence", -2)

	H.cmode_music = 'sound/music/combat_gronn.ogg'
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)

	if(!H.has_language(/datum/language/orcish))
		H.grant_language(/datum/language/orcish)
		to_chat(H, span_info("I can speak Orchish with ,o before my speech."))

//Tribal
/datum/migrant_role/gronn/tribal
	name = "Gronn Tribal"
	greet_text = "You are the bulk of the tribe. Skilled with bow and axe. Well adapted to surviving off the land."
	outfit = /datum/outfit/job/roguetown/gronn/tribal
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/human/northern, /datum/species/halforc, /datum/species/goblinp)
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE

/datum/outfit/job/roguetown/gronn/tribal/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/hatfur
	shoes = /obj/item/clothing/shoes/roguetown/armor/nomadboots
	pants = /obj/item/clothing/under/roguetown/trou/nomadpants
	shirt = /obj/item/clothing/suit/roguetown/armor/leather/hatanga_degel
	gloves =/obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/Huus_quyaq
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/huntingknife
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut
	r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	l_hand = /obj/item/ammo_holder/quiver/arrows
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
		H.change_stat("endurance", 3)
		H.change_stat("strength", 2)
		H.change_stat("constitution", 2)
		H.change_stat("intelligence", -1)

	H.cmode_music = 'sound/music/combat_gronn.ogg'
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	if(!H.has_language(/datum/language/orcish))
		H.grant_language(/datum/language/orcish)
		to_chat(H, span_info("I can speak Orchish with ,o before my speech."))

//Slave
/datum/migrant_role/gronn/slave
	name = "Gronn Slave"
	greet_text = "An unlucky soul. Perhaps caught in a pillaging raid, or alone in the wilderness. You have been enslaved by the tribe. Work hard to appease your new masters."
	outfit = /datum/outfit/job/roguetown/gronn/slave
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE

/datum/outfit/job/roguetown/gronn/slave/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/collar/leather/cursed
	pants = /obj/item/clothing/under/roguetown/trou/nomadpants
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/storage/belt/rogue/pouch
	beltr = /obj/item/flint
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("speed", 1)
		H.change_stat("strength", -3)
		H.change_stat("constitution", -2)
		H.change_stat("fortune", -1)

	H.cmode_music = 'sound/music/combat_gronn.ogg'

	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)

	if(!H.has_language(/datum/language/orcish))
		H.grant_language(/datum/language/orcish)
		to_chat(H, span_info("I can speak Orchish with ,o before my speech."))
