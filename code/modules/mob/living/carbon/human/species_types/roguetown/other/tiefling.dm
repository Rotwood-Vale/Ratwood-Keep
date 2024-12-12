/mob/living/carbon/human/species/tieberian
	race = /datum/species/tieberian

/datum/species/tieberian
	name = "Tiefling"
	id = "tiefling"
	desc = "<b>Tiefling</b><br>\
	Tieflings, also known as Infernal-Spawn by the Dwarves, are a relatively new species in Grimmoria. \
  	Having shown up sometime within the past two centuries in relatively great numbers, it is understood that they lack any cultural identity \
    as many seem to simply integrate within whatever society they find themselves born into. \
    The unholy origins of Tieflings are well-established; it is known that many favor the Inhumen under Baotha. \
    Many have claimed that they are the spawn of a succubus or incubus of Baotha laying with a mortal, \
    in this, the claims are entirely true; they have faced near-insurmountable struggles as a result. \
    Facing scrutiny, judgement and even genocide in the past. Wounding many Tiefling psyches' \
    and leading to most seeking a solitary life outside the watchful eyes of others. \
    Tieflings, while nominally mortal, are incapable of reproduction outside of their race. \
    Tiefling tend to be extremely perceptive and paranoid, as luck is rarely on their side \
    and their unique biology makes them extremely susceptible to injury."

	skin_tone_wording = "Progenitor"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
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
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list(
        "strength" = 0,
        "perception" = 1,
        "intelligence" = 1,
        "constitution" = -1,
        "endurance" = 1,
        "speed" = 0,
        "fortune" = -1
        )
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/tiefling,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
//		ORGAN_SLOT_TAIL = /obj/item/organ/tail/tiefling,  //Commenting out due to use of customizer organs.
//		ORGAN_SLOT_HORNS = /obj/item/organ/horns/tiefling,

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
		/datum/customizer/organ/horns/humanoid/tiefling,
		/datum/customizer/organ/tail/tiefling,
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
		/datum/language/hellspeak,
	)
	stress_examine = TRUE
	stress_desc = span_red("Helldweller... better stay away.")

/datum/species/tieberian/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/tieberian/after_creation(mob/living/carbon/C)
	..()
	to_chat(C, "<span class='info'>I can speak Infernal with ,h before my speech.</span>")

/datum/species/tieberian/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/tieberian/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/tieberian/get_skin_list()
	return list(
		"Zariel" = SKIN_COLOR_ZARIEL,
		"Levistus" = SKIN_COLOR_LEVISTUS,
		"Glasya" = SKIN_COLOR_GLASYA,
		"Asmodeus" = SKIN_COLOR_ASMODEUS,
		"Baalzebul" = SKIN_COLOR_BAALZEBUL,
		"Mephistopheles" = SKIN_COLOR_MEPHISTOPHELES,
		"Fierna" = SKIN_COLOR_FIERNA,
		"Dispater" = SKIN_COLOR_DISPATER,
		"Nymsea" = SKIN_COLOR_NYMSEA,
		"Mammon" = SKIN_COLOR_MAMMON
	)

/datum/species/tieberian/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b"
	))

/datum/species/tieberian/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/tiefm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/tieff.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/tiefm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/tieff.txt") )
	return randname

/datum/species/tieberian/random_surname()
	return " [pick(world.file2list("strings/rt/names/other/tieflast.txt"))]"
/* Commenting out Spanish Tieflings for now.
//Groups of Accents for each race set by associated 'skin_tone', see 'get_skin_list' above
// "full" group in JSON lists
/datum/species/tieberian/get_accent(mob/living/carbon/human/H)
		switch(H.skin_tone)
				if(SKIN_COLOR_CASTILLIAN)
						return strings("spanish_replacement.json", "full")
		return null

// "start" group in JSON lists
/datum/species/tieberian/get_accent_start(mob/living/carbon/human/H)
		switch(H.skin_tone)
				if(SKIN_COLOR_CASTILLIAN)
						return strings("spanish_replacement.json", "start")
		return null

// "end" group in JSON lists
/datum/species/tieberian/get_accent_end(mob/living/carbon/human/H)
		switch(H.skin_tone)
				if(SKIN_COLOR_CASTILLIAN)
						return strings("spanish_replacement.json", "end")
		return null

// "syllable" group in JSON lists
/datum/species/tieberian/get_accent_any(mob/living/carbon/human/H)
		switch(H.skin_tone)
				if(SKIN_COLOR_CASTILLIAN)
						return strings("spanish_replacement.json", "syllable")
		return null
*/
