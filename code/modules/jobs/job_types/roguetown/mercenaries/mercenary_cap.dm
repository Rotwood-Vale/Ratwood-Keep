/datum/job/roguetown/mercenary_cap
	title = "Mercenary Captain"
	flag = MERCENARY
	department_flag = MERCENARIES
	tutorial = "Being either appointed or earned through combat. You are the best that the Guild can offer. \
	Ensure that the Guild's reputation and it's members are well maintained.\
	You are expected to ensure that Guild services are not handed out freely."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	outfit = null
	outfit_female = null
	display_order = JDO_MERCENARY
	selection_color = JCOLOR_MERCENARY
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	min_pq = 14
	max_pq = null
	subclass_cat_rolls = list(CTAG_MERCENARY_CAP = 20)
	PQ_boost_divider = 10
	wanderer_examine = FALSE
	foreign_examine = TRUE
	advjob_examine = TRUE
	mercenary_examine = TRUE
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = FALSE
	same_job_respawn_delay = 15 MINUTES

/datum/job/roguetown/mercenary_cap/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
