/datum/examine_effect/proc/trigger(mob/user)
	return

/datum/examine_effect/proc/get_examine_line(mob/user)
	return

/obj/item/examine(mob/user) //This might be spammy. Remove?
	. = ..()

	if(max_integrity)
		if(obj_integrity < max_integrity)
			if (obj_broken)
				. += span_warning("It's broken.")
			else
				var/meme = round(((obj_integrity / max_integrity) * 100), 1)
				switch(meme)
					if(0 to 1)
						. += span_warning("It's broken.")
					if(1 to 10)
						. += span_warning("It's nearly broken.")
					if(10 to 30)
						. += span_warning("It's severely damaged.")
					if(30 to 80)
						. += span_warning("It's damaged.")
					if(80 to 99)
						. += span_warning("It's a little damaged.")

//	if(has_inspect_verb || (obj_integrity < max_integrity))
//		. += span_notice("<a href='?src=[REF(src)];inspect=1'>Inspect</a>")

	var/real_value = get_real_price()
	if(real_value > 0)
		if(HAS_TRAIT(user, TRAIT_SEEPRICES) || simpleton_price)
			. += span_info("Value: [real_value] mammon")
		else if(HAS_TRAIT(user, TRAIT_SEEPRICES_SHITTY))
			//you can get up to 50% of the value if you have shitty see prices
			var/static/fumbling_seed = text2num(GLOB.rogue_round_id)
			var/fumbled_value = max(1, round(real_value + (real_value * clamp(noise_hash(real_value, fumbling_seed) - 0.5, -0.5, 0.5)), 1))
			. += span_info("Value: [fumbled_value] mammon... <i>I think</i>")

//	. += "[gender == PLURAL ? "They are" : "It is"] a [weightclass2text(w_class)] item."

// Makes it so people know which items can be affected by which effects. Don't show other flags if the object is already indestructible, to prevent filling chat.
	if(resistance_flags & INDESTRUCTIBLE)
		. += span_warning("[src] seems extremely sturdy! It'll probably withstand anything that could happen to it!")
	else
		if(resistance_flags & LAVA_PROOF)
			. += span_warning("[src] is made of an extremely heat-resistant material, it'd probably be able to withstand lava!")
		if(resistance_flags & (ACID_PROOF | UNACIDABLE))
			. += span_warning("[src] looks pretty sturdy! It'd probably be able to withstand acid!")
		if(resistance_flags & FREEZE_PROOF)
			. += span_warning("[src] is made of cold-resistant materials.")
		if(resistance_flags & FIRE_PROOF)
			. += span_warning("[src] is made of fire-retardant materials.")

	// Examines for weaknesses
	if(resistance_flags & FLAMMABLE)
		. += span_warning("[src] looks pretty flammable.")

	for(var/datum/examine_effect/E in examine_effects)
		E.trigger(user)

// Defaults for all machinery examines.
/obj/machinery/examine(mob/user)
	. = ..()

	if(max_integrity)
		if(obj_integrity < max_integrity)
			if (obj_broken)
				. += span_warning("It's broken.")
			else
				var/meme = round(((obj_integrity / max_integrity) * 100), 1)
				switch(meme)
					if(0 to 1)
						. += span_warning("It's broken.")
					if(1 to 10)
						. += span_warning("It's nearly broken.")
					if(10 to 30)
						. += span_warning("It's severely damaged.")
					if(30 to 80)
						. += span_warning("It's damaged.")
					if(80 to 99)
						. += span_warning("It's a little damaged.")

// Makes it so people know which items can be affected by which effects. Don't show other flags if the object is already indestructible, to prevent filling chat.
	if((resistance_flags & INDESTRUCTIBLE) || !max_integrity)
		. += span_warning("[src] seems extremely sturdy! It'll probably withstand anything that could happen to it!")
	else
		if(resistance_flags & LAVA_PROOF)
			. += span_warning("[src] is made of an extremely heat-resistant material, it'd probably be able to withstand lava!")
		if(resistance_flags & (ACID_PROOF | UNACIDABLE))
			. += span_warning("[src] looks pretty sturdy! It'd probably be able to withstand acid!")
		if(resistance_flags & FREEZE_PROOF)
			. += span_warning("[src] is made of cold-resistant materials.")
		if(resistance_flags & FIRE_PROOF)
			. += span_warning("[src] is made of fire-retardant materials.")

	// Examines for weaknesses
	if(resistance_flags & FLAMMABLE)
		. += span_warning("[src] looks pretty flammable.")
					