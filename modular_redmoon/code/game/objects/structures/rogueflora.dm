// fyrituis bush
/obj/structure/flora/grass/pyroclasticflowers
	name = "odd group of flowers"
	desc = "A cluster of dangerously combustible flowers."
	icon = 'modular_redmoon/icons/misc/foliage.dmi'
	icon_state = "pyroflower1"
	layer = ABOVE_ALL_MOB_LAYER
	max_integrity = 1
	climbable = FALSE
	dir = SOUTH
	debris = list(/obj/item/natural/fibers = 1)
	var/list/looty2 = list()
	var/bushtype2
	var/res_replenish2

/obj/structure/flora/grass/pyroclasticflowers/update_icon()
	icon_state = "pyroflower[rand(1,3)]"

/obj/structure/flora/grass/pyroclasticflowers/Initialize()
	. = ..()
	if(prob(88))
		bushtype2 = pickweight(list(/obj/item/reagent_containers/food/snacks/grown/fyritius = 1))
	loot_replenish2()
	pixel_x += rand(-3,3)

/obj/structure/flora/grass/pyroclasticflowers/proc/loot_replenish2()
	if(bushtype2)
		looty2 += bushtype2
	if(prob(66))
		looty2 += /obj/item/reagent_containers/food/snacks/grown/fyritius

// pyroflower cluster looting
/obj/structure/flora/grass/pyroclasticflowers/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src.loc, "plantcross", 80, FALSE, -1)
		if(do_after(L, rand(1,5) DECISECONDS, src))
#ifndef MATURESERVER
			if(!looty2.len && (world.time > res_replenish2))
				loot_replenish2()
#endif
			if(prob(50) && looty2.len)
				if(looty2.len == 1)
					res_replenish2 = world.time + 8 MINUTES
				var/obj/item/B = pick_n_take(looty2)
				if(B)
					B = new B(user.loc)
					user.put_in_hands(B)
					user.visible_message(span_notice("[user] finds [B] in [src]."))
					return
			user.visible_message(span_warning("[user] searches through [src]."))
#ifdef MATURESERVER
			if(!looty2.len)
				to_chat(user, span_warning("Picked clean."))
#else
			if(!looty2.len)
				to_chat(user, span_warning("Picked clean... I should try later."))
#endif
