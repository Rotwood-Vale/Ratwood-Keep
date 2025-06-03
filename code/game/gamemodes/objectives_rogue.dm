/datum/objective/bandit
	name = "bandit"
	explanation_text = "Feed valuables to the idol."

/datum/objective/bandit/check_completion()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C.banditcontrib >= C.banditgoal)
			return TRUE

/datum/objective/bandit/update_explanation_text()
	..()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C)
			explanation_text = "Feed [C.banditgoal] mammon to an idol of greed."
		else
			explanation_text = "Pray to ZIZO."


/datum/objective/delf
	name = "delf"
	explanation_text = "Feed honeys to the mother."

/datum/objective/delf/check_completion()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C.delfcontrib >= C.delfgoal)
			return TRUE

/datum/objective/delf/update_explanation_text()
	..()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C)
			explanation_text = "Feed [C.delfgoal] honeys to the mother."
		else
			explanation_text = "Pray to ZIZO."

/datum/objective/werewolf
	name = "conquer"
	explanation_text = "Put an end to the vampire scourge in Rockhill, or unite with them against the forces of the Successors."
	team_explanation_text = "The feud between werewolves and vampires reaches back to the dawn of time. Will the two factions destroy each other, or find a way to coexist and face the mortals of Rockhill together?"
	triumph_count = 5

/datum/objective/werewolf/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "werewolf")
			return TRUE

/datum/objective/vampire
	name = "conquer"
	explanation_text = "Put an end to the werewolf menace in Rockhill, or unite with them against the forces of the Successors."
	team_explanation_text = "The feud between werewolves and vampires reaches back to the dawn of time. Will the two factions destroy each other, or find a way to coexist and face the mortals of Rockhill together?"
	triumph_count = 5

/datum/objective/vampire/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "vampire")
			return TRUE

/datum/objective/serial_killer
	name = "KILL"
	explanation_text = "The visions haunt me... I know that if I do not kill at least one person every night, I will be the one to die."
	flavor = "The overwhelming need to kill."
