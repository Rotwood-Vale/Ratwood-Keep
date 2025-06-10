//genstuff
/obj/effect/landmark/mapGenerator/rogue/bog
	mapGeneratorType = /datum/mapGenerator/bog
	endTurfX = 255
	endTurfY = 400
	startTurfX = 1
	startTurfY = 1


/datum/mapGenerator/bog
	modules = list(/datum/mapGeneratorModule/ambushing,/datum/mapGeneratorModule/boggrassturf,/datum/mapGeneratorModule/bog,/datum/mapGeneratorModule/bogroad,/datum/mapGeneratorModule/boggrass)


/datum/mapGeneratorModule/bog
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtree = 30,
							/obj/structure/flora/roguegrass/bush = 25,
							/obj/structure/flora/roguegrass = 26,
							/obj/structure/flora/roguegrass/maneater = 13,
							/obj/structure/flora/roguegrass/pyroclasticflowers = 5,
							/obj/item/natural/stone = 23,
							/obj/item/natural/rock = 6,
							/obj/item/natural/artifact = 4,
							/obj/structure/leyline = 1,
							/obj/structure/voidstoneobelisk = 1,
							/obj/structure/manaflower = 4,
							/obj/item/natural/manacrystal = 1,
							/obj/item/grown/log/tree/stick = 16,
							/obj/structure/table/roguetree/stump/log = 3,
							/obj/structure/table/roguetree/stump = 4,
							/obj/effect/mob_spawner =5,
							/obj/structure/closet/dirthole/closed/loot=3,
							/obj/structure/wild_swampweed = 5,
							/obj/structure/flora/roguegrass/maneater/real=3,
							/obj/item/clothing/head/flowers/purple_lily = 1,
							/obj/item/clothing/head/flowers/snapdragon = 1,
							/obj/item/clothing/head/flowers/redpurple_rose = 1,
							/obj/item/clothing/head/flowers/burdock_flower_purple = 1,
							/obj/item/clothing/head/flowers/yellow_lily = 1,
							/obj/item/clothing/head/flowers/burdock_flower_pink = 1,
							/obj/item/clothing/head/flowers/yarrow_white = 1,
							/obj/item/clothing/head/flowers/rose_pink = 1,
							/obj/item/clothing/head/flowers/roses_red = 1,
							/obj/item/clothing/head/flowers/peony = 1,
							/obj/item/clothing/head/flowers/forget_me_not_alt = 1,
							/obj/item/clothing/head/flowers/forget_me_not = 1,
							/obj/item/clothing/head/flowers/blue_rose = 1,
							/obj/item/clothing/head/flowers/orange_rose = 1,
							/obj/item/clothing/head/flowers/sunflower = 1,
							/obj/item/clothing/head/flowers/yellow_bells = 1,
							/obj/item/clothing/head/flowers/poppy = 1,
							/obj/item/clothing/head/flowers/blue_purple_bells = 1,
							/obj/item/clothing/head/flowers/iris = 1,
							/obj/item/clothing/head/flowers/muscaris = 1,
							/obj/item/clothing/head/flowers/lavander = 1,
							/obj/item/clothing/head/flowers/milva = 1,
							/obj/item/clothing/head/flowers/yellow_iris = 1)
	spawnableTurfs = list(/turf/open/floor/rogue/dirt/road=2,
						/turf/open/water/swamp=1)
	allowed_areas = list(/area/rogue/outdoors/bog, /area/rogue/outdoors/rtfield)

/datum/mapGeneratorModule/bogroad
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/item/natural/stone = 9,/obj/item/grown/log/tree/stick = 6)

/datum/mapGeneratorModule/boggrassturf
	clusterCheckFlags = CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/rogue/dirt)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableTurfs = list(/turf/open/floor/rogue/grass = 23)
	allowed_areas = list(/area/rogue/outdoors/bog)

/datum/mapGeneratorModule/boggrass
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/grass)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/bog)
	spawnableAtoms = list(/obj/structure/glowshroom = 5,
							/obj/structure/flora/roguetree = 30,
							/obj/structure/flora/roguetree/wise=1,
							/obj/structure/flora/roguegrass/bush = 25,
							/obj/structure/flora/roguegrass = 44,
							/obj/structure/flora/roguegrass/maneater = 13,
							/obj/structure/flora/roguegrass/maneater/real=2,
							/obj/item/natural/stone = 6,
							/obj/item/natural/rock = 1,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/table/roguetree/stump/log = 3,
							/datum/spacevine_controller = 1)
