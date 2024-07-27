GLOBAL_LIST_INIT(orcraider_quotes, world.file2list("strings/rt/orcraiderlines.txt"))
GLOBAL_LIST_INIT(orcraider_aggro, world.file2list("strings/rt/orcraideraggrolines.txt"))



/mob/living/carbon/human/species/halforc/orc_raider
	aggressive=1
	mode = AI_IDLE
	faction = list("orcs")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	possible_rmb_intents = list()
	gender = MALE

/mob/living/carbon/human/species/halforc/orc_raider/savage_orc

/mob/living/carbon/human/species/halforc/orc_raider/savage_orc/after_creation()
	equipOutfit(new /datum/outfit/job/roguetown/human/species/halforc/savage_orc)

/mob/living/carbon/human/species/halforc/orc_raider/ambush
	aggressive=1

	wander = TRUE

/mob/living/carbon/human/species/halforc/orc_raider/savage_orc/ambush
	aggressive=1

	wander = TRUE

/mob/living/carbon/human/species/halforc/orc_raider/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(target != newtarg)
			say(pick(GLOB.orcraider_aggro))
			linepoint(target)

/mob/living/carbon/human/species/halforc/orc_raider/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/halforc/orc_raider/Initialize()
	. = ..()
	set_species(/datum/species/halforc)
	skin_tone = SKIN_COLOR_GROONN
	spawn(10)
		after_creation()
	//addtimer(CALLBACK(src, PROC_REF(after_creation)), 10)


/mob/living/carbon/human/species/halforc/orc_raider/after_creation()
	..()
	job = "Orc Raider"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/halforc/orc_raider)

/mob/living/carbon/human/species/halforc/orc_raider/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))
	if(prob(12))
		say(pick(GLOB.orcraider_quotes))
	if(prob(12))
		emote(pick("laugh","burp","yawn","grumble","mumble","blink_r","clap"))

/mob/living/carbon/human/species/halforc/orc_raider/handle_combat()
	if(mode == AI_HUNT)
		if(prob(50))
			emote("rage")
	. = ..()

/datum/outfit/job/roguetown/human/species/halforc/savage_orc/pre_equip(mob/living/carbon/human/H)
	if(prob(20))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	if(prob(20))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(20))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/tribalrag
	pants =	/obj/item/clothing/under/roguetown/loincloth/brown
	if(prob(20))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(40))
		mask = /obj/item/clothing/mask/rogue/skullmask
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet/horned
	if(prob(50))
		r_hand = /obj/item/rogueweapon/spear/bonespear
	else
		r_hand = /obj/item/rogueweapon/stoneaxe/boneaxe
	if(prob(30))
		shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedanklets
	else
		shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	H.STASTR = rand(14,16)
	H.STASPD = rand(8,10)
	H.STACON = rand(9,10)
	H.STAEND = rand(8,14)
	H.STAINT = rand(1,2)
	H.name = pick( world.file2list("strings/rt/names/other/halforcm.txt") )
	H.real_name = H.name
	H.gender = MALE

/datum/outfit/job/roguetown/human/species/halforc/orc_raider/pre_equip(mob/living/carbon/human/H)
	if(prob(20))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	if(prob(70))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(60))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	pants =	/obj/item/clothing/under/roguetown/tights/vagrant
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	else
		head = /obj/item/clothing/head/roguetown/helmet/horned
	if(prob(40))
		mask = /obj/item/clothing/mask/rogue/skullmask
	if(prob(10))
		r_hand = /obj/item/rogueweapon/spear/improvisedbillhook
	else
		r_hand = /obj/item/rogueweapon/stoneaxe/battle
	if(prob(20))
		shoes = /obj/item/clothing/shoes/roguetown/boots/armoriron
	else
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	H.STASTR = rand(14,16)
	H.STASPD = rand(10,11)
	H.STACON = rand(7,10)
	H.STAEND = rand(11,14)
	H.STAINT = rand(3,4)
	H.name = pick( world.file2list("strings/rt/names/other/halforcm.txt") )
	H.real_name = H.name
	H.gender = MALE
