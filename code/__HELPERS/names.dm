/proc/lizard_name(gender)
	if(gender == MALE)
		return "[pick(GLOB.lizard_names_male)]-[pick(GLOB.lizard_names_male)]"
	else
		return "[pick(GLOB.lizard_names_female)]-[pick(GLOB.lizard_names_female)]"

/proc/moth_name()
	return "[pick(GLOB.moth_first)] [pick(GLOB.moth_last)]"
