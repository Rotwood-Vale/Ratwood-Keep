/datum/round_event_control/rogue/desecration
	name = "Descecrated Shrine"
	//typepath = /datum/round_event/rogue/haunts
	weight = 100
	max_occurrences = 999
	min_players = 0
	req_omen = TRUE
	todreq = list("night", "dawn", "day", "dusk")

/datum/round_event_control/rogue/desecration/dendor
	typepath = /datum/round_event/rogue/desecration_dendor
	max_occurrences = 3

/datum/round_event/rogue/desecration_dendor
	announceWhen	= 50
	var/spawncount = 8
	var/list/starts

/datum/round_event_control/rogue/desecration/dendor/canSpawnEvent()
	if(!LAZYLEN(GLOB.hauntstart))
		return FALSE
	if(occurrences >= max_occurrences)
		removeomen(OMEN_DESECRATE_DENDOR)
	. = ..()

/datum/round_event/rogue/desecration_dendor/start()
	var/list/spawn_locs = GLOB.hauntstart.Copy()
	if(LAZYLEN(GLOB.hauntstart))
		for(var/i in 1 to spawncount)
			var/obj/effect/landmark/events/haunts/_T = pick_n_take(spawn_locs)
			if(_T)
				_T = get_turf(_T)
				if(isfloorturf(_T))
					var/random = rand(1, 100)
					if (random < 50) //spawn an evil tree that makes vines
						new /obj/structure/flora/roguetree/evil(_T)
					else if(random < 75) //spawn 3 volfs
						new /mob/living/simple_animal/hostile/retaliate/rogue/wolf(_T)
						new /mob/living/simple_animal/hostile/retaliate/rogue/wolf(_T)
						new /mob/living/simple_animal/hostile/retaliate/rogue/wolf(_T)
					else if(random < 90) //spawn a werewolf
						new /mob/living/simple_animal/hostile/rogue/werewolf(_T)
					else //spawn a dryad
						new /mob/living/simple_animal/hostile/retaliate/rogue/fae/dryad(_T)
							
	return
