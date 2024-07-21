
/*
	Once again we are back here, ha hahaha....
	Also this is basically just a shell for the drifter queue system to manipulate.
*/
/datum/job/roguetown/drifters
	title = "Drifter"
	flag = WAVE_DRIFTER
	department_flag = PEASANTS
	faction = "Station"

	// Everyone can be a homeless man looking for work!
	allowed_races = RACES_ALL_KINDS

	tutorial = "A drifter of unknown origin searching things such as fame, fortune, and perhaps just some work to do."


	outfit = null
	outfit_female = null

	display_order = JDO_DRIFTER
	show_in_credits = FALSE
	max_pq = null
	min_pq = -999
	wanderer_examine = TRUE
	advjob_examine = TRUE

	total_positions = 0
	spawn_positions = 0
	advclass_cat_rolls = list(CTAG_PILGRIM = 10, CTAG_ADVENTURER = 5, CTAG_CHALLENGE = 5)

/datum/job/roguetown/drifters/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

		if(GLOB.adventurer_hugbox_duration)
			///FOR SOME RETARDED FUCKING REASON THIS REFUSED TO WORK WITHOUT A FUCKING TIMER IT JUST FUCKED SHIT UP
			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_start)), 1)

