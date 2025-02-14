/datum/virtue/utility/noble
	name = "Nobility"
	desc = "By birth, blade or brain, I am noble known to the royalty of these lands, and have all the benefits associated with it."
	added_traits = list(TRAIT_NOBLE)
	added_skills = list(/datum/skill/misc/reading = 1)
	added_stashed_items = list("Heirloom Amulet" = /obj/item/clothing/neck/roguetown/ornateamulet/noble)

/datum/virtue/utility/noble/apply_to_human(mob/living/carbon/human/recipient)
	SStreasury.noble_incomes[recipient] += 15
	var/obj/item/pouch = new /obj/item/storage/belt/rogue/pouch/coins/virtuepouch(get_turf(recipient))
	recipient.put_in_hands(pouch, forced = TRUE)

/datum/virtue/utility/beautiful
	name = "Beautiful"
	desc = "Wherever I go, I turn heads, such is my natural beauty. I am also rather good in bed, though they always say that."
	added_traits = list(TRAIT_BEAUTIFUL,TRAIT_GOODLOVER)

/datum/virtue/utility/beautiful/handle_traits(mob/living/carbon/human/recipient)
	..()
	if(HAS_TRAIT(recipient, TRAIT_UNSEEMLY))
		to_chat(recipient, "Your attractiveness is cancelled out! You become normal.")
		REMOVE_TRAIT(recipient, TRAIT_BEAUTIFUL, TRAIT_VIRTUE)
		REMOVE_TRAIT(recipient, TRAIT_UNSEEMLY, TRAIT_VIRTUE)

/datum/virtue/utility/deadened
	name = "Deadened"
	desc = "Some terrible incident colours my past, and now, I feel nothing."
	added_traits = list(TRAIT_NOMOOD)

/datum/virtue/utility/light_steps
	name = "Light Steps"
	desc = "Years of skulking about have left my steps quiet, and my hunched gait quicker."
	added_traits = list(TRAIT_LIGHT_STEP)
	added_skills = list(list(/datum/skill/misc/sneaking, 3, 6))

/datum/virtue/utility/resident
	name = "Resident"
	desc = "I'm a resident of Azure Peak. I have an account in the city's treasury and a home in the city."
	added_traits = list(TRAIT_RESIDENT)

/datum/virtue/utility/linguist
	name = "Intellectual"
	desc = "I've spent my life surrounded by various books or sophisticated foreigners, be it through travel or other fortunes beset on my life. I've picked up several tongues and wits, and keep a journal closeby. I can tell people's exact prowess.(+1 INT, 3 Languages, Stashed Book, Ability to Assess)"
	added_traits = list(TRAIT_INTELLECTUAL)

/datum/virtue/utility/linguist/apply_to_human(mob/living/carbon/human/recipient)
	var/list/selectable_languages = list(/datum/language/elvish, /datum/language/dwarvish, /datum/language/orcish, /datum/language/hellspeak, /datum/language/draconic, /datum/language/celestial, /datum/language/grenzelhoftian)
	var/list/choices = list()
	for(var/i = 1, i <= selectable_languages.len, i++)
		if (recipient.has_language(selectable_languages[i]))
			continue
		var/datum/language/a_language = selectable_languages[i]
		choices["[a_language.name]"] = a_language
	if (!LAZYLEN(choices))
		return // no new languages to learn - we probably picked archivist
	var/lang_count = 3
	var/count = lang_count
	for(var/i = 1, i <= lang_count, i++)
		var/chosen_language = input(recipient, "Choose your extra spoken language.", "VIRTUE: [count] LEFT") as null|anything in choices
		if (chosen_language)
			var/datum/language/new_language = choices[chosen_language]
			recipient.grant_language(new_language)
			LAZYREMOVE(choices,chosen_language)
			to_chat(recipient, span_info("I recall my knowledge of [new_language.name]..."))	
			count--
	recipient.change_stat("intelligence", 1)
	added_skills = list(list(/datum/skill/misc/reading, 3, 6))
	added_stashed_items = list(
		"Quill" = /obj/item/natural/feather,
		"Scroll" = /obj/item/paper/scroll,
		"Book" = /obj/item/book/rogue/playerbook
	)

/datum/virtue/utility/deathless
	name = "Deathless"
	desc = "Some fell magick has rendered me inwardly unliving - I do not hunger, and I do not breathe."
	added_traits = list(TRAIT_NOHUNGER, TRAIT_NOBREATH)

/*/datum/virtue/utility/deathless/apply_to_human(mob/living/carbon/human/recipient)
	recipient.mob_biotypes |= MOB_UNDEAD*/

/datum/virtue/utility/blacksmith
	name = "Blacksmith's Apprentice"
	desc = "In my youth, I worked under a skilled blacksmith, honing my skills with an anvil. (Apprentice in crafting, blacksmithing, weaponsmithing, armorsmithing, and smelting.)"
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/weaponsmithing, 2, 2),
						list(/datum/skill/craft/armorsmithing, 2, 2),
						list(/datum/skill/craft/blacksmithing, 2, 2),
						list(/datum/skill/craft/smelting, 2, 2)
	)

/datum/virtue/utility/hunter
	name = "Hunter's Apprentice"
	desc = "In my youth, I trained under a skilled hunter, learning how to butcher animals and work with leather/hide. (Apprentice in crafting, trapmaking, tracking, butchering, sewing, and tanning.)"
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/traps, 2, 2),
						list(/datum/skill/labor/butchering, 2, 2),
						list(/datum/skill/misc/sewing, 2, 2),
						list(/datum/skill/craft/tanning, 2, 2),
						list(/datum/skill/misc/tracking, 2, 2)
	)

/datum/virtue/utility/artificer
	name = "Artificer's Apprentice"
	desc = "In my youth, I worked under a skilled artificer, studying construction and engineering. (Apprentice in crafting, engineering, carpentry, masonry, and smelting.)"
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/carpentry, 2, 2),
						list(/datum/skill/craft/masonry, 2, 2),
						list(/datum/skill/craft/engineering, 2, 2),
						list(/datum/skill/craft/smelting, 2, 2)
	)

/datum/virtue/utility/physician
	name = "Physician's Apprentice"
	desc = "In my youth, I worked under a skilled physician, studying medicine and alchemy. (Apprentice in crafting, alchemy, and medicine. Stashed first aid pouch.)"
	added_stashed_items = list("Medicine Pouch" = /obj/item/storage/belt/rogue/pouch/medicine)
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/alchemy, 2, 2),
						list(/datum/skill/misc/alchemy, 2, 2),
						list(/datum/skill/misc/medicine, 2, 2)
	)

/datum/virtue/utility/feral_appetite
	name = "Feral Appetite"
	desc = "Raw, toxic or spoiled food doesn't bother my superior digestive system."
	added_traits = list(TRAIT_NASTY_EATER)

/datum/virtue/utility/night_vision
	name = "Night-eyed"
	desc = "I have eyes able to see through cloying darkness."

/datum/virtue/utility/night_vision/apply_to_human(mob/living/carbon/human/recipient)
	var/obj/item/organ/eyes/eyes = recipient.getorganslot(ORGAN_SLOT_EYES)
	if(!eyes)
		return
	eyes.see_in_dark = 12
	eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_DARKVISION
	recipient.update_sight()

/datum/virtue/utility/performer
	name = "Performer"
	desc = "Music, artistry and the act of showmanship carried me through life. I've hidden a favorite instrument of mine, know how to please anyone I touch, and how to crack the eggs of hecklers."
	added_traits = list(TRAIT_NUTCRACKER, TRAIT_GOODLOVER)

/datum/virtue/utility/performer/apply_to_human(mob/living/carbon/human/recipient)
	added_skills = list(list(/datum/skill/misc/music, 3, 6))
	var/list/instruments = list()
	for(var/path in subtypesof(/obj/item/rogue/instrument))
		var/obj/item/rogue/instrument/instr = path
		instruments[instr.name] = path
	var/item = input(recipient, "What instrument did I stash?", "STASH") as null|anything in instruments
	if(item)
		var/instr = instruments[item]
		var/obj/item/rogue/instrument/I = instr
		recipient.mind?.special_items[I.name] = instr

/datum/virtue/utility/larcenous
	name = "Larcenous"
	desc = "Whether it was asked of you, or by a calling for the rush deep within your hollow heart, you seek things that don't belong you. You know how to work a lock, and have stashed a ring of them, for just the occasion."
	added_stashed_items = list("Lockpick Ring" = /obj/item/lockpickring/mundane)
	added_skills = list(list(/datum/skill/misc/lockpicking, 3, 6))

/datum/virtue/utility/granary
	name = "Personal Granary"
	desc = "You've worked in or around the kitchens enough to steal away a sack of supplies that no one would surely miss, just in case. You've picked up on some cooking tips in your spare time, as well."
	added_stashed_items = list("Bag of Food" = /obj/item/storage/roguebag/food)
	added_skills = list(list(/datum/skill/craft/cooking, 3, 6))

/datum/virtue/utility/mining
	name = "Miner's Apprentice"
	desc = "The dark shafts, the damp smells of ichor and the laboring hours are no stranger to me. I keep my pickaxe and lamptern close, and have been taught how to mine well."
	added_stashed_items = list(
		"Steel Pickaxe" = /obj/item/rogueweapon/pick/steel,
		"Lamptern" = /obj/item/flashlight/flare/torch/lantern)
	added_skills = list(list(/datum/skill/labor/mining, 3, 6))

/datum/virtue/utility/ugly
	name = "Ugly"
	desc = "Be it your family's habits in and out of womb, your own choices or Xylix's cruel roll of fate, you have been left unbearable to look at. Stuck to the unseen pits and crevices of the town, you've grown used to the foul odours of lyfe that often follow you. Corpses do not stink for you, and that is all the company you might find."
	added_traits = list(TRAIT_UNSEEMLY, TRAIT_NOSTINK)

/datum/virtue/utility/ugly/handle_traits(mob/living/carbon/human/recipient)
	..()
	if(HAS_TRAIT(recipient, TRAIT_BEAUTIFUL))
		to_chat(recipient, "Your repulsiveness is cancelled out! You become normal.")
		REMOVE_TRAIT(recipient, TRAIT_BEAUTIFUL, TRAIT_VIRTUE)
		REMOVE_TRAIT(recipient, TRAIT_UNSEEMLY, TRAIT_VIRTUE)

/datum/virtue/utility/secondvoice
	name = "Second Voice"
	desc = "From performance, deception, or by a need to change yourself in uncanny ways, you've acquired a second, perfect voice. You may switch between them at any point."

/datum/virtue/utility/secondvoice/apply_to_human(mob/living/carbon/human/recipient)
	recipient.verbs += /mob/living/carbon/human/proc/changevoice
	recipient.verbs += /mob/living/carbon/human/proc/swapvoice

/datum/virtue/utility/keenears
	name = "Keen Ears"
	desc = "Cowering from authorities, loved ones or by a generous gift of the gods, you've adapted a keen sense of hearing, and can identify the speakers even when they are out of sight, and their whispers are louder to you. Along with this, you've developed good eyes for tracking, letting you keep those you fear, or those you seek, in your sights."
	added_skills = list(list(/datum/skill/misc/tracking, 3, 6))
	added_traits = list(TRAIT_KEENEARS)


//HERETIC VIRTUES (there's only pne amd it's utility so I didn't want to make a whole file yet)

/datum/virtue/heretic/seer
	name = "(ASCENDANT) Seer"
	desc = "You've spent your days studying the tales writ and told by the Ecclesiarchy's rejects and priests alike. You've grown to tell the followers by hunch and sight. They give themselves away so easily in this world slowly brewing to a fester."
	added_traits = list(TRAIT_HERETIC_SEER)
