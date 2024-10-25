/datum/advclass/mercenary/warscholar
	name = "Naledi Warscholar"
	tutorial = "Heralded by sigils of black-and-gold and their distinct masks, the Naledi Warscholars once prowled the dunes of their homeland, exterminating daemons in exchange for coin, artifacts, or knowledge. As Naledi's economy falters, the Warscholars travel to foreign lands to seek further business."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/warscholar
	category_tags = list(CTAG_MERCENARY)
	cmode_music = 'sound/music/warscholar.ogg'

/datum/outfit/job/roguetown/mercenary/warscholar/pre_equip(mob/living/carbon/human/H)
	..()

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Hierophant","Arcyne-Monk")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Hierophant")
			H.set_blindness(0)
			to_chat(H, span_warning("Hierophants are magicians who studied under cloistered sages, well-versed in all manners of arcyne. They prioritize enhancing their teammates and distracting foes while staying in the backline."))
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
				H.change_stat("speed", -1)
				H.change_stat("intelligence", 1)
				H.change_stat("perception", 1)
				H.mind.adjust_spellpoints(1)
			H.change_stat("strength", -1)
			H.change_stat("constitution", -1)
			H.change_stat("perception", 1)
			H.change_stat("intelligence", 3)
			H.mind.adjust_spellpoints(2)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			r_hand = /obj/item/rogueweapon/woodstaff
		if("Arcyne-Monk")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a Naledi Arcyne-Monk, a warrior trained into a hybridized style of movement-controlling magic and hand-to-hand combat. Though your abilities in magical fields are lacking, you are far more dangerous than other magi in a straight fight."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.mind.adjust_spellpoints(-6) //The - is intended.
			H.change_stat("strength", 1)
			H.change_stat("endurance", 2)
			H.change_stat("perception", -1)
			H.change_stat("speed", 2)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch) // In an attempt to make them less Possibly Wildly OP, they can't freely pick their spells. Casts at apprentice level, but doesn't get the spellbuy points it'd provide.
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe)
			r_hand = /obj/item/rogueweapon/katar
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

	//General gear regardless of class.
	mask = /obj/item/clothing/mask/rogue/lordmask/tarnished
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/flashlight/flare/torch
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	gloves = /obj/item/clothing/gloves/roguetown/angle
	backr = /obj/item/storage/backpack/rogue/satchel/black
	head = /obj/item/clothing/head/roguetown/roguehood/shalal/black
	cloak = /obj/item/clothing/cloak/half
	if(H.pronouns == SHE_HER || H.pronouns == THEY_THEM_F)
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	else
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord // FUCK YOU ZETH, WHY DOESN'T THE ARMING JACKET GET WOMEN SPRITES..

	backpack_contents = list(/obj/item/roguekey/mercenary,/obj/item/rogueweapon/huntingknife)
