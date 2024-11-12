/obj/item/thermometer
	name = "thermoscope"
	desc = "Used to tell how hot or cold an item is, but it's hard to read unless you're an alchemist."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "thermometer"
	item_state = "pen"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	possible_item_intents = list(/datum/intent/use)

/obj/item/thermometer/attack_obj(obj/target, mob/living/user)
	if(target.is_open_container())
		if(user.mind.get_skill_level(/datum/skill/misc/treatment) < 1) //Show each individual reagent
			to_chat(user, span_warning("I don't know how to read a thermoscope..."))
			return
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target] is empty!"))
		if(user.mind.get_skill_level(/datum/skill/misc/treatment) <= 3)
			if(target.reagents.chem_temp >= 300)
				to_chat(user, span_notice("The temperature of the mixture is about [abs(round(target.reagents.chem_temp, 10) - 300)] degrees above room temperature."))
			if(target.reagents.chem_temp < 300)
				to_chat(user, span_notice("The temperature of the mixture is about [abs(round(target.reagents.chem_temp, 10) - 300)] degrees below room temperature."))
		else
			if(target.reagents.chem_temp >= 300)
				to_chat(user, span_notice("The temperature of the mixture is [abs(target.reagents.chem_temp - 300)] degrees above room temperature."))
			if(target.reagents.chem_temp < 300)
				to_chat(user, span_notice("The temperature of the mixture is [abs(target.reagents.chem_temp - 300)] degrees below room temperature."))
		return
	return
	
