
SUBSYSTEM_DEF(todchange)
	name = "todchange"
	flags = SS_NO_INIT
	priority = 1
	var/list/processing = list()
	var/list/currentrun = list()
	processing_flag = PROCESSING_TODCHANGE

/datum/controller/subsystem/todchange/fire(resumed = 0)
	if (!resumed || !currentrun.len)
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/current = src.currentrun

//	if(!current.len)
//		testing("nothing to update [rand(1,9)]")

	while(current.len)
		var/obj/effect/sunlight/L = current[current.len]
		current.len--
		if (!L || QDELETED(L))
			processing -= L
			if (MC_TICK_CHECK)
				return
			continue
		L.update()
		STOP_PROCESSING(SStodchange, L)
		if (MC_TICK_CHECK)
			return
