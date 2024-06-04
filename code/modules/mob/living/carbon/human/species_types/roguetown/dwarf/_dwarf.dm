/mob/living/carbon/human/species/dwarf
	race = /datum/species/dwarf

/datum/species/dwarf
	name = "Dwarfb"
	id = "dwarf"
	max_age = 200
	languages = list(
		/datum/language/common,
		/datum/language/dwarvish
	)

/datum/species/dwarf/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

	var/mob/living/carbon/human/species/dwarf/H = C
	if(H.age == AGE_YOUNG)
		offset_features = list(OFFSET_ID = list(0,-1), OFFSET_GLOVES = list(0,-1), OFFSET_WRISTS = list(0,-1),\
		OFFSET_CLOAK = list(0,-1), OFFSET_FACEMASK = list(0,-5), OFFSET_HEAD = list(0,-5), \
		OFFSET_FACE = list(0,-5), OFFSET_BELT = list(0,-6), OFFSET_BACK = list(0,-5), \
		OFFSET_NECK = list(0,-5), OFFSET_MOUTH = list(0,-5), OFFSET_PANTS = list(0,-1), \
		OFFSET_SHIRT = list(0,-1), OFFSET_ARMOR = list(0,-1), OFFSET_HANDS = list(0,-4), \
		OFFSET_ID_F = list(0,-5), OFFSET_GLOVES_F = list(0,-5), OFFSET_WRISTS_F = list(0,-5), OFFSET_HANDS_F = list(0,-5), \
		OFFSET_CLOAK_F = list(0,-1), OFFSET_FACEMASK_F = list(0,-6), OFFSET_HEAD_F = list(0,-6), \
		OFFSET_FACE_F = list(0,-6), OFFSET_BELT_F = list(0,-6), OFFSET_BACK_F = list(0,-6), \
		OFFSET_NECK_F = list(0,-6), OFFSET_MOUTH_F = list(0,-6), OFFSET_PANTS_F = list(0,-1), \
		OFFSET_SHIRT_F = list(0,-1), OFFSET_ARMOR_F = list(0,-1), OFFSET_UNDIES = list(0,-1), OFFSET_UNDIES_F = list(0,-1))

		limbs_icon_m = 'icons/roguetown/mob/bodies/m/mds.dmi'
		limbs_icon_f = 'icons/roguetown/mob/bodies/f/fds.dmi'

//		soundpack_m = new /datum/voicepack/male/young()
		H.update_hair()
		H.update_body()

/datum/species/dwarf/after_creation(mob/living/carbon/C)
	..()
	to_chat(C, "<span class='info'>I can speak Dwarfish with ,d before my speech.</span>")

/datum/species/dwarf/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/dwarf/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/dwarf/get_skin_list()
	return sortList(list(
	"skin1" = "ffe0d1",
	"skin2" = "fcccb3"
	))

/datum/species/dwarf/get_hairc_list()
	return sortList(list(
	"black - nightsky" = "0a0707",
	"brown - treebark" = "362e25",
	"blonde - moonlight" = "dfc999",
	"red - autumn" = "a34332"
	))

