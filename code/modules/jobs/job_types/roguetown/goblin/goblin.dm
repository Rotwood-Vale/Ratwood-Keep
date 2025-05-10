/datum/job/roguetown/goblin
	title = "Goblins"
	flag = GOBLIN
	department_flag = GOBLIN
	tutorial = ""
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp)
	outfit = null
	outfit_female = null
	display_order = GOBLIN
	selection_color = GOBLIN
	faction = "Station"
	total_positions = 10
	spawn_positions = 10
	min_pq = 3
	max_pq = null
	subclass_cat_rolls = list(CTAG_GOBLIN = 20)
	PQ_boost_divider = 0
	wanderer_examine = FALSE
	foreign_examine = TRUE
	announce_latejoin = FALSE
	always_show_on_latechoices = TRUE

/datum/job/roguetown/goblin/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
