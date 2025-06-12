/datum/objective/serial_killer
	name = "KEEP KILLING"
	explanation_text = "The visions haunt me... I know that if I do not kill at least one person every 2 days, I will be the one to die."
	flavor = "The overwhelming need to kill."

/datum/objective/serial_killer/check_completion()
	var/SK = owner?.current.stat
	if(SK != DEAD)
		return TRUE
	else
		return FALSE
