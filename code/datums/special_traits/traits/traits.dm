//// Sleep Specials
//// these should still be in the round-start/late join specials as well! It's just these are contextually fitting for Sleep Specials as well!
/datum/special_trait/nothing
	name = "Nothing"
	greet_text = span_notice("You're not special (This is a placeholder chance to not get anything due to a low amount of specials currently. Eventually this chance will be removed. Sorry about this!)")
	weight = 2000

/datum/special_trait/nightvision
	name = "Night Vision"
	greet_text = span_notice("I can easily see in the dark.")
	weight = 100

/datum/special_trait/nightvision/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/organ/eyes/eyes = character.getorganslot(ORGAN_SLOT_EYES)
	if(!eyes)
		return
	eyes.see_in_dark = 3
	eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	character.update_sight()

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
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 6, TRUE) //will make a unique trait later on
	var/obj/item/rapier = new /obj/item/rogueweapon/sword/rapier(get_turf(character))
	character.put_in_hands(rapier, forced = TRUE)

/datum/special_trait/thief
	name = "Thief"
	greet_text = span_notice("Life's not easy around here, but I've made mine a little easier by taking things of others")
	weight = 100

/datum/special_trait/thief/on_apply(mob/living/carbon/human/character, silent)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/stealing, 4, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 2, TRUE)

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
	character.grant_language(/datum/language/draconic)

/datum/special_trait/civilizedbarbarian
	name = "Tavern Brawler"
	greet_text = span_notice("My fists feel heavier!")
	weight = 100

/datum/special_trait/civilizedbarbarian/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC) //Need to make trait improve hitting people with chairs, mugs, goblets.

/datum/special_trait/mastercraftsmen
	name = "Master Crasftman"
	greet_text = "In your youth, I've decided I'd get a grasp on every trade, and pursued the 10 arts of the craft."
	req_text = "Middle-aged or Old"
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	weight = 100

/datum/special_trait/mastercraftsmen/on_apply(mob/living/carbon/human/character)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/weaponsmithing, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/armorsmithing, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/blacksmithing, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/masonry, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/traps, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/engineering, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/tanning, 2, TRUE)

/datum/special_trait/bleublood
	name = "Noble Lineage"
	greet_text = span_notice("I come of noble blood.")
	restricted_traits = list(TRAIT_NOBLE)
	weight = 100

/datum/special_trait/bleublood/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOBLE, "[type]")

/datum/special_trait/richpouch
	name = "Rich Pouch"
	greet_text = span_notice("I've recently found a pouch filled with mammons, probably belonging to some noble.")
	weight = 100

/datum/special_trait/richpouch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/pouch = new /obj/item/storage/belt/rogue/pouch/coins/rich(get_turf(character))
	character.put_in_hands(pouch, forced = TRUE)

//neutral
/datum/special_trait/backproblems
	name = "Giant"
	greet_text = span_notice("I've always been called a giant. I am valued for my stature, but, this world made for smaller folk has forced me to move cautiously.")
	req_text = "Not a kobold, verminvolk or a dwarf"
	restricted_races = list(/datum/species/anthromorphsmall, /datum/species/dwarf/mountain, /datum/species/kobold)
	weight = 50

/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character)
	character.change_stat("strength", 2)
	character.change_stat("constitution", 1)
	character.change_stat("speed", -2)
	character.transform = character.transform.Scale(1.25, 1.25)
	character.transform = character.transform.Translate(0, (0.25 * 16))
	character.update_transform()

//negative
/datum/special_trait/nimrod
	name = "Nimrod"
	greet_text = span_warning("In the past I learned slower than my peers, and I tend to be clumsy.")
	weight = 100

/datum/special_trait/nimrod/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("speed", -2)
	character.change_stat("intelligence", -4)	

/datum/special_trait/nopouch
	name = "No Pouch"
	greet_text = span_notice("I lost my pouch recently, I'm without a zenny..")
	weight = 100

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
	req_text = "Non-church role"
	weight = 100
	restricted_jobs = list(CHURCH_ROLES)

/datum/special_trait/hussite/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.real_name

/datum/special_trait/bounty
	name = "Hunted Man"
	greet_text = span_notice("Someone put a bounty on my head!")
	weight = 100

/datum/special_trait/bounty/on_apply(mob/living/carbon/human/character, silent)
	var/reason = ""
	var/employer = "unknown employer"
	var/employer_gender
	if(prob(65))
		employer_gender = MALE
	else
		employer_gender = FEMALE
	if(employer_gender == MALE)
		employer = pick(list("Baron", "Lord", "Nobleman", "Prince"))
	else
		employer = pick(list("Duchess", "Lady", "Noblelady", "Princess"))
	employer = "[employer] [random_human_name(employer_gender, FALSE, FALSE)]"
	var/amount = rand(40,100)
	switch(rand(1,7))
		if(1)
			reason = "murder"
		if(2)
			reason = "kinslaying"
		if(3)
			reason = "besmirching a noble's name"
		if(4)
			reason = "treason"
		if(5)
			reason = "arson"
		if(6)
			reason = "heresy"
		if(7)
			reason = "robbing a noble"
	add_bounty(character.real_name, amount, FALSE, reason, employer)
	if(!silent)
		to_chat(character, span_notice("Whether I done it or not, I have been accused of [reason], and the [employer] put a bounty on my head!"))

/datum/special_trait/outlaw
	name = "Known Outlaw"
	greet_text = span_notice("Whether for crimes I did or was accused of, I have been declared an outlaw!")
	weight = 100

/datum/special_trait/outlaw/on_apply(mob/living/carbon/human/character, silent)
	make_outlaw(character.real_name, TRUE)

/datum/special_trait/sillyvoice
	name = "Annoying"
	greet_text = span_sans("People really hate my voice for some reason.")
	weight = 100

/datum/special_trait/sillyvoice/on_apply((mob/living/carbon/human/character))
	ADD_TRAIT(character, TRAIT_COMICSANS, "[type]")
	character.dna.add_mutation(WACKY)

//job specials
/datum/special_trait/punkprincess //I think everyone will like the Rebellous Prince-Like Princess. I'd love to do one for the prince as well that gives him princess loadout, but, up to you!
	name = "Rebellous Daughter"
	greet_text = span_notice("I am quite rebellious for a princess. Screw Noble Customs!")
	req_text = "Be a princess"
	allowed_sexes = list(FEMALE)
	allowed_jobs = list(/datum/job/roguetown/prince)
	weight = 100

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
	character.equip_to_slot_or_del(new /obj/item/clothing/shoes/roguetown/nobleboot(character), SLOT_SHOES)
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

/datum/special_trait/vengantbum
	name = "Vengant Bum"
	greet_text = span_notice("You were once a nobleman, high on life when your father was murdered right in front of you. Thankfully, your mentor took you to safety and taught you all you need to survive in these disgusting lands. They think you're a lowlife, but that's just an advantage.")
	req_text = "Be a beggar"
	allowed_jobs = list(/datum/job/roguetown/beggar)
	weight = 7

/datum/special_trait/vengantbum/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DECEIVING_MEEKNESS, "[type]")
	character.mind.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/unarmed, 6, TRUE)
	character.STASTR = 20
	character.STACON = 20
	character.STAEND = 20
