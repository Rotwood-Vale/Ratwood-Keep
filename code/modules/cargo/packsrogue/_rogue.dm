/datum/supply_pack/rogue
	var/static_cost = FALSE
	var/randomprice_factor = 0.07
	/// Multiplier for shipment cost if it's not defined explicitly
	var/shipment_cost_multiplier = 0.85
	/// Multiplier for teleport cost if it's not defined explicitly
	var/teleport_cost_multiplier = 1.15

	/// Whether buying it through means of teleportation is possible
	var/allows_teleport_buy = TRUE
	/// Cost of buying it through teleportation, if not defined it will use `cost` and be multiplied by `teleport_cost_multiplier`
	var/teleport_cost = null
	/// Whether buying it through means of shipment is possible
	var/allows_shipment_buy = TRUE
	/// Cost of buying it through shipment, if not defined it will use `cost` and be multiplied by `shipment_cost_multiplier`
	var/shipment_cost = null
	/// Whether the shipped items spawn in a crate, and require a crate consumed from the shipment system
	var/shipment_spawns_in_crate = TRUE

/datum/supply_pack/rogue/New()
	. = ..()
#ifdef TESTSERVER
	cost = 1
	teleport_cost = cost
	shipment_cost = cost
#else
	if(!static_cost)
		var/na = max(round(cost * randomprice_factor, 1), 1)
		cost = max(rand(cost-na, cost+na), 1)
	if(!shipment_cost)
		shipment_cost = max(round(cost * shipment_cost_multiplier), 1)
	if(!teleport_cost)
		teleport_cost = max(round(cost * teleport_cost_multiplier), 1)
	
#endif
