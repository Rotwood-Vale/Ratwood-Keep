/datum/subclass/warlock
	name = "Warlock"
	tutorial = "Warlocks are individuals who have formed a pact with an otherworldly entity, \
	gaining supernatural powers in exchange for their faith or other significant sacrifice. \
	Their powers are derived from sources beyond mortal understanding and are often associated with dark magic and forbidden knowledge."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/bandit/warlock
	category_tags = list(CTAG_BANDIT)
	maximum_possible_slots = 1
	min_pq = 15
	pickprob = 30

/datum/outfit/job/roguetown/bandit/warlock


/datum/outfit/job/roguetown/bandit/warlock/pre_equip(mob/living/carbon/human/H)
	..()

	H.adjust_blindness(-3)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
		H.mind.adjust_spellpoints(1) // all warlocks get at least 3 points to spend
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 3 , TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/hunting, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 1, TRUE)
		H.verbs |= /mob/proc/haltyell
		H.ambushable = FALSE
	backr = /obj/item/storage/backpack/rogue/satchel
	neck = null
	var/patrons = list( //who is your patron?
		"archfey", //a great seelie | utility | seelie spells
		"celestial", //a celestial being | utility | faithless healer
		"fathomless", //a creecher from the depths of the sea | melee combat | medium armor | water themed
		"fiend", //caster
		"genie", //a spirit trapped in an item | utility | specialty gear
		"great old one", //your typical lovecraftian creecher | caster | magic tab
		"hexblade", //a sentient weapon | melee combat | medium armor | specialty gear
		"undead" //a creecher from the grave | utility | heavy armor | tank
	)

	var/patronchoice = input("Choose your otherworldly patron", "Available patrons") as anything in patrons

	switch(patronchoice)
		if("archfey")
			archfeypatron(H, patronchoice)
		if("celestial")
			celestialpatron(H, patronchoice)
		if("fathomless")
			fathomlesspatron(H, patronchoice)
		if("fiend")
			fiendpatron(H, patronchoice)
		if("genie")
			geniepatron(H, patronchoice)
		if("great old one")
			goopatron(H, patronchoice)
		if("hexblade")
			hexbladepatron(H, patronchoice)
		if("undead")
			undeadpatron(H, patronchoice)

	var/boons = list( //what did you sell your faith for?
		"strength", //Pact of the Blade
		"knowledge", //Pact of the Tome
		"health", //give them healing
		"wealth", //Pact of the Talisman
		"love", //ring of soulbinding
		"friendship", //Pact of the Chain
		"power", //empowered eldritch blast
		"purpose" //Pact of the Star Chain
		"revenge" //Curses
	)

	var/boonchoice = input("What did you sell your faith for?", "Available boons") as anything in boons

	switch(boonchoice)
		if("strength") //Pact of the Blade
			H.put_in_hands(giveweapon(H,patronchoice), FALSE)
			H.change_stat("strength", 1)
			H.set_blindness(0)
		if("friendship") //Pact of the Chain
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/findfamiliar)
			H.change_stat("perception", 1)
			H.set_blindness(0)
		if("knowledge") //Pact of the Tome
			H.put_in_hands(givebook(patronchoice), FALSE)
			H.change_stat("intelligence", 1)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/guidance5e)
		if("power") //empowered eldritch blast
			H.mind.RemoveSpell(/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e/empowered)
			H.change_stat("intelligence", 1)
			H.mind.adjust_spellpoints(1)
		if("love") //ring of soulbinding
			H.put_in_hands(givering(H))
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
			H.set_blindness(0)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/docheal)
		if("health") //make healthier
			givehealing(H, patronchoice)
			H.change_stat("constitution", 1)
			H.set_blindness(0)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		if("wealth") //Pact of the Talisman
			ADD_TRAIT(H, TRAIT_SEEPRICES, type)
			H.mind.adjust_skillrank_up_to(/datum/skill/misc/treatment, 1, TRUE)
			H.put_in_hands(giveamulet(patronchoice), FALSE)
			beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
			H.set_blindness(0)
		if("purpose") //Pact of the Star Chain
			wrists = /obj/item/rope/chain/constellation
			H.set_blindness(0)
		if("revenge") //give curse
			givecurse(H, patronchoice)
			H.change_stat("speed", 1)
			H.set_blindness(0)

/datum/outfit/job/roguetown/bandit/warlock/proc/archfeypatron(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)

	head = /obj/item/clothing/head/roguetown/helmet/foresterhelmet
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
	r_hand = /obj/item/rogueweapon/woodstaff
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/rogueweapon/huntingknife

	//caster stats (must be 5 stat point total)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("constitution", 1)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/seelie_dust)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/strip)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/seelie_kiss)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/splash)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/animate_object)

	ADD_TRAIT(H, TRAIT_WILDMAGIC, TRAIT_GENERIC)

	H.visible_message(span_info("I made a deal with an archseelie from the wild."))

/datum/outfit/job/roguetown/bandit/warlock/proc/celestialpatron(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)

	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/armor
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/mace
	backpack_contents = list(/obj/item/rogueweapon/huntingknife)

	//caster stats (must be 5 stat point total)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("constitution", 1)

	H.mind.adjust_spellpoints(2) // general arcane power, less total gain than other trees, 4 points total (it's hard to give "celestial" a real spell theme)

	givehealing(H, patronchoice, TRUE)

	H.visible_message(span_info("I made a deal with a celestial being from the heavens."))

/datum/outfit/job/roguetown/bandit/warlock/proc/fathomlesspatron(mob/living/carbon/human/H, patronchoice) // a watery creature
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 3, TRUE)

	backl = /obj/item/fishingrod
	head = /obj/item/clothing/head/roguetown/fisherhat
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	cloak = /obj/item/clothing/cloak/raincloak/blue
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/rope
	r_hand = /obj/item/rogueweapon/pitchfork
	belt =/obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/huntingknife
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes

	backpack_contents = list(/obj/item/rope)

	//melee stats (must be 5 stat point total)
	H.change_stat("perception", 1)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 1)
	H.change_stat("speed", -1)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/frostbite5e) // "water" and ice magic, less arcane power because armor and dodge training

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_WATERBREATHING, TRAIT_GENERIC)

	H.visible_message(span_info("I made a deal with a fathomless creecher of the sea."))

/datum/outfit/job/roguetown/bandit/warlock/proc/fiendpatron(mob/living/carbon/human/H, patronchoice) //hellish fiend
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)

	head = /obj/item/clothing/head/roguetown/roguehood/red
	mask = /obj/item/clothing/mask/rogue/facemask/steel/hound
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/magered
	back = /obj/item/clothing/cloak/raincloak/red
	r_hand = /obj/item/rogueweapon/woodstaff
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/rogueweapon/huntingknife
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes

	//caster stats (must be 5 stat point total)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("constitution", 1)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball) // fireball is a very strong spell, fiendkiss makes it even stronger
	ADD_TRAIT(H, TRAIT_NOFIRE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_FIENDKISS, TRAIT_GENERIC)

	H.visible_message(span_info("I made a deal with a fiend from the hells."))

/datum/outfit/job/roguetown/bandit/warlock/proc/geniepatron(mob/living/carbon/human/H, patronchoice) //a desert entity
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)

	head = /obj/item/clothing/head/roguetown/roguehood/shalal
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	gloves = /obj/item/clothing/gloves/roguetown/leather/angle
	beltr = /obj/item/wisp_lantern
	beltl = /obj/item/rogueweapon/sword/sabre
	belt = /obj/item/storage/belt/rogue/leather/shalal
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/armor/shalal
	id = /obj/item/clothing/ring/gold/signet

	//lucky stats (must be 5 stat point total)
	H.change_stat("endurance", 1) //
	H.change_stat("speed", 2)
	H.change_stat("fortune", 2)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/haste)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/push_spell) // going with wind theme, speed and airblast, possibly eventual picker for "which type of genie did you make a deal with"

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

	H.visible_message(span_info("I made a deal with a djinn from a magic lamptern."))

/datum/outfit/job/roguetown/bandit/warlock/proc/goopatron(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)

	head = /obj/item/clothing/head/roguetown/roguehood/mage
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/necra
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/rogueweapon/huntingknife
	r_hand = /obj/item/rogueweapon/woodstaff

	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor)

	//caster stats (must be 5 stat point total)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("constitution", 1)

	H.mind.adjust_spellpoints(3) // 6 total spell points after arcane adjust; forbidden eldritch knowledge to build your own spellbook, but you get nothing else

	H.visible_message(span_info("Most minds would fracture having spoken to the creecher I made a deal with..."))

/datum/outfit/job/roguetown/bandit/warlock/proc/hexbladepatron(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/axes, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE) // patron weapon scales off of arcane for some reason
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 3, TRUE)

	shoes = /obj/item/clothing/shoes/roguetown/boots
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	if(prob(70))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	else if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	else
		armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
	if(prob(20))
		mask = /obj/item/clothing/mask/rogue/facemask
	else if(prob(60))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	else if(prob(20))
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
	else
		head = /obj/item/clothing/head/roguetown/helmet/kettle
	beltl = /obj/item/rogueweapon/huntingknife

	H.put_in_hands(giveweapon(H,patronchoice), FALSE)

	//melee stats (must be 5 stat point total)
	H.change_stat("perception", 1)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 1)
	H.change_stat("speed", -1)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/greenflameblade5e) // put that new weapon to work! martial focus means less magic
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mending5e)

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	H.visible_message(span_info("I made a deal with a sentient weapon."))

/datum/outfit/job/roguetown/bandit/warlock/proc/undeadpatron(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 3, TRUE)

	if(prob(20))
		head = /obj/item/clothing/head/roguetown/knitcap
	else
		head = null
	if(prob(10))
		cloak = /obj/item/clothing/cloak/raincloak/brown
	else
		cloak = null
	if(prob(10))
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	else
		gloves = /obj/item/clothing/gloves/roguetown/chain
		armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	neck = /obj/item/clothing/neck/roguetown/gorget
	shoes = /obj/item/clothing/shoes/roguetown/armor
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/mace
	backl = /obj/item/rogueweapon/sword/iron/short

	//tank stats (must be 5 stat point total)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/cloakofflies)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/infestation5e)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/chilltouch5e) // decay-themed magic and a skeletal hand to attack people with

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)

	H.visible_message(span_info("I made a deal with a horror from the grave."))

///////////////////////////////
//	Faithless Healing
///////////////////////////////

/datum/outfit/job/roguetown/bandit/warlock/proc/givehealing(mob/living/carbon/human/H, patronname = "", ignore_faithless = FALSE)
	var/obj/effect/proc_holder/spell/invoked/eldritchhealing/eldritchhealing = new /obj/effect/proc_holder/spell/invoked/eldritchhealing
	if(ignore_faithless)
		eldritchhealing.ignore_faithless = TRUE
	eldritchhealing.patronname = patronname
	switch(patronname) //god damn put this in a datum or something....
		if("archfey")
			eldritchhealing.targetnotification = "I am surrounded in a puff of seelie dust."
			eldritchhealing.othernotification = "is surrounded in a puff of seelie dust."
		if("celestial")
			eldritchhealing.targetnotification = "I am encircled in a tapestry of glittering starlight."
			eldritchhealing.othernotification = "is encircled in a tapestry of glittering starlight."
		if("fathomless")
			eldritchhealing.targetnotification = "My pain is siphoned away by an inky tendril!"
			eldritchhealing.othernotification = "'s injuries are siphoned away by an inky tendril!"
		if("genie")
			eldritchhealing.targetnotification = "I just feel better all of a sudden."
			eldritchhealing.othernotification = "looks better."
		if("great old one")
			eldritchhealing.targetnotification = "My wounds distort and fade away."
			eldritchhealing.othernotification = "'s injuries distort and fade away."
		if("hexblade")
			eldritchhealing.targetnotification = "My wounds close leaving scars."
			eldritchhealing.othernotification = "'s wounds close leaving scars."
		if("undead")
			eldritchhealing.targetnotification = "Maggots eat away my dead flesh!"
			eldritchhealing.othernotification = "'s wounds are healed by... Maggots?"
	H.mind.AddSpell(eldritchhealing)

///////////////////////////////
//	Curse
///////////////////////////////

/datum/outfit/job/roguetown/bandit/warlock/proc/givecurse(mob/living/carbon/human/H, patronname = "")
	var/obj/effect/proc_holder/spell/invoked/eldritchcurse/curse = new /obj/effect/proc_holder/spell/invoked/eldritchcurse

	switch(patronname) //god damn put this in a datum or something....
		if("archfey")
			curse.curse = /datum/status_effect/buff/eldritchcurse/archfey
		if("celestial")
			curse.curse = /datum/status_effect/buff/eldritchcurse/celestial
		if("fathomless")
			curse.curse = /datum/status_effect/buff/eldritchcurse/fathomless
		if("genie")
			curse.curse = /datum/status_effect/buff/eldritchcurse/genie
		if("great old one")
			curse.curse = /datum/status_effect/buff/eldritchcurse/goo
		if("hexblade")
			curse.curse = /datum/status_effect/buff/eldritchcurse/hexblade
		if("undead")
			curse.curse = /datum/status_effect/buff/eldritchcurse/undead
	curse.name += patronname
	curse.patronname = patronname
	H.mind.AddSpell(curse)

///////////////////////////////
//	Pact Book
///////////////////////////////

/datum/outfit/job/roguetown/bandit/warlock/proc/givebook(patronchoice)
	var/obj/item/item
	var/item_type = /obj/item/book/rogue/eldritch
	item = new item_type
	item.name = "grimoire of the "+patronchoice
	return item

/obj/item/book/rogue/eldritch
	desc = "An earie book containing hidden knowledge."
	icon_state = "ledger_0"
	force = 20
	throwforce = 10
	breakouttime = 2 MINUTES
	var/active_item
	var/spell1
	var/spell2
	var/spell3

/obj/item/book/rogue/eldritch/Initialize()
	. = ..()
	// TODO: GLOBAL LISTS OF SPELLS, THIS IS PAINFUL
	//removed eldritch blast and infestation
	spell1 = pick(/obj/effect/proc_holder/spell/invoked/projectile/fireball,/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt,/obj/effect/proc_holder/spell/invoked/projectile/fetch,/obj/effect/proc_holder/spell/invoked/projectile/spitfire,/obj/effect/proc_holder/spell/invoked/projectile/firebolt5e,/obj/effect/proc_holder/spell/invoked/projectile/rayoffrost5e,/obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e,/obj/effect/proc_holder/spell/invoked/blade_burst,/obj/effect/proc_holder/spell/invoked/frostbite5e,/obj/effect/proc_holder/spell/invoked/poisonspray5e,/obj/effect/proc_holder/spell/invoked/chilltouch5e,/obj/effect/proc_holder/spell/invoked/mindsliver5e,/obj/effect/proc_holder/spell/targeted/lightninglure5e,/obj/effect/proc_holder/spell/invoked/greenflameblade5e,)
	spell2 = pick(/obj/effect/proc_holder/spell/invoked/forcewall_weak,/obj/effect/proc_holder/spell/self/bladeward5e,)
	spell3 = pick(/obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe,/obj/effect/proc_holder/spell/invoked/message,/obj/effect/proc_holder/spell/invoked/push_spell,/obj/effect/proc_holder/spell/invoked/longjump,/obj/effect/proc_holder/spell/invoked/findfamiliar,/obj/effect/proc_holder/spell/targeted/guidance5e,/obj/effect/proc_holder/spell/targeted/encodethoughts5e,/obj/effect/proc_holder/spell/invoked/mending5e,/obj/effect/proc_holder/spell/self/light5e,/obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e,)


/obj/item/book/rogue/eldritch/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE
		to_chat(user, span_notice("Your mind swells with knowledge"))
		user.change_stat("intelligence", 1)
		user.mind.AddSpell(new spell1)
		user.mind.AddSpell(new spell2)
		user.mind.AddSpell(new spell3)
		user.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/message)
		return

/obj/item/book/rogue/eldritch/dropped(mob/living/user)
	if(active_item)
		to_chat(user, span_notice("Your intellect shrinks away"))
		user.change_stat("intelligence", -1)
		user.mind.RemoveSpell(spell1)
		user.mind.RemoveSpell(spell2)
		user.mind.RemoveSpell(spell3)
		user.mind.RemoveSpell(/obj/effect/proc_holder/spell/invoked/message)
		active_item = FALSE
		return

///////////////////////////////
//	Weapon of X
///////////////////////////////

/datum/outfit/job/roguetown/bandit/warlock/proc/giveweapon(mob/living/carbon/human/H, patronchoice)
	H.mind.adjust_skillrank_up_to(/datum/skill/magic/arcane, 3, TRUE)
	var/item_pick = pick(1,2,3,4,5,6,7,8,9,10,11)
	var/item_type
	switch(item_pick)
		if(1)
			item_type = /obj/item/rogueweapon/estoc
		if(2)
			item_type = /obj/item/rogueweapon/greatsword
		if(3)
			item_type = /obj/item/rogueweapon/eaglebeak
		if(4)
			item_type = /obj/item/rogueweapon/halberd
		if(5)
			item_type = /obj/item/rogueweapon/stoneaxe/battle
		if(6)
			item_type = /obj/item/rogueweapon/mace/goden/steel
		if(7)
			item_type = /obj/item/rogueweapon/mace/steel
		if(8)
			item_type = /obj/item/rogueweapon/huntingknife/idagger/steel
		if(9)
			item_type = /obj/item/rogueweapon/flail/sflail
		if(10)
			item_type = /obj/item/rogueweapon/whip
		if(11)
			item_type = /obj/item/rogueweapon/sword/sabre

	var/obj/item/item
	item = new item_type
	item.AddComponent(/datum/component/pact_weapon, H, patronchoice)
	item.AddComponent(/datum/component/singing_item, H)
	item.AddComponent(/datum/component/spirit_holding, null, null)
	return item

///////////////////////////////
//	Signet Ring
///////////////////////////////

/obj/item/clothing/ring/gold/signet
	name = "signet ring"
	desc = "A ring that denotes nobility."
	var/active_item

/obj/item/clothing/ring/gold/signet/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE
		to_chat(user, span_notice("You feel noble."))
		ADD_TRAIT(user, TRAIT_NOBLE, TRAIT_GENERIC)
		return

/obj/item/clothing/ring/gold/signet/dropped(mob/living/user)
	if(active_item)
		to_chat(user, span_notice("You feel like a peasant."))
		REMOVE_TRAIT(user, TRAIT_NOBLE, TRAIT_GENERIC)
		active_item = FALSE
		return

///////////////////////////////
//	TALISMAN OF X
///////////////////////////////

/datum/outfit/job/roguetown/bandit/warlock/proc/giveamulet(patronchoice)
	var/obj/item/item
	var/item_type = /obj/item/clothing/neck/roguetown/psicross/eldritch
	item = new item_type
	item.name += patronchoice
	return item

/obj/item/clothing/neck/roguetown/psicross/eldritch
	name = "talisman of the "
	desc = "An earie glowing talisman."
	icon_state = "eldritch"
	var/active_item

/obj/item/clothing/neck/roguetown/psicross/eldritch/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE
		to_chat(user, span_notice("You feel lucky."))
		user.change_stat("fortune", 3)
		return

/obj/item/clothing/neck/roguetown/psicross/eldritch/dropped(mob/living/user)
	if(active_item)
		to_chat(user, span_notice("Your stroke of luck has ended."))
		user.change_stat("fortune", -3)
		active_item = FALSE
		return

///////////////////////////////
//	CONSTELLATION CHAIN
///////////////////////////////

/obj/item/rope/chain/constellation
	desc = "A strange chain resembling a constellation."
	icon_state = "starchain"
	force = 20
	throwforce = 10
	breakouttime = 2 MINUTES
	var/active_item

/obj/item/rope/chain/constellation/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE

		var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
		eyes.see_in_dark = 8
		eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
		eyes.sight_flags = initial(eyes.sight_flags)
		eyes.sight_flags &= ~SEE_BLACKNESS
		eyes.owner.update_sight()

		to_chat(user, span_notice("Your purpose seems clearer now"))
		user.change_stat("intelligence", 1)
		user.change_stat("fortune", 1)
		return

/obj/item/rope/chain/constellation/dropped(mob/living/user)
	if(active_item)
		to_chat(user, span_notice("Your purpose is scattered to the wind"))

		var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
		eyes.see_in_dark = 2
		eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
		eyes.sight_flags = 0
		eyes.owner.update_sight()

		user.change_stat("intelligence", -1)
		user.change_stat("fortune", -1)
		active_item = FALSE
		return

///////////////////////////////
//	Soulbond Ring
///////////////////////////////
/datum/outfit/job/roguetown/bandit/warlock/proc/givering(mob/living/carbon/human/H)
	var/item_type = /obj/item/clothing/ring/diamond/soulbond
	var/obj/item/item
	item = new item_type
	item.item_owner = H
	return item

/obj/item/clothing/ring/diamond/soulbond
	name = "soulbond ring of null magic"
	desc = "A ring that bonds two together eternally."

/obj/item/clothing/ring/diamond/soulbond/equipped(mob/living/user, slot)
	. = ..()
	if(slot == SLOT_RING)
		if(user == item_owner)
			to_chat(user, span_warning("You feel lonely. This is meant to go on someone else."))
		else
			ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
			ADD_TRAIT(src, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
			to_chat(item_owner, span_warning("[user]'s life force is tied directly to yours."))
			to_chat(user, span_warning("Your lifeforce is linked to [item_owner]'s."))
			soullink(/datum/soullink/oneway/delay, item_owner, user)

/obj/item/clothing/ring/diamond/soulbond/dropped(mob/living/user)
	qdel(user.GetComponent(/datum/soullink/oneway))
	REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	REMOVE_TRAIT(src, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
