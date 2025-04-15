///T3 Enchantmentsdatum
/datum/magic_item/greater/lifesteal
	name = "life steal"
	description = "It seems bloodthirsty."
	var/last_used
	var/flat_heal = 10
	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY)
	var/warned = FALSE

/datum/magic_item/greater/lifesteal/projectile_hit(atom/fired_from, atom/movable/firer, atom/target, Angle)
	if(world.time < src.last_used + 100)
		to_chat(firer, span_notice("[fired_from] is not yet hungry for more life!"))
		return
	if(isliving(firer) && isliving(target))
		var/mob/living/healing = firer
		var/mob/living/damaging = target
		if(damaging.stat != DEAD)
			healing.heal_ordered_damage(flat_heal, damage_heal_order)
			firer.visible_message(span_danger("[fired_from] drains life from [target]!"))
			src.last_used = world.time

/datum/magic_item/greater/lifesteal/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(world.time < src.last_used + 100)
		if(!warned)
			to_chat(user, span_notice("[source] is not yet hungry for more life!"))
			warned = TRUE
		return
	if(isliving(user) && isliving(target))
		var/mob/living/healing = user
		var/mob/living/damaging = target
		if(damaging.stat != DEAD)
			healing.heal_ordered_damage(flat_heal, damage_heal_order)
			user.visible_message(span_danger("[source] drains life from [target]!"))
			warned = FALSE
			src.last_used = world.time

/datum/magic_item/greater/frostveil
	name = "frostveil"
	description = "It feels rather cold."
	var/last_used

/datum/magic_item/greater/frostveil/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(world.time < src.last_used + 100)
		return
	if(isliving(target))
		var/mob/living/targeted = target
		targeted.apply_status_effect(/datum/status_effect/debuff/cold)
		targeted.visible_message(span_danger("[source] chills [targeted]!"))
		src.last_used = world.time

/datum/magic_item/greater/frostveil/on_hit_response(var/obj/item/I, var/mob/living/carbon/human/owner, var/mob/living/carbon/human/attacker)
	if(world.time < src.last_used + 100)
		return
	if(isliving(attacker) && attacker != owner)
		attacker.apply_status_effect(/datum/status_effect/debuff/cold)
		attacker.visible_message(span_danger("[I] chills [attacker]!"))
		src.last_used = world.time

/datum/magic_item/greater/phoenixguard
	name = "phoenixguard"
	description = "It gives off radiant heat."
	var/last_used

/datum/magic_item/greater/phoenixguard/on_hit_response(var/obj/item/I, var/mob/living/carbon/human/owner, var/mob/living/carbon/human/attacker)
	if(world.time < src.last_used + 100)
		return
	if(isliving(attacker) && attacker != owner)
		attacker.adjust_fire_stacks(5)
		attacker.IgniteMob()
		attacker.visible_message(span_danger("[I] sets [attacker] on fire!"))
		src.last_used = world.time

/datum/magic_item/greater/woundclosing
	name = "wound closing"
	description = "It pulses with healing magick."
	var/active_item = FALSE

/datum/magic_item/greater/woundclosing/on_equip(var/obj/item/i, var/mob/living/user, slot)
	if(slot == ITEM_SLOT_HANDS)
		return
	if(active_item)
		return
	else
		user.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/docheallsser)
		to_chat(user, span_notice("[i] feels warm against fingers."))
		active_item = TRUE

/datum/magic_item/greater/woundclosing/on_drop(var/obj/item/i, var/mob/living/user)
	if(active_item)
		active_item = FALSE
		user.mind.RemoveSpell(/obj/effect/proc_holder/spell/targeted/docheallsser)
		to_chat(user, span_notice("The warmth of [i] fades away."))

/datum/magic_item/greater/returningweapon
	name = "returning weapon"
	description = "It glows with arcane sigils."
	var/active_item = FALSE

/datum/magic_item/greater/returningweapon/on_equip(var/obj/item/i, var/mob/living/user, slot)
	if(slot == ITEM_SLOT_HANDS)
		return
	if(active_item)
		return
	else
		active_item = TRUE
		user.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/summonweapon)
		to_chat(user, span_notice("I feel the magick within [i] resonate with my own."))

/datum/magic_item/greater/returningweapon/on_drop(var/obj/item/i, var/mob/living/user)
	if(active_item)
		user.mind.RemoveSpell(/obj/effect/proc_holder/spell/targeted/summonweapon)
		to_chat(user, span_notice("the warmth of [i] fades away."))
		active_item = FALSE

/datum/magic_item/greater/archery
	name = "archery"
	description = "It has the imprint of a bowstring."
	var/active_item = FALSE
/datum/magic_item/greater/archery/on_equip(var/obj/item/i, var/mob/living/user, slot)
	if(slot == ITEM_SLOT_HANDS)
		return
	if(active_item)
		return
	else
		user.change_stat("perception", 2)
		user.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		user.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		to_chat(user, span_notice("I feel more dexterious!"))
		active_item = TRUE

/datum/magic_item/greater/archery/on_drop(var/obj/item/i, var/mob/living/user)
	if(active_item)
		active_item = FALSE
		user.change_stat("perception", -2)
		user.mind.adjust_skillrank_down_to(/datum/skill/combat/bows, 2, TRUE)
		user.mind.adjust_skillrank_down_to(/datum/skill/combat/crossbows, 2, TRUE)
		to_chat(user, span_notice("I feel mundane once more"))

/datum/magic_item/greater/leaping
	name = "leaping"
	description = "It vibrates faintly with bound movement."
	var/active_item

/datum/magic_item/greater/leaping/on_equip(var/obj/item/i, var/mob/living/user, slot)
	.=..()
	if(slot == ITEM_SLOT_HANDS)
		return
	if(active_item)
		return
	else
		active_item = TRUE
		ADD_TRAIT(user, TRAIT_ZJUMP, TRAIT_GENERIC)
		ADD_TRAIT(user, TRAIT_LEAPER, TRAIT_GENERIC)
		to_chat(user, span_notice("My legs feel much stronger."))

/datum/magic_item/greater/leaping/on_drop(var/obj/item/i, var/mob/living/user)
	if(active_item)
		active_item = FALSE
		REMOVE_TRAIT(user, TRAIT_ZJUMP, TRAIT_GENERIC)
		REMOVE_TRAIT(user, TRAIT_LEAPER, TRAIT_GENERIC)
		to_chat(user, span_notice("I feel mundane once more."))
