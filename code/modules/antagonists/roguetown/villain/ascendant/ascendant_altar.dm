// OH GOD IT'S SO SHITTY IM SO SORRY PLEASE PLEAS EPLEASEP ELEA

var/list/psydon_pool = list(
	/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk,  //todo: items lol
	/obj/item/clothing/suit/roguetown/armor/gambeson,
	/obj/item/clothing/suit/roguetown/armor/leather,
	/obj/item/reagent_containers/glass/bottle/waterskin,
	/obj/item/natural/cloth,
	/obj/item/natural/fur,
	/obj/item/reagent_containers/food/snacks/grown/berries/rogue
)

//doing it this way came to me in a dream. find out which items ASCENDANT will be getting today
var/list/capstone_pool = list(
	/obj/item/rogueore/coal, //= "minecraft item",
	/obj/item/rogueore/gold,
	/obj/item/rogueore/iron
)


/datum/crafting_recipe/roguetown/structure/ascendant
	name = "ascendant's altar"
	result = /obj/structure/ascendant_altar
	reqs = list(
		/obj/item/bodypart = 2,
		/obj/item/organ/stomach = 1,
	)
	verbage_simple = "construct"
	verbage = "constructs"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = null
	always_availible = FALSE
	subtype_reqs = TRUE



/obj/structure/ascendant_altar
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "alch"
	var/ascend_stage = 0 //stages - 0 is base, 1 is 1st capstone, 2 is 2nd capstone, 3 is full ascension
	var/ascendpoints = 0 //artefact points

//im sorry im sorry im sorry im sorry im s
	var/obj/artefact_one
	var/obj/artefact_two
	var/artefact_one_display
	var/artefact_two_display
	var/obj/capstone_one
	var/capstone_one_display


/obj/structure/ascendant_altar/proc/runthejewels() //gets the name var of stuff
	src.artefact_one = psydon_pool[1]
	src.artefact_two = psydon_pool[2]
	src.capstone_one = capstone_pool[1]
	src.artefact_one_display = initial(artefact_one.name)
	src.artefact_two_display = initial(artefact_two.name)
	src.capstone_one = capstone_pool[1]
	src.capstone_one_display = initial(capstone_one.name)


/obj/structure/ascendant_altar/examine(mob/user)

	. = ..()

	runthejewels()

	if((user.mind?.has_antag_datum(/datum/antagonist/ascendant)))
		. += "The next artefacts I must find is a [src.artefact_one_display]. The next capstone to ascend in power is a [src.capstone_one_display]" //i think this works.
		return
	else
		.+= "It almost looks like it's waiting for something- but I don't know what."
		return



/*
/obj/structure/ascendant_altar/attack_hand(mob/living/user) //da bread n butter - see the next ascensions we need

	if((user.mind?.has_antag_datum(/datum/antagonist/ascendant)))
		to_chat(user, span_userdanger("I must collect [psydon_list]"))
	else
		to_chat(user, span_userdanger("I have no idea what this is."))
*/



/obj/structure/ascendant_altar/attackby(obj/item/I, mob/living/user)

//todo: this is garbage, break this into multiple procs, fucking please??
//basically- stuff in artefacts, get traits. stuff in capstone to actually get the next stage
// first, if this is an artifact, and not a capstone...
	if((user.mind?.has_antag_datum(/datum/antagonist/ascendant)))
		if(istype(I, psydon_pool[1]))
			src.ascendpoints += 1
			user.STASTR += 2
			user.STAPER += 2
			user.STAINT += 2
			user.STACON += 2
			user.STAEND += 2
			user.STASPD += 2
			user.STALUC += 2

//check what ascendpoint they are on and add that trait
			switch(src.ascendpoints)
				if(1)
					ADD_TRAIT(user, TRAIT_DECEIVING_MEEKNESS, TRAIT_GENERIC)
					ADD_TRAIT(user, TRAIT_EMPATH, TRAIT_GENERIC)
					ADD_TRAIT(user, TRAIT_STEELHEARTED, TRAIT_GENERIC)
					to_chat(user, span_userdanger("I bow my head in humility as I begin my journey. MAJOR ARCANA : TEMPERANCE, UPRIGHT."))
					psydon_pool.Remove(psydon_pool[1])
					qdel(I)
					return
				if(2)
					to_chat(user, span_userdanger("The world around me means LESS and LESS- I realize how SMALL everything is. MAJOR ARCANA : QUEEN OF CUPS, REVERSED."))
					ADD_TRAIT(user, TRAIT_NOSTINK, TRAIT_GENERIC)
					ADD_TRAIT(user, TRAIT_NOMOOD, TRAIT_GENERIC)
					ADD_TRAIT(user, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
					psydon_pool.Remove(psydon_pool[1])
					qdel(I)
					return
				if(3)
					ADD_TRAIT(user, TRAIT_NOPAIN, TRAIT_GENERIC)
					ADD_TRAIT(user, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
					to_chat(user, span_userdanger("I have many enemies- AND they HAVE NOTHING. TEN OF SWORDS, UPRIGHT"))
					psydon_pool.Remove(psydon_pool[1])
					qdel(I)
					return
				if(4)
					ADD_TRAIT(user, TRAIT_STABLEHEART, TRAIT_GENERIC)
					ADD_TRAIT(user, TRAIT_STABLELIVER, TRAIT_GENERIC)
					to_chat(user, span_userdanger("My insides BECOME like INCONGRUOUS STONE. Lines of vapour cross me over. I can NOT be mortal, I am BEYOND MORTAL, I AM I AM I AM I AM NEARING COMPLETION. MAJOR ARCANA : STRENGTH"))
					psydon_pool.Remove(psydon_pool[1])
					qdel(I)
					return
				else
					to_chat(user, span_danger("There are nO MORE ARTEFACts to collect. It is time for my BUSINESS to be DONE."))
					return

//handles capstones
		else if(istype(I, capstone_pool[1]))
			src.ascend_stage += 1
			user.STASTR += 2
			user.STAPER += 2
			user.STAINT += 2
			user.STACON += 2
			user.STAEND += 2
			user.STASPD += 2
			user.STALUC += 2

			switch(src.ascend_stage)
				if(1)
					ADD_TRAIT(user, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
					to_chat(user, span_danger("The first capstone. My mind opens. The world around me seems to get smaller. A corpse. We are living on a corpse. And this deadite must be dealt with the same as the rest. My pace stiffens."))
					user.mind.AddSpell(/obj/effect/proc_holder/spell/targeted/churn)
					capstone_pool.Remove(capstone_pool[1])
					qdel(I)
					addomen(ASCEND_FIRST)
					priority_announce("The leylines begin to tremble in unnatural perversion - MAJOR ARCANA: THE FOOL, UPRIGHT.", "THE DREAMER", 'sound/villain/dreamer_warning.ogg')
					return
				if(2)
					qdel(I)
					to_chat(user, span_danger("The second capstone. Stuck in filth- FILTH AND SHIT! I grab the rotted, fetted thing and begin to peel it back. LAYER BY LAYER- THE COMET SYON. THE ARCHDEVIL. IS HE DEAD, OR SLEEPING? ..."))
					sleep(30)
					to_chat(user, span_userdanger("IS HE WEAK - OR A COWARD??"))
					sleep(20)
					to_chat(user, span_userdanger("GOD IS COMING."))
					sleep(10)
					to_chat(user, span_userdanger("GODISCOMINGGODISCOMING"))
					addomen(ASCEND_FIRST)
					ADD_TRAIT(user, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
					capstone_pool.Remove(capstone_pool[1])
					priority_announce("The sky begins to turn quicker - MAJOR ARCANA: THE HANGED MAN, REVERSED", "THE DREAMER ", 'sound/villain/dreamer_warning.ogg')
					return
				if(3)
					capstone_pool.Remove(capstone_pool[1])
					qdel(I)
					to_chat(user, span_danger("AGONY. SPLITTING HEADACHE. THROBBING OF THE SOUL."))
					user.flash_fullscreen("redflash3")
					user.emote("agony", forced = TRUE)
					sleep(20)
					to_chat(user, span_userdanger("THEW ORLD is not real. my BREATH IS gone. my heart barely baeats. my veins are empty."))
					sleep(50)
					to_chat(user, span_userdanger("i am god. i am god. i am god. i am god. i am god. i am god. i am god. i am god. i am god. i am god. i am god. i am god."))
					sleep(30)
					to_chat(user, span_userdanger("i am god i am god i am go di am ogod I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD"))
					user.flash_fullscreen("redflash3")
					user.emote("agony", forced = TRUE)
					user.Stun(30)
					user.Knockdown(30)
					sleep(30)
					to_chat(user, span_userdanger("i am god i am god i am go di am ogod I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD"))
					user.flash_fullscreen("redflash3")
					user.emote("agony", forced = TRUE)
					user.Stun(100)
					user.Knockdown(100)
					user.SetSleeping(10 SECONDS)
					for(var/i = 1, i <= 10, i++)
						spawn((i - 1) * 5)
							to_chat(user, span_userdanger("I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD I AM GOD "))
					sleep(30)
					user.flash_fullscreen("redflash3")

//all goes dark. tp them over. give them their stats.
					user.emote("agony", forced = TRUE)
					to_chat(user, span_reallybig("THE WORLD GOES DARK!"))
					var/turf/location = get_spawn_turf_for_job("Pilgrim")
					user.forceMove(location)
					user.Stun(50)
					user.cmode_music = 'sound/music/combat_ascended.ogg'
					user.STASTR += 10
					user.STAPER += 10
					user.STAINT += 10
					user.STACON += 10
					user.STAEND += 10
					user.STASPD += 10
					user.STALUC += 6

					heavensaysdanger() //Roger, our deal is honored; you will be rewarded in heaven.
					addomen(ASCEND_ASCENDANT)
					qdel(src)
					return



		else
			to_chat(user, span_userdanger("This item is USELESS to me.."))






/obj/structure/ascendant_altar/attack_right(mob/living/user)

	for(var/mob/living/carbon/human/victim)
		if(victim.mind?.has_antag_datum(/datum/antagonist/ascendant))
			to_chat(victim, span_userdanger("I have collected [src.ascend_stage] capstones and [src.ascendpoints] artefacts."))
		else
			to_chat(victim, span_userdanger("I have no idea what this is."))


/obj/structure/ascendant_altar/proc/heavensaysdanger()

	priority_announce("THE DREAMER HAS ASCENDED - MAJOR ARCANA : T$yh3 TOW##ER, UP r4IGHT", "GOD IS COMING", 'sound/villain/ascendant_intro.ogg')