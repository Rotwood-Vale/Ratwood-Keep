/datum/job/roguetown/towner
	title = "Towner"
	flag = VILLAGER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 75
	spawn_positions = 75
	allowed_races = RACES_VERY_SHUNNED_UP
	tutorial = "You've lived in this shithole for effectively all your life. You are not an explorer, nor exactly a warrior in many cases. You're just some average poor bastard who thinks they'll be something somedae. You own one of the decrepit houses around here... You think you remember stashing a spare key just under the door."
	subclass_cat_rolls = list(CTAG_TOWNER = 20)
	outfit = null
	outfit_female = null
	bypass_lastclass = TRUE
	banned_leprosy = FALSE
	display_order = JDO_VILLAGER
	give_bank_account = TRUE
	min_pq = -15
	max_pq = null
	wanderer_examine = FALSE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	same_job_respawn_delay = 0



/datum/job/roguetown/towner/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
