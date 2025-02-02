/datum/sex_action/store_anal
	name = "Store/remove object in ass"

/datum/sex_action/store_anal/shows_on_menu(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_ANUS))
		return FALSE
	var/obj/item/organ/anus/userass = user.getorgan(/obj/item/organ/anus)
	if(userass.contents.len)
		return TRUE
	if(!get_insertable_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/store_anal/can_perform(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_ANUS))
		return FALSE
	var/obj/item/organ/anus/userass = user.getorgan(/obj/item/organ/anus)
	if(userass.contents.len)
		return TRUE
	if(!get_insertable_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/store_anal/on_start(mob/living/user, mob/living/target)
	var/obj/item/useditem = user.get_active_held_item()
	var/obj/item/organ/anus/userass = user.getorgan(/obj/item/organ/anus)
	if(istype(useditem, /obj/item/rogueweapon))
		to_chat(user, span_userdanger("[useditem] may cut me while i put it in, depending on my precision of hand."))
	if(user.m_intent != MOVE_INTENT_SNEAK && !userass.contents.len)
		user.visible_message(span_warning("[user] starts to stuff \the [useditem] in their ass..."))
	if(user.m_intent != MOVE_INTENT_SNEAK && userass.contents.len)
		user.visible_message(span_warning("[user] starts to pull \the [english_list(userass.contents)] from their ass..."))

/datum/sex_action/store_anal/is_finished(mob/living/user, mob/living/target)
	var/obj/item/useditem = user.get_active_held_item()
	var/obj/item/organ/anus/userass = user.getorgan(/obj/item/organ/anus)
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
			to_chat(user, span_userdanger("OUCH! \the [useditem] bleeds my ass!!!"))
			var/obj/item/bodypart/chest/gr = userussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
			gr.add_wound(/datum/wound/slash/small, TRUE, FALSE)
		else
			to_chat(user, span_userdanger("AHH!!! \the [useditem] TEARS my ass!!!"))
			var/obj/item/bodypart/chest/gr = userussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
			gr.add_wound(/datum/wound/slash, TRUE, FALSE)
	if(!userass.contents.len)
		if(user.m_intent != MOVE_INTENT_SNEAK)
			user.visible_message(span_warning("[user] manages to stuff \the [useditem] in their ass."))
			playsound(user, 'sound/misc/mat/girlmouth (1).ogg', 15, TRUE, -2, ignore_walls = FALSE)
			useditem.extinguish()
			useditem.forceMove(userass)
			userass.contents += useditem
			to_chat(user, span_info("There is now [english_list(userass.contents)] in my asshole."))
		else
			playsound(user, 'sound/misc/mat/girlmouth (1).ogg', 8, TRUE, -2, ignore_walls = FALSE)
			useditem.extinguish()
			useditem.forceMove(userass)
			userass.contents += useditem
			to_chat(user, span_info("There is now [english_list(userass.contents)] in my asshole."))
	else
		if(user.m_intent != MOVE_INTENT_SNEAK)
			user.visible_message(span_warning("[user] manages to pull [english_list(userass.contents)] out of their ass."))
			playsound(user, 'sound/misc/mat/insert (1).ogg', 15, TRUE, -2, ignore_walls = FALSE)
			for(var/obj/item/asscontents as anything in userass.contents)
				asscontents.doMove(get_turf(user))
				userass.contents -= asscontents
				user.put_in_active_hand(asscontents)
			to_chat(user, span_info("There is now nothing in my asshole."))
		else
			playsound(user, 'sound/misc/mat/insert (1).ogg', 8, TRUE, -2, ignore_walls = FALSE)
			for(var/obj/item/asscontents as anything in userass.contents)
				asscontents.doMove(get_turf(user))
				userass.contents -= asscontents
				user.put_in_active_hand(asscontents)
			to_chat(user, span_info("There is now nothing in my asshole."))
	return TRUE
