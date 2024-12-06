/datum/chemical_reaction/reagent_explosion
	name = "Generic explosive"
	id = "reagent_explosion"
	var/strengthdiv = 10
	var/modifier = 0

/datum/chemical_reaction/reagent_explosion/on_reaction(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	var/lastkey = holder.my_atom.fingerprintslast
	log_game("Reagent explosion reaction occurred at [AREACOORD(T)]. Last Fingerprint: [lastkey ? lastkey : "N/A"]." )
	var/datum/effect_system/reagents_explosion/e = new()
	e.set_up(modifier + round(created_volume/strengthdiv, 1), T, 0, 0)
	e.start()
	holder.clear_reagents()

/datum/chemical_reaction/reagent_explosion/on_reaction(datum/reagents/holder, created_volume)
	//do_explosion()
	..()

/datum/chemical_reaction/reagent_explosion/potassium_explosion
	name = "Explosion"
	id = "potassium_explosion"
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/potassium = 1)
	strengthdiv = 20

/datum/chemical_reaction/reagent_explosion/potassium_explosion/holyboom
	name = "Holy Explosion"
	id = "holyboom"
	required_reagents = list(/datum/reagent/water/holywater = 1, /datum/reagent/potassium = 1)

/datum/chemical_reaction/reagent_explosion/potassium_explosion/holyboom/on_reaction(datum/reagents/holder, created_volume)
	if(created_volume >= 150)
		playsound(get_turf(holder.my_atom), 'sound/blank.ogg', 80, FALSE, round(created_volume/48))
		strengthdiv = 8
	..()

/datum/chemical_reaction/gunpowder
	name = "Gunpowder"
	id = /datum/reagent/gunpowder
	results = list(/datum/reagent/gunpowder = 3)
	required_reagents = list(/datum/reagent/saltpetre = 1, /datum/reagent/charcoal = 1, /datum/reagent/sulfur = 1)

/datum/chemical_reaction/reagent_explosion/gunpowder_explosion
	name = "Gunpowder Kaboom"
	id = "gunpowder_explosion"
	required_reagents = list(/datum/reagent/gunpowder = 1)
	required_temp = 474
	strengthdiv = 6
	modifier = 1
	mix_message = span_boldannounce("Sparks start flying around the gunpowder!")

/datum/chemical_reaction/reagent_explosion/gunpowder_explosion/on_reaction(datum/reagents/holder, created_volume)
	//addtimer(CALLBACK(src, PROC_REF(do_explosion), holder, created_volume), rand(5 SECONDS, 10 SECONDS))
	..()
