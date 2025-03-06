
/datum/chemical_reaction/alch
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
	required_reagents = list(/datum/reagent/medicine/lesserhealthpot = 45, /datum/reagent/alch/syrum_swamp_weed = 24)

	
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
