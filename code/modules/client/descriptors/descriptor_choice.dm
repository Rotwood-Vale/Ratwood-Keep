/datum/descriptor_choice
	abstract_type = /datum/descriptor_choice
	var/name = "Descriptor"
	var/list/descriptors = list()

/datum/descriptor_choice/face
	name = "Face"
	descriptors = list(
		/datum/mob_descriptor/face/unremarkable,
		/datum/mob_descriptor/face/smooth,
		/datum/mob_descriptor/face/rough,
		/datum/mob_descriptor/face/chiseled,
		/datum/mob_descriptor/face/wrinkled,
		/datum/mob_descriptor/face/scarred,
		/datum/mob_descriptor/face/angular,
		/datum/mob_descriptor/face/gaunt,
		/datum/mob_descriptor/face/round,
		/datum/mob_descriptor/face/delicate,
		/datum/mob_descriptor/face/soft,
		/datum/mob_descriptor/face/sharp,
		/datum/mob_descriptor/face/sleek,
		/datum/mob_descriptor/face/broad,
		/datum/mob_descriptor/face/disfigured,
	)

/datum/descriptor_choice/body
	name = "Body"
	descriptors = list(
		/datum/mob_descriptor/body/plain,
		/datum/mob_descriptor/body/athletic,
		/datum/mob_descriptor/body/round,
		/datum/mob_descriptor/body/thin,
		/datum/mob_descriptor/body/surly,
		/datum/mob_descriptor/body/bulky,
		/datum/mob_descriptor/body/tall,
		/datum/mob_descriptor/body/short,
	)

/datum/descriptor_choice/voice
	name = "Voice"
	descriptors = list(
		/datum/mob_descriptor/voice/ordinary,
		/datum/mob_descriptor/voice/monotone,
		/datum/mob_descriptor/voice/deep,
		/datum/mob_descriptor/voice/soft,
		/datum/mob_descriptor/voice/shrill,
		/datum/mob_descriptor/voice/sleepy,
		/datum/mob_descriptor/voice/commanding,
		/datum/mob_descriptor/voice/kind,
		/datum/mob_descriptor/voice/androgynous,
	)

/datum/descriptor_choice/skin
	name = "Skin"
	descriptors = list(
		/datum/mob_descriptor/skin/normal,
		/datum/mob_descriptor/skin/hairy,
		/datum/mob_descriptor/skin/soft,
		/datum/mob_descriptor/skin/rugged,
		/datum/mob_descriptor/skin/diseased,
		/datum/mob_descriptor/skin/dry,
		/datum/mob_descriptor/skin/fine,
	)

/datum/descriptor_choice/scales
	name = "Scales"
	descriptors = list(
		/datum/mob_descriptor/scales/plain,
		/datum/mob_descriptor/scales/rough,
		/datum/mob_descriptor/scales/smooth,
		/datum/mob_descriptor/scales/plated,
	)

/datum/descriptor_choice/fur
	name = "Fur"
	descriptors = list(
		/datum/mob_descriptor/fur/plain,
		/datum/mob_descriptor/fur/short,
		/datum/mob_descriptor/fur/coarse,
		/datum/mob_descriptor/fur/bristly,
		/datum/mob_descriptor/fur/fluffy,
		/datum/mob_descriptor/fur/shaggy,
		/datum/mob_descriptor/fur/silky,
		/datum/mob_descriptor/fur/lank,
	)

#define PROMINENT_DESCRIPTORS list(\
		/datum/mob_descriptor/prominent/hunched_over,\
		/datum/mob_descriptor/prominent/drooling,\
		/datum/mob_descriptor/prominent/lazy_eye,\
		/datum/mob_descriptor/prominent/bloodshot_eye,\
		/datum/mob_descriptor/prominent/baggy_eye,\
		/datum/mob_descriptor/prominent/twitchy,\
		/datum/mob_descriptor/prominent/clumsy,\
		/datum/mob_descriptor/prominent/unkempt,\
		/datum/mob_descriptor/prominent/eloquent,\
		/datum/mob_descriptor/prominent/thick_tail,\
		/datum/mob_descriptor/prominent/cleft_lip,\
		/datum/mob_descriptor/prominent/physically_deformed,\
		/datum/mob_descriptor/prominent/extensive_scars,\
		/datum/mob_descriptor/prominent/elaborate_tattoo,\
		/datum/mob_descriptor/prominent/move_strange,\
		/datum/mob_descriptor/prominent/ghoulish_appearance,\
		/datum/mob_descriptor/prominent/prominent_chest,\
		/datum/mob_descriptor/prominent/prominent_bottom,\
		/datum/mob_descriptor/prominent/prominent_potbelly,\
		/datum/mob_descriptor/prominent/cold_gaze,\
		/datum/mob_descriptor/prominent/piercing_gaze,\
		/datum/mob_descriptor/prominent/promiscuous_mannerisms,\
		/datum/mob_descriptor/prominent/intimidating_presence,\
		/datum/mob_descriptor/prominent/meek_presence,\
		/datum/mob_descriptor/prominent/adorable_presence,\
		/datum/mob_descriptor/prominent/aristocratic_haughtiness,\
		/datum/mob_descriptor/prominent/cutthroat_expression,\
		/datum/mob_descriptor/prominent/suave_expression,\
		/datum/mob_descriptor/prominent/humble_expression,\
		/datum/mob_descriptor/prominent/ghastly_pale,\
	)

/datum/descriptor_choice/prominent_one
	name = "Prominent #1"
	descriptors = PROMINENT_DESCRIPTORS

/datum/descriptor_choice/prominent_two
	name = "Prominent #2"
	descriptors = PROMINENT_DESCRIPTORS

#undef PROMINENT_DESCRIPTORS
