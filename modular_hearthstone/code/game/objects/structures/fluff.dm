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

/obj/structure/fluff/statue/what
	name = "...?"
	desc = "A rickety wooden device."
	icon = 'modular_hearthstone/icons/roguetown/misc/64x64.dmi'
	icon_state = "what"
	layer = 3

/obj/structure/fluff/statue/what/examine(mob/user)
	. = ..()
	if(!user.is_literate())
		. += "I have no idea what this is!"
	else
		. += "I recognize this as the remains of an ancient once-gate. The rusted wrought-iron chains dangle loosely in my face. The Breach happened here."

/obj/structure/fluff/statue/why
	name = "...?"
	desc = ""
	icon = 'modular_hearthstone/icons/roguetown/misc/64x64.dmi'
	icon_state = "why"
	layer = 3

/obj/structure/fluff/statue/why/examine(mob/user)
	. = ..()
	if(!user.is_literate())
		. += "Foul liquid in a glass cask."
	else
		. += "Expired and dried True Draught. The stuff that the foul creatyres which came through the Breach bled. Mimickry of their life-stuff is what makes up the red and blue elixirs I quaff. Holdable only by crystal and blacksteel."

/obj/structure/fluff/statue/who
	name = "shattered metal"
	desc = ""
	icon = 'icons/obj/clockwork_objects.dmi'
	icon_state = "clockgolem_dead"
	layer = 3
	color = "#545454"

/obj/structure/fluff/statue/who/examine(mob/user)
	. = ..()
	if(!user.is_literate())
		. += "Shattered metal."
	else
		. += "One of the ancient servitude-golems that roamed the Melted Untercity before the Breach. Few yet stand, and those that do are universally murderous."

/obj/structure/fluff/statue/answer
	name = "BIRTH-GIVER"
	desc = ""
	icon = 'modular_hearthstone/icons/roguetown/misc/64x64.dmi'
	icon_state = "answer" //TODO: THIS IS A REALLY BAD SPRITE
	color = "#545454"
	layer = 3

/obj/structure/fluff/statue/answer/examine(mob/user)
	. = ..()
	if(!user.is_literate())
		. += "My head hurts."
	else
		. += "A plucked gaze at a furthest distance; the eye of God-Things. Psydon died in this cradle, torn apart by hubris and split into his children."