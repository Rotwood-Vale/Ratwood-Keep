// Positive Specials
/datum/special_trait/tough
	name = "Tough"
	greet_text = span_notice("I've always been sturdier than most, if that means anything.")
	weight = 80

/datum/special_trait/tough/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CRITICAL_RESISTANCE, "[type]")


/datum/special_trait/alert
	name = "Alert"
	greet_text = span_notice("My eyes are sharper than most, being on edge does not tire me.")
	weight = 100

/datum/special_trait/alert/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("perception", 2)
	ADD_TRAIT(character, TRAIT_BREADY, "[type]")


/datum/special_trait/curseofcain
	name = "Flawed Immortality"
	greet_text = span_notice("I've never needed to eat, drink or even breathe... In fact the stench of death does not bother me.")
	restricted_jobs = list(INQUISITION_ROLES)
	weight = 80

/datum/special_trait/curseofcain/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(character, TRAIT_NOBREATH, "[type]")
	ADD_TRAIT(character, TRAIT_NOSTINK, "[type]")


/datum/special_trait/desensitized
	name = "Desensitized"
	greet_text = span_notice("Shit happens.")
	weight = 100

/datum/special_trait/desensitized/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOMOOD, "[type]")
	ADD_TRAIT(character, TRAIT_NOSTINK, "[type]")


/datum/special_trait/scrooge
	name = "Scrooge"
	greet_text = span_notice("I've always had a mind for mammon, I have saved up some mammons in a safe spot.")
	weight = 80

/datum/special_trait/scrooge/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_SEEPRICES, "[type]")
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 3, TRUE)
	character.mind.special_items["My mammon"] = /obj/item/storage/belt/rogue/pouch/coins/poor
	character.mind.special_items["More of my mammon"] = /obj/item/storage/belt/rogue/pouch/coins/mid
	character.mind.special_items["A pouch for my mammon"] = /obj/item/storage/belt/rogue/pouch


/datum/special_trait/assassin
	name = "Stealthy"
	greet_text = span_notice("I've always been quieter than most.")
	weight = 40

/datum/special_trait/assassin/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_LIGHT_STEP, "[type]")
	character.change_stat("strength", -1)
	character.change_stat("endurance", 2)
	character.change_stat("speed", 2)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)


/datum/special_trait/lightfooted
	name = "Lightfooted"
	greet_text = span_notice("I've always been light on my feet. Sneaking around quietly and quickly has never been a problem for me.")
	weight = 60

/datum/special_trait/lightfooted/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_LIGHT_STEP, "[type]")
	character.change_stat("speed", 1)
	character.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)


/datum/special_trait/night_owl
	name = "Night Owl"
	greet_text = span_notice("I've always been tired at the break of dawn.")
	weight = 100

/datum/special_trait/night_owl/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NIGHT_OWL, "[type]")


/datum/special_trait/beautiful
	name = "Beautiful"
	greet_text = span_notice("My face is a work of art.")
	weight = 200

/datum/special_trait/beautiful/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BEAUTIFUL, "[type]")
	ADD_TRAIT(character, TRAIT_GOODLOVER, "[type]")

/datum/special_trait/duelist
	name = "Legendary duelist"
	greet_text = span_notice("I used to be a legendary swordsmaster until I settled down in Rockhill after a life of duelling.")
	req_text = "Be a town role and old."
	weight = 10
	allowed_ages = list(AGE_OLD)
	allowed_jobs = list(/datum/job/roguetown/towner, YEOMEN_ROLES , /datum/job/roguetown/nightmaiden, /datum/job/roguetown/butcher, /datum/job/roguetown/cook, /datum/job/roguetown/nightman, /datum/job/roguetown/farmer, /datum/job/roguetown/shophand)

/datum/special_trait/duelist/on_apply(mob/living/carbon/human/character, silent)
	character.cmode_music = 'sound/music/combat_duelist.ogg'
	character.change_stat("speed", 2)
	character.change_stat("endurance", 2)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 6, TRUE)
	character.mind.special_items["my sword"] = /obj/item/rogueweapon/sword/long/heirloom
	to_chat(character, span_notice("I need to get my sword from that tree."))

/datum/special_trait/corn_fed
	name = "Corn Fed"
	greet_text = span_notice("My diet was quite rich in corn.")
	weight = 100

/datum/special_trait/corn_fed/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("constitution", 2)

/datum/special_trait/bookworm
	name = "Bookworm"
	greet_text = span_notice("I'm a fan of books and I enjoy reading them regularly.")
	weight = 100

/datum/special_trait/bookworm/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("intelligence", 2)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 4, TRUE)

/datum/special_trait/arsonist
	name = "Arsonist"
	greet_text = span_notice("I like seeing things combust and burn. I have a stash of firebombs!")
	weight = 100

/datum/special_trait/arsonist/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["A firebomb"] = /obj/item/bomb
	character.mind.special_items["Another firebomb"] = /obj/item/bomb

/datum/special_trait/psydons_rider
	name = "Psydon's Drunkest Rider"
	greet_text = span_notice("I ride! None shall stop me for that is Psydon's divine will!")
	req_text = "Worship Psydon"
	allowed_patrons = list(/datum/patron/psydon)
	weight = 200

/datum/special_trait/psydons_rider/on_apply(mob/living/carbon/human/character, silent)
	character.drunkenness = 50
	for(var/i in 1 to 2)
		var/obj/item/bottle = new /obj/item/reagent_containers/glass/bottle/rogue/wine(get_turf(character))
		character.put_in_hands(bottle, forced = TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/riding, 4, TRUE)
	new /mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame/saddled(get_turf(character))


/datum/special_trait/packed_lunch
	name = "Packed Lunch"
	greet_text = span_notice("I don't like going around hungry so I packed my lunch!")
	weight = 75

/datum/special_trait/packed_lunch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/bag = new /obj/item/storage/roguebag/lunch(get_turf(character))
	character.put_in_hands(bag, forced = TRUE)
	bag.update_icon()


/datum/special_trait/freerunner
	name = "Freerunner"
	greet_text = span_notice("I've always had a knack for being fast, my legs work better than most and I have lept onto and off buildings with no difficulty.")
	req_text = "Adult or Middle-Aged, Non-keep role."
	restricted_jobs = list(KING_QUEEN_ROLES, GARRISON_ROLES, MANOR_ROLES)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	weight = 10

/datum/special_trait/freerunner/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_ZJUMP, "[type]")
	ADD_TRAIT(character, TRAIT_LEAPER, "[type]")
	ADD_TRAIT(character, TRAIT_NOFALLDAMAGE1, "[type]")


/datum/special_trait/thief
	name = "Thief"
	greet_text = span_notice("Life's not easy around here, but I've made mine a little easier by taking things of others")
	weight = 100

/datum/special_trait/thief/on_apply(mob/living/carbon/human/character, silent)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/stealing, 5, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 4, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/lockpicking, 4, TRUE)


/datum/special_trait/polyglot
	name = "Polyglot"
	greet_text = span_notice("I have always picked up on languages easily, even those that are forbidden to mortals.")
	weight = 100

/datum/special_trait/polyglot/on_apply(mob/living/carbon/human/character, silent)
	character.grant_language(/datum/language/dwarvish)
	character.grant_language(/datum/language/elvish)
	character.grant_language(/datum/language/hellspeak)
	character.grant_language(/datum/language/celestial)
	character.grant_language(/datum/language/orcish)
	character.grant_language(/datum/language/beast)
	character.grant_language(/datum/language/draconic)
	character.grant_language(/datum/language/faexin)


/datum/special_trait/tavernbrawler
	name = "Tavern Brawler"
	greet_text = span_notice("I've always loved hitting people with things that aren't conventional weapons!")
	weight = 20

/datum/special_trait/tavernbrawler/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CIVILIZEDBARBARIAN, "[type]") //Need to make trait improve hitting people with chairs, mugs, goblets. <real

/datum/special_trait/noble
	name = "Noble Lineage"
	greet_text = span_notice("I've been born with, or have been granted nobility.")
	restricted_traits = list(TRAIT_NOBLE)
	weight = 100

/datum/special_trait/noble/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOBLE, "[type]")
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 2, TRUE)


/datum/special_trait/swift
	name = "Speedster"
	greet_text = span_notice("I've always been much faster than most, running does not tire me.")
	weight = 40

/datum/special_trait/swift/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DODGEEXPERT, "[type]")
	ADD_TRAIT(character, TRAIT_GOODRUNNER, "[type]")
	character.mind.adjust_skillrank(/datum/skill/misc/athletics, 6, TRUE)
	character.change_stat("speed", 3)


/datum/special_trait/gourmand
	name = "Gourmand"
	greet_text = span_notice("If it is edible, I can probably eat it.")
	weight = 100

/datum/special_trait/gourmand/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NASTY_EATER, "[type]")


/datum/special_trait/lucky
	name = "Lucky"
	greet_text = span_notice("Xylix smiles on me.")
	weight = 10

/datum/special_trait/lucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC = rand(15, 20)


/datum/special_trait/graggar_champion
	name = "Graggar's Little Champ"
	greet_text = span_notice("A life of devotion to Graggar has taught me how to chew through flesh and bone alike with ease.")
	req_text = "Worship Graggar"
	allowed_patrons = list(/datum/patron/inhumen/graggar)
	weight = 40

/datum/special_trait/graggar_champion/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_STRONGBITE, "[type]")


// Neutral Specials
/datum/special_trait/giant // Arguable if this is neutral anyway, think nobody dislikes getting it.
	name = "Giant"
	greet_text = span_notice("I've always been called a giant. I am valued for my stature, but, this world made for smaller folk has forced me to move cautiously.")
	req_text = "Not a seelie" //Don't remove this
	restricted_races = list(/datum/species/seelie)
	weight = 60

/datum/special_trait/giant/on_apply(mob/living/carbon/human/character)
	character.mob_size += 1
	ADD_TRAIT(character, TRAIT_DEATHBYSNUSNU, "[type]")
	character.change_stat("strength", 2)
	character.change_stat("constitution", 2)
	character.change_stat("speed", -2)
	character.transform = character.transform.Scale(1.25, 1.25)
	character.transform = character.transform.Translate(0, (0.25 * 16))
	character.update_transform()


/datum/special_trait/atheism
	name = "Atheist"
	greet_text = span_notice("I've lost all faith.")
	req_text = "Non-Church Role"
	restricted_jobs = list(CHURCH_ROLES, INQUISITION_ROLES)
	weight = 100

/datum/special_trait/atheism/on_apply(mob/living/carbon/human/character, silent)
	character.set_patron(/datum/patron/godless)

//Negative Specials
/datum/special_trait/nimrod
	name = "Nimrod"
	greet_text = span_boldwarning("For some reason, I am slower than most. I can't figure out why.")
	weight = 80

/datum/special_trait/nimrod/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("speed", -2)
	character.change_stat("intelligence", -4)

/datum/special_trait/heretic
	name = "Known Heretic"
	greet_text = span_boldwarning("I've been denounced by the church for either reasons legitimate or not!")
	req_text = "Non-Church role"
	weight = 100
	restricted_jobs = list(CHURCH_ROLES, INQUISITION_ROLES)

/datum/special_trait/heretic/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.real_name
	character.add_stress(/datum/stressevent/psycurse)
	character.devotion?.excommunicate()

/datum/special_trait/hunted
	name = "Hunted"
	greet_text = span_boldwarning("Someone put a bounty on my head!")
	weight = 100

/datum/special_trait/hunted/on_apply(mob/living/carbon/human/character, silent)
	var/reason = ""
	var/employer = "unknown employer"
	var/employer_gender
	if(prob(65))
		employer_gender = MALE
	else
		employer_gender = FEMALE
	if(employer_gender == MALE)
		employer = pick(list("Baron", "Lord", "Nobleman", "Heir"))
	else
		employer = pick(list("Duchess", "Lady", "Noblelady", "Heiress"))
	employer = "[employer] [random_human_name(employer_gender, FALSE, FALSE)]"
	var/amount = rand(40,100)
	switch(rand(1,7))
		if(1)
			reason = "Murder"
		if(2)
			reason = "Kinslaying"
		if(3)
			reason = "Besmirching a Noble's name"
		if(4)
			reason = "Treason"
		if(5)
			reason = "Arson"
		if(6)
			reason = "Heresy"
		if(7)
			reason = "Robbing a Noble"
	add_bounty(character.real_name, amount, FALSE, reason, employer)
	if(!silent)
		to_chat(character, span_notice("Whether I've done it or not, I have been accused of [reason] and the [employer] put a bounty on my head!"))

/datum/special_trait/heretic/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.real_name
	character.add_stress(/datum/stressevent/psycurse)
	character.devotion?.excommunicate()

/datum/special_trait/outlaw
	name = "Known Outlaw"
	greet_text = span_boldwarning("Whether for crimes I've done or was accused of, I have been declared an outlaw!")
	weight = 100

/datum/special_trait/outlaw/on_apply(mob/living/carbon/human/character, silent)
	make_outlaw(character.real_name, TRUE)


/datum/special_trait/unlucky
	name = "Unlucky"
	greet_text = span_boldwarning("Ever since I knocked over that glass vase, I just feel... off.")
	weight = 60

/datum/special_trait/unlucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC -= rand(1, 10)


/datum/special_trait/jesterphobia
	name = "Jesterphobic"
	greet_text = span_boldwarning("I have a severe, irrational fear of Jesters!")
	weight = 80

/datum/special_trait/jesterphobia/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_JESTERPHOBIA, "[type]")


/datum/special_trait/wild_night
	name = "Wild Night"
	greet_text = span_boldwarning("I don't remember what I did last night, and now I'm lost!")
	weight = 100

/datum/special_trait/wild_night/on_apply(mob/living/carbon/human/character, silent)
	var/turf/location = get_spawn_turf_for_job("Refugee")
	character.forceMove(location)
	grant_lit_torch(character)

/datum/special_trait/nude_sleeper
	name = "Nude Sleeper"
	greet_text = span_boldwarning("I just can't seem to fall asleep unless I'm <i>truly</i> comfortable...")
	weight = 100

/datum/special_trait/nude_sleeper/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NUDE_SLEEPER, "[type]")


/datum/special_trait/annoying
	name = "Annoying"
	greet_text = span_boldwarning("People just don't seem to like me... I want to cry...")
	weight = 80

/datum/special_trait/annoying/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_COMICSANS, "[type]")


/datum/special_trait/missing_nose
	name = "Missing Nose"
	greet_text = span_boldwarning("I lost my nose in combat. This makes breathing difficult.")
	weight = 40

/datum/special_trait/missing_nose/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_MISSING_NOSE, "[type]")


/datum/special_trait/frail
	name = "Frail"
	greet_text = span_boldwarning("My bones and flesh seem exceptionally fragile...")
	weight = 60

/datum/special_trait/frail/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CRITICAL_WEAKNESS, "[type]")


/datum/special_trait/leper
	name = "Leper"
	greet_text = span_boldwarning("I'm a disgusting leper...")
	weight = 10

/datum/special_trait/leper/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_LEPROSY, "[type]")


// Job Specials
/datum/special_trait/my_precious
	name = "My Precious"
	greet_text = span_notice("The ring, it's so shiny.. so valuable, I can feel it's power. It's all mine!")
	req_text = "Be a beggar"
	allowed_jobs = list(/datum/job/roguetown/beggar)
	weight = 10

/datum/special_trait/my_precious/on_apply(mob/living/carbon/human/character, silent)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, rand(1,3), TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, rand(1,3), TRUE)
	ADD_TRAIT(character, TRAIT_STRONGBITE, "[type]") // It's literally Smeagol. This trait is supposed to be positive. Give the walking pinata some sort of way to protect that ring.
	QDEL_NULL(character.wear_pants)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.head)
	var/obj/item/ring = new /obj/item/clothing/ring/dragon_ring(get_turf(character))
	ring.desc = "The name of [character.real_name] can be seen engraved on ring's inner side."
	character.put_in_hands(ring, forced = TRUE)


/datum/special_trait/reps_redemption
	name = "Reps for Redemption"
	greet_text = span_notice("Pain has finally transformed into gain.")
	req_text = "Be a Church Role"
	allowed_jobs = list(CHURCH_ROLES, INQUISITION_ROLES)
	weight = 60

/datum/special_trait/reps_redemption/on_apply(mob/living/carbon/human/character)
	character.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	character.change_stat("strength", 2)
	character.change_stat("constitution", 2)
	character.change_stat("speed", -2)


/datum/special_trait/seed_feed
	name = "Seed & Feed"
	greet_text = span_notice("Armed with seeds and the unwavering belief that sharing is mandatory. Bag safely stashed, until the next seed-worthy moment arises.")
	req_text = "Be a Druid, Soilson, Towner or Refugee."
	allowed_jobs = list(/datum/job/roguetown/farmer, /datum/job/roguetown/refugee, /datum/job/roguetown/towner, /datum/job/roguetown/druid)
	weight = 100

/datum/special_trait/seed_feed/on_apply(mob/living/carbon/human/character)
	character.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	character.mind.special_items["The Bag"] = /obj/item/storage/roguebag/seedfeed
	character.mind.special_items["The Sickle"] = /obj/item/rogueweapon/sickle


/datum/special_trait/runic_faith
	name = "Runic Faith"
	greet_text = span_notice("I keep two runelocks on me at all times. Sadly I forgot to load them today.")
	req_text = "Be a Priest or Priestess"
	allowed_jobs = list(/datum/job/roguetown/priest)
	weight = 10

/datum/special_trait/runic_faith/on_apply(mob/living/carbon/human/character, silent)
	character.equip_to_slot_or_del(new /obj/item/gun/ballistic/revolver/grenadelauncher/runelock, SLOT_BELT_L)
	character.equip_to_slot_or_del(new /obj/item/gun/ballistic/revolver/grenadelauncher/runelock, SLOT_BELT_R)
	character.mind.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
