/datum/organ_customizer/wings
	abstract_type = /datum/organ_customizer/wings
	name = "Wings"

/datum/organ_choice/wings
	abstract_type = /datum/organ_choice/wings
	name = "Wings"
	organ_type = /obj/item/organ/wings
	organ_slot = ORGAN_SLOT_WINGS

/datum/organ_customizer/wings/mammal
	organ_choices = list(/datum/organ_choice/wings/mammal)

/datum/organ_choice/wings/mammal
	name = "Wings"
	organ_type = /obj/item/organ/wings/mammal
	sprite_accessories = list(
		/datum/sprite_accessory/wings/bee,
		/datum/sprite_accessory/wings/fairy,
		/datum/sprite_accessory/wings/feathery,
		/datum/sprite_accessory/wings/bat,
		/datum/sprite_accessory/wings/wide/succubus,
		/datum/sprite_accessory/wings/wide/dragon_synth,
		/datum/sprite_accessory/wings/wide/dragon_alt1,
		/datum/sprite_accessory/wings/wide/dragon_alt2,
		/datum/sprite_accessory/wings/wide/harpywings,
		/datum/sprite_accessory/wings/wide/harpywingsalt1,
		/datum/sprite_accessory/wings/wide/harpywingsalt2,
		/datum/sprite_accessory/wings/wide/harpywings_top,
		/datum/sprite_accessory/wings/wide/harpywingsalt1_top,
		/datum/sprite_accessory/wings/wide/harpywingsalt2_top,
		/datum/sprite_accessory/wings/wide/low_wings,
		/datum/sprite_accessory/wings/wide/low_wings_top,
		/datum/sprite_accessory/wings/wide/spider,
		/datum/sprite_accessory/wings/wide/robowing,
		/datum/sprite_accessory/wings/huge/angel,
		/datum/sprite_accessory/wings/huge/dragon,
		/datum/sprite_accessory/wings/huge/megamoth,
		/datum/sprite_accessory/wings/huge/mothra,
		/datum/sprite_accessory/wings/huge/skeleton,
		/datum/sprite_accessory/wings/huge/robotic,
		)

/datum/organ_customizer/wings/moth
	organ_choices = list(/datum/organ_choice/wings/moth)

/datum/organ_choice/wings/moth
	name = "Moth Wings"
	organ_type = /obj/item/organ/wings/moth
	sprite_accessories = list(
		/datum/sprite_accessory/wings/moth/plain,
		/datum/sprite_accessory/wings/moth/monarch,
		/datum/sprite_accessory/wings/moth/luna,
		/datum/sprite_accessory/wings/moth/atlas,
		/datum/sprite_accessory/wings/moth/reddish,
		/datum/sprite_accessory/wings/moth/royal,
		/datum/sprite_accessory/wings/moth/gothic,
		/datum/sprite_accessory/wings/moth/lovers,
		/datum/sprite_accessory/wings/moth/whitefly,
		/datum/sprite_accessory/wings/moth/punished,
		/datum/sprite_accessory/wings/moth/firewatch,
		/datum/sprite_accessory/wings/moth/deathhead,
		/datum/sprite_accessory/wings/moth/poison,
		/datum/sprite_accessory/wings/moth/ragged,
		/datum/sprite_accessory/wings/moth/moonfly,
		/datum/sprite_accessory/wings/moth/snow,
		/datum/sprite_accessory/wings/moth/oakworm,
		/datum/sprite_accessory/wings/moth/jungle,
		/datum/sprite_accessory/wings/moth/witchwing,
		/datum/sprite_accessory/wings/moth/rosy,
		/datum/sprite_accessory/wings/moth/featherful,
		/datum/sprite_accessory/wings/moth/brown,
		/datum/sprite_accessory/wings/moth/plasmafire,
		)
