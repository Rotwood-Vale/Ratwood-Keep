//// Odds for positive are as follows: 200-Kinda good. 100-Dope. 50-Strong as shit. 10-Blatantly OP.
//// Odds for negative: 200-Who cares? 100-Sucks. 50-Fucking awful. 10-Unplayable.
/datum/special_trait/nothing
	name = "Nothing"
	greet_text = span_notice("You're not special")
	weight = 0 

/datum/special_trait/nightvision
	name = "Night Vision"
	greet_text = span_notice("Darkness is unbeknownst to me.")
	weight = 100

/datum/special_trait/nightvision/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/organ/eyes/eyes = character.getorganslot(ORGAN_SLOT_EYES)
	if(!eyes)
		return
	eyes.see_in_dark = 3
	eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	character.update_sight()
	character.change_stat("perception", 2)

/datum/special_trait/thickskin
	name = "Tough"
	greet_text = span_notice("My thick skin, dense flesh, durable bones...The Enigma can't break me.")
	weight = 150

/datum/special_trait/thickskin/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BREADY, "[type]")
	character.change_stat("constitution", 4)

/datum/special_trait/curseofcain
	name = "Flawed Immortality"
	greet_text = span_notice("What...happened...to me..? Am I...even alive..?")
	weight = 50

/datum/special_trait/curseofcain/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(character, TRAIT_NOBREATH, "[type]")
	ADD_TRAIT(character, TRAIT_TOXIMMUNE, "[type]")
	ADD_TRAIT(character, TRAIT_EASYDISMEMBER, "[type]")
	ADD_TRAIT(character, TRAIT_BLOODLOSS_IMMUNE, "[type]")
	ADD_TRAIT(character, TRAIT_NOSLEEP, "[type]")
	ADD_TRAIT(character, TRAIT_NOMOOD, "[type]")

/datum/special_trait/deadened
	name = "Deadened"
	greet_text = span_notice("Ever since Astratan magic brought me back from death, I haven't been able to feel anything. Inside or out.")
	weight = 50

/datum/special_trait/deadened/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOMOOD, "[type]")
	ADD_TRAIT(character, TRAIT_CRITICAL_RESISTANCE, "[type]")
	ADD_TRAIT(character, TRAIT_NOPAIN, "[type]")
	ADD_TRAIT(character, TRAIT_NOPAINSTUN, "[type]")

/datum/special_trait/value
	name = "Eyes of Horuz"
	greet_text = span_notice("With just a glance I can weigh the worth of all things.")
	weight = 200
	restricted_traits = list(TRAIT_SEEPRICES)

/datum/special_trait/value/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_SEEPRICES, "[type]")
	character.change_stat("fortune", 2)

/datum/special_trait/lightstep
	name = "Feather-footed"
	greet_text = span_notice("I've always wondered if I was blessed by Xylix, as no one could ever hear my steps.")
	weight = 100

/datum/special_trait/lightstep/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_LIGHT_STEP, "[type]")
	character.change_stat("speed", 1)

/datum/special_trait/night_owl
	name = "Nite Owl"
	greet_text = span_notice("Noc is so beautiful. I always feel happy to gaze upon them in the nite sky.")
	weight = 200

/datum/special_trait/night_owl/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NIGHT_OWL, "[type]")
	character.change_stat("perception", 1)

/datum/special_trait/beautiful
	name = "Beautiful"
	greet_text = span_notice("Eora blessed me from birth with striking beauty. In this land? I'm a marvel among the unclean.")
	weight = 200

/datum/special_trait/beautiful/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BEAUTIFUL, "[type]")
	character.change_stat("fortune", 3)

//positive
/datum/special_trait/duelist
	name = "Weaponsmaster's Tutelage"
	greet_text = span_notice("I was the student of a legendary weaponsmaster for many years. There is no weapon of war I haven't sparred with a thousand times. My skill is rivalled by few in this world. I've also hidden my dead master's heirloom, who has passed it down to me to wield.")
	weight = 50

/datum/special_trait/duelist/on_apply(mob/living/carbon/human/character, silent)
	character.cmode_music = 'sound/music/combat_duelist.ogg'
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 5, TRUE) //will make a unique trait later on
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 5, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/axes, 5, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 5, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 5, TRUE)
	character.mind.special_items["Rapier"] = /obj/item/rogueweapon/sword/rapier/dec

/datum/special_trait/eagle_eyed
	name = "Crow's eye"
	greet_text = span_notice("I can spot distant objects far before others. My talent for weapons of range is enhanced far beyond a normal man's because of this. I should get my gear I hid away.")
	weight = 50

/datum/special_trait/eagle_eyed/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("perception", 4)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/crossbows, 5, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/bows, 5, TRUE)
	character.mind.special_items["Crossbow"] = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	character.mind.special_items["Bolts"] = /obj/item/quiver/bolts

/datum/special_trait/mule
	name = "Mule"
	greet_text = span_notice("Spice, dust, ozzy...Anything they're buyin', I'm sellin'. I got a stash hidden away...I think...what tree was it again..?")
	weight = 200

/datum/special_trait/mule/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Stash One"] = /obj/item/storage/backpack/rogue/satchel/mule
	character.mind.special_items["Stash Two"] = /obj/item/storage/backpack/rogue/satchel/mule
	character.mind.special_items["Dagger"] = /obj/item/rogueweapon/huntingknife/idagger
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)

/datum/special_trait/cunning_linguist
	name = "Cunning Linguist"
	greet_text = span_notice("I've picked up another language from my travels, and it opens many legs for me.")
	weight = 200

/datum/special_trait/cunning_linguist/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_GOODLOVER, "[type]")
	character.change_stat("fortune", 2)
	switch(rand(1,3))
		if(1)
			character.grant_language(/datum/language/elvish)
		if(2)
			character.grant_language(/datum/language/hellspeak)
		if(3)
			character.grant_language(/datum/language/draconic)

/datum/special_trait/corn_fed
	name = "Corn Fed"
	greet_text = span_notice("I was born on the cob.")
	weight = 150

/datum/special_trait/corn_fed/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("constitution", 6)
	character.change_stat("intelligence", -3)

/datum/special_trait/bookworm
	name = "Bookworm"
	greet_text = span_notice("I've read tons of books ever since I was young. Maybe I'll become an archivist one day.")
	weight = 25 // Lame special. Buffed for incredibly low odds.

/datum/special_trait/bookworm/on_apply(mob/living/carbon/human/character, silent)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 6, TRUE)
	character.change_stat("intelligence", 10)

/datum/special_trait/arsonist
	name = "Arsonist"
	greet_text = span_notice("I used to want to be an Astratan, before they shunned me for my fervent adoration of burnt flesh. Now I just want to see it all burn. I tossed my bombs behind a statue before the guards searched me.")
	weight = 150

/datum/special_trait/arsonist/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Firebomb One"] = /obj/item/bomb
	character.mind.special_items["Firebomb Two"] = /obj/item/bomb
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/alchemy, 3, TRUE)

/datum/special_trait/pineapple
	name = "The safeword is \"Pineapple\""
	greet_text = span_notice("I enjoy whipping people until they squirm and whine, their pain makes my pleasure. I also have a hidden a whip, and a special drink.")
	weight = 50

/datum/special_trait/pineapple/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["The carrot"] = /obj/item/slimepotion/lovepotion
	character.mind.special_items["The stick"] = /obj/item/rogueweapon/whip
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 6, TRUE)

/datum/special_trait/psydons_rider
	name = "Psydon's Drunkest Rider"
	greet_text = span_notice("I ride! None of the laws shall stop me for that is Psydon's divine will!")
	req_text = "Worship Psydon"
	allowed_patrons = list(/datum/patron/old_god)
	weight = 75

/datum/special_trait/psydons_rider/on_apply(mob/living/carbon/human/character, silent)
	character.drunkenness = 50
	for(var/i in 1 to 2)
		var/obj/item/bottle = new /obj/item/reagent_containers/glass/bottle/rogue/wine(get_turf(character))
		character.put_in_hands(bottle, forced = TRUE)

	character.mind.adjust_skillrank_up_to(/datum/skill/misc/riding, 6, TRUE)
	new /mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame/saddled(get_turf(character))

/datum/special_trait/packed_lunch
	name = "Packed Lunch"
	greet_text = span_notice("I don't like going around hungry so I packed my lunch!")
	weight = 200

/datum/special_trait/packed_lunch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/bag = new /obj/item/storage/roguebag/lunch(get_turf(character))
	character.put_in_hands(bag, forced = TRUE)
	character.change_stat("endurance", 2) // healthy boy

/datum/special_trait/spring_in_my_step
	name = "Acrobatic"
	greet_text = span_notice("I can leap with great ease, even up heights!")
	weight = 75

/datum/special_trait/spring_in_my_step/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_ZJUMP, "[type]")

/datum/special_trait/tolerant
	name = "Tolerant"
	greet_text = span_notice("I dream of an ideal future, one with peace between all races.")
	weight = 200

/datum/special_trait/tolerant/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_TOLERANT, "[type]")
	character.change_stat("intelligence", 2)

/datum/special_trait/thief
	name = "Thief"
	greet_text = span_notice("It's hard to make a fortune, so I make mine by taking others'.")
	weight = 25 //Cringe special, reduced odds but buffed.

/datum/special_trait/thief/on_apply(mob/living/carbon/human/character, silent)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/stealing, 6, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 6, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 6, TRUE)

/datum/special_trait/languagesavant
	name = "Polyglot"
	greet_text = span_notice("I have always picked up on languages easily, even those that are forbidden to mortals.")
	weight = 50 // Cooler when more rare.

/datum/special_trait/languagesavant/on_apply(mob/living/carbon/human/character, silent)
	character.grant_language(/datum/language/dwarvish)
	character.grant_language(/datum/language/elvish)
	character.grant_language(/datum/language/hellspeak)
	character.grant_language(/datum/language/celestial)
	character.grant_language(/datum/language/orcish)
	character.grant_language(/datum/language/beast)
	character.grant_language(/datum/language/draconic)
	character.grant_language(/datum/language/faexin)

/datum/special_trait/civilizedbarbarian
	name = "Tavern Brawler"
	greet_text = span_notice("I used to have to fight my father, and my mother gave birth to me drunk. My fists were born to brawl.")
	weight = 100

/datum/special_trait/civilizedbarbarian/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("strength", 3)
	ADD_TRAIT(character, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC) //Need to make trait improve hitting people with chairs, mugs, goblets.

/datum/special_trait/mastercraftsmen
	name = "Master Craftsman"
	greet_text = "In my youth, I'd studied under every legendary tradeworker, and pursued the 10 arts of the craft."
	req_text = "Middle-aged or Old"
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	weight = 100

/datum/special_trait/mastercraftsmen/on_apply(mob/living/carbon/human/character)
	character.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/swords, -1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/maces, -1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/axes, -1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/polearms, -1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/bows, -1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/crossbows, -1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/whipsflails, -1, TRUE)

/datum/special_trait/bleublood
	name = "Noble Lineage"
	greet_text = span_notice("I come of noble blood.")
	restricted_traits = list(TRAIT_NOBLE)
	weight = 200

/datum/special_trait/bleublood/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOBLE, "[type]")
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 2, TRUE)
	character.change_stat("fortune", 3)

/datum/special_trait/richpouch
	name = "Lucky Find!"
	greet_text = span_notice("I've recently come across a small fortune! Who cares who this used to belong to, it's mine now!")
	weight = 150

/datum/special_trait/richpouch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/ring = new /obj/item/clothing/ring/diamond(get_turf(character))
	character.put_in_hands(ring, forced = TRUE)

/datum/special_trait/swift
	name = "Bottled Lightning"
	greet_text = span_notice("I'm the fastest person alive and I can probably dodge anything, as long as I'm not weighed down by medium or heavy armor.")
	weight = 50

/datum/special_trait/swift/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DODGEEXPERT, "[type]")
	ADD_TRAIT(character, TRAIT_GOODRUNNER, "[type]")
	character.mind.adjust_skillrank(/datum/skill/misc/athletics, 6, TRUE)
	character.change_stat("speed", 3)

/datum/special_trait/gourmand
	name = "Lead-bellied"
	greet_text = span_notice("I can stomach even the most spoiled, raw, or toxic food and water as if they were bread and wine.")
	weight = 200

/datum/special_trait/gourmand/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NASTY_EATER, "[type]")
	character.change_stat("constitution", 4) // If you can endure drinking sewage...

/datum/special_trait/lucky
	name = "Fortune's Grace"
	greet_text = span_notice("I am Xylix's champion. My luck knows no bounds.")
	req_text = "Have Xylix as your Patron"
	allowed_patrons = list(/datum/patron/divine/xylix)
	weight = 50

/datum/special_trait/lucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC = 20 //In other words, In the next round following the special, you are effectively lucky.

//neutral
/datum/special_trait/backproblems
	name = "Giant"
	greet_text = span_notice("I've always been called a giant. I am valued for my stature, but, this world made for smaller folk has forced me to move cautiously.")
	req_text = "Not a kobold, seelie, verminvolk or a dwarf"
	restricted_races = list(/datum/species/anthromorphsmall, /datum/species/dwarf/mountain, /datum/species/kobold, /datum/species/seelie)
	weight = 200

/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character)
	character.change_stat("strength", 5)
	character.change_stat("constitution", 5)
	character.change_stat("perception", -3)
	character.change_stat("endurance", 5)
	character.change_stat("intelligence", -3)
	character.change_stat("speed", -6)
	character.transform = character.transform.Scale(1.25, 1.25)
	character.transform = character.transform.Translate(0, (0.25 * 16))
	character.update_transform()

/datum/special_trait/atheism
	name = "Godless"
	greet_text = span_notice("The "gods" do not exist. Miracles and magic is just undiscovered nature of our world. Anyone who thinks otherwise is deluded.")
	req_text = "Non-Church Role"
	restricted_jobs = list(CHURCH_ROLES)
	weight = 200

/datum/special_trait/atheism/on_apply(mob/living/carbon/human/character, silent)
	character.set_patron(/datum/patron/godless)
	ADD_TRAIT(character, TRAIT_SPELLCOCKBLOCK, "[type]")
	ADD_TRAIT(character, TRAIT_ANTIMAGIC, "[type]") // Magic isn't real, idiot
	ADD_TRAIT(character, TRAIT_ASTRATA_CURSE, "[type]")

//negative
/datum/special_trait/nimrod
	name = "Nimrod"
	greet_text = span_boldwarning("i no tink gud")
	weight = 50

/datum/special_trait/nimrod/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("intelligence", -99)	

/datum/special_trait/hussite
	name = "Known Heretic"
	greet_text = span_boldwarning("I've been denounced by the church. I'd better not get injured.")
	req_text = "Non-church role"
	weight = 200
	restricted_jobs = list(CHURCH_ROLES)

/datum/special_trait/hussite/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.real_name

/datum/special_trait/bounty
	name = "Hunted Man"
	greet_text = span_boldwarning("I may not be a bandit, but my head carries it's weight in gold. I need to watch my back, or I'll be having raisin bread with the undermaiden.")
	weight = 300 // Funnest negative for overall server quality.

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
	var/amount = rand(200,300) // Maybe this will get players to actually do it
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
	greet_text = span_boldwarning("I have been declared an outlaw! Would it be suicide to try to turn myself in..?")
	weight = 200

/datum/special_trait/outlaw/on_apply(mob/living/carbon/human/character, silent)
	make_outlaw(character.real_name, TRUE)

/datum/special_trait/sillyvoice
	name = "Annoying"
	greet_text = span_sans("People really hate my voice for some reason.")
	weight = 50 //Annoying when too common, for other players.

/datum/special_trait/sillyvoice/on_apply(mob/living/carbon/human/character)
	ADD_TRAIT(character, TRAIT_COMICSANS, "[type]")
	ADD_TRAIT(character, TRAIT_LIMPDICK, "[type]") // No one is willing to fuck you
	character.dna.add_mutation(WACKY)

/datum/special_trait/unlucky
	name = "Unlucky"
	greet_text = span_boldwarning("I should never have dug that grave...")
	weight = 50

/datum/special_trait/unlucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC = 7 // This sucks super bad. Trust me.


/datum/special_trait/jesterphobia
	name = "Jesterphobic"
	greet_text = span_boldwarning("I have a severe, irrational fear of jesters.")
	weight = 200

/datum/special_trait/jesterphobia/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_JESTERPHOBIA, "[type]")

/datum/special_trait/xenophobic
	name = "Xenophobic"
	greet_text = span_boldwarning("GIT THEE WEERD FOOKIN THEENGS UUT MAH TOWN")
	weight = 200

/datum/special_trait/xenophobic/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_XENOPHOBIC, "[type]")
	ADD_TRAIT(character, TRAIT_BAD_MOOD, "[type]")
	character.change_stat("intelligence", -1)

/datum/special_trait/wild_night
	name = "Wild Night"
	greet_text = span_boldwarning("The last thing I remember, was a guy I met at a bar calling themself "Psydon's Champion" and riding around with them on a saiga...")
	weight = 200

/datum/special_trait/wild_night/on_apply(mob/living/carbon/human/character, silent)
	var/turf/location = get_spawn_turf_for_job("Pilgrim")
	character.forceMove(location)
	grant_lit_torch(character)
	character.drunkenness = 50

/datum/special_trait/atrophy
	name = "Atrophy"
	greet_text = span_boldwarning("When growing up I could barely feed myself...this has left my bones hollow, and even just the smallest injuries hurt. Bad.")
	weight = 100

/datum/special_trait/atrophy/on_apply(mob/living/carbon/human/character)
	character.change_stat("constitution", -7)

/datum/special_trait/lazy
	name = "Lazy"
	greet_text = span_boldwarning("I don't care. Never did.")
	weight = 50

/datum/special_trait/lazy/on_apply(mob/living/carbon/human/character)
	character.change_stat("speed", -5)

/datum/special_trait/bad_week
	name = "Bad Week"
	greet_text = span_boldwarning("Ever since a bastard nicked off my nose, I've been pissed beyond belief.")
	weight = 100

/datum/special_trait/bad_week/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BAD_MOOD, "[type]")
	ADD_TRAIT(character, TRAIT_STEELHEARTED, "[type]")
	ADD_TRAIT(character, TRAIT_MISSING_NOSE, "[type]")

/datum/special_trait/nude_sleeper
	name = "Picky Sleeper"
	greet_text = span_boldwarning("I just can't seem to fall asleep unless I'm <i>truly</i> comfortable...")
	weight = 25 // Annoying as hell.

/datum/special_trait/nude_sleeper/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NUDE_SLEEPER, "[type]")

//job specials
/datum/special_trait/punkprincess //I think everyone will like the Rebellous Prince-Like Princess. I'd love to do one for the prince as well that gives him princess loadout, but, up to you!
	name = "Rebellous Daughter"
	greet_text = span_notice("I am quite rebellious for a princess. Screw noble customs!")
	req_text = "Be a princess"
	allowed_sexes = list(FEMALE)
	allowed_jobs = list(/datum/job/roguetown/prince)
	weight = 100 // People don't like to do this one, so increased odds for fans to get it.

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
	character.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	character.mind.adjust_skillrank(/datum/skill/misc/reading, -4, TRUE)
	character.mind.adjust_skillrank(/datum/skill/misc/sneaking, -2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)

/datum/special_trait/vengantbum
	name = "Vengant Bum"
	greet_text = span_notice("I was once a nobleman, high on life until my father was murdered right in front of me. Thankfully, my mentor took me to safety and taught me all I needed to survive in these disgusting lands. They think I am a lowlife, but that's just an advantage.")
	req_text = "Be a beggar"
	allowed_jobs = list(/datum/job/roguetown/beggar)
	weight = 10

/datum/special_trait/vengantbum/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DECEIVING_MEEKNESS, "[type]")
	character.mind.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/unarmed, 6, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 6, TRUE) // Lol. Lmao.
	character.STASTR = 20
	character.STAPER = 20
	character.STACON = 20
	character.STAEND = 20

/datum/special_trait/my_precious
	name = "My Precious"
	greet_text = span_notice("Ehehehe! Shiny...shiny... NO TAKESIES!!")
	req_text = "Be a beggar"
	allowed_jobs = list(/datum/job/roguetown/beggar)
	weight = 25

/datum/special_trait/my_precious/on_apply(mob/living/carbon/human/character, silent)
	character.mind.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE)
	character.STASPD = 20 // Knights just steal the ring every round otherwise.
	QDEL_NULL(character.wear_pants)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.head)
	var/obj/item/ring = new /obj/item/clothing/ring/dragon_ring(get_turf(character))
	character.put_in_hands(ring, forced = TRUE)

/datum/special_trait/illicit_merchant
	name = "Illicit Merchant"
	greet_text = span_notice("I'm sick of working as an underling! I will start my own trade emporium, once I get my own goldface device from behind that statue.")
	req_text = "Be a Shophand"
	allowed_jobs = list(/datum/job/roguetown/shophand)
	weight = 100 // Job specials are optional. Increased odds.

/datum/special_trait/illicit_merchant/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Merchant Key"] = /obj/item/roguekey/merchant
	character.mind.special_items["GOLDFACE Gem"] = /obj/item/gem_device/goldface
