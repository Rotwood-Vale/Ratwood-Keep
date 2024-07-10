/obj/structure/fluff/statue/secret
	name = "...?"
	desc = "A one-armed wild-kin."
	icon = 'modular_hearthstone/icons/roguetown/misc/64x64.dmi'
	icon_state = "who"

/obj/structure/fluff/statue/secret/what/examine(mob/user)
	. = ..()
	if(!user.is_literate())
		. += "Her name escapes me."
	else
		. += "I recognize her as Jaina Half-Arm, an ancient folklore hero. She was the one to rescue the citizens of what is now the Melted Undercity during the great Breach."

/obj/structure/fluff/statue/secret/what
	name = "...?"
	desc = "A rickety wooden device."
	icon_state = "what"

/obj/structure/fluff/statue/secret/what/examine(mob/user)
	. = ..()
	if(!user.is_literate())
		. += "I have no idea what this is!"
	else
		. += "I recognize this as the ancient remains of an ancient once-drill. The rusted wrought-iron chains dangle loosely in my face."
