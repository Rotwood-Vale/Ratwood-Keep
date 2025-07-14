/mob/living/carbon/human/species/halforc/npc
	gender = MALE

	ambushable = FALSE
	base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw, /datum/intent/simple/bite, /datum/intent/kick)
	possible_rmb_intents = list()

	aggressive = 1
	mode = NPC_AI_IDLE
	dodgetime = 15 //they can dodge easily, but have a cooldown on it
	canparry = TRUE
	flee_in_pain = FALSE
	rude = TRUE
	wander = FALSE

/mob/living/carbon/human/species/halforc/npc/ambush/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/ambush)
	aggressive = 1
	mode = NPC_AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/mob/living/carbon/human/species/halforc/npc/Initialize()
	. = ..()
	spawn(10)
		after_creation()
//	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)

/mob/living/carbon/human/species/halforc/npc/handle_combat()
	if(mode == NPC_AI_HUNT)
		if(prob(2))
			emote("aggro")
	. = ..()

/mob/living/carbon/human/species/halforc/npc/proc/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)

/mob/living/carbon/human/species/halforc/npc/after_creation()
	..()
	gender = MALE
	if(src.dna && src.dna.species)
		src.dna.species.soundpack_m = new /datum/voicepack/orc()
		var/obj/item/headdy = get_bodypart(BODY_ZONE_HEAD)
		if(headdy)
			headdy.icon_state = "[src.dna.species.id]_head"
			headdy.sellprice = rand(15,40)
	src.grant_language(/datum/language/common)
	var/obj/item/organ/eyes/eyes = src.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(src,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/nightmare
	eyes.Insert(src)
	src.underwear = "Nude"
	if(src.charflaw)
		QDEL_NULL(src.charflaw)
	update_body()
	faction = list("orcs")
	name = "half-orc"
	real_name = "half-orc"
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)

/////
////
////
//// OUTFIT//////////////////
////
///

/datum/outfit/job/roguetown/npc/orc/ambush/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 13
	H.STASPD = 12
	H.STACON = 13
	H.STAEND = 13
	var/loadout = rand(1,3)
	switch(loadout)
		if(1) //Stolen Tool armed raider
			r_hand = /obj/item/rogueweapon/stoneaxe/handaxe
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(2) //lightly armored sword/flail/daggers
			if(prob(50))
				head = /obj/item/clothing/head/roguetown/helmet/leather
				r_hand = /obj/item/rogueweapon/mace/spiked
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
				head = /obj/item/clothing/head/roguetown/helmet/leather
			if(prob(30))
				l_hand = /obj/item/rogueweapon/sword/iron
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
				head = /obj/item/clothing/head/roguetown/helmet/leather
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			if(prob(23))
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
				r_hand = /obj/item/rogueweapon/huntingknife/idagger
				l_hand = /obj/item/rogueweapon/huntingknife/idagger
				head = /obj/item/clothing/head/roguetown/helmet/leather
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			if(prob(80))
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
				head = /obj/item/clothing/head/roguetown/helmet/leather
		if(3) //heavy armored sword/flail/shields
			if(prob(20))
				r_hand = /obj/item/rogueweapon/mace//readded the blunt weapon, this time with an very rare "slavist" orc
				l_hand = /obj/item/rogueweapon/whip
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			else
				r_hand = /obj/item/rogueweapon/sword/short
				l_hand = /obj/item/rogueweapon/sword/short
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			if(prob(80))
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
				r_hand = /obj/item/rogueweapon/flail
			else
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
				r_hand = /obj/item/rogueweapon/stoneaxe/battle
			if(prob(50))
				r_hand = /obj/item/rogueweapon/sword/iron
				l_hand = /obj/item/rogueweapon/shield/wood
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			else
				r_hand = /obj/item/rogueweapon/mace/spiked
				l_hand = /obj/item/rogueweapon/shield/wood
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			if(prob(30))
				r_hand = /obj/item/rogueweapon/sword/iron/messer
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather

//NEW ORCS WITH DIFFERENT GEAR AND SHIT
/mob/living/carbon/human/species/halforc/npc/tribal
	name = "tribal half-orc"
	var/loadout = /datum/outfit/job/roguetown/npc/orc/tribal
	ambushable = FALSE

/mob/living/carbon/human/species/halforc/npc/tribal/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/tribal)
	aggressive = 1
	mode = NPC_AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/npc/orc/tribal/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 13
	H.STASPD = 13
	H.STACON = 13
	H.STAEND = 13
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //Dual Axe Warrior
			r_hand = /obj/item/rogueweapon/stoneaxe
			l_hand = /obj/item/rogueweapon/stoneaxe
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/brown
			pants = /obj/item/clothing/under/roguetown/loincloth
		if(2) //Long Club Caveman
			r_hand = /obj/item/rogueweapon/woodstaff
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/brown
			pants = /obj/item/clothing/under/roguetown/loincloth
		if(3) //Club Caveman
			r_hand = /obj/item/rogueweapon/mace/woodclub
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/brown
			pants = /obj/item/clothing/under/roguetown/loincloth
		if(4) //dagger fighter
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/brown
			r_hand = /obj/item/rogueweapon/huntingknife/stoneknife
			l_hand = /obj/item/rogueweapon/huntingknife/stoneknife
			pants = /obj/item/clothing/under/roguetown/loincloth
		if(5) //Spear hunter
			r_hand = /obj/item/rogueweapon/spear/stone
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/brown
			pants = /obj/item/clothing/under/roguetown/loincloth


//////////////////////////////////////////////////////////

/mob/living/carbon/human/species/halforc/npc/warrior
	name = "warrior half-orc"
	var/loadout = /datum/outfit/job/roguetown/npc/orc/warrior
	ambushable = FALSE

/mob/living/carbon/human/species/halforc/npc/warrior/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/warrior)
	aggressive = 1
	mode = NPC_AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/npc/orc/warrior/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 13
	H.STASPD = 13
	H.STACON = 14
	H.STAEND = 14
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //Marauder with Sword and Shield
			r_hand = /obj/item/rogueweapon/sword/iron
			l_hand = /obj/item/rogueweapon/shield/wood
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/leather
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(2) //Marauder with Axe and Shield
			r_hand = /obj/item/rogueweapon/stoneaxe/handaxe
			l_hand = /obj/item/rogueweapon/shield/wood
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/leather
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(3) //Club Caveman
			r_hand = /obj/item/rogueweapon/flail
			l_hand = /obj/item/rogueweapon/sword/iron/messer
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/leather
		if(4) //dagger fighter
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			cloak = /obj/item/clothing/cloak/raincloak/brown
			r_hand = /obj/item/rogueweapon/sword/iron
			l_hand = /obj/item/rogueweapon/sword/short
			head = /obj/item/clothing/head/roguetown/helmet/leather
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(5) //Marauder Ironblade
			if(prob(50))
				r_hand = /obj/item/rogueweapon/mace/spiked
				l_hand = /obj/item/rogueweapon/shield/wood
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			else
				r_hand = /obj/item/rogueweapon/mace/spiked
				l_hand = /obj/item/rogueweapon/sword/iron/messer
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				cloak = /obj/item/clothing/cloak/raincloak/brown
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			if(prob(30))
				r_hand = /obj/item/rogueweapon/stoneaxe/handaxe
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				cloak = /obj/item/clothing/cloak/raincloak/brown
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				shoes = /obj/item/clothing/shoes/roguetown/armor/leather




///////////////////////////////////////////////////////////////////////////////////////

/mob/living/carbon/human/species/halforc/npc/marauder
	name = "marauder half-orc"
	var/loadout = /datum/outfit/job/roguetown/npc/orc/marauder
	ambushable = FALSE

/mob/living/carbon/human/species/halforc/npc/marauder/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/marauder)
	aggressive = 1
	mode = NPC_AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/npc/orc/marauder/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 12
	H.STASPD = 12
	H.STACON = 13
	H.STAEND = 13
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //Marauder with Sword and Shield
			r_hand = /obj/item/rogueweapon/sword/iron
			l_hand = /obj/item/rogueweapon/stoneaxe/handaxe
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(2) //Marauder with Axe and Shield
			r_hand = /obj/item/rogueweapon/stoneaxe/battle
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(3) //Warhammer Caveman
			r_hand = /obj/item/rogueweapon/mace/warhammer
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(4) //dagger fighter
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
			cloak = /obj/item/clothing/cloak/raincloak/brown
			r_hand = /obj/item/rogueweapon/mace/steel
			l_hand = /obj/item/rogueweapon/shield/tower
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(5) //Marauder Ironblade
			r_hand = /obj/item/rogueweapon/halberd/bardiche
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather


///////////////////////////////////////////////////////////////////////////////////////
/mob/living/carbon/human/species/halforc/npc/warlord
	name = "warlord half-orc"
	var/loadout = /datum/outfit/job/roguetown/npc/orc/warlord
	ambushable = FALSE

/mob/living/carbon/human/species/halforc/npc/warlord/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/warlord)
	aggressive = 1
	mode = NPC_AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/npc/orc/warlord/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 14
	H.STASPD = 14
	H.STACON = 14
	H.STAEND = 14
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //Halberd Warlord
			r_hand = /obj/item/rogueweapon/halberd
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(2) //Greatsword Warlord
			r_hand = /obj/item/rogueweapon/greatsword
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half
			head = /obj/item/clothing/head/roguetown/helmet/winged
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(3) // WE DON'T WANNA GO TO WAR TODAY BUT THE LORD OF THE LASH SAYS "NAY NAY NAY!!" WE'RE GONNA MARCH ALL DAE, ALL DAE, ALL DAE! WHERE THERE'S A WHIP THERE'S A WAY!!
			r_hand = /obj/item/rogueweapon/whip
			l_hand = /obj/item/rogueweapon/sword/short
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half
			head = /obj/item/clothing/head/roguetown/helmet/horned
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(4) // Big Sword and Big Shield
			armor = /obj/item/clothing/suit/roguetown/armor/plate/full
			r_hand = /obj/item/rogueweapon/sword/iron/messer/steel
			l_hand = /obj/item/rogueweapon/shield/tower
			head = /obj/item/clothing/head/roguetown/helmet/heavy
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		if(5) //Anti Knight STR Build
			r_hand = /obj/item/rogueweapon/flail/sflail
			armor = /obj/item/clothing/suit/roguetown/armor/plate/full
			head = /obj/item/clothing/head/roguetown/helmet/heavy
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather

/mob/living/carbon/human/species/halforc/npc/warlord/skilled/after_creation() //these ones dont parry, but still get good weapon skills
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/warlord)
	aggressive = 1
	mode = NPC_AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE
	configure_mind()
