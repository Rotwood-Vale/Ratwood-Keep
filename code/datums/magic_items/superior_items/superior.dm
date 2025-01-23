///T2 Enchantments
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
	name = "fire resistance"
	description = "It seems to be absorbing heat!"

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

/datum/magic_item/superior/thievery
	name = "fast fingers"
	description = "It looks like it fits just right"

/datum/magic_item/superior/thievery/on_equip(var/item/i, var/mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		return
	else
		user.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		user.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		to_chat(user, span_notice("I feel more dexterious!"))

/datum/magic_item/superior/thievery/on_drop(var/item/i, var/mob/living/user)
	. = ..()
	user.mind.adjust_skillrank_down_to(/datum/skill/misc/stealing, 2, TRUE)
	user.mind.adjust_skillrank_down_to(/datum/skill/misc/lockpicking, 2, TRUE)
	to_chat(user, span_notice("I feel mundane once more"))

/datum/magic_item/superior/trekk
	name = "swamp running"
	description = "It looks like it can be used to move through rough terrain"

/datum/magic_item/superior/trekk/on_equip(var/item/i, var/mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		return
	else
		ADD_TRAIT(user, TRAIT_BOG_TREKKING, "[type]")
		to_chat(user, span_notice("I feel like I can move through rough ground easily!"))

/datum/magic_item/superior/trekk/on_drop(var/item/i, var/mob/living/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_BOG_TREKKING, "[type]")
	to_chat(user, span_notice("I feel mundane once more"))

/datum/magic_item/superior/smithing
	name = "smithing"
	description = "It's warm with forge flame."

/datum/magic_item/superior/smithing/on_apply(var/obj/item/i)
	.=..()
	var/obj/item/rogueweapon/hammer/hammer = i
	hammer.quality = hammer.quality *2