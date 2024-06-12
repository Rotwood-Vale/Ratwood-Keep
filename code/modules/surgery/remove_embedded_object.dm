/datum/surgery/embedded_removal
	name = "Removal of embedded objects"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/remove_object)
	possible_locs = list(BODY_ZONE_R_ARM,BODY_ZONE_L_ARM,BODY_ZONE_R_LEG,BODY_ZONE_L_LEG,BODY_ZONE_CHEST,BODY_ZONE_HEAD)


/datum/surgery_step/remove_object
	name = "remove embedded objects"
	time = 32
	accept_hand = 1
	var/obj/item/bodypart/L = null


/datum/surgery_step/remove_object/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	L = surgery.operated_bodypart
	if(L)
		user.visible_message(span_notice("[user] looks for objects embedded in [target]'s [parse_zone(user.zone_selected)]."), span_notice("I look for objects embedded in [target]'s [parse_zone(user.zone_selected)]..."))
		display_results(user, target, span_notice("I look for objects embedded in [target]'s [parse_zone(user.zone_selected)]..."),
			span_notice("[user] looks for objects embedded in [target]'s [parse_zone(user.zone_selected)]."),
			span_notice("[user] looks for something in [target]'s [parse_zone(user.zone_selected)]."))
	else
		user.visible_message(span_notice("[user] looks for [target]'s [parse_zone(user.zone_selected)]."), span_notice("I look for [target]'s [parse_zone(user.zone_selected)]..."))


/datum/surgery_step/remove_object/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(L)
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/objects = 0
			for(var/obj/item/I in L.embedded_objects)
				objects++
				L.remove_embedded_object(I)

			if(objects > 0)
				display_results(user, target, span_notice("I successfully remove [objects] objects from [H]'s [L.name]."),
					span_notice("[user] successfully removes [objects] objects from [H]'s [L]!"),
					span_notice("[user] successfully removes [objects] objects from [H]'s [L]!"))
			else
				to_chat(user, span_warning("I find no objects embedded in [H]'s [L]!"))

	else
		to_chat(user, span_warning("I can't find [target]'s [parse_zone(user.zone_selected)], let alone any objects embedded in it!"))

	return 1
