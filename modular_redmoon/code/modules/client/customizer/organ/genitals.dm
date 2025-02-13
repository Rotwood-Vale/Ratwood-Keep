//                                                                       //

/datum/customizer/organ/penis
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer/organ/penis/is_allowed(datum/preferences/prefs)
	return TRUE

//                                                                       //

/datum/customizer/organ/testicles
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer/organ/testicles/is_allowed(datum/preferences/prefs)
	return TRUE

//                                                                       //

/datum/customizer/organ/breasts
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer/organ/breasts/is_allowed(datum/preferences/prefs)
	return TRUE

//                                                                       //

/datum/customizer/organ/vagina
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer/organ/vagina/is_allowed(datum/preferences/prefs)
	return TRUE

//                                                                       //

/datum/customizer_entry/organ/butt
	var/butt_size = DEFAULT_BUTT_SIZE

/datum/customizer/organ/butt
	abstract_type = /datum/customizer/organ/butt
	name = "Butt"
	allows_disabling = TRUE
	default_disabled = FALSE

/datum/customizer_choice/organ/butt
	abstract_type = /datum/customizer_choice/organ/butt
	name = "Butt"
	customizer_entry_type = /datum/customizer_entry/organ/butt
	organ_type = /obj/item/organ/butt
	organ_slot = ORGAN_SLOT_BUTT
	organ_dna_type = /datum/organ_dna/butt

/datum/customizer_choice/organ/butt/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	butt_entry.butt_size = sanitize_integer(butt_entry.butt_size, MIN_BUTT_SIZE, MAX_BUTT_SIZE, DEFAULT_BUTT_SIZE)

/datum/customizer_choice/organ/butt/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/butt/butt_dna = organ_dna
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	butt_dna.butt_size = butt_entry.butt_size

/datum/customizer_choice/organ/butt/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	dat += "<br>Butt size: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=butt_size''>[find_key_by_value(GLOB.named_butt_sizes, butt_entry.butt_size)]</a>"

/datum/customizer_choice/organ/butt/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	switch(href_list["customizer_task"])
		if("butt_size")
			var/named_size = input(user, "Choose your butt size:", "Character Preference", find_key_by_value(GLOB.named_butt_sizes, butt_entry.butt_size)) as anything in GLOB.named_butt_sizes
			if(isnull(named_size))
				return
			var/new_size = GLOB.named_butt_sizes[named_size]
			butt_entry.butt_size = sanitize_integer(new_size, MIN_BUTT_SIZE, MAX_BUTT_SIZE, DEFAULT_BUTT_SIZE)

/datum/customizer/organ/butt/human
	customizer_choices = list(/datum/customizer_choice/organ/butt/human)

/datum/customizer_choice/organ/butt/human
	sprite_accessories = list(/datum/sprite_accessory/butt/pair)
	allows_accessory_color_customization = FALSE

/datum/customizer/organ/butt/animal
	customizer_choices = list(/datum/customizer_choice/organ/butt/animal)

/datum/customizer_choice/organ/butt/animal
	sprite_accessories = list(
		/datum/sprite_accessory/butt/pair
		)
