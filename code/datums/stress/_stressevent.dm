/datum/stressevent
	var/timer
	var/stressadd
	var/desc
	var/time_added
	var/max_stacks = 0 //if higher than 0, can stack

/datum/stressevent/proc/get_desc(mob/living/user)
	return desc

/datum/stressevent/test
	timer = 5 SECONDS
	stressadd = 3
	desc = span_red("This is a positive test event.")

/datum/stressevent/testr
	timer = 5 SECONDS
	stressadd = -3
	desc = span_green("This is a negative test event.")
