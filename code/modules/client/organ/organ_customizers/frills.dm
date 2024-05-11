/datum/organ_customizer/frills
	abstract_type = /datum/organ_customizer/frills
	name = "Frills"

/datum/organ_choice/frills
	abstract_type = /datum/organ_choice/frills
	name = "Frills"
	organ_type = /obj/item/organ/frills
	organ_slot = ORGAN_SLOT_FRILLS

/datum/organ_customizer/frills/humanoid
	organ_choices = list(/datum/organ_choice/frills/humanoid)

/datum/organ_choice/frills/humanoid
	name = "Frills"
	organ_type = /obj/item/organ/frills/humanoid
	sprite_accessories = list(
		/datum/sprite_accessory/frills/simple,
		/datum/sprite_accessory/frills/short,
		/datum/sprite_accessory/frills/aquatic,
		/datum/sprite_accessory/frills/divinity,
		/datum/sprite_accessory/frills/horns,
		/datum/sprite_accessory/frills/horns_double,
		/datum/sprite_accessory/frills/big,
		/datum/sprite_accessory/frills/cobrahood,
		/datum/sprite_accessory/frills/cobrahood_ears,
		)
