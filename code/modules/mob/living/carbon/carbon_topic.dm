/mob/living/carbon/Topic(href, href_list)
	//strip panel
	if(href_list["internal"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/slot = text2num(href_list["internal"])
		var/obj/item/ITEM = get_item_by_slot(slot)
		if(ITEM && istype(ITEM, /obj/item/tank) && wear_mask && (wear_mask.clothing_flags & MASKINTERNALS))
			visible_message(span_danger("[usr] tries to [internal ? "close" : "open"] the valve on [src]'s [ITEM.name]."), \
							span_danger("[usr] tries to [internal ? "close" : "open"] the valve on your [ITEM.name]."), null, null, usr)
			to_chat(usr, span_notice("I try to [internal ? "close" : "open"] the valve on [src]'s [ITEM.name]..."))
			if(do_mob(usr, src, POCKET_STRIP_DELAY))
				if(internal)
					internal = null
					update_internals_hud_icon(0)
				else if(ITEM && istype(ITEM, /obj/item/tank))
					if((wear_mask && (wear_mask.clothing_flags & MASKINTERNALS)) || getorganslot(ORGAN_SLOT_BREATHING_TUBE))
						internal = ITEM
						update_internals_hud_icon(1)

				visible_message(span_danger("[usr] [internal ? "opens" : "closes"] the valve on [src]'s [ITEM.name]."), \
								span_danger("[usr] [internal ? "opens" : "closes"] the valve on your [ITEM.name]."), null, null, usr)
				to_chat(usr, span_notice("I [internal ? "open" : "close"] the valve on [src]'s [ITEM.name]."))
	return ..()

/mob/living/carbon/soul_examine(mob/user)
	var/list/message = list()
	if((stat >= DEAD) && (isobserver(user) || HAS_TRAIT(user, TRAIT_SOUL_EXAMINE)))
		if(getorganslot(ORGAN_SLOT_BRAIN) && !key && !get_ghost(FALSE, TRUE))
			message += span_deadsay("[p_their(TRUE)] soul has departed...")
		else
			message += span_deadsay("[p_they(TRUE)] [p_are()] still earthbound.")
	return message
