/datum/special_trait/natural_talent
    name = "Natural Talent"
    greet_text = span_notice("Ever since I was little, with enough effort, I could do anything I put my mind to")

/datum/special_trait/natural_talent/on_apply(mob/living/carbon/human/character, silent)
    character.change_stat("strength", 1)
    character.change_stat("speed", 1)
    character.change_stat("perception", 1)
    character.change_stat("constitution", 1)
    character.change_stat("endurance", 1)
    character.change_stat("intelligence", 1)

//datum/special_trait/nimrod
//    name = "Nimrod"
//    greet_text = span_warning("In the past I learned slower than my peers, and I tend to be clumsy")

//datum/special_trait/nimrod/on_apply(mob/living/carbon/human/character, silent)
//    character.change_stat("speed", -2)
//    character.change_stat("intelligence", -4)

//positive

/datum/special_trait/novice
	name = "No Vice"
	greet_text = span_notice("Self-Disipline has saved you from many misfortunes. You have no vices.")

/datum/special_trait/novice/on_apply(mob/living/carbon/human/character, silent)
		QDEL_NULL(character.charflaw)
		character.charflaw = new /datum/charflaw/eznoflaw()

/datum/special_trait/duelist
	name = "Swordmaster Apprentice"
	greet_text = span_notice("You were the student of a legendary sword master, your skill is rivalled by few!")
	
/datum/special_trait/duelist/on_apply(mob/living/carbon/human/character, silent)
	character.cmode_music = 'sound/music/combat_duelist.ogg'
	character.change_stat("speed", 2)
	character.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE) //will make a unique trait later on
	//if(!character.beltr)	 ((code for me to keep here for now))
	//	character.equip_to_slot_or_del(new /obj/item/rogueweapon/sword/rapier(character), SLOT_BELT_R)
	//else
	//	new /obj/item/rogueweapon/sword/rapier(get_turf(character))

/datum/special_trait/languagesavant
	name = "Polyglot"
	greet_text = span_notice("You have always picked up on languages easily, even those that are forbidden to mortals.")
/datum/special_trait/languagesavant/on_apply(mob/living/carbon/human/character, silent)
	character.grant_language(/datum/language/dwarvish)
	character.grant_language(/datum/language/elvish)
	character.grant_language(/datum/language/hellspeak)
	character.grant_language(/datum/language/celestial)
	character.grant_language(/datum/language/orcish)
	character.grant_language(/datum/language/beast)
	
/datum/special_trait/civilizedbarbarian
	name = "Tavern Brawler"
	greet_text = span_notice("You are skilled at using Improvised Weapons and your fists feel heavier!")
	
/datum/special_trait/civilizedbarbarian/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC) //punches are slightly more deadly. Need to make trait also improve hitting people with chairs, mugs, goblets.	
	
/datum/special_trait/mastercraftsmen
    name = "Guildmaster"
    greet_text = "In your youth, you decided you'd get a grasp on every trade, and pursued the 10 arts of the craft."
	//allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD) (getting code\datums\special_traits\traits\traits.dm:58:error: inconsistent indentation here)

/datum/special_trait/mastercraftsmen/on_apply(mob/living/carbon/human/character)
	character.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	
/datum/special_trait/bleublood
	name = "Noble Lineage"
	greet_text = span_notice("You come are of noble blood.")
	
/datum/special_trait/bleublood/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOBLE, TRAIT_GENERIC)

//neutral
/datum/special_trait/backproblems
	name = "Giant"
	greet_text = span_notice("You've always been called a giant. You are valued for your stature, but, this world made for smaller folk has forced you to move cautiously.")
	//maybe I should lock this from short races (verminvolk, kobolds, dwarves)
	
/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character)
    character.change_stat("strength", 2)
    character.change_stat("constitution", 1)
    character.change_stat("speed", -2)
		
/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character, silent)
	if(..())
		return
	character.transform = character.transform.Scale(1.15, 1.15)
	character.update_transform()
	
/datum/special_trait/punknoble
	name = "Rebellous Noble"
	greet_text = span_notice("You are quite rebellous for a child of the King. Screw Noble Customs!")
	allowed_jobs = list("Prince")

/datum/special_trait/punknoble/on_apply(mob/living/carbon/human/character, silent)
	if(character.gender == FEMALE)
		QDEL_NULL(character.wear_pants)
		QDEL_NULL(character.wear_shirt)
		QDEL_NULL(character.wear_armor)
		QDEL_NULL(character.shoes)
		QDEL_NULL(character.belt)
		QDEL_NULL(character.beltl)
		QDEL_NULL(character.beltr)
		QDEL_NULL(character.backr)
		QDEL_NULL(character.head)
		character.equip_to_slot_or_del(new /obj/item/clothing/under/roguetown/tights/random(character), SLOT_PANTS)
		character.equip_to_slot_or_del(new /obj/item/clothing/suit/roguetown/shirt/undershirt/guard(character), SLOT_SHIRT)
		character.equip_to_slot_or_del(new /obj/item/clothing/suit/roguetown/armor/chainmail(character), SLOT_ARMOR)
		character.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/leather(character), SLOT_BELT)
		character.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/pouch/coins/rich(character), SLOT_BELT_R)
		character.equip_to_slot_or_del(new /obj/item/storage/backpack/rogue/satchel(character), SLOT_BACK_R)
		character.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/misc/reading, -2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/misc/sneaking, -2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/misc/stealing, -2, TRUE)
	else
		QDEL_NULL(character.wear_pants)
		QDEL_NULL(character.wear_shirt)
		QDEL_NULL(character.wear_armor)
		QDEL_NULL(character.shoes)
		QDEL_NULL(character.belt)
		QDEL_NULL(character.beltl)
		QDEL_NULL(character.beltr)
		QDEL_NULL(character.backr)
		character.equip_to_slot_or_del(new /obj/item/clothing/head/roguetown/hennin(character), SLOT_HEAD)
		character.equip_to_slot_or_del(new /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/princess(character), SLOT_SHIRT)
		character.equip_to_slot_or_del(new /obj/item/clothing/suit/roguetown/armor/silkcoat(character), SLOT_ARMOR) //I will add a male sprite for this!
		character.equip_to_slot_or_del(new /obj/item/clothing/shoes/roguetown/shortboots(character), SLOT_SHOES)
		character.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/leather/cloth/lady(character), SLOT_BELT)
		character.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/pouch/coins/rich(character), SLOT_NECK)
		character.mind.adjust_skillrank(/datum/skill/combat/maces, -1, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/bows, -3, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/crossbows, -2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/wrestling, -2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/unarmed, -2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/swords, -2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/combat/knives, -2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		character.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
	
//negative
/datum/special_trait/hussite
	name = "Known Heretic"
	greet_text = span_notice("You've been denounced by the church for either reasons legitimate or not! A strange sympathetic noble from a nearby mountain manor has given you some coin to aid you in these times.")
	
/datum/special_trait/hussite/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.real_name
	if(!character.wear_neck)
		character.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/pouch/coins/rich(character), SLOT_NECK)
	else
		new /obj/item/storage/belt/rogue/pouch/coins/rich(get_turf(character))
	
datum/special_trait/murderer
	name = "Ancestral Curse"
	greet_text = span_warning("Graggar is your ancestor and nothing will let you escape this fact! The God of Cannibalism and Murder watches you with a judging eye, demanding that blood be spilled by your hands.")
	
datum/special_trait/murderer/on_apply((mob/living/carbon/human/character))
	if(character.charflaw)
		QDEL_NULL(character.charflaw)
		character.charflaw = new /datum/charflaw/addiction/murderer() //For some reason, no matter what I try, either by adding var/debufft1 - t3 or copypasting the entire on_apply code and switching out the vices with status effects, it won't let me make a charflaw that progresses similiar to hunger? I got the addiction fufilled code to work, just not the status effects.

datum/special_trait/sillyvoice
	name = "Annoying"
	greet_text = span_sans("People really hate your voice for some reason.")
	
datum/special_trait/sillyvoice/on_apply((mob/living/carbon/human/character))
	ADD_TRAIT(character, TRAIT_COMICSANS, TRAIT_GENERIC)
	addtimer(CALLBACK(character,TYPE_PROC_REF(/mob/living/carbon/human, add_credit)), 10)
	character.dna.add_mutation(WACKY)