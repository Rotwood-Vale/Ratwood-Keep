/obj/item/dice/attack_right(mob/user)
	if(HAS_TRAIT(user, TRAIT_BLACKLEG))
		var/list/possible_outcomes = list()
		var/special = FALSE
		if(special_faces.len == sides)
			possible_outcomes.Add(special_faces)
			special = TRUE
		else
			for(var/i in 1 to sides)
				possible_outcomes += i
		var/outcome = input(user, "What will you rig the next roll to?", "XYLIX") as null|anything in possible_outcomes
		if(special)
			outcome = special_faces.Find(outcome)
		if(!outcome)
			return
		rigged = DICE_BASICALLY_RIGGED
		rigged_value = outcome
		return
	. = ..()
