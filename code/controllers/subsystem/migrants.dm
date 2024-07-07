SUBSYSTEM_DEF(migrants)
	name = "Migrants"
	wait = 1 SECONDS
	runlevels = RUNLEVEL_GAME

/datum/controller/subsystem/migrants/Initialize()
	return ..()

/datum/controller/subsystem/migrants/fire(resumed)
	return

/datum/controller/subsystem/migrants/proc/get_active_migrants()
	return
