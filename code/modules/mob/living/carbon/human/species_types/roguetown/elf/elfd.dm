/mob/living/carbon/human/species/elf/dark
	race = /datum/species/elf/dark

/datum/species/elf/dark
	name = "Тёмный эльф"
	id = "elfd"
	desc = "<b>Тёмный эльф</b><br>\
	Эльфы — это общее название для высоких гуманоидов с заострёнными ушами, происхождение которых уходит корнями к древним таинственным снежным эльфам. \
	Тёмные эльфы имеют тёмный оттенок кожи и в основном происходят из подземелий. Их культура и жизнь обычно связаны со служением злым богам презренного пантеона. \
	Ранее они были редкостью, но в последнее время всё больше тёмных эльфов можно встретить на поверхности. Те из них, \
	кто не является откровенно жестоким и кровожадным, склонны искать укрытие на поверхности, чтобы избежать преследования со стороны своего общества,\
	в то время как более зловещие представители покидают свои города в поисках новой и большей силы."

/*
	Former RT Desc: These guys were undead which doesn't really fit considering now you have a ton of them walking around.

	Descending from a perversion of necromancy, Dark Elves are a unique species \
	that have only recently found themselves a staple of daily life. \
	They boast a proud, beauty-centric culture that demands only the finest \
	out of its citizens, with anyone falling behind their cripplingly high standards \
	refered to as a Homonculus, while less graceful terms such as \
	Stitchface, Zombie or corpsewalker are most commonly thrown out by the elder races\
	Dark Elves tend to be extremely arrogant of others plights, with selfishness\
	being seen as a massive boon in their society. They are academic and usually well taught\
	through are noted to suffer from their biology, which tends to be weak and falls apart\
	without careful upkeep...\
	They typically trace their beginnings to how their progenator died before being raised."
*/
	skin_tone_wording = "Город-подземелье"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	possible_ages = ALL_AGES_LIST
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mem.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	use_f = TRUE
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
	offset_features = list(
		OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1), OFFSET_HANDS = list(0,0), \
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,0), OFFSET_HEAD = list(0,0), \
		OFFSET_FACE = list(0,0), OFFSET_BELT_F = list(0,0), OFFSET_BACK = list(0,0), \
		OFFSET_NECK = list(0,0), OFFSET_MOUTH = list(0,0), OFFSET_PANTS = list(0,0), \
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_UNDIES = list(0,1),\
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list(
		"strength" = 0,
		"perception" = -1,
		"intelligence" = 0,
		"constitution" = 0,
		"endurance" = 1,
		"speed" = 1,
		"fortune" = 0
		)
	specstats_m = list(
		"strength" = -1,
		"speed" = 1,
	)
	specstats_f = list(
		"constitution" = 1,
		"intelligence" = -1,
	)
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/elf,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
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
		/datum/language/elvish
	)

	gender_swapping = TRUE
	stress_examine = TRUE
	stress_desc = span_red("A loathesome dark elf.")

/datum/species/elf/dark/get_skin_list()
	return list(
		"Commorah" = SKIN_COLOR_COMMORAH,
		"Gloomhaven" = SKIN_COLOR_GLOOMHAVEN,
		"Darkpila" = SKIN_COLOR_DARKPILA,
		"Sshanntynlan" = SKIN_COLOR_SSHANNTYNLAN,
		"Llurth Dreir" = SKIN_COLOR_LLURTH_DREIR,
		"Tafravma" = SKIN_COLOR_TAFRAVMA,
		"Yuethindrynn" = SKIN_COLOR_YUETHINDRYNN,
	)

/datum/species/elf/dark/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"white - cavedew" = "dee9ed",
	"white - spiderweb" = "f4f4f4"

	))

/datum/species/elf/dark/random_name(gender,unique,lastname)
	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/elf/elfdm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/elf/elfdf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/elf/elfdm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/elf/elfdf.txt") )
	return randname

/datum/species/elf/dark/random_surname()
	return " [pick(world.file2list("strings/rt/names/elf/elfsnf.txt"))]"
