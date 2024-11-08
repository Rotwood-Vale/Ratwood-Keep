/obj/effect/temp_visual/heal_rogue //color is white by default, set to whatever is needed
	name = "healing glow"
	icon = 'modular_azurepeak/icons/effects/miracle-healing.dmi'
	icon_state = "heal_pantheon"
	duration = 15
	plane = GAME_PLANE_UPPER
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/temp_visual/heal_rogue/Initialize(mapload, set_color)
	if(set_color)
		add_atom_colour(set_color, FIXED_COLOUR_PRIORITY)
	. = ..()
	alpha = 180
	pixel_x = rand(-12, 12)
	pixel_y = rand(-9, 0)
