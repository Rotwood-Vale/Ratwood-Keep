/datum/subclass/harlequin
    name = "Harlequin spy"
    tutorial = "You were not a rat that decided to leave the ship, but the ship itself disappeared one day. And your proposal is to find a new scene now. What will your performance be? One of service? Of glory? Or of heresy?"
    allowed_sexes = list(MALE, FEMALE)
    allowed_races = list(/datum/species/elf/dark, /datum/species/tieberian)
    outfit = /datum/outfit/job/roguetown/mercenary/harlequin
    maximum_possible_slots = 10
    min_pq = 0
    torch = FALSE
    category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/harlequin/pre_equip(mob/living/carbon/human/H)
    ..()
    shoes = /obj/item/clothing/shoes/roguetown/armor/harlequinshoes
    neck = /obj/item/clothing/neck/roguetown/gorget
    mask = /obj/item/clothing/mask/rogue/facemask/steel/harlequin
    gloves = /obj/item/clothing/gloves/roguetown/fingerless
    belt = /obj/item/storage/belt/rogue/leather/black
    pants = /obj/item/clothing/under/roguetown/trou/leather
    armor = /obj/item/clothing/suit/roguetown/armor/leather/harlequinsuit
    beltr = /obj/item/storage/keyring/mercenary
    beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/parrydagger
    backr = /obj/item/storage/backpack/rogue/satchel
    backl = /obj/item/storage/belt/rogue/pouch/coins/poor

    if (H.mind)
        H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
        H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
        H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
        H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
        H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/shadowstep)
        H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mimicry)
        H.change_stat("strength", 2)
        H.change_stat("endurance", 2)
        H.change_stat("perception", 1)
        H.change_stat("speed", 2)
        ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

/obj/effect/proc_holder/spell/invoked/shadowstep
    name = "Shadow Step"
    overlay_state = "invisibility"
    releasedrain = 0
    chargedrain = 0
    chargetime = 0
    charge_max = 60 SECONDS
    range = 3
    warnie = "sydwarning"
    movement_interrupt = FALSE
    sound = 'sound/misc/area.ogg'
    associated_skill = /datum/skill/misc/sneaking

/obj/effect/proc_holder/spell/invoked/shadowstep/cast(list/targets, mob/living/user)
    if (isliving(targets[1]))
        var/mob/living/target = targets[1]
        if (target.anti_magic_check(TRUE, TRUE))
            return FALSE
        target.visible_message(
            span_warning("[target] starts to fade into thin air!"),
            span_notice("You start to become invisible!")
        )
        animate(target, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
        target.mob_timers[MT_INVISIBILITY] = world.time + 7 SECONDS
        addtimer(
            CALLBACK(target, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE),
            7 SECONDS
        )
        addtimer(
            CALLBACK(target, TYPE_PROC_REF(
                /atom/movable, visible_message),
                span_warning("[target] fades back into view."),
                span_notice("You become visible again.")
            ),
            7 SECONDS
        )
        return TRUE
    revert_cast()
    return FALSE

/obj/effect/proc_holder/spell/invoked/mimicry
    name = "Mimicry"
    overlay_state = "facespell"
    releasedrain = 0
    chargedrain = 0
    chargetime = 0
    charge_max = 300 SECONDS
    range = 1
    warnie = "sydwarning"
    movement_interrupt = FALSE
    sound = 'sound/misc/area.ogg'
    associated_skill = /datum/skill/misc/sneaking

/obj/effect/proc_holder/spell/invoked/mimicry/cast(list/targets, mob/living/user)
    if (isliving(targets[1]))
        var/mob/living/carbon/target = targets[1]
        var/list/names = list("Custom...")
        if (ishuman(target))
            var/mob/living/carbon/human/human_target = target
            names += human_target.dna.species.random_name(target.gender, TRUE)
        var/chosen_name = input(user, "Choose a new name to assign.", "Mimicry") as null|anything in names
        if (chosen_name == "Custom...")
            chosen_name = input(user, "What name?", "Mimicry")
            chosen_name = reject_bad_name(chosen_name)
            if (!chosen_name)
                return
        target.real_name = chosen_name
        return TRUE
    return FALSE
