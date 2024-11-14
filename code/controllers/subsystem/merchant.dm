SUBSYSTEM_DEF(merchant)
	name = "Merchant Packs"
	wait = 10
	init_order = INIT_ORDER_SHUTTLE
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	var/list/supply_packs = list()
	var/list/supply_cats = list()
	var/list/shoppinglist = list()
	var/list/requestlist = list()
	var/list/orderhistory = list()


/datum/controller/subsystem/merchant/Initialize(timeofday)
	for(var/pack in subtypesof(/datum/supply_pack/rogue))
		var/datum/supply_pack/P = new pack()
		if(!P.contains)
			continue
		supply_packs[P.type] = P
		if(!(P.group in supply_cats))
			supply_cats += P.group
