/datum/crafting_recipe/roguetown/structure/composter
	name = "composter - (small log; NONE)"
	result = /obj/structure/composter
	reqs = list(/obj/item/grown/log/tree/small = 1)
	verbage_simple = "build"
	verbage = "builds"
	skill_level = 0
	time = 2 SECONDS

/datum/crafting_recipe/roguetown/wheatflour
	name = "flour (wheat) - (wheat; MILLSTONE; NONE)"
	result = /obj/item/reagent_containers/powder/flour
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/wheat = 1)
	structurecraft = /obj/structure/fluff/millstone
	verbage_simple = "mill"
	verbage = "mills"
	skill_level = -2
	time = 3

/datum/crafting_recipe/roguetown/oatflour
	name = "flour (oat) - (oat; MILLSTONE; NONE)"
	result = /obj/item/reagent_containers/powder/flour
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/oat = 1)
	structurecraft = /obj/structure/fluff/millstone
	verbage_simple = "mill"
	verbage = "mills"
	skill_level = -2
	time = 3

/datum/crafting_recipe/roguetown/structure/plough
	name = "plough - (2 small logs, iron ingot; BEGINNER)"
	result = /obj/structure/plough
	reqs = list(/obj/item/grown/log/tree/small = 2, /obj/item/ingot/iron = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	time = 4 SECONDS

/datum/crafting_recipe/roguetown/dryleaf
	name = "dry swampweed - (swamp weed; DRYING RACK; NONE)"
	result = /obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf = 1)
	structurecraft = /obj/machinery/tanningrack
	time = 2 SECONDS
	verbage_simple = "dry"
	verbage = "dries"
	craftsound = null
	skillcraft = null

/datum/crafting_recipe/roguetown/sigsweet
	name = "swampweed zig - (dry weed, paper; NONE)"
	result = /obj/item/clothing/mask/cigarette/rollie/cannabis
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry = 1,
				/obj/item/paper = 1)
	req_table = TRUE
	time = 10 SECONDS
	verbage_simple = "roll"
	verbage = "rolls"
	skill_level = 0

/datum/crafting_recipe/roguetown/dryweed
	name = "dry westleach leaf - (westleach leaf; DRYING RACK; NONE)"
	result = /obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed = 1)
	structurecraft = /obj/machinery/tanningrack
	time = 2 SECONDS
	verbage_simple = "dry"
	verbage = "dries"
	craftsound = null
	skillcraft = null

/datum/crafting_recipe/roguetown/sigdry
	name = "westleach zig - (dry westleach leaf, paper; NONE)"
	result = /obj/item/clothing/mask/cigarette/rollie/nicotine
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry = 1,
				/obj/item/paper = 1)
	req_table = TRUE
	time = 10 SECONDS
	verbage_simple = "roll"
	verbage = "rolls"
	skill_level = 0
