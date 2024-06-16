//GLOBAL_LIST_INIT(badomens, list("roundstart"))
GLOBAL_LIST_INIT(badomens, list())

/datum/round_event_control/rogue
	name = null

/datum/round_event_control/rogue/canSpawnEvent()
	. = ..()
	if(!.)
		return .
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.allmig || C.roguefight)
			return FALSE
	if(!name)
		return FALSE

/proc/hasomen(input)
	return (input in GLOB.badomens)

/proc/addomen(input)
	if(hasomen(input))
		return
	testing("Omen added: [input]")
	GLOB.badomens += input

/proc/removeomen(input)
	if(!hasomen(input))
		return
	testing("Omen removed: [input]")
	GLOB.badomens -= input

/datum/round_event_control/proc/badomen(eventreason)
	var/used
	switch(eventreason)
		if(OMEN_ROUNDSTART)
			used = "Zizo."
		if(OMEN_NOLORD)
			used = "The Monarch is dead! We need a new ruler."
		if(OMEN_NOPRIEST)
			used = "The High Priest is dead!"
		if(OMEN_NOBLEDEATH)
			used = "A Noble has perished."
		if(OMEN_SUNSTEAL)
			used = "The Sun, she is wounded!"
		if(OMEN_SKELETONSIEGE)
			used = "Unwelcome visitors!"
	if(eventreason && used)
		priority_announce(used, "Bad Omen", 'sound/misc/evilevent.ogg')

