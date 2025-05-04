/datum/preferences/proc/redmoon_character_pref_load(savefile/S)
	S["bark_id"] 										>> bark_id
	S["bark_speed"] 									>> bark_speed
	S["bark_pitch"] 									>> bark_pitch
	S["bark_variance"] 									>> bark_variance

	// family_changes
	S["spouse_ckey"]									>> spouse_ckey
	S["family_surname"]									>> family_surname
	S["family_genitals"] 								>> family_genitals
	S["allow_latejoin_family"] 							>> allow_latejoin_family

	if(!islist(family_genitals) || !LAZYLEN(family_genitals))
		family_genitals = list("Male", "Female")

	// rumors_addition
	S["use_rumors"]										>> use_rumors

	// Sethand remoake
	S["hand_ckey"]										>> hand_ckey

	// String
	S["rumors_prefered_behavior_in_combat"]				>> rumors_prefered_behavior_in_combat
	S["rumors_prefered_behavior_with_problems"]			>> rumors_prefered_behavior_with_problems
	S["rumors_prefered_behavior_in_work"]				>> rumors_prefered_behavior_in_work
	S["rumors_genitals"]								>> rumors_genitals
	S["rumors_family"]									>> rumors_family

	// Списки
	S["rumors_prefered_behavior_in_bed"]				>> rumors_prefered_behavior_in_bed
	S["rumors_prefered_beginnings"]						>> rumors_prefered_beginnings
	S["rumors_prefered_races"]							>> rumors_prefered_races
	S["rumors_prefered_ways_to_relax"]					>> rumors_prefered_ways_to_relax
	S["rumors_secret"]									>> rumors_secret
	S["rumors_overal"]									>> rumors_overal
	S["rumors_overal_good"]								>> rumors_overal_good
	S["rumors_dangerous"]								>> rumors_dangerous

	if(!islist(rumors_secret))
		rumors_secret = list()
	if(!islist(rumors_prefered_beginnings))
		rumors_prefered_beginnings = list()
	if(!islist(rumors_prefered_races))
		rumors_prefered_races = list()
	if(!islist(rumors_prefered_behavior_in_bed))
		rumors_prefered_behavior_in_bed = list()
	if(!islist(rumors_prefered_ways_to_relax))
		rumors_prefered_ways_to_relax = list()
	if(!islist(rumors_overal))
		rumors_overal = list()
	if(!islist(rumors_overal_good))
		rumors_overal_good = list()
	if(!islist(rumors_dangerous))
		rumors_dangerous = list()

	_load_loadout(S)

/datum/preferences/proc/redmoon_character_pref_save(savefile/S)
	WRITE_FILE(S["bark_id"]								, bark_id)
	WRITE_FILE(S["bark_speed"]							, bark_speed)
	WRITE_FILE(S["bark_pitch"]							, bark_pitch)
	WRITE_FILE(S["bark_variance"]						, bark_variance)

	if(loadout)
		WRITE_FILE(S["loadout"] 						, loadout.type)
	else
		WRITE_FILE(S["loadout"] 						, null)

	WRITE_FILE(S["spouse_ckey"] 						, spouse_ckey) // family_changes - ckey второй половинки
	WRITE_FILE(S["family_surname"] 						, family_surname) // family_changes - фамилия семьи
	WRITE_FILE(S["family_genitals"] 					, family_genitals) // family_changes - проверка на половые органы партнёра
	WRITE_FILE(S["allow_latejoin_family"] 				, allow_latejoin_family) // family_changes - разрешение на семью после раундстарта

	WRITE_FILE(S["use_rumors"]							, use_rumors) // rumors_addition

	WRITE_FILE(S["hand_ckey"]							, hand_ckey) // sethand remake

	// String
	WRITE_FILE(S["rumors_prefered_behavior_with_problems"]	, rumors_prefered_behavior_with_problems) // rumors_addition
	WRITE_FILE(S["rumors_prefered_behavior_in_work"]	, rumors_prefered_behavior_in_work) // rumors_addition
	WRITE_FILE(S["rumors_prefered_behavior_in_combat"]	, rumors_prefered_behavior_in_combat) // rumors_addition
	WRITE_FILE(S["rumors_genitals"]						, rumors_genitals) // rumors_addition
	WRITE_FILE(S["rumors_family"]						, rumors_family) // rumors_addition

	// Списки
	WRITE_FILE(S["rumors_prefered_beginnings"]			, rumors_prefered_beginnings) // rumors_addition
	WRITE_FILE(S["rumors_prefered_races"]				, rumors_prefered_races) // rumors_addition
	WRITE_FILE(S["rumors_prefered_behavior_in_bed"]		, rumors_prefered_behavior_in_bed) // rumors_addition
	WRITE_FILE(S["rumors_prefered_ways_to_relax"]		, rumors_prefered_ways_to_relax) // rumors_addition
	WRITE_FILE(S["rumors_secret"]						, rumors_secret) // rumors_addition
	WRITE_FILE(S["rumors_overal"]						, rumors_overal) // rumors_addition
	WRITE_FILE(S["rumors_overal_good"]					, rumors_overal_good) // rumors_addition
	WRITE_FILE(S["rumors_dangerous"]					, rumors_dangerous) // rumors_addition

/datum/preferences/proc/redmoon_copy_character(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE)
	// family_changes
	character.spouse_ckey = spouse_ckey
	character.family_surname = family_surname
	character.family_genitals = family_genitals 
	character.allow_latejoin_family = allow_latejoin_family 

 	// rumors_addition
	character.use_rumors = use_rumors

	// String
	character.rumors_prefered_behavior_in_combat = rumors_prefered_behavior_in_combat
	character.rumors_prefered_behavior_with_problems = rumors_prefered_behavior_with_problems
	character.rumors_prefered_behavior_in_work = rumors_prefered_behavior_in_work
	character.rumors_genitals = rumors_genitals
	character.rumors_family = rumors_family

	// Списки
	character.rumors_prefered_behavior_in_bed = rumors_prefered_behavior_in_bed
	character.rumors_prefered_ways_to_relax = rumors_prefered_ways_to_relax
	character.rumors_prefered_beginnings= rumors_prefered_beginnings
	character.rumors_prefered_races = rumors_prefered_races
	character.rumors_secret = rumors_secret
	character.rumors_overal = rumors_overal
	character.rumors_overal_good = rumors_overal_good
	character.rumors_dangerous = rumors_dangerous

/datum/preferences/proc/_load_loadout(S)
	var/loadout_type
	S["loadout"] >> loadout_type
	if (loadout_type)
		loadout = new loadout_type()

/datum/preferences/proc/redmoon_save_preferences(savefile/S)
	WRITE_FILE(S["redmoon_toggles"] 					, redmoon_toggles) // gain_stress_indicator
	WRITE_FILE(S["detailed_family_loging"] 				, detailed_family_loging) // family_changes
	WRITE_FILE(S["be_russian"]							, be_russian) // translation
	WRITE_FILE(S["donator_bonus_received"]				, donator_bonus_received) // PQ bonus for supporters

/datum/preferences/proc/redmoon_load_preferences(savefile/S)
	S["redmoon_toggles"] 								>> redmoon_toggles

	// family_changes
	S["detailed_family_loging"] 						>> detailed_family_loging

	// translation
	S["be_russian"]										>> be_russian

	// PQ bonus for supporters
	S["donator_bonus_received"]    						>> donator_bonus_received
