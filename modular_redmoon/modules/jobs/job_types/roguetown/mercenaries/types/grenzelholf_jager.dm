// fixes_for_ancestory_skintones
/datum/outfit/job/roguetown/mercenary/grenzelhoft_jager/pre_equip(mob/living/carbon/human/H)
	..()
	var/accessories_color_changing = 0

	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		accessories_color_changing = skin_slop["Grenzelhoft"]

	if(isdemihuman(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		accessories_color_changing = skin_slop["Grenzelhoft"]

	if(accessories_color_changing)
		var/obj/item/organ/breasts/breasts = H.getorganslot(ORGAN_SLOT_BREASTS)
		if(breasts)
			breasts.accessory_colors = "#[accessories_color_changing]"
		var/obj/item/organ/penis/penis = H.getorganslot(ORGAN_SLOT_PENIS)
		if(penis)
			penis.accessory_colors = "#[accessories_color_changing]"
		var/obj/item/organ/testicles/testicles = H.getorganslot(ORGAN_SLOT_TESTICLES)
		if(testicles)
			testicles.accessory_colors = "#[accessories_color_changing]"
		var/obj/item/organ/butt/butt = H.getorganslot(ORGAN_SLOT_BUTT)
		if(butt)
			butt.accessory_colors ="#[accessories_color_changing]"
		var/obj/item/organ/ears/ears = H.getorganslot(ORGAN_SLOT_EARS)
		if(ears)
			ears.accessory_colors = "#[accessories_color_changing]"
		H.update_body()
