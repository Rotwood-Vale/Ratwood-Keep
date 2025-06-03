/mob/living/carbon/human/species/dracon
	race = /datum/species/dracon

/datum/species/dracon
	name = "Drakian"
	id = "dracon"
	desc = "<b>Drakian</b><br>\
	Drakians are a proud and ancient race that trace their heritage to dragons of old. \
	They are highly protective of their bloodline and do everything in their power to make sure it does not spread beyond their own, \
	as they believe themselves to be guardians of tradition and that it is their ultimate duty to maintain their prestige as a race. \
	After all, a single drop of draconic blood in one's bloodline means that they will experience all of the benefits of having draconic ancestors such as agelessness."
	expanded_desc = "Drakians are a proud and ancient race that trace their heritage to dragons of old. \
	They are highly protective of their bloodline and do everything in their power to make sure it does not spread beyond their own, \
	as they believe themselves to be guardians of tradition and that it is their ultimate duty to maintain their prestige as a race. \
	After all, a single drop of draconic blood in ones bloodline means that they will experience all of the benefits of having draconic ancestors such as agelessness.\
	<br><br> \
	Yet, it comes at a cost. \
	While initially viewed as one of the noblest races, \
	they are now hated for their insufferable arrogance and often appear completely out of touch with the rest of society. \
	Their inability to have a concept of time, refusal to compromise or intermarry, \
	along with their rejection of any technology that threatens their supremacy have earned them countless enemies from Axians to Dwarves. \
	For instance, they view any Wild-kin with draconic features or blood as inherently inferior. \
	Yet, not all Drakians are like this with some believing it is their duty to help lesser races, although many still view these Drakians to be just as insufferable.\
	<br><br> \
	In the past, Drakians held positions of power and prestige across all the realms. \
	Many try to style themselves after knight-philosophers in an attempt to hide their brutish ways. \
	When in reality, most Drakians are known for being bloody conquerors. \
	However, the rise of humans have caused their ambitions to crumble, forcing them to work with other races, especially at the climax of the Great Sissean Uprising. \
	Furthermore, dwindling numbers have caused Drakians to increasingly abandon the ways of old, forcing them to adapt to a more modern way of life."
	species_traits = list(EYECOLOR,LIPS,STUBBLE,MUTCOLORS)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	possible_ages = ALL_AGES_LIST
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mt.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male
	soundpack_f = /datum/voicepack/female
	offset_features = list(
		OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
		OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
		OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,0), \
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list(
		"strength" = 1,
		"perception" = 0,
		"intelligence" = 1,
		"constitution" = 1,
		"endurance" = -1,
		"speed" = -1,
		"fortune" = 0
		)
	specstats_f = list(
		"constitution" = -1,
		"endurance" = 1,
	)
	enflamed_icon = "widefire"
	attack_verb = "slash"
	attack_sound = 'sound/blank.ogg'
	miss_sound = 'sound/blank.ogg'
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/lizard,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		//ORGAN_SLOT_TAIL = /obj/item/organ/tail/lizard, //Commenting out due to use of customizer organs.
		ORGAN_SLOT_SNOUT = /obj/item/organ/snout/lizard,
		ORGAN_SLOT_TAIL_FEATURE = /obj/item/organ/tail_feature/lizard_spines,
		ORGAN_SLOT_FRILLS = /obj/item/organ/frills/lizard,
		ORGAN_SLOT_HORNS = /obj/item/organ/horns,
		ORGAN_SLOT_WINGS = /obj/item/organ/wings/dracon,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/testicles,
		ORGAN_SLOT_PENIS = /obj/item/organ/penis/tapered,
		ORGAN_SLOT_BREASTS = /obj/item/organ/breasts,
		ORGAN_SLOT_VAGINA = /obj/item/organ/vagina,
		)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/tail/lizard,
		/datum/customizer/organ/tail_feature/lizard_spines,
		/datum/customizer/organ/snout/lizard,
		/datum/customizer/organ/frills/lizard,
		/datum/customizer/organ/horns/humanoid,
		/datum/customizer/organ/testicles/anthro,
		/datum/customizer/organ/penis/lizard,
		/datum/customizer/organ/breasts/animal,
		/datum/customizer/organ/vagina/animal,
		)
	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/bellyscale,
		/datum/body_marking_set/tiger,
		/datum/body_marking_set/tiger_dark,
	)
	body_markings = list(
		/datum/body_marking/flushed_cheeks,
		/datum/body_marking/eyeliner,
		/datum/body_marking/bellyscale,
		/datum/body_marking/bellyscaleslim,
		/datum/body_marking/bellyscaleslimsmooth,
		/datum/body_marking/buttscale,
		/datum/body_marking/tiger,
		/datum/body_marking/tiger/dark,
		/datum/body_marking/drake_eyes,
		/datum/body_marking/tonage,
	)
	languages = list(
		/datum/language/common,
		/datum/language/draconic
	)
	descriptor_choices = list(
		/datum/descriptor_choice/height,
		/datum/descriptor_choice/body,
		/datum/descriptor_choice/stature,
		/datum/descriptor_choice/face,
		/datum/descriptor_choice/face_exp,
		/datum/descriptor_choice/scales,
		/datum/descriptor_choice/voice,
		/datum/descriptor_choice/prominent_one,
		/datum/descriptor_choice/prominent_two,
		/datum/descriptor_choice/prominent_three,
		/datum/descriptor_choice/prominent_four,
	)

/datum/species/dracon/check_roundstart_eligible()
	return TRUE

/datum/species/dracon/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/dracon/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/dracon/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/dracon/get_random_body_markings(list/passed_features)
	return assemble_body_markings_from_set(GLOB.body_marking_sets_by_type[/datum/body_marking_set/bellyscale], passed_features, src)

/datum/species/dracon/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/random = rand(1,9)
	//Choose from a variety of draconic colors
	switch(random)
		if(1)
			main_color = "e43900"
			second_color = "ea673c"
		if(2)
			main_color = "ea6f01"
			second_color = "ea8e3c"
		if(3)
			main_color = "eaa501"
			second_color = "e7b43a"
		if(4)
			main_color = "63d100"
			second_color = "89d248"
		if(5)
			main_color = "51aa01"
			second_color = "70ae39"
		if(6)
			main_color = "00b302"
			second_color = "2eb62f"
		if(7)
			main_color = "02c33c"
			second_color = "3ac664"
		if(8)
			main_color = "00c170"
			second_color = "3fbf89"
		if(9)
			main_color = "00bc94"
			second_color = "3cbea2"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = second_color
	return returned
