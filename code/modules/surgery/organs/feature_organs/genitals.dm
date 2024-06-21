/obj/item/organ/penis
	name = "penis"
	icon_state = "severedtail" //placeholder
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_PENIS
	organ_dna_type = /datum/organ_dna/penis
	accessory_type = /datum/sprite_accessory/penis/human
	var/penis_size = DEFAULT_PENIS_SIZE

/obj/item/organ/vagina
	name = "vagina"
	icon_state = "severedtail" //placeholder
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_VAGINA
	accessory_type = /datum/sprite_accessory/vagina/human

/obj/item/organ/breasts
	name = "breasts"
	icon_state = "severedtail" //placeholder
	visible_organ = TRUE
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BREASTS
	organ_dna_type = /datum/organ_dna/breasts
	accessory_type = /datum/sprite_accessory/breasts/pair
	var/breast_size = DEFAULT_BREASTS_SIZE

/obj/item/organ/breasts/Insert(mob/living/carbon/M, special = 0, drop_if_replaced = FALSE)
	..()
	if(breast_size == 5)
		ADD_TRAIT(M, TRAIT_BIGBOOBS, ORGAN_TRAIT)

/obj/item/organ/breasts/Remove(mob/living/carbon/M, special = 0)
	if(breast_size == 5)
		REMOVE_TRAIT(M, TRAIT_BIGBOOBS, ORGAN_TRAIT)
	..()

/obj/item/organ/testicles
	name = "testicles"
	icon_state = "severedtail" //placeholder
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TESTICLES
	organ_dna_type = /datum/organ_dna/testicles
	accessory_type = /datum/sprite_accessory/testicles/pair
	var/ball_size = DEFAULT_TESTICLES_SIZE

/obj/item/organ/testicles/internal
	name = "internal testicles"
	visible_organ = FALSE
	accessory_type = /datum/sprite_accessory/none
