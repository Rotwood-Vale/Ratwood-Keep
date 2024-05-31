/datum/crafting_recipe/roguetown
	always_availible = TRUE
	skillcraft = /datum/skill/craft/crafting


/datum/crafting_recipe/roguetown/tneedle
	name = "sewing needle"
	result = /obj/item/needle/thorn
	reqs = list(/obj/item/natural/thorn = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/cloth
	name = "cloth"
	result = /obj/item/natural/cloth
	reqs = list(/obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage_simple = "sew"
	verbage = "sews"
	craftdiff = 0

/datum/crafting_recipe/roguetown/clothbelt
	name = "cloth belt"
	result = /obj/item/storage/belt/rogue/leather/cloth
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0
	verbage_simple = "tie"
	verbage = "ties"

/datum/crafting_recipe/roguetown/rope
	name = "rope"
	result = /obj/item/rope
	reqs = list(/obj/item/natural/fibers = 3)
	verbage_simple = "braid"
	verbage = "braids"

/datum/crafting_recipe/roguetown/bowstring
	name = "fiber bowstring"
	result = /obj/item/natural/bowstring
	reqs = list(/obj/item/natural/fibers = 2)
	verbage_simple = "twist"
	verbage = "twists"

/datum/crafting_recipe/roguetown/bowpartial
	name = "unstrung bow"
	result = /obj/item/grown/log/tree/bowpartial
	reqs = list(/obj/item/grown/log/tree/small = 1)
	tools = /obj/item/rogueweapon/huntingknife
	verbage_simple = "carve"
	verbage = "carves"
	craftdiff = 2

/datum/crafting_recipe/roguetown/bow
	name = "wooden bow"
	result = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	reqs = list(/obj/item/natural/bowstring = 1, /obj/item/grown/log/tree/bowpartial = 1)
	skillcraft = /datum/skill/combat/bows
	verbage_simple = "string together"
	verbage = "strings together"
	craftdiff = 2

/datum/crafting_recipe/roguetown/torch
	name = "torch"
	result = /obj/item/flashlight/flare/torch
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/candle
	name = "candle"
	result = /obj/item/candle/yellow
	reqs = list(/obj/item/reagent_containers/food/snacks/fat = 2)

/datum/crafting_recipe/roguetown/stoneaxe
	name = "stone axe"
	result = /obj/item/rogueweapon/stoneaxe
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/stone = 1)


/datum/crafting_recipe/roguetown/stoneknife
	name = "stone knife"
	result = /obj/item/rogueweapon/huntingknife/stoneknife
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/stonespear
	name = "stone spear"
	result = /obj/item/rogueweapon/spear/stone
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/natural/stone = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/woodclub
	name = "wood club"
	result = /obj/item/rogueweapon/mace/woodclub/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/billhook
	name = "improvised billhook"
	result = /obj/item/rogueweapon/spear/improvisedbillhook
	reqs = list(/obj/item/rogueweapon/sickle = 1,
				/obj/item/grown/log/tree/small = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	craftdiff = 3

/datum/crafting_recipe/roguetown/goedendag
	name = "goedendag"
	result = /obj/item/rogueweapon/mace/goden
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/rogueweapon/hoe = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	craftdiff = 3

/datum/crafting_recipe/roguetown/peasantwarflail
	name = "peasant war flail"
	result = /obj/item/rogueweapon/flail/peasantwarflail
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/rogueweapon/thresher = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	craftdiff = 3

/datum/crafting_recipe/roguetown/rproesthetic
	name = "wood arm (L)"
	result = list(/obj/item/bodypart/l_arm/rproesthetic)
	reqs = list(/obj/item/grown/log/tree/small = 1,
	/obj/item/roguegear = 1)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 3

/datum/crafting_recipe/roguetown/rproesthetic
	name = "wood arm (R)"
	result = list(/obj/item/bodypart/r_arm/rproesthetic)
	reqs = list(/obj/item/grown/log/tree/small = 1,
	/obj/item/roguegear = 1)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 3

/obj/item/rogueweapon/mace/woodclub/crafted
	sellprice = 8

/datum/crafting_recipe/roguetown/woodstaff
	name = "wood staff"
	result = list(/obj/item/rogueweapon/woodstaff,
	/obj/item/rogueweapon/woodstaff,
	/obj/item/rogueweapon/woodstaff)
	reqs = list(/obj/item/grown/log/tree = 1)

/datum/crafting_recipe/roguetown/woodsword
	name = "wood sword"
	result = list(/obj/item/rogueweapon/mace/wsword,
					/obj/item/rogueweapon/mace/wsword)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/woodshield
	name = "wooden shield"
	result = /obj/item/rogueweapon/shield/wood/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/hide = 1)
	skillcraft = /datum/skill/craft/carpentry


/obj/item/rogueweapon/shield/wood/crafted
	sellprice = 6

/datum/crafting_recipe/roguetown/woodbucket
	name = "wooden bucket"
	result = /obj/item/reagent_containers/glass/bucket/wooden
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/woodcup
	name = "wooden cups"
	result = list(/obj/item/reagent_containers/glass/cup/wooden/crafted,
				/obj/item/reagent_containers/glass/cup/wooden/crafted,
				/obj/item/reagent_containers/glass/cup/wooden/crafted)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/obj/item/reagent_containers/glass/cup/wooden/crafted
	sellprice = 3

/datum/crafting_recipe/roguetown/stonearrow
	name = "stone arrow"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/stone
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)

	req_table = TRUE

/datum/crafting_recipe/roguetown/bag
	name = "bag"
	result = /obj/item/storage/roguebag/crafted
	reqs = list(/obj/item/natural/fibers = 1,
				/obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	req_table = TRUE

/obj/item/storage/roguebag/crafted
	sellprice = 4


/datum/crafting_recipe/roguetown/bait
	name = "bait"
	result = /obj/item/bait
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/wheat = 2)
	req_table = TRUE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/sbaita
	name = "sweetbait (apple)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/apple = 2)
	req_table = TRUE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/sbait
	name = "sweetbait (berry)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2)
	req_table = TRUE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/bloodbait
	name = "bloodbait"
	result = /obj/item/bait/bloody
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/rogue/meat = 2)
	req_table = TRUE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/pipe
	name = "wood pipe"
	result = /obj/item/clothing/mask/cigarette/pipe/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1)


/obj/item/clothing/mask/cigarette/pipe/crafted
	sellprice = 6

/datum/crafting_recipe/roguetown/rod
	name = "fishing rod"
	result = /obj/item/fishingrod/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 2)


/obj/item/fishingrod/crafted
	sellprice = 8

/datum/crafting_recipe/roguetown/woodspade
	name = "wood spade"
	result = /obj/item/rogueweapon/shovel/small
	reqs = list(/obj/item/grown/log/tree/small = 1,
			/obj/item/grown/log/tree/stick = 1)
/obj/item/rogueweapon/shovel/small/crafted
	sellprice = 5

/datum/crafting_recipe/roguetown/book_crafting_kit
	name = "book crafting kit"
	result = /obj/item/book_crafting_kit
	reqs = list(
			/obj/item/natural/hide = 2,
			/obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle = 1)
	req_table = TRUE

/datum/crafting_recipe/roguetown/woodcross
	name = "wooden amulet"
	result = /obj/item/clothing/neck/roguetown/psicross/wood
	reqs = list(/obj/item/natural/fibers = 2,
				/obj/item/grown/log/tree/stick = 2)

/datum/crafting_recipe/roguetown/mantrap
	name = "mantrap"
	result = list(/obj/item/restraints/legcuffs/beartrap,
				/obj/item/restraints/legcuffs/beartrap)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 2,
				/obj/item/ingot/iron = 1)
	req_table = TRUE
	skillcraft = /datum/skill/craft/traps
	craftdiff = 1
	verbage = "put together"
