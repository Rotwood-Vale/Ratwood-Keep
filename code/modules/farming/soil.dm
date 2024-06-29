#define MAX_PLANT_HEALTH 100
#define MAX_PLANT_WATER 300
#define MAX_PLANT_NUTRITION 300
#define MAX_PLANT_WEEDS 100
#define SOIL_DECAY_TIME 10 MINUTES

/obj/structure/soil
	name = "soil"
	desc = "Dirt, ready to give life like a womb."
	icon = 'icons/obj/structures/soil.dmi'
	icon_state = "soil"
	density = FALSE
	climbable = FALSE
	max_integrity = 0
	/// Amount of water in the soil. It makes the plant and weeds not loose health
	var/water = 0
	/// Amount of weeds in the soil. The more of them the more water and nutrition they eat.
	var/weeds = 0
	/// Amount of nutrition in the soil. Nutrition is drained for the plant to mature and produce, also makes weeds grow
	var/nutrition = 0
	/// Amount of plant health, if it drops to zero the plant won't grow, make produce and will have to be uprooted.
	var/plant_health = MAX_PLANT_HEALTH
	/// The plant that is currently planted, it is a reference to a singleton
	var/datum/plant_def/plant = null
	/// Time of growth so far
	var/growth_time = 0
	/// Time of making produce so far
	var/produce_time = 0
	/// Whether the plant has matured
	var/matured = FALSE
	/// Whether the produce is ready for harvest
	var/produce_ready = FALSE
	/// Whether the plant is dead
	var/plant_dead = FALSE
	/// The time remaining in which the soil has been tilled and will help the plant grow
	var/tilled_time = 0
	/// The time remaining in which the soil was blessed and will help the plant grow, and make weeds decay
	var/blessed_time = 0
	/// Time remaining for the soil to decay and destroy itself, only applicable when its out of water and nutriments and has no plant
	var/soil_decay_time = SOIL_DECAY_TIME

/obj/structure/soil/Crossed(atom/movable/AM)
	. = ..()
	if(isliving(AM))
		on_stepped(AM)

/obj/structure/soil/proc/user_harvests(mob/living/user)
	apply_farming_fatigue(user, 5)
	if(produce_ready)
		adjust_experience(user, /datum/skill/labor/farming, user.STAINT * 4)
	yield_produce()

/obj/structure/soil/proc/try_handle_harvest(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/rogueweapon/sickle))
		if(!plant || !produce_ready)
			to_chat(user, span_warning("There is nothing to harvest!"))
			return TRUE
		user_harvests(user)
		playsound(src,'sound/items/seed.ogg', 100, FALSE)
		to_chat(user, span_notice("I harvest the crop."))
		return TRUE
	return FALSE

/obj/structure/soil/proc/try_handle_seed_planting(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/seeds))
		var/obj/item/seeds/seeds = attacking_item
		seeds.try_plant_seed(user, src)
		return TRUE
	return FALSE

/obj/structure/soil/proc/try_handle_uprooting(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/rogueweapon/shovel))
		to_chat(user, span_notice("I begin to uproot the crop..."))
		playsound(src,'sound/items/dig_shovel.ogg', 100, TRUE)
		if(do_after(user, get_farming_do_time(user, 4 SECONDS), target = src))
			to_chat(user, span_notice("I uproot the crop."))
			playsound(src,'sound/items/dig_shovel.ogg', 100, TRUE)
			uproot()
		return TRUE
	return FALSE

/obj/structure/soil/proc/try_handle_tilling(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/rogueweapon/hoe))
		to_chat(user, span_notice("I begin to till the soil..."))
		playsound(src,'sound/items/dig_shovel.ogg', 100, TRUE)
		if(do_after(user, get_farming_do_time(user, 4 SECONDS), target = src))
			to_chat(user, span_notice("I till the soil."))
			playsound(src,'sound/items/dig_shovel.ogg', 100, TRUE)
			user_till_soil(user)
		return TRUE
	return FALSE

/obj/structure/soil/proc/try_handle_watering(obj/item/attacking_item, mob/user, params)
	var/water_amount = 0
	if(istype(attacking_item, /obj/item/reagent_containers))
		if(water >= MAX_PLANT_WATER * 0.8)
			to_chat(user, span_warning("The soil is already wet!"))
			return TRUE
		var/obj/item/reagent_containers/container = attacking_item
		if(container.reagents.has_reagent(/datum/reagent/water, 10))
			container.reagents.remove_reagent(/datum/reagent/water, 10)
			water_amount = 150
		else if(container.reagents.has_reagent(/datum/reagent/water/gross, 10))
			container.reagents.remove_reagent(/datum/reagent/water/gross, 10)
			water_amount = 150
		else
			to_chat(user, span_warning("There's no water in \the [container]!"))
			return TRUE
	if(water_amount > 0)
		var/list/wash = list('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg')
		playsound(user, pick_n_take(wash), 100, FALSE)
		to_chat(user, span_notice("I water the soil."))
		adjust_water(water_amount)
		return TRUE
	return FALSE

/obj/structure/soil/proc/try_handle_fertilizing(obj/item/attacking_item, mob/user, params)
	var/fertilize_amount = 0
	if(istype(attacking_item, /obj/item/ash))
		fertilize_amount = 100
	else if (istype(attacking_item, /obj/item/natural/poo))
		fertilize_amount = 150
	else if (istype(attacking_item, /obj/item/compost))
		fertilize_amount = 150
	if(fertilize_amount > 0)
		if(nutrition >= MAX_PLANT_NUTRITION * 0.8)
			to_chat(user, span_warning("The soil is already fertilized!"))
		else
			to_chat(user, span_notice("I fertilize the soil."))
			adjust_nutrition(fertilize_amount)
			qdel(attacking_item)
		return TRUE
	return FALSE

/obj/structure/soil/proc/try_handle_deweed(obj/item/attacking_item, mob/user, params)
	if(weeds < MAX_PLANT_WEEDS * 0.3)
		return FALSE
	if(attacking_item == null)
		to_chat(user, span_notice("I begin ripping out the weeds with my hands..."))
		if(do_after(user, get_farming_do_time(user, 3 SECONDS), target = src))
			apply_farming_fatigue(user, 20)
			to_chat(user, span_notice("I rip out the weeds."))
			deweed()
		return TRUE
	if(istype(attacking_item, /obj/item/rogueweapon/hoe))
		apply_farming_fatigue(user, 10)
		to_chat(user, span_notice("I rip out the weeds with the [attacking_item]"))
		deweed()
		return TRUE
	return FALSE

/obj/structure/soil/proc/try_handle_flatten(obj/item/attacking_item, mob/user, params)
	if(plant)
		return FALSE
	if(istype(attacking_item, /obj/item/rogueweapon/shovel))
		to_chat(user, span_notice("I begin flattening the soil with \the [attacking_item]..."))
		playsound(src,'sound/items/dig_shovel.ogg', 100, TRUE)
		if(do_after(user, get_farming_do_time(user, 3 SECONDS), target = src))
			if(plant)
				return FALSE
			apply_farming_fatigue(user, 10)
			playsound(src,'sound/items/dig_shovel.ogg', 100, TRUE)
			to_chat(user, span_notice("I flatten the soil."))
			decay_soil()
		return TRUE
	return FALSE

/obj/structure/soil/attack_hand(mob/user)
	if(plant && produce_ready)
		to_chat(user, span_notice("I begin collecting the produce..."))
		if(do_after(user, get_farming_do_time(user, 4 SECONDS), target = src))
			to_chat(user, span_notice("I collect the produce."))
			playsound(src,'sound/items/seed.ogg', 100, FALSE)
			user_harvests(user)
		return
	if(plant && plant_dead)
		to_chat(user, span_notice("I begin to remove the dead crop..."))
		if(do_after(user, get_farming_do_time(user, 6 SECONDS), target = src))
			if(!plant || !plant_dead)
				return
			apply_farming_fatigue(user, 10)
			to_chat(user, span_notice("I remove the crop."))
			playsound(src,'sound/items/seed.ogg', 100, FALSE)
			uproot()
		return
	. = ..()

/obj/structure/soil/attack_right(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	var/obj/item = user.get_active_held_item()
	if(try_handle_deweed(item, user, null))
		return
	if(try_handle_flatten(item, user, null))
		return
	return ..()

/obj/structure/soil/attackby(obj/item/attacking_item, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(try_handle_seed_planting(attacking_item, user, params))
		return
	if(try_handle_uprooting(attacking_item, user, params))
		return
	if(try_handle_tilling(attacking_item, user, params))
		return
	if(try_handle_watering(attacking_item, user, params))
		return
	if(try_handle_fertilizing(attacking_item, user, params))
		return
	if(try_handle_harvest(attacking_item, user, params))
		return
	return ..()

/obj/structure/soil/proc/on_stepped(mob/living/stepper)
	if(!plant)
		return
	if(stepper.m_intent == MOVE_INTENT_SNEAK)
		return
	if(stepper.m_intent == MOVE_INTENT_WALK)
		adjust_plant_health(-5)
	else if(stepper.m_intent == MOVE_INTENT_RUN)
		adjust_plant_health(-10)
	playsound(src,"plantcross", 100, FALSE)

/obj/structure/soil/proc/deweed()
	if(weeds >= MAX_PLANT_WEEDS * 0.3)
		playsound(src,"plantcross", 100, FALSE)
	adjust_weeds(-100)

/obj/structure/soil/proc/user_till_soil(mob/user)
	apply_farming_fatigue(user, 10)
	till_soil(15 MINUTES * get_farming_effort_multiplier(user))

/obj/structure/soil/proc/till_soil(time = 15 MINUTES)
	tilled_time = time
	adjust_plant_health(-20)
	adjust_weeds(-30)
	if(plant)
		playsound(src,"plantcross", 100, FALSE)
	update_icon()

/obj/structure/soil/proc/bless_soil()
	blessed_time = 15 MINUTES
	// It's a miracle! Plant comes back to life when blessed by Dendor
	if(plant && plant_dead)
		plant_dead = FALSE
		plant_health = 10.0
	// If low on nutrition, Dendor provides
	if(nutrition < 100)
		adjust_nutrition(max(100 - nutrition, 0))
	// If low on water, Dendor provides
	if(water < 100)
		adjust_water(max(100 - water, 0))
	// And it grows a little!
	if(plant)
		add_growth(2 MINUTES)

/obj/structure/soil/proc/adjust_water(adjust_amount)
	water = clamp(water + adjust_amount, 0, MAX_PLANT_WATER)
	update_icon()

/obj/structure/soil/proc/adjust_nutrition(adjust_amount)
	nutrition = clamp(nutrition + adjust_amount, 0, MAX_PLANT_NUTRITION)
	update_icon()

/obj/structure/soil/proc/adjust_weeds(adjust_amount)
	weeds = clamp(weeds + adjust_amount, 0, MAX_PLANT_WEEDS)
	update_icon()

/obj/structure/soil/proc/adjust_plant_health(adjust_amount)
	if(!plant || plant_dead)
		return
	plant_health = clamp(plant_health + adjust_amount, 0, MAX_PLANT_HEALTH)
	if(plant_health <= 0)
		plant_dead = TRUE
		produce_ready = FALSE
	update_icon()

/obj/structure/soil/Initialize()
	START_PROCESSING(SSprocessing, src)
	. = ..()

/obj/structure/soil/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	. = ..()

/obj/structure/soil/process()
	var/dt = 10
	process_weeds(dt)
	process_plant(dt)
	process_soil(dt)
	update_icon()
	if(soil_decay_time <= 0)
		decay_soil()

/obj/structure/soil/update_icon()
	. = ..()
	update_overlays()

/obj/structure/soil/update_overlays()
	. = ..()
	// Tilled overlay
	if(tilled_time > 0)
		. += "soil-tilled"
	// Water overlay
	var/mutable_appearance/water_ma = mutable_appearance(icon, "soil-overlay")
	water_ma.color = "#000033"
	if(water >= MAX_PLANT_WATER * 0.6)
		water_ma.alpha = 100
	else if (water >= MAX_PLANT_WATER * 0.15)
		water_ma.alpha = 50
	else
		water_ma.alpha = 0
	. += water_ma
	// Nutriment overlay
	var/mutable_appearance/nutri_ma = mutable_appearance(icon, "soil-overlay")
	nutri_ma.color = "#6d3a00"
	if(nutrition >= MAX_PLANT_NUTRITION * 0.6)
		nutri_ma.alpha = 50
	else if (nutrition >= MAX_PLANT_NUTRITION * 0.15)
		nutri_ma.alpha = 25
	else
		nutri_ma.alpha = 0
	. += nutri_ma
	// Plant overlay
	if(plant)
		var/plant_state
		var/plant_color
		if(plant_dead == TRUE)
			plant_color = null
		else if(plant_health <=  MAX_PLANT_HEALTH * 0.3)
			plant_color = "#9c7b43"
		else if (plant_health <=  MAX_PLANT_HEALTH * 0.6)
			plant_color = "#d8b573"
		if(plant_dead == TRUE)
			plant_state = "[plant.icon_state]3"
		else
			if(produce_ready)
				plant_state = "[plant.icon_state]2"
			else if (matured)
				plant_state = "[plant.icon_state]1"
			else
				plant_state = "[plant.icon_state]0"
		var/mutable_appearance/plant_ma = mutable_appearance(plant.icon, plant_state)
		plant_ma.color = plant_color
		. += plant_ma
	// Weeds overlay
	if(weeds >= MAX_PLANT_WEEDS * 0.6)
		. += "weeds-2"
	else if (weeds >= MAX_PLANT_WEEDS * 0.3)
		. += "weeds-1"

/obj/structure/soil/examine(mob/user)
	. = ..()
	// Plant description
	if(plant)
		. += span_info("\The [plant.name] is growing here...")
		// Plant health feedback
		if(plant_dead == TRUE)
			. += span_warning("It's dead!")
		else if(plant_health <=  MAX_PLANT_HEALTH * 0.3)
			. += span_warning("It's dying!")
		else if (plant_health <=  MAX_PLANT_HEALTH * 0.6)
			. += span_warning("It's brown and unhealthy...")
		// Plant maturation and produce feedback
		if(matured)
			. += span_info("It's fully matured.")
		else
			. += span_info("It has yet to mature.")
		if(produce_ready)
			. += span_info("It's ready for harvest.")
	// Water feedback
	if(water <= MAX_PLANT_WATER * 0.15)
		. += span_warning("The soil is thirsty.")
	else if (water <= MAX_PLANT_WATER * 0.5)
		. += span_info("The soil is moist.")
	else
		. += span_info("The soil is wet.")
	// Nutrition feedback
	if(nutrition <= MAX_PLANT_NUTRITION * 0.15)
		. += span_warning("The soil is hungry.")
	else if (nutrition <= MAX_PLANT_NUTRITION * 0.5)
		. += span_info("The soil is sated.")
	else
		. += span_info("The soil looks fertile.")
	// Weeds feedback
	if(weeds >= MAX_PLANT_WEEDS * 0.6)
		. += span_warning("It's overtaken by the weeds!")
	else if (weeds >= MAX_PLANT_WEEDS * 0.3)
		. += span_warning("Weeds are growing out...")
	// Tilled feedback
	if(tilled_time > 0)
		. += span_info("The soil is tilled.")
	// Blessed feedback
	if(blessed_time > 0)
		. += span_good("The soil seems blessed.")

#define BLESSING_WEED_DECAY_RATE 10 / (1 MINUTES)
#define WEED_GROWTH_RATE 3 / (1 MINUTES)
#define WEED_DECAY_RATE 5 / (1 MINUTES)
#define WEED_RESISTANCE_DECAY_RATE 20 / (1 MINUTES)

// These get multiplied by 0.0 to 1.0 depending on amount of weeds
#define WEED_WATER_CONSUMPTION_RATE 5 / (1 MINUTES)
#define WEED_NUTRITION_CONSUMPTION_RATE 5 / (1 MINUTES)

/obj/structure/soil/proc/process_weeds(dt)
	// Blessed soil will have the weeds die
	if(blessed_time > 0)
		adjust_weeds(-dt * BLESSING_WEED_DECAY_RATE)
	if(plant && plant.weed_immune)
		// Weeds die if the plant is immune to them
		adjust_weeds(-dt * WEED_RESISTANCE_DECAY_RATE)
		return
	if(water <= 0)
		// Weeds die without water in soil
		adjust_weeds(-dt * WEED_DECAY_RATE)
		return
	// Weeds eat water and nutrition to grow
	var/weed_factor = weeds / MAX_PLANT_WEEDS
	adjust_water(-dt * weed_factor * WEED_WATER_CONSUMPTION_RATE)
	adjust_nutrition(-dt * weed_factor * WEED_NUTRITION_CONSUMPTION_RATE)
	if(nutrition > 0)
		adjust_weeds(dt * WEED_GROWTH_RATE)


#define PLANT_REGENERATION_RATE 10 / (1 MINUTES)
#define PLANT_DECAY_RATE 10 / (1 MINUTES)
#define PLANT_BLESS_HEAL_RATE 20 / (1 MINUTES)
#define PLANT_WEEDS_HARM_RATE 10 / (1 MINUTES)

/obj/structure/soil/proc/process_plant(dt)
	if(!plant)
		return
	if(plant_dead)
		return
	process_plant_nutrition(dt)
	process_plant_health(dt)


/obj/structure/soil/proc/process_plant_health(dt)
	var/drain_rate = plant.water_drain_rate
	// Lots of weeds harm the plant
	if(weeds >= MAX_PLANT_WEEDS * 0.6)
		adjust_plant_health(-dt * PLANT_WEEDS_HARM_RATE)
	// Regenerate plant health if we dont drain water, or we have the water
	if(drain_rate <= 0 || water > 0)
		adjust_plant_health(dt * PLANT_REGENERATION_RATE)
	if(drain_rate > 0)
		// If we're dry and we want to drain water, we loose health
		if(water <= 0)
			adjust_plant_health(-dt * PLANT_DECAY_RATE)
		else
			// Drain water
			adjust_water(-dt * drain_rate)
	// Blessed plants heal!!
	if(blessed_time > 0)
		adjust_plant_health(dt * PLANT_BLESS_HEAL_RATE)

/obj/structure/soil/proc/process_plant_nutrition(dt)
	// If matured and produce is ready, don't process plant nutrition
	if(matured && produce_ready)
		return
	var/drain_rate = plant.water_drain_rate
	// If we drain water, and have no water, we can't grow
	if(drain_rate > 0 && water <= 0)
		return
	var/growth_multiplier = 1.0
	var/nutriment_eat_mutliplier = 1.0
	// If soil is tilled, grow faster
	if(tilled_time > 0)
		growth_multiplier *= 1.6
	// If soil is blessed, grow faster and take up less nutriments
	if(blessed_time > 0)
		growth_multiplier *= 2.0
		nutriment_eat_mutliplier *= 0.4
	// If there's too many weeds, they hamper the growth of the plant
	if(weeds >= MAX_PLANT_WEEDS * 0.3)
		growth_multiplier *= 0.75
	if(weeds >= MAX_PLANT_WEEDS * 0.6)
		growth_multiplier *= 0.75
	// If we're low on health, also grow slower
	if(plant_health <= MAX_PLANT_HEALTH * 0.6)
		growth_multiplier *= 0.75
	if(plant_health <= MAX_PLANT_HEALTH * 0.3)
		growth_multiplier *= 0.75
	var/target_growth_time = growth_multiplier * dt
	process_growth(target_growth_time)

/obj/structure/soil/proc/process_growth(target_growth_time)
	var/target_nutrition
	if(!matured)
		target_nutrition = (plant.maturation_nutrition / plant.maturation_time) * target_growth_time
	else
		target_nutrition = (plant.produce_nutrition / plant.produce_time) * target_growth_time
	var/possible_nutrition = min(target_nutrition, nutrition)
	var/factor = possible_nutrition / target_nutrition
	var/possible_growth_time = target_growth_time * factor
	adjust_nutrition(-possible_nutrition)
	add_growth(possible_growth_time)


/obj/structure/soil/proc/add_growth(added_growth)
	growth_time += added_growth
	if(!matured)
		if(growth_time >= plant.maturation_time)
			matured = TRUE
	else
		produce_time += added_growth
		if(produce_time >= plant.produce_time)
			produce_time -= plant.produce_time
			produce_ready = TRUE


#define SOIL_WATER_DECAY_RATE 0.5 / (1 MINUTES)
#define SOIL_NUTRIMENT_DECAY_RATE 0.5 / (1 MINUTES)

/obj/structure/soil/proc/process_soil(dt)
	// If plant exists and is not dead, nutriment or water is not zero, reset the decay timer
	if(nutrition > 0 || water > 0 || (plant != null && plant_health > 0))
		soil_decay_time = SOIL_DECAY_TIME
	else
		// Otherwise, "decay" the soil
		soil_decay_time = max(soil_decay_time - dt, 0)

	adjust_water(-dt * SOIL_WATER_DECAY_RATE)
	adjust_nutrition(-dt * SOIL_NUTRIMENT_DECAY_RATE)

	tilled_time = max(tilled_time - dt, 0)
	blessed_time = max(blessed_time - dt, 0)

/obj/structure/soil/proc/decay_soil()
	uproot()
	qdel(src)

/obj/structure/soil/proc/uproot()
	if(!plant)
		return
	adjust_weeds(-100)
	yield_uproot_loot()
	yield_produce()
	plant = null
	update_icon()

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
	produce_ready = FALSE
	if(!plant.perennial)
		uproot()
	update_icon()

/obj/structure/soil/proc/insert_plant(datum/plant_def/new_plant)
	if(plant)
		return
	plant = new_plant
	plant_health = MAX_PLANT_HEALTH
	growth_time = 0
	produce_time = 0
	matured = FALSE
	produce_ready = FALSE
	plant_dead = FALSE
	update_icon()
