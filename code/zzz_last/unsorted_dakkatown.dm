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

/obj/structure/table/wood/counter
    name = "counter"
    icon_state = "longtable_mid"

/obj/structure/table/wood/counter/end
    icon_state = "longtable"

/obj/structure/table/wood/plain
    icon_state = "tablewood1"

/obj/structure/table/wood/plain/alt
    icon_state = "tablewood2"

/obj/structure/table/wood/plain/alto
    icon_state = "tablewood3"

/obj/structure/rack/rogue/shelf/biggest
	icon_state = "shelf_biggest"
	pixel_y = 0

// When players exit the round via boat, their items get transported here
/obj/structure/closet/crate/chest/lostandfound
	desc = "An incredibly sturdy chest; the Guild can afford the best materials after all."
	anchored = 1
	max_integrity = 2000

/obj/structure/closet/crate/chest/wicker
	name = "wicker basket"
	desc = "Fibers interwoven to make a cheap storage bin."
	base_icon_state = "wicker"
	icon_state = "wicker"
	open_sound = 'sound/items/book_open.ogg'
	open_sound = 'sound/items/book_close.ogg'
	close_sound = 'sound/items/book_close.ogg'

/obj/structure/closet/crate/chest/neu
	name = "sturdy oak chest"

/obj/structure/closet/crate/chest/neu_iron
	name = "reinforced chest"

/obj/structure/closet/crate/chest/neu_fancy
	name = "fancy chest"

/obj/structure/closet/crate/chest/old_crate
	name = "old crate"

/obj/structure/closet/crate/drawer/random
	icon_state = "drawer1"
	pixel_y = 12

/obj/structure/closet/crate/drawer/random/Initialize()
    . = ..()
    if(icon_state == "drawer1")
        base_icon_state = "drawer[rand(1,4)]"
        icon_state = "[base_icon_state]"
    else
        base_icon_state = "drawer1"
        pixel_y = 12

/obj/structure/table/wood/large/corner
    icon_state = "largetable"

/obj/structure/table/wood/large/corner_alt
    icon_state = "largetable_alt"

/obj/structure/table/wood/fine
	name = "wooden table"
	desc = ""
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "tablefine"
	resistance_flags = FLAMMABLE
	max_integrity = 40
	smooth = 0
	debris = list(/obj/item/grown/log/tree/small = 2)
	climb_offset = 10

/obj/structure/table/wood/nice
	name = "wooden table"
	desc = ""
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "tablefine2"


/obj/structure/table/wood/reinforced
    name = "reinforced table"
    icon_state = "tablewood"

/obj/structure/table/wood/reinforced_alt
    icon_state = "tablewood_alt2"

/// new food stuff
/obj/item/cooking/pot
/obj/item/reagent_containers/peppermill

/obj/effect/landmark/start/prisoner
	name = "Prisoner (Rockhill)"
	icon_state = "arrow"

/obj/item/reagent_containers/glass/bottle/rogue/beer/butterhairs
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 45)
	desc = "A bottle with the Dwarven Federation Trade Alliance cork-seal. This beer, known as butterhairs: is widely considered one of the greatest exported by the Dwarves."


/obj/item/reagent_containers/glass/bottle/rogue/beer/spottedhen
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 45)
	desc = "A bottle with the spotted-hen cork-seal. An extremely cheap lager hailing from a local brewery."

/obj/item/reagent_containers/glass/bottle/rogue/beer/stonebeardreserve
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 45)
	desc = "A bottle with the House Stoutenson cork-seal. Stonebeards Reserve is one of the most legendary beers in existence, with only a few hundred barrels made every year."

/obj/structure/fluff/walldeco/med
	name = "diagram"
	icon_state = "medposter"

/obj/structure/fluff/walldeco/med2
	name = "diagram"
	icon_state = "medposter2"

/obj/structure/fluff/walldeco/med3
	name = "diagram"
	icon_state = "medposter3"

/obj/structure/fluff/walldeco/med4
	name = "diagram"
	icon_state = "medposter4"

/obj/structure/fluff/walldeco/med5
	name = "diagram"
	icon_state = "medposter5"

/obj/structure/fluff/walldeco/med6
	name = "diagram"
	icon_state = "medposter6"

/obj/item/roguekey/niteman
	name = "nitemaster's key"
	desc = "The master key of Eora's House."
	icon_state = "greenkey"
	lockid = "nightman"

/obj/item/roguekey/nitemaiden
	name = "nitemaiden's key"
	desc = "This brownish key opens a few doors within the pleasure house."
	icon_state = "brownkey"
	lockid = "nightmaiden"

/obj/item/roguekey/captain
	name = "captain's key"
	desc = "This key belongs to the Captain of the Guard."
	icon_state = "cheesekey"
	lockid = "sheriff"

/obj/item/roguekey/soilson
	name = "Soilson Key"
	desc = "This key is used by the soilsons."
	icon_state = "rustkey"
	lockid = "soilson"

/obj/item/roguekey/doctor
	name = "doctor's key"
	desc = "This key is ued by the Physickers."
	icon_state = "birdkey"
	lockid = "doctor"

/obj/item/roguekey/warehouse
	name = "Warehouse Key"
	desc = "This key opens the Steward's warehouse."
	icon_state = "rustkey"
	lockid = "warehouse"

/mob/living/simple_animal/pet/cat/inn

/obj/machinery/light/rogue/lanternpost/fixed
	desc = "The lamptern is permanently built into the structure of this one."

/obj/structure/bed/rogue/sleepingbag
	name = "sleepcloth"
	desc = "So you can sleep on the ground in relative peace."
	icon_state = "sleepingcloth"
	attacked_sound = 'sound/foley/cloth_rip.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	sleepy = 0.5

/obj/structure/bed/rogue/sleepingbag/MiddleClick(mob/user, params)
	..()
	user.visible_message("<span class='notice'>[user] begins rolling up \the [src].</span>")
	if(do_after(user, 2 SECONDS, TRUE, src))
		new /obj/item/sleepingbag(get_turf(src))
		qdel(src)

/obj/item/sleepingbag
	name = "roll of sleepcloth"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "sleepingcloth_rolled"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/sleepingbag/MiddleClick(mob/user, params)
	..()
	var/turf/T = get_turf(loc)
	if(!isfloorturf(T))
		to_chat(user, "<span class='warning'>I need ground to plant this on!</span>")
		return
	for(var/obj/A in T)
		if(istype(A, /obj/structure))
			to_chat(user, "<span class='warning'>I need some free space to deploy a [src] here!</span>")
			return
		if(A.density && !(A.flags_1 & ON_BORDER_1))
			to_chat(user, "<span class='warning'>There is already something here!</span>")
			return
	user.visible_message("<span class='notice'>[user] begins placing \the [src] down on the ground.</span>")
	if(do_after(user, 2 SECONDS, TRUE, src))
		new /obj/structure/bed/rogue/sleepingbag(get_turf(src))
		qdel(src)

/obj/effect/landmark/start/mercenarylate
	name = "Mercenarylate"
	icon_state = "arrow"
	jobspawn_override = list("Desert Rider Mercenary", "Grenzelhoft Mercenary")
	delete_after_roundstart = FALSE

/obj/item/reagent_containers/glass/bottle/rogue/wine/sourwine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 45)
	desc = "A bottle that contains a grenzelhoftian classic with a black ink cork-seal.. An extremely sour wine that is watered down with mineral water."

/obj/item/reagent_containers/glass/bottle/rogue/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 45)
	desc = "A bottle with the Valorian Merchant Guild cork-seal. This one appears to be labelled as a relatively young red-wine from the coinlord state."

/obj/item/reagent_containers/glass/bottle/rogue/whitewine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 45)
	desc = "A bottle with the Valorian Merchant Guild cork-seal. This one appears to be labelled as a sweet wine from the colder northern regions."

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog
	icon = 'icons/roguetown/mob/monster/trolls.dmi'
	name = "Bog Troll"
	icon_state = "Troll"
	icon_living = "Troll"
	icon_dead = "Trolld"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 4
	see_in_dark = 10
	move_to_delay = 2
	base_intents = list(/datum/intent/simple/headbutt, /datum/intent/simple/bigbite)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/rawcutlet/xeno = 1,
						/obj/item/natural/hide = 2)
	faction = list("orcs")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 400
	maxHealth = 400
	melee_damage_lower = 35
	melee_damage_upper = 50
	vision_range = 6
	aggro_vision_range = 6
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 14
	STASTR = 16
	STASPD = 9
	STAEND = 14
	deaggroprob = 0
	defprob = 30
	defdrain = 13
	del_on_deaggro = 99 SECONDS
	retreat_health = 0
	food = 0
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')
	dodgetime = 15
	aggressive = 1
//	stat_attack = UNCONSCIOUS

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/death(gibbed)
	..()
	update_icon()

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/troll/aggro1.ogg','sound/vo/mobs/troll/aggro2.ogg')
		if("pain")
			return pick('sound/vo/mobs/troll/pain1.ogg','sound/vo/mobs/troll/pain2.ogg')
		if("death")
			return pick('sound/vo/mobs/troll/death.ogg')
		if("idle")
			return pick('sound/vo/mobs/troll/idle1.ogg','sound/vo/mobs/troll/idle2.ogg')
		if("cidle")
			return pick('sound/vo/mobs/troll/cidle1.ogg','sound/vo/mobs/troll/aggro2.ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/find_food()
	. = ..()
	if(!.)
		return eat_bodies()

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

/datum/intent/simple/bigbite
	name = "big bite"
	icon_state = "instrike"
	attack_verb = list("gnashes", "viciously bites")
	animname = "blank22"
	blade_class = BCLASS_CHOP
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 20
	swingdelay = 1
	candodge = TRUE
	canparry = TRUE

// Future farm content I guess
/obj/item/reagent_containers/food/snacks/grown/nettle
/obj/item/reagent_containers/food/snacks/grown/garlic
/obj/item/seeds/garlic
/obj/item/seeds/onion
/obj/item/seeds/cabbage
/obj/item/seeds/sunflower

///mob/living/simple_animal/hostile/retaliate/rogue/trufflepig // was removed

// Replaced with dummy
/obj/structure/mannequin/male

// ???
/obj/item/clothing/suit/roguetown/shirt/robe/feld
/obj/item/clothing/neck/roguetown/feld
/obj/item/clothing/mask/rogue/feld
/obj/item/clothing/head/roguetown/roguehood/feld
/obj/item/clothing/gloves/roguetown/leather/feld

