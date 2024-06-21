/datum/plant_def
	/// Name of the plant
	var/name = "Some plant"
	/// Description of the plant
	var/desc = "Sure is a plant."
	/// Loot the plant will yield for uprooting it
	var/list/uproot_loot
	/// Time in ticks the plant will require to mature, before starting to make produce
	var/maturation_time = 5 MINUTES
	/// Time in ticks the plant will require to make produce
	var/produce_time = 2 MINUTES
	/// Typepath of produce to make on harvest
	var/produce_type
	/// Amount of produce to make on harvest
	var/produce_amount = 1
	/// How much nutrition will the plant require to mature fully
	var/maturation_nutrition = 0
	/// How much nutrition will the plant require to make produce
	var/produce_nutrition = 0
	/// If not perennial, the plant will uproot itself upon harvesting first produce
	var/perennial = FALSE
	/// Whether the plant is immune to weeds and will naturally deal with them
	var/weed_immune = FALSE
