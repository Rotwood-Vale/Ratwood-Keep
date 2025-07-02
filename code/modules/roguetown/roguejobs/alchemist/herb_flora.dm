/obj/structure/flora/roguegrass/herb
	name = "herbbush"
	desc = "A bush,for an herb. This shouldn't show up."
	icon = 'icons/roguetown/misc/herbfoliage.dmi'
	icon_state = "spritemeplz"
	var/res_replenish
	max_integrity = 10
	climbable = FALSE
	dir = SOUTH
	var/list/looty = list()
	var/herbtype

	var/timerid
	var/harvested = FALSE
