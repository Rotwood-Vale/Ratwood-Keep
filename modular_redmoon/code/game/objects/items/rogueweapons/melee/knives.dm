/obj/item/rogueweapon/huntingknife
	grid_height = 64
	grid_width = 32

/obj/item/rogueweapon/huntingknife/idagger/steel/parrying
	name = "steel parrying dagger"
	desc = "This is a parrying dagger made of solid steel, used to catch opponent's weapons in the handguard. It's a bit more dull, however."
	force = 12
	throwforce = 12
	wdefense = 6
	icon = 'modular_redmoon/icons/weapons/32.dmi'
	icon_state = "spdagger"
	item_state = "cultdagger"

/obj/item/rogueweapon/huntingknife/idagger/navaja
	possible_item_intents = list(/datum/intent/dagger/thrust,/datum/intent/dagger/cut,  /datum/intent/dagger/thrust/pick)
	name = "navaja"
	desc = "A folding Etruscan knife valued by merchants, mercenaries and peasants for its convenience. It possesses a long hilt, allowing for a sizeable blade with good reach."
	force = 5
	icon = 'modular_redmoon/icons/weapons/32.dmi'
	icon_state = "navaja_c"
	item_state = "elfdag"
	var/extended = 0
	wdefense = 2
	sellprice = 30 //shiny :o

/obj/item/rogueweapon/huntingknife/idagger/navaja/attack_self(mob/user)
	extended = !extended
	playsound(src.loc, 'sound/blank.ogg', 50, TRUE)
	if(extended)
		force = 20
		wdefense = 6
		w_class = WEIGHT_CLASS_NORMAL
		throwforce = 23
		icon_state = "navaja_o"
		attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
		sharpness = IS_SHARP
		playsound(user, 'sound/items/knife_open.ogg', 100, TRUE)
	else
		force = 5
		w_class = WEIGHT_CLASS_SMALL
		throwforce = 5
		icon_state = "navaja_c"
		attack_verb = list("stubbed", "poked")
		sharpness = IS_BLUNT
		wdefense = 2

/obj/item/rogueweapon/huntingknife/throwingknife
	name = "iron tossblade"
	desc = "Paradoxical; why is it called a blade when it is meant for tossing? Or is it the act of cutting post-toss that makes it a blade? ...Are arrows tossblades, too?"
	item_state = "bone_dagger"
	force = 10
	throwforce = 22
	throw_speed = 4
	max_integrity = 50
	wdefense = 1
	icon = 'modular_redmoon/icons/weapons/32.dmi'
	icon_state = "throw_knifei"
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 25, "embedded_fall_chance" = 10)
	possible_item_intents = list(/datum/intent/dagger/thrust, /datum/intent/dagger/chop)
	smeltresult = null
	sellprice = 1

/obj/item/rogueweapon/huntingknife/throwingknife/steel
	name = "steel tossblade"
	desc = "There are rumors of some sea-marauders loading these into metal tubes with explosive powder to launch then fast and far. Probably won't catch on."
	item_state = "bone_dagger"
	force = 10
	throwforce = 28
	throw_speed = 4
	max_integrity = 100
	wdefense = 1
	icon_state = "throw_knifes"
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 30, "embedded_fall_chance" = 5)
	smeltresult = null
	sellprice = 2

/obj/item/rogueweapon/huntingknife/throwingknife/psydon
	name = "psydonian tossblade"
	desc = "An unconventional method of delivering silver to a heretic; but one PSYDON smiles at, all the same. Doubles as an actual knife in a pinch, though obviously not as well."
	item_state = "bone_dagger"
	force = 12
	throwforce = 28
	throw_speed = 4
	max_integrity = 150
	wdefense = 3
	icon_state = "throw_knifep"
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 50, "embedded_fall_chance" = 0)
	sellprice = 6
	smeltresult = null

/obj/item/rogueweapon/huntingknife/throwingknife/psydon/Initialize()
	. = ..()
	var/datum/magic_item/mundane/silver/effect = new
	AddComponent(/datum/component/magic_item, effect)
