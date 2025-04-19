/mob/living/carbon/human/species/lupian
	race = /datum/species/lupian

/datum/species/lupian
	name = "Lupian"
	id = "lupian"
	desc = "<b>Lupian</b><br>\
	Lupians are the sons and daughters of Noc. They are a volf-like people hailing from the Northern Regions of the world. \
	They are resilient, cunning and fight ready creachures capable of surviving the north thanks to their rugged pelts, \
	sharp teeth and deep-rooted spirit of community. They are very dutiful individuals and make fantastic and fearsome \
	warriors to those who earn their loyalty. Thanks to their pack minded nature they are slow to trust the other races \
	but form deep connections with those they do. In recent years they have been driven from the forests by unrest and the \
	inevitable spread of the rot and pressed into cohabitation with races they'd deem lesser."
	expanded_desc = "Lupians live under elective monarchies, forms of feudalism where the king of a pack is chosen from, and by, the military council. \
	The leader of the pack is a philosopher king, a paragon of virtue and one who should inspire awe and loyalty among the population \
	while the real power is held by the military leadership. Should a king fail his people it is not uncommon for the entire kingdom \
	to fall into disarray as law and order begin to break down, for many Lupians see it a disgrace to themselves to follow a king who \
	appears weak. Similarly, most Lupians uphold an image of pride and toughness, it is only in the presence of someone who appears \
	stronger do they bend the knee. To become a leader is a constant challenge to maintain. \
	<br><br> \
	Vakran was once the largest of the pack-nations, the capital of Lupian civilization. After the King sequestered himself away under \
	insurmountable stress and went into hiding, it was revealed weeks later that he was poisoned by one of his sons. This plunged the \
	nation states under the Vakran name into chaos. Vassals left, either becoming free or aligning themselves with the neighboring \
	Frostfell or Felsaad, while others faced internal strife, civils wars between those who believed the Vakran name still held strong, \
	and those who saw the crown tainted, even the military council decimated itself between duels and the pitting of coups."
	skin_tone_wording = "Pack"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAIR,
	)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	use_skintones = 1
	attack_verb = "slash"
	liked_food = GROSS | MEAT | FRIED
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
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list(
		"strength" = 1,
		"perception" = -1,
		"intelligence" = 1,
		"constitution" = 0,
		"endurance" = 1,
		"speed" = -1,
		"fortune" = 0
		)
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/lupian,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/lupian,
		ORGAN_SLOT_SNOUT = /obj/item/organ/snout/lupian,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/testicles,
		ORGAN_SLOT_PENIS = /obj/item/organ/penis/knotted,
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
		/datum/customizer/organ/tail/lupian,
		/datum/customizer/organ/snout/lupian,
		/datum/customizer/organ/ears/lupian,
		/datum/customizer/organ/neck_feature/anthro,
		/datum/customizer/organ/testicles/external,
		/datum/customizer/organ/penis/canine,
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
		/datum/body_marking/flushed_cheeks,
		/datum/body_marking/eyeliner,
		/datum/body_marking/wolf,
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
		/datum/body_marking/harlequin,
		/datum/body_marking/harlequinreversed,
	)
	descriptor_choices = list(
		/datum/descriptor_choice/height,
		/datum/descriptor_choice/body,
		/datum/descriptor_choice/stature,
		/datum/descriptor_choice/face,
		/datum/descriptor_choice/face_exp,
		/datum/descriptor_choice/fur,
		/datum/descriptor_choice/voice,
		/datum/descriptor_choice/prominent_one,
		/datum/descriptor_choice/prominent_two,
		/datum/descriptor_choice/prominent_three,
		/datum/descriptor_choice/prominent_four,
	)
	languages = list(
		/datum/language/common,
		/datum/language/canilunzt
	)

/datum/species/lupian/check_roundstart_eligible()
	return TRUE

/datum/species/lupian/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/lupian/get_skin_list()
	return list(
		"Vakran" = "271f1b",
		"Lanarain" = "271f1c",
		"Frostfell" = "271f1d",
		"Varghelm" = "271f1e",
		"Dawnbreak" = "271f1f",
		"Bloodmoon" = "271f2a",
		"Felsaad" = "271f2b",
		"Hizmut" = "271f2c",
		"Langqan" = "271f2d",
		"a tangled lineage" = "271f2e",
		"disputed" = "271f2f",
		"bastardized" = "271f3a"
	) // This is a dirty hack that stops me using mob defines, the colors do not do anything, it just a var that relates to their pack name on examine

/datum/species/lupian/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of mostly dark, wolfish colors
	switch(random)
		if(1)
			main_color = "f3efe6"
			second_color = "dcd8ce"
		if(2)
			main_color = "948e86"
			second_color = "cdcccc"
		if(3)
			main_color = "4d4c4c"
			second_color = "706c69"
		if(4)
			main_color = "32312c"
			second_color = "8D7F69"
		if(5)
			main_color = "282421"
			second_color = "645b54"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = "373330"
	return returned

/datum/species/lupian/on_species_gain(mob/living/carbon/C, datum/species/old_species)
    . = ..()
    RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
    // Add Lupian-specific emotes
    C.verbs += list(
        /mob/proc/howl,
        /mob/proc/growl,
        /mob/proc/whine,
		/mob/proc/bark,
    )

/datum/species/lupian/on_species_loss(mob/living/carbon/C)
    . = ..()
    UnregisterSignal(C, COMSIG_MOB_SAY)
    // Remove Lupian-specific emotes
    C.verbs -= list(
        /mob/proc/howl,
        /mob/proc/growl,
        /mob/proc/whine,
		/mob/proc/bark,
    )

/mob/proc/howl()
    set name = "Howl"
    set category = "Noises"
    if(stat != CONSCIOUS)
        return
    if(next_move > world.time)
        return
    emote("howl")
    next_move = world.time + 9 // 0.9 second cooldown

/mob/proc/growl()
    set name = "Growl"
    set category = "Noises"
    if(stat != CONSCIOUS)
        return
    if(next_move > world.time)
        return
    emote("growl")
    next_move = world.time + 3

/mob/proc/whine()
    set name = "Whine"
    set category = "Noises"
    if(stat != CONSCIOUS)
        return
    if(next_move > world.time)
        return
    emote("whine")
    next_move = world.time + 3

/mob/proc/bark()
    set name = "Bark"
    set category = "Noises"
    if(stat != CONSCIOUS)
        return
    if(next_move > world.time)
        return
    emote("bark")
    next_move = world.time + 3
