/mob/living/carbon/human/species/aasimar
	race = /datum/species/aasimar

/datum/species/aasimar
	name = "Аасимар"
	id = "aasimar"
	desc = "<b>Аасимар</b><br>\
	Аасимар рождаются от редкого союза между смертными и небожителями Десяти. \
	Они несут на себе отпечаток небесного прикосновения через множество разнообразных физических особенностей. \
	Их внешность напоминает традиционные черты того из Богов, с которым был связан их небесный родитель. \
	Чаще всего Аасимар похожи на людей, хотя и более высокого роста, и обладают сверхъестественной красотой, что, как правило, объясняется происхождением от Эоры. \
	У них может быть кожа странного цвета, а физически они более хрупкие, чем обычные смертные. \
	Благодаря своему воспитанию, они являются естественными проводниками божественных сил. \
	Население Рокхилла относится к ним с опаской и уважением. Широко распространено мнение, \
	что несправедливая смерть аасимара - дурное предзнаменование, к которому Десять не отнесутся легкомысленно."

	skin_tone_wording = "План"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	max_age = "Unknown"
	possible_ages = ALL_AGES_LIST
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mt.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
	offset_features = list(
		OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
		OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
		OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,0), \
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list(
        "strength" = -1,
        "perception" = 0,
        "intelligence" = 2,
        "constitution" = -2,
        "endurance" = 0,
        "speed" = 0,
        "fortune" = 2,
        )
	enflamed_icon = "widefire"
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/testicles/human,
		/datum/customizer/organ/penis/human,
		/datum/customizer/organ/breasts/human,
		/datum/customizer/organ/vagina/human,
		)
	body_markings = list(
		/datum/body_marking/flushed_cheeks,
		/datum/body_marking/eyeliner,
		/datum/body_marking/tonage,
	)
	languages = list(
		/datum/language/common,
		/datum/language/celestial
	)

/datum/species/aasimar/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))


/datum/species/aasimar/after_creation(mob/living/carbon/C)
	..()
	to_chat(C, "<span class='info'>I can speak Celestial with ,c before my speech.</span>")

/datum/species/aasimar/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/aasimar/get_skin_list()
	return list(
		"Planetar" = SKIN_COLOR_PLANETAR,
		"Deva"	   = SKIN_COLOR_DEVA,
		"Solar" = SKIN_COLOR_SOLAR,
		"Empyrea" = SKIN_COLOR_EMPYREA,
		"Gaeia" = SKIN_COLOR_GAEIA,
		"Celestial" = SKIN_COLOR_CELESTIAL,
		"Olympia" = SKIN_COLOR_OLYMPIA,
		"Necral" = SKIN_COLOR_NECRAL,
		"Abyssal" = SKIN_COLOR_ABYSSAL,
	)

/datum/species/aasimar/get_hairc_list()
	return sortList(list(
	"white - silver" = "d3d9e3",
	"white - alabaster" = "fffffc",
	"white - skies" = "a1b4d4",
	"yellow - sunlight" = "f3f797",
	"red - flame" = "ab4637"
	))

/datum/species/tieberian/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/aasm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/aasf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/aasm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/aasf.txt") )
	return randname

/datum/species/aasimar/random_surname()
	return
