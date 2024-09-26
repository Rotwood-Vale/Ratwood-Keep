/obj/item/rogueweapon/blowRod
	force = 10
	possible_item_intents = list(/datum/intent/mace/strike)
	name = "Blowing Rod"
	desc = "A blowing rod for shaping glass."
	icon_state = "blowJobRod" // sorry not sorry
	icon = 'icons/roguetown/weapons/tools.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	associated_skill = null
	smeltresult = /obj/item/ingot/iron

/obj/item/ingot/glass
	name = "glass sheet"
	desc = "A marvelous pane of transparent glass."
	icon_state = "ingotglass" //TODO
	smeltresult = /obj/item/ingot/glass
	grind_results = list(/datum/reagent/lye = 15, /datum/reagent/ash = 15,) // Placeholder. 
	sellprice = 30 // This is probably way too much.
    /*
        I was going to add an intermediary, glass blob item that had to be shaped into a pane by a
        potter, but I figured that this would probably be too tedious, so, we are assuming that
        molten glass is poured into a mold for a sheet as soon as it leaves the kiln/furnace.
    */