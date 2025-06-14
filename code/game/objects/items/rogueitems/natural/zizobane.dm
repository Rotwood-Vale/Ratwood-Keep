/obj/structure/zizo_bane
    name = "Zizo's bane"
    desc = "A small purple mushroom that has been growing in areas of rot."
    icon = 'icons/obj/flora/rogueflora.dmi'
    icon_state = "zizo_bane"
    density = FALSE
    anchored= TRUE
    var/time_delay = 0

/obj/structure/zizo_bane/Initialize()
    . = ..()
    var/matrix/M = matrix()
    M.Scale(0.6, 0.6)
    transform = M

/obj/structure/zizo_bane/Crossed(atom/movable/arrived)
    if(time_delay < world.time)
        if(isliving(arrived))
            make_gas()
            time_delay = world.time + 20 SECONDS

/obj/structure/zizo_bane/proc/make_gas()
    visible_message(span_warn("A cloud of spores burst up from \the [src]!"))
    var/datum/effect_system/smoke_spread/zizosleep/S = new
    playsound(get_turf(src), "sound/items/mushroom_step.ogg", 100)
    S.set_up(2, loc)
    S.start()

/obj/structure/zizo_bane/attack_hand(mob/living/carbon/human/user)
    playsound(src.loc, "plantcross", 80, FALSE, -1)
    user.visible_message(span_warning("[user] starts plucking out \the [src] from the earth."))
    if(do_after(user, 3 SECONDS, target = src))
        var/obj/item/reagent_containers/food/snacks/zizo_bane/z =  new /obj/item/reagent_containers/food/snacks/zizo_bane/ (get_turf(src))
        user.put_in_active_hand(z)
        qdel(src)
    
/obj/item/reagent_containers/food/snacks/zizo_bane
    name = "Zizo's bane"
    desc = "A small purple mushroom that has been growing in areas of rot."
    icon = 'icons/obj/flora/rogueflora.dmi'
    icon_state = "zizo_bane"
    filling_color = "#772681"
    bitesize = 1
    foodtype = VEGETABLES
    list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/sleep_powder = 5)
    tastes = list("sweet" = 1,"bitterness" = 1)
    eat_effect = /datum/status_effect/debuff/knockout
    mill_result = /obj/item/reagent_containers/powder/sleep_powder
    grind_results = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/sleep_powder = 5)
    rotprocess = 30 MINUTES