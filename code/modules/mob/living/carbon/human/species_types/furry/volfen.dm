/mob/living/carbon/human/species/volfen
	race = /datum/species/volfen

/datum/species/volfen
	name = "Volfen"
	id = "volfen"
	desc = "<b>Volfen</b><br>\
	Volfen are a volf-life people hailing from the Northern Regions of the world. \
	They are resilient, sharp witted and fight ready creatures capable of surviving and thriving thanks to their \
	rugged pelts, sharp teeth and deep-rooted spirit of community. \
	Volfen prefer a carnivorous diet and have not adapted to agriculture like the rest of the world. \
	Thanks to their pack minded nature they are slow to trust other races but form deep connections with those they do. \
	They are very dutiful individuals and make fantastic and fearsome warriors to those who earn their loyalty."
	default_color = "444"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAIR,
	)
	inherent_traits = list(TRAIT_NOMOBSWAP, TRAIT_NASTY_EATER, TRAIT_STRONGBITE, TRAIT_ORGAN_EATER)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	attack_verb = "slash"
	liked_food = GROSS | MEAT | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	possible_ages = ALL_AGES_LIST
	limbs_icon_m = 'icons/mob/species/male.dmi'
	limbs_icon_f = 'icons/mob/species/female.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male
	soundpack_f = /datum/voicepack/female
	offset_features = list(
		OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
		OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
		OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1), \
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list("strength" = 2, "perception" = -2, "intelligence" = 1, "constitution" = 0, "endurance" = 1, "speed" = -1, "fortune" = 0) //+1 total
	specstats_f = list("strength" = 1, "perception" = -1, "intelligence" = 1, "constitution" = 0, "endurance" = 0, "speed" = 0, "fortune" = 0) //+1 total
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/volfen,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/volfen,
		ORGAN_SLOT_SNOUT = /obj/item/organ/snout/volfen,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/testicles,
		ORGAN_SLOT_PENIS = /obj/item/organ/penis,
		ORGAN_SLOT_BREASTS = /obj/item/organ/breasts,
		ORGAN_SLOT_VAGINA = /obj/item/organ/vagina,
		)
	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		/datum/bodypart_feature/hair/facial,
	)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/tail/volfen,
		/datum/customizer/organ/snout/volfen,
		/datum/customizer/organ/ears/volfen,
		/datum/customizer/organ/neck_feature/anthro,
		/datum/customizer/organ/testicles/external,
		/datum/customizer/organ/penis/knotted,
		/datum/customizer/organ/breasts/animal,
		/datum/customizer/organ/vagina/animal,
		)
	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/belly,
		/datum/body_marking_set/bellysocks,
		/datum/body_marking_set/tiger,
		/datum/body_marking_set/tiger_dark,
	)
	body_markings = list(
		/datum/body_marking/plain,
		/datum/body_marking/belly,
		/datum/body_marking/bellyslim,
		/datum/body_marking/butt,
		/datum/body_marking/sock,
		/datum/body_marking/socklonger,
		/datum/body_marking/tips,
		/datum/body_marking/backspots,
		/datum/body_marking/front,
		/datum/body_marking/tonage,
	)
	
/datum/species/volfen/check_roundstart_eligible()
	return TRUE

/datum/species/volfen/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/volfen/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/volfen/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/volfen/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/third_color
	var/random = rand(1,6)
	switch(random)
		if(1)
			main_color = "FFFFFF"
			second_color = "333333"
			third_color = "333333"
		if(2)
			main_color = "FFFFDD"
			second_color = "DD6611"
			third_color = "AA5522"
		if(3)
			main_color = "DD6611"
			second_color = "FFFFFF"
			third_color = "DD6611"
		if(4)
			main_color = "CCCCCC"
			second_color = "FFFFFF"
			third_color = "FFFFFF"
		if(5)
			main_color = "AA5522"
			second_color = "CC8833"
			third_color = "FFFFFF"
		if(6)
			main_color = "FFFFDD"
			second_color = "FFEECC"
			third_color = "FFDDBB"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = third_color
	return returned
