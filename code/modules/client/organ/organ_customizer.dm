/datum/organ_customizer
	abstract_type = /datum/organ_customizer
	/// User facing name of the organ customization.
	var/name = "Organ"
	/// List of all /datum/organ_choice's that this customizer can pick from.
	var/list/organ_choices
	/// The default choice from among `organ_choices`.
	var/default_choice
	/// Whether this choice allows the user to choose to be missing an organ.
	var/allows_missing_organ = FALSE
	/// Whether this organ choice defaults to being missing.
	var/default_missing_organ = FALSE

/datum/organ_customizer/New()
	. = ..()
	if(!length(organ_choices))
		CRASH("Organ customizer [type] lacks organ choices")
	if(!default_choice)
		default_choice = organ_choices[1]

/datum/organ_customizer/proc/make_default_organ_entry(datum/preferences/prefs, changed_entry = TRUE)
	return get_organ_entry(prefs, default_choice, changed_entry)

/datum/organ_customizer/proc/create_organ_entry(datum/preferences/prefs, organ_choice_type, changed_entry = TRUE)
	return get_organ_entry(prefs, organ_choice_type, changed_entry)

/datum/organ_customizer/proc/get_organ_entry(datum/preferences/prefs, organ_choice_type, changed_entry = TRUE)
	var/datum/organ_choice/chosen_organ = ORGAN_CHOICE(organ_choice_type)
	var/datum/organ_entry/created_entry = chosen_organ.make_default_organ_entry(prefs, type, changed_entry)
	if(!changed_entry)
		created_entry.missing_organ = default_missing_organ
	return created_entry

/datum/organ_customizer/proc/create_organ_dna(datum/organ_entry/entry, datum/preferences/prefs)
	var/datum/organ_choice/choice = ORGAN_CHOICE(entry.organ_choice_type)
	var/datum/organ_dna/organ_dna = new choice.organ_dna_type()
	imprint_organ_dna(organ_dna, entry, prefs)
	return organ_dna

/datum/organ_customizer/proc/imprint_organ_dna(datum/organ_dna/organ_dna, datum/organ_entry/entry, datum/preferences/prefs)
	if(allows_missing_organ && entry.missing_organ)
		organ_dna.missing_organ = TRUE
	var/datum/organ_choice/choice = ORGAN_CHOICE(entry.organ_choice_type)
	choice.imprint_organ_dna(organ_dna, entry, prefs)

/datum/organ_customizer/proc/validate_entry(datum/preferences/prefs, datum/organ_entry/entry)
	if(entry.missing_organ && !allows_missing_organ)
		entry.missing_organ = FALSE
	var/datum/organ_choice/choice = ORGAN_CHOICE(entry.organ_choice_type)
	choice.validate_entry(prefs, entry)
