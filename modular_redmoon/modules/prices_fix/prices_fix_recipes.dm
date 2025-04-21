
/datum/anvil_recipe
	var/sellprice = 0

/obj/item/proc/Get_Anvil_Production_Sellprice(datum/anvil_recipe/anvil_recipe)
	if(anvil_recipe.sellprice)
		sellprice = anvil_recipe.sellprice
		randomize_price()

/// IRON 

/datum/anvil_recipe/weapons/iron
	sellprice = 20

/datum/anvil_recipe/weapons/iron/bardiche
	sellprice = 40

/datum/anvil_recipe/weapons/iron/zweihander
	sellprice = 60

/// STEEL

/datum/anvil_recipe/weapons/steel
	sellprice = 30

/datum/anvil_recipe/weapons/steel/bastardsword
	sellprice = 60

/datum/anvil_recipe/weapons/steel/battleaxe
	sellprice = 60

/datum/anvil_recipe/weapons/steel/mace
	sellprice = 60

/datum/anvil_recipe/weapons/steel/warhammer
	sellprice = 60

/datum/anvil_recipe/weapons/steel/langesmesser
	sellprice = 60

/datum/anvil_recipe/weapons/steel/estoc
	sellprice = 90

/datum/anvil_recipe/weapons/steel/greatsword
	sellprice = 90

/datum/anvil_recipe/weapons/steel/lucerne
	sellprice = 50

/datum/anvil_recipe/weapons/steel/halberd
	sellprice = 60

/datum/anvil_recipe/weapons/steel/eaglebeak
	sellprice = 60

/datum/anvil_recipe/weapons/steel/execution
	sellprice = 50

/// SILVER 

/datum/anvil_recipe/weapons/silver
	sellprice = 60

/// GOLD

/datum/anvil_recipe/weapons/decsword/steel
	sellprice = 140

/datum/anvil_recipe/weapons/decsword
	sellprice = 140

/datum/anvil_recipe/weapons/decsaber/steel
	sellprice = 140

/datum/anvil_recipe/weapons/decsaber
	sellprice = 140

/datum/anvil_recipe/weapons/decrapier/steel
	sellprice = 140

/datum/anvil_recipe/weapons/decrapier
	sellprice = 140

/datum/anvil_recipe/weapons/terminus
	sellprice = 250

// BRONZE

/datum/anvil_recipe/weapons/gladius
	sellprice = 20

/datum/anvil_recipe/weapons/bronze/spear
	sellprice = 40

/// SHIELDS

/datum/anvil_recipe/weapons/steel/kiteshield
	sellprice = 80

/datum/anvil_recipe/weapons/iron/towershield
	sellprice = 20

/datum/anvil_recipe/weapons/steel/buckler
	sellprice = 30
