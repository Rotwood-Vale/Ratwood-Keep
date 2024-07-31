//// Sleep Specials
//// these should still be in the round-start/late join specials as well! It's just these are contextually fitting for Sleep Specials as well!
/datum/special_trait/nothing
	name = "Nothing"
	greet_text = span_notice("I'm not particularly special")
	weight = 1000

/datum/special_trait/nightvision
	name = "Night Vision"
	greet_text = span_notice("I can easily see in the dark.")
	weight = 100

/datum/special_trait/nightvision/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/organ/eyes/eyes = character.getorganslot(ORGAN_SLOT_EYES)
	eyes.see_in_dark = 3
	eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_LESSER_NV_TRAIT
	eyes.Insert(character)

/datum/special_trait/thickskin
	name = "Tough"
	greet_text = span_notice("I feel it. Thick Skin. Dense Flesh. Durable Bones. I'm a punch-taking machine.")
	weight = 100

/datum/special_trait/thickskin/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BREADY, "[type]")
	character.change_stat("constitution", 2)

/datum/special_trait/curseofcain
	name = "Flawed Immortality"
	greet_text = span_notice("I feel like I don't need to eat anymore, and my veins feel empty... Is this normal?")
	weight = 25

/datum/special_trait/curseofcain/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(character, TRAIT_NOBREATH, "[type]")

/datum/special_trait/value
	name = "Coin Counter"
	greet_text = span_notice("I know how to estimate an item's value.")
	weight = 100
	restricted_traits = list(TRAIT_SEEPRICES)

/datum/special_trait/value/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_SEEPRICES, "[type]")

/datum/special_trait/lightstep
	name = "Light Step"
	greet_text = span_notice("I am quiet, nobody can hear my steps.")
	weight = 100

/datum/special_trait/lightstep/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_LIGHT_STEP, "[type]")

//positive
/datum/special_trait/duelist
	name = "Swordmaster Apprentice"
	greet_text = span_notice("I was the student of a legendary sword master, my skill is rivalled by few!")
	weight = 100

/datum/special_trait/duelist/on_apply(mob/living/carbon/human/character, silent)
	character.cmode_music = 'sound/music/combat_duelist.ogg'
	character.change_stat("speed", 2)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 5, TRUE) //will make a unique trait later on
	var/obj/item/rapier = new /obj/item/rogueweapon/sword/rapier(get_turf(character))
	if(!character.equip_to_appropriate_slot(rapier))
		character.put_in_hands(rapier, TRUE)

/datum/special_trait/languagesavant
	name = "Polyglot"
	greet_text = span_notice("I have always picked up on languages easily, even those that are forbidden to mortals.")
	weight = 100

/datum/special_trait/languagesavant/on_apply(mob/living/carbon/human/character, silent)
	character.grant_language(/datum/language/dwarvish)
	character.grant_language(/datum/language/elvish)
	character.grant_language(/datum/language/hellspeak)
	character.grant_language(/datum/language/celestial)
	character.grant_language(/datum/language/orcish)
	character.grant_language(/datum/language/beast)

/datum/special_trait/civilizedbarbarian
	name = "Tavern Brawler"
	greet_text = span_notice("My fists feel heavier!")

/datum/special_trait/civilizedbarbarian/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC) //Need to make trait improve hitting people with chairs, mugs, goblets.

/datum/special_trait/mastercraftsmen
	name = "Master Crasftman"
	greet_text = "In your youth, I've decided I'd get a grasp on every trade, and pursued the 10 arts of the craft."
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)

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
	greet_text = span_notice("I come are of noble blood.")
	restricted_traits = list(TRAIT_NOBLE)

/datum/special_trait/bleublood/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOBLE, "[type]")

/datum/special_trait/richpouch
	name = "Rich Pouch"
	greet_text = span_notice("I've recently found a pouch filled with mammons, probably belonging to some noble.")

/datum/special_trait/richpouch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/pouch = new /obj/item/storage/belt/rogue/pouch/coins/rich(get_turf(character))
	if(!character.equip_to_appropriate_slot(pouch))
		character.put_in_hands(pouch, TRUE)

//neutral
/datum/special_trait/backproblems
	name = "Giant"
	greet_text = span_notice("I've always been called a giant. I am are valued for your stature, but, this world made for smaller folk has forced me to move cautiously.")
	restricted_races = list(/datum/species/anthromorphsmall, /datum/species/dwarf/mountain, /datum/species/kobold)

/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character)
	character.change_stat("strength", 2)
	character.change_stat("constitution", 1)
	character.change_stat("speed", -2)
	character.transform = character.transform.Scale(1.15, 1.15)
	character.update_transform()

//negative
/datum/special_trait/nopouch
	name = "No Pouch"
	greet_text = span_notice("I lost my pouch recently...")

/datum/special_trait/nopouch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/pouch = locate(/obj/item/storage/belt/rogue/pouch) in character
	if(character.wear_neck == pouch)
		character.wear_neck = null
	if(character.beltl == pouch)
		character.beltl = null
	if(character.beltr == pouch)
		character.beltr = null
	qdel(pouch)

/datum/special_trait/hussite
	name = "Known Heretic"
	greet_text = span_notice("I've been denounced by the church for either reasons legitimate or not!")

/datum/special_trait/hussite/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.real_name

/datum/special_trait/outlaw
	name = "Known Outlaw"
	greet_text = span_notice("Whether for crimes I did or was accused of, I have been declared an outlaw!")

/datum/special_trait/outlaw/on_apply(mob/living/carbon/human/character, silent)
	make_outlaw(character.real_name, TRUE)

/datum/special_trait/sillyvoice
	name = "Annoying"
	greet_text = span_sans("People really hate my voice for some reason.")

/datum/special_trait/sillyvoice/on_apply((mob/living/carbon/human/character))
	ADD_TRAIT(character, TRAIT_COMICSANS, "[type]")
	character.dna.add_mutation(WACKY)

//job specials
/datum/special_trait/punkprincess //I think everyone will like the Rebellous Prince-Like Princess. I'd love to do one for the prince as well that gives him princess loadout, but, up to you!
	name = "Rebellous Daughter"
	greet_text = span_notice("I am quite rebellious for a princess. Screw Noble Customs!")
	allowed_sexes = list(FEMALE)
	allowed_jobs = list(/datum/job/roguetown/prince)
	weight = 300

/datum/special_trait/punkprincess/on_apply(mob/living/carbon/human/character, silent)
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
