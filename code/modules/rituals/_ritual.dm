/datum/ritual
	var/name = "debug ritual"

	var/circle = null // Servantry, Transmutation, Fleshcrafting, etc...

	var/center_requirement = /obj/item

	// This is absolutely fucking terrible. I tried to do it with lists but it just didn't work and
	//kept runtiming. Something something, can't access list inside a datum.
	//I couldn't find a more efficient solution to do this, I'm sorry. -7
	var/n_req = null
	var/e_req = null
	var/s_req = null
	var/w_req = null

	var/function // a proc
	var/favor_cost = 0 //universal currency
	var/difficulty = 0 //required unholy skill to cast this
	var/revealchance = 0 //the chance to ping people with the sense evil trait when this ritual is completed
	var/casttime = 0 //how long of a doafter it takes to complete a ritual, important for things like stunrunes
