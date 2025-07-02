/datum/round_event_control/rogue/poltergeist
	name = "Violent Poltergeists"
	typepath = /datum/round_event/rogue/poltergeist
	weight = 10
	max_occurrences = 1
	min_players = 0
	req_omen = TRUE
	todreq = list("night", "dawn", "day", "dusk")

/datum/round_event/rogue/poltergeist
	announceWhen = 50
	var/spawncount = 5
	var/list/starts

/datum/round_event_control/rogue/poltergeist/canSpawnEvent()
	if(!LAZYLEN(GLOB.hauntstart))
		return FALSE
	. = ..()

/datum/round_event/rogue/poltergeist/start()
	var/list/spawn_locs = GLOB.hauntstart.Copy()
	if(LAZYLEN(GLOB.hauntstart))
		for(var/i in 1 to spawncount)
			var/obj/effect/landmark/events/haunts/_T = pick_n_take(spawn_locs)
			if(_T)
				_T = get_turf(_T)
				if(isfloorturf(_T))
					new /mob/living/simple_animal/hostile/retaliate/rogue/poltergeist(_T)

	return
