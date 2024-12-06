/datum/anvil_recipe/weapons
	i_type = "Weapons"
/datum/anvil_recipe/ammo
	i_type = "Ammo"

/datum/anvil_recipe/weapons
	appro_skill = /datum/skill/craft/blacksmithing  // inheritance yay !!
	skill_level = 1

/// IRON WEAPONS

/datum/anvil_recipe/weapons/iron/sword
	name = "Sword"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron

/datum/anvil_recipe/weapons/iron/swordshort
	name = "Short sword"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron/short

/datum/anvil_recipe/weapons/iron/messer
	name = "Messer"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron/messer

/datum/anvil_recipe/weapons/iron/dagger
	name = "Dagger"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife/idagger

/datum/anvil_recipe/weapons/iron/flail
	name = "Flail"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/flail

/datum/anvil_recipe/weapons/iron/huntingknife
	name = "Hunting knife"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife

/datum/anvil_recipe/weapons/iron/axe
	name = "Axe (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut
	skill_level = 0

/datum/anvil_recipe/weapons/iron/cudgel
	name = "Cudgel (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/cudgel
	skill_level = 0

/datum/anvil_recipe/weapons/iron/mace
	name = "Mace (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace
	skill_level = 0

/datum/anvil_recipe/weapons/iron/spear
	name = "Spear (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear
	skill_level = 0

/datum/anvil_recipe/weapons/iron/bardiche
	name = "Bardiche (+ Iron) (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd/bardiche
	skill_level = 2

/datum/anvil_recipe/weapons/steel/zweihander
	name = "Zweihander (+2 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron)
	created_item = /obj/item/rogueweapon/greatsword/zwei
	skill_level = 3

/datum/anvil_recipe/weapons/iron/axe
	name = "Axe (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut

/datum/anvil_recipe/weapons/iron/mace
	name = "Mace (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace

/datum/anvil_recipe/weapons/iron/warhammer
	name = "Warhammer (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/warhammer

/datum/anvil_recipe/weapons/iron/polemace
	name = "Warclub (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden

/// STEEL

/datum/anvil_recipe/weapons/steel/messer
	name = "Messer"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/iron/messer/steel

/datum/anvil_recipe/weapons/iron/dagger
	name = "Dagger"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel

/datum/anvil_recipe/weapons/steel/flail
	name = "Flail"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/flail/sflail

/datum/anvil_recipe/weapons/steel/sword
	name = "Sword"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword

/datum/anvil_recipe/weapons/steel/swordshort
	name = "Arming Sword"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/short

/datum/anvil_recipe/weapons/steel/saber
	name = "Sabre"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/sabre

/datum/anvil_recipe/weapons/steel/rapier
	name = "Rapier"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/rapier

/datum/anvil_recipe/weapons/steel/cutlass
	name = "Cutlass"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/cutlass

/datum/anvil_recipe/weapons/steel/katar
	name = "Katar"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/katar

/datum/anvil_recipe/weapons/steel/cleaver
	name = "Cleaver"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/cleaver

/datum/anvil_recipe/weapons/steel/combatknife
	name = "Combat Knife"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/cleaver/combat
	skill_level = 2

/datum/anvil_recipe/weapons/steel/bastardsword
	name = "Bastard Sword (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long
	skill_level = 2

/datum/anvil_recipe/weapons/steel/battleaxe
	name = "Battle Axe (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/stoneaxe/battle
	skill_level = 2

/datum/anvil_recipe/weapons/steel/mace
	name = "Mace (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/mace/steel
	skill_level = 2

/datum/anvil_recipe/weapons/steel/warhammer
	name = "Warhammer (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/mace/warhammer/steel
	skill_level = 2

/datum/anvil_recipe/weapons/steel/langesmesser
	name = "Langesmesser (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long/rider/messer
	skill_level = 2

/datum/anvil_recipe/weapons/steel/estoc
	name = "Estoc (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/estoc
	skill_level = 4

/datum/anvil_recipe/weapons/steel/greatsword
	name = "Greatsword (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/greatsword
	skill_level = 3

/datum/anvil_recipe/weapons/steel/lucerne
	name = "Lucerne (+ Steel) (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak/lucerne
	skill_level = 2

/datum/anvil_recipe/weapons/steel/billhook
	name = "Billhook (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/billhook

/datum/anvil_recipe/weapons/steel/axe
	name = "Axe (+1 Stick)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/steel

/datum/anvil_recipe/weapons/steel/halberd
	name = "Halberd (+1 Steel) (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd
	skill_level = 2

/datum/anvil_recipe/weapons/steel/eaglebeak
	name = "Eagle's Beak (+1 Steel) (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak
	skill_level = 2

/datum/anvil_recipe/weapons/steel/grandmace
	name = "Grand Mace (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden/steel

/datum/anvil_recipe/weapons/steel/execution
	name = "Execution Sword (+ 1 Steel, + 1 Iron)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long/exe

/// SILVER 

/datum/anvil_recipe/weapons/silver/dagger
	name = "Dagger"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver

/datum/anvil_recipe/weapons/silver/elfsaber
	name = "Elvish Saber"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/rogueweapon/sword/sabre/elf
	skill_level = 3

/datum/anvil_recipe/weapons/silver/elfdagger
	name = "Elvish Dagger"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/elvish
	skill_level = 3

//GOLD

/datum/anvil_recipe/weapons/decsword
	name = "Decorated Sword (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/decorated
	skill_level = 2

/datum/anvil_recipe/weapons/decsword
	name = "Decorated Sword (+1 Steel Sword)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword)
	created_item = /obj/item/rogueweapon/sword/decorated
	skill_level = 2

/datum/anvil_recipe/weapons/decsaber
	name = "Decorated Sabre (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	skill_level = 2

/datum/anvil_recipe/weapons/decsaber
	name = "Decorated Sabre (+1 Steel Sabre)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/sabre)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	skill_level = 2

/datum/anvil_recipe/weapons/decrapier
	name = "Decorated Rapier (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	skill_level = 2

/datum/anvil_recipe/weapons/decrapier
	name = "Decorated Rapier (+1 Steel Rapier)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/rapier)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	skill_level = 2

/datum/anvil_recipe/weapons/terminus
	name = "Terminus Est (+1 Gold Bar, +1 Steel, +1 Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/ingot/steel, /obj/item/roguegem)	
	created_item = /obj/item/rogueweapon/sword/long/exe/cloth
	skill_level = 3

// BRONZE

/datum/anvil_recipe/weapons/gladius
	name = "Gladius"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/rogueweapon/sword/gladius
	skill_level = 2

/datum/anvil_recipe/weapons/bronze/spear
	name = "Bronze Spear (+1 Bronze, +1 Small Log)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/bronze
	skill_level = 0


/// SHIELDS
/datum/anvil_recipe/weapons/steel/kiteshield
	name = "Heraldic Shield (+1 Steel +1 Hide)"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/hide/cured)
	created_item = /obj/item/rogueweapon/shield/tower/metal
	skill_level = 2

/datum/anvil_recipe/weapons/iron/towershield
	name = "Tower Shield (+1 Small Log)"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/shield/tower

/datum/anvil_recipe/weapons/steel/buckler
	name = "Buckler Shield"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/shield/buckler
	skill_level = 3

/datum/anvil_recipe/ammo/musketball
	name = "Musketballs 8x"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead
					)

	skill_level = 1

/datum/anvil_recipe/ammo/grapeshot
	name = "Grapeshot Cluster 8x"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot
					)

	skill_level = 1
