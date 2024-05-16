/datum/customizer/bodypart_feature/face_detail
	name = "Face Detail"
	customizer_choices = list(/datum/customizer_choice/bodypart_feature/face_detail)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/bodypart_feature/face_detail
	name = "Face Detail"
	feature_type = /datum/bodypart_feature/face_detail
	allows_accessory_color_customization = FALSE
	sprite_accessories = list(
		/datum/sprite_accessory/face_detail/brows,
		/datum/sprite_accessory/face_detail/brows/dark,
		/datum/sprite_accessory/face_detail/scar,
		/datum/sprite_accessory/face_detail/scart,
		/datum/sprite_accessory/face_detail/burnface_r,
		/datum/sprite_accessory/face_detail/burnface_l,
		/datum/sprite_accessory/face_detail/deadeye_r,
		/datum/sprite_accessory/face_detail/deadeye_l,
		)

/datum/customizer/bodypart_feature/accessory
	name = "Accessory"
	customizer_choices = list(/datum/customizer_choice/bodypart_feature/accessory)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/bodypart_feature/accessory
	name = "Accessory"
	feature_type = /datum/bodypart_feature/accessory
	allows_accessory_color_customization = FALSE
	sprite_accessories = list(
		/datum/sprite_accessory/accessory/earrings,
		/datum/sprite_accessory/accessory/earrings/sil,
		/datum/sprite_accessory/accessory/earrings/em,
		/datum/sprite_accessory/accessory/eyepierce,
		/datum/sprite_accessory/accessory/eyepierce/alt,
		/datum/sprite_accessory/accessory/choker,
		/datum/sprite_accessory/accessory/chokere,
		)
