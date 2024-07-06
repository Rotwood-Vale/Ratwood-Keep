///// DAKKATOWN AREAS //////

// Players should be fined for any damage they do to the Guild's property
/area/rogue/outdoors/beach/boat
	name = "sophia's cry"
	ambientsounds = AMB_BEACH
	ambientnight = AMB_BEACH
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'

// Players are penalized for entering the Guild Gaptain's quarters (FAFO)
/area/rogue/outdoors/beach/boat/captain
	name = "guild captain"
	ambientsounds = AMB_BEACH
	ambientnight = AMB_BEACH
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'

/area/rogue/indoors/town/theatre
	name = "theatre"
	icon_state = "manor"
	droning_sound = null
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/theatre

/area/rogue/outdoors/exposed/theatre
	name = "theatre"
	icon_state = "manor"
	droning_sound = null
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/indoors/town/apothecary
	name = "apothecary"
	icon_state = "manor"
	droning_sound = null
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/ruin
	name = "townruin"
	icon_state = "town"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

#define WOOD 2

/obj/structure/barricade/wooden/rogue
	name = "wooden barricade"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "woodenbarricade_r"
	max_integrity = 60
	bar_material = WOOD
	drop_amount = 0

#undef WOOD

/obj/structure/barricade/wooden/rogue/crude
	name = "crude plank barricade"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "woodenbarricade_r2"
	max_integrity = 40

/obj/effect/landmark/start/combatlate
	name = "Combatlate"
	icon_state = "arrow"
	jobspawn_override = list("Skeleton", "Drifter", "Pilgrim", "Adventurer", "Mercenary")
	delete_after_roundstart = FALSE

/obj/item/keyring/jester
	keys = list(/obj/item/roguekey/manor, /obj/item/roguekey/garrison, /obj/item/roguekey/theatre)

/obj/item/keyring/weaponsmith
	keys = list(/obj/item/roguekey/weaponsmith, /obj/item/roguekey/blacksmith)

/obj/item/keyring/armorsmith
	keys = list(/obj/item/roguekey/armorsmith, /obj/item/roguekey/blacksmith)

// Dakkatown Keys
/obj/item/roguekey/monastery
	name = "monastery key"
	icon_state = "greenkey"
	lockid = "monastery"

/obj/item/roguekey/houses
	name = ""
	icon_state = ""
	lockid = ""

/obj/item/roguekey/houses/house1
	name = "house i key"
	icon_state = "brownkey"
	lockid = "house1"

/obj/item/roguekey/houses/house2
	name = "house ii key"
	icon_state = "brownkey"
	lockid = "house2"

/obj/item/roguekey/houses/house3
	name = "house iii key"
	icon_state = "brownkey"
	lockid = "house3"

/obj/item/roguekey/houses/house4
	name = "house iv key"
	icon_state = "brownkey"
	lockid = "house4"

/obj/item/roguekey/houses/house5
	name = "house v key"
	icon_state = "brownkey"
	lockid = "house5"

/obj/item/roguekey/houses/house6
	name = "house vi key"
	icon_state = "brownkey"
	lockid = "house6"

/obj/item/roguekey/houses/house7
	name = "house vii key"
	icon_state = "brownkey"
	lockid = "house7"

/obj/item/roguekey/houses/house8
	name = "house viii key"
	icon_state = "brownkey"
	lockid = "house8"

/obj/item/roguekey/houses/house9
	name = "house ix key"
	icon_state = "brownkey"
	lockid = "house9"

/obj/item/roguekey/apartments
	name = ""
	icon_state = ""
	lockid = ""

/obj/item/roguekey/apartments/apartment1
	name = "apartment i key"
	icon_state = "brownkey"
	lockid = "apartment1"

/obj/item/roguekey/apartments/apartment2
	name = "apartment ii key"
	icon_state = "brownkey"
	lockid = "apartment2"

/obj/item/roguekey/apartments/apartment3
	name = "apartment iii key"
	icon_state = "brownkey"
	lockid = "apartment3"

/obj/item/roguekey/apartments/apartment4
	name = "apartment iv key"
	icon_state = "brownkey"
	lockid = "apartment4"

/obj/item/roguekey/apartments/apartment5
	name = "apartment v key"
	icon_state = "brownkey"
	lockid = "apartment5"

/obj/item/roguekey/apartments/apartment6
	name = "apartment vi key"
	icon_state = "brownkey"
	lockid = "apartment6"

/obj/item/roguekey/apartments/apartment7
	name = "apartment vii key"
	icon_state = "brownkey"
	lockid = "apartment7"

/obj/item/roguekey/apartments/apartment8
	name = "apartment viii key"
	icon_state = "brownkey"
	lockid = "apartment8"

/obj/item/roguekey/apartments/apartment9
	name = "apartment ix key"
	icon_state = "brownkey"
	lockid = "apartment9"

/obj/item/roguekey/shops
	name = ""
	icon_state = ""
	lockid = ""

/obj/item/roguekey/shops/shop1
	name = "shop i key"
	icon_state = "rustkey"
	lockid = "shop1"

/obj/item/roguekey/shops/shop2
	name = "shop ii key"
	icon_state = "rustkey"
	lockid = "shop2"

/obj/item/roguekey/shops/shop3
	name = "shop iii key"
	icon_state = "rustkey"
	lockid = "shop3"

/obj/item/roguekey/shops/shop4
	name = "shop iv key"
	icon_state = "rustkey"
	lockid = "shop4"

/obj/item/roguekey/shops/shop5
	name = "shop v key"
	icon_state = "rustkey"
	lockid = "shop5"

/obj/item/roguekey/shops/shop6
	name = "shop vi key"
	icon_state = "rustkey"
	lockid = "shop6"

/obj/item/roguekey/shops/shop7
	name = "shop vii key"
	icon_state = "rustkey"
	lockid = "shop7"

/obj/item/roguekey/shops/shop8
	name = "shop viii key"
	icon_state = "rustkey"
	lockid = "shop8"

/obj/item/roguekey/shops/shop9
	name = "shop ix key"
	icon_state = "rustkey"
	lockid = "shop9"

/obj/item/roguekey/theatre
	name = "theatre key"
	icon_state = "mazekey"
	lockid = "theatre"

/obj/item/roguekey/butcher
	name = "butcher's key"
	icon_state = "rustkey"
	lockid = "butcher"

/obj/item/roguekey/elder
	name = "elder's key"
	icon_state = "rustkey"
	lockid = "elder"

/obj/item/roguekey/apothecary
	name = "apothecary's key"
	icon_state = "rustkey"
	lockid = "apothecary"

/obj/item/roguekey/weaponsmith
	name = "weaponsmith's key"
	icon_state = "rustkey"
	lockid = "weaponsmith"

/obj/item/roguekey/armorsmith
	name = "armorsmith's key"
	icon_state = "rustkey"
	lockid = "armorsmith"

/obj/structure/bars/bent
	icon_state = "barsbent"

/obj/structure/mineral_door/wood/green
	icon_state = "wcg"

// original icon = 'icons/roguetown/topadd/cre/enigma_misc1.dmi'
/obj/structure/stairs/stone/church
	name = "stone stairs"
	icon = 'icons/obj/stairs.dmi'
	icon_state = "churchstairs"

// temporary
/obj/item/cooking/platter


// Dakkatown Turfs
/turf/closed/indestructible/wooddark
	name = "wall"
	desc = ""
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "corner"

/turf/closed/indestructible/roguewindow
	name = "window"
	desc = ""
	opacity = 0
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "window-solid"

/turf/open/floor/rogue/plank
	icon_state = "plank"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/woodland.wav'

/turf/open/floor/rogue/plank/h
	icon_state = "plank2"

/datum/mapGeneratorModule/dambushing
	spawnableAtoms = list(/obj/effect/landmark/ambush=50)
	spawnableTurfs = list()
	clusterMax = 3
	clusterMin = 2
	checkdensity = FALSE
	allowed_areas = list(/area/rogue/outdoors)
	allowed_turfs = list(/turf/open/floor/rogue/dirt/ambush)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)

/obj/effect/landmark/ambush/Initialize()
	. = ..()
#ifdef TESTSERVER
	invisibility = 0
#endif
/obj/effect/landmark/ambush/Crossed(AM as mob|obj)
	. = ..()
	if(isturf(loc))
		if(isliving(AM))
			var/mob/living/MM = AM
			if(MM.m_intent != MOVE_INTENT_SNEAK)
				MM.consider_ambush()

/obj/effect/landmark/mapGenerator/dakka/beach
	mapGeneratorType = /datum/mapGenerator/dbeach
	endTurfX = 155
	endTurfY = 45
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/dbeach
	modules = list(/datum/mapGeneratorModule/dbeach)

/datum/mapGeneratorModule/dbeach
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS|CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt/road)
	allowed_areas = list(/area/rogue/outdoors/beach)
	spawnableAtoms = list(	/obj/item/natural/stone = 11,
							/obj/item/grown/log/tree/stick = 1)


/obj/effect/landmark/mapGenerator/dakka/forest
	mapGeneratorType = /datum/mapGenerator/dforest
	endTurfX = 155
	endTurfY = 155
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/dforest
	modules = list(/datum/mapGeneratorModule/dambushing,/datum/mapGeneratorModule/dforestgrassturf,/datum/mapGeneratorModule/dforest,/datum/mapGeneratorModule/dforestroad,/datum/mapGeneratorModule/dforestgrass,/datum/mapGeneratorModule/dforestwaterturf)

/datum/mapGeneratorModule/dforest
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtree = 5,
							/obj/structure/flora/roguegrass/bush = 6,
							/obj/structure/flora/roguegrass = 100,
							/obj/item/natural/stone = 5,
							/obj/item/natural/rock = 6,
							/obj/item/grown/log/tree/stick = 5,
							/obj/structure/flora/roguetree/stump/log = 3,
							/obj/structure/flora/roguetree/stump = 4,
							/obj/structure/closet/dirthole/closed/loot=6,
							/obj/item/restraints/legcuffs/beartrap/armed/camouflage=0,
							/obj/structure/flora/roguegrass/maneater/real=0)
	spawnableTurfs = list(/turf/open/floor/rogue/dirt/road=80,
						/turf/open/water/swamp=25)
	allowed_areas = list(/area/rogue/outdoors/woods)

/datum/mapGeneratorModule/dforestroad
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/item/natural/stone = 3,/obj/item/grown/log/tree/stick = 2)

/datum/mapGeneratorModule/dforestgrassturf
	clusterCheckFlags = CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/rogue/dirt)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableTurfs = list(/turf/open/floor/rogue/grass = 200)
	allowed_areas = list(/area/rogue/outdoors/woods)

/datum/mapGeneratorModule/dforestgrass
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/grass)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/roguetree = 0,
							/obj/structure/flora/roguegrass/bush = 6,
							/obj/structure/flora/roguegrass = 120,
							/obj/structure/flora/roguegrass/maneater = 0,
							/obj/structure/flora/roguegrass/maneater/real = 0,
							/obj/item/restraints/legcuffs/beartrap/armed/camouflage = 0,
							/obj/item/natural/stone = 6,
							/obj/item/natural/rock = 5,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/flora/roguetree/stump/log = 5)

/datum/mapGeneratorModule/dforestwaterturf
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/water/cleanshallow)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/roguegrass/water = 20,
	                        /obj/structure/flora/roguegrass/water/reeds = 30,
	                        /obj/structure/glowshroom = 55)

/obj/effect/landmark/mapGenerator/dakka/mountain
	mapGeneratorType = /datum/mapGenerator/dmtn
	endTurfX = 155
	endTurfY = 155
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/dmtn
	modules = list(/datum/mapGeneratorModule/dambushing,/datum/mapGeneratorModule/dmtn)

/datum/mapGeneratorModule/dmtn
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/structure/roguerock=5,/obj/item/natural/stone = 18,/obj/item/natural/rock = 10)
	allowed_areas = list(/area/rogue/outdoors/mountains,/area/rogue/outdoors/mountains/deception)

/obj/effect/landmark/mapGenerator/dakka/swamp
	mapGeneratorType = /datum/mapGenerator/dswamp
	endTurfX = 155
	endTurfY = 155
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/dswamp
	modules = list(/datum/mapGeneratorModule/dambushing,/datum/mapGeneratorModule/dswamp, /datum/mapGeneratorModule/dswampwater)

/datum/mapGeneratorModule/dswamp
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt)
	spawnableAtoms = list(/obj/structure/flora/roguetree = 1,
							/obj/structure/flora/roguegrass/bush = 12,
							/obj/structure/flora/roguegrass/maneater = 0,
							/obj/structure/flora/roguegrass = 23,
							/obj/structure/flora/roguetree/stump/log = 20,
							/obj/item/natural/rock = 30,
							/obj/item/natural/stone = 30,
							/obj/structure/flora/roguegrass/swampweed = 30,
							/obj/item/grown/log/tree/stick = 4,
							/obj/structure/flora/roguegrass/maneater/real = 1,
							/obj/item/restraints/legcuffs/beartrap/armed/camouflage = 0)
	spawnableTurfs = list(/turf/open/water/swamp = 5,
	                     /turf/open/floor/rogue/dirt = 80)
	allowed_areas = list(/area/rogue/outdoors/bog)

/datum/mapGeneratorModule/dswampwater
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/roguegrass/water = 5,
						/obj/structure/flora/roguegrass/water/reeds = 80,
						/obj/structure/glowshroom = 60)
	allowed_turfs = list(/turf/open/water/swamp,
						/turf/open/water/swamp/deep)
	allowed_areas = list(/area/rogue/outdoors/bog)

/obj/effect/landmark/mapGenerator/dakka/dakkatownfield
	mapGeneratorType = /datum/mapGenerator/dakkatownfield
	endTurfX = 155
	endTurfY = 155
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/dakkatownfield
	modules = list(/datum/mapGeneratorModule/dambushing,/datum/mapGeneratorModule/dakkatownfield,/datum/mapGeneratorModule/dakkatownfield/road,/datum/mapGeneratorModule/dakkatownfield/grass)

/datum/mapGeneratorModule/dakkatownfield
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtree = 5,
							/obj/structure/flora/roguegrass/bush = 13,
							/obj/structure/flora/roguegrass = 50,
							/obj/structure/flora/roguegrass/maneater = 1,
							/obj/item/natural/stone = 8,
							/obj/item/natural/rock = 7,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/closet/dirthole/closed/loot=6,
							/obj/item/restraints/legcuffs/beartrap/armed/camouflage=0.5)
	spawnableTurfs = list(/turf/open/floor/rogue/dirt/road=5)
	allowed_areas = list(/area/rogue/outdoors/rtfield)

/datum/mapGeneratorModule/dakkatownfield/road
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt/road)
	excluded_turfs = list()
	spawnableAtoms = list(/obj/item/natural/stone = 8,
							/obj/item/grown/log/tree/stick = 3)
	allowed_areas = list(/area/rogue/outdoors/rtfield)

/datum/mapGeneratorModule/dakkatownfield/grass
	clusterCheckFlags = CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/rogue/dirt)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableTurfs = list(/turf/open/floor/rogue/grass = 15)
	allowed_areas = list(/area/rogue/outdoors/rtfield)

/obj/item/roguekey/houses/waterfront1
	name = "I Waterfront Street Ket"
	icon_state = "brownkey"
	lockid = "1waterfront"

/obj/item/roguekey/houses/waterfront2
	name = "II Waterfront Street Ket"
	icon_state = "brownkey"
	lockid = "2waterfront"

/obj/item/roguekey/houses/waterfront3
	name = "III Waterfront Street Ket"
	icon_state = "brownkey"
	lockid = "3waterfront"

/obj/item/roguekey/houses/waterfront4
	name = "IV Waterfront Street Ket"
	icon_state = "brownkey"
	lockid = "4waterfront"

/obj/item/roguekey/houses/waterfront5
	name = "V Waterfront Street Ket"
	icon_state = "brownkey"
	lockid = "5waterfront"

// swarmpweed bush
/obj/structure/flora/roguegrass/swampweed
	name = "bunch of swampweed"
	desc = "a green root good for smoking."
	icon_state = "swampweed1"
	layer = ABOVE_ALL_MOB_LAYER
	max_integrity = 1
	climbable = FALSE
	dir = SOUTH
	debris = list(/obj/item/natural/fibers = 1)
	var/list/looty3 = list()
	var/bushtype3
	var/res_replenish3

/obj/structure/flora/roguegrass/swampweed/Initialize()
	if(prob(88))
		bushtype3 = pickweight(list(/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry = 1))
	loot_replenish3()
	pixel_x += rand(-3,3)
	return ..()

/obj/structure/flora/roguegrass/swampweed/proc/loot_replenish3()
	if(bushtype3)
		looty3 += bushtype3
	if(prob(66))
		looty3 += /obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry

/obj/structure/rack/rogue/shelf/biggest
/obj/structure/table/wood/plain
/obj/structure/table/wood/plain/alt
/obj/structure/table/wood/plain/alto
/obj/item/reagent_containers/powder/salt
/obj/structure/closet/crate/chest/wicker
/obj/structure/table/wood/counter
/obj/structure/table/wood/counter/end
/obj/item/clothing/head/roguetown/crown/serpcrown/surplus
/obj/structure/table/wood/large/corner
/obj/structure/table/wood/large/corner_alt
/obj/item/cooking/pot
/obj/structure/closet/crate/chest/neu
/obj/structure/closet/crate/chest/neu_fancy
/obj/structure/closet/crate/chest/neu_iron
/obj/item/reagent_containers/glass/bottle/rogue/beer/butterhairs
/obj/item/reagent_containers/glass/bottle/rogue/beer/spottedhen
/obj/item/reagent_containers/glass/bottle/rogue/beer/stonebeardreserve
/obj/structure/closet/crate/chest/old_crate
/obj/effect/landmark/start/prisoner
/obj/item/reagent_containers/peppermill
/obj/structure/table/wood/fine
/mob/living/carbon/human/species/skeleton/npc/peasant
/obj/structure/fluff/walldeco/med
/obj/structure/fluff/walldeco/med2
/obj/structure/fluff/walldeco/med3
/obj/structure/fluff/walldeco/med4
/obj/structure/fluff/walldeco/med5
/obj/structure/fluff/walldeco/med6
/obj/structure/table/wood/nice
/obj/item/reagent_containers/food/snacks/grown/nettle
/obj/item/rogueweapon/woodcut
/obj/item/rogueweapon/sword/coppermesser
/obj/item/rogueweapon/halberd/iron
/obj/item/reagent_containers/food/snacks/grown/garlic
/obj/item/rogueweapon/mace/coppermace
/mob/living/carbon/human/species/skeleton/npc/warrior
/obj/machinery/light/rogue/lanternpost/fixed
/obj/structure/roguemachine/submission
/obj/item/roguekey/doctor
/obj/structure/table/wood/reinforced_alt
/obj/item/reagent_containers/glass/bottle/rogue/wine/sourwine
/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast/buttered
/obj/item/reagent_containers/glass/bottle/rogue/redwine
/obj/item/reagent_containers/glass/bottle/rogue/whitewine
/obj/item/seeds/sunflower
/obj/structure/mannequin/male
/mob/living/simple_animal/hostile/retaliate/rogue/trollbog
/obj/item/roguekey/captain
/obj/structure/closet/crate/drawer/random
/obj/item/roguekey/niteman
/obj/item/roguekey/nitemaiden
/obj/item/rogueweapon/knife/copperdagger
/obj/item/rogueweapon/mace/warhammer
/obj/effect/landmark/start/apothecary
/obj/effect/landmark/start/feldsher
/obj/item/roguekey/warehouse
/obj/item/clothing/suit/roguetown/shirt/robe/feld
/obj/item/clothing/neck/roguetown/feld
/obj/item/clothing/mask/rogue/feld
/obj/item/clothing/head/roguetown/roguehood/feld
/obj/item/clothing/gloves/roguetown/leather/feld
/mob/living/simple_animal/pet/cat/inn
/obj/item/rogueweapon/woodcut/steel
/obj/structure/bed/rogue/sleepingbag
/obj/structure/closet/crate/chest/lostandfound
/obj/effect/landmark/start/mercenarylate
/obj/item/roguekey/soilson
/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig
/obj/item/seeds/garlic
/obj/item/seeds/onion
/obj/item/seeds/cabbage
