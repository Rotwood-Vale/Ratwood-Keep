/datum/round_event_control/rogue/desecration_dendor
	name = "Descecrated Dendor"
	typepath = /datum/round_event/rogue/desecration_dendor
	weight = 1000
	max_occurrences = 2
	min_players = 0
	req_omen = TRUE
	todreq = list("night", "dawn", "day", "dusk")
	earliest_start = 3 MINUTES

/datum/round_event_control/rogue/desecration_dendor/canSpawnEvent()
	if(hasomen(OMEN_DESECRATE_DENDOR) == 0)
		return FALSE
	if(!LAZYLEN(GLOB.hauntstart))
		return FALSE
	. = ..()

/datum/round_event/rogue/desecration_dendor
	announceWhen	= 1
	var/spawncount = 5
	var/list/starts

/datum/round_event/rogue/desecration_dendor/start()
	var/list/spawn_locs = GLOB.hauntstart.Copy()
	if(LAZYLEN(GLOB.hauntstart))
		for(var/i in 1 to spawncount)
			var/obj/effect/landmark/events/haunts/_T = pick_n_take(spawn_locs)
			if(_T)
				_T = get_turf(_T)
				if(isfloorturf(_T))
					var/random = rand(1, 100)					
					if (random < 50) //50% spawn an evil tree that makes vines
						new /datum/spacevine_controller(_T, null)
						new /obj/structure/flora/roguetree/evil(_T)
					else if(random < 75) //25% spawn 3 rous
						new /mob/living/simple_animal/hostile/retaliate/rogue/bigrat(_T)
						new /mob/living/simple_animal/hostile/retaliate/rogue/bigrat(_T)
						new /mob/living/simple_animal/hostile/retaliate/rogue/bigrat(_T)
					else if(random < 90) //15% spawn a volfs
						new /mob/living/simple_animal/hostile/retaliate/rogue/wolf(_T)
						new /mob/living/simple_animal/hostile/retaliate/rogue/wolf(_T)
						new /mob/living/simple_animal/hostile/retaliate/rogue/wolf(_T)
					else //10% spawn a dryad
						new /mob/living/simple_animal/hostile/retaliate/rogue/fae/dryad/dendor(_T)
					
	return
