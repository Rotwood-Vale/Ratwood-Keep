/// potions and tinctures

/datum/crafting_recipe/roguetown/alchemy
	req_table = FALSE
	verbage_simple = "mix"
	skillcraft = /datum/skill/misc/alchemy
	subtype_reqs = TRUE
	structurecraft = /obj/structure/fluff/alch

/datum/crafting_recipe/roguetown/alchemy/bbomb
	name = "Bottle bomb"
	result = list(/obj/item/bomb)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 2, /obj/item/rogueore/coal = 1, /obj/item/natural/cloth = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/manna_pot
	name = "Manna Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1, 
		/obj/item/reagent_containers/powder/sublimate = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/manna_pot_3x
	name = "3x Manna Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot,/obj/item/reagent_containers/glass/bottle/rogue/manapot,/obj/item/reagent_containers/glass/bottle/rogue/manapot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/powder/sublimate = 3,
		/obj/item/reagent_containers/food/snacks/fish/eel = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/minorhealthpot
	name = "Minor Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/minorhealthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1,
		/obj/item/natural/worms/leech = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/minorhealthpot3x
	name = "3x Minor Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/minorhealthpot,/obj/item/reagent_containers/glass/bottle/rogue/minorhealthpot,/obj/item/reagent_containers/glass/bottle/rogue/minorhealthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2,
		/obj/item/natural/worms/leech = 2)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/healthpot
	name = "Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1,
		/obj/item/reagent_containers/food/snacks/fish = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/healthpot3x
	name = "3x Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot,/obj/item/reagent_containers/glass/bottle/rogue/healthpot,/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2,
		/obj/item/reagent_containers/food/snacks/fish = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/majorhealthpot
	name = "Major Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/majorhealthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/powder/sublimate = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 2,
		/obj/item/reagent_containers/food/snacks/fish/clownfish = 1,
		/obj/item/natural/bone = 2)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/majorhealthpot3x
	name = "3x Major Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/majorhealthpot,/obj/item/reagent_containers/glass/bottle/rogue/majorhealthpot,/obj/item/reagent_containers/glass/bottle/rogue/majorhealthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/powder/sublimate = 2,
		/obj/item/reagent_containers/food/snacks/grown/apple = 4,
		/obj/item/reagent_containers/food/snacks/fish/clownfish = 2,
		/obj/item/natural/bone = 4)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/antipoison_pot
	name = "Anti Poison Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/antipoisonpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1, 
		/obj/item/reagent_containers/powder/sublimate = 1, 
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/antipoison_pot_3x
	name = "3x Anti Poison Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/antipoisonpot,/obj/item/reagent_containers/glass/bottle/rogue/antipoisonpot,/obj/item/reagent_containers/glass/bottle/rogue/antipoisonpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3, 
		/obj/item/reagent_containers/powder/sublimate = 3, 
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison = 2)
	craftdiff = 1



/// bottle craft


/datum/crafting_recipe/roguetown/alchemy/glassbottles
	name = "2x glass bottles"
	result = list(/obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/bottle)
	reqs = list(
		/obj/item/natural/stone = 1, 
		/obj/item/natural/dirtclod = 1)
	craftdiff = 1
	verbage_simple = "forge"

/// transmutation

/datum/crafting_recipe/roguetown/alchemy/distill
	name = "distill water"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/water = 1)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1, 
		/datum/reagent/water = 99) // 45 and 90 u allows for bottle duping. This requires 33oz containers, preventing the dupe.
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/w2m
	name = "transmute water to milk"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/milk = 1)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1, 
		/datum/reagent/water = 99) // 45 and 90 u allows for bottle duping. This requires 33oz containers, preventing the dupe.
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/w2w
	name = "transmute water to wine" /// eat your heart out god.
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/wine = 1)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1, 
		/datum/reagent/water = 99) // 45 and 90 u allows for bottle duping. This requires 33oz containers, preventing the dupe.
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/g2wes
	name = "transmute grain to westleach"
	result = list(/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/wheat = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/w2swa
	name = "transmute westleach to swampweed"
	result = list(/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/f2gra
	name = "transmute fiber to grain"
	result = list(/obj/item/reagent_containers/food/snacks/grown/wheat = 1)
	reqs = list(/obj/item/natural/fibers = 4)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/b2app
	name = "transmute berry to apple"
	result = list(/obj/item/reagent_containers/food/snacks/grown/apple = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/s2coa
	name = "transmute stone to coal"
	result = list(/obj/item/rogueore/coal = 1)
	reqs = list(/obj/item/natural/stone = 4)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/c2irn
	name = "transmute coal to iron"
	result = list(/obj/item/rogueore/iron = 1)
	reqs = list(/obj/item/rogueore/coal = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/i2gol
	name = "transmute iron to gold"
	result = list(/obj/item/rogueore/gold = 1)
	reqs = list(/obj/item/rogueore/iron = 4)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/i2top // Keep topers and their trinkets cheap to prevent wealth creep. Cheap means of getting gem dust, for potions.
	name = "transmute iron to toper"
	result = list(/obj/item/roguegem/yellow = 1)
	reqs = list(
		/obj/item/rogueore/iron = 1, 
		/obj/item/natural/stone = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/t2gem
	name = "transmute toper to gemerald"
	result = list(/obj/item/roguegem/green = 1)
	reqs = list(
		/obj/item/roguegem/yellow = 1, 
		/obj/item/rogueore/gold = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/g2saf
	name = "transmute gemerald to saffira"
	result = list(/obj/item/roguegem/violet = 1)
	reqs = list(
		/obj/item/roguegem/green = 1, 
		/obj/item/rogueore/gold = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/s2blo
	name = "transmute saffira to blortz"
	result = list(/obj/item/roguegem/blue = 1)
	reqs = list(
		/obj/item/roguegem/violet = 1, 
		/obj/item/rogueore/gold = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/r2dia
	name = "transmute blortz to dorpel"
	result = list(/obj/item/roguegem/diamond = 1)
	reqs = list(
		/obj/item/roguegem/blue = 2, 
		/obj/item/rogueore/gold = 2)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/d2ros
	name = "transmute dorpels to riddle of steel" /// holy grail requires legendary. (sell price on average is 350. rontz and diamond worth 100 each. you get to legndary you deserve 150-200 profit)
	result = list(/obj/item/riddleofsteel = 1)
	reqs = list(
		/obj/item/roguegem/diamond = 2, 
		/obj/item/rogueore/iron = 1, 
		/obj/item/rogueore/coal = 1)
	craftdiff = 6

/datum/crafting_recipe/roguetown/alchemy/e2s
	name = "transmute steel to silver" // This is gonna be ass to make. Have fun. (2 gold ORE, and 4 steel INGOTs, and 2 seffira)
	result = list(/obj/item/ingot/silver = 1)
	reqs = list(/obj/item/rogueore/gold = 2, /obj/item/ingot/steel = 4, /obj/item/roguegem/violet = 2)
	craftdiff = 6

/datum/crafting_recipe/roguetown/alchemy/moon
	name = "Moondust"
	result = list(/obj/item/reagent_containers/powder/moondust)
	reqs = list(
		/obj/item/ash = 1, 
		/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry = 2) // Probably better to just buy from the merchant.
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/t2sub
	name = "Sublimate Toper Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/toper = 1, 
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/g2sub
	name = "Sublimate Gemerald Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/gemerald = 1, 
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/s2sub
	name = "Sublimate Saffira Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/saffira = 1, 
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/b2sub
	name = "Sublimate Blortz Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/blortz = 1, 
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/r2sub
	name = "Sublimate Rontz Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/rontz = 1, 
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/d2sub
	name = "Sublimate Dorpel Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/dorpel = 1, 
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/m2sub
	name = "Sublimate Malum's Fire"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/mfire = 1, 
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1
