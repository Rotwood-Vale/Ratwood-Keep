
/obj/structure/flora/wildplant
	name = "wild plant"
	desc = "It's a wild plant."
	icon = 'icons/obj/flora/wildflora.dmi'
	anchored = 1
	density = 0
	var/has_plod = TRUE
	var/produce
	var/timer = 5000 

/obj/structure/flora/wildplant/Destroy()
	if(LAZYLEN(contents))
		var/turf/our_turf = get_turf(src)
		if(isturf(our_turf))
			for(var/atom/movable/inside_thing in contents)
				inside_thing.forceMove(our_turf)
	. = ..()

/obj/structure/flora/wildplant/attack_hand(mob/user)
	if(!ispath(produce))
		return ..()

	if(has_plod)
		var/obj/item/product = new produce
		if(!istype(product))
			return 
		user.put_in_hands(product)
		to_chat(user, span_notice("You pluck [product] from [src]."))
		has_plod = FALSE
		update_icon() 
		timer = initial(timer) + rand(-100,100) 
		addtimer(CALLBACK(src, .proc/regrow),timer) 
	update_icon()

/obj/structure/flora/wildplant/proc/regrow()
	if(!QDELETED(src))
		has_plod = TRUE
		update_icon()

/obj/structure/flora/wildplant/update_icon()
	if(has_plod)
		icon_state = "[initial(icon_state)]"
	else
		icon_state = "[initial(icon_state)]_no"

/obj/structure/flora/wildplant/Initialize()
	. = ..()
	if(ispath(produce))
		new produce(src) 

/obj/structure/flora/wildplant/wild_poppy
	name = "wild poppy flower"
	icon_state = "wild_poppy"
	desc = "vibrant red flowers famed for their use in ozium creation and pain removing effects"
	produce = /obj/item/reagent_containers/food/snacks/grown/poppy

/obj/structure/flora/wildplant/wild_herbs
	name = "wild herbs"
	icon_state = "wild_herbs"
	desc = "an assortment of wild herbs with mild healing properties."
	produce = /obj/item/reagent_containers/food/snacks/grown/herbs

