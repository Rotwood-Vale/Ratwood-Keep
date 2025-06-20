/datum/crafting_recipe/roguetown
	always_available = TRUE
	skillcraft = /datum/skill/craft/crafting


/datum/crafting_recipe/roguetown/tneedle
	name = "thorn sewing needle - (thorn, fiber; NONE)"
	result = /obj/item/needle/thorn
	reqs = list(/obj/item/natural/thorn = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/whet
	name = "whet stone - (2 stones; BEGINNER)"
	result = /obj/item/natural/whet
	reqs = list(/obj/item/natural/stone = 2)
	skill_level = 1

/datum/crafting_recipe/roguetown/cloth5x
	name = "cloth 5x - (10 fibers; NONE)"
	result = list(
				/obj/item/natural/cloth,
				/obj/item/natural/cloth,
				/obj/item/natural/cloth,
				/obj/item/natural/cloth,
				/obj/item/natural/cloth,
				)
	reqs = list(/obj/item/natural/fibers = 10)
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage_simple = "sew"
	verbage = "sews"
	skill_level = 0

/datum/crafting_recipe/roguetown/clothbelt
	name = "cloth belt - (cloth; NONE)"
	result = /obj/item/storage/belt/rogue/leather/cloth
	reqs = list(/obj/item/natural/cloth = 1)
	skill_level = 0
	verbage_simple = "tie"
	verbage = "ties"

/datum/crafting_recipe/roguetown/spoon
	name = "spoon (x3) - (small log; BEGINNER)"
	result = list(/obj/item/kitchen/spoon,
				/obj/item/kitchen/spoon,
				/obj/item/kitchen/spoon)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/forks
	name = "fork (x3) - (small log; BEGINNER)"
	result = list(/obj/item/kitchen/fork,
				/obj/item/kitchen/fork,
				/obj/item/kitchen/fork)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/platter
	name = "plater (x3) - (small log; BEGINNER)"
	result = list(/obj/item/cooking/platter,
				/obj/item/cooking/platter,
				/obj/item/cooking/platter)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/rollingpin
	name = "rollingpin - (small log; BEGINNER)"
	result = /obj/item/kitchen/rollingpin
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/bellcollar
	name = "leather collar with catbell - (catbell, collar; NONE)"
	result = /obj/item/clothing/neck/roguetown/collar/leather/bell
	reqs = list(/obj/item/clothing/neck/roguetown/collar/leather = 1, /obj/item/catbell = 1)
	skill_level = 0
	verbage_simple = "affix"
	verbage = "affixes"

/datum/crafting_recipe/roguetown/bellcollar/cow
	name = "leather collar with cowbell - (cowbell, collar; NONE)"
	result = /obj/item/clothing/neck/roguetown/collar/leather/bell/cow
	reqs = list(/obj/item/clothing/neck/roguetown/collar/leather = 1, /obj/item/catbell/cow = 1)
	skill_level = 0
	verbage_simple = "affix"
	verbage = "affixes"

/datum/crafting_recipe/roguetown/unclothbelt
	name = "untie cloth belt - (cloth belt; NONE)"
	result = /obj/item/natural/cloth
	reqs = list(/obj/item/storage/belt/rogue/leather/cloth = 1)
	skill_level = 0
	verbage_simple = "untie"
	verbage = "unties"

/datum/crafting_recipe/roguetown/ropebelt
	name = "rope belt - (rope; NONE)"
	result = /obj/item/storage/belt/rogue/leather/rope
	reqs = list(/obj/item/rope = 1)
	skill_level = 0
	verbage_simple = "tie"
	verbage = "ties"

/datum/crafting_recipe/roguetown/unropebelt
	name = "untie rope belt - (rope belt; NONE)"
	result = /obj/item/rope
	reqs = list(/obj/item/storage/belt/rogue/leather/rope = 1)
	skill_level = 0
	verbage_simple = "untie"
	verbage = "unties"

/datum/crafting_recipe/roguetown/rope
	name = "rope - (3 fibers; BEGINNER)"
	result = /obj/item/rope
	reqs = list(/obj/item/natural/fibers = 3)
	verbage_simple = "braid"
	verbage = "braids"

/datum/crafting_recipe/roguetown/bowstring
	name = "bowstring - (2 fibers; BEGINNER)"
	result = /obj/item/natural/bowstring
	reqs = list(/obj/item/natural/fibers = 2)
	verbage_simple = "twist"
	verbage = "twists"

/datum/crafting_recipe/roguetown/bowpartial
	name = "unstrung bow - (small log; KNIFE; BEGINNER)"
	result = /obj/item/grown/log/tree/bowpartial
	reqs = list(/obj/item/grown/log/tree/small = 1)
	tools = list(/obj/item/rogueweapon/huntingknife)
	verbage_simple = "carve"
	verbage = "carves"

/datum/crafting_recipe/roguetown/bow
	name = "strung bow - (bowstring, unstrung bow; COMPETENT)"
	result = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	reqs = list(/obj/item/natural/bowstring = 1, /obj/item/grown/log/tree/bowpartial = 1)
	verbage_simple = "string together"
	verbage = "strings together"
	skill_level = 2

/datum/crafting_recipe/roguetown/torch
	name = "torch - (stick, fiber; NONE)"
	result = /obj/item/flashlight/flare/torch
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/candle
	name = "candle (x3) - (2 fat; BEGINNER)"
	result = list(/obj/item/candle/yellow,
				/obj/item/candle/yellow,
				/obj/item/candle/yellow)
	reqs = list(/obj/item/reagent_containers/food/snacks/fat = 2)

/datum/crafting_recipe/roguetown/stoneaxe
	name = "axe (stone) - (small log, stone; BEGINNER)"
	result = /obj/item/rogueweapon/stoneaxe
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/stone = 1)


/datum/crafting_recipe/roguetown/stoneknife
	name = "knife (stone) - (stick, stone; NONE)"
	result = /obj/item/rogueweapon/huntingknife/stoneknife
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/stonespear
	name = "spear (stone) - (staff, stone; COMPETENT)"
	result = /obj/item/rogueweapon/spear/stone
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/natural/stone = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/woodclub
	name = "club (wood) - (small log; BEGINNER)"
	result = /obj/item/rogueweapon/mace/woodclub
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/billhook
	name = "improvised billhook - (sickle, rope, small log; COMPETENT)"
	result = /obj/item/rogueweapon/spear/improvisedbillhook
	reqs = list(/obj/item/rogueweapon/sickle = 1,
				/obj/item/rope = 1,
				/obj/item/grown/log/tree/small = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/goedendag
	name = "goedendag - (small log, rope, hoe; COMPETENT)"
	result = /obj/item/rogueweapon/mace/goden
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/rope = 1,
				/obj/item/rogueweapon/hoe = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/peasantwarflail
	name = "peasant war flail (chain) - (chain, tresher; COMPETENT)"
	result = /obj/item/rogueweapon/thresher/wflail
	reqs = list(/obj/item/rope/chain = 1,
				/obj/item/rogueweapon/thresher = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/woodstaff
	name = "staff (x3) - (log; BEGINNER)"
	result = list(/obj/item/rogueweapon/woodstaff,
				/obj/item/rogueweapon/woodstaff,
				/obj/item/rogueweapon/woodstaff)
	reqs = list(/obj/item/grown/log/tree = 1)

/datum/crafting_recipe/roguetown/woodsword
	name = "sword (wood) (x3) - (small log, fiber; BEGINNER)"
	result = list(/obj/item/rogueweapon/mace/wsword,
				/obj/item/rogueweapon/mace/wsword,
				/obj/item/rogueweapon/mace/wsword)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/woodbucket
	name = "bucket - (small log; BEGINNER)"
	result = /obj/item/reagent_containers/glass/bucket/wooden
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/woodcup
	name = "cups (wood) (x3) - (small log; BEGINNER)"
	result = list(/obj/item/reagent_containers/glass/cup/wooden,
				/obj/item/reagent_containers/glass/cup/wooden,
				/obj/item/reagent_containers/glass/cup/wooden)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/woodtray
	name = "trays (wood) (x2) - (small log; BEGINNER)"
	result = list(/obj/item/storage/bag/tray,
				/obj/item/storage/bag/tray)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/woodbowl
	name = "bowls (wood) (x3) - (small log; BEGINNER)"
	result = list(/obj/item/reagent_containers/glass/bowl,
				/obj/item/reagent_containers/glass/bowl,
				/obj/item/reagent_containers/glass/bowl)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/pot
	name = "pot (stone) - (2 stones; BEGINNER)"
	result = /obj/item/reagent_containers/glass/bucket/pot/stone
	reqs = list(/obj/item/natural/stone = 2)

/datum/crafting_recipe/roguetown/stonearrow
	name = "arrow (stone) - (stick, stone; BEGINNER)"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/stone
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)
	req_table = TRUE

/datum/crafting_recipe/roguetown/stonearrow_five
	name = "stone arrow (x5) - (5 sticks, 5 stones; BEGINNER)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone
				)
	reqs = list(/obj/item/grown/log/tree/stick = 5,
				/obj/item/natural/stone = 5)
	req_table = TRUE

/datum/crafting_recipe/roguetown/poisonarrow
	name = "poisoned arrow - (iron arrow, berry poison; BEGINNER)"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/poison
	reqs = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/iron = 1,
				/datum/reagent/berrypoison = 5
				)
	req_table = TRUE

/datum/crafting_recipe/roguetown/poisonarrow_stone
	name = "poisoned stone arrow - (stone arrow, berry poison; BEGINNER)"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/stone/poison
	reqs = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/stone = 1,
				/datum/reagent/berrypoison = 5
				)
	req_table = TRUE

/*
/datum/crafting_recipe/roguetown/poisonbolt //Coded, but commented out pending balance discussion.
	name = "poisoned bolt"
	result = /obj/item/ammo_casing/caseless/rogue/bolt/poison
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 1,
				/datum/reagent/berrypoison = 5)

	req_table = TRUE
*/
/datum/crafting_recipe/roguetown/poisonarrow_five //Arrows and bolts can be smithed in batches of five. Makes sense for them to be dipped in batches of five, too
	name = "poisoned arrow (x5) - (5 iron arrows, berry poison; BEGINNER)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/poison
				)
	reqs = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/iron = 5,
				/datum/reagent/berrypoison = 25
				)
	req_table = TRUE
/*
/datum/crafting_recipe/roguetown/poisonbolt_five //Coded, but commented out pending balance discussion.
	name = "poisoned bolts (x5)"
	result = list(/obj/item/ammo_casing/caseless/rogue/bolt/poison = 5)
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 5,
				/datum/reagent/berrypoison = 25)

	req_table = TRUE
*/
/datum/crafting_recipe/roguetown/poisonarrow_five_stone
	name = "poisoned stone arrow (x5) - (5 stone arrows, berry poison; BEGINNER)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison
				)
	reqs = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/stone = 5,
				/datum/reagent/berrypoison = 25
				)
	req_table = TRUE

/datum/crafting_recipe/roguetown/sackx5
	name = "sack x5 - (5 cloth, 5 fibers; NONE)"
	result = list(
				/obj/item/storage/roguebag,
				/obj/item/storage/roguebag,
				/obj/item/storage/roguebag,
				/obj/item/storage/roguebag,
				/obj/item/storage/roguebag,
				)
	reqs = list(/obj/item/natural/fibers = 5,
				/obj/item/natural/cloth = 5)
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	req_table = FALSE

/datum/crafting_recipe/roguetown/rucksack
	name = "Rucksack - (rope, sack; NONE)"
	result = /obj/item/storage/backpack/rogue/backpack/rucksack
	reqs = list(/obj/item/rope = 1, /obj/item/storage/roguebag = 1,)
	skill_level = 0
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/bait
	name = "bait - (bag, 2 wheats; BEGINNER)"
	result = /obj/item/bait
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/wheat = 2)
	req_table = TRUE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/sbaita
	name = "sweetbait (apple) - (bag, 2 apples; BEGINNER)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/apple = 2)
	req_table = TRUE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/sbait
	name = "sweetbait (berry) - (bag, 2 berries; BEGINNER)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2)
	req_table = TRUE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/bloodbait
	name = "bloodbait - (bag, 2 meats; BEGINNER)"
	result = /obj/item/bait/bloody
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/rogue/meat = 2)
	req_table = TRUE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/pipe
	name = "smoking pipe - (stick, BEGINNER)"
	result = /obj/item/clothing/mask/cigarette/pipe/crafted
	reqs = list(/obj/item/grown/log/tree/stick = 1)


/obj/item/clothing/mask/cigarette/pipe/crafted
	sellprice = 4

/datum/crafting_recipe/roguetown/rod
	name = "fishing rod - (small log, 2 fibers; BEGINNER)"
	result = /obj/item/fishingrod
	reqs = list(/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 2)

/datum/crafting_recipe/roguetown/fishingcage
	name = "fishing cage - (small log, 2 sticks, COMPETENT)"
	result = /obj/item/fishingcage
	reqs = list(/obj/item/grown/log/tree/small = 1,
		/obj/item/grown/log/tree/stick = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/woodspade
	name = "spade - (small log, stick; BEGINNER)"
	result = /obj/item/rogueweapon/shovel/small
	reqs = list(/obj/item/grown/log/tree/small = 1,
			/obj/item/grown/log/tree/stick = 1)

/datum/crafting_recipe/roguetown/book_crafting_kit
	name = "book crafting kit - (2 cured leather, cloth; NEEDLE; BEGINNER)"
	result = /obj/item/book_crafting_kit
	reqs = list(
			/obj/item/natural/hide/cured = 2,
			/obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle = 1)
	req_table = TRUE

/datum/crafting_recipe/roguetown/woodcross
	name = "amulet (wood) - (2 fibers, 2 sticks; BEGINNER)"
	result = /obj/item/clothing/neck/roguetown/psicross/wood
	reqs = list(/obj/item/natural/fibers = 2,
				/obj/item/grown/log/tree/stick = 2)

/datum/crafting_recipe/roguetown/pearlcross
	name = "amulet (pearls) - (fiber, 3 pearls; COMPETENT)"
	result = /obj/item/clothing/neck/roguetown/psicross/pearl
	reqs = list(/obj/item/natural/fibers = 1,
			/obj/item/pearl = 3)
	skill_level = 2

/datum/crafting_recipe/roguetown/bpearlcross
	name = "amulet (black pearls) - (fiber, 3 black pearls; COMPETENT)"
	result = /obj/item/clothing/neck/roguetown/psicross/bpearl
	reqs = list(/obj/item/natural/fibers = 1,
			/obj/item/pearl/black = 3)
	skill_level = 2

/datum/crafting_recipe/roguetown/shellnecklace
	name = "shell necklace - (fiber, 5 oyster shells; BEGINNER)"
	result = /obj/item/clothing/neck/roguetown/psicross/shell
	reqs = list(/obj/item/oystershell = 5,
			/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/shellbracelet
	name = "shell bracelet - (fiber, 3 oyster shells; BEGINNER)"
	result = /obj/item/clothing/neck/roguetown/psicross/shell/bracelet
	reqs = list(/obj/item/oystershell = 3,
			/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/abyssoramulet
	name = "abyssor amulet - (fiber, black pearl; BEGINNER)"
	result = /obj/item/clothing/neck/roguetown/psicross/abyssor
	reqs = list(/obj/item/natural/fibers = 1,
			/obj/item/pearl/black = 1)

/datum/crafting_recipe/roguetown/mantrap
	name = "mantrap (x2) - (small log, 2 fibers, iron ingot; BEGINNER)"
	result = list(/obj/item/restraints/legcuffs/beartrap,
				/obj/item/restraints/legcuffs/beartrap)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 2,
				/obj/item/ingot/iron = 1)
	req_table = TRUE
	skill_level = 1
	verbage_simple = "put together"
	verbage = "puts together"

/datum/crafting_recipe/roguetown/paperscroll
	name = "scroll of parchment (x5) - (small log, water; DRYING RACK; KNIFE; BEGINNER)"
	result = list(/obj/item/paper/scroll,
				  /obj/item/paper/scroll,
				  /obj/item/paper/scroll,
				  /obj/item/paper/scroll,
				  /obj/item/paper/scroll)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/datum/reagent/water = 50)
	tools = list(/obj/item/rogueweapon/huntingknife = 1)
	structurecraft = /obj/machinery/tanningrack
	skill_level = 1

/datum/crafting_recipe/roguetown/parchment
	name = "paper parchment (x8) - (small log, water; DRYING RACK; KNIFE; BEGINNER)"
	result = list(/obj/item/paper,
				  /obj/item/paper,
				  /obj/item/paper,
				  /obj/item/paper,
				  /obj/item/paper,
				  /obj/item/paper,
				  /obj/item/paper,
				  /obj/item/paper)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/datum/reagent/water = 30)
	tools = list(/obj/item/rogueweapon/huntingknife = 1)
	structurecraft = /obj/machinery/tanningrack
	skill_level = 1


/datum/crafting_recipe/roguetown/briarmask
	name = "briarmask - (4 sticks, 3 fibers; COMPETENT)"
	result = /obj/item/clothing/head/roguetown/dendormask
	reqs = list(/obj/item/grown/log/tree/stick = 4,
				/obj/item/natural/fibers = 3)
	skillcraft = /datum/skill/magic/druidic
	skill_level = 2 // druids & dendor clerics can craft

// Woodcutting recipe

/datum/crafting_recipe/roguetown/lumberjacking
	skillcraft = /datum/skill/labor/lumberjacking
	tools = list(/obj/item/rogueweapon/huntingknife = 1)

/datum/crafting_recipe/roguetown/lumberjacking/cart_upgrade
	name = "upgrade cog - (2 small logs, stone; KNIFE; COMPETENT)"
	result = /obj/item/roguegear/wood/basic
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/stone = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sawedoff
	name = "handgonne - (arquebus rifle; SURGERY SAW; NONE)"
	result = /obj/item/gun/ballistic/firearm/handgonne
	reqs = list(/obj/item/gun/ballistic/firearm/arquebus = 1)
	skill_level = 0
	tools = list(/obj/item/rogueweapon/surgery/saw = 1)


// Blacksmithing Recipes

/datum/crafting_recipe/roguetown/gorget/oring
	name = "ringed gorget - (iron gorget; HAMMER; COMPETENT)"
	skillcraft = /datum/skill/craft/blacksmithing
	reqs = list(/obj/item/clothing/neck/roguetown/gorget = 1)
	result = /obj/item/clothing/neck/roguetown/gorget/oring
	skill_level = 2
	tools = list(/obj/item/rogueweapon/hammer = 1)
	req_table = TRUE

/datum/crafting_recipe/roguetown/gorget/soring
	name = "ringed steel gorget - (steel gorget; HAMMER; COMPETENT)"
	skillcraft = /datum/skill/craft/blacksmithing
	reqs = list(/obj/item/clothing/neck/roguetown/gorget/steel = 1)
	result = /obj/item/clothing/neck/roguetown/gorget/steel/oring
	skill_level = 2
	tools = list(/obj/item/rogueweapon/hammer = 1)
	req_table = TRUE

/datum/crafting_recipe/roguetown/chainleash
	name = "chain leash - (chain; HAMMER; COMPETENT)"
	skillcraft = /datum/skill/craft/blacksmithing
	reqs = list(/obj/item/rope/chain = 1)
	result = /obj/item/leash/chain
	skill_level = 2
	tools = list(/obj/item/rogueweapon/hammer = 1)
	req_table = TRUE

//Siege

/datum/crafting_recipe/roguetown/boulder
	name = "boulder - (5 stones; BEGINNER)"
	result = /obj/item/boulder
	reqs = list(/obj/item/natural/stone = 5)
	always_available = TRUE

//Bombs

/datum/crafting_recipe/roguetown/smokebombefficient
	name = "Smoke bomb (Ash Syrum) (x2) - (iron ingot, syrum of fire; BEGINNER)"
	result = list(/obj/item/smokebomb,
				  /obj/item/smokebomb,)
	reqs = list(/datum/reagent/alch/syrum_ash = 24,
				/obj/item/ingot/iron = 1)
	req_table = TRUE

/datum/crafting_recipe/roguetown/smokebomb
	name = "Smoke bomb (Coal) - (iron ingot, coal; BEGINNER)"
	result = /obj/item/smokebomb
	reqs = list(/obj/item/rogueore/coal = 1,
				/obj/item/ingot/iron = 1)
	req_table = TRUE

//Alchemy and med crafts

/datum/crafting_recipe/roguetown/mortar
	name = "mortar and pestle - (stick, small log; BEGINNER)"
	result = /obj/item/reagent_containers/glass/mortar
	reqs = list(/obj/item/grown/log/tree/stick = 1, /obj/item/grown/log/tree/small = 1,)
	skill_level = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/bandage
	name = "roll of bandages - (3 cloths, ash; COMPETENT)"
	result = /obj/item/natural/bundle/cloth/bandage/full
	reqs = list(/obj/item/natural/cloth = 3, /obj/item/ash = 1,)
	skill_level = 2
	skillcraft = /datum/skill/misc/medicine

/datum/crafting_recipe/roguetown/impsaw
	name = "improvised saw - (fiber, stone, stick; BEGINNER)"
	result = /obj/item/rogueweapon/surgery/saw/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/natural/stone = 1, /obj/item/grown/log/tree/stick = 1,)
	skill_level = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/impretra
	name = "improvised clamp - (fiber, 2 sticks; BEGINNER)"
	result = /obj/item/rogueweapon/surgery/hemostat/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 2,)
	skill_level = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/imphemo
	name = "improvised retractor - (fiber, 2 sticks, BEGINNER)"
	result = /obj/item/rogueweapon/surgery/retractor/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 2,)
	skill_level = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/wickercloak
	name = "wickercloak"
	result = /obj/item/clothing/cloak/wickercloak
	reqs = list(
		/obj/item/natural/dirtclod = 1,
		/obj/item/grown/log/tree/stick = 5,
		/obj/item/natural/fibers = 3,
		)
	skill_level = 0