/obj/effect/decal/cleanable/sigil/divine
	name = "divine sigils"
	desc = "Holy sigils drawn by the followers of the Successors."
	icon_state = "center"
	icon = 'icons/obj/sigils/sigils_divine.dmi' //PLACEHOLDER

	rituals_type = /datum/ritual/divine

/obj/effect/decal/cleanable/sigil/divine/N
	icon_state = "N"

/obj/effect/decal/cleanable/sigil/divine/NE
	icon_state = "NE"

/obj/effect/decal/cleanable/sigil/divine/E
	icon_state = "E"

/obj/effect/decal/cleanable/sigil/divine/SE
	icon_state = "SE"

/obj/effect/decal/cleanable/sigil/divine/S
	icon_state = "S"

/obj/effect/decal/cleanable/sigil/divine/SW
	icon_state = "SW"

/obj/effect/decal/cleanable/sigil/divine/W
	icon_state = "W"

/obj/effect/decal/cleanable/sigil/divine/NW
	icon_state = "NW"


/obj/effect/decal/cleanable/sigil/divine/attack_hand(mob/living/user)
	. = ..()
	if(.)
		user.playsound_local(user, 'sound/misc/vampirespell.ogg', 100)
