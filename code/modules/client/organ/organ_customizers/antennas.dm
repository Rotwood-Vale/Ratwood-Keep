/datum/organ_customizer/antennas
	abstract_type = /datum/organ_customizer/antennas
	name = "Antennas"

/datum/organ_choice/antennas
	abstract_type = /datum/organ_choice/antennas
	name = "Antennas"
	organ_type = /obj/item/organ/antennas
	organ_slot = ORGAN_SLOT_ANTENNAS

/datum/organ_customizer/antennas/moth
	organ_choices = list(/datum/organ_choice/antennas/moth)

/datum/organ_choice/antennas/moth
	name = "Moth Antennas"
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

/datum/organ_customizer/antennas/ipc
	organ_choices = list(/datum/organ_choice/antennas/ipc)

/datum/organ_choice/antennas/ipc
	name = "I.P.C. Antennas"
	organ_type = /obj/item/organ/antennas/ipc
	sprite_accessories = list(
		/datum/sprite_accessory/antenna/ipc/antennae,
		/datum/sprite_accessory/antenna/ipc/tvantennae,
		/datum/sprite_accessory/antenna/ipc/cyberhead,
		/datum/sprite_accessory/antenna/ipc/antlers,
		/datum/sprite_accessory/antenna/ipc/crowned,
		)

/datum/organ_customizer/antennas/synthliz
	organ_choices = list(/datum/organ_choice/antennas/synthliz)

/datum/organ_choice/antennas/synthliz
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
