/datum/magic_item
	var/name = "Name of Magical Item Effect"
	var/description = "Text shown on item examine."

/datum/magic_item/proc/on_hit(var/mob/living/target, var/mob/living/user)

/datum/magic_item/proc/on_equip(var/mob/living/user)

/datum/magic_item/proc/on_pickup(var/mob/living/user)

/datum/magic_item/proc/on_use(var/mob/living/user)

/datum/magic_item/proc/on_process()

/datum/magic_item/proc/on_examine(atom/movable/source, mob/user, list/examine_list)
	examine_list += span_info(description)

