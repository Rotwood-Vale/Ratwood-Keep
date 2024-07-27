// Global multiplier for sell prices
var/global/real_price_multiplier = 1

// Updates the real price multiplier and item prices
/proc/update_real_price_multiplier()
    // Set a new random multiplier between 0.40 and 1.60
    global.real_price_multiplier = rand(40, 160) / 100.0

    // Ensure that the item list is processed correctly
    var/items_updated = 0

    // Loop through all items in the world
    for (var/obj/item/I in world)
        // Only update items that have a sellprice
        if (I.sellprice)
            // If this item doesn't have the original price recorded yet, do it now
            if (!I.vars["original_real_price"])
                I.vars["original_real_price"] = I.sellprice

            // Update the sellprice based on the multiplier
            I.sellprice = I.vars["original_real_price"] * global.real_price_multiplier
            items_updated++

    // Notify admins about the update
    if (items_updated > 0)
        message_admins("Real prices have been randomized. Multiplier: [global.real_price_multiplier]")
    else
        message_admins("No items with sell prices found to update.")

/world/New()
    ..()
    // Ensure prices are updated when the world starts
    update_real_price_multiplier()

/client/verb/update_prices()
    set name = "Update Item Prices"
    set category = "Debug"
    // Update prices when this verb is used
    update_real_price_multiplier()
    to_chat(usr, "Prices updated. Check admin log for details.")

/obj/item
    var/original_real_price

    // Initialize method to record the original price
    /obj/item/Initialize()
        ..()
        if (sellprice)
            original_real_price = sellprice

// Define roguegem items and their specific price updates
/obj/item/roguegem
    name = "rontz"
    icon_state = "ruby_cut"
    icon = 'icons/roguetown/items/gems.dmi'
    desc = "Its facets shine so brightly.."
    lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
    righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
    w_class = WEIGHT_CLASS_TINY
    slot_flags = ITEM_SLOT_MOUTH
    dropshrink = 0.4
    drop_sound = 'sound/items/gem.ogg'
    sellprice = 100
    static_price = FALSE

/obj/item/roguegem/Initialize()
    ..()
    if (sellprice)
        original_real_price = sellprice

// Specific roguegem types
/obj/item/roguegem/green
    name = "gemerald"
    icon_state = "emerald_cut"
    sellprice = 42
    desc = "Glints with verdant brilliance."

/obj/item/roguegem/blue
    name = "blortz"
    icon_state = "quartz_cut"
    sellprice = 88
    desc = "Pale blue, like a frozen tear."

/obj/item/roguegem/yellow
    name = "toper"
    icon_state = "topaz_cut"
    sellprice = 34
    desc = "Its amber hues remind you of the sunset."

/obj/item/roguegem/violet
    name = "saffira"
    icon_state = "sapphire_cut"
    sellprice = 56
    desc = "This gem is admired by many wizards."

/obj/item/roguegem/diamond
    name = "dorpel"
    icon_state = "diamond_cut"
    sellprice = 121
    desc = "Beautifully clear, it demands respect."

/obj/item/roguegem/random
    name = "random gem"
    desc = "You shouldn't be seeing this."
    icon_state = null

/obj/item/roguegem/random/Initialize()
    ..()
    var/newgem = list(/obj/item/roguegem = 5, /obj/item/roguegem/green = 15, /obj/item/roguegem/blue = 10, /obj/item/roguegem/yellow = 20, /obj/item/roguegem/violet = 10, /obj/item/roguegem/diamond = 5, /obj/item/riddleofsteel = 1)
    var/pickgem = pickweight(newgem)
    new pickgem(get_turf(src))
    return INITIALIZE_HINT_QDEL

/obj/item/riddleofsteel
    name = "riddle of steel"
    icon_state = "ros"
    icon = 'icons/roguetown/items/gems.dmi'
    desc = "Flesh, mind."
    lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
    righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
    w_class = WEIGHT_CLASS_TINY
    slot_flags = ITEM_SLOT_MOUTH
    dropshrink = 0.4
    drop_sound = 'sound/items/gem.ogg'
    sellprice = 400

/obj/item/riddleofsteel/Initialize()
    ..()
    set_light(2, 1, "#ff0d0d")
