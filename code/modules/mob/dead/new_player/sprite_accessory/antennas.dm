/datum/sprite_accessory/antenna
	abstract_type = /datum/sprite_accessory/antenna
	color_key_name = "Antennae"
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/antenna/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/humie = owner
	var/datum/species/species = owner.dna.species
	for(var/mutable_appearance/appearance as anything in appearance_list)
		if(humie.gender == FEMALE)
			if(OFFSET_FACE_F in species.offset_features)
				appearance.pixel_x += species.offset_features[OFFSET_FACE_F][1]
				appearance.pixel_y += species.offset_features[OFFSET_FACE_F][2]
		else
			if(OFFSET_FACE in species.offset_features)
				appearance.pixel_x += species.offset_features[OFFSET_FACE][1]
				appearance.pixel_y += species.offset_features[OFFSET_FACE][2]

/datum/sprite_accessory/antenna/ipc
	abstract_type = /datum/sprite_accessory/antenna/ipc
	icon = 'icons/mob/sprite_accessory/antenna/ipc_antenna.dmi'

/datum/sprite_accessory/antenna/ipc/antennae
	name = "Angled Antennae"
	icon_state = "antennae"

/datum/sprite_accessory/antenna/ipc/tvantennae
	name = "TV Antennae"
	icon_state = "tvantennae"

/datum/sprite_accessory/antenna/ipc/cyberhead
	name = "Cyberhead"
	icon_state = "cyberhead"

/datum/sprite_accessory/antenna/ipc/antlers
	name = "Antlers"
	icon_state = "antlers"

/datum/sprite_accessory/antenna/ipc/crowned
	name = "Crowned"
	icon_state = "crowned"

/datum/sprite_accessory/antenna/synthliz
	abstract_type = /datum/sprite_accessory/antenna/synthliz
	icon = 'icons/mob/sprite_accessory/antenna/synthliz_antenna.dmi'

/datum/sprite_accessory/antenna/synthliz/curled
	name = "Curled"
	icon_state = "curled"

/datum/sprite_accessory/antenna/synthliz/thick
	name = "Thick"
	icon_state = "thick"

/datum/sprite_accessory/antenna/synthliz/thicklight
	name = "Thick Light"
	icon_state = "thicklight"
	color_keys = 2
	color_key_names = list("Antennae", "Lights")

/datum/sprite_accessory/antenna/synthliz/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/antenna/synthliz/sharp
	name = "Sharp"
	icon_state = "sharp"

/datum/sprite_accessory/antenna/synthliz/sharplight
	name = "Sharp Light"
	icon_state = "sharplight"
	color_keys = 2
	color_key_names = list("Antennae", "Lights")

/datum/sprite_accessory/antenna/synthliz/synth_horns
	name = "Horns"
	icon_state = "horns"

/datum/sprite_accessory/antenna/synthliz/synth_hornslight
	name = "Horns Light"
	icon_state = "hornslight"
	color_keys = 2
	color_key_names = list("Antennae", "Lights")

/datum/sprite_accessory/antenna/synthliz/cobrahood
	name = "Cobra Hood"
	icon_state = "cobrahood"
	color_keys = 2
	color_key_names = list("Outer", "Inner")

/datum/sprite_accessory/antenna/synthliz/cobrahoodears
	name = "Cobra Hood (Ears)"
	icon_state = "cobraears"
	color_keys = 2
	color_key_names = list("Outer", "Inner")

/datum/sprite_accessory/antenna/moth
	abstract_type = /datum/sprite_accessory/antenna/moth
	icon = 'icons/mob/sprite_accessory/antenna/moth_antenna.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	default_colors = list("#FFFFFF")

/datum/sprite_accessory/antenna/moth/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/antenna/moth/reddish
	name = "Reddish"
	icon_state = "reddish"

/datum/sprite_accessory/antenna/moth/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/antenna/moth/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/antenna/moth/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/antenna/moth/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/antenna/moth/burnt_off
	name = "Burnt Off"
	icon_state = "burnt_off"

/datum/sprite_accessory/antenna/moth/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/antenna/moth/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/antenna/moth/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/antenna/moth/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/antenna/moth/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/antenna/moth/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/antenna/moth/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/antenna/moth/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/antenna/moth/regal
	name = "Regal"
	icon_state = "regal"

/datum/sprite_accessory/antenna/moth/mothra
	name = "Mothra"
	icon_state = "mothra"
