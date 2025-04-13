/datum/subclass/minstrel
    name = "Minstrel"
    tutorial = "The people love music, they crave entertainment as much as they crave food and luckily for them \
    you have always been there to provide such songs to soothe sore ears."
    allowed_sexes = list(MALE, FEMALE)
    allowed_races = RACES_ALL_KINDS
    outfit = /datum/outfit/job/roguetown/towner/minstrel

    category_tags = list(CTAG_TOWNER)

/datum/outfit/job/roguetown/towner/minstrel/pre_equip(mob/living/carbon/human/H)
    ..()
    H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
    H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
    H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
    H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
    H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
    H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
    H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
    H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
    H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
    H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
    H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
    head = /obj/item/clothing/head/roguetown/bardhat
    pants = /obj/item/clothing/under/roguetown/tights/random
    gloves = /obj/item/clothing/gloves/roguetown/fingerless
    belt = /obj/item/storage/belt/rogue/leather
    armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
    cloak = /obj/item/clothing/cloak/raincloak/green
    backl = /obj/item/storage/backpack/rogue/satchel
    //beltl = /obj/item/ammo_holder/bomb/smokebombs
    beltr = /obj/item/rogueweapon/huntingknife/idagger
    head = /obj/item/clothing/head/roguetown/bardhat //with this hat, they will get all the pussy(or dick depending on preference(or both ig))
    neck = /obj/item/clothing/neck/roguetown/coif
    shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/white
    shoes = /obj/item/clothing/shoes/roguetown/shortboots
    backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1)
    var/instrument = pick(0,1,2,3,4,5)
    switch(instrument)
        if(0)
            backr = /obj/item/rogue/instrument/harp
        if(1)
            backr = /obj/item/rogue/instrument/lute
        if(2)
            backr = /obj/item/rogue/instrument/accord
        if(3)
            backr = /obj/item/rogue/instrument/guitar
        if(4)
            backr = /obj/item/rogue/instrument/flute
        if(5)
            backr = /obj/item/rogue/instrument/drum
    
    // gives you the most random choices but could double up...
    // Does a check, if you somehow land on the same instrument
    // you at least get a different one.
    var/second_instrument = pick(0,1,2,3,4,5)
    if(second_instrument == instrument)
        second_instrument -= 1
        if(second_instrument < 0)
            second_instrument = 5

    switch(second_instrument)
        if(0)
            beltl = /obj/item/rogue/instrument/harp
        if(1)
            beltl = /obj/item/rogue/instrument/lute
        if(2)
            beltl = /obj/item/rogue/instrument/accord
        if(3)
            beltl = /obj/item/rogue/instrument/guitar
        if(4)
            beltl = /obj/item/rogue/instrument/flute
        if(5)
            beltl = /obj/item/rogue/instrument/drum

    H.change_stat("intelligence", 2)
    H.change_stat("perception", 2)
    H.change_stat("speed", 2)
    ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)