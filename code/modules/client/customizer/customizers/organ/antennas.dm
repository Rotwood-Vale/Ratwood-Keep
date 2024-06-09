/datum/customizer/organ/antennas
	abstract_type = /datum/customizer/organ/antennas
	name = "Antennas"

/datum/customizer_choice/organ/antennas
	abstract_type = /datum/customizer_choice/organ/antennas
	name = "Antennas"
	organ_type = /obj/item/organ/antennas
	organ_slot = ORGAN_SLOT_ANTENNAS

/datum/customizer/organ/antennas/moth
	customizer_choices = list(/datum/customizer_choice/organ/antennas/moth)

/datum/customizer_choice/organ/antennas/moth
	name = "Fluvian Antennas"
	organ_type = /obj/item/organ/antennas/moth
	sprite_accessories = list(
		/datum/sprite_accessory/antenna/moth/plain,
		/datum/sprite_accessory/antenna/moth/reddish,
		/datum/sprite_accessory/antenna/moth/royal,
		/datum/sprite_accessory/antenna/moth/gothic,
		/datum/sprite_accessory/antenna/moth/whitefly,
		/datum/sprite_accessory/antenna/moth/lovers,
		/datum/sprite_accessory/antenna/moth/burnt_off,
		/datum/sprite_accessory/antenna/moth/firewatch,
		/datum/sprite_accessory/antenna/moth/deathhead,
		/datum/sprite_accessory/antenna/moth/poison,
		/datum/sprite_accessory/antenna/moth/ragged,
		/datum/sprite_accessory/antenna/moth/moonfly,
		/datum/sprite_accessory/antenna/moth/oakworm,
		/datum/sprite_accessory/antenna/moth/jungle,
		/datum/sprite_accessory/antenna/moth/witchwing,
		/datum/sprite_accessory/antenna/moth/regal,
		/datum/sprite_accessory/antenna/moth/mothra,
		)

/datum/customizer/organ/antennas/ipc
	customizer_choices = list(/datum/customizer_choice/organ/antennas/ipc)

/datum/customizer_choice/organ/antennas/ipc
	name = "I.P.C. Antennas"
	organ_type = /obj/item/organ/antennas/ipc
	sprite_accessories = list(
		/datum/sprite_accessory/antenna/ipc/antennae,
		/datum/sprite_accessory/antenna/ipc/tvantennae,
		/datum/sprite_accessory/antenna/ipc/cyberhead,
		/datum/sprite_accessory/antenna/ipc/antlers,
		/datum/sprite_accessory/antenna/ipc/crowned,
		)

/datum/customizer/organ/antennas/synthliz
	customizer_choices = list(/datum/customizer_choice/organ/antennas/synthliz)

/datum/customizer_choice/organ/antennas/synthliz
	name = "Synthetic Antennas"
	organ_type = /obj/item/organ/antennas/synth
	sprite_accessories = list(
		/datum/sprite_accessory/antenna/synthliz/curled,
		/datum/sprite_accessory/antenna/synthliz/thick,
		/datum/sprite_accessory/antenna/synthliz/thicklight,
		/datum/sprite_accessory/antenna/synthliz/short,
		/datum/sprite_accessory/antenna/synthliz/sharp,
		/datum/sprite_accessory/antenna/synthliz/sharplight,
		/datum/sprite_accessory/antenna/synthliz/synth_horns,
		/datum/sprite_accessory/antenna/synthliz/synth_hornslight,
		/datum/sprite_accessory/antenna/synthliz/cobrahood,
		/datum/sprite_accessory/antenna/synthliz/cobrahoodears,
		)
