/datum/preferences/proc/redmoon_character_pref_load(savefile/S)
	S["be_russian"]										>> be_russian
	S["donator_bonus_received"]    						>> donator_bonus_received

	S["bark_id"] 										>> bark_id
	S["bark_speed"] 									>> bark_speed
	S["bark_pitch"] 									>> bark_pitch
	S["bark_variance"] 									>> bark_variance

	// family_changes
	S["spouse_ckey"]									>> spouse_ckey
	S["family_surname"]									>> family_surname
	S["family_genitals"] 								>> family_genitals

	S["prefer_old_chat"]								>> prefer_old_chat

	if(!family_genitals)
		family_genitals = list()

	_load_loadout(S)

/datum/preferences/proc/redmoon_character_pref_save(savefile/S)
	WRITE_FILE(S["be_russian"]							, be_russian)
	WRITE_FILE(S["donator_bonus_received"]				, donator_bonus_received)

	WRITE_FILE(S["bark_id"]								, bark_id)
	WRITE_FILE(S["bark_speed"]							, bark_speed)
	WRITE_FILE(S["bark_pitch"]							, bark_pitch)
	WRITE_FILE(S["bark_variance"]						, bark_variance)

	WRITE_FILE(S["prefer_old_chat"]						, prefer_old_chat)

	if(loadout)
		WRITE_FILE(S["loadout"] 						, loadout.type)
	else
		WRITE_FILE(S["loadout"] 						, null)

	WRITE_FILE(S["spouse_ckey"] 						, spouse_ckey) // family_changes - ckey второй половинки
	WRITE_FILE(S["family_surname"] 						, family_surname) // family_changes - фамилия семьи
	WRITE_FILE(S["family_genitals"] 					, family_genitals) // family_changes - проверка на половые органы партнёра

/datum/preferences/proc/redmoon_copy_character(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE)
	character.spouse_ckey = spouse_ckey // family_changes
	character.family_surname = family_surname // family_changes
	character.family_genitals = family_genitals

/datum/preferences/proc/_load_loadout(S)
	var/loadout_type
	S["loadout"] >> loadout_type
	if (loadout_type)
		loadout = new loadout_type()
