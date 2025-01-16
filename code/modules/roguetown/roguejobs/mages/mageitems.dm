/obj/item/storage/magebag
	name = "summoners pouch"
	desc = "A pouch for carrying handfuls of summoning ingredients."
	icon_state = "summoning"
	item_state = "summoning"
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	resistance_flags = NONE
	max_integrity = 300

/obj/item/storage/magebag/examine(mob/user)
	. = ..()
	if(contents.len)
		. += span_notice("[contents.len] thing[contents.len > 1 ? "s" : ""] in the pouch.")

/obj/item/storage/magebag/attack_right(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/list/things = STR.contents()
	if(things.len)
		var/obj/item/I = pick(things)
		STR.remove_from_storage(I, get_turf(user))
		user.put_in_hands(I)

/obj/item/storage/magebag/update_icon()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/list/things = STR.contents()
	if(things.len)
		icon_state = "summoning"
		w_class = WEIGHT_CLASS_NORMAL
	else
		icon_state = "summoning"
		w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/magebag/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 20
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_items = 20
	STR.set_holdable(list(
		/obj/item/natural/infernalash,
		/obj/item/natural/hellhoundfang,
		/obj/item/natural/moltencore,
		/obj/item/natural/abyssalflame,
		/obj/item/natural/fairydust,
		/obj/item/natural/iridescentscale,
		/obj/item/natural/heartwoodcore,
		/obj/item/natural/sylvanessence,
		/obj/item/natural/elementalmote,
		/obj/item/natural/elementalshard,
		/obj/item/natural/elementalfragment,
		/obj/item/natural/elementalrelic,
		/obj/item/natural/obsidian,
		/obj/item/natural/leyline,
		/obj/item/natural/manabloom,
		/obj/item/natural/manacrystal
		))
	STR.click_gather = TRUE
	STR.attack_hand_interact = TRUE
	STR.collection_mode = COLLECT_EVERYTHING
	STR.dump_time = 0
	STR.allow_quick_gather = TRUE
	STR.allow_quick_empty = TRUE
	STR.allow_look_inside = TRUE
	STR.allow_dump_out = FALSE
	STR.display_numerical_stacking = TRUE

/obj/item/storage/magebag/apprentice/PopulateContents()
	new /obj/item/natural/infernalash(src)
	new /obj/item/natural/fairydust(src)
	new /obj/item/natural/elementalmote(src)
	new /obj/item/natural/manacrystal(src)
	new /obj/item/natural/manacrystal(src)
	new /obj/item/natural/manacrystal(src)
	new /obj/item/natural/obsidian(src)
	new /obj/item/natural/obsidian(src)
	new /obj/item/natural/obsidian(src)
	new /obj/item/natural/manabloom(src)
	new /obj/item/natural/manabloom(src)
	new /obj/item/natural/manabloom(src)



/obj/item/chalk
	name = "stick of chalk"
	desc = "A stark-white stick of chalk, possibly made from quicksilver. "
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "chalk"
	throw_speed = 2
	throw_range = 5
	throwforce = 5
	damtype = BRUTE
	force = 1
	w_class = WEIGHT_CLASS_SMALL
	var/rune_to_scribe = null
	var/amount = 8
/obj/item/chalk/examine(mob/user)
	. = ..()
	desc += "It has [amount] uses left."

/obj/item/chalk/attackby(obj/item/M, mob/user, params)
	if(istype(M,/obj/item/rogueore/cinnabar))
		if(amount < 8)
			amount = 8
			to_chat(user, span_notice("I press acryne magic into the [M] and the red crystals within melt into quicksilver, quickly sinking into the [src]."))
	else
		return ..()


/obj/item/chalk/attack_self(mob/living/carbon/human/user)
	if(!isarcyne(user))//We'll set up other items for other types of rune rituals
		to_chat(user, span_cult("Nothing comes in mind to draw with the chalk."))
		return
	var/datum/ritual/pickrune
	var/runenameinput = input(user, "Runes", "Tier 1&2 Runes") as null|anything in GLOB.t2rune_types
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
	playsound(loc, 'sound/magic/bladescrape.ogg', 100, TRUE)
	if(do_after(user, crafttime, target = src))
		user.visible_message(span_warning("[user] carves an arcyne rune with [user.p_their()] [src]!"), \
		span_notice("I finish dragging the blade in symbols and circles, leaving behind an ritual rune"))
		src.amount --
		new rune_to_scribe(Turf)

/obj/item/chalk/proc/check_for_structures_and_closed_turfs(loc, var/obj/effect/decal/cleanable/roguerune/rune_to_scribe)
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


/obj/item/rogueweapon/huntingknife/idagger/silver/arcyne
	name = "glowing purple silver dagger"
	desc = "This dagger glows a faint purple. Quicksilver runs across its blade."
	var/is_bled = FALSE
	var/rune_to_scribe = null

/obj/item/rogueweapon/huntingknife/idagger/silver/arcyne/Initialize()
	. = ..()
	filter(type="drop_shadow", x=0, y=0, size=2, offset=1, color=rgb(128, 0, 128, 1))

/obj/item/rogueweapon/huntingknife/idagger/silver/attackby(obj/item/M, mob/user, params)
	if(istype(M,/obj/item/rogueore/cinnabar))
		var/crafttime = (60 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
		if(do_after(user, crafttime, target = src))
			playsound(loc, 'sound/magic/scrapeblade.ogg', 100, TRUE)
			to_chat(user, span_notice("I press acryne magic into the blade and it throbs in a deep purple..."))
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
	var/runenameinput = input(user, "Runes", "RATWOOD") as null|anything in GLOB.t4rune_types
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


//adapted from forcefields.dm, this needs to be destructible
/obj/structure/arcyne_wall
	desc = "A wall of pure arcyne force."
	name = "Arcyne Wall"
	icon = 'icons/effects/effects.dmi'
	icon_state = "forcefield"
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	opacity = 0
	density = TRUE
	max_integrity = 200
	CanAtmosPass = ATMOS_PASS_DENSITY
	climbable = TRUE
	climb_time = 0

/obj/structure/arcyne_wall/Initialize()
	. = ..()

/obj/structure/arcyne_wall/caster
	var/mob/caster

/obj/structure/arcyne_wall/caster/Initialize(mapload, mob/summoner)
	. = ..()
	caster = summoner

/obj/structure/arcyne_wall/caster/CanPass(atom/movable/mover, turf/target)	//only the caster can move through this freely
	if(mover == caster)
		return TRUE
	if(ismob(mover))
		var/mob/M = mover
		if(M.anti_magic_check(chargecost = 0) || structureclimber == M)
			return TRUE
	return FALSE

/obj/structure/arcyne_wall/greater
	desc = "An immensely strong wall of pure arcyne force."
	name = "Greater Arcyne Wall"
	icon = 'icons/effects/effects.dmi'
	icon_state = "forcefield"
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	max_integrity = 1100
	CanAtmosPass = ATMOS_PASS_DENSITY
	climbable = TRUE
	climb_time = 0

/obj/structure/arcyne_wall/greater/caster
	var/mob/caster

/obj/structure/arcyne_wall/greater/caster/Initialize(mapload, mob/summoner)
	. = ..()
	caster = summoner

/obj/structure/arcyne_wall/greater/caster/CanPass(atom/movable/mover, turf/target)	//only the caster can move through this freely
	if(mover == caster)
		return TRUE
	if(ismob(mover))
		var/mob/M = mover
		if(M.anti_magic_check(chargecost = 0) || structureclimber == M)
			return TRUE
	return FALSE

////////////////////////////////////////Magic resources go below here////////////////////


//mapfetchable items
/obj/item/natural/obsidian
	name = "obsidian fragment"
	icon = 'icons/obj/shards.dmi'
	icon_state = "obsidian"
	desc = "Volcanic glass cooled from molten lava rapidly."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/natural/leyline
	name = "leyline shards"
	icon = 'icons/obj/shards.dmi'
	icon_state = "leyline"
	desc = "Volcanic glass cooled from molten lava rapidly."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/natural/manabloom
	name = "mana bloom"
	icon_state = "wessence"
	desc = "Volcanic glass cooled from molten lava rapidly."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/natural/artifacts
	name = "runed artifacts"
	icon_state = "wessence"
	desc = "Volcanic glass cooled from molten lava rapidly."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/natural/manacrystal
	name = "crytalized mana"
	icon_state = "wessence"
	desc = "Volcanic glass cooled from molten lava rapidly."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL

//combined items
/obj/item/natural/melded
	name = "arcane meld"
	icon_state = "wessence"
	desc = "You should not be seeing this"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	sellprice = 20

/obj/item/natural/melded/t1
	name = "arcanic meld"
	icon = 'icons/obj/objects.dmi'
	icon_state = "meld"
	desc = "A melding of infernal ash, fairy dust and elemental mote."

/obj/item/natural/melded/t2
	name = "dense arcanic meld"
	icon = 'icons/obj/objects.dmi'
	icon_state = "dmeld"
	desc = "A melding of hellhound fang, iridescent scales and elemental shard."

/obj/item/natural/melded/t3
	name = "sorcerous weave"
	icon = 'icons/obj/objects.dmi'
	icon_state = "wessence"
	desc = "A melding of molten core, heartwood core and elemental fragment."

/obj/item/natural/melded/t4
	name = "magical confluence"
	icon = 'icons/obj/objects.dmi'
	icon_state = "wessence"
	desc = "A melding of abyssal flame, sylvan essence and elemental relic."

/obj/item/natural/melded/t5
	name = "arcanic aberation"
	icon_state = "wessence"
	desc = "A melding of arcane fusion and voidstone. It pulses erratically, power coiled tightly within and dangerous. Many would be afraid of going near this, let alone holding it."