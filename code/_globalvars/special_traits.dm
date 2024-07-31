GLOBAL_LIST_INIT(special_traits, build_special_traits())

#define SPECIAL_TRAIT(trait_type) GLOB.special_traits[trait_type]

/proc/build_special_traits()
	. = list()
	for(var/type in typesof(/datum/special_trait))
		if(is_abstract(type))
			continue
		.[type] = new type()
	return .

/// Applies random special trait IF the client has specials enabled in prefs
/proc/apply_random_special_trait(mob/living/carbon/human/character, client/player)
    if(!player)
        player = character.client
    if(!player)
        return
    if(!player.prefs.get_special_trait)
        return
    var/special_type = get_random_special_for_char(character, player)
    if(!special_type) // Ineligible for all of them, somehow
        return
    apply_special_trait(character, special_type)

/proc/get_random_special_for_char(mob/living/carbon/human/character, client/player)
	var/list/eligible_weight = list()
	for(var/trait_type in GLOB.special_traits)
		var/datum/special_trait/special = SPECIAL_TRAIT(trait_type)
		var/datum/job/job
		if(character.job)
			job = SSjob.name_occupations[character.job]
		if(!isnull(special.allowed_jobs))
			if(!job)
				continue
			if(!(job.type in special.allowed_jobs))
				continue
		if(!isnull(special.restricted_jobs) && job && (job.type in special.restricted_jobs))
			continue
		if(!isnull(special.allowed_races) && !(character.dna.species.type in special.allowed_races))
			continue
		if(!isnull(special.allowed_migrants))
			if(!character.migrant_type)
				continue
			if(!(character.migrant_type in special.allowed_migrants))
				continue
		if(!isnull(special.restricted_migrants) && character.migrant_type && (character.migrant_type in special.restricted_migrants))
			continue
		if(!isnull(special.restricted_races) && (character.dna.species.type in special.allowed_races))
			continue
		if(!isnull(special.allowed_sexes) && !(character.gender in special.allowed_sexes))
			continue
		if(!isnull(special.allowed_ages) && !(character.age in special.allowed_ages))
			continue
		if(!isnull(special.allowed_patrons) && !(character.patron in special.allowed_patrons))
			continue
		if(!isnull(special.restricted_traits))
			var/has_trait
			for(var/trait in special.restricted_traits)
				if(HAS_TRAIT(character, trait))
					has_trait = TRUE
					break
			if(has_trait)
				continue
		if(!special.can_apply(character))
			continue
		eligible_weight[trait_type] = special.weight

	if(!length(eligible_weight))
		return null

	return pickweight(eligible_weight)

/proc/apply_special_trait(mob/living/carbon/human/character, trait_type, silent)
    var/datum/special_trait/special = SPECIAL_TRAIT(trait_type)
    special.on_apply(character, silent)
    if(!silent && special.greet_text)
        to_chat(character, special.greet_text)
