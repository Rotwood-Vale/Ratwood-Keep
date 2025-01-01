/datum/subclass/assassin
    name = "Dark Elf Assassin"
    tutorial = "Cloaked figures shrouded in darkness. Skilled in the arts of subterfuge and assassination."
    allowed_sexes = list(FEMALE)
    allowed_races = list(/datum/species/elf/dark)
    outfit = /datum/outfit/job/roguetown/mercenary/assassin
    maximum_possible_slots = 10
    min_pq = 0
    torch = FALSE
    cmode_music = 'sound/music/combat_duelist.ogg'
    category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/assassin/pre_equip(mob/living/carbon/human/H)
    ..()
    shoes = /obj/item/clothing/shoes/roguetown/armor/leather
    pants = /obj/item/clothing/under/roguetown/tights/black
    gloves = /obj/item/clothing/gloves/roguetown/leather
    belt = /obj/item/storage/belt/rogue/leather
    armor = /obj/item/clothing/suit/roguetown/armor/leather
    shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
    head = /obj/item/clothing/head/roguetown/roguehood/black
    back = /obj/item/storage/backpack/rogue/satchel
    cloak = /obj/item/clothing/cloak/cape/black
    beltr = /obj/item/rogueweapon/huntingknife/idagger
    backl = /obj/item/storage/backpack/rogue/satchel
    backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
    beltl = /obj/item/ammo_holder/quiver/arrows

    if(H.mind)
        H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
        H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
        H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
        H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
        H.change_stat("strength", -1)
        H.change_stat("speed", 2)
        H.change_stat("perception", 1)
    ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
