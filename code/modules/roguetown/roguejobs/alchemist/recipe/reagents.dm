/datum/reagents_recipes

//In the future porting over TGs reagents

	var/name = null
	var/id = null
	var/list/results = new/list()
	var/list/required_reagents = new/list()
	var/list/required_catalysts = new/list()


	var/required_container = null
	var/required_other = 0

	var/mob_react = TRUE

	var/required_temp = 0
	var/is_cold_recipe = 0
	var/mix_message
	var/mix_sound

/datum/reagents_recipes/proc/on_reaction(datum/reagents/holder, created_volume)
	return


/datum/reagents_recipes/proc/chemical_mob_spawn(datum/reagents/holder, amount_to_spawn, reaction_name, mob_class = HOSTILE_SPAWN, mob_faction = "chemicalsummon", random = TRUE)
	if(holder && holder.my_atom)
		var/atom/A = holder.my_atom
		var/turf/T = get_turf(A)
		var/message = "A [reaction_name] reaction has occurred in [ADMIN_VERBOSEJMP(T)]"
		message += " (<A HREF='?_src_=vars;Vars=[REF(A)]'>VV</A>)"

		var/mob/M = get(A, /mob)
		if(M)
			message += " - Carried By: [ADMIN_LOOKUPFLW(M)]"
		else
			message += " - Last Fingerprint: [(A.fingerprintslast ? A.fingerprintslast : "N/A")]"

		message_admins(message, 0, 1)
		log_game("[reaction_name] chemical mob spawn reaction occuring at [AREACOORD(T)] carried by [key_name(M)] with last fingerprint [A.fingerprintslast? A.fingerprintslast : "N/A"]")

		playsound(get_turf(holder.my_atom), 'sound/blank.ogg', 100, TRUE)

		for(var/mob/living/carbon/C in viewers(get_turf(holder.my_atom), null))
			C.flash_act()

		for(var/i in 1 to amount_to_spawn)
			var/mob/living/simple_animal/S
			if(random)
				S = create_random_mob(get_turf(holder.my_atom), mob_class)
			else
				S = new mob_class(get_turf(holder.my_atom))
			S.faction |= mob_faction
			if(prob(50))
				for(var/j = 1, j <= rand(1, 3), j++)
					step(S, pick(NORTH,SOUTH,EAST,WEST))


/proc/rogue_vortex(turf/T, setting_type, range)
	for(var/atom/movable/X in view(range, T))
		if(X.anchored)
			continue
		if(iseffect(X) || iscameramob(X) || isdead(X))
			continue
		var/distance = get_dist(X, T)
		var/moving_power = max(range - distance, 1)
		if(moving_power > 2)
			if(setting_type)
				var/atom/throw_target = get_edge_target_turf(X, get_dir(X, get_step_away(X, T)))
				X.throw_at(throw_target, moving_power, 1)
			else
				X.throw_at(T, moving_power, 1)
		else
			if(setting_type)
				if(step_away(X, T) && moving_power > 1)
					addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(_step_away), X, T), 2)
			else
				if(step_towards(X, T) && moving_power > 1)
					addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(_step_towards), X, T), 2)


/datum/chemical_reaction/alch //someone will need to remake this later, that someone isnt me
	name = "debug alch reaction"
	mix_sound = 'sound/items/fillbottle.ogg'
	id = /datum/reagent/alch
	required_container = /obj/item/reagent_containers/glass/alembic

/datum/chemical_reaction/alch/lesserhealth
	name = "lesser health pot"
	id = /datum/reagent/medicine/lesserhealthpot
	results = list(/datum/reagent/medicine/lesserhealthpot = 45) //15 oz
	required_reagents = list(/datum/reagent/alch/syrum_meat = 24, /datum/reagent/alch/syrum_ash = 24)

/datum/chemical_reaction/alch/health //purify minor health pot into half a bottle by using essence of clarity (swampweed)
	name = "health pot purification"
	id = /datum/reagent/medicine/healthpot
	results = list(/datum/reagent/medicine/healthpot = 22.5) //about 7.5 oz
	required_reagents = list(/datum/reagent/medicine/lesserhealthpot = 45, /datum/reagent/alch/syrum_swamp_weed = 24)


/datum/chemical_reaction/alch/greaterhealth //purify health pot into half a bottle of super by using essence of poison (poison berry) which used to be in the old red recipe
	name = "greater health pot purification"
	id = /datum/reagent/medicine/greaterhealthpot
	results = list(/datum/reagent/medicine/greaterhealthpot = 22.5) //about 7.5 oz
	required_reagents = list(/datum/reagent/medicine/healthpot = 45, /datum/reagent/alch/syrum_poison_berry = 24)


/datum/chemical_reaction/alch/lessermana
	name = "lesser mana pot"
	id = /datum/reagent/medicine/lessermanapot
	results = list(/datum/reagent/medicine/lessermanapot = 45)
	required_reagents = list(/datum/reagent/alch/syrum_fish = 24, /datum/reagent/alch/syrum_ash = 24)


/datum/chemical_reaction/alch/mana
	name = "mana pot"
	id = /datum/reagent/medicine/manapot
	results = list(/datum/reagent/medicine/manapot = 22.5)
	required_reagents = list(/datum/reagent/medicine/lessermanapot = 45, /datum/reagent/alch/syrum_swamp_weed = 24)


/datum/chemical_reaction/alch/greatermana
	name = "greater mana pot"
	id = /datum/reagent/medicine/greatermanapot
	results = list(/datum/reagent/medicine/greatermanapot = 22.5)
	required_reagents = list(/datum/reagent/medicine/manapot = 45, /datum/reagent/alch/syrum_poison_berry = 24)

/*documentation: 15 oz = 45 units, 1 oz = 3 units.
2 lesser makes 1 normal bottle, 2 normal makes 1 greater bottle
you need 4 lesser bottles to make 2 normal to make 1 half bottle of greater
8 lesser bottles for 1 bottle of greater
end recipe count: 8 ash, 8 minced meat or fish, 4 swampweed, 2 poisonberry to make 1 bottle of greater*/

/datum/chemical_reaction/alch/salt
	name = "saltify"
	id = "saltify"
	required_reagents = list(/datum/reagent/alch/syrum_stone = 24, /datum/reagent/alch/syrum_ash = 24)

/datum/chemical_reaction/alch/salt/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/salt(location)

/datum/chemical_reaction/alch/ozium
	name = "oziumify"
	id = "oziumify"
	required_reagents = list(/datum/reagent/alch/syrum_poison_berry = 24, /datum/reagent/alch/syrum_swamp_weed = 24)

/datum/chemical_reaction/alch/ozium/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/ozium(location)

/datum/chemical_reaction/alch/moon
	name = "moondustify"
	id = "moondustify"
	required_reagents = list(/datum/reagent/alch/syrum_poison_berry = 24, /datum/reagent/alch/syrum_westleach_leaf = 24)

/datum/chemical_reaction/alch/moon/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/moondust(location)

/datum/chemical_reaction/alch/puresalt
	name = "puresalt"
	id = "puresalt"
	required_reagents = list(/datum/reagent/water/salty = 30) //Boil off the water to get pure salt
	results = list(/datum/reagent/rawsalt = 15)

/datum/chemical_reaction/alch/saltsea
	name = "saltsea"
	id = "saltsea"
	required_reagents = list(/datum/reagent/rawsalt = 15)

/datum/chemical_reaction/alch/saltsea/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/salt(location)

/datum/chemical_reaction/alch/spice
	name = "spiceify"
	id = "spiceify"
	required_reagents = list(/datum/reagent/alch/syrum_swamp_weed = 24, /datum/reagent/alch/syrum_westleach_leaf = 24)

/datum/chemical_reaction/alch/spice/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/spice(location)

/datum/chemical_reaction/alch/pure
	name = "clean moondustify"
	id = "clean moondustify"
	required_reagents = list(/datum/reagent/ozium = 15, /datum/reagent/moondust = 15)

/datum/chemical_reaction/alch/pure/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/moondust_purest(location)


/datum/chemical_reaction/alch/embalm
	name = "embalming fluidification"
	id = "embalmify"
	results = list(/datum/reagent/medicine/enbalming = 45)
	required_reagents = list(/datum/reagent/alch/syrum_stone = 24, /datum/reagent/alch/syrum_honey = 24)