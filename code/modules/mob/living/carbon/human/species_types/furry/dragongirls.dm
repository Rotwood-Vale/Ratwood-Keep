/mob/living/carbon/human/species/dragongirl
	race = /datum/species/dragongirl

/datum/species/dragongirl
	name = "Юань-ти"
	id = "dragongirl"
	desc = "<b>Юань-ти</b><br>\
	Изогнутые рога и красиво узорчатая чешуя юань-ти часто заставляют предполагать, что они произошли от драконов.\
	Это давно оспаривается, и ученые приводят в качестве доказательств против этого явные различия между двумя видами. Улучшенный слух и \
	способность распознавать пространство, которыми обладают их рога, не встречаются у драконов,а крайний половой диморфизм, характерный для этой расы, \
	также не встречается у драконов. Представители этой расы крепки и выносливы из-за чешуи, которая защищает их."
	expanded_desc = "Родом с дальневосточных земель, юань-ти были редкостью в Гримории до недавнего времени, когда усилившиеся волнения на их родине заставили \
	немалое их количество отправиться на запад в качестве беженцев. Наиболее широко известными кланами юань-ти являются Азри и Наиире. \
	Азри живут на равнинах Гранн и в Багровых землях, установив более крепкие связи с Зибантией и Багровыми землями и адаптированы к культуре Зибантии \
	и степенных племен, ведя кочевой образ жизни.  И наоборот, Наиире по-прежнему живут в основном на своем родном полуострове и в соседних островах, \
	такие как туманные острова, сохраняя свой традиционный, оседлый образ жизни.\ " //sm
	skin_tone_wording = "Skin Colors"
	skin_tone_wording = "Ancestry"
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = TRUE
	possible_ages = ALL_AGES_LIST
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mt.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male
	soundpack_f = /datum/voicepack/female //iley
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
		"strength" = 0,
		"perception" = 1,
		"intelligence" = -1,
		"constitution" = 1,
		"endurance" = 1,
		"speed" = -2,
		"fortune" = 0
		)
	specstats_f = list(
		"strength" = -1,
		"perception" = 1,
		"intelligence" = 0,
		"constitution" = -1,
		"endurance" = 0,
		"speed" = 1,
		"fortune" = 0
	)
	enflamed_icon = "widefire"
	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		/datum/bodypart_feature/hair/facial,
	) //sos
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/horns/humanoid/dragongirl,
		/datum/customizer/organ/tail/dragongirl,
		/datum/customizer/organ/testicles/human,
		/datum/customizer/organ/penis/human,
		/datum/customizer/organ/breasts/human,
		/datum/customizer/organ/vagina/human,
		)
	body_marking_sets = list(
		/datum/body_marking_set/dragongirl/z,
		/datum/body_marking_set/dragongirl/x,
		/datum/body_marking_set/dragongirl/c,
		/datum/body_marking_set/dragongirl/v,
	)
	body_markings = list(
		/datum/body_marking/dragongirl/z,
		/datum/body_marking/dragongirl/x,
		/datum/body_marking/dragongirl/c,
		/datum/body_marking/dragongirl/v,

	) //et
	
	descriptor_choices = list(
		/datum/descriptor_choice/height,
		/datum/descriptor_choice/body,
		/datum/descriptor_choice/stature,
		/datum/descriptor_choice/face,
		/datum/descriptor_choice/face_exp,
		/datum/descriptor_choice/skin,
		/datum/descriptor_choice/voice,
		/datum/descriptor_choice/prominent_one_wild,
		/datum/descriptor_choice/prominent_two_wild,
		/datum/descriptor_choice/prominent_three_wild,
		/datum/descriptor_choice/prominent_four_wild,
	)

/datum/species/dragongirl/check_roundstart_eligible()
	return TRUE

/datum/species/dragongirl/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/dragongirl/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/dragongirl/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/dragongirl/get_random_body_markings(list/passed_features)
	return assemble_body_markings_from_set(GLOB.body_marking_sets_by_type[pick(body_marking_sets)], passed_features, src)

/datum/species/dragongirl/get_skin_list()
	return list(
		"Азри" = SKIN_COLOR_GRENZELHOFT,
		"Наиире" = SKIN_COLOR_TAFRAVMA,
	)
