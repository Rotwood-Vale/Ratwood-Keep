
/datum/supply_pack/rogue/weapons
	group = "Weapons"
	crate_name = "merchant guild's crate"
	crate_type = /obj/structure/closet/crate/chest/merchant

/datum/supply_pack/rogue/weapons/sword
	name = "Iron Swords"
	cost = 50//3 iron
	contains = list(
					/obj/item/rogueweapon/sword/iron,
					/obj/item/rogueweapon/sword/iron,
					/obj/item/rogueweapon/sword/iron,
				)

/datum/supply_pack/rogue/weapons/mace
	name = "Iron Maces"
	cost = 50//3 iron
	contains = list(
					/obj/item/rogueweapon/mace,
					/obj/item/rogueweapon/mace,
					/obj/item/rogueweapon/mace,
				)

/datum/supply_pack/rogue/weapons/dagger
	name = "Iron Daggers"
	cost = 50//3 iron
	contains = list(
					/obj/item/rogueweapon/huntingknife/idagger,
					/obj/item/rogueweapon/huntingknife/idagger,
					/obj/item/rogueweapon/huntingknife/idagger,
				)

/datum/supply_pack/rogue/weapons/axe
	name = "Iron Axes"
	cost = 50//3 iron
	contains = list(
					/obj/item/rogueweapon/stoneaxe/woodcut,
					/obj/item/rogueweapon/stoneaxe/woodcut,
					/obj/item/rogueweapon/stoneaxe/woodcut,
				)

/datum/supply_pack/rogue/weapons/spear
	name = "Iron Spears"
	cost = 50//3 iron
	contains = list(
					/obj/item/rogueweapon/spear,
					/obj/item/rogueweapon/spear,
					/obj/item/rogueweapon/spear,
				)

/datum/supply_pack/rogue/weapons/flail
	name = "Iron Flails"
	cost = 50//3 iron
	contains = list(
					/obj/item/rogueweapon/flail,
					/obj/item/rogueweapon/flail,
					/obj/item/rogueweapon/flail,
				)

/datum/supply_pack/rogue/weapons/daggerss
	name = "Steel Daggers"
	cost = 80 //3 steel
	contains = list(
					/obj/item/rogueweapon/huntingknife/idagger/steel,
					/obj/item/rogueweapon/huntingknife/idagger/steel,
					/obj/item/rogueweapon/huntingknife/idagger/steel,
				)

/datum/supply_pack/rogue/weapons/daggerss/single
	name = "Steel Dagger"
	cost = 30
	contains = list(/obj/item/rogueweapon/huntingknife/idagger/steel)

/datum/supply_pack/rogue/weapons/shield
	name = "Wooden Shields"
	cost = 45
	contains = list(
					/obj/item/rogueweapon/shield/wood,
					/obj/item/rogueweapon/shield/wood,
					/obj/item/rogueweapon/shield/wood,
				)

/datum/supply_pack/rogue/weapons/crossbow
	name = "Crossbows"
	cost = 90// 3 steel + misc
	contains = list(
					/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow,
					/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow,
					/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow,
				)

/datum/supply_pack/rogue/weapons/crossbow/single
	name = "Crossbow"
	cost = 30
	contains = list(/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow)

/datum/supply_pack/rogue/weapons/bow
	name = "Bows"
	cost = 30
	contains = list(
					/obj/item/gun/ballistic/revolver/grenadelauncher/bow,
					/obj/item/gun/ballistic/revolver/grenadelauncher/bow,
					/obj/item/gun/ballistic/revolver/grenadelauncher/bow,
				)

/datum/supply_pack/rogue/weapons/quiver
	name = "Quiver"
	cost = 15
	contains = list(
					/obj/item/ammo_holder/quiver,
					/obj/item/ammo_holder/quiver,
					/obj/item/ammo_holder/quiver,
				)

/datum/supply_pack/rogue/weapons/arrow
	name = "Arrows"
	cost = 20//1 iron
	contains = list(
					/obj/item/ammo_casing/caseless/rogue/arrow/iron,
					/obj/item/ammo_casing/caseless/rogue/arrow/iron,
					/obj/item/ammo_casing/caseless/rogue/arrow/iron,
					/obj/item/ammo_casing/caseless/rogue/arrow/iron,
					/obj/item/ammo_casing/caseless/rogue/arrow/iron,
				)

/datum/supply_pack/rogue/weapons/quivers/arrows
	name = "Quiver of Arrows"
	cost = 60//3 iron
	contains = list(
					/obj/item/ammo_holder/quiver/arrows,
					/obj/item/ammo_holder/quiver/arrows,
					/obj/item/ammo_holder/quiver/arrows,
				)

/datum/supply_pack/rogue/weapons/quivers/arrows/single
	name = "Quiver of Arrows"
	cost = 30
	contains = list(/obj/item/ammo_holder/quiver/arrows)

/datum/supply_pack/rogue/weapons/quivers/bolts
	name = "Quiver of Bolts"
	cost = 60//3 iron
	contains = list(
					/obj/item/ammo_holder/quiver/bolts,
					/obj/item/ammo_holder/quiver/bolts,
					/obj/item/ammo_holder/quiver/bolts,
				)

/datum/supply_pack/rogue/weapons/quivers/bolts/single
	name = "Quiver of Bolts"
	cost = 30
	contains = list(/obj/item/ammo_holder/quiver/bolts)
/*
/datum/supply_pack/rogue/weapons/Parrows
	name = "Poisoned Arrows"
	cost = 100//1 iron plus jacksberries and shit(2 shot guaranteed kill and also wouldnt want to step on chemist players now would we ?)
	contains = list(/obj/item/ammo_casing/caseless/rogue/arrow/poison,
					/obj/item/ammo_casing/caseless/rogue/arrow/poison,
					/obj/item/ammo_casing/caseless/rogue/arrow/poison,
					/obj/item/ammo_casing/caseless/rogue/arrow/poison,
					/obj/item/ammo_casing/caseless/rogue/arrow/poison,)
*/

/datum/supply_pack/rogue/weapons/bolt
	name = "Bolts"
	cost = 20//1 iron
	contains = list(
					/obj/item/ammo_casing/caseless/rogue/bolt,
					/obj/item/ammo_casing/caseless/rogue/bolt,
					/obj/item/ammo_casing/caseless/rogue/bolt,
					/obj/item/ammo_casing/caseless/rogue/bolt,
					/obj/item/ammo_casing/caseless/rogue/bolt,
				)
/*
/datum/supply_pack/rogue/weapons/Pbolts
	name = "Poisoned Bolts"
	cost = 100 //See Poisoned arrows
	contains = list(/obj/item/ammo_casing/caseless/rogue/bolt/poison,
					/obj/item/ammo_casing/caseless/rogue/bolt/poison,
					/obj/item/ammo_casing/caseless/rogue/bolt/poison,
					/obj/item/ammo_casing/caseless/rogue/bolt/poison,
					/obj/item/ammo_casing/caseless/rogue/bolt/poison,
					)
*/

/datum/supply_pack/rogue/weapons/arquebus
	name = "Arquebus Rifle"
	cost = 90
	contains = list(/obj/item/gun/ballistic/firearm/arquebus)

/datum/supply_pack/rogue/weapons/handgonne
	name = "Handgonne"
	cost = 50
	contains = list(/obj/item/gun/ballistic/firearm/handgonne)

/datum/supply_pack/rogue/weapons/powderflask
	name = "Powderflask"
	cost = 20
	contains = list(/obj/item/powderflask)

/datum/supply_pack/rogue/weapons/bullet
	name = "Bullet Pouch (lead)"
	cost = 30
	contains = list(/obj/item/ammo_holder/bullet/lead)


/datum/supply_pack/rogue/weapons/bullet/grape
	name = "Bullet Pouch (grape)"
	cost = 30
	contains = list(/obj/item/ammo_holder/bullet/grapeshot)
