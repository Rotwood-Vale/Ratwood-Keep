
/datum/crafting_recipe/roguetown/hunting
	tools = list(/obj/item/rogueweapon/huntingknife)
	skillcraft = /datum/skill/craft/hunting

//Survival type crafting belongs here!
//It no longer requires a structure

/datum/crafting_recipe/roguetown/hunting/cloak
	name = "leather cloak"
	result = /obj/item/clothing/cloak/raincloak/brown
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/hunting/belt
	name = "leather belt"
	result = /obj/item/storage/belt/rogue/leather
	reqs = list(/obj/item/natural/hide/cured = 1)

/datum/crafting_recipe/roguetown/hunting/gloves
	name = "leather gloves"
	result = list(/obj/item/clothing/gloves/roguetown/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)

/datum/crafting_recipe/roguetown/hunting/lcollar
	name = "leather collar"
	result = list(/obj/item/clothing/neck/roguetown/collar/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)

/datum/crafting_recipe/roguetown/hunting/lleash
	name = "leather leash"
	result = list(/obj/item/leash/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)

/datum/crafting_recipe/roguetown/hunting/bracers
	name = "leather bracers"
	result = list(/obj/item/clothing/wrists/roguetown/bracers/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)

/datum/crafting_recipe/roguetown/hunting/pants
	name = "leather trousers"
	result = list(/obj/item/clothing/under/roguetown/trou/leather)
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/hunting/boots
	name = "leather boots"
	result = /obj/item/clothing/shoes/roguetown/armor/leather
	reqs = list(/obj/item/natural/hide/cured = 1)

/datum/crafting_recipe/roguetown/hunting/helmet
	name = "leather helmet"
	result = /obj/item/clothing/head/roguetown/helmet/leather
	reqs = list(/obj/item/natural/hide/cured = 1)

/datum/crafting_recipe/roguetown/hunting/armor
	name = "leather armor"
	result = /obj/item/clothing/suit/roguetown/armor/leather
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/hunting/pouch
	name = "leather pouch"
	result = list(/obj/item/storage/belt/rogue/pouch)
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 6

/datum/crafting_recipe/roguetown/hunting/summonerspouch
	name = "summoners pouch"
	result = list(/obj/item/storage/magebag)
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 6

/datum/crafting_recipe/roguetown/hunting/satchel
	name = "leather satchel"
	result = list(/obj/item/storage/backpack/rogue/satchel)
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 13

/datum/crafting_recipe/roguetown/hunting/backpack
	name = "leather backpack"
	result = /obj/item/storage/backpack/rogue/backpack
	reqs = list(/obj/item/natural/hide/cured = 3,
				/obj/item/natural/fibers = 1)
	sellprice = 27

/datum/crafting_recipe/roguetown/hunting/waterskin
	name = "waterskin"
	result = /obj/item/reagent_containers/glass/bottle/waterskin
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 2)
	sellprice = 15

/datum/crafting_recipe/roguetown/hunting/powderflask
	name = "powderflask"
	result = /obj/item/powderflask
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 2,
				/datum/reagent/alch/syrum_ash = 15)
	sellprice = 15

/datum/crafting_recipe/roguetown/hunting/quiver
	name = "quiver"
	result = /obj/item/ammo_holder/quiver
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 28

/datum/crafting_recipe/roguetown/hunting/bulletpouch
	name = "bullet pouch"
	result = /obj/item/ammo_holder/bullet
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 28

/datum/crafting_recipe/roguetown/hunting/bombpouch
	name = "bomb pouch"
	result = /obj/item/ammo_holder/bomb
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 28
/datum/crafting_recipe/roguetown/hunting/saddle
	name = "saddle"
	result = /obj/item/natural/saddle
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/hunting/whip
	name = "leather whip"
	result = /obj/item/rogueweapon/whip
	reqs = list(/obj/item/natural/hide/cured = 2,/obj/item/natural/stone = 1)
	sellprice = 28

/datum/crafting_recipe/roguetown/hunting/drum
	name = "Drum"
	result = /obj/item/rogue/instrument/drum
	reqs = list(/obj/item/natural/hide/cured = 1,/obj/item/grown/log/tree/small = 1)
	sellprice = 5

/datum/crafting_recipe/roguetown/hunting/bedroll
	name = "bedroll"
	result = /obj/item/bedroll
	reqs = list(/obj/item/natural/hide/cured = 2, /obj/item/natural/cloth = 2, /obj/item/rope = 1)
	sellprice = 50

/datum/crafting_recipe/roguetown/hunting/wickercloak
	name = "wicker cloak"
	result = /obj/item/clothing/cloak/wickercloak
	reqs = list(/obj/item/natural/fibers = 3,
				/obj/item/grown/log/tree/stick = 2)
	sellprice = 5

/datum/crafting_recipe/roguetown/hunting/tribalcloak
	name = "tribal cloak"
	result = /obj/item/clothing/cloak/tribal
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 8

/datum/crafting_recipe/roguetown/hunting/volfmantle
	name = "volf mantle"
	result = /obj/item/clothing/cloak/volfmantle
	reqs = list(/obj/item/natural/fur = 2,
				/obj/item/natural/hide/cured = 1)
	sellprice = 15

/datum/crafting_recipe/roguetown/hunting/volfhelm
	name = "volf helm"
	result = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	sellprice = 20



/datum/crafting_recipe/roguetown/hunting/bowstring
	name = "bowstring"
	result = /obj/item/natural/bowstring
	reqs = list(/obj/item/natural/fibers = 2)
	sellprice = 3

/datum/crafting_recipe/roguetown/hunting/bowpartial
	name = "unstrung bow"
	result = /obj/item/grown/log/tree/bowpartial
	reqs = list(/obj/item/grown/log/tree/small = 1)
	tools = list(/obj/item/rogueweapon/huntingknife)
	sellprice = 8

/datum/crafting_recipe/roguetown/hunting/bow
	name = "strung bow"
	result = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	reqs = list(/obj/item/natural/bowstring = 1, 
				/obj/item/grown/log/tree/bowpartial = 1)
	sellprice = 15

/datum/crafting_recipe/roguetown/hunting/stonearrow
	name = "stone arrow"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/stone
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)
	sellprice = 1

/datum/crafting_recipe/roguetown/hunting/stonearrow_five
	name = "stone arrows (x5)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone
				)
	reqs = list(/obj/item/grown/log/tree/stick = 5,
				/obj/item/natural/stone = 5)
	sellprice = 5

/datum/crafting_recipe/roguetown/hunting/bait
	name = "bait"
	result = /obj/item/bait
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/wheat = 2)
	sellprice = 2

/datum/crafting_recipe/roguetown/hunting/sweetbait
	name = "sweetbait (berry)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2)
	sellprice = 3

/datum/crafting_recipe/roguetown/hunting/bloodbait
	name = "bloodbait"
	result = /obj/item/bait/bloody
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/rogue/meat = 2)
	sellprice = 4

/datum/crafting_recipe/roguetown/hunting/torch
	name = "torch"
	result = /obj/item/flashlight/flare/torch
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 2

/datum/crafting_recipe/roguetown/hunting/tneedle
	name = "thorn sewing needle"
	result = /obj/item/needle/thorn
	reqs = list(/obj/item/natural/thorn = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 2

/datum/crafting_recipe/roguetown/hunting/whet
	name = "whet stone"
	result = /obj/item/natural/whet
	reqs = list(/obj/item/natural/stone = 2)
	sellprice = 3

