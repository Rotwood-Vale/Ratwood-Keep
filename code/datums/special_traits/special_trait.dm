/datum/special_trait
    abstract_type = /datum/special_trait
    var/name
    var/greet_text
    var/weight = 100
    var/list/allowed_sexes
    var/list/allowed_races
    var/list/allowed_ages
    var/list/allowed_patrons
    /// Not yet implemented
    var/list/allowed_jobs
    /// Not yet implemented
    var/list/allowed_migrants

/datum/special_trait/proc/on_apply(mob/living/carbon/human/character, silent)
    return
