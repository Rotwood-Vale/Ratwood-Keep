/datum/job/roguetown/pilgrim
	title = "Pilgrim"
	flag = PILGRIM
	department_flag = PEASANTS
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	allowed_races = RACES_VERY_SHUNNED_UP
	tutorial = "Fleeing misfortune you head your way towards Rockhill, you're not a soldier or an explorer, but a humble migrant trying to look for a better life, if you get to survive the trip that is."

	outfit = null
	outfit_female = null
	bypass_lastclass = TRUE
	banned_leprosy = FALSE

	advclass_cat_rolls = list(CTAG_PILGRIM = 10)
	PQ_boost_divider = 10

	display_order = JDO_PILGRIM
	min_pq = -20
	max_pq = null
	wanderer_examine = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	same_job_respawn_delay = 0

/datum/job/roguetown/pilgrim/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
