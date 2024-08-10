/datum/anvil_recipe/weapons
	appro_skill = /datum/skill/craft/weaponsmithing  // inheritance yay !!
	craftdiff = 1

/// BASIC IRON WEAPONS
// Craft Difficulty: 1 (Base)

/datum/anvil_recipe/weapons/isword
	name = "Sword"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron
	i_type = "Weapons"

/datum/anvil_recipe/weapons/iswordshort
	name = "Short sword"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron/short
	i_type = "Weapons"

/datum/anvil_recipe/weapons/imesser
	name = "Messer"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron/messer
	i_type = "Weapons"

/datum/anvil_recipe/weapons/idagger
	name = "Dagger"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife/idagger
	i_type = "Weapons"

/datum/anvil_recipe/weapons/iflail
	name = "Flail"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/flail
	i_type = "Weapons"

/datum/anvil_recipe/weapons/hknife
	name = "Hunting knife"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife
	i_type = "Weapons"

/datum/anvil_recipe/weapons/axe
	name = "Axe (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut
	i_type = "Weapons"

/datum/anvil_recipe/weapons/mace
	name = "Mace (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace
	i_type = "Weapons"

/datum/anvil_recipe/weapons/spear
	name = "Spear (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear
	i_type = "Weapons"

/datum/anvil_recipe/weapons/polemace
	name = "Warclub (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden
	i_type = "Weapons"

// Only level 2 diff craft, it's a Halberd but iron.
/datum/anvil_recipe/weapons/bardiche
	name = "Bardiche (+ iron) (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd/bardiche
	craftdiff = 2
	i_type = "Weapons"

/// BASIC STEEL WEAPONS
// Craft Dificulty: 2

/datum/anvil_recipe/weapons/sdagger
	name = "Dagger"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/sdaggerparrying
	name = "Parrying Dagger (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel/parrying
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/sflail
	name = "Flail"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/flail/sflail
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/ssword
	name = "Sword"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/sswordshort
	name = "steel short sword"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/short
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/ssaber
	name = "Sabre"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/sabre
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/srapier
	name = "Rapier"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/rapier
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/scutlass
	name = "Cutlass"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/cutlass
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/cleaver
	name = "Cleaver"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/cleaver
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/falchion
	name = "Falchion"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/falchion
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/saxe
	name = "Axe (+1 Stick)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/steel
	i_type = "Weapons"
	craftdiff = 2

/datum/anvil_recipe/weapons/billhook
	name = "Billhook (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/billhook
	i_type = "Weapons"
	craftdiff = 2

/// ADVANCED WEAPONS
// Craft Difficulty: 3

/datum/anvil_recipe/weapons/tsword
	name = "Bastard Sword (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/baxe
	name = "Battle Axe (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/stoneaxe/battle
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/ccleaver
	name = "Hunting Knife (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/huntingknife/cleaver/combat
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/smace
	name = "Mace (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/mace/steel
	craftdiff = 4
	i_type = "Weapons"

/datum/anvil_recipe/weapons/grandmace
	name = "Grand Mace (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden/steel
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/zweihander
	name = "Zweihander (+2 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron)
	created_item = /obj/item/rogueweapon/greatsword/zwei
	craftdiff = 4
	i_type = "Weapons"

/datum/anvil_recipe/weapons/greatsword
	name = "Greatsword (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/greatsword
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/halbert
	name = "Halberd (+1 Steel) (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/lucerne
	name = "Lucerne (+ iron) (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak/lucerne
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/eaglebeak
	name = "Eagle's Beak (+1 Steel) (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak
	craftdiff = 3
	i_type = "Weapons"

/// SHIELDS
/datum/anvil_recipe/weapons/ironshield
	name = "Tower Shield (+1 Small Log)"
	appro_skill = /datum/skill/craft/armorsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/shield/tower
	craftdiff = 2	//Only because high coverage.
	i_type = "Weapons"

/datum/anvil_recipe/weapons/buckler
	name = "Buckler (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/shield/buckler
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/steelshield
	name = "Heraldic Shield (+1 Steel +1 Hide)"
	appro_skill = /datum/skill/craft/armorsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/hide)
	created_item = /obj/item/rogueweapon/shield/tower/metal
	craftdiff = 4	//Very high coverage + good parry
	i_type = "Weapons"

/// RANGED + AMMO
// Craft Difficulty: 1-2

/datum/anvil_recipe/weapons/xbow
	name = "Crossbow (+1 Small Log) (+1 Fiber)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small, /obj/item/natural/fibers)
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	craftdiff = 2
	i_type = "Weapons"

//No difficulty for bolts and arrows; too commonly needed.
/datum/anvil_recipe/weapons/bolts
	name = "Crossbow Bolts 5x (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = list(/obj/item/ammo_casing/caseless/rogue/bolt, /obj/item/ammo_casing/caseless/rogue/bolt, /obj/item/ammo_casing/caseless/rogue/bolt, /obj/item/ammo_casing/caseless/rogue/bolt, /obj/item/ammo_casing/caseless/rogue/bolt)
	i_type = "Ammo"

/datum/anvil_recipe/weapons/arrows
	name = "Arrows 5x (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = list(/obj/item/ammo_casing/caseless/rogue/arrow,/obj/item/ammo_casing/caseless/rogue/arrow,/obj/item/ammo_casing/caseless/rogue/arrow, /obj/item/ammo_casing/caseless/rogue/arrow, /obj/item/ammo_casing/caseless/rogue/arrow)
	i_type = "Ammo"

/// SPECIALTY WEAPONS
// Includes: Gold weapons, silver weapons, and 'rare' weapons (Executioner sword)
// Craft Difficulty: 2-4

//GOLD
/datum/anvil_recipe/weapons/decsword
	name = "Decorated Sword (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/decorated
	craftdiff = 4
	i_type = "Weapons"

/datum/anvil_recipe/weapons/decsword
	name = "Decorated Sword (+1 Steel Sword)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword)
	created_item = /obj/item/rogueweapon/sword/decorated
	craftdiff = 4
	i_type = "Weapons"

/datum/anvil_recipe/weapons/decsaber
	name = "Decorated Sabre (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	craftdiff = 4
	i_type = "Weapons"

/datum/anvil_recipe/weapons/decsaber
	name = "Decorated Sabre (+1 Steel Sabre)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/sabre)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	craftdiff = 4
	i_type = "Weapons"

/datum/anvil_recipe/weapons/decrapier
	name = "Decorated Rapier (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	craftdiff = 4
	i_type = "Weapons"

/datum/anvil_recipe/weapons/decrapier
	name = "Decorated Rapier (+1 Steel Rapier)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/rapier)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	craftdiff = 4
	i_type = "Weapons"

// SILVER
/datum/anvil_recipe/weapons/sidagger
	name = "Dagger"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/esaber
	name = "Elvish Saber (+1 Silver)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/rogueweapon/sword/silver/sabre/elf
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/edagger
	name = "Elvish Dagger"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver/elvish
	craftdiff = 3
	i_type = "Weapons"

// RARITY
/datum/anvil_recipe/valuables/execution
	name = "Execution Sword (+ 1 Steel, + 1 Iron)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/steel)	
	created_item = /obj/item/rogueweapon/sword/long/exe
	craftdiff = 3
	i_type = "Weapons"
