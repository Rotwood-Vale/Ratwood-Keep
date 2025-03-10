/datum/triumph_buy/grenzelhoft_maximum
	triumph_buy_id = "Grenzelhoftmaxx"
	desc = "Everyone is a human!"
	triumph_cost = 500
	category = TRIUMPH_CAT_ROUND_EFX
	pre_round_only = TRUE
	visible_on_active_menu = TRUE

	// When the goblin buy was enabled this actually worked to stop it from being buyable
	//conflicts_with = list(/datum/triumph_buy/goblin_class)

/datum/triumph_buy/grenzelhoft_maximum/on_buy()
	SStriumphs.post_equip_calls[triumph_buy_id] = src
	to_chat(world, span_redtext("Благодаря усилиям [usr] остров Энигма наконец-то переходит во владения Королевства Гренцельхофт. И первым же решением оказалось выселение абсолютно всех нелюдей в Зибантию. Удивительно"))

/datum/triumph_buy/grenzelhoft_maximum/on_removal()
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

/datum/triumph_buy/grenzelhoft_maximum/on_activate(mob/living/carbon/human/H)
	if(is_species(H, /datum/species/goblin)) // idk this is funny lets have it happen one more time...
		return
	if(is_species(H, /datum/species/human/northern))
		return
	H.set_species(/datum/species/human/northern, FALSE)
	H.client?.prefs.headshot_link = null
	H.client?.prefs.nudeshot_link = null
	H.client?.prefs.customizer_entries = list()
	H.client?.prefs.validate_customizer_entries()
	H.client?.prefs.reset_all_customizer_accessory_colors()
	H.client?.prefs.randomize_all_customizer_accessories()
	H.client?.prefs.reset_descriptors()
	var/acceptable = list("Tomboy", "Bob", "Curly Short")
	H.hairstyle = pick(acceptable)
	var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
	var/num = rand(0, 6)
	switch(num)
		if(0)
			return set_eye_color(H, "#865900", "#865900")
		if(1)
			return set_eye_color(H, "#06b400", "#06b400")
		if(2)
			return set_eye_color(H, "#312f27", "#312f27")
		if(3)
			return set_eye_color(H, "#008e83", "#008e83")
		if(4)
			return set_eye_color(H, "#002d8e", "#002d8e")
		if(5)
			return set_eye_color(H, "#c16c00", "#c16c00")
		else
			return set_eye_color(H, "#ff0000", "#ff0000")
	eyes.update_accessory_colors()
	var/datum/bodypart_feature/hair/facial/hair = H.get_bodypart_feature_of_slot(BODYPART_FEATURE_HAIR)
	var/num2 = rand(0, 6)
	switch(num2)
		if(0)
			return hair.accessory_type = /datum/sprite_accessory/hair/head/bald
		if(1)
			return hair.accessory_type = /datum/sprite_accessory/hair/head/bob
		if(2)
			return hair.accessory_type = /datum/sprite_accessory/hair/head/boddicker
		if(3)
			return hair.accessory_type = /datum/sprite_accessory/hair/head/braided
		if(4)
			return hair.accessory_type = /datum/sprite_accessory/hair/head/lowbun
		if(5)
			return hair.accessory_type = /datum/sprite_accessory/hair/head/largebun
		else
			return hair.accessory_type = /datum/sprite_accessory/hair/head/combover
	H.update_body()
	H.update_hair()
	H.update_body_parts()
	 // Yeah, you gotta do this after setting species haha! theres an after_creation() proc that goes with set_species and this handles the stats in it.
	H.roll_stats()
