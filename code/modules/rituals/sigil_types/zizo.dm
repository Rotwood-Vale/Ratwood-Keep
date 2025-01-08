/obj/effect/decal/cleanable/sigil/zizo
	name = "occult sigils"
	desc = "Strange, evil runics."
	icon_state = "center"
	icon = 'icons/obj/sigils/sigils_zizo.dmi'

	rituals_type = /datum/ritual/zizo

/obj/effect/decal/cleanable/sigil/zizo/N
	icon_state = "N"

/obj/effect/decal/cleanable/sigil/zizo/NE
	icon_state = "NE"

/obj/effect/decal/cleanable/sigil/zizo/E
	icon_state = "E"

/obj/effect/decal/cleanable/sigil/zizo/SE
	icon_state = "SE"

/obj/effect/decal/cleanable/sigil/zizo/S
	icon_state = "S"

/obj/effect/decal/cleanable/sigil/zizo/SW
	icon_state = "SW"

/obj/effect/decal/cleanable/sigil/zizo/W
	icon_state = "W"

/obj/effect/decal/cleanable/sigil/zizo/NW
	icon_state = "NW"

/obj/effect/decal/cleanable/sigil/zizo/attack_hand(mob/living/user)
	if(!(iszizocultist(user) || iszizolackey(user)))
		to_chat(user, span_warning("What.. is this..."))
		return

	..()

	user.playsound_local(user, 'sound/vo/cult/tesa.ogg', 25)
	user.whisper("O'vena tesa...")
