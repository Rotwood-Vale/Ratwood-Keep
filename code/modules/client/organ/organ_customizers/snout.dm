/datum/organ_customizer/snout
	abstract_type = /datum/organ_customizer/snout
	name = "Snout"

/datum/organ_choice/snout
	abstract_type = /datum/organ_choice/snout
	name = "Snout"
	organ_type = /obj/item/organ/snout
	organ_slot = ORGAN_SLOT_SNOUT

/datum/organ_customizer/snout/lizard
	organ_choices = list(/datum/organ_choice/snout/lizard)

/datum/organ_choice/snout/lizard
	name = "Lizard Snout"
	organ_type = /obj/item/organ/snout/lizard
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/snout/sharp,
		/datum/sprite_accessory/snout/round,
		/datum/sprite_accessory/snout/sharplight,
		/datum/sprite_accessory/snout/roundlight,
		/datum/sprite_accessory/snout/front/sharp,
		/datum/sprite_accessory/snout/front/round,
		/datum/sprite_accessory/snout/front/sharplight,
		/datum/sprite_accessory/snout/front/roundlight,
		)

/datum/organ_customizer/snout/vulpkanin
	organ_choices = list(/datum/organ_choice/snout/vulpkanin)

/datum/organ_choice/snout/vulpkanin
	name = "Vulpkanin Snout"
	organ_type = /obj/item/organ/snout/vulpkanin
	sprite_accessories = list(
		/datum/sprite_accessory/snout/lcanid,
		/datum/sprite_accessory/snout/lcanidalt,
		/datum/sprite_accessory/snout/lcanidstriped,
		/datum/sprite_accessory/snout/lcanidstripedalt,
		)

/datum/organ_customizer/snout/tajaran
	organ_choices = list(/datum/organ_choice/snout/tajaran)

/datum/organ_choice/snout/tajaran
	name = "Tajaran Snout"
	organ_type = /obj/item/organ/snout/tajaran
	sprite_accessories = list(
		/datum/sprite_accessory/snout/tajaran,
		/datum/sprite_accessory/snout/scanid,
		/datum/sprite_accessory/snout/scanidalt,
		/datum/sprite_accessory/snout/scanidalt2,
		/datum/sprite_accessory/snout/scanidalt3,
		/datum/sprite_accessory/snout/front/scanid,
		/datum/sprite_accessory/snout/front/scanidalt,
		/datum/sprite_accessory/snout/front/scanidalt2,
		/datum/sprite_accessory/snout/front/scanidalt3,
		)

/datum/organ_customizer/snout/vox
	organ_choices = list(/datum/organ_choice/snout/vox)

/datum/organ_choice/snout/vox
	name = "Vox Beak"
	organ_type = /obj/item/organ/snout/vox
	sprite_accessories = list(/datum/sprite_accessory/snout/vox/default)

/datum/organ_customizer/snout/synthliz
	organ_choices = list(/datum/organ_choice/snout/vulpkanin)

/datum/organ_choice/snout/synthliz
	name = "Synthetic Snout"
	organ_type = /obj/item/organ/snout/synth
	sprite_accessories = list(
		/datum/sprite_accessory/snout/synthliz/basic,
		/datum/sprite_accessory/snout/synthliz/long,
		/datum/sprite_accessory/snout/synthliz/long_thick,
		/datum/sprite_accessory/snout/synthliz/under,
		/datum/sprite_accessory/snout/synthliz/over,
		)

/datum/organ_customizer/snout/mammal
	allows_missing_organ = TRUE
	organ_choices = list(
		/datum/organ_choice/snout/mammal,
		/datum/organ_choice/snout/lizard,
		)

/datum/organ_choice/snout/mammal
	name = "Mammal Snout"
	organ_type = /obj/item/organ/snout/mammal
	sprite_accessories = list(
		/datum/sprite_accessory/snout/bird,
		/datum/sprite_accessory/snout/bigbeak,
		/datum/sprite_accessory/snout/bigbeakshort,
		/datum/sprite_accessory/snout/slimbeak,
		/datum/sprite_accessory/snout/slimbeakshort,
		/datum/sprite_accessory/snout/slimbeakalt,
		/datum/sprite_accessory/snout/hookbeak,
		/datum/sprite_accessory/snout/hookbeakbig,
		/datum/sprite_accessory/snout/bug,
		/datum/sprite_accessory/snout/elephant,
		/datum/sprite_accessory/snout/husky,
		/datum/sprite_accessory/snout/rhino,
		/datum/sprite_accessory/snout/bovine,
		/datum/sprite_accessory/snout/rodent,
		/datum/sprite_accessory/snout/lcanid,
		/datum/sprite_accessory/snout/lcanidalt,
		/datum/sprite_accessory/snout/lcanidstriped,
		/datum/sprite_accessory/snout/lcanidstripedalt,
		/datum/sprite_accessory/snout/scanid,
		/datum/sprite_accessory/snout/scanidalt,
		/datum/sprite_accessory/snout/scanidalt2,
		/datum/sprite_accessory/snout/scanidalt3,
		/datum/sprite_accessory/snout/tajaran,
		/datum/sprite_accessory/snout/wolf,
		/datum/sprite_accessory/snout/wolfalt,
		/datum/sprite_accessory/snout/otie,
		/datum/sprite_accessory/snout/otiesmile,
		/datum/sprite_accessory/snout/pede,
		/datum/sprite_accessory/snout/sergal,
		/datum/sprite_accessory/snout/shark,
		/datum/sprite_accessory/snout/hshark,
		/datum/sprite_accessory/snout/toucan,
		/datum/sprite_accessory/snout/redpanda,
		/datum/sprite_accessory/snout/redpandaalt,
		/datum/sprite_accessory/snout/sbeak,
		/datum/sprite_accessory/snout/shark_light,
		/datum/sprite_accessory/snout/rat,
		/datum/sprite_accessory/snout/stubby,
		/datum/sprite_accessory/snout/alienlizard,
		/datum/sprite_accessory/snout/alienlizardteeth,
		/datum/sprite_accessory/snout/skulldog,
		/datum/sprite_accessory/snout/hanubus,
		/datum/sprite_accessory/snout/hpanda,
		/datum/sprite_accessory/snout/hjackal,
		/datum/sprite_accessory/snout/hhorse,
		/datum/sprite_accessory/snout/hzebra,
		/datum/sprite_accessory/snout/protogen,
		/datum/sprite_accessory/snout/protogen_frame,
		/datum/sprite_accessory/snout/protogen_bolt,
		/datum/sprite_accessory/snout/front/bird,
		/datum/sprite_accessory/snout/front/bigbeak,
		/datum/sprite_accessory/snout/front/bug,
		/datum/sprite_accessory/snout/front/elephant,
		/datum/sprite_accessory/snout/front/rhino,
		/datum/sprite_accessory/snout/front/bovine,
		/datum/sprite_accessory/snout/front/husky,
		/datum/sprite_accessory/snout/front/lcanid,
		/datum/sprite_accessory/snout/front/lcanidalt,
		/datum/sprite_accessory/snout/front/lcanidstriped,
		/datum/sprite_accessory/snout/front/lcanidstripedalt,
		/datum/sprite_accessory/snout/front/scanid,
		/datum/sprite_accessory/snout/front/scanidalt,
		/datum/sprite_accessory/snout/front/scanidalt2,
		/datum/sprite_accessory/snout/front/scanidalt3,
		/datum/sprite_accessory/snout/front/wolf,
		/datum/sprite_accessory/snout/front/wolfalt,
		/datum/sprite_accessory/snout/front/otie,
		/datum/sprite_accessory/snout/front/otiesmile,
		/datum/sprite_accessory/snout/front/rodent,
		/datum/sprite_accessory/snout/front/pede,
		/datum/sprite_accessory/snout/front/sergal,
		/datum/sprite_accessory/snout/front/shark,
		/datum/sprite_accessory/snout/front/toucan,
		/datum/sprite_accessory/snout/front/redpanda,
		/datum/sprite_accessory/snout/front/redpandaalt,
		/datum/sprite_accessory/snout/front/skulldog,
		)
