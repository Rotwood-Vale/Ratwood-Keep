/datum/magic_item/mundane/nomagic
	name = "no magic"
	description = "It has red gemstones embedded."

/datum/magic_item/mundane/nomagic/on_equip(var/item/i, var/mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		return
	else
		ADD_TRAIT(user, TRAIT_SPELLCOCKBLOCK, TRAIT_GENERIC)
		to_chat(user, span_notice("I feel a draining sensation as my mana is locked away..."))


/datum/magic_item/mundane/nomagic/on_drop(var/item/i, var/mob/living/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_SPELLCOCKBLOCK, TRAIT_GENERIC)