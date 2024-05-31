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
		if("roundstart")
			used = "Zizo."
		if("importantdeath")
			used = "A Noble has perished."
		if("skellysiege")
			used = "Unwelcome visitors!"
		if("nolord")
			used = "The Monarch is dead! We need a new ruler."
		if("nopriest")
			used = "The High Priest is dead!"
		if("sunsteal")
			used = "The Sun, she is wounded!"
	if(eventreason && used)
		priority_announce(used, "Bad Omen", 'sound/misc/evilevent.ogg')

