/datum/special_trait/natural_talent
    name = "Natural Talent"
    greet_text = span_notice("Ever since I was little, with enough effort, I could do anything I put my mind to")

/datum/special_trait/natural_talent/on_apply(mob/living/carbon/human/character, silent)
    character.change_stat("strength", 1)
    character.change_stat("speed", 1)
    character.change_stat("perception", 1)
    character.change_stat("constitution", 1)
    character.change_stat("endurance", 1)
    character.change_stat("intelligence", 1)

/datum/special_trait/nimrod
    name = "Nimrod"
    greet_text = span_warning("In the past I learned slower than my peers, and I tend to be clumsy")

/datum/special_trait/nimrod/on_apply(mob/living/carbon/human/character, silent)
    character.change_stat("speed", -2)
    character.change_stat("intelligence", -4)
