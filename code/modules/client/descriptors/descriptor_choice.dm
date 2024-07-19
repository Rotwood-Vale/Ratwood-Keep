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

/datum/descriptor_choice/face_exp
	name = "Expression"
	descriptors = list(
		/datum/mob_descriptor/face_exp/refined,
		/datum/mob_descriptor/face_exp/disinterested,
		/datum/mob_descriptor/face_exp/sour,
		/datum/mob_descriptor/face_exp/bright,
		/datum/mob_descriptor/face_exp/starry_eyed,
		/datum/mob_descriptor/face_exp/cold,
		/datum/mob_descriptor/face_exp/tall,
	)

/datum/descriptor_choice/body
	name = "Body"
	descriptors = list(
		/datum/mob_descriptor/body/average,
		/datum/mob_descriptor/body/athletic,
		/datum/mob_descriptor/body/muscular,
		/datum/mob_descriptor/body/herculean,
		/datum/mob_descriptor/body/fat,
		/datum/mob_descriptor/body/chubby,
		/datum/mob_descriptor/body/curvy,
		/datum/mob_descriptor/body/voluptuous,
		/datum/mob_descriptor/body/decrepit,
		/datum/mob_descriptor/body/thin,
		/datum/mob_descriptor/body/bulky,
		/datum/mob_descriptor/body/tall,
		/datum/mob_descriptor/body/short,
		/datum/mob_descriptor/body/slender,
		/datum/mob_descriptor/body/lissome,
		/datum/mob_descriptor/body/lanky,
		/datum/mob_descriptor/body/twiggy,
		/datum/mob_descriptor/body/dainty,
		/datum/mob_descriptor/body/petite,
		/datum/mob_descriptor/body/gaunt,
		/datum/mob_descriptor/body/lean,
	)

/datum/descriptor_choice/stature
	name = "Stature"
	descriptors = list(
		/datum/mob_descriptor/stature/man,
		/datum/mob_descriptor/stature/gentleman,
		/datum/mob_descriptor/stature/thug,
		/datum/mob_descriptor/stature/snob,
		/datum/mob_descriptor/stature/slob,
		/datum/mob_descriptor/stature/brute,
		/datum/mob_descriptor/stature/highbrow,
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
		/datum/mob_descriptor/voice/growly,
		/datum/mob_descriptor/voice/androgynous,
		/datum/mob_descriptor/voice/nasal,
		/datum/mob_descriptor/voice/refined,
		/datum/mob_descriptor/voice/cheery,
		/datum/mob_descriptor/voice/dispassionate,
		/datum/mob_descriptor/voice/gravelly,
		/datum/mob_descriptor/voice/whiny,
		/datum/mob_descriptor/voice/melodic,
		/datum/mob_descriptor/voice/drawling,
		/datum/mob_descriptor/voice/stilted,
		/datum/mob_descriptor/voice/grave,
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
		/datum/mob_descriptor/scales/peeling,
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
		/datum/mob_descriptor/fur/mangy,
		/datum/mob_descriptor/fur/velvety,
		/datum/mob_descriptor/fur/dense,
		/datum/mob_descriptor/fur/matted,
	)

/datum/descriptor_choice/feathers
	name = "Feathers"
	descriptors = list(
		/datum/mob_descriptor/feathers/fine,
		/datum/mob_descriptor/feathers/stiff,
		/datum/mob_descriptor/feathers/frayed,
		/datum/mob_descriptor/feathers/delicate,
		/datum/mob_descriptor/feathers/soft,
	)

/datum/descriptor_choice/chitin
	name = "Chitin"
	descriptors = list(
		/datum/mob_descriptor/chitin/smooth,
		/datum/mob_descriptor/chitin/hard,
		/datum/mob_descriptor/chitin/fine,
	)

/datum/descriptor_choice/skin_all
	name = "Skin/Fur/Scales"
	descriptors = list(
		/datum/mob_descriptor/skin/normal,
		/datum/mob_descriptor/skin/hairy,
		/datum/mob_descriptor/skin/soft,
		/datum/mob_descriptor/skin/rugged,
		/datum/mob_descriptor/skin/diseased,
		/datum/mob_descriptor/skin/dry,
		/datum/mob_descriptor/skin/fine,
		/datum/mob_descriptor/scales/plain,
		/datum/mob_descriptor/scales/rough,
		/datum/mob_descriptor/scales/smooth,
		/datum/mob_descriptor/scales/plated,
		/datum/mob_descriptor/scales/peeling,
		/datum/mob_descriptor/fur/plain,
		/datum/mob_descriptor/fur/short,
		/datum/mob_descriptor/fur/coarse,
		/datum/mob_descriptor/fur/bristly,
		/datum/mob_descriptor/fur/fluffy,
		/datum/mob_descriptor/fur/shaggy,
		/datum/mob_descriptor/fur/silky,
		/datum/mob_descriptor/fur/lank,
		/datum/mob_descriptor/fur/mangy,
		/datum/mob_descriptor/fur/velvety,
		/datum/mob_descriptor/fur/dense,
		/datum/mob_descriptor/fur/matted,
		/datum/mob_descriptor/feathers/fine,
		/datum/mob_descriptor/feathers/stiff,
		/datum/mob_descriptor/feathers/frayed,
		/datum/mob_descriptor/feathers/delicate,
		/datum/mob_descriptor/feathers/soft,
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
		/datum/mob_descriptor/prominent/elaborate_tattoos,\
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
		/datum/mob_descriptor/prominent/lordly_presence,\
		/datum/mob_descriptor/prominent/aristocratic_haughtiness,\
		/datum/mob_descriptor/prominent/cutthroat_expression,\
		/datum/mob_descriptor/prominent/suave_expression,\
		/datum/mob_descriptor/prominent/humble_expression,\
		/datum/mob_descriptor/prominent/ghastly_pale,\
		/datum/mob_descriptor/prominent/ritual_tattoos,\
		/datum/mob_descriptor/prominent/tribal_tattoos,\
		/datum/mob_descriptor/prominent/slave_tattoos,\
		/datum/mob_descriptor/prominent/enigmatic_tattoos,\
		/datum/mob_descriptor/prominent/mean_look,\
		/datum/mob_descriptor/prominent/haughty_atmosphere,\
		/datum/mob_descriptor/prominent/untrustworthy,\
	)

/datum/descriptor_choice/prominent_one
	name = "Prominent #1"
	descriptors = PROMINENT_DESCRIPTORS

/datum/descriptor_choice/prominent_two
	name = "Prominent #2"
	descriptors = PROMINENT_DESCRIPTORS

#undef PROMINENT_DESCRIPTORS
