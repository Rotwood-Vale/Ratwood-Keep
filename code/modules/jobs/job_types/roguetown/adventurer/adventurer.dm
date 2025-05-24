
/datum/job/roguetown/adventurer
	title = "Adventurer"
	flag = MIGRANT
	tutorial = "Hero of nothing, adventurer by trade. \
	Whatever led you to this fate is up to the wind to decide, \
	and you've never fancied yourself for much other than the thrill. \
	Someday your pride is going to catch up to you, \
	and you're going to find out why most men don't end up in the annals of history."
	department_flag = FOREIGNERS
	faction = "Station"
	allowed_races = RACES_VERY_SHUNNED_UP
	tutorial = "People of all walks of life have fled the rot, seeking refuge in the many rumored safe havens of the world. \
				One of these refugees, you have left everything behind to seek a new life in a foreign land."


	outfit = null
	outfit_female = null

	selection_color = JCOLOR_FOREIGNER
	show_in_credits = TRUE
	min_pq = 0
	max_pq = null

	subclass_cat_rolls = list(CTAG_ADVENTURER = 15)

	wanderer_examine = TRUE
	foreign_examine = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	announce_latejoin = FALSE


/datum/job/roguetown/adventurer/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
