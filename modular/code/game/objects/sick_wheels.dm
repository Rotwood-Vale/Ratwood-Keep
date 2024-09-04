/obj/vehicle/ridden/wheelchair/sick_wheels
	name = "sick cart"
	desc = "Used by the beggars or veterans with no legs intact."
	icon = 'modular/icons/obj/sick_wheels.dmi'
	icon_state = "sick"
	layer = OBJ_LAYER
	max_integrity = 100
	legs_required = 0	//You'll probably be using this if you don't have legs

/obj/vehicle/ridden/wheelchair/sick_wheels/Initialize()
	. = ..()
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.vehicle_move_delay = 0
	D.set_vehicle_dir_layer(SOUTH, OBJ_LAYER)
	D.set_vehicle_dir_layer(NORTH, OBJ_LAYER)
	D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
	D.set_vehicle_dir_layer(WEST, OBJ_LAYER)

/obj/vehicle/ridden/wheelchair/sick_wheels/obj_destruction(damage_flag)
	new /obj/item/grown/log/tree/small(drop_location(), 3)
	return ..()

/obj/vehicle/ridden/wheelchair/sick_wheels/handle_rotation_overlayed()
	cut_overlays()
	var/image/V = image(icon = icon, icon_state = "sick_overlay", layer = FLY_LAYER, dir = src.dir)
	add_overlay(V)

/datum/crafting_recipe/roguetown/structure/sick_wheels
	name = "sick cart"
	result = /obj/vehicle/ridden/wheelchair/sick_wheels
	reqs = list(/obj/item/grown/log/tree/small = 3)
	verbage_simple = "construct"
	verbage = "constructs"
