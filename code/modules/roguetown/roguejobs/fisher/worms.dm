/obj/item
	var/baitchance = 0
	var/list/fishloot = null

/obj/item/natural/worms
	name = "worm"
	desc = "The favorite bait of the courageous fishermen who venture these dark waters."
	icon_state = "worm1"
	throwforce = 10
	baitchance = 75
	color = "#b65f49"
	w_class = WEIGHT_CLASS_TINY
	fishloot = list(/obj/item/trash/applecore = 50,
					/obj/item/trash/pearcore = 25, //Pears, in Rockhill? Perish the thought.
					/obj/item/natural/fibers = 15, //It's pretty hard to hook a fiber.
					/obj/item/grown/log/tree/stick = 2, //Single stick
					/obj/item/reagent_containers/food/snacks/fish/carp = 214,
					/obj/item/reagent_containers/food/snacks/fish/eel = 214,
					/obj/item/reagent_containers/food/snacks/fish/angler = 214,
					/obj/item/reagent_containers/food/snacks/fish/shrimp = 180, //Shrimp man gone. Life bad.
					/obj/item/reagent_containers/food/snacks/fish/clownfish = 214,
					/obj/item/natural/bundle/stick = 15, //Bundle of sticks
					/obj/item/natural/stone = 15, //Hard to catch stones!
					/obj/item/clothing/head/roguetown/helmet/tricorn = 25,
					/obj/item/clothing/head/roguetown/helmet/bandana = 25,
					/obj/item/clothing/head/roguetown/roguehood = 25,
					/obj/item/clothing/under/roguetown/loincloth/brown = 25,
					/obj/item/clothing/shoes/roguetown/sandals = 25,
					/obj/item/clothing/shoes/roguetown/simpleshoes = 25,
					/obj/item/clothing/gloves/roguetown/fingerless = 25,
					/obj/item/clothing/gloves/roguetown/leather = 25,
					/obj/item/clothing/shoes/roguetown/armor/leather = 25,
					/obj/item/reagent_containers/syringe = 1, //These are terrifyingly powerful.
					/obj/item/reagent_containers/glass/cup/wooden = 27,
					/obj/item/ammo_casing/caseless/rogue/arrow = 45,
					/obj/item/roguecoin/copper = 45,
					/obj/item/leash = 15,
					/obj/item/customlock = 35,
					/obj/item/storage/belt/rogue/pouch/coins/poor = 25,
					/obj/item/shard = 1, //Bait is smaller
					/obj/item/natural/feather = 15,
					/obj/item/natural/cloth = 15,
					/obj/item/kitchen/spoon = 1,
					/obj/item/restraints/legcuffs/beartrap = 25,
					/obj/item/roguecoin/silver = 24,
					/obj/item/roguecoin/gold = 24,
					/obj/item/clothing/ring/copper = 55,
					/obj/item/clothing/ring/topazc = 15,
					/obj/item/clothing/ring/emeraldc = 15,
					/obj/item/clothing/ring/sapphirec = 15,
					/obj/item/clothing/ring/silver = 20, //You're more likely to find rings with worms, but they tend to be worth less.
					/obj/item/clothing/ring/topazs = 5,
					/obj/item/clothing/ring/emeralds = 5)
	drop_sound = 'sound/foley/dropsound/food_drop.ogg'
		//Approximate Catch Rates:
		//Very Common: 25.0%
		//Common: Actual = 14.98%
		//Rare: Target = 9.9%
		//Super Rare: 4.95%

/obj/item/natural/worms/grubs //Pretty rare, they keep the old loot table including the super-gacha chance of getting useless bullshit.
	name = "grub"
	desc = "Bait for the desperate, or the daring."
	baitchance = 100
	color = null
	fishloot = list(
		/obj/item/trash/applecore = 625,
		/obj/item/trash/pearcore = 625,
		/obj/item/natural/fibers = 625,
		/obj/item/grown/log/tree/stick = 625,
		/obj/item/reagent_containers/food/snacks/fish/carp = 214,
		/obj/item/reagent_containers/food/snacks/fish/eel = 214,
		/obj/item/reagent_containers/food/snacks/fish/angler = 214,
		/obj/item/reagent_containers/food/snacks/fish/shrimp = 214,
		/obj/item/reagent_containers/food/snacks/fish/clownfish = 214,
		/obj/item/natural/bundle/stick = 214,
		/obj/item/natural/stone = 214,
		/obj/item/clothing/head/roguetown/helmet/tricorn = 45,
		/obj/item/clothing/head/roguetown/helmet/bandana = 45,
		/obj/item/clothing/head/roguetown/roguehood = 45,
		/obj/item/clothing/under/roguetown/loincloth/brown = 45,
		/obj/item/clothing/shoes/roguetown/sandals = 45,
		/obj/item/clothing/shoes/roguetown/simpleshoes = 45,
		/obj/item/clothing/gloves/roguetown/fingerless = 45,
		/obj/item/clothing/gloves/roguetown/leather = 45,
		/obj/item/clothing/shoes/roguetown/armor/leather = 45,
		/obj/item/reagent_containers/syringe = 1,
		/obj/item/reagent_containers/glass/cup/wooden = 45,
		/obj/projectile/bullet/reusable/bolt = 45,
		/obj/item/ammo_casing/caseless/rogue/arrow = 45,
		/obj/item/roguecoin/copper = 45,
		/obj/item/leash = 45,
		/obj/item/customlock = 45,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 45,
		/obj/item/shard = 45,
		/obj/item/natural/feather = 45,
		/obj/item/natural/cloth = 45,
		/obj/item/kitchen/spoon = 45,
		/obj/item/restraints/legcuffs/beartrap = 45,
		/obj/item/roguecoin/silver = 24,
		/obj/item/roguecoin/gold = 24,
		/obj/item/clothing/ring/copper = 25,
		/obj/item/clothing/ring/topazc = 3,
		/obj/item/clothing/ring/emeraldc = 2,
		/obj/item/clothing/ring/sapphirec = 2,
		/obj/item/clothing/ring/silver = 15,
		/obj/item/clothing/ring/topazs = 2,
		/obj/item/clothing/ring/emeralds = 2)

	drop_sound = 'sound/foley/dropsound/food_drop.ogg'
		//Approximate Catch Rates:
		//Very Common: 25.0%
		//Common: Actual = 14.98%
		//Rare: Target = 9.9%
		//Super Rare: 4.95%
