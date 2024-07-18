/datum/customizer/organ/ears
	name = "Ears"
	abstract_type = /datum/customizer/organ/ears

/datum/customizer_choice/organ/ears
	name = "Ears"
	organ_type = /obj/item/organ/ears
	organ_slot = ORGAN_SLOT_EARS
	abstract_type = /datum/customizer_choice/organ/ears

/datum/customizer/organ/ears/vulpkanin
	customizer_choices = list(/datum/customizer_choice/organ/ears/vulpkanin)

/datum/customizer_choice/organ/ears/vulpkanin
	name = "Vulpkian Ears"
	organ_type = /obj/item/organ/ears/vulpkanin
	sprite_accessories = list(/datum/sprite_accessory/ears/fox)

/datum/customizer/organ/ears/lupian
	customizer_choices = list(/datum/customizer_choice/organ/ears/lupian)

/datum/customizer_choice/organ/ears/lupian
	name = "Lupian Ears"
	organ_type = /obj/item/organ/ears/lupian
	sprite_accessories = list(
		/datum/sprite_accessory/ears/bigwolf,
		/datum/sprite_accessory/ears/bigwolf_inner,
		/datum/sprite_accessory/ears/fox,
		/datum/sprite_accessory/ears/husky,
		/datum/sprite_accessory/ears/otie,
		/datum/sprite_accessory/ears/wolf
	)

/datum/customizer/organ/ears/tajaran
	customizer_choices = list(/datum/customizer_choice/organ/ears/tajaran)

/datum/customizer_choice/organ/ears/tajaran
	name = "Tajaran Ears"
	organ_type = /obj/item/organ/ears/tajaran
	sprite_accessories = list(
		/datum/sprite_accessory/ears/cat_big,
		/datum/sprite_accessory/ears/cat_normal,
		)

/datum/customizer/organ/ears/cat
	customizer_choices = list(/datum/customizer_choice/organ/ears/cat)

/datum/customizer_choice/organ/ears/cat
	name = "Cat Ears"
	organ_type = /obj/item/organ/ears/cat
	sprite_accessories = list(/datum/sprite_accessory/ears/cat)

/datum/customizer/organ/ears/demihuman
	customizer_choices = list(/datum/customizer_choice/organ/ears/demihuman)
	allows_disabling = TRUE

/datum/customizer_choice/organ/ears/demihuman
	name = "Half-Kinhuman Ears"
	organ_type = /obj/item/organ/ears
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/ears/cat,
		/datum/sprite_accessory/ears/axolotl,
		/datum/sprite_accessory/ears/bat,
		/datum/sprite_accessory/ears/bear,
		/datum/sprite_accessory/ears/bigwolf,
		/datum/sprite_accessory/ears/bigwolf_inner,
		/datum/sprite_accessory/ears/rabbit,
		/datum/sprite_accessory/ears/bunny,
		/datum/sprite_accessory/ears/bunny_perky,
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
		/datum/sprite_accessory/ears/pede,
		/datum/sprite_accessory/ears/sergal,
		/datum/sprite_accessory/ears/skunk,
		/datum/sprite_accessory/ears/squirrel,
		/datum/sprite_accessory/ears/wolf,
		/datum/sprite_accessory/ears/perky,
		/datum/sprite_accessory/ears/miqote,
		/datum/sprite_accessory/ears/lunasune,
		/datum/sprite_accessory/ears/sabresune,
		/datum/sprite_accessory/ears/possum,
		/datum/sprite_accessory/ears/raccoon,
		/datum/sprite_accessory/ears/mouse,
		)

/datum/customizer/organ/ears/anthro
	customizer_choices = list(/datum/customizer_choice/organ/ears/anthro)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/organ/ears/anthro
	name = "Wild-Kin Ears"
	organ_type = /obj/item/organ/ears/anthro
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/ears/cat,
		/datum/sprite_accessory/ears/axolotl,
		/datum/sprite_accessory/ears/bat,
		/datum/sprite_accessory/ears/bear,
		/datum/sprite_accessory/ears/bigwolf,
		/datum/sprite_accessory/ears/bigwolf_inner,
		/datum/sprite_accessory/ears/rabbit,
		/datum/sprite_accessory/ears/bunny,
		/datum/sprite_accessory/ears/bunny_perky,
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
		/datum/sprite_accessory/ears/pede,
		/datum/sprite_accessory/ears/sergal,
		/datum/sprite_accessory/ears/skunk,
		/datum/sprite_accessory/ears/squirrel,
		/datum/sprite_accessory/ears/wolf,
		/datum/sprite_accessory/ears/perky,
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
		/datum/sprite_accessory/ears/mouse,
		)
