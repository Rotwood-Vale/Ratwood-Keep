/datum/magic_item
	var/name = "Name of Magical Item Effect"
	var/description = "A MAGICAL ITEM, WOW!"

/datum/magic_item/proc/do_literally_anything_thanks()
	return

/datum/magic_item/proc/on_apply(var/obj/item/i)
	RegisterSignal(i, COMSIG_ITEM_AFTERATTACK, PROC_REF(on_hit))
	RegisterSignal(i, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(i, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))
	RegisterSignal(i, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	RegisterSignal(i, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_use))

/datum/magic_item/proc/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)

/datum/magic_item/proc/on_equip(var/item/i, var/mob/living/user)

/datum/magic_item/proc/on_pickup(var/item/i, var/mob/living/user)

/datum/magic_item/proc/on_use(var/item/i, var/mob/living/user)

/datum/magic_item/proc/on_drop()
