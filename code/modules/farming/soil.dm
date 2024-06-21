#define MAX_PLANT_HEALTH 100
#define MAX_PLANT_WATER 100
#define MAX_PLANT_NUTRITION 100
#define MAX_PLANT_WEEDS 100
#define SOIL_DECAY_TIME 3 MINUTES

/obj/structure/soil
	name = "soil"
	/// Amount of water in the soil. It makes the plant and weeds not loose health
	var/water = 0
	/// Amount of weeds in the soil. The more of them the more water and nutrition they eat.
	var/weeds = 0
	/// Amount of nutrition in the soil. Nutrition is drained for the plant to mature and produce, also makes weeds grow
	var/nutrition = 0
	/// Amount of plant health, if it drops to zero the plant won't grow, make produce and will have to be uprooted.
	var/plant_health = 0
	/// The plant that is currently planted, it is a reference to a singleton
	var/datum/plant_def/plant = null
	/// Time of maturation so far
	var/maturation_time = 0
	/// Time of making produce so far
	var/produce_time = 0
	/// Whether the plant has matured
	var/matured = FALSE
	/// Whether the produce is ready for harvest
	var/produce_ready = FALSE
	/// Whether the plant is ready
	var/plant_dead = FALSE
	/// The time remaining in which the soil has been tilled and will help the plant grow
	var/tilled_time = 0
	/// The time remaining in which the soil was blessed and will help the plant grow, and make weeds decay
	var/blessed_time = 0
	/// Time remaining for the soil to decay and destroy itself, only applicable when its out of water and nutriments and has no plant
	var/soil_decay_time = SOIL_DECAY_TIME

/obj/structure/soil/Initialize()
	START_PROCESSING(SSprocessing, src)
	. = ..()

/obj/structure/soil/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	. = ..()

/obj/structure/soil/process()
	var/dt = 1 * SSprocessing.wait
	process_weeds(dt)
	process_plant(dt)
	process_soil(dt)
	update_icon()
	if(soil_decay_time <= 0)
		decay_soil()

/obj/structure/soil/update_icon()
	. = ..()

/obj/structure/soil/examine(mob/user)
	. = ..()

#define BLESSING_WEED_DECAY_RATE 50 / 1 MINUTES
#define WEED_GROWTH_RATE 10 / 1 MINUTES
#define WEED_DECAY_RATE 10 / 1 MINUTES

// These get multiplied by 0.0 to 1.0 depending on amount of weeds
#define WEED_WATER_CONSUMPTION_RATE 10 / 1 MINUTES
#define WEED_NUTRITION_CONSUMPTION_RATE 10 / 1 MINUTES

/obj/structure/soil/proc/process_weeds(dt)
	// Blessed soil will have the weeds die
	if(blessed_time > 0)
		weeds = max(weeds - (dt * BLESSING_WEED_DECAY_RATE), 0)
	if(plant && plant.weed_immune)
		// Weeds die if the plant is immune to them
		weeds = max(weeds - (dt * WEED_DECAY_RATE), 0)
		return
	if(water <= 0)
		// Weeds die without water in soil
		weeds = max(weeds - (dt * WEED_DECAY_RATE), 0)
		return
	// Weeds eat water and nutrition to grow
	var/weed_factor = weeds / MAX_PLANT_WEEDS
	water = max(water - (dt * weed_factor * WEED_WATER_CONSUMPTION_RATE), 0)
	nutrition = max(nutrition - (dt * weed_factor * WEED_NUTRITION_CONSUMPTION_RATE), 0)
	weeds = min(weeds + (dt * WEED_GROWTH_RATE), MAX_PLANT_WEEDS)

/obj/structure/soil/proc/process_plant(dt)
	if(!plant)
		return
	if(plant_dead)
		return

#define SOIL_WATER_DECAY_RATE 2 / 1 MINUTES
#define SOIL_NUTRIMENT_DECAY_RATE 2 / 1 MINUTES	

/obj/structure/soil/proc/process_soil(dt)
	// If nutriment or water is not zero, reset the decay timer
	if(nutriment > 0 || water > 0)
		soil_decay_time = SOIL_DECAY_TIME
	
	tilled_time = max(tilled_time - dt, 0)
	blessed_time = max(blessed_time - dt, 0)

	if(nutriment == 0 && water == 0)
		soil_decay_time = max(soil_decay_time - dt, 0)

/obj/structure/soil/proc/decay_soil()
	uproot()
	qdel(src)

/obj/structure/soil/proc/uproot()
	if(!plant)
		return
	yield_uproot_loot()
	yield_produce()
	plant = null

/// Spawns uproot loot, such as a long from an apple tree when removing the tree
/obj/structure/soil/proc/yield_uproot_loot()
	if(!matured || !plant.uproot_loot)
		return
	for(var/loot_type in plant.uproot_loot)
		new loot_type(loc)

/// Yields produce on its tile if it's ready for harvest
/obj/structure/soil/proc/yield_produce()
	if(!produce_ready)
		return
	for(var/i in 1 to plant.produce_amount)
		new plant.produce_type(loc)

/obj/structure/soil/proc/plant(datum/plant_def/new_plant)
	if(plant)
		return
	plant = new_plant
	plant_health = MAX_PLANT_HEALTH
	maturation_time = 0
	produce_time = 0
	matured = FALSE
	produce_ready = FALSE
	plant_dead = FALSE
