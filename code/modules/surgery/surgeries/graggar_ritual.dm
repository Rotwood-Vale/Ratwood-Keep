
/datum/surgery/graggar_ritual
    steps = list(
        /datum/surgery_step/incise,
        /datum/surgery_step/saw,
        /datum/surgery_step/graggarritual,
        /datum/surgery_step/cauterize
    )
    target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
    possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/graggarritual
    name = "Graggar's ritual"
    implements = list(
        TOOL_CUT = 10,
    )
    target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
    time = 30 SECONDS
    surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_BROKEN
    skill_min = SKILL_LEVEL_NOVICE

/datum/surgery_step/graggarritual/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
    if(target.has_status_effect(/datum/status_effect/alreadygraggared))
        display_results(user, target, span_notice("The [target]'s most delicious parts are already taken!"),
            "[user] chops [target]'s body.",
            "[user] chops [target]'s body.")
        return FALSE

    var/mob/living/carbon/H = target
    if(!H.mind || !H.mind.assigned_role)
        display_results(user, target, span_notice("[target] is NOT a worthy OPPONENT!"),
            "[user] attempts to cut [target]'s body, but finds nothing special.",
            "[user] attempts to cut [target]'s body.")
        return FALSE

    if(!HAS_TRAIT(user, "TRAIT_ORGAN_EATER") || !HAS_TRAIT(user, "TRAIT_MATTHIOS_EYES"))
        display_results(user, target, span_notice("You lack the devotion to perform Graggar's ritual!"),
            "[user] attempts to cut [target]'s body, but fails.",
            "[user] attempts to cut [target]'s body.")
        return FALSE

    var/chosen_meat = null
    if(H.mind.assigned_role == "manatarms")  
        chosen_meat = /obj/item/graggarflesh/maa
    else if(H.mind.assigned_role == "Templar")
        chosen_meat = /obj/item/graggarflesh/templar
    else if(H.mind.assigned_role == "Watchman")
        chosen_meat = /obj/item/graggarflesh/watchman
    else if(H.mind.assigned_role == "Vanguard")
        chosen_meat = /obj/item/graggarflesh/vanguard
    else if(H.mind.assigned_role == "Knight")
        chosen_meat = /obj/item/graggarflesh/knight
    else if(H.mind.assigned_role == "Priest")
        chosen_meat = /obj/item/graggarflesh/priest
    else if(H.mind.assigned_role == "Duke" || H.mind.assigned_role == "Duchess" || H.mind.assigned_role == "Heir" || H.mind.assigned_role == "Heiress")
        chosen_meat = /obj/item/graggarflesh/royal
    else
        display_results(user, target, span_notice("[target] is NOT a worthy OPPONENT!"),
            "[user] attempts to cut [target]'s body, but finds nothing special.",
            "[user] attempts to cut [target]'s body.")
        return FALSE

    display_results(user, target, span_notice("[user] starts to cut some meat from [target]'s spine!"),
        "[user] cuts a slice from [target]'s body.",
        "[user] cuts a slice from [target]'s body.")

    new chosen_meat(target.loc)
    target.apply_status_effect(/datum/status_effect/alreadygraggared)
    return TRUE

/datum/status_effect/alreadygraggared
    id = "alreadygraggared"
    alert_type = /atom/movable/screen/alert/status_effect/alreadygraggared
    duration = -1 // permanent until removed

    on_apply()
        if(ishuman(owner))
            var/mob/living/carbon/human/H = owner
            H.change_stat("endurance", -2)
            H.change_stat("strength", -2)
            H.change_stat("constitution", -2)
        return TRUE

    on_remove()
        if(ishuman(owner))
            var/mob/living/carbon/human/H = owner
            H.change_stat("endurance", 2)
            H.change_stat("strength", 2)
            H.change_stat("constitution", 2)
        return TRUE

/atom/movable/screen/alert/status_effect/alreadygraggared
    name = "Already Graggared"
    desc = "Your body has been harvested by Graggar's ritual, leaving you weakened."
    icon_state = "debuff"

/obj/item/graggarflesh
    name = "Flesh"
    desc = "A piece of meat harvested from a fallen foe."
    icon_state = "meatsteak"

// Man-at-Arms Flesh
/obj/item/graggarflesh/maa
    name = "Manatarms's flesh"
    desc = "A tough, sinewy piece of meat from a Man-at-Arms."

    proc/consume_flesh(mob/living/carbon/human/M, mob/user)
        if(!isliving(M) || M.stat == DEAD)
            to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
            return FALSE
        if(!HAS_TRAIT(user, "TRAIT_ORGAN_EATER"))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/maameat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/maameat)
        to_chat(user, span_notice("[M] now tastes the flesh of a Man-at-Arms."))
        qdel(src)
        return TRUE

    attack(mob/M, mob/user)
        if(ishuman(M))
            consume_flesh(M, user)
        return ..()

// Templar's Flesh
/obj/item/graggarflesh/templar
    name = "Templar's flesh"
    desc = "A sanctified cut from a Templar's body, radiating faint warmth."

    proc/consume_flesh(mob/living/carbon/human/M, mob/user)
        if(!isliving(M) || M.stat == DEAD)
            to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
            return FALSE
        if(!HAS_TRAIT(user, "TRAIT_ORGAN_EATER"))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/templarmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/templarmeat)
        to_chat(user, span_notice("[M] now tastes the flesh of a Templar."))
        qdel(src)
        return TRUE

    attack(mob/M, mob/user)
        if(ishuman(M))
            consume_flesh(M, user)
        return ..()

// Watchman's Flesh
/obj/item/graggarflesh/watchman
    name = "Watchman's flesh"
    desc = "A lean piece of meat, taken from a vigilant Watchman."

    proc/consume_flesh(mob/living/carbon/human/M, mob/user)
        if(!isliving(M) || M.stat == DEAD)
            to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
            return FALSE
        if(!HAS_TRAIT(user, "TRAIT_ORGAN_EATER"))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/watchmanmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/watchmanmeat)
        to_chat(user, span_notice("[M] now tastes the flesh of a Watchman."))
        qdel(src)
        return TRUE

    attack(mob/M, mob/user)
        if(ishuman(M))
            consume_flesh(M, user)
        return ..()

// Vanguard's Flesh
/obj/item/graggarflesh/vanguard
    name = "Vanguard's flesh"
    desc = "A sturdy chunk of flesh from a Vanguard, brimming with resilience."

    proc/consume_flesh(mob/living/carbon/human/M, mob/user)
        if(!isliving(M) || M.stat == DEAD)
            to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
            return FALSE
        if(!HAS_TRAIT(user, "TRAIT_ORGAN_EATER"))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/vanguardmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/vanguardmeat)
        to_chat(user, span_notice("[M] now tastes the flesh of a Vanguard."))
        qdel(src)
        return TRUE

    attack(mob/M, mob/user)
        if(ishuman(M))
            consume_flesh(M, user)
        return ..()

// Knight's Flesh
/obj/item/graggarflesh/knight
    name = "Knight's flesh"
    desc = "A noble cut of meat, harvested from a Knight's frame."

    proc/consume_flesh(mob/living/carbon/human/M, mob/user)
        if(!isliving(M) || M.stat == DEAD)
            to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
            return FALSE
        if(!HAS_TRAIT(user, "TRAIT_ORGAN_EATER"))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/knightmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/knightmeat)
        to_chat(user, span_notice("[M] now tastes the flesh of a Knight."))
        qdel(src)
        return TRUE

    attack(mob/M, mob/user)
        if(ishuman(M))
            consume_flesh(M, user)
        return ..()

// Priest's Flesh
/obj/item/graggarflesh/priest
    name = "Priest's flesh"
    desc = "A tender piece of meat, infused with a hint of divine essence."

    proc/consume_flesh(mob/living/carbon/human/M, mob/user)
        if(!isliving(M) || M.stat == DEAD)
            to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
            return FALSE
        if(!HAS_TRAIT(user, "TRAIT_ORGAN_EATER"))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/priestmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/priestmeat)
        to_chat(user, span_notice("[M] now tastes the flesh of a Priest."))
        qdel(src)
        return TRUE

    attack(mob/M, mob/user)
        if(ishuman(M))
            consume_flesh(M, user)
        return ..()

// Royal Flesh
/obj/item/graggarflesh/royal
    name = "Royal flesh"
    desc = "An exquisite piece of meat from royalty, rich and succulent."

    proc/consume_flesh(mob/living/carbon/human/M, mob/user)
        if(!isliving(M) || M.stat == DEAD)
            to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
            return FALSE
        if(!HAS_TRAIT(user, "TRAIT_ORGAN_EATER"))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/royalmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/royalmeat)
        to_chat(user, span_notice("[M] now tastes the flesh of royalty."))
        qdel(src)
        return TRUE

    attack(mob/M, mob/user)
        if(ishuman(M))
            consume_flesh(M, user)
        return ..()

// Status Effects for Flesh Consumption
/datum/status_effect/maameat
    id = "maameat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/maameat
    effectedstats = list("endurance" = 1)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/maameat
    name = "Man-at-Arms Flesh"
    desc = "The flesh of a Man-at-Arms, granting an increase in endurance."
    icon_state = "meatsteak"

/datum/status_effect/templarmeat
    id = "templarmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/templarmeat
    effectedstats = list("constitution" = 1)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/templarmeat
    name = "Templar Flesh"
    desc = "The flesh of a Templar, granting a boost to constitution."
    icon_state = "meatsteak"

/datum/status_effect/watchmanmeat
    id = "watchmanmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/watchmanmeat
    effectedstats = list("perception" = 1)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/watchmanmeat
    name = "Watchman Flesh"
    desc = "The flesh of a Watchman, granting an increase in perception."
    icon_state = "meatsteak"

/datum/status_effect/vanguardmeat
    id = "vanguardmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/vanguardmeat
    effectedstats = list("speed" = 1)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/vanguardmeat
    name = "Vanguard Flesh"
    desc = "The flesh of a Vanguard, granting a boost in speed."
    icon_state = "meatsteak"

/datum/status_effect/knightmeat
    id = "knightmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/knightmeat
    effectedstats = list("strength" = 1)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/knightmeat
    name = "Knight Flesh"
    desc = "The flesh of a Knight, granting an increase in strength."
    icon_state = "meatsteak"

/datum/status_effect/priestmeat
    id = "priestmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/priestmeat
    effectedstats = list("intelligence" = 2)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/priestmeat
    name = "Priest Flesh"
    desc = "The flesh of a Priest, granting a boost to intelligence."
    icon_state = "meatsteak"

/datum/status_effect/royalmeat
    id = "royalmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/royalmeat
    effectedstats = list("fortune" = 3)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/royalmeat
    name = "Royal Flesh"
    desc = "The flesh of royalty, granting an increase in luck."
    icon_state = "meatsteak"
