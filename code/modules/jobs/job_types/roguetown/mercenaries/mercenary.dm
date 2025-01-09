/datum/job/roguetown/mercenary
	title = "Mercenary"
	flag = MERCENARY
	department_flag = MERCENARIES
	tutorial = "Вы путешествуете по землям и используете свой меч и мастерство ради маммонов и крови. \
	Вы верны только тому, кто больше заплатит, и самому себе, а не лорду, как обычные солдаты. \
	Возможно, вы вступили в гильдию, возможно, являетесь членом святого ордена, возможно, вы просто выше обычного бандита."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	outfit = null
	outfit_female = null
	display_order = JDO_MERCENARY
	selection_color = JCOLOR_MERCENARY
	faction = "Station"
	total_positions = 10
	spawn_positions = 10 //subject to change, was originally 6
	min_pq = 5
	max_pq = null
	subclass_cat_rolls = list(CTAG_MERCENARY = 20)
	PQ_boost_divider = 10
	wanderer_examine = FALSE
	foreign_examine = TRUE
	advjob_examine = TRUE
	mercenary_examine = TRUE
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
