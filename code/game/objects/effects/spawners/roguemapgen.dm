// why the fuck??
/obj/effect/spawner/roguemap/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSmapgen, src)

/obj/effect/spawner/roguemap
	icon = 'icons/obj/structures_spawners.dmi'
	var/probby = 100
	var/list/spawned

/obj/effect/spawner/roguemap/process()
	if(prob(probby))
		var/obj/new_type = pick(spawned)
		new new_type(get_turf(src))

	STOP_PROCESSING(SSmapgen, src)
	qdel(src)

/obj/effect/spawner/roguemap/pit
	icon_state = "pit"

/obj/effect/spawner/roguemap/pit/process()
	var/turf/T = get_turf(src)
	var/turf/below = get_step_multiz(src, DOWN)
	if(below)
		T.ChangeTurf(/turf/open/transparent/openspace)
		below.ChangeTurf(/turf/open/floor/rogue/dirt/road)

	STOP_PROCESSING(SSmapgen, src)
	qdel(src)


/obj/effect/spawner/roguemap/tree
	icon_state = "tree"
	name = "Tree spawner"
	probby = 80
	spawned = list(/obj/structure/flora/roguetree)

/obj/effect/spawner/roguemap/mobspawner
	icon_state = "mobspawner"
	name = "mob spawner"
	probby = 50
	spawned = list(/obj/structure/flora/roguetree)

/obj/effect/spawner/roguemap/treeorbush
	icon_state = "Treeorbush"
	name = "Tree or bush spawner"
	probby = 50
	spawned = list(/obj/structure/flora/roguetree, /obj/structure/flora/roguegrass/bush)

/obj/effect/spawner/roguemap/treeorstump
	icon_state = "treeorstump"
	name = "Tree or stump spawner"
	probby = 50
	spawned = list(/obj/structure/flora/roguetree, /obj/structure/table/roguetree/stump)

/obj/effect/spawner/roguemap/stump
	icon_state = "stump"
	name = "stump spawner"
	probby = 75
	spawned = list(/obj/structure/table/roguetree/stump)

/obj/effect/spawner/roguemap/shroud
	icon_state = "shroud"
	name = "shroud sp"
	probby = 30
	spawned = list(/turf/closed/wall/shroud)

/obj/effect/spawner/roguemap/hauntpile
	icon_state = "hauntpile"
	name = "hauntpile"
	probby = 23
	spawned = list(/obj/structure/bonepile)

/obj/effect/spawner/roguemap/beartrap
	icon_state = "beartrap"
	name = "beartrap"
	probby = 50
	spawned = list(/obj/item/restraints/legcuffs/beartrap/armed/camouflage)

/obj/effect/spawner/roguemap/flowerspawn
	name = "flowerspawn"
	icon_state = "flowerspawn"
	probby = 100

	spawned = list(
		/obj/item/clothing/head/flowers/purple_lily = 4,
		/obj/item/clothing/head/flowers/snapdragon = 4,
		/obj/item/clothing/head/flowers/redpurple_rose = 4,
		/obj/item/clothing/head/flowers/burdock_flower_purple = 4,
		/obj/item/clothing/head/flowers/yellow_lily = 4,
		/obj/item/clothing/head/flowers/burdock_flower_pink = 4,
		/obj/item/clothing/head/flowers/yarrow_white = 4,
		/obj/item/clothing/head/flowers/rose_pink = 4,
		/obj/item/clothing/head/flowers/roses_red = 4,
		/obj/item/clothing/head/flowers/peony = 4,
		/obj/item/clothing/head/flowers/forget_me_not_alt = 4,
		/obj/item/clothing/head/flowers/forget_me_not = 4,
		/obj/item/clothing/head/flowers/blue_rose = 4,
		/obj/item/clothing/head/flowers/orange_rose = 4,
		/obj/item/clothing/head/flowers/sunflower = 4,
		/obj/item/clothing/head/flowers/yellow_bells = 4,
		/obj/item/clothing/head/flowers/poppy = 4,
		/obj/item/clothing/head/flowers/blue_purple_bells = 5,
		/obj/item/clothing/head/flowers/iris = 5,
		/obj/item/clothing/head/flowers/muscaris = 5,
		/obj/item/clothing/head/flowers/lavander = 5,
		/obj/item/clothing/head/flowers/milva = 5,
		/obj/item/clothing/head/flowers/yellow_iris = 5
	)

/obj/effect/spawner/roguemap/flowerspawn/process()
	var/type = pickweight(spawned)
	if(type)
		new type(get_turf(src))

	STOP_PROCESSING(SSmapgen, src)
	qdel(src)
