/datum/job/roguetown/puritan
	subclass_cat_rolls = list(CTAG_INQUISITOR = 20)
	visuals_only_outfit = /datum/outfit/job/roguetown/puritan
	outfit = null
	advjob_examine = TRUE // Use subclass name on examine
	foreign_examine = TRUE

/datum/job/roguetown/puritan/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

// Basic inquisitor class, no changes.
/datum/subclass/puritan/inquisitor
    name = "Inquisitor"
    tutorial = "After all this time, Inquisition is still waging its endless war against Archnemesis, and you are ready to help it. \
    Innocents may suffer, but it is a small price for safety."
    outfit = /datum/outfit/job/roguetown/puritan
    category_tags = list(CTAG_INQUISITOR)
    allowed_races = RACES_TOLERATED_UP
    maximum_possible_slots = 1

// Trades armored gloves and boots for a helmet. 
// Has a cutlass instead of a rapier.
/datum/subclass/puritan/viceseer
    name = "Vice Overseer"
    tutorial = "Militant arm of the Psydonian Church you found yourself part of was established quite recently, but has already become infamous. \
    It is time again to prove your reputation true."
    outfit = /datum/outfit/job/roguetown/puritan/viceseer
    category_tags = list(CTAG_INQUISITOR)
    allowed_races = RACES_TOLERATED_UP
    maximum_possible_slots = 1

/datum/outfit/job/roguetown/puritan/viceseer/pre_equip(mob/living/carbon/human/H)
    ..()
    backl = null
    cloak = null
    neck = null
    head = /obj/item/clothing/head/roguetown/helmet/overseer/vice
    belt = /obj/item/storage/belt/rogue/leather/overseer
    shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
    pants = /obj/item/clothing/under/roguetown/trou/overseer
    mask = /obj/item/clothing/mask/rogue/overseer
    armor = /obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/overseer
    shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/overseer
    gloves = /obj/item/clothing/gloves/roguetown/leather/overseer/vice
    wrists = /obj/item/clothing/neck/roguetown/psicross/silver
    beltr = /obj/item/gun/ballistic/revolver/grenadelauncher/runelock
    beltl = /obj/item/rogueweapon/sword/cutlass
    backr = /obj/item/storage/backpack/rogue/satchel/black
    backpack_contents = list(/obj/item/storage/keyring/puritan = 1, /obj/item/rogueweapon/huntingknife/idagger/silver, /obj/item/lockpick = 1, /obj/item/storage/belt/rogue/pouch/ammo = 1)