GLOBAL_VAR_INIT(mercenary_hugbox_duration, 40 SECONDS)
GLOBAL_VAR_INIT(mercenary_hugbox_duration_still, 3 MINUTES)

/datum/job/roguetown/mercenary
	title = "Mercenary"
	flag = MERCENARY
	department_flag = MERCENARIES
	faction = "Station"
	total_positions = 8 //two of each type
	spawn_positions = 8
	allowed_races = RACES_VERY_SHUNNED_UP
	tutorial = ""

	outfit = null
	outfit_female = null

	display_order = JDO_MERCENARY
	show_in_credits = FALSE
	min_pq = 0
	max_pq = null
	
	advclass_cat_rolls = list(CTAG_MERCENARY = 20)

	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 15 MINUTES


/datum/job/roguetown/mercenary/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
