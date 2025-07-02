/obj/item/rogueweapon/pick
	force = 21
	possible_item_intents = list(/datum/intent/pick)
	name = "iron pick"
	desc = "This tool is essential to mine in the dark depths."
	icon_state = "pick"
	item_state = "pick"
	icon = 'icons/roguetown/weapons/tools.dmi'
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	experimental_onback = FALSE
	sharpness = IS_BLUNT
	wlength = 10
	max_integrity = 400
	slot_flags = ITEM_SLOT_HIP
	toolspeed = 1
	associated_skill = /datum/skill/combat/maces
	smeltresult = /obj/item/ingot/iron
	w_class = WEIGHT_CLASS_BULKY

/obj/item/rogueweapon/pick/steel
	name = "steel pick"
	desc = "With a reinforced handle and sturdy shaft, this is a superior tool for delving in the darkness."
	force_wielded = 28
	icon_state = "steelpick"
	item_state = "steelpick"
	possible_item_intents = list(/datum/intent/pick)
	gripped_intents = list(/datum/intent/pick)
	max_integrity = 600
	smeltresult = /obj/item/ingot/steel
/obj/item/rogueweapon/pick/steel/New()
	. = ..()
	icon_state = "steelpick[rand(1,2)]"

/obj/item/rogueweapon/pick/blacksteel
	name = "blacksteel pick"
	desc = "Glimmering with silver-y black, this is a pretigious tool for miners delving in the darkness."
	force_wielded = 28
	icon_state = "blacksteelpick"
	item_state = "blacksteelpick"
	possible_item_intents = list(/datum/intent/pick)
	gripped_intents = list(/datum/intent/pick)
	max_integrity = 800
	smeltresult = /obj/item/ingot/blacksteel

/obj/item/rogueweapon/pick/blacksteel/New()
	. = ..()
	icon_state = "blacksteelpick[rand(1,2)]"

/obj/item/rogueweapon/pick/drill
	name = "clockwork drill"
	desc = "A wonderfully complex work of engineering capable of shredding walls in seconds as opposed to hours."
	force_wielded = 30
	icon_state = "drill"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	item_state = "drill"
	possible_item_intents = list(/datum/intent/mace/smash)
	gripped_intents = list(/datum/intent/drill)
	slot_flags = ITEM_SLOT_BACK
	gripspriteonmob = TRUE
	var/datum/looping_sound/drill/drill_loop

/obj/item/rogueweapon/pick/drill/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

	drill_loop = new(src, FALSE)

/obj/item/rogueweapon/pick/drill/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/rogueweapon/pick/drill/process()
	update_sound()

/obj/item/rogueweapon/pick/drill/proc/update_sound()
	var/datum/looping_sound/drill/loop = drill_loop
	if(!wielded)
		loop.stop()
		return
	loop.start()
