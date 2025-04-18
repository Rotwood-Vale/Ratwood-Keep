/*
Within this file:
 - Burden
 - Divine Smite
 - Hellish Rebuke
*/

//Burden - Intended to allow a Ravox Paladin/Templar to slow someone enough to catch them if they flee.
//Might need to tweak how long this lasts. Twelve seconds.
/obj/effect/proc_holder/spell/invoked/burden
	name = "Burden"
	overlay_state = "hierophant"
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/timestop.ogg'
	invocation = "In Ravox's name, stand and fight, coward!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	miracle = TRUE
	charge_max = 30 SECONDS
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/burden/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	spelltarget.apply_status_effect(/datum/status_effect/debuff/ravox_burden)

	if(spelltarget != user)
		user.visible_message("[user] shouts an incantation, causing [spelltarget] to go stiff!")
	else
		user.visible_message("[user] shouts an incantation as they slow to a crawl.")

	return TRUE


/obj/effect/proc_holder/spell/self/divine_strike
	name = "Divine Strike"
	overlay = "createlight"
	charge_max = 1 MINUTES
	movement_interrupt = FALSE
	chargedrain = 0
	chargetime = 1 SECONDS
	charging_slowdown = 2
	chargedloop = null
	associated_skill = /datum/skill/magic/holy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/timestop.ogg'
	invocation = "By Ravox’s might, I strike you ablaze!"
	invocation_type = "shout"
	antimagic_allowed = TRUE
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/self/divine_strike/cast(mob/living/user)
	if(!isliving(user))
		return FALSE
	user.apply_status_effect(/datum/status_effect/divine_strike, user.get_active_held_item())
	return ..()

/datum/status_effect/divine_strike
	id = "divine_strike"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 15 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/buff/divine_strike
	on_remove_on_mob_delete = TRUE
	var/datum/weakref/buffed_item

/datum/status_effect/divine_strike/on_creation(mob/living/new_owner, obj/item/I)
	. = ..()
	if(!.)
		return
	if(istype(I) && !(I.item_flags & ABSTRACT))
		buffed_item = WEAKREF(I)
		//this is where overlay code would go?
		RegisterSignal(I, COMSIG_ITEM_AFTERATTACK, PROC_REF(item_afterattack))
	else
		RegisterSignal(owner, COMSIG_MOB_ATTACK_HAND, PROC_REF(hand_attack))

/datum/status_effect/divine_strike/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOB_ATTACK_HAND)
	if(buffed_item)
		var/obj/item/I = buffed_item.resolve()
		if(istype(I))
			//this is where overlay removal code would go?
		UnregisterSignal(I, COMSIG_ITEM_AFTERATTACK)

/datum/status_effect/divine_strike/proc/item_afterattack(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return
	if(!isliving(target))
		return
	var/mob/living/living_target = target
	living_target.adjust_fire_stacks(5)
	living_target.IgniteMob()
	addtimer(CALLBACK(living_target, TYPE_PROC_REF(/mob/living, ExtinguishMob)), 5 SECONDS)
	living_target.visible_message(span_warning("The strike from [user]'s weapon causes [living_target] to ignite with holy flame!"), vision_distance = COMBAT_MESSAGE_RANGE)
	qdel(src)

/datum/status_effect/divine_strike/proc/hand_attack(datum/source, mob/living/carbon/human/M, mob/living/carbon/human/H, datum/martial_art/attacker_style)
	if(!istype(M))
		return
	if(!istype(H))
		return
	if(!istype(M.used_intent, INTENT_HARM))
		return
	H.adjust_fire_stacks(5)
	H.IgniteMob()
	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living, ExtinguishMob)), 5 SECONDS)
	H.visible_message(span_warning("The strike from [M]'s fist causes [H] to ignite with holy flame!"), vision_distance = COMBAT_MESSAGE_RANGE)
	qdel(src)


//Divine Smite - Allows the user to imbue their weapon with hellfire briefly.
//Stronger strikes, basically. Two seconds.

//Hellish Rebuke - Enables the user to shield themselves, causing anyone striking them to burst into flames.
//A stupid strong shielding spell, balanced by the fact that it only lasts two seconds.
