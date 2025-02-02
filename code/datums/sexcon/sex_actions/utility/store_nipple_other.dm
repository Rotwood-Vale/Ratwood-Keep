/datum/sex_action/store_nipple_other
	name = "Store/remove object in their nipple"

/datum/sex_action/store_nipple_other/shows_on_menu(mob/living/user, mob/living/target)
	if(target == user)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	var/obj/item/organ/breasts/targetbreasts = target.getorgan(/obj/item/organ/breasts)
	if(!targetbreasts)
		return FALSE
	if(targetbreasts.breast_size < 4)
		return FALSE
	if(targetbreasts.contents.len == 0 && target.get_active_held_item() == null)
		return FALSE
	if((targetbreasts.contents.len <= 2 && target.get_active_held_item() == null) || (targetbreasts.contents.len < 2 && target.get_active_held_item() != null))
		return TRUE
	if(!get_insertable_in_hand(target))
		return FALSE
	return TRUE

/datum/sex_action/store_nipple_other/can_perform(mob/living/user, mob/living/target)
	if(target == user)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	var/obj/item/organ/breasts/targetbreasts = target.getorgan(/obj/item/organ/breasts)
	var/obj/item/heldstuff = target.get_active_held_item()

	if(targetbreasts.contents.len == 0 && heldstuff == null)
		return TRUE
	if((targetbreasts.contents.len <= 2 && heldstuff == null) || (targetbreasts.contents.len < 2 && heldstuff != null))
		return TRUE
	if(!get_insertable_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/store_nipple_other/on_start(mob/living/user, mob/living/target)
	var/obj/item/organ/breasts/targetbreasts = target.getorgan(/obj/item/organ/breasts)
	var/obj/item/heldstuff = user.get_active_held_item()
	if(heldstuff)
		if(targetbreasts.breast_size < 3)
			to_chat(user, span_info("Unfortunately, [target]'s breasts are not big enough to fit anything in them."))
			user.dropItemToGround(heldstuff)
			return
		else 
			if(targetbreasts.breast_size < 4 && heldstuff.w_class > WEIGHT_CLASS_TINY)
				to_chat(user, span_info("Unfortunately, [target]'s breasts are only big enough to fit tiny things."))
				user.dropItemToGround(heldstuff)
				return
			else 
				if(targetbreasts.breast_size < 5 && heldstuff.w_class > WEIGHT_CLASS_SMALL)
					to_chat(user, span_info("Unfortunately, [target]'s breasts are only big enough to fit small things."))
					user.dropItemToGround(heldstuff)
					return
				// else 
				// 	if(targetbreasts.breast_size < 10 && heldstuff.w_class > WEIGHT_CLASS_NORMAL)
				// 		to_chat(user, span_info("Unfortunately, [target]'s breasts are only big enough to fit medium sized things."))
				// 		user.dropItemToGround(heldstuff)
				// 		return

	if(istype(heldstuff, /obj/item/rogueweapon))
		to_chat(user, span_userdanger("[heldstuff] may cut me while i put it in, depending on  my precision of hand."))
	if(user.m_intent != MOVE_INTENT_SNEAK && targetbreasts.contents.len < 2 && target.get_active_held_item() != null)
		target.visible_message(span_warning("[target] starts to stuff \the [heldstuff] in [target]'s nipple..."))
	if(user.m_intent != MOVE_INTENT_SNEAK && targetbreasts.contents.len == 2 && target.get_active_held_item() == null)
		target.visible_message(span_warning("[target] starts to pull \the [english_list(targetbreasts.contents)] from [target]'s nipple..."))

/datum/sex_action/store_nipple_other/is_finished(mob/living/user, mob/living/target)
	var/obj/item/useditem = target.get_active_held_item()
	var/obj/item/organ/breasts/targetbreasts = target.getorgan(/obj/item/organ/breasts)
	var/mob/living/carbon/human/targetussy = target
	var/stealskill =  max(1,user.mind.get_skill_level(/datum/skill/misc/stealing))
	var/medicineskill =  max(1,user.mind.get_skill_level(/datum/skill/misc/treatment))
	var/flubchance = 100
	if(stealskill > medicineskill) //medicine or stealth, taken higher and used to divide the flubbing chance, if you got neither skill its 100 odds, go home bro.
		flubchance = flubchance/stealskill
	else
		flubchance = flubchance/medicineskill

	if(istype(useditem, /obj/item/rogueweapon) && prob(flubchance))
		to_chat(user, span_smallnotice("[flubchance]% failure chance with skill."))
		if(prob(75))
			target.visible_message(span_userdanger("\the [useditem] bleeds [target]'s nipple!!!"))
			var/obj/item/bodypart/chest/gr = targetussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
			gr.add_wound(/datum/wound/slash/small, TRUE, FALSE)
		else
			target.visible_message(span_userdanger("\the [useditem] TEARS [target]'s nipple!!!"))
			var/obj/item/bodypart/chest/gr = targetussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
			gr.add_wound(/datum/wound/slash, TRUE, FALSE)
	if(targetbreasts.contents.len < 2 && target.get_active_held_item() != null)
		if(user.m_intent != MOVE_INTENT_SNEAK)
			target.visible_message(span_warning("[target] manages to stuff \the [useditem] in [target]'s nipple."))
			playsound(target, 'sound/misc/mat/girlmouth (1).ogg', 15, TRUE, -2, ignore_walls = FALSE)
			useditem.extinguish()
			useditem.forceMove(targetbreasts)
			targetbreasts.contents += useditem
			to_chat(user, span_info("There is now [english_list(targetbreasts.contents)] in [target]'s nipples."))
		else
			playsound(target, 'sound/misc/mat/girlmouth (1).ogg', 8, TRUE, -2, ignore_walls = FALSE)
			useditem.extinguish()
			useditem.forceMove(targetbreasts)
			targetbreasts.contents += useditem
			to_chat(user, span_info("There is now [english_list(targetbreasts.contents)] in [target]'s nipples."))
	else if((targetbreasts.contents.len <= 2 || target.get_active_held_item() == null))
		if(user.m_intent != MOVE_INTENT_SNEAK)
			target.visible_message(span_warning("[target] manages to pull [english_list(targetbreasts.contents)] out of [target]'s nipple."))
			playsound(target, 'sound/misc/mat/insert (1).ogg', 15, TRUE, -2, ignore_walls = FALSE)
			for(var/obj/item/nipplecontents as anything in targetbreasts.contents)
				nipplecontents.doMove(get_turf(target))
				targetbreasts.contents -= nipplecontents
				target.put_in_active_hand(nipplecontents)
			to_chat(user, span_info("There is now nothing in [target]'s nipples."))			
		else
			playsound(target, 'sound/misc/mat/insert (1).ogg', 8, TRUE, -2, ignore_walls = FALSE)
			for(var/obj/item/nipplecontents as anything in targetbreasts.contents)
				nipplecontents.doMove(get_turf(target))
				targetbreasts.contents -= nipplecontents
				target.put_in_active_hand(nipplecontents)
			to_chat(user, span_info("There is now nothing in [target]'s nipples."))
	return TRUE
