#define BCLASS_CHISEL			"chisel"
//................	Handsaw	............... //
/obj/item/rogueweapon/handsaw
	force = 5
	possible_item_intents = list(/datum/intent/mace/strike/shovel)
	gripped_intents = null
	name = "handsaw"
	desc = "Iron tool for woodworking."
	icon_state = "handsaw"
	icon = 'icons/roguetown/items/crafting.dmi'
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	sharpness = IS_SHARP
	wdefense = 0
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	swingsound = list('sound/combat/wooshes/blunt/shovel_swing.ogg','sound/combat/wooshes/blunt/shovel_swing2.ogg')
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/maces
	max_blade_int = 50

/obj/item/rogueweapon/chisel/attackby(obj/item/W, mob/living/user, params)
	. = ..()
	if(istype(W,/obj/item/natural/stoneblock))
		playsound(get_turf(user.loc), 'sound/foley/brickdrop.ogg', 100)
		user.visible_message("<span class='info'>[user] adds a striking tool to the chisel set.</span>")
		var/obj/item/rogueweapon/chisel/tool/stoneblock/F = new(src.loc)
		user.put_in_hands(F)
		qdel(W)
		qdel(src)
		return

	else if(istype(W,/obj/item/natural/stone))
		playsound(get_turf(user.loc), 'sound/foley/brickdrop.ogg', 100)
		user.visible_message("<span class='info'>[user] adds a striking tool to the chisel set.</span>")
		var/obj/item/rogueweapon/chisel/tool/stone/F = new(src.loc)
		user.put_in_hands(F)
		qdel(W)
		qdel(src)
		return

	else if(istype(W, /obj/item/rogueweapon/hammer/claw))
		playsound(get_turf(user.loc), 'sound/foley/brickdrop.ogg', 100)
		user.visible_message("<span class='info'>[user] adds a striking tool to the chisel set.</span>")
		var/obj/item/rogueweapon/chisel/tool/hammerclaw/F = new(src.loc)
		user.put_in_hands(F)
		qdel(W)
		qdel(src)
		return

	else if(istype(W, /obj/item/rogueweapon/hammer/plain))
		playsound(get_turf(user.loc), 'sound/foley/brickdrop.ogg', 100)
		user.visible_message("<span class='info'>[user] adds a striking tool to the chisel set.</span>")
		var/obj/item/rogueweapon/chisel/tool/hammer/F = new(src.loc)
		user.put_in_hands(F)
		qdel(W)
		qdel(src)
		return

	else if(istype(W, /obj/item/rogueweapon/hammer/wood))
		playsound(get_turf(user.loc), 'sound/foley/brickdrop.ogg', 100)
		user.visible_message("<span class='info'>[user] adds a striking tool to the chisel set.</span>")
		var/obj/item/rogueweapon/chisel/tool/mallet/F = new(src.loc)
		user.put_in_hands(F)
		qdel(W)
		qdel(src)
		return



/obj/item/rogueweapon/chisel
	name = "chisel"
	desc = "Add something to strike it with before doing stonework. Like a mallet or a stone."
	icon_state = "chisel"
	icon = 'icons/roguetown/items/crafting.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	force = 10
	throwforce = 2
	possible_item_intents = list(/datum/intent/stab)
	sharpness = IS_SHARP
	dropshrink = 0.9
	w_class = WEIGHT_CLASS_SMALL
	wdefense = 0
	blade_dulling = 0
	max_integrity = 150
	slot_flags = ITEM_SLOT_HIP
	swingsound = list('sound/combat/wooshes/blunt/shovel_swing.ogg','sound/combat/wooshes/blunt/shovel_swing2.ogg')
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	associated_skill = /datum/skill/combat/maces
	max_blade_int = 50
	dropshrink = 0.9


//................	Chisel toolset	............... //
/obj/item/rogueweapon/chisel/tool
	name = "chisel set"
	desc = ""
	icon_state = "chisel"
	possible_item_intents = list(/datum/intent/hit)
	gripped_intents =  list(/datum/intent/chisel)

/obj/item/rogueweapon/chisel/tool/mallet
	icon_state = "chiselm"
	item_state = "chisel"
/obj/item/rogueweapon/chisel/tool/mallet/attack_right(mob/user)
	var/obj/item/rogueweapon/chisel/F = new(src.loc)
	var/obj/item/rogueweapon/hammer/wood/E = new(src.loc)
	user.put_in_hands(E)
	user.put_in_hands(F)
	playsound(get_turf(user.loc), 'sound/foley/brickdrop.ogg', 100)
	qdel(src)

/obj/item/rogueweapon/chisel/tool/hammer
	icon_state = "chiselh"
/obj/item/rogueweapon/chisel/tool/hammer/attack_right(mob/user)
	var/obj/item/rogueweapon/chisel/F = new(src.loc)
	var/obj/item/rogueweapon/hammer/plain/E = new(src.loc)
	user.put_in_hands(E)
	user.put_in_hands(F)
	playsound(get_turf(user.loc), 'sound/foley/brickdrop.ogg', 100)
	qdel(src)

/obj/item/rogueweapon/chisel/tool/hammerclaw
	icon_state = "chiselc"
/obj/item/rogueweapon/chisel/tool/hammerclaw/attack_right(mob/user)
	var/obj/item/rogueweapon/chisel/F = new(src.loc)
	var/obj/item/rogueweapon/hammer/claw/E = new(src.loc)
	user.put_in_hands(E)
	user.put_in_hands(F)
	playsound(get_turf(user.loc), 'sound/foley/brickdrop.ogg', 100)
	qdel(src)

/obj/item/rogueweapon/chisel/tool/stone
	icon_state = "chisels"
/obj/item/rogueweapon/chisel/tool/stone/attack_right(mob/user)
	var/obj/item/rogueweapon/chisel/F = new(src.loc)
	var/obj/item/natural/stone/E = new(src.loc)
	user.put_in_hands(E)
	user.put_in_hands(F)
	playsound(get_turf(user.loc), 'sound/foley/brickdrop.ogg', 100)
	qdel(src)

/obj/item/rogueweapon/chisel/tool/stoneblock
	icon_state = "chiselb"
/obj/item/rogueweapon/chisel/tool/stoneblock/attack_right(mob/user)
	var/obj/item/rogueweapon/chisel/F = new(src.loc)
	var/obj/item/natural/stoneblock/E = new(src.loc)
	user.put_in_hands(E)
	user.put_in_hands(F)
	playsound(get_turf(user.loc), 'sound/foley/brickdrop.ogg', 100)
	qdel(src)



/datum/intent/chisel
	name = "chisel"
	icon_state = "inchisel"
	attack_verb = list("chisels")
	hitsound = list('sound/combat/hits/pick/genpick (1).ogg', 'sound/combat/hits/pick/genpick (2).ogg')
	animname = "strike"
	item_d_type = "stab"
	blade_class = BCLASS_CHISEL
	chargetime = 0
	swingdelay = 3
