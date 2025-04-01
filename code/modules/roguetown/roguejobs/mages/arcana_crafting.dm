/datum/crafting_recipe/roguetown/arcana
	req_table = TRUE
	tools = list()
	skillcraft = /datum/skill/magic/arcane
	subtype_reqs = TRUE
	xpgain = FALSE

/datum/crafting_recipe/roguetown/arcana/amethyst
	name = "amythortz"
	result = /obj/item/roguegem/amethyst
	reqs = list(/obj/item/natural/stone = 1,
				/datum/reagent/medicine/lessermanapot = 15)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/chalk
	name = "chalk"
	result = /obj/item/chalk
	reqs = list(/obj/item/rogueore/cinnabar = 1,
				/datum/reagent/medicine/lessermanapot = 15)
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
/datum/crafting_recipe/roguetown/arcana/nomagiccollar
	name = "mana binding collar"
	result = /obj/item/clothing/neck/roguetown/collar/leather/nomagic
	reqs = list(/obj/item/clothing/neck/roguetown/collar/leather = 1,
				/obj/item/roguegem = 1,
				/obj/item/natural/melded/t2 = 1)
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
	reqs = list(/obj/item/natural/wood/plank = 4,
				/obj/item/natural/leyline = 1,
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
				/obj/item/natural/melded/t1 = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/binding
	name = "binding shackles"
	result = /obj/item/rope/chain/bindingshackles
	reqs = list(/obj/item/rope/chain = 2,
				/obj/item/natural/melded/t1 = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/forge
	name = "infernal forge"
	req_table = FALSE
	result = /obj/machinery/light/rogue/forge/arcane
	reqs = list(/obj/item/natural/moltencore = 1,
				/obj/item/natural/stone = 4)
	skill_level = 3

/datum/crafting_recipe/roguetown/arcana/nullring
	name = "ring of null magic"
	result = /obj/item/clothing/ring/active/nomag
	reqs = list(/obj/item/clothing/ring/gold = 1,
				/obj/item/natural/voidstone = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/arcana/arcanesigil
	name = "arcane sigil"
	result = /obj/item/clothing/ring/arcanesigil
	reqs = list(/obj/item/natural/leyline = 1,
				/obj/item/natural/melded/t4 = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/arcana/meldt1
	name = "arcanic meld"
	result = /obj/item/natural/melded/t1
	reqs = list(/obj/item/natural/infernalash = 1,
				/obj/item/natural/fairydust = 1,
				/obj/item/natural/elementalmote = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/meldt2
	name = "dense arcanic meld"
	result = /obj/item/natural/melded/t2
	reqs = list(/obj/item/natural/hellhoundfang = 1,
				/obj/item/natural/iridescentscale = 1,
				/obj/item/natural/elementalshard = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/meldt3
	name = "sorcerous weave"
	result = /obj/item/natural/melded/t3
	reqs = list(/obj/item/natural/moltencore = 1,
				/obj/item/natural/heartwoodcore = 1,
				/obj/item/natural/elementalfragment = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/meldt4
	name = "magical confluence"
	result = /obj/item/natural/melded/t4
	reqs = list(/obj/item/natural/abyssalflame = 1,
				/obj/item/natural/sylvanessence = 1,
				/obj/item/natural/elementalrelic = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/arcana/meldt5
	name = "arcanic abberation"
	result = /obj/item/natural/melded/t5
	reqs = list(/obj/item/natural/melded/t4 = 1,
				/obj/item/natural/voidstone = 1)
	skill_level = 2

