// TRANSMUTATION, creating inanimate stuff

/datum/ritual/zizo/corruptamulet
	name = "Corrupt Amulet"
	circle = "Transmutation"
	difficulty = 1
	favor_cost = 25
	revealchance = 5
	center_requirement = /obj/item/clothing/neck/roguetown/psicross/ //all of them, wood etc. get incinerated
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/corruptamulet

/proc/corruptamulet(mob/user, turf/C)
	var/obj/item/clothing/neck/roguetown/psicross/P = locate(/obj/item/clothing/neck/roguetown/psicross) in C
	if(!P)
		return TRUE
	if(!(P.corruptable))
		C.visible_message(span_danger("The amulet in the center of the ritual circle begins to bleed for but a moment, before a puff of black fire consumes it utterly!"))
		return TRUE
	
	new /obj/item/clothing/neck/roguetown/psicross/bloodied(C)
	C.visible_message(span_danger("The amulet in the center of the ritual circle begins to bleed from its edges as it warps into a mockery of the divine!"))
	user.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	return TRUE

/datum/ritual/zizo/allseeingeye
	name = "All-seeing Eye"
	circle = "Transmutation"
	difficulty = 2
	favor_cost = 250
	revealchance = 10
	center_requirement = /obj/item/organ/eyes

	function = /proc/allseeingeye

/proc/allseeingeye(mob/user, turf/C)
	new /obj/item/scrying/eye(C)


/datum/ritual/zizo/criminalstool
	name = "Criminal's Tool"
	circle = "Transmutation"
	difficulty = 1
	favor_cost = 20
	center_requirement = /obj/item/natural/cloth

	function = /proc/criminalstool

/obj/item/soap/cult
	name = "accursed soap"
	desc = "It is pulsating."
	uses = 9
	cleanspeed = 1

/proc/criminalstool(mob/user, turf/C)
	new /obj/item/soap/cult(C)
	to_chat(user.mind, span_notice("The Criminal's Tool. Could be useful for hiding tracks or getting rid of sigils."))

/datum/ritual/zizo/propaganda
	name = "Propaganda"
	circle = "Transmutation"
	difficulty = 1
	favor_cost = 25
	center_requirement = /obj/item/natural/worms/leech
	n_req = /obj/item/paper
	s_req = /obj/item/paper

	function = /proc/propaganda

/proc/propaganda(mob/user, turf/C)
	new /obj/item/natural/worms/leech/propaganda(C)
	to_chat(user.mind, span_notice("A leech to make their minds wrangled. They'll be in bad spirits."))

/datum/ritual/zizo/falseidol
	name = "False Idol"
	circle = "Transmutation"
	difficulty = 1
	favor_cost = 10
	center_requirement = /mob/living/carbon/human
	w_req = /obj/item/paper
	e_req = /obj/item/paper

	function = /proc/falseidol

/obj/effect/dummy/falseidol
	name = "false idol"
	icon = 'icons/effects/effects.dmi'
	icon_state = "static"
	desc = "Through lies interwine from blood into truth."

/obj/effect/dummy/falseidol/Crossed(atom/movable/AM, oldloc)
	. = ..()
	qdel(src)

/proc/falseidol(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		var/obj/effect/dummy/falseidol/idol = new(C)
		var/datum/icon_snapshot/entry = new
		entry.name = H.name
		entry.icon = H.icon
		entry.icon_state = H.icon_state
		entry.overlays = H.get_overlays_copy(list(HANDS_LAYER))	//ugh
		sleep(10)
		idol.name = entry.name
		idol.icon = entry.icon
		idol.icon_state = entry.icon_state
		idol.add_overlay(entry.overlays)
		return TRUE
	return FALSE

/datum/ritual/zizo/summonrobes
	name = "Summon Robes"
	circle = "Transmutation"
	difficulty = 1
	favor_cost = 25
	revealchance = 1
	n_req = /obj/item/natural/hide
	function = /proc/summonrobes

/proc/summonrobes(mob/user, turf/C)
	var/datum/effect_system/spark_spread/S = new(C)
	S.set_up(1, 1, C)
	S.start()

	new /obj/item/clothing/head/roguetown/helmet/leather/cult_hood(C)
	new /obj/item/clothing/suit/roguetown/armor/leather/cult_robe(C)

	playsound(C,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)


/datum/ritual/zizo/empowerrobes
	name = "Summon Robes"
	circle = "Transmutation"
	difficulty = 2
	favor_cost = 25
	revealchance = 10
	n_req = /obj/item/clothing/head/roguetown/helmet/leather/cult_hood
	s_req = /obj/item/clothing/suit/roguetown/armor/leather/cult_robe
	center_requirement = /obj/item/clothing/neck/roguetown/psicross/bloodied
	function = /proc/empowerrobes


/proc/empowerrobes(mob/user, turf/C)
	var/datum/effect_system/spark_spread/S = new(C)
	S.set_up(1, 1, C)
	S.start()
	new /obj/item/clothing/head/roguetown/helmet/leather/cult_hood/empowered(C)
	new /obj/item/clothing/suit/roguetown/armor/leather/cult_robe/empowered(C)
	playsound(C,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
