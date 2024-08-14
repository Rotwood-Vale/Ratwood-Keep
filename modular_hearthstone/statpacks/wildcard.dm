// Statpacks for those wildcards out there who like a challenge; basically PUNISHING or random archetypes.
/datum/statpack/wildcard/wretched
	name = "Wretched"
	desc = "The cruelty of Enigma leaves many in its wake - you among them. But with her terrible eye turned elsewhere, perhaps it is time for your fortune to be made..."
	stat_array = list(STAT_STRENGTH = -2, STAT_PERCEPTION = -2, STAT_INTELLIGENCE = -2, STAT_CONSTITUTION = -2, STAT_ENDURANCE = -2, STAT_SPEED = -2, STAT_FORTUNE = 3)

/datum/statpack/wildcard/fated
	name = "Fated"
	desc = "The first or the last - let destiny's fickle loom decree what your fate shall be."
	stat_array = list(STAT_STRENGTH = list(-1, 1), STAT_PERCEPTION = list(-1, 1), STAT_INTELLIGENCE = list(-1, 1), STAT_CONSTITUTION = list(-1, 1), STAT_ENDURANCE = list(-1, 1), STAT_SPEED = list(-1, 1), STAT_FORTUNE = list(-1, 1))

/datum/statpack/wildcard/frail
	name = "Frail"
	desc = "The growing dark limns your vision more with every passing day: your flesh and mind are failing you, and destiny has turned her gaze from you. How will your tale endure such hardship?"
	stat_array = list(STAT_STRENGTH = -4, STAT_PERCEPTION = -4, STAT_INTELLIGENCE = -4, STAT_CONSTITUTION = -4, STAT_ENDURANCE = -4, STAT_SPEED = -4, STAT_FORTUNE = -4)
