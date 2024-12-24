/mob/living/simple_animal/shade
	name = "Shade"
	real_name = "Shade"
	desc = ""
	gender = PLURAL
	icon = 'icons/mob/mob.dmi'
	icon_state = "shade"
	icon_living = "shade"
	mob_biotypes = MOB_SPIRIT
	maxHealth = 40
	health = 40
	spacewalk = TRUE
	healable = 0
	speak_emote = list("hisses")
	emote_hear = list("wails.","screeches.")
	response_help_continuous = "puts their hand through"
	response_help_simple = "put your hand through"
	response_disarm_continuous = "flails at"
	response_disarm_simple = "flail at"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"
	speak_chance = 1
	melee_damage_lower = 5
	melee_damage_upper = 12
	attack_verb_continuous = "metaphysically strikes"
	attack_verb_simple = "metaphysically strike"
	minbodytemp = 0
	maxbodytemp = INFINITY
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	stop_automated_movement = 1
	faction = list("cult")
	status_flags = CANPUSH
	movement_type = FLYING
	del_on_death = TRUE
	initial_language_holder = /datum/language_holder/construct

/mob/living/simple_animal/shade/death()
	deathmessage = "lets out a contented sigh as [p_their()] form unwinds."
	..()