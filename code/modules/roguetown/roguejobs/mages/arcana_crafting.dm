/datum/crafting_recipe/roguetown/arcana
	req_table = TRUE
	tools = list()
	skillcraft = /datum/skill/magic/arcane
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/arcana/amethyst
	name = "amythortz"
	result = /obj/item/roguegem/amethyst
	reqs = list(/obj/item/natural/stone = 1,
				/datum/reagent/medicine/manapot = 15)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/infernalfeather
	name = "infernal feather"
	result = /obj/item/natural/feather/infernal
	reqs = list(/obj/item/natural/feather = 1,
				/obj/item/natural/infernalash = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/sendingstone
	name = "sending stones"
	result = /obj/item/sendingstonesummoner
	reqs = list(/obj/item/natural/stone = 2,
				/obj/item/roguegem/amethyst = 2,
				/obj/item/natural/melded/t1 = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/voidlamptern
	name = "voidlamptern"
	result = /obj/item/flashlight/flare/torch/lantern/voidlamptern
	reqs = list(/obj/item/flashlight/flare/torch/lantern = 1,
				/obj/item/natural/obsidian = 1,
				/obj/item/natural/melded/t1 = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/nomagicglove
	name = "mana binding gloves"
	result = /obj/item/clothing/gloves/roguetown/nomagic
	reqs = list(/obj/item/clothing/gloves/roguetown/leather = 1,
				/obj/item/roguegem = 1,
				/obj/item/natural/melded/t3 = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/arcana/temporalhourglass
	name = "temporal hourglass"
	result = /obj/item/hourglass/temporal
	reqs = list(/obj/item/clothing/gloves/roguetown/leather = 1,
				/obj/item/roguegem = 1,
				/obj/item/natural/melded/t2 = 1)
	skill_level = 3


/datum/crafting_recipe/roguetown/arcana/shimmeringlens
	name = "shimmering lens"
	result = /obj/item/clothing/ring/active/shimmeringlens
	reqs = list(/obj/item/natural/iridescentscale = 1,
				/obj/item/natural/leyline = 1,
				/obj/item/natural/melded/t2 = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/arcana/mimictrinket
	name = "mimic trinket"
	result = /obj/item/mimictrinket
	reqs = list(/obj/item/natural/wood/plank = 2,
				/obj/item/natural/melded/t2 = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/binding
	name = "binding shackles"
	result = /obj/item/mimictrinket
	reqs = list(/obj/item/rope/chain = 2,
				/obj/item/natural/melded/t2 = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/forge
	name = "infernal forge"
	result = /obj/machinery/light/rogue/forge/arcane
	reqs = list(/obj/item/natural/moltencore = 1,
				/obj/item/natural/stone = 4)
	skill_level = 3
