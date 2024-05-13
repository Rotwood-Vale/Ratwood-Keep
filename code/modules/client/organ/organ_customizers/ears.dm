/datum/organ_customizer/ears
	name = "Ears"
	abstract_type = /datum/organ_customizer/ears

/datum/organ_choice/ears
	name = "Ears"
	organ_type = /obj/item/organ/ears
	organ_slot = ORGAN_SLOT_EARS
	abstract_type = /datum/organ_choice/ears

/datum/organ_customizer/ears/vulpkanin
	organ_choices = list(/datum/organ_choice/ears/vulpkanin)

/datum/organ_choice/ears/vulpkanin
	name = "Vulpkanin Ears"
	organ_type = /obj/item/organ/ears/vulpkanin
	sprite_accessories = list(/datum/sprite_accessory/ears/fox)

/datum/organ_customizer/ears/tajaran
	organ_choices = list(/datum/organ_choice/ears/tajaran)

/datum/organ_choice/ears/tajaran
	name = "Tajaran Ears"
	organ_type = /obj/item/organ/ears/tajaran
	sprite_accessories = list(
		/datum/sprite_accessory/ears/cat_big,
		/datum/sprite_accessory/ears/cat_normal,
		)

/datum/organ_customizer/ears/cat
	organ_choices = list(/datum/organ_choice/ears/cat)

/datum/organ_choice/ears/cat
	name = "Cat Ears"
	organ_type = /obj/item/organ/ears/cat
	sprite_accessories = list(/datum/sprite_accessory/ears/cat)

/datum/organ_customizer/ears/anthromorph
	organ_choices = list(/datum/organ_choice/ears/anthromorph)

/datum/organ_choice/ears/anthromorph
	name = "Mammal Ears"
	organ_type = /obj/item/organ/ears/anthromorph
	sprite_accessories = list(
		/datum/sprite_accessory/ears/cat,
		/datum/sprite_accessory/ears/axolotl,
		/datum/sprite_accessory/ears/bat,
		/datum/sprite_accessory/ears/bear,
		/datum/sprite_accessory/ears/bigwolf,
		/datum/sprite_accessory/ears/bigwolf_inner,
		/datum/sprite_accessory/ears/bunny,
		/datum/sprite_accessory/ears/cat_big,
		/datum/sprite_accessory/ears/cat_normal,
		/datum/sprite_accessory/ears/cow,
		/datum/sprite_accessory/ears/curled,
		/datum/sprite_accessory/ears/deer,
		/datum/sprite_accessory/ears/eevee,
		/datum/sprite_accessory/ears/elf,
		/datum/sprite_accessory/ears/elephant,
		/datum/sprite_accessory/ears/fennec,
		/datum/sprite_accessory/ears/fish,
		/datum/sprite_accessory/ears/fox,
		/datum/sprite_accessory/ears/husky,
		/datum/sprite_accessory/ears/jellyfish,
		/datum/sprite_accessory/ears/kangaroo,
		/datum/sprite_accessory/ears/lab,
		/datum/sprite_accessory/ears/murid,
		/datum/sprite_accessory/ears/otie,
		/datum/sprite_accessory/ears/rabbit,
		/datum/sprite_accessory/ears/rabbit_lop,
		/datum/sprite_accessory/ears/pede,
		/datum/sprite_accessory/ears/sergal,
		/datum/sprite_accessory/ears/skunk,
		/datum/sprite_accessory/ears/squirrel,
		/datum/sprite_accessory/ears/wolf,
		/datum/sprite_accessory/ears/perky,
		/datum/sprite_accessory/ears/protogen,
		/datum/sprite_accessory/ears/antenna_simple1,
		/datum/sprite_accessory/ears/antenna_simple2,
		/datum/sprite_accessory/ears/antenna_simple3,
		/datum/sprite_accessory/ears/antenna_fuzzball1,
		/datum/sprite_accessory/ears/antenna_fuzzball2,
		/datum/sprite_accessory/ears/cobrahood,
		/datum/sprite_accessory/ears/cobrahoodears,
		/datum/sprite_accessory/ears/miqote,
		/datum/sprite_accessory/ears/lunasune,
		/datum/sprite_accessory/ears/sabresune,
		/datum/sprite_accessory/ears/possum,
		/datum/sprite_accessory/ears/raccoon,
		)
