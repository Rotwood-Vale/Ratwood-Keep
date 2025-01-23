/datum/magic_item/superior/nightvision
	name = "night vision"
	description = "It has a sigil of Noc's eye."


/datum/magic_item/superior/nightvision/on_equip(var/item/i, var/mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		return
	else
		ADD_TRAIT(user, TRAIT_DARKVISION, "[type]")
		to_chat(user, span_notice("I can see much better!"))


/datum/magic_item/superior/nightvision/on_drop(var/item/i, var/mob/living/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_DARKVISION, "[type]")
	to_chat(user, span_notice("I feel mundane once more"))


/datum/magic_item/superior/featherstep
	name = "feather step"
	description = "It feels as light as a feather"


/datum/magic_item/superior/featherstep/on_equip(var/item/i, var/mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		return
	else
		ADD_TRAIT(user, TRAIT_LIGHT_STEP, "[type]")
		user.change_stat("speed", 1)
		to_chat(user, span_notice("I feel much more nimble!"))


/datum/magic_item/superior/featherstep/on_drop(var/item/i, var/mob/living/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_LIGHT_STEP, "[type]")
	user.change_stat("speed", -1)
	to_chat(user, span_notice("I feel mundane once more"))

/datum/magic_item/superior/fireresist
	name = "feather step"
	description = "It feels as light as a feather

/datum/magic_item/superior/fireresist/on_equip(var/item/i, var/mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		return
	else
		ADD_TRAIT(user, TRAIT_NOFIRE, "[type]")
		to_chat(user, span_notice("I feel fire-resistant!"))

/datum/magic_item/superior/fireresist/on_drop(var/item/i, var/mob/living/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_NOFIRE, "[type]")
	to_chat(user, span_notice("I feel mundane once more"))

/datum/magic_item/superior/climbing
	name = "spider's movement"
	description = "It bristles with ends like fine hairs."

/datum/magic_item/superior/climbing/on_equip(var/item/i, var/mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		return
	else
		user.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		to_chat(user, span_notice("I feel almost spiderlike!"))

/datum/magic_item/superior/climbing/on_drop(var/item/i, var/mob/living/user)
	. = ..()
	user.mind.adjust_skillrank(/datum/skill/misc/climbing, -2, TRUE)
	to_chat(user, span_notice("I feel mundane once more"))

/datum/magic_item/superior/climbing
	name = "spider's movement"
	description = "It bristles with ends like fine hairs."