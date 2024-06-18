/datum/advclass/prisoner/masked
	name = "Masked"
	tutorial = "When you were locked away, they sealed a cursed iron mask on your face, to never be removed without your death."
	allowed_sexes = list("male", "female")
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/prisoner/masked
	isprisoner = TRUE

/datum/outfit/job/roguetown/prisoner/masked/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.wear_mask)
		var/obj/I = H.wear_mask
		H.dropItemToGround(H.wear_mask, TRUE)
		qdel(I)
	mask = /obj/item/clothing/mask/rogue/facemask/prisoner
