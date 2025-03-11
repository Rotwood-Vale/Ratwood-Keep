/datum/special_trait/nothing
	name = "Nothing"
	greet_text = span_notice("You get <b>NOTHING</b>! you <b>LOSE</b>! Good dae, Sire!")
	weight = 10


// Positive Specials
/datum/special_trait/tough
	name = "Tough"
	greet_text = span_notice("Father always said - The best defence is a good offence... Until mother knocked some sense into him with a rolling pin, that is. Momma was always a great teacher.")
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
	greet_text = span_notice("I've traveled from land to land for months, treaded over countless corpses; challenged tyrants and heroes alike, slain entire retinues and inhumen warbands, yet I still stand. Perhaps a worthy opponent lives here, on Enigma...? Mmmaybe I could use a little break, though...")
	weight = 10

/datum/special_trait/duelist/on_apply(mob/living/carbon/human/character, silent)
	character.cmode_music = 'sound/music/combat_duelist.ogg'
	character.change_stat("speed", pick(0,1,1,1,1,2))
	character.change_stat("endurance", pick(0,1,1,2,3))
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, pick(5,6,6), TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, pick(1,2,2,2,3), TRUE)
	switch(rand(1,100))
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
			to_chat(character, span_notice("In that tree."))


/datum/special_trait/eagle_eyed
	name = "Eagle Eyed"
	greet_text = span_notice("I'd like to see them fire that obnoxiously loud stick with a bolt through their skull. I don't miss.")
	weight = 10

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
	character.mind.special_items["A firebomb"] = /obj/item/bomb
	character.mind.special_items["Another firebomb"] = /obj/item/bomb


/datum/special_trait/pineapple
	name = "The safeword is 'Pineapple'"
	greet_text = span_notice("I enjoy whipping people until they squirm and whine, their pain makes my pleasure. I'll need to grab my toy from that one tree.")
	weight = 10

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


/datum/special_trait/freerunner
	name = "Freerunner"
	greet_text = span_notice("I've been jumping across Rockhill roofs since I was a little brat, the adrenaline of leaving the entire retinue scratching their heads and raging at their inability to catch me never gets old. I think some of them still hold a grudge.")
	req_text = "Adult or Middle-Aged, Non-keep role."
	restricted_jobs = list(KING_QUEEN_ROLES, GARRISON_ROLES, MANOR_ROLES)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	weight = 10

/datum/special_trait/freerunner/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_ZJUMP, "[type]")
	ADD_TRAIT(character, TRAIT_LEAPER, "[type]")
	ADD_TRAIT(character, TRAIT_NOFALLDAMAGE1, "[type]")
	make_outlaw(character.real_name, TRUE)

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
	greet_text = span_notice("I am <b>not</b> an aggressive drunk! Who the hell is spouting slander about me? I'm going over there to show them what's up! ... Oh? What?... You want some too?!")
	weight = 20 // Seems very strong, someone said they punched thru blacksteel plate as 14 STR acolyte expert unarmed with 5 punches? But since when do punches damage armor at all?

/datum/special_trait/tavernbrawler/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CIVILIZEDBARBARIAN, "[type]") //Need to make trait improve hitting people with chairs, mugs, goblets. <real


/datum/special_trait/jack_of_all_trades
	name = "John of Most Trades" // that 'master craftsman' couldn't ever even /hope/ to lick a Master's boots, leave!
	greet_text = span_notice("In my youth, I've decided I'd try a little bit of everything, I turned out quite the versatile craftsman, if I do say so myself.")
	weight = 80

/datum/special_trait/jack_of_all_trades/on_apply(mob/living/carbon/human/character)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/blacksmithing, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/masonry, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/engineering, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/hunting, 2, TRUE)


/datum/special_trait/true_jack_of_all_trades
	name = "Jack of All Trades"
	greet_text = span_notice("In my youth, I've decided I'd try a little bit of everything, I turned out quite the versatile cr- woaahhh.. Deja vu...")
	req_text = "Middle-Aged or Old"
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	weight = 60

/datum/special_trait/true_jack_of_all_trades/on_apply(mob/living/carbon/human/character)
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
	greet_text = span_notice("I've been born with, or have been granted nobility.")
	restricted_traits = list(TRAIT_NOBLE)
	weight = 100

/datum/special_trait/noble/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOBLE, "[type]")
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 2, TRUE)


/datum/special_trait/swift
	name = "Speedster"
	greet_text = span_notice("I feel like the fastest person alive and I can probably dodge anything, as long as I'm not weighed down by bulky armor.")
	weight = 40

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
	weight = 10

/datum/special_trait/lucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC = rand(15, 20)


/datum/special_trait/mule
	name = "Mule"
	greet_text = span_notice("I've been running errands for the Nightmaster, recently I've gotten my hands on an interesting little thing, I stashed that thing. Perhaps I should consider going independent...")
	weight = 100

/datum/special_trait/mule/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Drugs"] = /obj/item/storage/backpack/rogue/satchel/mule
	character.mind.special_items["PURITY Gem"] = /obj/item/gem_device/purity
	character.mind.special_items["Dagger"] = /obj/item/rogueweapon/huntingknife/idagger
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 2, TRUE)

/datum/special_trait/plate_trained
	name = "Plate Trained"
	greet_text = span_notice("I've made friends with a knight in the past, they have taught me how to feel comfortable in even the heaviest kinds of armor.")
	restricted_traits = list(TRAIT_HEAVYARMOR)
	weight = 20

/datum/special_trait/plate_trained/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_HEAVYARMOR, "[type]")


/datum/special_trait/maile_trained
	name = "Maile Trained"
	greet_text = span_notice("I've known a guy, he knew how to run maile, so I asked him to teach me.")
	restricted_traits = list(TRAIT_MEDIUMARMOR)
	weight = 40

/datum/special_trait/maile_trained/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_MEDIUMARMOR, "[type]")

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
	req_text = "Not a kobold, seelie, verminvolk or a dwarf" // 1984
	restricted_races = list(/datum/species/anthromorphsmall, /datum/species/dwarf/mountain, /datum/species/kobold, /datum/species/seelie)
	weight = 60

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


/datum/special_trait/disfigured
	name = "Disfigured"
	greet_text = span_notice("For better or worse, my face has been fucked up beyond recognition for quite a long while now.")
	weight = 80

/datum/special_trait/disfigured/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DISFIGURED, "[type]")


//Negative Specials
/datum/special_trait/nimrod
	name = "Nimrod"
	greet_text = span_boldwarning("In the past I learned slower than my peers, I can't even lace my shoes.")
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
	ADD_TRAIT(character, TRAIT_WANTED, TRAIT_GENERIC)
	if(!silent)
		to_chat(character, span_notice("Whether I've done it or not, I have been accused of [reason] and the [employer] put a bounty on my head!"))

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


/datum/special_trait/atrophy
	name = "Atrophy"
	greet_text = span_boldwarning("When growing up I could barely feed myself, this left me weak and fragile...")
	weight = 80

/datum/special_trait/atrophy/on_apply(mob/living/carbon/human/character)
	character.change_stat("strength", -2)
	character.change_stat("constitution", -2)
	character.change_stat("endurance", -1)


/datum/special_trait/lazy
	name = "Lazy"
	greet_text = span_boldwarning("I don't care, never did.")
	weight = 80

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
	ADD_TRAIT(character, TRAIT_BAD_MOOD, "[type]")

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
	weight = 40

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


/datum/special_trait/thinker
	name = "The Thinker"
	greet_text = span_notice("Physique, Endurance, Constitution. The trinity of what builds a great leader and an even greater kingdom... or whatever those nimrods were yapping about! <b>I cast FIREBALL!!!</b>")
	req_text = "Ruler, worship Noc"
	allowed_sexes = list(MALE)
	allowed_patrons = list(/datum/patron/divine/noc)
	allowed_jobs = list(/datum/job/roguetown/ruler)
	restricted_traits = list(TRAIT_SPELLCOCKBLOCK)
	weight = 10

/datum/special_trait/thinker/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("strength", -3)
	character.change_stat("intelligence", 6)
	character.change_stat("constitution", -2)
	character.change_stat("endurance", -1)
	character.mind.adjust_skillrank_up_to(/datum/skill/magic/arcane, 4, TRUE)
	character.mind.adjust_spellpoints(6)
	character.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
	new /obj/item/scrying(get_turf(character))


/datum/special_trait/warhorse
	name = "Warhorse"
	greet_text = span_notice("You think you are <b>real soldiers</b>? Kiddo, don't make me laugh! If you've seen the crap <b>I've</b> seen, you'd be pissing your pants everytime you try to sleep! What was that? 'Burnt out old fart'? How about you square up and find out, you brat!")
	req_text = "Be a Veteran"
	allowed_jobs = list(/datum/job/roguetown/veteran)
	weight = 10

/datum/special_trait/warhorse/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DECEIVING_MEEKNESS, "[type]")
	ADD_TRAIT(character, TRAIT_NOSLEEP, "[type]")
	character.change_stat("strength", 4)
	character.change_stat("speed", 3)


/datum/special_trait/bailiff
	name = "Bailiff"
	greet_text = span_notice("Order! Order! Bailiff?! Smack his nuts!")
	req_text = "Be a Marshal"
	allowed_jobs = list(/datum/job/roguetown/marshal)
	weight = 40

/datum/special_trait/bailiff/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NUTCRACKER, "[type]")
