/datum/organ_customizer/tail
	name = "Tail"
	abstract_type = /datum/organ_customizer/tail

/datum/organ_choice/tail
	name = "Tail"
	organ_type = /obj/item/organ/tail
	organ_slot = ORGAN_SLOT_TAIL
	abstract_type = /datum/organ_choice/tail

/datum/organ_customizer/tail/vulpkanin
	organ_choices = list(/datum/organ_choice/tail/vulpkanin)

/datum/organ_choice/tail/vulpkanin
	name = "Vulpkanin Tail"
	organ_type = /obj/item/organ/tail/vulpkanin
	sprite_accessories = list(/datum/sprite_accessory/tail/fox)

/datum/organ_customizer/tail/tajaran
	organ_choices = list(/datum/organ_choice/tail/tajaran)

/datum/organ_choice/tail/tajaran
	name = "Tajaran Tail"
	organ_type = /obj/item/organ/tail/tajaran
	sprite_accessories = list(/datum/sprite_accessory/tail/catbig)

/datum/organ_customizer/tail/lizard
	organ_choices = list(/datum/organ_choice/tail/lizard)

/datum/organ_choice/tail/lizard
	name = "Lizard Tail"
	organ_type = /obj/item/organ/tail/lizard
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/tail/lizard/smooth,
		/datum/sprite_accessory/tail/lizard/dtiger,
		/datum/sprite_accessory/tail/lizard/ltiger,
		/datum/sprite_accessory/tail/lizard/spikes,
		)

/datum/organ_customizer/tail/demihuman
	organ_choices = list(/datum/organ_choice/tail/demihuman)
	allows_missing_organ = TRUE

/datum/organ_choice/tail/demihuman
	name = "Demihuman Tail"
	organ_type = /obj/item/organ/tail
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/tail/cat,
		/datum/sprite_accessory/tail/fox,
		/datum/sprite_accessory/tail/wolf,
		/datum/sprite_accessory/tail/husky,
		/datum/sprite_accessory/tail/rabbit,
		)

/datum/organ_customizer/tail/vox
	organ_choices = list(/datum/organ_choice/tail/vox)

/datum/organ_choice/tail/vox
	name = "Vox Tail"
	organ_type = /obj/item/organ/tail/vox
	sprite_accessories = list(/datum/sprite_accessory/tail/vox/default)

/datum/organ_customizer/tail/vox
	organ_choices = list(/datum/organ_choice/tail/vox)

/datum/organ_choice/tail/xeno
	name = "Xeno Tail"
	organ_type = /obj/item/organ/tail/xeno
	sprite_accessories = list(/datum/sprite_accessory/tail/xeno)

/datum/organ_customizer/tail/synthliz
	organ_choices = list(/datum/organ_choice/tail/synthliz)

/datum/organ_choice/tail/synthliz
	name = "Synthetic Tail"
	organ_type = /obj/item/organ/tail/synth
	sprite_accessories = list(/datum/sprite_accessory/tail/synthliz/normal)

/datum/organ_customizer/tail/avali
	organ_choices = list(/datum/organ_choice/tail/avali)

/datum/organ_choice/tail/avali
	name = "Avali Tail"
	organ_type = /obj/item/organ/tail/avali
	sprite_accessories = list(
		/datum/sprite_accessory/tail/teshari/default,
		/datum/sprite_accessory/tail/teshari/fluffy,
		/datum/sprite_accessory/tail/teshari/thin,
		)

/datum/organ_choice/tail/cat
	name = "Cat Tail"
	organ_type = /obj/item/organ/tail/cat
	sprite_accessories = list(/datum/sprite_accessory/tail/cat)

/datum/organ_customizer/tail/cat
	organ_choices = list(/datum/organ_choice/tail/cat)

/datum/organ_customizer/tail/mammal
	organ_choices = list(
		/datum/organ_choice/tail/mammal,
		/datum/organ_choice/tail/lizard,
		/datum/organ_choice/tail/xeno,
		)

/datum/organ_choice/tail/mammal
	name = "Mammal Tail"
	organ_type = /obj/item/organ/tail/mammal
	sprite_accessories = list(
		/datum/sprite_accessory/tail/cat,
		/datum/sprite_accessory/tail/monkey,
		/datum/sprite_accessory/tail/axolotl,
		/datum/sprite_accessory/tail/batl,
		/datum/sprite_accessory/tail/bats,
		/datum/sprite_accessory/tail/bee,
		/datum/sprite_accessory/tail/catbig,
		/datum/sprite_accessory/tail/twocat,
		/datum/sprite_accessory/tail/corvid,
		/datum/sprite_accessory/tail/cow,
		/datum/sprite_accessory/tail/eevee,
		/datum/sprite_accessory/tail/fennec,
		/datum/sprite_accessory/tail/fish,
		/datum/sprite_accessory/tail/fox,
		/datum/sprite_accessory/tail/fox2,
		/datum/sprite_accessory/tail/hawk,
		/datum/sprite_accessory/tail/horse,
		/datum/sprite_accessory/tail/husky,
		/datum/sprite_accessory/tail/insect,
		/datum/sprite_accessory/tail/kangaroo,
		/datum/sprite_accessory/tail/kitsune,
		/datum/sprite_accessory/tail/lab,
		/datum/sprite_accessory/tail/murid,
		/datum/sprite_accessory/tail/orca,
		/datum/sprite_accessory/tail/otie,
		/datum/sprite_accessory/tail/rabbit,
		/datum/sprite_accessory/tail/redpanda,
		/datum/sprite_accessory/tail/pede,
		/datum/sprite_accessory/tail/sergal,
		/datum/sprite_accessory/tail/shark,
		/datum/sprite_accessory/tail/shepherd,
		/datum/sprite_accessory/tail/skunk,
		/datum/sprite_accessory/tail/stripe,
		/datum/sprite_accessory/tail/straighttail,
		/datum/sprite_accessory/tail/squirrel,
		/datum/sprite_accessory/tail/tamamo_kitsune,
		/datum/sprite_accessory/tail/tentacle,
		/datum/sprite_accessory/tail/tiger,
		/datum/sprite_accessory/tail/wolf,
		/datum/sprite_accessory/tail/guilmon,
		/datum/sprite_accessory/tail/sharknofin,
		/datum/sprite_accessory/tail/raptor,
		/datum/sprite_accessory/tail/lunasune,
		/datum/sprite_accessory/tail/spade,
		/datum/sprite_accessory/tail/leopard,
		/datum/sprite_accessory/tail/deer,
		/datum/sprite_accessory/tail/raccoon,
		/datum/sprite_accessory/tail/data_shark,
		/datum/sprite_accessory/tail/sabresune,
		)
