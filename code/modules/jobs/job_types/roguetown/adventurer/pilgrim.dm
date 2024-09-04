/datum/job/roguetown/pilgrim
	title = "Pilgrim"
	flag = PILGRIM
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 0
	spawn_positions = 0		//Disables round-start spawn of pilgrims but allows migrant waves via total positions. Pilgrim = Towners now.
	allowed_races = RACES_ALL_KINDS
	tutorial = "Fleeing misfortune you head your way towards Rockhill, you're not a soldier or an explorer, but a humble migrant trying to look for a better life, if you get to survive the trip that is."

	outfit = null
	outfit_female = null
	bypass_lastclass = TRUE
	banned_leprosy = FALSE

	advclass_cat_rolls = list(CTAG_PILGRIM = 20)
	PQ_boost_divider = 10

	display_order = JDO_PILGRIM
	min_pq = -20
	max_pq = null
	wanderer_examine = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = FALSE		//Migrant only now; Towner handles regular-joining pilgrims. Same exact roles, really.
	same_job_respawn_delay = 0

/datum/job/roguetown/pilgrim/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

		if(GLOB.adventurer_hugbox_duration)
			///FOR SOME RETARDED FUCKING REASON THIS REFUSED TO WORK WITHOUT A FUCKING TIMER IT JUST FUCKED SHIT UP
			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_start)), 1)
