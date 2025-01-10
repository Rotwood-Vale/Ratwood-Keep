/mob/living/carbon/human/species/kobold
	race = /datum/species/kobold

/datum/species/kobold
	name = "Кобольд"
	id = "kobold"
	desc = "<b>Кобольд</b><br>\
	Кобольды — агрессивные, замкнутые, но при этом трудолюбивые маленькие гуманоидные существа. \
	Они известны своим умением строить ловушки, устраивать засады и заниматься горным делом. Они отдаленно связаны с драконами и урдами.\
	Кобольд — это рептилоидный гуманоид, ростом от 60 до 75 сантиметров и весом от 16 до 20 килограммов, с чешуйчатой кожей, \
	цвет которой варьируется от красновато-коричневого до черного, и с глазами от жженого оранжевого до красного цвета. \
	Их ноги жилистые и пальцеходящие. У них длинные, когтистые пальцы и челюсть, напоминающая крокодилью. На голове у них выступают маленькие белые или светло-коричневые рога, \
	а хвосты напоминают крысиные. Они часто пахнут мокрой собакой и застоявшейся водой. Кобольды любят носить красную или оранжевую одежду, которая обычно изношенная.\
	Кобольды затаили обиду на свой маленький рост и ненавидят представителей других рас, которые над этим смеются. \
	Большинство из них чувствует, что они должны компенсировать свои небольшие размеры другими способами, такими как юмор или агрессия. \
	Они, естественно, склонны ненавидеть более крупных существ и, хотя будут проявлять уважение и послушание, если это требуется, всегда ищут способы показать свое недовольство."
	expanded_desc = "В то время как другие расы считают героями тех, кто совершает великие подвиги силы или военного мастерства, \
	кобольдскими героями становятся те, кто показывает выдающееся мастерство в установке ловушек, пытках и засадах.\
	Кобольды процветают в тесных условиях, вдали от солнечного света. Большинство из них живет в огромных норах глубоко под землей, \
	но некоторые предпочитают обустраивать свои жилища под зарослями деревьев и кустарников. Сохраняя свою злобу для других рас, \
	большинство кобольдов хорошо ладят со своими сородичами. Хотя ссоры и распри случаются, старейшины, управляющие кобольдскими общинами, \
	склонны быстро улаживать такие конфликты. Кобольды обожают брать рабов, наслаждаясь возможностью мучить и унижать их. \
	Они также трусливы и практичны, и часто склоняются перед более могущественными существами. Если эти существа принадлежат к другой гуманоидной расе, \
	кобольды часто строят планы по освобождению от подчинения как можно скорее. Если же повелитель является мощным драконоподобным или чудовищным существом, \
	кобольды не видят позора в подчинении и часто осыпают нового лидера восхищением. Это особенно верно, \
	если кобольды служат настоящему дракону, которого они, как правило, прямо поклоняются. Кобольды часто кипят ненавистью и завистью, \
	но их врожденная осторожность гарантирует, что они действуют на эти импульсы только когда у них есть преимущество. \
	Если они не могут безопасно реализовать свое желание физически навредить и унизить представителей других рас,\
	они прибегают к осторожным оскорблениям и /практическим шуткам/. Они считают и дворфов, и эльфов смертельными соперниками. \
	Кобольды боятся грубой силы полуорков и завидуют людям за доминирующий статус, которым они обладают. \
	Они считают, что полуэльфы сочетают в себе лучшие качества обеих родительских рас, что кобольдам кажется фундаментально несправедливым."
	species_traits = list(EYECOLOR,LIPS,STUBBLE,MUTCOLORS)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	possible_ages = ALL_AGES_LIST
	limbs_icon_m = 'icons/mob/species/anthro_small_male.dmi'
	limbs_icon_f = 'icons/mob/species/anthro_small_female.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
	use_f = TRUE
	custom_clothes = TRUE
	clothes_id = "dwarf"
	offset_features = list(
		OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,-3), OFFSET_WRISTS = list(0,-3),\
		OFFSET_CLOAK = list(0,0), OFFSET_FACEMASK = list(0,-4), OFFSET_HEAD = list(0,-4), \
		OFFSET_FACE = list(0,-4), OFFSET_BELT = list(0,-4), OFFSET_BACK = list(0,-3), \
		OFFSET_NECK = list(0,-4), OFFSET_MOUTH = list(0,-4), OFFSET_PANTS = list(0,0), \
		OFFSET_SHIRT = list(0,0), OFFSET_ARMOR = list(0,0), OFFSET_HANDS = list(0,-3), \
		OFFSET_ID_F = list(0,-4), OFFSET_GLOVES_F = list(0,-4), OFFSET_WRISTS_F = list(0,-4), OFFSET_HANDS_F = list(0,-4), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-5), OFFSET_HEAD_F = list(0,-5), \
		OFFSET_FACE_F = list(0,-5), OFFSET_BELT_F = list(0,-4), OFFSET_BACK_F = list(0,-4), \
		OFFSET_NECK_F = list(0,-5), OFFSET_MOUTH_F = list(0,-5), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES = list(0,-4), OFFSET_UNDIES_F = list(0,-4), \
		)
	specstats = list(
		"strength" = -2, 
		"perception" = 0, 
		"intelligence" = 1, 
		"constitution" = -1,
		"endurance" = 1, 
		"speed" = 2, 
		"fortune" = 0
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
		//ORGAN_SLOT_TAIL = /obj/item/organ/tail/kobold, //Commenting out due to use of customizer organs.
		ORGAN_SLOT_SNOUT = /obj/item/organ/snout/lizard,
		ORGAN_SLOT_FRILLS = /obj/item/organ/frills/lizard,
		ORGAN_SLOT_HORNS = /obj/item/organ/horns,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/testicles,
		ORGAN_SLOT_PENIS = /obj/item/organ/penis/tapered,
		ORGAN_SLOT_BREASTS = /obj/item/organ/breasts,
		ORGAN_SLOT_VAGINA = /obj/item/organ/vagina,
		)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid/bald_default,
		/datum/customizer/bodypart_feature/hair/facial/humanoid/shaved_default,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/tail/kobold,
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
		/datum/body_marking_set/kobold_scale,
	)
	body_markings = list(
	)
	languages = list(
		/datum/language/common,
		/datum/language/draconic
	)
	stress_examine = TRUE
	stress_desc = span_red("Thieving little kobold...")
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

/datum/species/kobold/check_roundstart_eligible()
	return TRUE

/datum/species/kobold/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/kobold/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/kobold/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/kobold/get_random_body_markings(list/passed_features)
	return assemble_body_markings_from_set(GLOB.body_marking_sets_by_type[/datum/body_marking_set/kobold_scale], passed_features, src)

/datum/species/kobold/get_random_features()
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
