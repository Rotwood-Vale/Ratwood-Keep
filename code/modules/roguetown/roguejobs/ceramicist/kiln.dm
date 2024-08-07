/* 
	Implementation of a Kiln for pottery work based on the existing ovens.
	Kilns reach temperatures of over 1000C to properly glaze clay.
	Trying to cook with a kiln should, therefore, always burn your food.
	And trying to glaze clay with a regular oven should always be insufficient.

	Despite being similar, Kilns and ovens are, therefore, not interchangeable.
 */

/obj/machinery/light/rogue/oven/kiln
	icon = 'icons/roguetown/misc/lighting.dmi'
	name = "stone kiln"
	desc = "A specialized oven, able to reach higher temperatures to glaze clay."
	icon_state = "oven1" // TODO: Kiln sprites
	base_state = "oven"  // TODO: Kiln sprites
	fueluse = 5 MINUTES // Higher fuel usage, to reach higher temperatures.
	density = TRUE
	anchored = TRUE
	climbable = FALSE
	var/list/clayItems = list()
	var/maxClay = 5
	var/doneClay = FALSE
	var/lastsmoke = 0
	var/need_underlay_update = TRUE

/obj/machinery/light/rogue/oven/OnCrafted(dirin)
	dirin = turn(dirin, 180)
	. = ..(dirin)
	update_icon()

/obj/machinery/light/rogue/oven/kiln/attackby(obj/item/W, mob/living/user, params)
	var/_y = text2num(params2list(params)["icon-y"])
	var/clicked_top
	if(_y > 14)
		clicked_top = TRUE

	if(clicked_top)
		if((W.item_flags & ABSTRACT) || HAS_TRAIT(W, TRAIT_NODROP))
			return ..()
		if(W.wlength > WLENGTH_NORMAL)
			return ..()
		if(clayItems.len < maxClay)
			doneClay = FALSE
			W.forceMove(src)
			clayItems += W
			user.visible_message(span_warning("[user] puts something in the kiln."))
			need_underlay_update = TRUE
			update_icon()
			return
	return ..()

/obj/machinery/light/rogue/oven/kiln/process()
	..()
	if(on)
		for(var/obj/item/I in clayItems)
			if(istype(I, /obj/item/reagent_containers/food/snacks))
				var/obj/item/C = I.burning(1 MINUTES)
			else
				var/obj/item/C = I.glaze(10, src) // TODO: Glaze proc
			if(C)
				doneClay = TRUE
				clayItems -= I
				qdel(I)
				clayItems += C
				visible_message(span_notice("The [C.name] looks ready..."))
				need_underlay_update = TRUE
		update_icon()


/obj/machinery/light/rogue/oven/kiln/Crossed(atom/movable/AM, oldLoc)
	return

/obj/machinery/light/rogue/oven/kiln/Initialize()
	. = ..()
	update_icon()

/obj/machinery/light/rogue/oven/kiln/update_icon()
	icon_state = "[base_state][on]"
	if(on)
		var/burning
		for(var/obj/item/reagent_containers/food/snacks/S in clayItems) //TODO: Wrong var/obj path
			if(S.burning >= S.burntime)
				burning = TRUE
		if(burning)
			if(world.time > lastsmoke + 10 SECONDS)
				lastsmoke = world.time
				var/datum/effect_system/smoke_spread/smoke = new
				smoke.set_up(0, src)
				smoke.start()

	if(need_underlay_update)
		need_underlay_update = FALSE
		underlays.Cut()
		for(var/obj/item/I in clayItems)
			I.pixel_x = 0
			I.pixel_y = 0
			var/mutable_appearance/M = new /mutable_appearance(I)
			M.transform *= 0.5
			M.pixel_y = rand(8,10)
			M.pixel_y = rand(-5,5)
			M.layer = 4.24
			underlays += M
		var/mutable_appearance/M = mutable_appearance(icon, "oven_under")
		M.layer = 4.23
		underlays += M

/obj/machinery/light/rogue/oven/kiln/attack_hand(mob/user, params)
	var/_y = text2num(params2list(params)["icon-y"])
	var/clicked_top
	if(_y > 14)
		clicked_top = TRUE
	if(clicked_top)
		if(clayItems.len)
			var/obj/item/I = clayItems[clayItems.len]
			I.forceMove(get_turf(user))
			clayItems -= I
			user.put_in_active_hand(I)
			doneClay = FALSE
			need_underlay_update = TRUE
			update_icon()
	else
		return ..()
