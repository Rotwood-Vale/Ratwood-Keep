
SUBSYSTEM_DEF(soundloopers)
	name = "soundloopers"
	wait = 1
	flags = SS_NO_INIT
	priority = FIRE_PRIORITY_DEFAULT
	var/list/processing = list()
	var/list/currentrun = list()

/datum/controller/subsystem/soundloopers/fire(resumed = 0)
	if (!resumed || !currentrun.len)
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/current = src.currentrun
	var/static/count = 0
	if (count) //runtime last run before we could do this.
		var/c = count
		count = 0 //so if we runtime on the Cut, we don't try again.
		current.Cut(1,c+1)

	for(var/i in 1 to length(current))
		var/datum/looping_sound/thing = current[i]
		count++
		if (QDELETED(thing)) // !thing is redundant as QDELETED includes an isnull check
			processing -= thing
			if (MC_TICK_CHECK)
				break
			continue
		thing.sound_loop()
		if (MC_TICK_CHECK)
			break
	if (count)
		current.Cut(1,count+1)
		count = 0
