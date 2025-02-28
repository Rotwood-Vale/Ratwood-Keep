GLOBAL_VAR_INIT(hugbox_duration, 40 SECONDS)
GLOBAL_VAR_INIT(hugbox_duration_still, 3 MINUTES)

/datum/job/roguetown/refugee
	title = "Refugee"
	flag = REFUGEE
	department_flag = FOREIGNERS
	faction = "Station"
	total_positions = 25
	spawn_positions = 25
	allowed_races = RACES_VERY_SHUNNED_UP
	tutorial = "People of all walks of life have fled the rot, seeking refuge in the many rumored safe havens of the world. \
				One of these refugees, you have left everything behind to seek a new life in a foreign land."


	outfit = null
	outfit_female = null

	display_order = JDO_REFUGEE
	selection_color = JCOLOR_FOREIGNER
	show_in_credits = TRUE
	min_pq = 0
	max_pq = null

	subclass_cat_rolls = list(CTAG_REFUGEE = 5)
	PQ_boost_divider = 10

	wanderer_examine = TRUE
	foreign_examine = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 15 MINUTES
	announce_latejoin = FALSE


/datum/job/roguetown/refugee/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
