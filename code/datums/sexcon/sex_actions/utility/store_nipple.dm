/datum/sex_action/store_nipple
	name = "Store/remove object in nipple"

/datum/sex_action/store_nipple/shows_on_menu(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	var/obj/item/organ/breasts/userbreasts = user.getorgan(/obj/item/organ/breasts)
	if(userbreasts.breast_size < 4)
		return FALSE
	if(userbreasts.contents.len == 0 && user.get_active_held_item() == null)
		return FALSE
	if((userbreasts.contents.len <= 2 && user.get_active_held_item() == null) || (userbreasts.contents.len < 2 && user.get_active_held_item() != null))
		return TRUE
	if(!get_insertable_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/store_nipple/can_perform(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	var/obj/item/organ/breasts/userbreasts = user.getorgan(/obj/item/organ/breasts)
	var/obj/item/heldstuff = user.get_active_held_item()

	if(userbreasts.contents.len == 0 && heldstuff == null)
		return TRUE
	if((userbreasts.contents.len <= 2 && heldstuff == null) || (userbreasts.contents.len < 2 && heldstuff != null))
		return TRUE
	if(!get_insertable_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/store_nipple/on_start(mob/living/user, mob/living/target)
	var/obj/item/organ/breasts/userbreasts = user.getorgan(/obj/item/organ/breasts)
	var/obj/item/heldstuff = user.get_active_held_item()
	if(heldstuff)
		if(userbreasts.breast_size < 3)
			to_chat(user, span_info("Unfortunately, my breasts are not big enough to fit anything in them."))
			user.dropItemToGround(heldstuff)
			return
		else
			if(userbreasts.breast_size < 4 && heldstuff.w_class > WEIGHT_CLASS_TINY)
				to_chat(user, span_info("Unfortunately, my breasts are only big enough to fit tiny things."))
				user.dropItemToGround(heldstuff)
				return
			else
				if(userbreasts.breast_size < 5 && heldstuff.w_class > WEIGHT_CLASS_SMALL)
					to_chat(user, span_info("Unfortunately, my breasts are only big enough to fit small things."))
					user.dropItemToGround(heldstuff)
					return

	if(istype(heldstuff, /obj/item/rogueweapon))
		to_chat(user, span_userdanger("[heldstuff] may cut me while i put it in, depending on my precision of hand."))
	if(user.m_intent != MOVE_INTENT_SNEAK && userbreasts.contents.len < 2 && user.get_active_held_item() != null)
		user.visible_message(span_warning("[user] starts to stuff \the [heldstuff] in their nipple..."))
	if(user.m_intent != MOVE_INTENT_SNEAK && userbreasts.contents.len == 2 && user.get_active_held_item() == null)
		user.visible_message(span_warning("[user] starts to pull \the [english_list(userbreasts.contents)] from their nipple..."))

/datum/sex_action/store_nipple/is_finished(mob/living/user, mob/living/target)
	var/obj/item/useditem = user.get_active_held_item()
	var/obj/item/organ/breasts/userbreasts = user.getorgan(/obj/item/organ/breasts)
	var/mob/living/carbon/human/userussy = user
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
			to_chat(user, span_userdanger("OUCH! \the [useditem] bleeds my nipple!!!"))
			var/obj/item/bodypart/chest/gr = userussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
			gr.add_wound(/datum/wound/slash/small, TRUE, FALSE)
		else
			to_chat(user, span_userdanger("AHH!!! \the [useditem] TEARS my nipple!!!"))
			var/obj/item/bodypart/chest/gr = userussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
			gr.add_wound(/datum/wound/slash, TRUE, FALSE)
	if(userbreasts.contents.len < 2 && user.get_active_held_item() != null)
		if(user.m_intent != MOVE_INTENT_SNEAK)
			user.visible_message(span_warning("[user] manages to stuff \the [useditem] in their nipple."))
			playsound(user, 'sound/misc/mat/girlmouth (1).ogg', 15, TRUE, -2, ignore_walls = FALSE)
			useditem.extinguish()
			useditem.forceMove(userbreasts)
			userbreasts.contents += useditem
			to_chat(user, span_info("There is now [english_list(userbreasts.contents)] in my nipples."))
		else
			playsound(user, 'sound/misc/mat/girlmouth (1).ogg', 8, TRUE, -2, ignore_walls = FALSE)
			useditem.extinguish()
			useditem.forceMove(userbreasts)
			userbreasts.contents += useditem
			to_chat(user, span_info("There is now [english_list(userbreasts.contents)] in my nipples."))
	else if((userbreasts.contents.len <= 2 || user.get_active_held_item() == null))
		if(user.m_intent != MOVE_INTENT_SNEAK)
			user.visible_message(span_warning("[user] manages to pull [english_list(userbreasts.contents)] out of their nipple."))
			playsound(user, 'sound/misc/mat/insert (1).ogg', 15, TRUE, -2, ignore_walls = FALSE)
			for(var/obj/item/nipplecontents as anything in userbreasts.contents)
				nipplecontents.doMove(get_turf(user))
				userbreasts.contents -= nipplecontents
				user.put_in_active_hand(nipplecontents)
			to_chat(user, span_info("There is now nothing in my nipples."))
		else
			playsound(user, 'sound/misc/mat/insert (1).ogg', 8, TRUE, -2, ignore_walls = FALSE)
			for(var/obj/item/nipplecontents as anything in userbreasts.contents)
				nipplecontents.doMove(get_turf(user))
				userbreasts.contents -= nipplecontents
				user.put_in_active_hand(nipplecontents)
			to_chat(user, span_info("There is now nothing in my nipples."))
	return TRUE
