/obj/item/organ/anus
	//absorbs faster than womb, less capacity.
	name = "anus"
	icon = 'modular_redmoon/icons/surgery.dmi'
	icon_state = "anus"
	dropshrink = 0.5
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_ANUS
	accessory_type = /datum/sprite_accessory/none
	// max_reagents = 20 //less size than vagene in turn for more effective absorbtion
	// absorbing = TRUE
	// absorbmult = 1.5 //more effective absorb than others i guess.
	// altnames = list("ass", "asshole", "butt", "butthole", "guts") //used in thought messages.
	// spiller = TRUE
	// blocker = ITEM_SLOT_PANTS
	// bloatable = TRUE

/obj/item/organ/butt
	name = "butt"
	icon = 'modular_redmoon/icons/surgery.dmi'
	icon_state = "butt"
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_STOMACH
	slot = ORGAN_SLOT_BUTT
	organ_dna_type = /datum/organ_dna/butt
	accessory_type = /datum/sprite_accessory/butt/pair
	var/butt_size = DEFAULT_BUTT_SIZE
