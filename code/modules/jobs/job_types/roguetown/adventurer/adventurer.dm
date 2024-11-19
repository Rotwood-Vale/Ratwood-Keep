GLOBAL_LIST_EMPTY(billagerspawns)

GLOBAL_VAR_INIT(hugbox_duration, 40 SECONDS)
GLOBAL_VAR_INIT(hugbox_duration_still, 3 MINUTES)

/datum/job/roguetown/adventurer
	title = "Adventurer"
	flag = ADVENTURER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 20
	spawn_positions = 20
	allowed_races = RACES_VERY_SHUNNED_UP
	tutorial = "Hero of nothing, adventurer by trade. Whatever led you to this fate is up to the wind to decide, and you've never fancied yourself for much other than the thrill. Someday your pride is going to catch up to you, and you're going to find out why most men don't end up in the annals of history."


	outfit = null
	outfit_female = null

	display_order = JDO_ADVENTURER
	show_in_credits = FALSE
	min_pq = 0
	max_pq = null
	
	advclass_cat_rolls = list(CTAG_ADVENTURER = 5)
	PQ_boost_divider = 10

	wanderer_examine = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 15 MINUTES


/datum/job/roguetown/adventurer/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
