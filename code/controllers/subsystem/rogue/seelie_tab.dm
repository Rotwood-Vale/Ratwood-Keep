

/mob/living/carbon/human/proc/Turnlight()
	set name = "Seelie glow"
	set category = "Seelie"


	switch(src.light_power)
		if(!0)
			src.set_light(0, 0, null)
		if(0)
			src.set_light(3, 1, "#d4fcac")

/mob/living/carbon/proc/switchaura()
	set name = "Luck aura"
	set category = "Seelie"


	var/mob/living/carbon/User = src
	switch(User.aura)
		if(TRUE)
			User.aura = FALSE
		if(FALSE)
			User.aura = TRUE
