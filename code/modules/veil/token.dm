GLOBAL_VAR_INIT(underworld_coins, 0)

/obj/item/veil/toll
	name = "The Toll"
	desc = "This is more than just a coin."
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "soultoken_floor"
	var/should_track = TRUE

/obj/item/veil/toll/Initialize()
	. = ..()
	if(should_track)
		GLOB.underworld_coins += 1

/obj/item/veil/toll/Destroy()
	if(should_track)
		GLOB.underworld_coins -= 1
	coin_upkeep()
	return ..()

/obj/item/veil/toll/pickup(mob/user)
	..()
	if(should_track)
		GLOB.underworld_coins -= 1
	coin_upkeep()
	icon_state = "soultoken"

/obj/item/veil/toll/dropped(mob/user)
	..()
	if(should_track)
		GLOB.underworld_coins += 1
	icon_state = "soultoken_floor"

/obj/item/veil/toll/notracking
	should_track = FALSE

/proc/coin_upkeep()
	if(GLOB.underworld_coins < 8)
		for(var/obj/effect/landmark/underworldcoin/B in GLOB.landmarks_list)
			new /obj/item/underworld/coin(B.loc)
