/datum/surgery_step/graggarritual
	name = "Graggar ritual"
	time = 45 SECONDS
	accept_hand = TRUE
	possible_locs = list(BODY_ZONE_CHEST)
	implements = list(
		TOOL_SCALPEL = 80,
		TOOL_SHARP = 60,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	surgery_flags = SURGERY_INCISED | SURGERY_BROKEN

/datum/surgery_step/graggarritual/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
    if(target.has_status_effect(/datum/status_effect/debuff/alreadygraggared))
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

    if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
        display_results(user, target, span_notice("You lack the devotion to perform Graggar's ritual!"),
            "[user] attempts to cut [target]'s body, but fails.",
            "[user] attempts to cut [target]'s body.")
        return FALSE

    var/chosen_meat = null
    if(H.mind.assigned_role == "Manatarms")
        chosen_meat = /obj/item/graggarflesh/maa
    else if(H.mind.assigned_role == "Templar")
        chosen_meat = /obj/item/graggarflesh/templar
    else if(H.mind.assigned_role == "Watchman")
        chosen_meat = /obj/item/graggarflesh/watchman
    else if(H.mind.assigned_role == "Vanguard")
        chosen_meat = /obj/item/graggarflesh/vanguard
    else if(H.mind.assigned_role == "Knight" || H.mind.assigned_role == "Retinue Captain")
        chosen_meat = /obj/item/graggarflesh/knight
    else if(H.mind.assigned_role == "Priest")
        chosen_meat = /obj/item/graggarflesh/priest
    else if(H.mind.assigned_role == "Duke" || H.mind.assigned_role == "Duke consort" || H.mind.assigned_role == "Duchess" || H.mind.assigned_role == "Duchess consort" || H.mind.assigned_role == "Heir" || H.mind.assigned_role == "Heiress")
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
    target.apply_status_effect(/datum/status_effect/debuff/alreadygraggared)
    return TRUE

/obj/item/graggarflesh
    name = "Flesh"
    desc = "A piece of meat harvested from a fallen foe."
    icon = 'icons/roguetown/items/food.dmi'  
    icon_state = "meatcutlet"          


// Man-at-Arms Flesh
/obj/item/graggarflesh/maa
    name = "Manatarms's flesh"
    desc = "A tough, sinewy piece of meat from a Man-at-Arms."

    proc/consume_flesh(mob/living/carbon/human/M, mob/user)
        if(!isliving(M) || M.stat == DEAD)
            to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
            return FALSE
        if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/buff/maameat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/buff/maameat)
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
        if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/buff/templarmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/buff/templarmeat)
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
        if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/buff/watchmanmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/buff/watchmanmeat)
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
        if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/buff/vanguardmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/buff/vanguardmeat)
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
        if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/buff/knightmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/buff/knightmeat)
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
        if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/buff/priestmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/buff/priestmeat)
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
        if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
            to_chat(user, span_warning("Only followers of Graggar can do such things..."))
            return FALSE
        if(M.has_status_effect(/datum/status_effect/buff/royalmeat))
            to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
            return FALSE
        M.apply_status_effect(/datum/status_effect/buff/royalmeat)
        to_chat(user, span_notice("[M] now tastes the flesh of royalty."))
        qdel(src)
        return TRUE

    attack(mob/M, mob/user)
        if(ishuman(M))
            consume_flesh(M, user)
        return ..()
