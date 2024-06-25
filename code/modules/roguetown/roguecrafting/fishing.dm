/datum/crafting_recipe/roguetown/fishing
	req_table = TRUE

/datum/crafting_recipe/roguetown/fishing/bait
	verbage_simple = "roll"
	verbage = "rolls"

/datum/crafting_recipe/roguetown/fishing/bait/red
	name = "red bait"
	result = list(/obj/item/fishing/bait/meat,
					/obj/item/fishing/bait/meat,
					/obj/item/fishing/bait/meat)
	reqs = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish = 1)

/datum/crafting_recipe/roguetown/fishing/bait/dough
	name = "doughy bait"
	result = list(/obj/item/fishing/bait/dough,
					/obj/item/fishing/bait/dough,
					/obj/item/fishing/bait/dough)
	reqs = list(/obj/item/reagent_containers/powder/flour = 1)

/datum/crafting_recipe/roguetown/fishing/bait/gray
	name = "gray bait"
	result = list(/obj/item/fishing/bait/gray,
					/obj/item/fishing/bait/gray,
					/obj/item/fishing/bait/gray,
					/obj/item/fishing/bait/gray,
					/obj/item/fishing/bait/gray)
	reqs = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish = 1,
					/obj/item/reagent_containers/powder/flour = 1)

/datum/crafting_recipe/roguetown/fishing/bait/speckled
	name = "speckled bait"
	result = list(/obj/item/fishing/bait/speckled,
					/obj/item/fishing/bait/speckled,
					/obj/item/fishing/bait/speckled)
	reqs = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish = 1, 
					/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1, 
					/obj/item/reagent_containers/powder/flour = 1)

/datum/crafting_recipe/roguetown/fishing/reel
	verbage_simple = "weave"
	verbage = "weaves"

/datum/crafting_recipe/roguetown/fishing/reel/twine
	name = "twine fishing line"
	result = list(/obj/item/fishing/reel/twine)
	reqs = list(/obj/item/natural/fibers = 2)

/datum/crafting_recipe/roguetown/fishing/reel/leather
	name = "leather fishing line"
	result = list(/obj/item/fishing/reel/leather)
	reqs = list(/obj/item/natural/hide = 1)

/datum/crafting_recipe/roguetown/fishing/reel/silk
	name = "silk fishing line"
	result = list(/obj/item/fishing/reel/silk)
	reqs = list(/obj/item/natural/silk = 1)

/datum/crafting_recipe/roguetown/fishing/woodenhook
	name = "wooden fishing hook"
	result = list(/obj/item/fishing/hook/wooden)
	reqs = list(/obj/item/grown/log/tree/stick = 1)

/datum/crafting_recipe/roguetown/fishing/thornhook
	name = "thorn fishing hook"
	result = list(/obj/item/fishing/hook/thorn)
	reqs = list(/obj/item/natural/thorn = 1)

/datum/crafting_recipe/roguetown/fishing/woodenbobber
	name = "wooden bobber"
	result = list(/obj/item/fishing/line/bobber)
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 1)

/datum/crafting_recipe/roguetown/fishing/stonesinker
	name = "stone sinker"
	result = list(/obj/item/fishing/line/sinker)
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/natural/stone = 1)
