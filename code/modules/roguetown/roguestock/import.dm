/datum/roguestock/import
	import_only = TRUE
	stable_price = TRUE
// Worked Iron standard rates should be 20, worked steel should be 25. Both will be added 5 for transport costs. Everything else should default to stockpile prices and +5 if worked other things can be added to the total costs
/datum/roguestock/import/crackers
	name = "Bin of Rations"
	desc = "Low moisture bread that keeps well."
	item_type = /obj/item/roguebin/crackers
	export_price = 100 //10 mammons per cracker
	importexport_amt = 1

/obj/item/roguebin/crackers/Initialize()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked(src)

/obj/structure/closet/crate/chest/steward
	lockid = "steward"
	locked = TRUE
	masterkey = TRUE

/datum/roguestock/import/vanguard
	name = "Vanguard Equipment Crate"
	desc = "Starting kit for a new Vanguard."
	item_type = /obj/structure/closet/crate/chest/steward/vanguard
	export_price = 50
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/vanguard/Initialize()
	. = ..()
	new /obj/item/clothing/cloak/raincloak/vanguard(src)
	new /obj/item/storage/keyring/bog_guard(src)
	new /obj/item/clothing/suit/roguetown/armor/gambeson(src)
	new /obj/item/rogueweapon/mace/cudgel(src)
	new /obj/item/rope/chain(src)
	
/datum/roguestock/import/townguard
	name = "Watchman Equipment Crate"
	desc = "Starting kit for a new Watchman."
	item_type = /obj/structure/closet/crate/chest/steward/townguard
	export_price = 50
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/townguard/Initialize()
	. = ..()
	new /obj/item/clothing/cloak/stabard/guard(src)
	new /obj/item/storage/keyring/town_watch(src)
	new /obj/item/clothing/suit/roguetown/armor/gambeson(src)
	new /obj/item/rogueweapon/mace/cudgel(src)
	new /obj/item/rope/chain(src)

/datum/roguestock/import/redpotion
	name = "Crate of Health Potions"
	desc = "Red that keeps men alive."
	item_type = /obj/structure/closet/crate/chest/steward/redpotion
	export_price = 100
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/redpotion/Initialize()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)

/datum/roguestock/import/perfume
	name = "Crate of perfumes"
	desc = "To keep the stench away."
	item_type = /obj/structure/closet/crate/chest/steward/perfume
	export_price = 60
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/perfume/Initialize()
	. = ..()
	new /obj/item/perfume/random(src)
	new /obj/item/perfume/random(src)
	new /obj/item/perfume/random(src)
	new /obj/item/perfume/random(src)
	new /obj/item/perfume/random(src)

/datum/roguestock/import/knight
	name = "Knight Equipment Crate"
	desc = "Kit for a Knight."
	item_type = /obj/structure/closet/crate/chest/steward/knight
	export_price = 530 //(15 steel)*35=525 extra keys and gimmicks cost an extra 5 mammons
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/knight/Initialize()
	. = ..()
	new /obj/item/clothing/head/roguetown/helmet/heavy/knight(src)
	new /obj/item/clothing/gloves/roguetown/plate(src)
	new /obj/item/clothing/under/roguetown/platelegs(src)
	new /obj/item/clothing/cloak/tabard/knight/guard(src)
	new /obj/item/clothing/neck/roguetown/bervor(src)
	new /obj/item/clothing/suit/roguetown/armor/chainmail(src)
	new /obj/item/clothing/suit/roguetown/armor/plate/full(src)
	new /obj/item/clothing/shoes/roguetown/armor/steel(src)
	new /obj/item/storage/keyring/knight(src)
	new /obj/item/storage/belt/rogue/leather/steel(src)
	new /obj/item/rogueweapon/sword/long(src)


/datum/roguestock/import/manatarms
	name = "Man at Arms Equipment Crate"
	desc = "Kit for a Man at Arms."
	item_type = /obj/structure/closet/crate/chest/steward/manatarms
	export_price = 335 //(8 steel 1 iron)=305 if iron costs 25 and steel costs 35 +5 for extra gimmicks
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/manatarms/Initialize()
	. = ..()
	new /obj/item/clothing/head/roguetown/helmet/bascinet(src)
	new /obj/item/clothing/under/roguetown/chainlegs(src)
	new /obj/item/clothing/cloak/stabard/surcoat/guard(src)
	new /obj/item/clothing/gloves/roguetown/plate(src)
	new /obj/item/clothing/neck/roguetown/gorget(src)
	new /obj/item/clothing/suit/roguetown/armor/chainmail(src)
	new /obj/item/clothing/suit/roguetown/armor/plate/half(src)
	new /obj/item/clothing/shoes/roguetown/armor/steel(src)
	new /obj/item/storage/keyring/man_at_arms(src)
	new /obj/item/storage/belt/rogue/leather/steel(src)
	new /obj/item/rogueweapon/spear(src)

/datum/roguestock/import/crossbow
	name = "Crossbows Crate"
	desc = "A crate with 3 crossbows with 3 full quivers."
	item_type = /obj/structure/closet/crate/chest/steward/crossbow
	export_price = 405 //each quiver holds 20 bolts which is 4 iron and 4 sticks each and each crossbow is 1 steel so 135 per not including other materials
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/crossbow/Initialize()
	. = ..()
	new /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow(src)
	new /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow(src)
	new /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow(src)
	new /obj/item/ammo_holder/quiver/bolts(src)
	new /obj/item/ammo_holder/quiver/bolts(src)
	new /obj/item/ammo_holder/quiver/bolts(src)

/datum/roguestock/import/saigabuck
	name = "Saigabuck"
	desc = "One Saigabuck tamed with a saddle from a far away land"
	item_type = /mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/tame/saddled/saigabuck
	export_price = 100
	importexport_amt = 1

/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/tame/saddled/saigabuck/Initialize()
	. = ..()
	new /mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/tame/saddled(src)


/datum/roguestock/import/farmequip
	name = "Farm Equipment Crate"
	desc = "A crate with a pitchfork, sickle , hoe and some seeds."
	item_type = /obj/structure/closet/crate/chest/steward/farmequip
	export_price = 75 //not combat related and 3 iron which is 75
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/farmequip/Initialize()
	. = ..()
	new /obj/item/rogueweapon/hoe(src)
	new /obj/item/rogueweapon/pitchfork(src)
	new /obj/item/rogueweapon/sickle(src)
	new /obj/item/seeds/apple(src)
	new /obj/item/seeds/wheat(src)
	new /obj/item/seeds/berryrogue(src)

/datum/roguestock/import/blacksmith
	name = "Smith Crate"
	desc = "Stone, coal , iron ingot, wood bin, bucket with hammer and tongs."
	item_type = /obj/structure/closet/crate/chest/steward/blacksmith
	export_price = 135 //3 iron 8 stones 3 wood and one coal stones cost 4 per, worked iron standard rates should be below 25 for rounding stones wood and coal are all worth 5 each totaling at 135
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/blacksmith/Initialize()
	. = ..()
	new /obj/item/rogueweapon/hammer(src)
	new /obj/item/rogueweapon/tongs(src)
	new /obj/item/natural/stone(src)
	new /obj/item/natural/stone(src)
	new /obj/item/natural/stone(src)
	new /obj/item/natural/stone(src)
	new /obj/item/rogueore/coal(src)
	new /obj/item/rogueore/coal(src)
	new /obj/item/ingot/iron(src)
	new /obj/item/natural/stone(src)
	new /obj/item/natural/stone(src)
	new /obj/item/natural/stone(src)
	new /obj/item/natural/stone(src)
	new /obj/item/roguebin(src)
	new /obj/item/reagent_containers/glass/bucket/wooden(src)















