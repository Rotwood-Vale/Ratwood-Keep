/datum/organ_customizer/neck_feature
	abstract_type = /datum/organ_customizer/neck_feature
	name = "Neck"

/datum/organ_choice/neck_feature
	abstract_type = /datum/organ_choice/neck_feature
	name = "Neck"
	organ_type = /obj/item/organ/neck_feature
	organ_slot = ORGAN_SLOT_NECK_FEATURE

/datum/organ_customizer/neck_feature/moth_fluff
	organ_choices = list(/datum/organ_choice/neck_feature/moth_fluff)

/datum/organ_choice/neck_feature/moth_fluff
	name = "Moth Fluff"
	organ_type = /obj/item/organ/neck_feature/moth_fluff
	sprite_accessories = list(
		/datum/sprite_accessory/neck_feature/moth_fluff/plain,
		/datum/sprite_accessory/neck_feature/moth_fluff/monarch,
		/datum/sprite_accessory/neck_feature/moth_fluff/luna,
		/datum/sprite_accessory/neck_feature/moth_fluff/atlas,
		/datum/sprite_accessory/neck_feature/moth_fluff/reddish,
		/datum/sprite_accessory/neck_feature/moth_fluff/royal,
		/datum/sprite_accessory/neck_feature/moth_fluff/gothic,
		/datum/sprite_accessory/neck_feature/moth_fluff/lovers,
		/datum/sprite_accessory/neck_feature/moth_fluff/whitefly,
		/datum/sprite_accessory/neck_feature/moth_fluff/punished,
		/datum/sprite_accessory/neck_feature/moth_fluff/firewatch,
		/datum/sprite_accessory/neck_feature/moth_fluff/deathhead,
		/datum/sprite_accessory/neck_feature/moth_fluff/poison,
		/datum/sprite_accessory/neck_feature/moth_fluff/ragged,
		/datum/sprite_accessory/neck_feature/moth_fluff/moonfly,
		/datum/sprite_accessory/neck_feature/moth_fluff/snow,
		/datum/sprite_accessory/neck_feature/moth_fluff/oakworm,
		/datum/sprite_accessory/neck_feature/moth_fluff/jungle,
		/datum/sprite_accessory/neck_feature/moth_fluff/witchwing,
		)

/datum/organ_customizer/neck_feature/mammal_fluff
	organ_choices = list(
		/datum/organ_choice/neck_feature/mammal_fluff,
		/datum/organ_choice/neck_feature/moth_fluff,
		)

/datum/organ_choice/neck_feature/mammal_fluff
	name = "Mammal Fluff"
	organ_type = /obj/item/organ/neck_feature/mammal_fluff
	sprite_accessories = list(
		/datum/sprite_accessory/neck_feature/mammal_fluff/fluff,
		/datum/sprite_accessory/neck_feature/mammal_fluff/fluff_front,
		/datum/sprite_accessory/neck_feature/mammal_fluff/fluff_dual,
		/datum/sprite_accessory/neck_feature/mammal_fluff/fluff_dual_front,
		/datum/sprite_accessory/neck_feature/mammal_fluff/insect_m,
		/datum/sprite_accessory/neck_feature/mammal_fluff/insect_f,
		)
