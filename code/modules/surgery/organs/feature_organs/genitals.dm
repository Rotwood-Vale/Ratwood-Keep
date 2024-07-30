/obj/item/organ/penis
	name = "penis"
	icon_state = "penis"
	dropshrink = 0.5
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_PENIS
	organ_dna_type = /datum/organ_dna/penis
	accessory_type = /datum/sprite_accessory/penis/human
	var/penis_size = DEFAULT_PENIS_SIZE
	
/obj/item/organ/vagina
	name = "vagina"
	icon_state = "vagina"
	dropshrink = 0.5
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_VAGINA
	accessory_type = /datum/sprite_accessory/vagina/human
	var/pregnant = FALSE
	var/fertility = TRUE

/obj/item/organ/vagina/proc/be_impregnated(mob/living/carbon/human/father)
	if(pregnant)
		return
	if(!owner)
		return
	if(owner.stat == DEAD)
		return
	to_chat(owner, span_love("I feel a surge of warmth in my belly, I’m definitely pregnant!"))
	pregnant = TRUE

/obj/item/organ/breasts
	name = "breasts"
	icon_state = "breasts"
	dropshrink = 1.25
	visible_organ = TRUE
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BREASTS
	organ_dna_type = /datum/organ_dna/breasts
	accessory_type = /datum/sprite_accessory/breasts/pair
	var/breast_size = DEFAULT_BREASTS_SIZE
	var/lactating = FALSE
	var/milk_stored = 0
	var/milk_max = 75

/obj/item/organ/breasts/New()
	..()
	milk_max = max(75, breast_size * 100)

/obj/item/organ/belly
	name = "belly"
	icon_state = "belly"
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_STOMACH
	slot = ORGAN_SLOT_BELLY
	organ_dna_type = /datum/organ_dna/belly
	accessory_type = /datum/sprite_accessory/belly
	var/belly_size = DEFAULT_BELLY_SIZE

/obj/item/organ/testicles
	name = "testicles"
	icon_state = "testicles"
	dropshrink = 0.5
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TESTICLES
	organ_dna_type = /datum/organ_dna/testicles
	accessory_type = /datum/sprite_accessory/testicles/pair
	var/ball_size = DEFAULT_TESTICLES_SIZE
	var/virility = TRUE

/obj/item/organ/testicles/internal
	name = "internal testicles"
	visible_organ = FALSE
	accessory_type = /datum/sprite_accessory/none

/obj/item/organ/penis/internal
	name = "internal penis"
	visible_organ = FALSE
	accessory_type = /datum/sprite_accessory/none

/obj/item/organ/vagina/internal
	name = "internal vagina"
	visible_organ = FALSE
	accessory_type = /datum/sprite_accessory/none

/obj/item/organ/breasts/internal
	name = "internal breasts"
	visible_organ = FALSE
	accessory_type = /datum/sprite_accessory/none

/obj/item/organ/belly/internal
	name = "internal belly"
	visible_organ = FALSE
	accessory_type = /datum/sprite_accessory/none
