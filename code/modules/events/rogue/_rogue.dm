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
			used = "Tenebris dies venit."
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
		if(ASCEND_FIRST)
			used = "A tremble runs through the leylines of the realm. NEW DECK, MAJOR ARCANA: THE FOOL - UPRIGHT"
		if(ASCEND_WAKENING)
			used = "The sky begins to turn quicker. NEW OMEN, MAJOR ARCANA: THE HANGED MAN - REVERSED"
		if(ASCEND_ASCENDANT)
			used = "A N##EW G$ $OD A@@AKENSS IN GORE AND S3%HIT - <span class='userdanger'>MAJOR ARCANA: THE TOWER - UPRIGHT</span>"
	if(eventreason && used)
		priority_announce(used, "Bad Omen", 'sound/misc/evilevent.ogg')

