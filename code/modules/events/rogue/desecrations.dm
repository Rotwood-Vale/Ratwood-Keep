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
		message_admins("does not have desecrate dendor omen")
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
