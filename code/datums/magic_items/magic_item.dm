/datum/magic_item
	var/name = "Name of Magical Item Effect"
	var/description = "A MAGICAL ITEM, WOW!"

/datum/magic_item/proc/do_literally_anything_thanks()
	return

/datum/magic_item/proc/on_apply(var/obj/item/i)
	RegisterSignal(i, COMSIG_PROJECTILE_ON_HIT, PROC_REF(projectile_hit))
	RegisterSignal(i, COMSIG_ITEM_AFTERATTACK, PROC_REF(on_hit))
	RegisterSignal(i, COMSIG_ITEM_ATTACK_OBJ, PROC_REF(on_hit_structure))
	RegisterSignal(i, COMSIG_ITEM_ATTACK_TURF, PROC_REF(on_hit_turf))
	RegisterSignal(i, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(i, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))
	RegisterSignal(i, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	RegisterSignal(i, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_use))
	RegisterSignal(i, COMSIG_ITEM_HIT_RESPONSE, PROC_REF(on_hit_response))

/datum/magic_item/proc/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)	//when enchanted item hits a mob/living, do effect.
	SIGNAL_HANDLER

/datum/magic_item/proc/on_hit_turf(var/turf/target, var/obj/item/I, var/mob/living/user)		//when enchated item hits a turf, do effect
	SIGNAL_HANDLER

/datum/magic_item/proc/on_hit_structure(var/obj/target, var/obj/item/I, var/mob/living/user)	//when enchanted item hits structure, do effect
	SIGNAL_HANDLER

/datum/magic_item/proc/on_equip(var/obj/item/i, var/mob/living/user, slot)	//when enchanted item is placed into an equipment slot, do effect
	SIGNAL_HANDLER

/datum/magic_item/proc/on_pickup(var/obj/item/i, var/mob/living/user)		//when enchanted item is picked up, do effect
	SIGNAL_HANDLER

/datum/magic_item/proc/on_use(var/obj/item/i, var/mob/living/user)		//when enchanted item is used in hand, do effect
	SIGNAL_HANDLER

/datum/magic_item/proc/on_drop(var/obj/item/i, var/mob/living/user)		//when enchanted item is dropped, do effect
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, PROC_REF(drop_effects), i, user), 1)

/datum/magic_item/proc/drop_effects(var/obj/item/i, var/mob/living/user)
	SIGNAL_HANDLER



/datum/magic_item/proc/projectile_hit(atom/fired_from, atom/movable/firer, atom/target, Angle)	//effects when shooting a protectile from an enchanted item
	SIGNAL_HANDLER

/datum/magic_item/proc/on_hit_response(var/obj/item/I, var/mob/living/carbon/human/owner, var/mob/living/carbon/human/attacker)//use for worn items such as armor to have effects on hit.
	SIGNAL_HANDLER
