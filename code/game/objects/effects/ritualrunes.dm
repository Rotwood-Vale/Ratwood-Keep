#define isstack(A) (istype(A, /obj/item/stack))

/obj/effect/decal/cleanable/roguerune	// basis for all rituals
	name = "ritualrune"
	desc = "Strange symbols pulse upon the ground..."
	anchored = TRUE
	icon = 'icons/obj/rune.dmi'
	icon_state = "6"
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	layer = SIGIL_LAYER
	color = null
	var/magictype = "arcyne"//"arcyne", "divine", "druid", "blood"
	var/runesize = 1	//Used to determine range of 'range' of the rune when counting for invokers. Should correspond to rune size. EX: 32x32 and 96x96 should be size 1. Increase each size by one for every tile radius increase after.
	var/invoker_name = "basic rune"

	/// The description of the ritual rune shown to those who have knowledge to examine it
	var/invoker_desc = "a basic rune with no function."

	/// This is said by those when the rune is invoked.
	var/invocation = "Aiy ele-mayo!"
	/// The amount of invokers required around the rune to invoke it.
	var/req_invokers = 1

	/// If we have a description override for required invokers to invoke
	var/req_invokers_text
	/// Used for some runes, this is for when you want a rune to not be usable when in use.
	var/rune_in_use = FALSE

	/// Used when you want to keep track of who erased the rune
	var/log_when_erased = FALSE
	/// Number of rituals able to be selected with this rune- Requires picking one in attack hand
	var/ritual_number = 1
	/// Whether this rune can be scribed or if it's admin only / special spawned / whatever
	var/can_be_scribed = TRUE
	/// How long the rune takes to erase
	var/erase_time = 1.5 SECONDS
	/// How long the rune takes to create
	var/scribe_delay = 4 SECONDS
	/// If a rune cannot be speed boosted while scribing on certain turfs
	var/no_scribe_boost = FALSE
	/// If a rune provides a bonus to a spell, or spellbook reading.
	var/spellbonus = 0
	/// Hhow much damage you take doing it
	var/scribe_damage = 0.1
	/// How much damage invokers take when invoking it
	var/invoke_damage = 0
	/// If the rune requires a keyword when scribed
	var/req_keyword = FALSE
	/// The actual keyword for the rune
	var/keyword
	/// Global proc to call while the rune is being created
	var/started_creating
	/// Global proc to call if the rune fails to be created
	var/failed_to_create
	var/active = FALSE
	/// Tier var is used for 'tier' of rune, if the rune has tiers. EX: Summoning runes. If it doesn't have tiers, set tier to 0.
	var/tier = 1


/proc/isarcyne(mob/living/carbon/human/A)
	return istype(A) && A.mind && (A.mind?.get_skill_level(/datum/skill/magic/arcane) > SKILL_LEVEL_NONE)	//checks if person has arcane skill

/proc/isdivine(mob/living/carbon/human/A)
	return istype(A) && A.mind && (A.mind?.get_skill_level(/datum/skill/magic/holy) > SKILL_LEVEL_NONE)	//checks if person has holy/divine skill

/proc/isdruid(mob/living/carbon/human/A)
	return istype(A) && A.mind && (A.mind?.get_skill_level(/datum/skill/magic/druidic) > SKILL_LEVEL_NONE)	//checks if person has druidic skill

/proc/isblood(mob/living/carbon/human/A)
	return istype(A) && A.mind && (A.mind?.get_skill_level(/datum/skill/magic/blood) > SKILL_LEVEL_NONE)		//checks if person has blood magic skill

GLOBAL_LIST_INIT(rune_types, generate_rune_types())
GLOBAL_LIST_INIT(runeritualslist, generate_runeritual_types())
GLOBAL_LIST_INIT(allowedrunerituallist, generate_allowed_runeritual_types())

/// Returns an associated list of rune types. [rune.cultist_name] = [typepath]
/proc/generate_rune_types()
	RETURN_TYPE(/list)
	var/list/runes = list()
	for(var/obj/effect/decal/cleanable/roguerune/rune as anything in subtypesof(/obj/effect/decal/cleanable/roguerune))
		if(!initial(rune.can_be_scribed))
			continue
		runes[initial(rune.name)] = rune // Uses the invoker name for displaying purposes
	return runes

/proc/generate_runeritual_types()	//debug list
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in typesof(/datum/runerituals))
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/proc/generate_allowed_runeritual_types()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in typesof(/datum/runerituals))
		if(runeritual.blacklisted)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/obj/effect/decal/cleanable/roguerune/Initialize(mapload)
	. = ..()
/*	if(!LAZYLEN(GLOB.runeritualslist))
		testing("initializing ritualslist")
		GLOB.runeritualslist = list()
		var/static/list/rituals = subtypesof(/datum/runerituals)
		for(var/path in rituals)
			var/datum/ritual/G = path
			testing("now initializing: [path]")
			testing("[G.name]")
			GLOB.runeritualslist[G.name] = G*/

/obj/effect/decal/cleanable/roguerune/examine(mob/user)
	. = ..()
	if(magictype == "arcane")
		if(isarcyne(user))
			. += "<b>Name:</b> [invoker_name]\n"+\
			"<b>Effects:</b> [capitalize(invoker_desc)]\n"+\
			"<b>Required Invokers:</b> [req_invokers_text ? "[req_invokers_text]":"[req_invokers]"]"
		if(req_keyword && keyword)
			. += "<b>Keyword:</b> [keyword]"
	if(magictype == "divine")
		if(isdivine(user))
			. += "<b>Name:</b> [invoker_name]\n"+\
			"<b>Effects:</b> [capitalize(invoker_desc)]\n"+\
			"<b>Required Invokers:</b> [req_invokers_text ? "[req_invokers_text]":"[req_invokers]"]"
		if(req_keyword && keyword)
			. += "<b>Keyword:</b> [keyword]"
	if(magictype == "druid")
		if(isdruid(user))
			. += "<b>Name:</b> [invoker_name]\n"+\
			"<b>Effects:</b> [capitalize(invoker_desc)]\n"+\
			"<b>Required Invokers:</b> [req_invokers_text ? "[req_invokers_text]":"[req_invokers]"]"
		if(req_keyword && keyword)
			. += "<b>Keyword:</b> [keyword]"
	if(magictype == "blood")
		if(isblood(user))
			. += "<b>Name:</b> [invoker_name]\n"+\
			"<b>Effects:</b> [capitalize(invoker_desc)]\n"+\
			"<b>Required Invokers:</b> [req_invokers_text ? "[req_invokers_text]":"[req_invokers]"]"
		if(req_keyword && keyword)
			. += "<b>Keyword:</b> [keyword]"

/obj/effect/decal/cleanable/roguerune/proc/invoke(list/invokers, /datum/runerituals)		//Generic invoke proc. This will be defined on every rune, along with effects.If you want to make an object, or provide a buff, do so through this proc., have both here.
	for(var/atom/invoker in invokers)
		if(!isliving(invoker))
			continue
		var/mob/living/living_invoker = invoker
		if(invocation)
			living_invoker.say(invocation, language = /datum/language/common, ignore_spam = TRUE, forced = "cult invocation")
		if(invoke_damage)
			living_invoker.apply_damage(invoke_damage, BRUTE)
			to_chat(living_invoker,  span_italics("[src] saps your strength!"))

	do_invoke_glow()

/obj/effect/decal/cleanable/roguerune/proc/do_invoke_glow()
	set waitfor = FALSE
	animate(src, transform = matrix()*2, alpha = 0, time = 5, flags = ANIMATION_END_NOW) //fade out
	sleep(0.5 SECONDS)
	animate(src, transform = matrix(), alpha = 255, time = 0, flags = ANIMATION_END_NOW)

/obj/effect/decal/cleanable/roguerune/proc/fail_invoke()
	//This proc contains the effects of a rune if it is not invoked correctly, through either invalid wording or not enough cultists. By default, it's just a basic fizzle.
	visible_message(span_warning("The markings pulse with a small flash of light, then fall dark."))
	var/oldcolor = color
	color = rgb(255, 0, 0)
	animate(src, color = oldcolor, time = 5)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, update_atom_colour)), 0.5 SECONDS)

/obj/effect/decal/cleanable/roguerune/attack_hand(mob/living/user)
	if(.)
		return
	if(ritual_number == 1)					//Only one option of ritual for this rune
		var/list/invokers = can_invoke(user)
		if(length(invokers) >= req_invokers)		//Enough invokers? If Yes, invoke
			invoke(invokers)
		else
			to_chat(user, span_danger("You need [req_invokers - length(invokers)] more adjacent invokers to use this rune in such a manner."))	//Needs more invokers, fails invoke
			fail_invoke()
	else
		var/list/invokers = can_invoke(user)
		if(length(invokers) >= req_invokers)
//			var/list/rituals = list()
//			var/datum/runerituals/R
//			for(R in GLOB.allowedrunerituallist)
//				if(R.blacklisted)
//					continue
//				if(R.tier <= src.tier)
//					to_chat(user, span_notice("for R in glob allowed ruenrituals"))
//					rituals.Add(R)
			var/ritualnameinput = input(user, "Rituals", "RATWOOD") as null|anything in GLOB.allowedrunerituallist
			testing("ritualnameinput [ritualnameinput]")
			var/datum/runerituals/pickritual
			pickritual = GLOB.allowedrunerituallist[ritualnameinput]
			if(!pickritual)
				return
			if(!pickritual.tier <= src.tier)
				to_chat(user, span_hierophant_warning("Your ritual rune is not strong enough to perform this ritual."))
			invoke(invokers, pickritual)
		else
			to_chat(user, span_danger("You need [req_invokers - length(invokers)] more adjacent invokers to use this rune in such a manner."))	//Needs more invokers, fails invoke
			fail_invoke()
	. = ..()


/obj/effect/decal/cleanable/roguerune/proc/can_invoke(mob/living/user=null)
	//This proc determines if the rune can be invoked at the time. If there are multiple required invokers, it will find all nearby invokers.
	var/list/invokers = list() //people eligible to invoke the rune
	if(user)
		invokers += user
	if(req_invokers > 1)
		for(var/mob/living/invoker in range(runesize, src))
			if(!invoker.can_speak())
				continue
			if(invoker.stat != CONSCIOUS)
				continue
			if(magictype == "arcane")
				if(isarcyne(invoker))
					invokers += invoker
			if(magictype == "divine")
				if(isdivine(invoker))
					invokers += invoker
			if(magictype == "druid")
				if(isdruid(invoker))
					invokers += invoker
			if(magictype == "blood")
				if(isblood(invoker))
					invokers += invoker
			if(invoker == user)
				continue

	return invokers



/obj/effect/decal/cleanable/roguerune/arcyne	//arcane
	name = "Arcane ritual rune"
	desc = "subtype used for arcane rituals- you should not be seeing this."
	magictype = "arcyne"
	can_be_scribed = FALSE
/obj/effect/decal/cleanable/roguerune/arcyne/attack_hand(mob/living/user)
	if(!isarcyne(user))
		to_chat(user, span_warning("You aren't able to understand the words of [src]."))
		return
	. = ..()

/obj/effect/decal/cleanable/roguerune/arcyne/knowledge	//used for better quality of learning, grants temporary 2 minute INT bonus.
	name = "Knowledge rune"
	desc = "arcane symbols pulse upon the ground..."
	icon_state = "6"
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	layer = SIGIL_LAYER
	color = "#3A0B61"
	spellbonus = 15
	scribe_damage = 10
	can_be_scribed = TRUE
/obj/effect/decal/cleanable/roguerune/arcyne/knowledge/attack_hand(mob/living/user)
	. = ..()

/obj/effect/decal/cleanable/roguerune/arcyne/enchantment

/obj/effect/decal/cleanable/roguerune/arcyne/summoning	//32x32 rune t1(one tile)
	name = "confinement matrix"
	desc = "A relatively basic confinement matrix used to hold small things when summoned."
	ritual_number = 3
	tier = 1
	can_be_scribed = TRUE
	var/summoning = FALSE
	var/mob/living/simple_animal/summoned_mob

/obj/effect/decal/cleanable/roguerune/arcyne/summoning/attack_hand(mob/living/user)
	if(summoning)
		to_chat(user, span_notice("You release the summon from it's containment"))
		sleep(10)
		animate(summoned_mob, color = "#660099",time = 5)
		REMOVE_TRAIT(summoned_mob, TRAIT_PACIFISM, TRAIT_GENERIC)	//can't kill while planar bound.
		summoned_mob.status_flags -= GODMODE//remove godmode
		summoned_mob.binded = FALSE	//BE FREE!!
		summoned_mob = null
		summoning = FALSE
	. = ..()

/obj/effect/decal/cleanable/roguerune/arcyne/summoning/invoke(list/invokers, datum/runerituals/runeritual)
	//This proc contains the effects of the rune as well as things that happen afterwards. If you want it to spawn an object and then delete itself, have both here.
	var/list/atom/movable/atoms_in_range = list()
	for(var/atom/close_atom as anything in range(runesize, src))
		if(!ismovable(close_atom))
			continue
		if(isitem(close_atom))
			var/obj/item/close_item = close_atom
			if(close_item.item_flags & ABSTRACT) //woops sacrificed your own head
				continue
		if(close_atom.invisibility)
			continue
		if(close_atom == usr)
			continue
		if(close_atom == src)
			continue
		atoms_in_range += close_atom
	var/datum/runerituals/pickritual = new runeritual
	to_chat(invokers, span_notice("invoked"))
	to_chat(invokers, json_encode(pickritual.required_atoms, JSON_PRETTY_PRINT))
	if(!islist(pickritual.required_atoms))
		to_chat(invokers, span_notice("required atoms is NOT a list"))

	// A copy of our requirements list.
	// We decrement the values of to determine if enough of each key is present.

	var/list/requirements_list = pickritual.required_atoms.Copy()
	var/list/banned_atom_types = pickritual.banned_atom_types.Copy()
	// A list of all atoms we've selected to use in this recipe.
	var/list/selected_atoms = list()
	for(var/atom/nearby_atom as anything in atoms_in_range)
		// Go through all of our required atoms
		for(var/req_type in requirements_list)
			// We already have enough of this type, skip
			if(requirements_list[req_type] <= 0)
				continue
			// If req_type is a list of types, check all of them for one match.
			if(islist(req_type))
				if(!(is_type_in_list(nearby_atom, req_type)))
					continue
			else if(!istype(nearby_atom, req_type))
				continue
			// if list has items, check if the strict type is banned.
			if(length(banned_atom_types))
				if(nearby_atom.type in banned_atom_types)
					continue
			// This item is a valid type. Add it to our selected atoms list.
			selected_atoms |= nearby_atom
			// If it's a stack, we gotta see if it has more than one inside,
			// as our requirements may want more than one item of a stack
			if(isstack(nearby_atom))
				var/obj/item/stack/picked_stack = nearby_atom
				requirements_list[req_type] -= picked_stack.amount // Can go negative, but doesn't matter. Negative = fulfilled

			// Otherwise, just add the mark down the item as fulfilled x1
			else
				requirements_list[req_type]--

	var/list/what_are_we_missing = list()
	for(var/req_type in requirements_list)
		var/number_of_things = requirements_list[req_type]
		// <= 0 means it's fulfilled, skip
		if(number_of_things <= 0)
			continue
		// > 0 means it's unfilfilled - the ritual has failed, we should tell them why
		// Lets format the thing they're missing and put it into our list
		var/formatted_thing = "[number_of_things] "
		if(islist(req_type))
			var/list/req_type_list = req_type
			var/list/req_text_list = list()
			for(var/atom/possible_type as anything in req_type_list)
				req_text_list += pickritual.parse_required_item(possible_type)
			formatted_thing += english_list(req_text_list, and_text = "or")

		else
			formatted_thing = pickritual.parse_required_item(req_type)

		what_are_we_missing += formatted_thing

	if(length(what_are_we_missing))
		// Let them know it screwed up
		to_chat(usr, "ritual failed, missing components!")
		// Then let them know what they're missing
		to_chat(usr, span_hierophant_warning("You are missing [english_list(what_are_we_missing)] in order to complete the ritual \"[pickritual.name]\"."))
		return FALSE
	playsound(usr, 'sound/magic/teleport_diss.ogg', 75, TRUE)
	// All the components have been invisibled, time to actually do the ritual. Call on_finished_recipe
	// (Note: on_finished_recipe may sleep in the case of some rituals like summons, which expect ghost candidates.)
	// - If the ritual was success (Returned TRUE), proceede to clean up the atoms involved in the ritual. The result has already been spawned by this point.
	// - If the ritual failed for some reason (Returned FALSE), likely due to no ghosts taking a role or an error, we shouldn't clean up anything, and reset.
	var/ritual_result = pickritual.on_finished_recipe(usr, selected_atoms, loc)
	if(ismob(ritual_result))
		summoned_mob = ritual_result
		src.summoning = TRUE
	if(ritual_result)
		pickritual.cleanup_atoms(selected_atoms)

	for(var/atom/invoker in invokers)
		if(!isliving(invoker))
			continue
		var/mob/living/living_invoker = invoker
		to_chat(living_invoker, span_notice("[living_invoker]"))
		if(invocation)
			living_invoker.say(invocation, language = /datum/language/common, ignore_spam = TRUE, forced = "cult invocation")
		if(invoke_damage)
			living_invoker.apply_damage(invoke_damage, BRUTE)
			to_chat(living_invoker,  span_italics("[src] saps your strength!"))
	do_invoke_glow()




/obj/effect/decal/cleanable/roguerune/arcyne/summoning/mid// 96x96 rune t2(3x3 tile)
	name = "sealate confinement matrix"
	desc = "An adept confinement matrix improved with the addition of a sealate matrix; used to hold things when summoned."
	icon = 'icons/effects/96x96.dmi'
	icon_state = "sealate"
	tier = 2
	pixel_x = -32 //So the big ol' 96x96 sprite shows up right
	pixel_y = -32
	pixel_z = 0
	can_be_scribed = TRUE

/obj/effect/decal/cleanable/roguerune/arcyne/summoning/adv	//160x160 rune t2(5x5 tile)
	name = "warded sealate confinement matrix"
	desc = "An thoroughly warded confinement matrix improved with the addition of a sealate matrix; used to hold larger, dangerous things when summoned."
	icon = 'icons/effects/160x160.dmi'
	icon_state = "warded"
	runesize = 2
	tier = 3
	pixel_x = -64 //So the big ol' 96x96 sprite shows up right
	pixel_y = -64
	pixel_z = 0
	can_be_scribed = TRUE

/obj/effect/decal/cleanable/roguerune/arcyne/summoning/max	//224x224 rune t3(7x7 tile)
	name = "noc's eye warded sealate confinement matrix"
	desc = "An thoroughly warded confinement matrix improved with a Noc's eye sealing measure and the addition of a sealate matrix; used to hold the largest, most dangerous things summonable."
	icon = 'icons/effects/224x224.dmi'
	icon_state = "hugerune"
	runesize = 3
	tier = 4
	pixel_x = -96 //So the big ol' 96x96 sprite shows up right
	pixel_y = -96
	pixel_z = 0
	can_be_scribed = TRUE

/obj/effect/decal/cleanable/roguerune/arcyne/enchanting




/obj/effect/decal/cleanable/roguerune/divine	//To be used for divine rituals.
	magictype = "divine"
	can_be_scribed = FALSE
/obj/effect/decal/cleanable/roguerune/divine/attack_hand(mob/living/user)
	if(!isdivine(user))
		to_chat(user, span_warning("You aren't able to understand the words of [src]."))
		return
	. = ..()



/obj/effect/decal/cleanable/roguerune/druid		//to be used with druid magick
	magictype = "druid"
	can_be_scribed = FALSE
/obj/effect/decal/cleanable/roguerune/druid/attack_hand(mob/living/user)
	if(!isdruid(user))
		to_chat(user, span_warning("You aren't able to understand the words of [src]."))
		return
	. = ..()


/obj/effect/decal/cleanable/roguerune/blood		//to be used with blood magick
	magictype = "blood"
	can_be_scribed = FALSE
/obj/effect/decal/cleanable/roguerune/blood/attack_hand(mob/living/user)
	if(!isblood(user))
		to_chat(user, span_warning("You aren't able to understand the words of [src]."))
		return
	. = ..()

/obj/item/rogueweapon/huntingknife/idagger/silver/arcyne
	name = "glowing purple silver dagger"
	desc = "This dagger glows a faint purple. Powder runs across its blade."
	var/is_bled = FALSE
	var/rune_to_scribe = null

/obj/item/rogueweapon/huntingknife/idagger/silver/arcyne/Initialize()
	. = ..()
	filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(128, 0, 128, 1))

/obj/item/rogueweapon/huntingknife/idagger/silver/attackby(obj/item/M, mob/user, params)
	var/mob/living/carbon/gamer = user
	if(istype(M, /obj/item/reagent_containers/glass/bottle/rogue))
		var/reagent_to_check = /datum/reagent/medicine/manapot
		var/reagents = M.reagents
		if(reagent_to_check in reagents  && isarcyne(gamer))
			var/crafttime = (60 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(loc, 'sound/magic/scrapeblade.ogg', 100, TRUE)
				to_chat(user, span_notice("I scrape the arcyne powder into the blade, and it throbs in a deep purple..."))
				var/obj/arcyne_knife = new /obj/item/rogueweapon/huntingknife/idagger/silver/arcyne
				qdel(M)
				qdel(src)
				user.put_in_active_hand(arcyne_knife)
	else
		return ..()

/obj/item/rogueweapon/huntingknife/idagger/silver/arcyne/attack_self(mob/living/carbon/human/user)

	if(!isarcyne(user))
		return
	if(!is_bled)
		playsound(loc, get_sfx("genslash"), 100, TRUE)
		user.visible_message(span_warning("[user] cuts open [user.p_their()] palm!"), \
							span_cult("I slice open my palm!"))
		if(user.blood_volume)
			var/obj/effect/decal/cleanable/roguerune/rune = rune_to_scribe
			user.apply_damage(initial(rune.scribe_damage), BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		is_bled = TRUE
		return
	var/datum/ritual/pickrune
	var/runenameinput = input(user, "Runes", "RATWOOD") as null|anything in GLOB.rune_types
	testing("runenameinput [runenameinput]")
	pickrune = GLOB.rune_types[runenameinput]
	rune_to_scribe = pickrune
	if(rune_to_scribe == null)
		return
	var/turf/Turf = get_turf(user)
	if(locate(/obj/effect/decal/cleanable/roguerune) in Turf)
		to_chat(user, span_cult("There is already a rune here."))
		return
	var/structures_in_way = check_for_structures_and_closed_turfs(loc, rune_to_scribe)
	if(structures_in_way == TRUE)
		to_chat(user, span_cult("There is a structure, rune or wall in the way."))
		return
	var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))

	user.visible_message(span_notice("I start drag the blade in the shape of symbols and sigils"))
	if(do_after(user, crafttime, target = src))
		playsound(loc, 'sound/magic/bladescrape.ogg', 100, TRUE)
		user.visible_message(span_warning("[user] carves an arcyne rune with [user.p_their()] [src]!"), \
		span_notice("I finish dragging the blade in symbols and circles, leaving behind an ritual rune"))
		new rune_to_scribe(Turf)

/obj/item/rogueweapon/huntingknife/idagger/proc/check_for_structures_and_closed_turfs(loc, var/obj/effect/decal/cleanable/roguerune/rune_to_scribe)
	for(var/turf/T in range(loc, rune_to_scribe.runesize))
		//check for /sturcture subtypes in the turf's contents
		for(var/obj/structure/S in T.contents)
			return TRUE		//Found a structure, no need to continue

		//check if turf itself is a /turf/closed subtype
		if(istype(T,/turf/closed))
			return TRUE
		//check if rune in the turfs contents
		for(var/obj/effect/decal/cleanable/roguerune/R in T.contents)
			return TRUE
		//Return false if nothing in range was found
	return FALSE



/datum/runerituals/proc/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	if(!length(result_atoms))
		return FALSE

	for(var/result in result_atoms)
		new result(loc)
	return TRUE

/datum/runerituals/proc/parse_required_item(atom/item_path, number_of_things)
	// If we need a human, there is a high likelihood we actually need a (dead) body
	if(ispath(item_path, /mob/living/carbon/human))
		return "bod[number_of_things > 1 ? "ies" : "y"]"
	if(ispath(item_path, /mob/living))
		return "carcass[number_of_things > 1 ? "es" : ""] of any kind"
	return "[initial(item_path.name)]\s"

/**
 * Called after on_finished_recipe returns TRUE
 * and a ritual was successfully completed.
 *
 * Goes through and cleans up (deletes)
 * all atoms in the selected_atoms list.
 *
 * Remove atoms from the selected_atoms
 * (either in this proc or in on_finished_recipe)
 * to NOT have certain atoms deleted on cleanup.
 *
 * Arguments
 * * selected_atoms - a list of all atoms we intend on destroying.
 */
/datum/runerituals/proc/cleanup_atoms(list/selected_atoms)
	SHOULD_CALL_PARENT(TRUE)

	for(var/atom/sacrificed as anything in selected_atoms)
		if(isliving(sacrificed))
			continue

		if(isstack(sacrificed))
			var/obj/item/stack/sac_stack = sacrificed
			var/how_much_to_use = 0
			for(var/requirement in required_atoms)
				// If it's not requirement type and type is not a list, skip over this check
				if(!istype(sacrificed, requirement) && !islist(requirement))
					continue
				// If requirement *is* a list and the stack *is* in the list, skip over this check
				if(islist(requirement) && !is_type_in_list(sacrificed, requirement))
					continue
				how_much_to_use = min(required_atoms[requirement], sac_stack.amount)
				break
			sac_stack.use(how_much_to_use)
			continue

		selected_atoms -= sacrificed
		qdel(sacrificed)


/datum/runerituals
	var/name
	var/desc
	var/list/required_atoms = list()
	var/list/result_atoms = list()
	var/list/banned_atom_types = list()
	var/mob_to_summon
	var/blacklisted = FALSE
	var/tier = 0				/// Tier var is used for 'tier' of ritual, if the ritual has tiers. EX: Summoning rituals. If it doesn't have tiers, set tier to 0.

/datum/runerituals/buff

/datum/runerituals/buff/knowledge

/datum/runerituals/enchantment


/datum/runerituals/summoning
	name = "summoning ritual parent"
	desc = "summoning parent rituals."
	blacklisted = TRUE

/datum/runerituals/summoning/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return summon_ritual_mob(user, loc, mob_to_summon)


/datum/runerituals/summoning/proc/summon_ritual_mob(mob/living/user, turf/loc, mob/living/mob_to_summon)
	var/mob/living/simple_animal/summoned
	if(isliving(mob_to_summon))
		summoned = mob_to_summon
	else
		summoned = new mob_to_summon(loc)
		ADD_TRAIT(summoned, TRAIT_PACIFISM, TRAIT_GENERIC)	//can't kill while planar bound.
		summoned.status_flags += GODMODE//It's not meant to be killable until released from it's planar binding.
		summoned.binded = TRUE	//No auto movement, no moving to targets
		animate(summoned, color = "#660099",time = 5)
		return summoned

/datum/runerituals/summoning/imp
	name = "summoning lesser infernal"
	desc = "summons an infernal imp"
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/obj/item/ash = 2, /obj/item/natural/obsidian = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing

/datum/runerituals/summoning/hellhound
	name = "summoning hellhound"
	desc = "summons a hellhound"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/obj/item/natural/infernalash = 3, /obj/item/natural/obsidian = 1, /obj/item/natural/melded/t1 = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing

/datum/runerituals/summoning/watcher
	name = "summoning infernal watcher"
	desc = "summons an infernal watcher"
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/obj/item/natural/hellhoundfang = 2, /obj/item/natural/obsidian = 1, /obj/item/natural/melded/t2 =1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing

/datum/runerituals/summoning/archfiend
	name = "summoning archfiend"
	desc = "summons an archfiend"
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/obj/item/natural/moltencore = 1, /obj/item/natural/obsidian = 1, /obj/item/natural/melded/t3 =1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing

/datum/runerituals/summoning/sprite
	name = "summoning sprite"
	desc = "summons an fae sprite"
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/obj/item/natural/manabloom = 1, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing

/datum/runerituals/summoning/glimmer
	name = "summoning glimmerwing"
	desc = "summons an fae spirit"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/obj/item/natural/manabloom = 1, /obj/item/natural/fairydust = 3, /obj/item/natural/melded/t1 = 1)

	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing
/datum/runerituals/summoning/dryad
	name = "summoning dryad"
	desc = "summons an drayd"
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/obj/item/natural/manabloom = 1, /obj/item/natural/iridescentscale = 2, /obj/item/natural/melded/t2 = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing

/datum/runerituals/summoning/sylph
	name = "summoning sylph"
	desc = "summons an archfae"
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/obj/item/natural/manabloom = 1, /obj/item/natural/heartwoodcore = 1, /obj/item/natural/melded/t3 = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing

/datum/runerituals/summoning/crawler
	name = "summoning elemental crawler"
	desc = "summons a minor elemental"
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/obj/item/natural/stone = 3, /obj/item/natural/manacrystal = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing

/datum/runerituals/summoning/warden
	name = "summoning elemental warden"
	desc = "summons an elemental"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/obj/item/natural/elementalmote = 3, /obj/item/natural/manacrystal = 1, /obj/item/natural/melded/t1 = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing

/datum/runerituals/summoning/behemoth
	name = "summoning elemental behemoth"
	desc = "summons a large elemental"
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/obj/item/natural/elementalshard = 2, /obj/item/natural/manacrystal = 1, /obj/item/natural/melded/t2 =1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing

/datum/runerituals/summoning/collossus
	name = "summoning elemental collossus"
	desc = "summons an huge elemental"
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/obj/item/natural/elementalfragment = 1, /obj/item/natural/manacrystal = 1, /obj/item/natural/melded/t3 =1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat//temporary rat 4 testing