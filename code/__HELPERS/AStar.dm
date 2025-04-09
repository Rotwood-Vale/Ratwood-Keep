/*
A Star pathfinding algorithm
Returns a list of tiles forming a path from A to B, taking dense objects as well as walls, and the orientation of
windows along the route into account.
Use:
your_list = AStar(start location, end location, moving atom, distance proc, max nodes, maximum node depth, minimum distance to target, adjacent proc, atom id, turfs to exclude, check only simulated)

Optional extras to add on (in order):
Distance proc : the distance used in every A* calculation (length of path and heuristic)
MaxNodes: The maximum number of nodes the returned path can be (0 = infinite)
Maxnodedepth: The maximum number of nodes to search (default: 30, 0 = infinite)
Mintargetdist: Minimum distance to the target before path returns, could be used to get
near a target, but not right to it - for an AI mob with a gun, for example.
Adjacent proc : returns the turfs to consider around the actually processed node
Simulated only : whether to consider unsimulated turfs or not (used by some Adjacent proc)

Also added 'exclude' turf to avoid travelling over; defaults to null

Actual Adjacent procs :

	/turf/proc/reachableAdjacentTurfs : returns reachable turfs in cardinal directions (uses simulated_only)


*/
#define PF_TIEBREAKER 0.005
//tiebreker weight.To help to choose between equal paths
//////////////////////
//datum/PathNode object
//////////////////////
#define MASK_ODD 85
#define MASK_EVEN 170


//A* nodes variables
/datum/PathNode
	var/turf/source //turf associated with the PathNode
	var/datum/PathNode/prevNode //link to the parent PathNode
	var/f		//A* Node weight (f = g + heuristic)
	var/g		//A* movement cost variable
	var/heuristic		//A* heuristic variable
	var/nodes_traversed //count the number of Nodes traversed
	var/bf		//bitflag for dir to expand.Some sufficiently advanced motherfuckery

/datum/PathNode/New(s,p,pg,ph,pnt,_bf)
	source = s
	setp(p, pg, ph, pnt)
	bf = _bf

/datum/PathNode/proc/setp(p,pg,ph,pnt)
	prevNode = p
	g = pg
	heuristic = ph
	calc_f()
	nodes_traversed = pnt

/datum/PathNode/proc/calc_f()
	f = g + heuristic*(1 + PF_TIEBREAKER)

//////////////////////
//A* procs
//////////////////////

//the weighting function, used in the A* algorithm
/proc/PathWeightCompare(datum/PathNode/a, datum/PathNode/b)
	return a.f - b.f

//reversed so that the Heap is a MinHeap rather than a MaxHeap
/proc/HeapPathWeightCompare(datum/PathNode/a, datum/PathNode/b)
	return b.f - a.f

//wrapper that returns an empty list if A* failed to find a path
/proc/get_path_to(caller, end, dist, maxnodes, maxnodedepth = 30, mintargetdist, adjacent = /turf/proc/reachableTurftest, id=null, turf/exclude=null)
	var/l = SSpathfinder.mobs.getfree(caller)
	while(!l)
		stoplag(3)
		l = SSpathfinder.mobs.getfree(caller)
	var/list/path = AStar(caller, end, dist, maxnodes, maxnodedepth, mintargetdist, adjacent,id, exclude)

	SSpathfinder.mobs.found(l)
	if(!path)
		path = list()
	return path

/proc/cir_get_path_to(caller, end, dist, maxnodes, maxnodedepth = 30, mintargetdist, adjacent = /turf/proc/reachableTurftest, id=null, turf/exclude=null)
	var/l = SSpathfinder.circuits.getfree(caller)
	while(!l)
		stoplag(3)
		l = SSpathfinder.circuits.getfree(caller)
	var/list/path = AStar(caller, end, dist, maxnodes, maxnodedepth, mintargetdist, adjacent,id, exclude)
	SSpathfinder.circuits.found(l)
	if(!path)
		path = list()
	return path

/proc/AStar(caller, _end, dist, maxnodes, maxnodedepth = 30, mintargetdist, adjacent = /turf/proc/reachableTurftest, id=null, turf/exclude=null)
	//sanitation
	var/turf/end = get_turf(_end)
	var/turf/start = get_turf(caller)
	if(!start || !end)
		stack_trace("Invalid A* start or destination")
		return FALSE
	if( start.z != end.z || start == end ) //no pathfinding between z levels
		return FALSE
	if(maxnodes)
		//if start turf is farther than maxnodes from end turf, no need to do anything
		if(call(start, dist)(end, caller) > maxnodes)
			return FALSE
		maxnodedepth = maxnodes //no need to consider path longer than maxnodes
	var/datum/Heap/open = new /datum/Heap(/proc/HeapPathWeightCompare) //the open list
	var/list/openc = new() //open list for node check
	var/list/path = null //the returned path, if any
	//initialization
	var/datum/PathNode/cur = new /datum/PathNode(start,null,0,call(start,dist)(end, caller),0,15,1)//current processed turf
	open.Insert(cur)
	openc[start] = cur
	//then run the main loop
	while(!open.IsEmpty() && !path)
		cur = open.Pop() //get the lower f turf in the open list
		//get the lower f node on the open list
		//if we only want to get near the target, check if we're close enough
		var/closeenough
		if(mintargetdist)
			closeenough = call(cur.source,dist)(end, caller) <= mintargetdist

		//found the target turf (or close enough), let's create the path to it
		if(cur.source == end || closeenough)
			path = list(cur.source)
			while(cur.prevNode)
				cur = cur.prevNode
				path.Add(cur.source)
			break
		if(maxnodedepth && (cur.nodes_traversed > maxnodedepth)) //if too many steps, don't process that path
			cur.bf = 0
			CHECK_TICK
			continue
		//get adjacents turfs using the adjacent proc, checking for access with id
		for(var/dir_to_check in GLOB.cardinals)
			if(cur.bf & dir_to_check)
				var/T = get_step(cur.source,dir_to_check)
				if(T != exclude)
					var/datum/PathNode/CN = openc[T]  //current checking turf
					var/reverse = GLOB.reverse_dir[dir_to_check]
					var/newg = cur.g + call(cur.source,dist)(T, caller) // add the travel distance between these two tiles to the distance so far
					if(CN)
					//is already in open list, check if it's a better way from the current turf
						CN.bf &= 15^reverse //we have no closed, so just cut off exceed dir.00001111 ^ reverse_dir.We don't need to expand to checked turf.
						if((newg < CN.g) )
							if(call(cur.source,adjacent)(caller, T, id))
								CN.setp(cur,newg,CN.heuristic,cur.nodes_traversed+1)
								open.ReSort(CN)//reorder the changed element in the list
					else
					//is not already in open list, so add it
						if(call(cur.source,adjacent)(caller, T, id))
							CN = new(T,cur,newg,call(T,dist)(end, caller),cur.nodes_traversed+1,15^reverse)
							open.Insert(CN)
							openc[T] = CN
		cur.bf = 0
		CHECK_TICK
	//reverse the path to get it from start to finish
	if(path)
		for(var/i = 1 to round(0.5*path.len))
			path.Swap(i,path.len-i+1)
	openc = null
	//cleaning after us
	return path

//Returns adjacent turfs in cardinal directions that are reachable
/turf/proc/reachableAdjacentTurfs(caller, ID)
	var/list/L = new()
	var/turf/T

	for(var/k in 1 to GLOB.cardinals.len)
		T = get_step(src,GLOB.cardinals[k])
		if(!T)
			continue
		if(!T.density && !LinkBlockedWithAccess(T,caller, ID))
			L.Add(T)
	return L

/turf/proc/reachableTurftest(caller, turf/T, ID)
	if(T && !T.density && !LinkBlockedWithAccess(T,caller, ID))
		return TRUE

/turf/proc/LinkBlockedWithAccess(turf/T, caller, ID)
	var/adir = get_dir(src, T)
	var/rdir = GLOB.reverse_dir[adir]
	for(var/obj/O in T)
		if(!O.CanAStarPass(ID, rdir, caller))
			return TRUE
	for(var/mob/living/M in T)
		if(!M.CanPass(caller, src))
			return TRUE
	return FALSE
