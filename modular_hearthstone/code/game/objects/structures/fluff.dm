/obj/structure/fluff/statue/secret
	name = "...?"
	desc = "A one-armed wild-kin."
	icon = 'modular_hearthstone/icons/roguetown/misc/64x64.dmi'
	icon_state = "who"
	layer = 3

/obj/structure/fluff/statue/secret/examine(mob/user)
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
		. += "I recognize this as the remains of an ancient once-gate. The rusted wrought-iron chains dangle loosely in my face. The Breach happened here."

/obj/structure/fluff/statue/secret/why
	name = "...?"
	desc = ""
	icon_state = "why" //literal codersprite. todo: this is bad

/obj/structure/fluff/statue/secret/why/examine(mob/user)
	. = ..()
	if(!user.is_literate())
		. += "Foul liquid in a glass cask."
	else
		. += "Expired and dried True Draught. The stuff that the foul creatyres which came through the Breach bled. Mimickry of their life-stuff is what makes up the red and blue elixirs I quaff. Holdable only by crystal and blacksteel."
