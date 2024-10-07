SUBSYSTEM_DEF(icon_smooth)
	name = "Icon Smoothing"
	init_order = INIT_ORDER_ICON_SMOOTHING
	wait = 1
	priority = FIRE_PRIOTITY_SMOOTHING
	flags = SS_TICKER
//	flags = SS_NO_FIRE
	///Blueprints assemble an image of what pipes/manifolds/wires look like on initialization, and thus should be taken after everything's been smoothed
	var/list/blueprint_queue = list()
	var/list/smooth_queue = list()
	var/list/deferred = list()

/datum/controller/subsystem/icon_smooth/fire()
	var/list/cached = smooth_queue
	while(cached.len)
		var/atom/A = cached[cached.len]
		cached.len--
		if (A.flags_1 & INITIALIZED_1)
			smooth_icon(A)
		else
			deferred += A
		if (MC_TICK_CHECK)
			return

	if (!cached.len)
		if (deferred.len)
			smooth_queue = deferred
			deferred = cached
		else
			can_fire = 0

/datum/controller/subsystem/icon_smooth/Initialize()
	var/list/queue = smooth_queue
	smooth_queue = list()
	for(var/V in queue)
		var/atom/smoothing_atom = queue[length(queue)]
		queue.len--
		if(QDELETED(smoothing_atom) || !(smoothing_atom.smooth & SMOOTH_QUEUED) || !smoothing_atom.z)
			continue
		smooth_icon(smoothing_atom)
		CHECK_TICK
	queue = blueprint_queue
	blueprint_queue = list()
	var/atom/movable/AM
	var/turf/T
	for(var/item in queue)
		AM = item
		T = AM.loc
		if(T && AM)
			T.add_blueprints(AM)

	return ..()
