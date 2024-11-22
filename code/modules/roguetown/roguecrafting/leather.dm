
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

/datum/crafting_recipe/roguetown/hunting/quiver
	name = "quiver"
	result = /obj/item/ammo_holder/quiver
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
