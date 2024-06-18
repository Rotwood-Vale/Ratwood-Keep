/datum/advclass/prisoner/collared
	name = "Collared"
	tutorial = "When you were locked away, they sealed a cursed collar around your neck, to never be removed without your death."
	allowed_sexes = list("male", "female")
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/prisoner/collared
	isprisoner = TRUE

/datum/outfit/job/roguetown/prisoner/collared/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/gorget/prisoner
