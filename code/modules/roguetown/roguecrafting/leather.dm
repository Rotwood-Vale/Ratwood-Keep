
/datum/crafting_recipe/roguetown/hunting
	tools = list(/obj/item/rogueweapon/huntingknife)
	skillcraft = /datum/skill/craft/hunting

//Survival type crafting belongs here!
//It no longer requires a structure

/datum/crafting_recipe/roguetown/hunting/cloak
	name = "leather cloak - (2 cured leather; COMPETENT)"
	result = /obj/item/clothing/cloak/raincloak/brown
	reqs = list(/obj/item/natural/hide/cured = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/hunting/belt
	name = "leather belt - (cured leather; COMPETENT)"
	result = /obj/item/storage/belt/rogue/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/hunting/gloves
	name = "leather gloves - (cured leather; COMPETENT)"
	result = list(/obj/item/clothing/gloves/roguetown/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/hunting/lcollar
	name = "leather collar - (cured leather; COMPETENT)"
	result = list(/obj/item/clothing/neck/roguetown/collar/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/hunting/lleash
	name = "leather leash - (cured leather; BEGINNER)"
	result = list(/obj/item/leash/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/hunting/bracers
	name = "leather bracers - (cured leather; COMPETENT)"
	result = list(/obj/item/clothing/wrists/roguetown/bracers/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/hunting/pants
	name = "leather trousers - (2 cured leather; COMPETENT)"
	result = list(/obj/item/clothing/under/roguetown/trou/leather)
	reqs = list(/obj/item/natural/hide/cured = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/hunting/boots
	name = "leather boots - (cured leather; PROFICIENT)"
	result = /obj/item/clothing/shoes/roguetown/armor/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/hunting/helmet
	name = "leather helmet - (cured leather; PROFICIENT)"
	result = /obj/item/clothing/head/roguetown/helmet/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/hunting/armor
	name = "leather armor - (2 cured leather; EXPERT)"
	result = /obj/item/clothing/suit/roguetown/armor/leather
	reqs = list(/obj/item/natural/hide/cured = 2)
	skill_level = 4

/datum/crafting_recipe/roguetown/hunting/pouch
	name = "leather pouch - (cured leather; COMPETENT)"
	result = list(/obj/item/storage/belt/rogue/pouch)
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 6
	skill_level = 2

/datum/crafting_recipe/roguetown/hunting/summonerspouch
	name = "summoners pouch - (cured leather; COMPETENT)"
	result = list(/obj/item/storage/magebag)
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 6
	skill_level = 2

/datum/crafting_recipe/roguetown/hunting/satchel
	name = "leather satchel - (2 cured leather, fiber; PROFICIENT)"
	result = list(/obj/item/storage/backpack/rogue/satchel)
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 13
	skill_level = 3

/datum/crafting_recipe/roguetown/hunting/backpack
	name = "leather backpack - (3 cured leather, fiber; PROFICIENT)"
	result = /obj/item/storage/backpack/rogue/backpack
	reqs = list(/obj/item/natural/hide/cured = 3,
				/obj/item/natural/fibers = 1)
	sellprice = 27
	skill_level = 3

/datum/crafting_recipe/roguetown/hunting/waterskin
	name = "waterskin - (cured leather, 2 fibers; PROFICIENT)"
	result = /obj/item/reagent_containers/glass/bottle/waterskin
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 2)
	sellprice = 15
	skill_level = 3

/datum/crafting_recipe/roguetown/hunting/powderflask
	name = "powderflask - (cured leather, 2 fibers, syrum of fire; EXPERT)"
	result = /obj/item/powderflask
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 2,
				/datum/reagent/alch/syrum_ash = 24) //1 brewed ash = 24 syrum
	sellprice = 15
	skill_level = 4

/datum/crafting_recipe/roguetown/hunting/quiver
	name = "quiver - (2 cured leather, 2 fibers; PROFICIENT)"
	result = /obj/item/ammo_holder/quiver
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 28
	skill_level = 3

/datum/crafting_recipe/roguetown/hunting/bulletpouch
	name = "bullet pouch - (2 cured leather, 2 fibers; PROFICIENT)"
	result = /obj/item/ammo_holder/bullet
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 28
	skill_level = 3

/datum/crafting_recipe/roguetown/hunting/bombpouch
	name = "bomb pouch - (2 cured leather, 2 fibers; PROFICIENT)"
	result = /obj/item/ammo_holder/bomb
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 28
	skill_level = 3

/datum/crafting_recipe/roguetown/hunting/saddle
	name = "saddle - (2 cured leather; PROFICIENT)"
	result = /obj/item/natural/saddle
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 26
	skill_level = 3

/datum/crafting_recipe/roguetown/hunting/whip
	name = "leather whip - (2 cured leather, stone; PROFICIENT)"
	result = /obj/item/rogueweapon/whip
	reqs = list(/obj/item/natural/hide/cured = 2,/obj/item/natural/stone = 1)
	sellprice = 28
	skill_level = 3

/datum/crafting_recipe/roguetown/hunting/drum
	name = "Drum - (cured leather, small log; BEGINNER)"
	result = /obj/item/rogue/instrument/drum
	reqs = list(/obj/item/natural/hide/cured = 1,/obj/item/grown/log/tree/small = 1)
	sellprice = 5
	skill_level = 1

/datum/crafting_recipe/roguetown/hunting/bedroll
	name = "bedroll - (2 cured leather, 2 cloths, rope; COMPETENT)"
	result = /obj/item/bedroll
	reqs = list(/obj/item/natural/hide/cured = 2, /obj/item/natural/cloth = 2, /obj/item/rope = 1)
	sellprice = 50
	skill_level = 2
