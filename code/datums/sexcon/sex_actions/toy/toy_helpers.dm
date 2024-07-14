/proc/get_dildo_in_either_hand(mob/living/carbon/human/user)
	for(var/obj/item/thing in user.held_items)
		if(thing == null)
			continue
		if(!istype(thing, /obj/item/dildo))
			continue
		return thing
	return null

//for vampires etc
/proc/check_dildo_silver(mob/living/carbon/human/user)
	for(var/obj/item/thing in user.held_items)
		if(thing == null)
			continue
		if(istype(thing, /obj/item/dildo/silver))
			return TRUE
	return null

/proc/dildoburn(mob/living/carbon/human/user)
	var/mob/living/carbon/human/H = user
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	if(ishuman(H))
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			if(rand(1,4) == 1)
				to_chat(H, span_userdanger("THE SILVER SIZZLES AGAINST MY INSIDES!"))
			H.adjustFireLoss(10)
			if(rand(1,10) == 1)
				H.fire_act(1,2)
				H.freak_out()
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				if(rand(1,6) == 1)
					to_chat(H, span_userdanger("The silver feels spicy inside."))
				H.adjustFireLoss(3) //non immune vampire lord
		if(W && W.transformed == TRUE)
			if(rand(1,4) == 1)
				to_chat(H, span_userdanger("THE SILVER SIZZLES AGAINST MY INSIDES!"))
			H.adjustFireLoss(5)
			if(rand(1,10) == 1)
				H.fire_act(1,2)
				H.freak_out()

/proc/other_dildoburn(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/mob/living/carbon/human/H = user
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	if(ishuman(H))
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			if(rand(1,4) == 1)
				to_chat(H, span_userdanger("THE SILVER SIZZLES AGAINST MY INSIDES!"))
			H.adjustFireLoss(10)
			if(rand(1,10) == 1)
				H.fire_act(1,2)
				H.freak_out()
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				if(rand(1,6) == 1)
					to_chat(H, span_userdanger("The silver feels spicy inside."))
				H.adjustFireLoss(3) //non immune vampire lord
		if(W && W.transformed == TRUE)
			if(rand(1,4) == 1)
				to_chat(H, span_userdanger("THE SILVER SIZZLES AGAINST MY INSIDES!"))
			H.adjustFireLoss(5)
			if(rand(1,10) == 1)
				H.fire_act(1,2)
				H.freak_out()
