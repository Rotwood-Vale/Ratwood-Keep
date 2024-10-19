
/datum/crafting_recipe/roguetown/leather
	tools = list(/obj/item/needle)
	structurecraft = /obj/structure/fluff/dryingrack
	skillcraft = /datum/skill/craft/tanning

/datum/crafting_recipe/roguetown/leather/pouch
	name = "leather pouch"
	result = list(/obj/item/storage/belt/rogue/pouch,
				/obj/item/storage/belt/rogue/pouch)
	reqs = list(/obj/item/natural/hide = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 6

/datum/crafting_recipe/roguetown/leather/satchel
	name = "leather satchel"
	result = list(/obj/item/storage/backpack/rogue/satchel,
			/obj/item/storage/backpack/rogue/satchel)
	reqs = list(/obj/item/natural/hide = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 13

/datum/crafting_recipe/roguetown/leather/backpack
	name = "leather backpack"
	result = /obj/item/storage/backpack/rogue/backpack
	reqs = list(/obj/item/natural/hide = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 27

/datum/crafting_recipe/roguetown/leather/waterskin
	name = "waterskin"
	result = /obj/item/reagent_containers/glass/bottle/waterskin
	reqs = list(/obj/item/natural/hide = 1,
				/obj/item/natural/fibers = 2)
	sellprice = 15

/datum/crafting_recipe/roguetown/leather/quiver
	name = "quiver"
	result = /obj/item/quiver
	reqs = list(/obj/item/natural/hide = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 28

/datum/crafting_recipe/roguetown/leather/gloves
	name = "leather gloves"
	result = list(/obj/item/clothing/gloves/roguetown/leather,
	/obj/item/clothing/gloves/roguetown/leather)
	reqs = list(/obj/item/natural/hide = 1)
	sellprice = 6

/datum/crafting_recipe/roguetown/leather/heavygloves
	name = "hide gloves"
	result = /obj/item/clothing/gloves/roguetown/angle
	reqs = list(/obj/item/natural/fur = 1)
	sellprice = 15

/datum/crafting_recipe/roguetown/leather/bracers
	name = "leather bracers"
	result = list(/obj/item/clothing/wrists/roguetown/bracers/leather,
			/obj/item/clothing/wrists/roguetown/bracers/leather)
	reqs = list(/obj/item/natural/hide = 1)
	sellprice = 6

/datum/crafting_recipe/roguetown/leather/pants
	name = "leather trousers"
	result = list(/obj/item/clothing/under/roguetown/trou/leather)
	reqs = list(/obj/item/natural/hide = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/shoes
	name = "leather shoes"
	result = list(/obj/item/clothing/shoes/roguetown/simpleshoes,
				/obj/item/clothing/shoes/roguetown/simpleshoes,
				/obj/item/clothing/shoes/roguetown/simpleshoes)
	reqs = list(/obj/item/natural/hide = 1)
	sellprice = 4

/datum/crafting_recipe/roguetown/leather/boots
	name = "leather boots"
	result = /obj/item/clothing/shoes/roguetown/armor/leather
	reqs = list(/obj/item/natural/hide = 1)
	sellprice = 13

/datum/crafting_recipe/roguetown/leather/helmet
	name = "leather helmet"
	result = /obj/item/clothing/head/roguetown/helmet/leather
	reqs = list(/obj/item/natural/hide = 1)
	sellprice = 13

/datum/crafting_recipe/roguetown/leather/bandana
	name = "leather bandana"
	result = /obj/item/clothing/head/roguetown/helmet/bandana
	reqs = list(/obj/item/natural/hide = 1)
	sellprice = 13

/datum/crafting_recipe/roguetown/leather/tricorn
	name = "leather tricorn"
	result = /obj/item/clothing/head/roguetown/helmet/tricorn
	reqs = list(/obj/item/natural/hide = 1)
	sellprice = 13

/datum/crafting_recipe/roguetown/leather/hood
	name = "leather hood"
	result = /obj/item/clothing/head/roguetown/roguehood
	reqs = list(/obj/item/natural/hide = 1)
	sellprice = 13

/datum/crafting_recipe/roguetown/leather/vest
	name = "leather vest"
	result = /obj/item/clothing/suit/roguetown/armor/leather/vest
	reqs = list(/obj/item/natural/hide = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/armor
	name = "leather armor"
	result = /obj/item/clothing/suit/roguetown/armor/leather
	reqs = list(/obj/item/natural/hide = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/hidearmor
	name = "hide armor"
	result = /obj/item/clothing/suit/roguetown/armor/leather/hide
	reqs = list(/obj/item/natural/hide = 2,
				/obj/item/natural/fur = 1)
	sellprice = 41

/datum/crafting_recipe/roguetown/leather/cloak
	name = "leather cloak"
	result = /obj/item/clothing/cloak/raincloak/brown
	reqs = list(/obj/item/natural/hide = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/apron/blacksmith
	name = "leather apron"
	result = /obj/item/clothing/cloak/apron/blacksmith
	reqs = list(/obj/item/natural/hide = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 27

/datum/crafting_recipe/roguetown/leather/cloakfur
	name = "fur cloak"
	result = /obj/item/clothing/cloak/raincloak/furcloak/crafted
	reqs = list(/obj/item/natural/hide = 2,
				/obj/item/natural/fur = 1)
	sellprice = 31

/datum/crafting_recipe/roguetown/leather/saddle
	name = "saddle"
	result = /obj/item/natural/saddle
	reqs = list(/obj/item/natural/hide = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/whip
	name = "leather whip"
	result = /obj/item/rogueweapon/whip
	reqs = list(/obj/item/natural/hide = 2,/obj/item/natural/stone = 1)
	sellprice = 28

/datum/crafting_recipe/roguetown/leather/drum
	name = "Drum"
	result = /obj/item/rogue/instrument/drum
	reqs = list(/obj/item/natural/hide = 1,/obj/item/grown/log/tree/small = 1)
	sellprice = 5

/datum/crafting_recipe/roguetown/leather/vest/sailor
	name = "leather sea jacket"
	result = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	reqs = list(/obj/item/natural/hide = 2)
	sellprice = 26
