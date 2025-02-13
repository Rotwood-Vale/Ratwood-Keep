/datum/sprite_accessory/butt
	icon = 'modular_redmoon/icons/sprite_accessory/butt.dmi'
	color_key_name = "Butt"
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/butt/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(!isdwarf(owner) && !isgoblinp(owner) && !iskobold(owner) && !isanthromorphsmall(owner))
		generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_PANTS, OFFSET_PANTS_F)
	else
		generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_BUTT, OFFSET_BUTT)

/datum/sprite_accessory/butt/get_icon_state(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	var/obj/item/organ/butt/buttie = organ
	return "butt_[icon_state]_[buttie.butt_size]"

/datum/sprite_accessory/butt/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	var/obj/item/organ/butt/buttie = organ
	if(!buttie.visible_organ)
		return FALSE
	return is_human_part_visible(owner, HIDEJUMPSUIT|HIDECROTCH)

/datum/sprite_accessory/butt/pair
	name = "Pair"
	icon_state = "pair"
	color_key_defaults = list(KEY_SKIN_COLOR)
