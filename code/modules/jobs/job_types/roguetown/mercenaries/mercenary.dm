/datum/job/roguetown/mercenary
	title = "Mercenary"
	flag = MERCENARIES
	department_flag = MERCENARIES
	faction = "Station"
	total_positions = 6		//Was 3 Grenz and 3 Desert, merging together to 6 total.
	spawn_positions = 6
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	tutorial = "Blood stains your hands and the coins you hold. You are a sell-sword, a mercenary, a contractor of war. Where you come from, what you are, who you serve.. none of it matters. What matters is that the mammon flows to your pocket."
	display_order = JDO_MERCENARY
	selection_color = JCOLOR_MERCENARY
	min_pq = 0		//Will be handled by classes if PQ limiting is needed.
	max_pq = null
	outfit = null	//Handled by classes
	outfit_female = null
	advclass_cat_rolls = list(CTAG_MERCENARY = 20)
	always_show_on_latechoices = TRUE

/datum/job/roguetown/mercenary/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
