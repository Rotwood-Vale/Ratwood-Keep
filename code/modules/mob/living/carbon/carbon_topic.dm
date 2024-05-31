/mob/living/carbon/Topic(href, href_list)
	//strip panel
	if(href_list["internal"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/slot = text2num(href_list["internal"])
		var/obj/item/ITEM = get_item_by_slot(slot)
		if(ITEM && istype(ITEM, /obj/item/tank) && wear_mask && (wear_mask.clothing_flags & MASKINTERNALS))
			visible_message("<span class='danger'>[usr] tries to [internal ? "close" : "open"] the valve on [src]'s [ITEM.name].</span>", \
							"<span class='danger'>[usr] tries to [internal ? "close" : "open"] the valve on your [ITEM.name].</span>", null, null, usr)
			to_chat(usr, "<span class='notice'>I try to [internal ? "close" : "open"] the valve on [src]'s [ITEM.name]...</span>")
			if(do_mob(usr, src, POCKET_STRIP_DELAY))
				if(internal)
					internal = null
					update_internals_hud_icon(0)
				else if(ITEM && istype(ITEM, /obj/item/tank))
					if((wear_mask && (wear_mask.clothing_flags & MASKINTERNALS)) || getorganslot(ORGAN_SLOT_BREATHING_TUBE))
						internal = ITEM
						update_internals_hud_icon(1)

				visible_message("<span class='danger'>[usr] [internal ? "opens" : "closes"] the valve on [src]'s [ITEM.name].</span>", \
								"<span class='danger'>[usr] [internal ? "opens" : "closes"] the valve on your [ITEM.name].</span>", null, null, usr)
				to_chat(usr, "<span class='notice'>I [internal ? "open" : "close"] the valve on [src]'s [ITEM.name].</span>")
	return ..()

/mob/living/carbon/soul_examine(mob/user)
	var/list/message = list()
	if((stat >= DEAD) && (isobserver(user) || HAS_TRAIT(user, TRAIT_SOUL_EXAMINE)))
		if(getorganslot(ORGAN_SLOT_BRAIN) && !key && !get_ghost(FALSE, TRUE))
			message += "<span class='deadsay'>[p_their(TRUE)] soul has departed...</span>"
		else
			message += "<span class='deadsay'>[p_they(TRUE)] [p_are()] still earthbound.</span>"
	return message
