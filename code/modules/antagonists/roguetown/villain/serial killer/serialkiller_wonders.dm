/datum/crafting_recipe/roguetown/structure/wonder
	name = "bloody totem (3 bodyparts, 1 head)"
	result = /obj/structure/totem
	reqs = list(
		/obj/item/bodypart = 3,
		/obj/item/bodypart/head = 1,
	)
	verbage_simple = "construct"
	verbage = "constructs"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = null
	always_available = FALSE

/obj/structure/totem
	name = "bloody totem"
	desc = "What a disgusting thing, what type of lunatic would make this!?"
	icon = 'icons/roguetown/maniac/creations.dmi'
	icon_state = "creation1"
	density = TRUE
	anchored = TRUE

/obj/structure/totem/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/structure/totem/Initialize()
	. = ..()
	playsound(src, 'sound/villain/wonder.ogg', 100, vary = FALSE)
	icon_state = "creation[rand(1, 4)]"
	START_PROCESSING(SSobj, src)

/obj/structure/totem/OnCrafted(dirin, mob/user)
	. = ..()
	user.log_message("crafted Serial Killer Totem.", LOG_GAME)

// Give visions to the person who examines the totem.
/obj/structure/totem/examine(mob/user)
	. = ..()

	if(user.stat == DEAD || isobserver(user))
		return .

	if(!ishuman(user))
		return .

	var/is_SK = user.mind?.has_antag_datum(/datum/antagonist/serial_killer)
	if(is_SK)
		return .

	mark_victim(user)

/obj/structure/totem/process()
	. = ..()
	var/list/viewers = view(7, src)
	for(var/mob/living/carbon/human/victim in viewers)
		var/is_SK = victim.mind?.has_antag_datum(/datum/antagonist/serial_killer)

		// Skip logged off players
		if(!victim.mind)
			continue

		if (victim.stat == DEAD || is_SK)
			continue

		mark_victim(victim)
		break

// Curse victim with stress and temporary visions
/obj/structure/totem/proc/mark_victim(mob/living/carbon/human/V)

	V.add_stress(/datum/stressevent/saw_wonder)
	V.add_curse(/datum/curse/zizo, TRUE)
	addtimer(CALLBACK(V, TYPE_PROC_REF(/mob/living/carbon/human, remove_curse), /datum/curse/zizo, TRUE), 5 MINUTES)
	V.emote("scream")
	V.blur_eyes(2)
	SEND_SOUND(V, 'sound/villain/seen_wonder.ogg')
	V.Paralyze(5 SECONDS)
	to_chat(V, span_userdanger("WHAT IS THAT!?"))
