/datum/job/roguetown/adventurer/villager
	title = "Towner"
	flag = VILLAGER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 50
	spawn_positions = 50
	allowed_races = CLOTHED_RACES_TYPES
	tutorial = "You've lived in this shithole for effectively all your life. You are not an explorer, nor exactly a warrior in many cases. You're just some average poor bastard who thinks they'll be something someday."

	outfit = null
	outfit_female = null
	bypass_lastclass = TRUE
	bypass_jobban = FALSE
	display_order = JDO_VILLAGER
	isvillager = TRUE
	give_bank_account = TRUE
	min_pq = -15
	max_pq = null
	wanderer_examine = FALSE
	advjob_examine = TRUE

/*
/datum/job/roguetown/adventurer/villager/New()
	. = ..()
	for(var/X in GLOB.peasant_positions)
		peopleiknow += X
		peopleknowme += X
	for(var/X in GLOB.yeoman_positions)
		peopleiknow += X
	for(var/X in GLOB.church_positions)
		peopleiknow += X
	for(var/X in GLOB.garrison_positions)
		peopleiknow += X
	for(var/X in GLOB.noble_positions)
		peopleiknow += X*/
