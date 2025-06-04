/datum/migrant_wave/werewolf
	name = "Roving Pack"
	downgrade_wave = /datum/migrant_wave/werewolf_down_one
	can_roll = TRUE
	weight = 2 //Significantly Rarer than bandits, due to the fact these guys can convert.
	max_spawns = 1
	roles = list(
		/datum/migrant_role/werewolf = 2,
	)
	greet_text = "You are a part of a roving pair- Scouts sent by the Alpha of your pack, to begin converting and spreading your lupine mark to far-off lands. You are strangers to this land, and uncertain in these times of trial- but the pack takes care of it's own. Assist one another, and above all- Stay alive."

/datum/migrant_wave/werewolf_down_one
	name = "Isolated Packmate"
	can_roll = TRUE
	weight = 4 //Half as rare. 
	max_spawns = 2 //Can roll more often. 
	roles = list(
		/datum/migrant_role/werewolf = 1,
	)
	greet_text = "You were seperated during a fight, driven from your ancient, ancestral grounds - you have known nothing but the beat of freedom; the pounding of your heart during nightly hunts... Yet now, alone - you are forced into a new decision. Shall you try and cast off your curse, to live a solitary life- or shall you create a pack anew?"

