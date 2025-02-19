/obj/item/storage/magebag
	name = "summoners pouch"
	desc = "A pouch for carrying handfuls of summoning ingredients."
	icon_state = "summoning"
	item_state = "summoning"
	icon = 'icons/roguetown/clothing/mage.dmi'
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
	STR.max_combined_w_class = 42
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
		/obj/item/reagent_containers/food/snacks/grown/rogue/manabloom,
		/obj/item/natural/manacrystal,
		/obj/item/natural/artifact
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
	new /obj/item/reagent_containers/food/snacks/grown/rogue/manabloom(src)
	new /obj/item/reagent_containers/food/snacks/grown/rogue/manabloom(src)
	new /obj/item/reagent_containers/food/snacks/grown/rogue/manabloom(src)



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
	playsound(loc, 'sound/misc/chalkdraw.ogg', 100, TRUE)
	if(do_after(user, crafttime, target = src))
		user.visible_message(span_warning("[user] carves an arcyne rune with [user.p_their()] [src]!"), \
		span_notice("I finish dragging the blade in symbols and circles, leaving behind an ritual rune"))
		src.amount --
		new rune_to_scribe(Turf)
	if(amount == 0)
		qdel(src)

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
	var/obj/effect/decal/cleanable/roguerune/rune_to_scribe = null
	var/chosen_keyword

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
	if(initial(rune_to_scribe.req_keyword))
		chosen_keyword = stripped_input(user, "Keyword for the new rune", "Ratwood", max_length = MAX_NAME_LEN)
		if(!chosen_keyword)
			return FALSE
	var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))

	user.visible_message(span_notice("I start drag the blade in the shape of symbols and sigils"))
	playsound(loc, 'sound/magic/bladescrape.ogg', 100, TRUE)
	if(do_after(user, crafttime, target = src))
		user.visible_message(span_warning("[user] carves an arcyne rune with [user.p_their()] [src]!"), \
		span_notice("I finish dragging the blade in symbols and circles, leaving behind an ritual rune"))
		new rune_to_scribe(Turf, chosen_keyword)

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



/obj/item/roguegem/amethyst
	name = "amythortz"
	icon_state = "amethyst"
	sellprice = 18
	arcyne_potency = 25
	desc = "A deep lavender crystal, it surges with magical energy, yet it's artificial nature means it' worth little."



/obj/item/mimictrinket
	name = "mimic trinket"
	desc = "A small mimic, imbued with the arcane to make it docile. It can transform into most things it touchs. "
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "mimic_trinket"
	possible_item_intents = list(/datum/intent/use)
	var/duration = 10 MINUTES
	var/oldicon
	var/oldicon_state
	var/olddesc
	var/oldname
	var/ready = TRUE
	var/timing_id

/obj/item/mimictrinket/attack_self(mob/living/carbon/human/user)
	revert()
/obj/item/mimictrinket/proc/revert()
	icon = oldicon
	icon_state = oldicon_state
	name = oldname
	desc = olddesc
	ready = TRUE
	if(timing_id)
		deltimer(timing_id)
		timing_id = null

/obj/item/mimictrinket/attack_obj(obj/target, mob/living/user)
	if(ready)
		to_chat(user,span_notice("[src] takes the form of [target]!"))
		oldicon = icon
		oldicon_state = icon_state
		olddesc = desc
		oldname = name
		icon = target.icon
		icon_state = target.icon_state
		name = target.name
		desc = target.desc
		ready = FALSE
		timing_id = addtimer(CALLBACK(src, PROC_REF(revert), user), duration,TIMER_STOPPABLE) // Minus two so we play the sound and decap faster


/obj/item/hourglass/temporal
	name = "temporal hourglass"
	desc = "An arcane infused hourglass that glows with magick."
	icon = 'icons/obj/hourglass.dmi'
	icon_state = "hourglass_idle"
	var/turf/target
	var/mob/living/victim

/obj/item/hourglass/temporal/toggle(mob/user)
	if(!timing_id)
		to_chat(user,span_notice("I flip the [src]."))
		start()
		flick("hourglass_flip",src)
		target = get_turf(src)
		victim = user
	else
		to_chat(user,span_notice("I stop the [src].")) //Sand magically flows back because that's more convinient to use.
		stop()

obj/item/hourglass/temporal/stop()
	..()
	do_teleport(victim, target, channel = TELEPORT_CHANNEL_QUANTUM)

/obj/item/natural/feather/infernal
	name = "infernal feather"
	icon_state = "hellfeather"
	possible_item_intents = list(/datum/intent/use)
	desc = "A fluffy feather."

/obj/item/flashlight/flare/torch/lantern/voidlamptern
	name = "void lamptern"
	icon_state = "voidlamp"
	item_state = "voidlamp"
	desc = "An old lamptern that seems darker and darker the longer you look at it."
	light_range = 8
	light_color = "#000000"
	light_power = -3
	on = FALSE

/obj/item/clothing/ring/active/shimmeringlens
	name = "shimmering lens"
	desc = "A radiantly shimmering glass of lens that shimmers with magick. Looking through it gives you a bit of a headache."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "lens"
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF | ACID_PROOF
	cdtime = 10 MINUTES
	activetime = 30 SECONDS

/obj/item/clothing/ring/arcanesigil
	name = "arcane sigil"
	desc = "A radiantly shimmering sigil within an amulet, It seems to pulse with intense arcanic flows."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "amulet"
	var/cdtime = 30 MINUTES
	var/ready = TRUE

/obj/item/clothing/ring/arcanesigil/attack_self(mob/living/carbon/human/user)
	if(ready)
		message_admins("ready")
		if(do_after(user, 25, target = src))
			to_chat(user,span_notice("[src] heats up to an almost burning temperature, flooding you with overwhelming arcane knowledge!"))
			ready = FALSE
			addtimer(CALLBACK(src, PROC_REF(revert), user), cdtime,TIMER_STOPPABLE) // Minus two so we play the sound and decap faster
			user.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
	else
		to_chat(user,span_notice("[src] remains inert. It must be gathering arcana!"))

/obj/item/clothing/ring/arcanesigil/proc/revert()
	ready = TRUE

/obj/item/clothing/ring/active/shimmeringlens/attack_right(mob/user)
	if(loc != user)
		return
	if(cooldowny)
		if(world.time < cooldowny + cdtime)
			to_chat(user, span_warning("Nothing happens."))
			return
	user.visible_message(span_warning("[user] looks through the [src]!"))
	if(activate_sound)
		playsound(user, activate_sound, 100, FALSE, -1)
	cooldowny = world.time
	addtimer(CALLBACK(src, PROC_REF(demagicify)), activetime)
	active = TRUE
	activate(user)

/obj/item/clothing/ring/active/shimmeringlens/activate(mob/user)
	ADD_TRAIT(user, TRAIT_XRAY_VISION, "[type]")

/obj/item/clothing/ring/active/shimmeringlens/demagicify()
	var/mob/living/user = usr
	REMOVE_TRAIT(user,TRAIT_XRAY_VISION, "[type]")
	active = FALSE

/obj/item/sendingstonesummoner/Initialize()
	var/mob/living/user = usr
	var/obj/item/natural/stone/sending/item1 = new /obj/item/natural/stone/sending
	var/obj/item/natural/stone/sending/item2 = new /obj/item/natural/stone/sending
	item1.paired_with = item2
	item2.paired_with = item1
	item1.icon_state = "whet"
	item2.icon_state = "whet"
	item1.color = "#d8aeff"
	item2.color = "#d8aeff"
	user.put_in_hands(item1, FALSE)
	user.put_in_hands(item2, FALSE)
	qdel(src)

/obj/item/natural/stone/sending
	name = "sending stone"
	desc = "One of a pair of sending stones."
	var/obj/item/natural/stone/sending/paired_with

/obj/item/natural/stone/sending/attack_self(mob/user)
	var/input_text = input(user, "Enter your message:", "Message")
	if(input_text)
		paired_with.say(input_text)

/obj/item/clothing/neck/roguetown/collar/leather/nomagic
	name = "mana-binding collar"
	desc = "A comfortable collar made of leather. studded with red gems"
	icon_state = "manabindingcollar"
	color = null
	slot_flags = ITEM_SLOT_NECK
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured
	unequip_delay_self = 1200

/obj/item/clothing/neck/roguetown/collar/leather/nomagic/Initialize(mapload)
	. = ..()
	var/datum/magic_item/mundane/nomagic/effect = new
	AddComponent(/datum/component/magic_item, effect)

/obj/item/clothing/gloves/roguetown/nomagic
	icon = 'icons/roguetown/clothing/mage.dmi'
	icon_state = "manabindinggloves"
	bloody_icon_state = "bloodyhands"
	name = "gem encrusted mana binding gloves"
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_SMALL
	allow_self_unequip = FALSE	//Can not remove these without help
	equip_delay_self = 60
	equip_delay_other = 60
	strip_delay = 300

/obj/item/clothing/gloves/roguetown/nomagic/Initialize(mapload)
	. = ..()
	var/datum/magic_item/mundane/nomagic/effect = new
	AddComponent(/datum/component/magic_item, effect)

/obj/item/rope/chain/bindingshackles
	name = "planar binding shackles"
	desc = "arcane shackles imbued to bind other-planar creatures intelligence to this plane. They will not be under your thrall and a deal will need to be made."
	var/mob/living/fam
	var/tier = 1
	var/being_used = FALSE
	var/sentience_type = SENTIENCE_ORGANIC

/obj/item/rope/chain/bindingshackles/Initialize()
	.=..()
	src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))

/obj/item/rope/chain/bindingshackles/attackby(obj/item/P, mob/living/carbon/human/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/natural/melded/t2))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(loc, 'sound/items/book_close.ogg', 100, TRUE)
				to_chat(user, span_notice("I mold the [P] into the [src] with my arcyne power."))
				new /obj/item/rope/chain/bindingshackles/t2(loc)
				qdel(P)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put the [src] on a table to work on it.</span>")
	else
		return ..()
/obj/item/rope/chain/bindingshackles/t2
	name = "greater planar binding shackles"
	tier = 2

/obj/item/rope/chain/bindingshackles/t2/attackby(obj/item/P, mob/living/carbon/human/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/natural/melded/t3))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(loc, 'sound/items/book_close.ogg', 100, TRUE)
				to_chat(user, span_notice("I mold the [P] into the [src] with my arcyne power."))
				new /obj/item/rope/chain/bindingshackles/t3(loc)
				qdel(P)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put the [src] on a table to work on it.</span>")
	else
		return ..()
/obj/item/rope/chain/bindingshackles/t3
	name = "woven planar binding shackles"
	tier = 3

/obj/item/rope/chain/bindingshackles/t3/attackby(obj/item/P, mob/living/carbon/human/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/natural/melded/t4))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(loc, 'sound/items/book_close.ogg', 100, TRUE)
				to_chat(user, span_notice("I mold the [P] into the [src] with my arcyne power."))
				new /obj/item/rope/chain/bindingshackles/t4(loc)
				qdel(P)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put the [src] on a table to work on it.</span>")
	else
		return ..()
/obj/item/rope/chain/bindingshackles/t4
	name = "confluent planar binding shackles"
	tier = 4

/obj/item/rope/chain/bindingshackles/t4/attackby(obj/item/P, mob/living/carbon/human/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/natural/melded/t5))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(loc, 'sound/items/book_close.ogg', 100, TRUE)
				to_chat(user, span_notice("I mold the [P] into the [src] with my arcyne power."))
				new /obj/item/rope/chain/bindingshackles/t5(loc)
				qdel(P)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put the [src] on a table to work on it.</span>")
	else
		return ..()

/obj/item/rope/chain/bindingshackles/t5
	name = "abberant planar binding shackles"
	tier = 5

/obj/item/rope/chain/bindingshackles/attack(mob/living/simple_animal/hostile/retaliate/rogue/captive, mob/living/user)
	var/list/summon_types = list(
		/mob/living/simple_animal/hostile/retaliate/rogue/infernal/imp,
		/mob/living/simple_animal/hostile/retaliate/rogue/infernal/hellhound,
		/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher,
		/mob/living/simple_animal/hostile/retaliate/rogue/infernal/fiend,
		/mob/living/simple_animal/hostile/retaliate/rogue/elemental/crawler,
		/mob/living/simple_animal/hostile/retaliate/rogue/elemental/warden,
		/mob/living/simple_animal/hostile/retaliate/rogue/elemental/behemoth,
		/mob/living/simple_animal/hostile/retaliate/rogue/elemental/collossus,
		/mob/living/simple_animal/hostile/retaliate/rogue/fae/sprite,
		/mob/living/simple_animal/hostile/retaliate/rogue/fae/glimmerwing,
		/mob/living/simple_animal/hostile/retaliate/rogue/fae/dryad,
		/mob/living/simple_animal/hostile/retaliate/rogue/fae/sylph,
		/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk,
		/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon)

	if(!(captive.type in summon_types))
		to_chat(user, span_warning("[captive] cannot be bound by these shackles!"))
		return
	if(captive.tier > tier)
		to_chat(user, span_warning("[src] is not strong enough to bind [captive]!"))
		return

	var/mob/living/simple_animal/hostile/retaliate/rogue/target = captive
	target.visible_message(span_warning("[target.real_name]'s body is entangled by glowing chains..."), runechat_message = TRUE)

	if(!target.ckey) //player is not inside body or has refused, poll for candidates

		var/list/candidates = pollCandidatesForMob("Do you want to play as a Mage's summon?", null, null, null, 100, target, POLL_IGNORE_MAGE_SUMMON)

		// theres at least one candidate
		if(LAZYLEN(candidates))
			var/mob/C = pick(candidates)
			target.awaken_summon(user, C.ckey)
			target.visible_message(span_warning("[target.real_name]'s eyes light up with an intelligence as it awakens fully on this plane."), runechat_message = TRUE)
			custom_name(user,target)

		//no candidates, raise as npc
		else
			to_chat(user, span_notice("The [captive] stares at you with mindless hate. The binding attempt failed to draw out it's intelligence!"))

		return FALSE
	return FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/proc/awaken_summon(mob/living/carbon/human/master, ckey)
	if(!master)
		return FALSE
	if(ckey) //player
		src.ckey = ckey

	to_chat(src, span_userdanger("My summoner is [master.real_name]. They will need to convince me to obey them."))
	to_chat(src, span_warning("[summon_primer]"))



/obj/item/rope/chain/bindingshackles/proc/custom_name(mob/awakener, var/mob/chosen_one, iteration = 1)
	if(iteration > 5)
		return  // The spirit of indecision
	var/chosen_name = sanitize_name(stripped_input(chosen_one, "What are you named?"))
	if(!chosen_name) // with the way that sanitize_name works, it'll actually send the error message to the awakener as well.
		to_chat(awakener, span_warning("Your weapon did not select a valid name! Please wait as they try again.")) // more verbose than what sanitize_name might pass in it's error message
		return custom_name(awakener, iteration++)
	return chosen_name

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
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "leyline"
	desc = "A shard of a fractured leyline, it glows with lost power."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/grown/rogue/manabloom
	seed = /obj/item/seeds/manabloom
	name = "mana bloom"
	desc = "Glowing blue flower that seems to attract latent mana."
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "manabloom"
//	filling_color = "#008000"
	bitesize_mod = 1
	foodtype = VEGETABLES
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("sweet" = 1,"bitterness" = 1)
	eat_effect = /datum/status_effect/debuff/badmeal
	rotprocess = 60 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/seeds/manabloom
	seed_identity = "manabloom seeds"
	plant_def_type = /datum/plant_def/manabloom

/datum/plant_def/manabloom
	name = "manabloom"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "manabloom"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/rogue/manabloom

/obj/item/natural/artifact
	name = "runed artifact"
	icon_state = "runedartifact"
	desc = "an old stone from age long ago, marked with glowing sigils."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/natural/artifact/Initialize()
	.=..()
	var/list/listy = list("runedartifact", "runedartifact1")
	var/newicon = pick(listy)
	icon_state = newicon

/obj/item/natural/manacrystal
	name = "crystalized mana"
	icon_state = "manacrystal"
	desc = "A crystal made of mana, woven into an artifical structure."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/natural/voidstone
	name = "Voidstone"
	icon_state = "voidstone"
	desc = "A piece of blackstone, it feels disconcerting to stare at it for long."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL

//combined items
/obj/item/natural/melded
	name = "arcane meld"
	icon_state = "wessence"
	icon = 'icons/roguetown/items/natural.dmi'
	desc = "You should not be seeing this"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	sellprice = 20

/obj/item/natural/melded/t1
	name = "arcanic meld"
	icon_state = "meld"
	desc = "A melding of infernal ash, fairy dust and elemental mote."

/obj/item/natural/melded/t2
	name = "dense arcanic meld"
	icon_state = "dmeld"
	desc = "A melding of hellhound fang, iridescent scales and elemental shard."

/obj/item/natural/melded/t3
	name = "sorcerous weave"
	icon_state = "weave"
	desc = "A melding of molten core, heartwood core and elemental fragment."

/obj/item/natural/melded/t4
	name = "magical confluence"
	icon_state = "confluence"
	desc = "A melding of abyssal flame, sylvan essence and elemental relic."

/obj/item/natural/melded/t5
	name = "arcanic aberration"
	icon_state = "abberant"
	desc = "A melding of arcane fusion and voidstone. It pulses erratically, power coiled tightly within and dangerous. Many would be afraid of going near this, let alone holding it."