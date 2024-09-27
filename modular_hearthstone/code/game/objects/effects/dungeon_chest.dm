
/obj/effect/spawner/lootdrop/roguetown/dungeon_chest
	name = "dungeon_chest"
	loot = list(
	/obj/structure/closet/crate/chest/dungeon/generic_item = 6,
	/obj/structure/closet/crate/chest/dungeon/materials = 5,
	/obj/structure/closet/crate/chest/dungeon/armor = 3,
	/obj/structure/closet/crate/chest/dungeon/weapon = 4,
	/obj/structure/closet/crate/chest/dungeon/treasure = 2,
	/obj/structure/closet/crate/chest/dungeon/medicine = 3,
	/obj/structure/closet/crate/chest/dungeon/mimic = 2
	)
	lootcount = 1




/obj/structure/closet/crate/chest/dungeon/generic_item


/obj/structure/closet/crate/chest/dungeon/generic_item/PopulateContents()
	..()
	var/list/loot = list(
		// Materials
		/obj/item/natural/bundle/stick = 50,
		/obj/item/natural/fibers = 50,
		/obj/item/natural/stone = 50,
		/obj/item/rogueore/coal	= 50,
		/obj/item/ingot/iron = 50,
		/obj/item/ingot/steel = 50,
		/obj/item/rogueore/iron = 50,
		/obj/item/natural/bundle/fibers = 50,

		// Clothing
		/obj/item/clothing/cloak/stabard = 15,
		/obj/item/storage/backpack/rogue/satchel = 15,
		/obj/item/clothing/shoes/roguetown/simpleshoes = 15,
		/obj/item/clothing/suit/roguetown/shirt/undershirt/random = 15,
		/obj/item/storage/belt/rogue/leather/cloth = 15,
		/obj/item/clothing/cloak/raincloak/mortus = 15,
		/obj/item/clothing/head/roguetown/armingcap = 15,
		/obj/item/clothing/cloak/apron/waist = 15,
		/obj/item/storage/belt/rogue/leather/rope = 15,
		/obj/item/clothing/under/roguetown/tights/vagrant = 15,
		/obj/item/clothing/gloves/roguetown/leather = 15,
		/obj/item/clothing/shoes/roguetown/boots = 15,
		/obj/item/clothing/shoes/roguetown/boots/leather = 15,

		// Money
		/obj/item/roguecoin/copper = 50,
		/obj/item/roguecoin/silver = 30,
		/obj/item/roguecoin/gold = 20,
		/obj/item/roguecoin/copper/pile = 30,
		/obj/item/roguecoin/silver/pile = 20,
		/obj/item/roguecoin/gold/pile = 5,

		// Garbage and Miscellanous
		/obj/item/rogue/instrument/flute = 30,
		/obj/item/ash = 50,
		/obj/item/shard = 50,
		/obj/item/candle/yellow = 30,
		/obj/item/flashlight/flare/torch = 30,
		/obj/item/reagent_containers/glass/bowl = 40,
		/obj/item/reagent_containers/glass/cup = 40,
		/obj/item/reagent_containers/glass/cup/wooden = 40,
		/obj/item/reagent_containers/glass/cup/steel = 30,
		/obj/item/reagent_containers/glass/cup/golden = 10,
		/obj/item/reagent_containers/glass/cup/skull = 10,
		/obj/item/reagent_containers/glass/bucket/wooden = 30,
		/obj/item/natural/feather = 40,
		/obj/item/paper/scroll = 30,
		/obj/item/rope = 30,
		/obj/item/rope/chain = 30,
		/obj/item/storage/roguebag/crafted = 30,
		/obj/item/clothing/mask/cigarette/pipe = 30,
		/obj/item/paper = 30,
		/obj/item/reagent_containers/glass/bowl = 30,
		/obj/item/storage/bag/tray = 30,

		//medical
		/obj/item/needle = 40,
		/obj/item/natural/cloth = 50,
		/obj/item/natural/bundle/cloth = 30,

		//weapons
		/obj/item/rogueweapon/mace = 20,
		/obj/item/rogueweapon/huntingknife/idagger/steel = 30,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow = 20,
		/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow = 20,
		/obj/item/ammo_casing/caseless/rogue/arrow = 40,
		/obj/item/ammo_casing/caseless/rogue/bolt = 40,
		/obj/item/rogueweapon/mace/woodclub/crafted = 30,
		/obj/item/rogueweapon/mace/cudgel = 20,
		/obj/item/rogueweapon/mace/wsword = 30,
		/obj/item/rogueweapon/huntingknife = 30,
		/obj/item/rogueweapon/huntingknife/stoneknife = 30,
		/obj/item/rogueweapon/halberd = 10,
		/obj/item/rogueweapon/woodstaff = 30,
		/obj/item/rogueweapon/spear = 10,

		// tools
		/obj/item/rogueweapon/shovel = 30,
		/obj/item/rogueweapon/thresher = 30,
		/obj/item/flint = 40,
		/obj/item/rogueweapon/stoneaxe/woodcut = 30,
		/obj/item/rogueweapon/stoneaxe = 30,
		/obj/item/rogueweapon/hammer = 30,
		/obj/item/rogueweapon/tongs = 30,
		/obj/item/rogueweapon/pick = 30,

	)

	var/I = pickweight(loot)
	var/O = pickweight(loot)
	var/E = pickweight(loot)
	var/A = pickweight(loot)
	var/U = pickweight(loot)
	new I(src)
	if(prob(50))
		new I(src)
		if(prob(30))
			new I(src)
	if(prob(70))
		new O(src)
		if(prob(50))
			new O(src)
			if(prob(30))
				new O(src)
	if(prob(60))
		new E(src)
		if(prob(30))
			new E(src)
			if(prob(10))
				new E(src)
	if(prob(60))
		new A(src)
		if(prob(30))
			new A(src)
			if(prob(10))
				new A(src)
	if(prob(30))
		new U(src)
		if(prob(10))
			new U(src)
			if(prob(10))
				new U(src)

/obj/structure/closet/crate/chest/dungeon/armor

/obj/structure/closet/crate/chest/dungeon/armor/PopulateContents()
	..()
	var/list/loot = list(//armor
		/obj/item/clothing/suit/roguetown/armor/leather/studded = 60,
		/obj/item/clothing/suit/roguetown/armor/gambeson = 60,
		/obj/item/clothing/suit/roguetown/armor/chainmail = 40,
		/obj/item/clothing/suit/roguetown/armor/chainmail/iron = 50,
		/obj/item/clothing/suit/roguetown/armor/plate/half/iron = 50,
		/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk = 50,
		/obj/item/clothing/suit/roguetown/armor/plate/half = 30,
		/obj/item/clothing/suit/roguetown/armor/chainmail/bikini = 20,
		/obj/item/clothing/suit/roguetown/armor/carapace = 40,
		/obj/item/clothing/suit/roguetown/armor/plate/ironarmor = 40,
		/obj/item/clothing/suit/roguetown/armor/leather/hide = 55,
		/obj/item/clothing/suit/roguetown/armor/leather/bikini = 50,
		/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini = 45,
		/obj/item/clothing/suit/roguetown/armor/leather/hide/bikini = 45,
		/obj/item/clothing/suit/roguetown/armor/leather/vest= 55,
		/obj/item/clothing/suit/roguetown/armor/hide/bearfur = 30,
		/obj/item/clothing/suit/roguetown/armor/bone/chestplate = 40,

		//helmet
		/obj/item/clothing/head/roguetown/helmet/kettle = 10,
		/obj/item/clothing/head/roguetown/helmet/leather = 20,
		/obj/item/clothing/head/roguetown/helmet/horned = 10,
		/obj/item/clothing/head/roguetown/helmet/skullcap = 50,
		/obj/item/clothing/head/roguetown/helmet/winged = 10,
		/obj/item/clothing/head/roguetown/antlerhood = 35,
		/obj/item/clothing/head/roguetown/roguehood = 40,
		/obj/item/clothing/head/roguetown/roguehood/shalal = 30,
		/obj/item/clothing/head/roguetown/paddedcap = 55,
		/obj/item/clothing/head/roguetown/helmet/bascinet = 20,
		/obj/item/clothing/head/roguetown/helmet/carapacecap = 35,
		/obj/item/clothing/head/roguetown/helmet/carapacehelm = 35,
		/obj/item/clothing/head/roguetown/helmet/leather/bearhead = 25,
		/obj/item/clothing/head/roguetown/helmet/footmanhelmet = 35,
		/obj/item/clothing/head/roguetown/helmet/ironplatehelmet = 50,

		//legs
		/obj/item/clothing/under/roguetown/chainlegs = 20,
		/obj/item/clothing/under/roguetown/chainlegs/iron = 50,
		/obj/item/clothing/under/roguetown/platelegs = 10,
		/obj/item/clothing/under/roguetown/carapacelegs = 35,
		/obj/item/clothing/under/roguetown/chainlegs/skirt = 35,
		/obj/item/clothing/under/roguetown/platelegs/skirt = 35,
		/obj/item/clothing/under/roguetown/carapacelegs/skirt = 50,

		//gloves

		/obj/item/clothing/gloves/roguetown/carapace = 50,
		/obj/item/clothing/gloves/roguetown/chain = 20,
		/obj/item/clothing/gloves/roguetown/leather = 45,
		/obj/item/clothing/gloves/roguetown/chain/iron = 50,
		/obj/item/clothing/gloves/roguetown/plate = 10,
		/obj/item/clothing/gloves/roguetown/footmangauntlets = 25,

		//neck
		/obj/item/clothing/neck/roguetown/chaincoif = 50,
		/obj/item/clothing/neck/roguetown/gorget = 20,
		/obj/item/clothing/neck/roguetown/bervor = 10,

		//feet
		/obj/item/clothing/shoes/roguetown/boots/carapace = 50,
		/obj/item/clothing/shoes/roguetown/boots/armoriron = 55,
		/obj/item/clothing/shoes/roguetown/boots/armor = 50,
		/obj/item/clothing/shoes/roguetown/boots/leather = 55,
		/obj/item/clothing/shoes/roguetown/boots/footmangreaves = 30
		)
	var/I = pickweight(loot)
	var/O = pickweight(loot)
	var/E = pickweight(loot)
	new I(src)
	if(prob(30))
		new I(src)
		if(prob(10))
			new I(src)
	if(prob(70))
		new O(src)
		if(prob(50))
			new O(src)
			if(prob(20))
				new O(src)
	if(prob(30))
		new E(src)
		if(prob(30))
			new E(src)
			if(prob(20))
				new E(src)

/obj/structure/closet/crate/chest/dungeon/weapon

/obj/structure/closet/crate/chest/dungeon/weapon/PopulateContents()
	..()
	var/list/loot = list(//sword
		/obj/item/rogueweapon/sword/iron = 50,
		/obj/item/rogueweapon/sword/iron/short = 50,
		/obj/item/rogueweapon/sword/iron/messer = 30,
		/obj/item/rogueweapon/sword/iron/messer/steel = 20,
		/obj/item/rogueweapon/sword/falchion = 45,
		/obj/item/rogueweapon/sword/sabre = 50,
		/obj/item/rogueweapon/sword/estoc = 35,
		/obj/item/rogueweapon/sword/rapier = 35,
		/obj/item/rogueweapon/sword/cutlass = 50,
		/obj/item/rogueweapon/sword/silver = 30,
		/obj/item/rogueweapon/sword/silver/sabre/elf = 10,

	//axe
		/obj/item/rogueweapon/stoneaxe/battle = 50,

	//blunt
		/obj/item/rogueweapon/mace = 50,
		/obj/item/rogueweapon/mace/cudgel = 30,
		/obj/item/rogueweapon/mace/spiked = 25,

	//knives
		/obj/item/rogueweapon/huntingknife = 35,
		/obj/item/rogueweapon/huntingknife/idagger = 40,
		/obj/item/rogueweapon/huntingknife/idagger/steel = 25,
		/obj/item/rogueweapon/huntingknife/idagger/steel/parrying = 25,
		/obj/item/rogueweapon/huntingknife/idagger/silver = 25,
		/obj/item/rogueweapon/huntingknife/idagger/silver/elvish = 15,


	//polearms
		/obj/item/rogueweapon/spear = 50,
		/obj/item/rogueweapon/spear/billhook = 20,
		/obj/item/rogueweapon/halberd = 10,
		/obj/item/rogueweapon/halberd/bardiche = 10,
		/obj/item/rogueweapon/eaglebeak = 10,
		/obj/item/rogueweapon/eaglebeak/lucerne = 10,

	//ammunition
		/obj/item/quiver/bolts = 30,
		/obj/item/quiver/arrows = 35

	)
	var/I = pickweight(loot)
	var/O = pickweight(loot)
	var/E = pickweight(loot)
	new I(src)
	if(prob(70))
		new I(src)
		if(prob(30))
			new I(src)
	if(prob(70))
		new O(src)
		if(prob(50))
			new O(src)
			if(prob(30))
				new O(src)
	if(prob(60))
		new E(src)
		if(prob(30))
			new E(src)
			if(prob(20))
				new E(src)

/obj/structure/closet/crate/chest/dungeon/materials

/obj/structure/closet/crate/chest/dungeon/materials/PopulateContents()
	..()
	var/list/loot = list(//ingot
		/obj/item/ingot/copper = 50,
		/obj/item/ingot/iron = 30,
		/obj/item/ingot/steel = 20,

		/obj/item/natural/bundle/stick = 20,
		/obj/item/rogueore/coal = 55,
		/obj/item/natural/bundle/fibers = 50,
		/obj/item/natural/bundle/cloth = 50,
		/obj/item/natural/hide = 50,
		/obj/item/natural/fur = 50,
		/obj/item/natural/carapace = 50,
		/obj/item/grown/log/tree/small = 40
		)
	var/I = pickweight(loot)
	var/O = pickweight(loot)
	var/E = pickweight(loot)
	new I(src)
	if(prob(70))
		new I(src)
		if(prob(60))
			new I(src)
	if(prob(80))
		new O(src)
		if(prob(70))
			new O(src)
			if(prob(60))
				new O(src)
	if(prob(70))
		new E(src)
		if(prob(60))
			new E(src)
			if(prob(50))
				new E(src)


/obj/structure/closet/crate/chest/dungeon/medicine


/obj/structure/closet/crate/chest/dungeon/medicine/PopulateContents()
	..()
	var/list/loot = list(//ingot
		/obj/item/needle = 30,
		/obj/item/natural/bundle/cloth = 10,

		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 50,
		/obj/item/reagent_containers/glass/bottle/rogue/manapot = 30,
		/obj/item/reagent_containers/glass/bottle/rogue/antipoisonpot = 20,
		/obj/item/reagent_containers/glass/bottle/rogue/poison = 10,
		/obj/item/reagent_containers/glass/bottle/rogue/wine = 10,
		/obj/item/reagent_containers/glass/bottle/rogue/water = 25
		)

	var/I = pickweight(loot)
	var/O = pickweight(loot)
	var/E = pickweight(loot)
	new I(src)
	if(prob(50))
		new I(src)
		if(prob(20))
			new I(src)
	if(prob(80))
		new O(src)
		if(prob(50))
			new O(src)
			if(prob(20))
				new O(src)
	if(prob(30))
		new E(src)
		if(prob(50))
			new E(src)
			if(prob(20))
				new E(src)


/obj/structure/closet/crate/chest/dungeon/treasure


/obj/structure/closet/crate/chest/dungeon/treasure/PopulateContents()
	..()
	var/list/loot = list(//ingot
		/obj/item/roguegem/random = 50,
		/obj/item/ingot/gold = 10,

		/obj/item/roguecoin/copper/pile = 50,
		/obj/item/roguecoin/silver/pile = 40,
		/obj/item/roguecoin/gold/pile = 25,
		/obj/item/roguestatue/gold = 5,
		/obj/item/roguestatue/steel = 10,
		/obj/item/roguestatue/silver = 15,
		/obj/item/roguestatue/iron = 15,
		/obj/item/roguestatue/gold/loot = 10,

		/obj/item/clothing/ring/dragon_ring = 5,
		/obj/item/clothing/ring/diamonds = 15,
		/obj/item/clothing/ring/quartzs = 15,
		/obj/item/clothing/ring/sapphires = 15,
		/obj/item/clothing/ring/topazs = 15,
		/obj/item/clothing/ring/rubys = 15,
		/obj/item/clothing/ring/emeralds =15,

		/obj/item/clothing/ring/emerald = 15,
		/obj/item/clothing/ring/ruby = 15,
		/obj/item/clothing/ring/topaz = 15,
		/obj/item/clothing/ring/quartz = 15,
		/obj/item/clothing/ring/sapphire = 15,
		/obj/item/clothing/ring/diamond = 15,

		/obj/item/riddleofsteel = 15,
		/obj/item/listenstone = 15,
				)

	var/I = pickweight(loot)
	var/O = pickweight(loot)
	var/E = pickweight(loot)
	var/A = pickweight(loot)

	new I(src)
	if(prob(80))
		new I(src)
		if(prob(60))
			new I(src)
	if(prob(80))
		new O(src)
		if(prob(70))
			new O(src)
			if(prob(60))
				new O(src)
	if(prob(80))
		new E(src)
		if(prob(70))
			new E(src)
			if(prob(60))
				new E(src)
	if(prob(80))
		new A(src)
		if(prob(70))
			new A(src)
			if(prob(60))
				new A(src)







// MIMIC


/obj/structure/closet/crate/chest/dungeon/mimic


/obj/structure/closet/crate/chest/dungeon/mimic/attack_hand(mob/living/user)
	. = ..()
	playsound(src.loc, 'sound/vo/mobs/mimic/surprise.ogg', 100, TRUE)
	visible_message(span_danger("The [src] is a mimic!"))
	new	/mob/living/simple_animal/hostile/rogue/mimic (get_turf(src))
	qdel(src)


// MIMIC DROP


/obj/structure/closet/crate/chest/reward

/obj/structure/closet/crate/chest/reward/PopulateContents()
	..()
	var/list/loot = list(
		/obj/item/clothing/head/roguetown/helmet/heavy/blkknight = 5,
		/obj/item/clothing/cloak/tabard/blkknight = 5,
		/obj/item/clothing/under/roguetown/platelegs/blk = 5,
		/obj/item/clothing/gloves/roguetown/plate/blk = 5,
		/obj/item/clothing/neck/roguetown/blkknight = 5,
		/obj/item/clothing/shoes/roguetown/boots/armor/blkknight = 5,
		/obj/item/clothing/suit/roguetown/armor/plate/blkknight = 5,

		/obj/item/rogueweapon/sword/long/judgement = 10,
		/obj/item/rogueweapon/sword/long/vlord = 10,
		/obj/item/rogueweapon/sword/long/rider = 10,
		/obj/item/rogueweapon/sword/long/marlin = 10,
		/obj/item/rogueweapon/sword/long/exe = 10,
		/obj/item/rogueweapon/sword/long/exe/cloth = 10,
		/obj/item/rogueweapon/whip/antique = 10,
		/obj/item/rogueweapon/mace/steel/morningstar = 15,
		/obj/item/rogueweapon/mace/goden = 15,
		/obj/item/rogueweapon/mace/goden/steel = 15,
		/obj/item/rogueweapon/mace/stunmace = 10,

		/obj/item/clothing/ring/dragon_ring = 5,
		/obj/item/clothing/ring/diamonds = 15,
		/obj/item/clothing/ring/quartzs = 15,
		/obj/item/clothing/ring/sapphires = 15,
		/obj/item/clothing/ring/topazs = 15,
		/obj/item/clothing/ring/rubys = 15,
		/obj/item/clothing/ring/emeralds =15,

		/obj/item/clothing/ring/emerald = 15,
		/obj/item/clothing/ring/ruby = 15,
		/obj/item/clothing/ring/topaz = 15,
		/obj/item/clothing/ring/quartz = 15,
		/obj/item/clothing/ring/sapphire = 15,
		/obj/item/clothing/ring/diamond = 15,

		/obj/item/riddleofsteel = 15,
		/obj/item/listenstone = 15,

		/obj/item/book/granter/spell/blackstone/fireball = 15,
		/obj/item/book/granter/spell/blackstone/greaterfireball = 15,
		/obj/item/book/granter/spell/blackstone/lightning = 15,
		/obj/item/book/granter/spell/blackstone/fetch = 15,
		/obj/item/book/granter/spell/blackstone/blindness = 15,
		/obj/item/book/granter/spell/blackstone/invisibility = 15,
		/obj/item/book/granter/spell/blackstone/sicknessray = 15,
		/obj/item/book/granter/spell/blackstone/bonechill = 15

		)

	var/I = pickweight(loot)
	var/O = pickweight(loot)
	var/E = pickweight(loot)
	var/A = pickweight(loot)
	new I(src)
	if(prob(80))
		new O(src)
	if(prob(60))
		new E(src)
	if(prob(30))
		new A(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	if(prob(50))
		new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
		if(prob(30))
			new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
