/datum/subclass/fisher
	ru_name = "Рыбак"
	ru_tutorial = "Вы рыбак, у вас есть мешок, приманка и удочка. Вы один из немногих, кто может с уверенностью добывать рыбу в этих местах."

/datum/outfit/job/roguetown/towner/fisher/pre_equip(mob/living/carbon/human/H)
	..()
	backl = /obj/item/storage/backpack/rogue/backpack
