/datum/customizer/organ/head_feature
	abstract_type = /datum/customizer/organ/head_feature
	name = "Head"

/datum/customizer_choice/organ/head_feature
	abstract_type = /datum/customizer_choice/organ/head_feature
	name = "Head"
	organ_type = /obj/item/organ/head_feature
	organ_slot = ORGAN_SLOT_HEAD_FEATURE

/datum/customizer/organ/head_feature/skrell_hair
	customizer_choices = list(/datum/customizer_choice/organ/head_feature/skrell_hair)

/datum/customizer_choice/organ/head_feature/skrell_hair
	name = "Skrell Hair"
	organ_type = /obj/item/organ/head_feature/skrell_hair
	sprite_accessories = list(
		/datum/sprite_accessory/head_feature/skrell_hair/long,
		/datum/sprite_accessory/head_feature/skrell_hair/short,
		)

/datum/customizer/organ/head_feature/xeno_head
	customizer_choices = list(/datum/customizer_choice/organ/head_feature/xeno_head)

/datum/customizer_choice/organ/head_feature/xeno_head
	name = "Xeno Head"
	organ_type = /obj/item/organ/head_feature/xeno_head
	sprite_accessories = list(
		/datum/sprite_accessory/head_feature/xeno_head/standard,
		/datum/sprite_accessory/head_feature/xeno_head/royal,
		/datum/sprite_accessory/head_feature/xeno_head/hollywood,
		/datum/sprite_accessory/head_feature/xeno_head/warrior,
		)
