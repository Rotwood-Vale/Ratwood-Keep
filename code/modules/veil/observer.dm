/mob/dead/observer/rogue/veil
	name = "veil ghost"

	/// Tracks if the user has collected a toll from the ground
	var/collected_toll = FALSE

	/// Tracks if the user has paid the toll to the carriageman
	var/paid_toll = FALSE

/mob/dead/observer/rogue/veil/Initialize(mapload)
	. = ..()
	GLOB.veil_ghost_list += src

	// this sucks, but the ghost is initialized before the mind is set
	addtimer(CALLBACK(src, PROC_REF(intro)), 1 SECONDS)

	// give them a toll after 15 minutes
	addtimer(CALLBACK(src, PROC_REF(give_toll)), 15 MINUTES)

/mob/dead/observer/rogue/veil/proc/intro()
	to_chat(usr, span_green("I feel ripped away from my own body...\nMy spirit is now bound to the veil...\nI must wander this alternate reality and find a toll... The Carriageman awaits by the bastion."))

/mob/dead/observer/rogue/veil/Destroy()
	GLOB.veil_ghost_list -= src
	return ..()

/// Gives the user a toll
/mob/dead/observer/rogue/veil/proc/give_toll()
	src << sound('sound/misc/carriage4.ogg', 0, 0 ,0, 50)
	to_chat(src, span_bold("Necra extends a dying arm to give you a toll."))
	collected_toll = TRUE
