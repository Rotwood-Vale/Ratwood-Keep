/datum/sex_action/store_ass_other
	name = "search/insert in their ass"

/datum/sex_action/store_ass_other/shows_on_menu(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_ANUS))
		return FALSE
	var/obj/item/organ/anus/targetass = target.getorgan(/obj/item/organ/vagina)
	if(!targetass)
		return FALSE
	if(targetass.contents.len)
		return TRUE
	if(!get_insertable_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/store_ass_other/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_ANUS))
		return FALSE
	var/obj/item/organ/anus/targetass = target.getorgan(/obj/item/organ/vagina)
	if(targetass.contents.len)
		return TRUE
	if(!get_insertable_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/store_ass_other/on_start(mob/living/user, mob/living/target)
	var/obj/item/useditem = user.get_active_held_item()
	var/obj/item/organ/anus/targetass = target.getorgan(/obj/item/organ/vagina)
	if(istype(useditem, /obj/item/rogueweapon))
		to_chat(user, span_userdanger("[useditem] may cut [target] while i put it in, depending on my precision of hand."))
	if(user.m_intent != MOVE_INTENT_SNEAK && !targetass.contents.len)
		user.visible_message(span_warning("[user] starts to stuff \the [useditem] in [target]'s ass..."))
	if(user.m_intent != MOVE_INTENT_SNEAK && targetass.contents.len)
		user.visible_message(span_warning("[user] starts to pull \the [english_list(targetass.contents)] from [target]'s ass..."))

/datum/sex_action/store_ass_other/is_finished(mob/living/user, mob/living/target)
	var/obj/item/useditem = user.get_active_held_item()
	var/obj/item/organ/anus/targetass = target.getorgan(/obj/item/organ/vagina)
	var/mob/living/carbon/human/targetussy = user
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
			target.visible_message(span_userdanger("\the [useditem] bleeds [target]'s ass!!!"))
			var/obj/item/bodypart/chest/gr = targetussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
			gr.add_wound(/datum/wound/slash/small, TRUE, FALSE)
		else
			target.visible_message(span_userdanger("\the [useditem] TEARS [target]'s ass!!!"))
			var/obj/item/bodypart/chest/gr = targetussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
			gr.add_wound(/datum/wound/slash, TRUE, FALSE)
	if(!targetass.contents.len)
		if(user.m_intent != MOVE_INTENT_SNEAK)
			user.visible_message(span_warning("[user] manages to stuff \the [useditem] in [target]'s ass."))
			playsound(user, 'sound/misc/mat/girlmouth (1).ogg', 15, TRUE, -2, ignore_walls = FALSE)
			useditem.extinguish()
			useditem.forceMove(targetass)
			targetass.contents += useditem
			to_chat(user, span_info("There is now [english_list(targetass.contents)] in [target]'s anus."))
		else
			playsound(user, 'sound/misc/mat/girlmouth (1).ogg', 8, TRUE, -2, ignore_walls = FALSE)
			useditem.extinguish()
			useditem.forceMove(targetass)
			targetass.contents += useditem
			to_chat(user, span_info("There is now [english_list(targetass.contents)] in [target]'s anus."))
	else
		if(user.m_intent != MOVE_INTENT_SNEAK)
			user.visible_message(span_warning("[user] manages to pull [english_list(targetass.contents)] out of [target]'s ass."))
			playsound(user, 'sound/misc/mat/insert (1).ogg', 15, TRUE, -2, ignore_walls = FALSE)
			for(var/obj/item/asscontents as anything in targetass.contents)
				asscontents.doMove(get_turf(user))
				targetass.contents -= asscontents
				user.put_in_active_hand(asscontents)
			to_chat(user, span_info("There is now nothing in [target]'s asshole."))
		else
			playsound(user, 'sound/misc/mat/insert (1).ogg', 8, TRUE, -2, ignore_walls = FALSE)
			for(var/obj/item/asscontents as anything in targetass.contents)
				asscontents.doMove(get_turf(user))
				targetass.contents -= asscontents
				user.put_in_active_hand(asscontents)
			to_chat(user, span_info("There is now nothing in [target]'s asshole."))
	return TRUE
