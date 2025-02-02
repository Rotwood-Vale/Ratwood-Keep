/datum/sex_action/store_vagina
	name = "Store/remove object in cunt"

/datum/sex_action/store_vagina/shows_on_menu(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	var/obj/item/organ/vagina/uservag = user.getorgan(/obj/item/organ/vagina)
	if(uservag.contents.len)
		return TRUE
	if(!get_insertable_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/store_vagina/can_perform(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	var/obj/item/organ/vagina/uservag = user.getorgan(/obj/item/organ/vagina)
	if(uservag.contents.len)
		return TRUE
	if(!get_insertable_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/store_vagina/on_start(mob/living/user, mob/living/target)
	var/obj/item/useditem = user.get_active_held_item()
	var/obj/item/organ/vagina/uservag = user.getorgan(/obj/item/organ/vagina)
	if(istype(useditem, /obj/item/rogueweapon))
		to_chat(user, span_userdanger("[useditem] may cut me while i put it in, depending on my precision of hand."))
	if(user.m_intent != MOVE_INTENT_SNEAK && !uservag.contents.len)
		user.visible_message(span_warning("[user] starts to stuff \the [useditem] in their cunt..."))
	if(user.m_intent != MOVE_INTENT_SNEAK && uservag.contents.len)
		user.visible_message(span_warning("[user] starts to pull \the [english_list(uservag.contents)] from their cunt..."))

/datum/sex_action/store_vagina/is_finished(mob/living/user, mob/living/target)
	var/obj/item/useditem = user.get_active_held_item()
	var/obj/item/organ/vagina/uservag = user.getorgan(/obj/item/organ/vagina)
	var/mob/living/carbon/human/userussy = user
	var/stealskill =  user.mind.get_skill_level(/datum/skill/misc/stealing)
	var/medicineskill =  user.mind.get_skill_level(/datum/skill/misc/treatment)
	var/flubchance = 100
	if(stealskill > medicineskill) //medicine or stealth, taken higher and used to divide the flubbing chance, if you got neither skill its 100 odds, go home bro.
		flubchance = flubchance/stealskill
	else
		flubchance = flubchance/medicineskill

	if(istype(useditem, /obj/item/rogueweapon) && prob(flubchance))
		to_chat(user, span_smallnotice("[flubchance]% failure chance with skill."))
		if(prob(75))
			to_chat(user, span_userdanger("OUCH! \the [useditem] bleeds my cunt!!!"))
			var/obj/item/bodypart/chest/gr = userussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
			gr.add_wound(/datum/wound/slash/small, TRUE, FALSE)
		else
			to_chat(user, span_userdanger("AHH!!! \the [useditem] TEARS my cunt!!!"))
			var/obj/item/bodypart/chest/gr = userussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
			gr.add_wound(/datum/wound/slash, TRUE, FALSE)
	if(!uservag.contents.len)
		if(user.m_intent != MOVE_INTENT_SNEAK)
			user.visible_message(span_warning("[user] manages to stuff \the [useditem] in their cunt."))
			playsound(user, 'sound/misc/mat/girlmouth (1).ogg', 15, TRUE, -2, ignore_walls = FALSE)
			useditem.extinguish()
			useditem.forceMove(uservag)
			uservag.contents += useditem
			to_chat(user, span_info("There is now [english_list(uservag.contents)] in my pussy."))
		else
			playsound(user, 'sound/misc/mat/girlmouth (1).ogg', 8, TRUE, -2, ignore_walls = FALSE)
			useditem.extinguish()
			useditem.forceMove(uservag)
			uservag.contents += useditem
			to_chat(user, span_info("There is now [english_list(uservag.contents)] in my pussy."))
	else
		if(user.m_intent != MOVE_INTENT_SNEAK)
			user.visible_message(span_warning("[user] manages to pull [english_list(uservag.contents)] out of their cunt."))
			playsound(user, 'sound/misc/mat/insert (1).ogg', 15, TRUE, -2, ignore_walls = FALSE)
			for(var/obj/item/pusscontents as anything in uservag.contents)
				pusscontents.doMove(get_turf(user))
				uservag.contents -= pusscontents
				user.put_in_active_hand(pusscontents)
			to_chat(user, span_info("There is now nothing in my pussy."))			
		else
			playsound(user, 'sound/misc/mat/insert (1).ogg', 8, TRUE, -2, ignore_walls = FALSE)
			for(var/obj/item/pusscontents as anything in uservag.contents)
				pusscontents.doMove(get_turf(user))
				uservag.contents -= pusscontents
				user.put_in_active_hand(pusscontents)
			to_chat(user, span_info("There is now nothing in my pussy."))
	return TRUE
