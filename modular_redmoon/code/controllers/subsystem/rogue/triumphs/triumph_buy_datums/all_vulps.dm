/datum/triumph_buy/zybantine_maximum
	triumph_buy_id = "Zybantinemaxx"
	desc = "Everyone is a vulps from Zybantine!"
	triumph_cost = 250
	category = TRIUMPH_CAT_ROUND_EFX
	pre_round_only = TRUE
	visible_on_active_menu = TRUE

/datum/triumph_buy/zybantine_maximum/on_buy()
	SStriumphs.post_equip_calls[triumph_buy_id] = src

/datum/triumph_buy/zybantine_maximum/on_removal()
	var/found_duplicate = FALSE
	for(var/datum/triumph_buy/cur_datum in SStriumphs.active_triumph_buy_queue)
		if(cur_datum.category != TRIUMPH_CAT_ROUND_EFX)
			continue
		if(cur_datum == src)
			continue
		if(istype(cur_datum, src.type))
			found_duplicate = TRUE

	// We found no same type effects in there outside of us
	if(!found_duplicate) 
		SStriumphs.post_equip_calls.Remove(triumph_buy_id)

/datum/triumph_buy/zybantine_maximum/on_activate(mob/living/carbon/human/H)
//	if(is_species(A, /datum/species/goblin)) idk this is funny lets have it happen one more time...
//		return
	H.set_species(/datum/species/vulpkanin, FALSE)
	H.client?.prefs.random_character()
	 // Yeah, you gotta do this after setting species haha! theres an after_creation() proc that goes with set_species and this handles the stats in it.
	H.roll_stats()
