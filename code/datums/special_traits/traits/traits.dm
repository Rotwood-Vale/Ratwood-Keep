//// Sleep Specials
//// these should still be in the round-start/late join specials as well! It's just these are contextually fitting for Sleep Specials as well!
/datum/special_trait/nothing
	name = "Nothing"
	greet_text = span_notice("You get <b>NOTHING</b>! you <b>LOSE</b>! Good dae, Sire!")
	weight = 10

//Temporary positives concept book

///datum/special_trait/tiny
//	name = "Freak of Nature"
//	greet_text = span_notice("How the hell did he even manage to get a seelie pregnant?")
//	weight = x

///datum/special_trait/tiny/on_apply(mob/living/carbon/human/character, silent)


///datum/special_trait/ultra_based_mule_rework_where_its_basically_illicit_merchant_but_whitevein? *waggles eyebrows
//	name = "Mule"
//	greet_text = span_notice("I've been running rounds for the Nightmaster, recently I've gotten my hands on a pretty interesting little gem. Perhaps I should consider .")
//	weight = 100

///datum/special_trait/mule/on_apply(mob/living/carbon/human/character, silent)
//	character.mind.special_items["Stash One"] = /obj/item/storage/backpack/rogue/satchel/mule
//	character.mind.special_items["Stash Two"] = /obj/item/storage/backpack/rogue/satchel/mule
//	character.mind.special_items["Dagger"] = /obj/item/rogueweapon/huntingknife/idagger
//	character.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 2, TRUE)
//	portable purity gem? 'CLARITY'?


/datum/special_trait/thinker
	name = "The Thinker"
	greet_text = "Physique, Endurance, Constitution. The trinity of what builds a great leader and an even greater kingdom... or whatever those nimrods were yapping about! <b>I cast FIREBALL!!!</b>"
	req_text = "Ruler, worship Noc"
	weight = 10
	allowed_sexes = list(MALE)
	allowed_patrons = list(/datum/patron/divine/noc)
	allowed_jobs = list(/datum/job/roguetown/ruler)
	restricted_traits = list(TRAIT_SPELLCOCKBLOCK)

/datum/special_trait/thinker/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("strength" -3)
	character.change_stat("intelligence" +5)
	
	character.mind.adjust_spellpoints(6)
	character.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
	var/obj/item/orb = new /obj/item/scrying(get_turf(character))



/datum/special_trait/warhorse

/datum/special_trait/warhorse/on_apply(mob/living/carbon/human/character, silent)

// Positive
/datum/special_trait/tough
	name = "Tough"
	greet_text = span_notice("Father always said - The best defence is a good offence... Until mother knocked some sense into him with a rolling pin, that is. Momma was always a great teacher.")
	weight = 80

/datum/special_trait/tough/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CRITICAL_RESISTANCE, "[type]")


/datum/special_trait/alert
	name = "Alert"
	greet_text = span_notice("Those cheap tricks? I've seen it all and then some more. Nobody- No... <b>Nothing</b> can surprise me.")
	weight = 100

/datum/special_trait/alert/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("perception", 2)
	ADD_TRAIT(character, TRAIT_BREADY, "[type]")


/datum/special_trait/aboriginal
	name = "Aboriginal Roots"
	greet_text = span_notice("My distant ancestors had to cope with Enigma's hardships long before colonization, the lack of need to eat or breathe is my family's most guarded secret. Some dare call it inhumen magic, I'd prefer \"Taming the land\".")
	restricted_jobs = list(INQUISITION_ROLES)
	weight = 80

/datum/special_trait/aboriginal/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(character, TRAIT_NOBREATH, "[type]")
	ADD_TRAIT(character, TRAIT_NOSTINK, "[type]")


/datum/special_trait/desensitized
	name = "Desensitized"
	greet_text = span_notice("Living in a shithole such as this sad island really builds character, no?")
	weight = 100

/datum/special_trait/desensitized/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOMOOD, "[type]")
	ADD_TRAIT(character, TRAIT_NOSTINK, "[type]")


/datum/special_trait/scrooge
	name = "Scrooge"
	greet_text = span_notice("Mammon runs Enigma and <b>I</b> happen to be one of the lucky ones who know how mammon <b>really</b> works. I always store my mammon in the safest of places.")
	weight = 80

/datum/special_trait/scrooge/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_SEEPRICES, "[type]")
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 3, TRUE)
	character.mind.special_items["My mammon"] = /obj/item/storage/belt/rogue/pouch/coins/poor
	character.mind.special_items["More of my mammon"] = /obj/item/storage/belt/rogue/pouch/coins/mid
	character.mind.special_items["A pouch for my mammon"] = /obj/item/storage/belt/rogue/pouch


/datum/special_trait/assassin
	name = "Apprentice Assassin"
	greet_text = span_notice("I've always been an outlier. Even from a young age, socialite activities weren't for me. Be it fate or luck - I ended up in the ranks of one of the many assassin guilds that poliferate this rotten world.")
	weight = 60

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
	weight = 80

/datum/special_trait/lightfooted/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_LIGHT_STEP, "[type]")
	character.change_stat("speed", 1)
	character.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)


/datum/special_trait/night_owl
	name = "Night Owl"
	greet_text = span_notice("I've always preferred Noc over her sister.")
	weight = 100

/datum/special_trait/night_owl/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NIGHT_OWL, "[type]")


/datum/special_trait/beautiful
	name = "Beautiful"
	greet_text = span_notice("My face is a work of art.")
	weight = 100

/datum/special_trait/beautiful/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BEAUTIFUL, "[type]")


/datum/special_trait/duelist
	name = "Ambitious Swordsman"
	greet_text = span_notice("I've traveled from land to land for months, treaded over countless corpses; challenged tyrants and heroes alike, slain entire retinues and inhumen warbands, yet I still stand. Perhaps a worthy opponent lives gere, on Enigma...? Mmmaybe I could use a little break, though...")
	weight = 30
	

/datum/special_trait/duelist/on_apply(mob/living/carbon/human/character, silent)
	character.cmode_music = 'sound/music/combat_duelist.ogg'
	character.change_stat("speed", pick(0,1,1,1,1,2))
	character.change_stat("endurance", pick(0,1,1,2,3))
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, pick(5,6,6), TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, pick(1,2,2,2,3), TRUE)
	switch(rand(1,101))
		if(1 to 24)
			character.mind.special_items["my sword"] = /obj/item/rogueweapon/sword
			to_chat(character, span_notice("That old piece of junk... I think I left it in a tree?..."))
		if(25 to 44)
			character.mind.special_items["my sword"] = /obj/item/rogueweapon/sword/rapier
			to_chat(character, span_notice("Where did I put that damned thing again? Right, the woods..,"))
		if(45 to 60)
			character.mind.special_items["my sword"] = /obj/item/rogueweapon/sword/long
			to_chat(character, span_notice("I need to get my sword from that tree."))
		if(61 to 74)
			character.mind.special_items["my sword"] = /obj/item/rogueweapon/sword/long/heirloom
			to_chat(character, span_notice("Shit. I'm going to shame my entire bloodline if I really lost that thing. Wait... Right! The tree!"))
		if(75 to 85)
			character.mind.special_items["my sword"] = /obj/item/rogueweapon/greatsword/zwei
			to_chat(character, span_notice("There is just no way I lost a fucking zweihander. I should check that tree I slept in."))
		if(86 to 93)
			character.mind.special_items["my sword"] = /obj/item/rogueweapon/estoc
			to_chat(character, span_notice("Well... Stabbing through plate might be a challenge without that estoc... Where did I leave it..."))
		if(94 to 97)
			character.mind.special_items["my sword"] = /obj/item/rogueweapon/sword/long/vlord
			to_chat(character, span_notice("Hmmm... Didn't I kill that annoying deadite two weeks ago...?"))
		if(98 to 100)
			character.mind.special_items["my sword"] = /obj/item/rogueweapon/sword/long/judgement
			to_chat(character, span_notice("It's in the tree."))
		else
			character.mind.special_items["my toothpick"] = /obj/item/rogueweapon/sword/short/legendary
			to_chat(character, span_notice("Think something's stuck in my teeth, back to that tree..."))


/datum/special_trait/eagle_eyed
	name = "Eagle Eyed"
	greet_text = span_notice("I'd like to see them fire that obnoxiously loud stick with a bolt through their skull. I don't miss.")
	weight = 30

/datum/special_trait/eagle_eyed/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("perception", 2)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/crossbows, 5, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/bows, 4, TRUE)
	character.mind.special_items["Crossbow"] = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	character.mind.special_items["Bolts"] = /obj/item/ammo_holder/quiver/bolts


/datum/special_trait/seduction_artist
	name = "Seduction Artist"
	greet_text = span_notice("I learned to wrap weak willed people around my finger through sex-appeal! I also picked up a few words from my last partner's language!")
	weight = 100

/datum/special_trait/seduction_artist/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_GOODLOVER, "[type]")
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/riding, 4, TRUE)
	switch(rand(1,6))
		if(1)
			character.grant_language(/datum/language/elvish)
		if(2)
			character.grant_language(/datum/language/hellspeak)
		if(3)
			character.grant_language(/datum/language/draconic)
		if(4)
			character.grant_language(/datum/language/dwarvish)
		if(5)
			character.grant_language(/datum/language/orcish)
		if(6)
			character.grant_language(/datum/language/celestial)


/datum/special_trait/corn_fed
	name = "Corn Fed"
	greet_text = span_notice("My diet was quite rich in corn.")
	weight = 100

/datum/special_trait/corn_fed/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("constitution", 2)
	character.change_stat("intelligence", -2)


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
	var/counter = 1
	while(prob(40) && counter <= 3) // Stops you from getting more than 4 bombs total
		character.mind.special_items["firebomb [counter]"] = /obj/item/bomb
		counter++


/datum/special_trait/pineapple
	name = "The safeword is 'Pineapple'"
	greet_text = span_notice("I enjoy whipping people until they squirm and whine, their pain makes my pleasure. I'll need to grab my toy from that one tree.")
	weight = 30

/datum/special_trait/pineapple/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Whip"] = /obj/item/rogueweapon/whip
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 6, TRUE)

/datum/special_trait/psydons_rider
	name = "Psydon's Drunkest Rider"
	greet_text = span_notice("I ride! None shall stop me for that is Psydon's divine will!")
	req_text = "Worship Psydon"
	allowed_patrons = list(/datum/patron/psydon)
	weight = 100

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
	weight = 100

/datum/special_trait/packed_lunch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/bag = new /obj/item/storage/roguebag/lunch(get_turf(character))
	character.put_in_hands(bag, forced = TRUE)
	bag.update_icon()

/datum/special_trait/spring_in_my_step
	name = "Spring in my Step"
	greet_text = span_notice("My legs are quite strong and where most have to climb, I can just jump")
	weight = 25

/datum/special_trait/spring_in_my_step/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_ZJUMP, "[type]")

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


/datum/special_trait/civilizedbarbarian
	name = "Tavern Brawler"
	greet_text = span_notice("I am <b>not</b> an aggressive drunk! Who the hell is spouting slander about me? I'm going over there to show them what's up! ... Oh? What?... You want some too?!")
	weight = 100

/datum/special_trait/civilizedbarbarian/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC) //Need to make trait improve hitting people with chairs, mugs, goblets. <real


/datum/special_trait/jackofalltrades
	name = "John of Most Trades" // that 'master craftsman' couldn't ever even /hope/ to lick a Master's boots, leave!
	greet_text = span_notice("In my youth, I've decided I'd try a little bit of everything, I turned out quite the versatile craftsman, if I do say so myself.")
	weight = 80

/datum/special_trait/jackofalltrades/on_apply(mob/living/carbon/human/character)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/blacksmithing, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/masonry, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/engineering, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/hunting, 2, TRUE)


/datum/special_trait/truejackofalltrades
	name = "Jack of All Trades"
	greet_text = span_notice("In my youth, I've decided I'd try a little bit of everything, I turned out quite the versatile cr- woaahhh.. Deja vu...")
	req_text = "Middle-Aged or Old"
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	weight = 60

/datum/special_trait/truejackofalltrades/on_apply(mob/living/carbon/human/character)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/blacksmithing, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/masonry, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/engineering, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/hunting, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/labor/farming, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/labor/mining, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/labor/fishing, 3, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/labor/lumberjacking, 3, TRUE)

/datum/special_trait/noble
	name = "Noble Lineage"
	greet_text = span_notice("I come of noble blood.")
	restricted_traits = list(TRAIT_NOBLE)
	weight = 100

/datum/special_trait/noble/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOBLE, "[type]")
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 2, TRUE)

/datum/special_trait/rich
	name = "Rich"
	greet_text = span_notice("I've recently found a pouch filled with mammons, probably belonging to some noble.")
	weight = 100

/datum/special_trait/richpouch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/pouch = new /obj/item/storage/belt/rogue/pouch/coins/rich(get_turf(character))
	character.put_in_hands(pouch, forced = TRUE)

/datum/special_trait/swift
	name = "Speedster"
	greet_text = span_notice("I feel like the fastest person alive and I can probably dodge anything, as long as I'm not weighed down by medium or heavy armor")
	weight = 50

/datum/special_trait/swift/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DODGEEXPERT, "[type]")
	ADD_TRAIT(character, TRAIT_GOODRUNNER, "[type]")
	character.mind.adjust_skillrank(/datum/skill/misc/athletics, 6, TRUE)
	character.change_stat("speed", 3)


/datum/special_trait/gourmand
	name = "Gourmand"
	greet_text = span_notice("These ignorant fools could never even dream to rival my refined palate. Food is for eating and that's just what I'll do.")
	weight = 100

/datum/special_trait/gourmand/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NASTY_EATER, "[type]")


/datum/special_trait/lucky
	name = "Lucky"
	greet_text = span_notice("I feel like the luckiest person alive! Misfortune trembles as I pass her by on a dae to dae basis!")
	req_text = "Worship Xylix"
	allowed_patrons = list(/datum/patron/divine/xylix)
	weight = 10

/datum/special_trait/lucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC = rand(15, 20) //In other words, In the next round following the special, you are effectively lucky.


//neutral
/datum/special_trait/giant
	name = "Giant"
	greet_text = span_notice("I've always been called a giant. I am valued for my stature, but, this world made for smaller folk has forced me to move cautiously.")
	req_text = "Not a kobold, seelie, verminvolk or a dwarf" //1984
	restricted_races = list(/datum/species/anthromorphsmall, /datum/species/dwarf/mountain, /datum/species/kobold, /datum/species/seelie)
	weight = 50

/datum/special_trait/giant/on_apply(mob/living/carbon/human/character)
	character.mob_size += 1
	character.change_stat("strength", 2)
	character.change_stat("constitution", 2)
	character.change_stat("speed", -2)
	character.transform = character.transform.Scale(1.25, 1.25)
	character.transform = character.transform.Translate(0, (0.25 * 16))
	character.update_transform()


/datum/special_trait/atheism
	name = "Atheist"
	greet_text = span_notice("God is dead.")
	req_text = "Non-Church Role"
	restricted_jobs = list(CHURCH_ROLES, INQUISITION_ROLES)
	weight = 100

/datum/special_trait/atheism/on_apply(mob/living/carbon/human/character, silent)
	character.set_patron(/datum/patron/godless)


//negative
/datum/special_trait/nimrod //by the old, very weird, in my opinion, very unnecessary  template of making the typepath something completely different than the name of the special, I do wonder, whatever stopped you guys from making this typepath /re- *gets BRUTALLY DECAPITATED!
	name = "Nimrod"
	greet_text = span_boldwarning("In the past I learned slower than my peers, I can't even lace my shoes.")
	weight = 100

/datum/special_trait/nimrod/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("speed", -2)
	character.change_stat("intelligence", -4)

/datum/special_trait/heretic
	name = "Known Heretic"
	greet_text = span_boldwarning("I've been denounced by the church for either reasons legitimate or not!")
	req_text = "Non-Church role"
	weight = 100
	restricted_jobs = list(CHURCH_ROLES, INQUISITION_ROLES)

/datum/special_trait/hussite/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.real_name
	character.add_stress(/datum/stressevent/psycurse)
	character.devotion.excommunicate()

/datum/special_trait/bounty
	name = "Hunted Man"
	greet_text = span_boldwarning("Someone put a bounty on my head!")
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
		to_chat(character, span_notice("Whether I done it or not, I have been accused of [reason] and the [employer] put a bounty on my head!"))

/datum/special_trait/outlaw
	name = "Known Outlaw"
	greet_text = span_boldwarning("Whether for crimes I did or was accused of, I have been declared an outlaw!")
	weight = 100

/datum/special_trait/outlaw/on_apply(mob/living/carbon/human/character, silent)
	make_outlaw(character.real_name, TRUE)


/datum/special_trait/unlucky
	name = "Unlucky"
	greet_text = span_boldwarning("Ever since you knocked over that glass vase, you just feel... off.")
	weight = 25

/datum/special_trait/unlucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC -= rand(1, 10)

/datum/special_trait/jesterphobia
	name = "Jesterphobic"
	greet_text = span_boldwarning("I have a severe, irrational fear of Jesters!")
	weight = 50

/datum/special_trait/jesterphobia/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_JESTERPHOBIA, "[type]")

/datum/special_trait/xenophobic
	name = "Xenophobic"
	greet_text = span_boldwarning("Lesser races pollute our land!")
	weight = 200

/datum/special_trait/xenophobic/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_XENOPHOBIC, "[type]")

/datum/special_trait/wild_night
	name = "Wild Night"
	greet_text = span_boldwarning("I don't remember what I did last night, and now I'm lost!")
	weight = 200

/datum/special_trait/wild_night/on_apply(mob/living/carbon/human/character, silent)
	var/turf/location = get_spawn_turf_for_job("Refugee")
	character.forceMove(location)
	grant_lit_torch(character)

/datum/special_trait/atrophy
	name = "Atrophy"
	greet_text = span_boldwarning("When growing up I could barely feed myself... this left me weak and fragile.")
	weight = 50

/datum/special_trait/atrophy/on_apply(mob/living/carbon/human/character)
	character.change_stat("strength", -2)
	character.change_stat("constitution", -2)
	character.change_stat("endurance", -1)

/datum/special_trait/lazy
	name = "Lazy"
	greet_text = span_boldwarning("I don't care, never did.")
	weight = 200

/datum/special_trait/lazy/on_apply(mob/living/carbon/human/character)
	character.change_stat("strength", -1)
	character.change_stat("constitution", -1)
	character.change_stat("endurance", -1)
	character.change_stat("speed", -1)
	character.change_stat("perception", -1)

/datum/special_trait/bad_week
	name = "Bad Week"
	greet_text = span_boldwarning("Everything just seems to piss me off!")
	weight = 100

/datum/special_trait/bad_week/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BAD_MOOD, "[type]")

/datum/special_trait/nude_sleeper
	name = "Picky Sleeper"
	greet_text = span_boldwarning("I just can't seem to fall asleep unless I'm <i>truly</i> comfortable...")
	weight = 50

/datum/special_trait/nude_sleeper/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NUDE_SLEEPER, "[type]")

//job specials
/datum/special_trait/punkprincess //I think everyone will like the Rebellous Prince-Like Princess. I'd love to do one for the prince as well that gives him princess loadout, but, up to you!
	name = "Rebellous Daughter"
	greet_text = span_notice("I am quite rebellious for a noblewoman. Screw Noble Customs!")
	req_text = "Be a princess"
	allowed_sexes = list(FEMALE)
	allowed_jobs = list(/datum/job/roguetown/prince)
	weight = 50

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
	character.equip_to_slot_or_del(new /obj/item/clothing/shoes/roguetown/armor/nobleboot(character), SLOT_SHOES)
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

/datum/special_trait/my_precious
	name = "My Precious"
	greet_text = span_notice("The ring, it's so shiny.. so valuable, I can feel it's power. It's all mine!")
	req_text = "Be a beggar"
	allowed_jobs = list(/datum/job/roguetown/beggar)
	weight = 50

/datum/special_trait/my_precious/on_apply(mob/living/carbon/human/character, silent)
	QDEL_NULL(character.wear_pants)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.head)
	var/obj/item/ring = new /obj/item/clothing/ring/dragon_ring(get_turf(character))
	ring.desc = "The name of [character.real_name] can be seen engraved on ring's inner side."
	character.put_in_hands(ring, forced = TRUE)

/datum/special_trait/illicit_merchant
	name = "Illicit Merchant"
	greet_text = span_notice("I'm sick of working as an underling, I will start my own trade emporium. I've got my hands on a hidden merchant key and a curious magical device.")
	req_text = "Be a Shophand"
	allowed_jobs = list(/datum/job/roguetown/shophand)
	weight = 100

/datum/special_trait/illicit_merchant/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Merchant Key"] = /obj/item/key/merchant
	character.mind.special_items["GOLDFACE Gem"] = /obj/item/gem_device/goldface

/datum/special_trait/reps_redemption
	name = "Reps for Redemption"
	greet_text = span_notice("Pain has finally transformed into gain.")
	req_text = "Be a Church Role"
	allowed_jobs = list(CHURCH_ROLES, INQUISITION_ROLES)
	weight = 50

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

//Keep that thang on ye, Priest, for the wicked folk will arrive soon.
/datum/special_trait/priest_akimbo
	name = "Runic Faith"
	greet_text = span_notice("I keep two runelocks at me at all times. Unloaded, of course.")
	req_text = "Be a Priest or Priestess"
	allowed_jobs = list(/datum/job/roguetown/priest)
	weight = 5

/datum/special_trait/priest_akimbo/on_apply(mob/living/carbon/human/character, silent)
	character.equip_to_slot_or_del(new /obj/item/gun/ballistic/revolver/grenadelauncher/runelock, SLOT_BELT_L)
	character.equip_to_slot_or_del(new /obj/item/gun/ballistic/revolver/grenadelauncher/runelock, SLOT_BELT_R)
	character.mind.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
