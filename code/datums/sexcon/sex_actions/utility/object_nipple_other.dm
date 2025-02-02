/datum/sex_action/object_nipple_other
	name = "Fuck their nipple with object"
	var/ouchietext = "owie"
	check_same_tile = FALSE

/datum/sex_action/object_nipple_other/shows_on_menu(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	if(!get_funobject_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/object_nipple_other/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	if(!get_funobject_in_hand(user))
		return FALSE
	if(target.cmode)
		return FALSE
	return TRUE

/datum/sex_action/object_nipple_other/on_start(mob/living/user, mob/living/target)
	var/obj/item/dildo = user.get_active_held_item()
	if(dildo.get_temperature() >= 150+T0C)
		to_chat(user, span_userdanger("\the [dildo] is flaming hot, this will hurt [target]!"))
		to_chat(user, span_smallred("Nothing I do except extinguishing this will help."))
	if(istype(user.get_active_held_item(), /obj/item/rogueweapon))
		var/obj/item/rogueweapon/wdildo = dildo
		if(wdildo.sharpness >= IS_SHARP)
			to_chat(user, span_userdanger("\the [wdildo] is sharp, this will hurt [target]!"))
			to_chat(user, span_smallred("I must control my <bold>speed</bold> for lesser risk."))
		if(wdildo.sharpness == IS_BLUNT)
			to_chat(user, span_userdanger("\the [wdildo] will mush [target]'s insides if i am not careful.!"))
			to_chat(user, span_smallred("I must control my <bold>speed</bold> for lesser risk."))

	if(istype(user.get_active_held_item(), /obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/contdildo = dildo
		if(contdildo.spillable)
			to_chat(user, span_info("\the [contdildo] will likely spill inside [target]."))
			to_chat(user, span_smallred("I can pump it with <bold>speed</bold> for faster success."))

	if(istype(user.get_active_held_item(), /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/fooddildo = dildo
		to_chat(user, span_info("\the [fooddildo] is food, this is the wrong hole, but..."))
		to_chat(user, span_smallred("I can <bold>force</bold> this in for faster success."))

	user.visible_message(span_warning("[user] stuffs \the [dildo] in [target]'s nipple..."))

/datum/sex_action/object_nipple_other/on_perform(mob/living/user, mob/living/target)
	var/pain_amt = 3 //base pain amt to use
	var/obj/item/dildo = user.get_active_held_item()
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks [target]'s nipple with \the [dildo]."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 50, TRUE, -2, ignore_walls = FALSE)

	if(dildo.get_temperature() >= 150+T0C)
		ouchietext = pick("OUCH! \the [dildo] burns [target]'s nipple!", "YOUCH! \the [dildo] burns [target]'s nipple!", "OW! \the [dildo] chars [target]'s walls!", "AGH! \the [dildo] burns [target]'s nipple!")
		target.visible_message(span_userdanger(ouchietext))
		target.apply_damage(rand(4,6), BURN, BODY_ZONE_CHEST)
		pain_amt *= 2

	var/datum/sex_controller/sc = user.sexcon
	if(istype(user.get_active_held_item(), /obj/item/rogueweapon))
		var/obj/item/rogueweapon/wdildo = dildo
		var/cutchance = 15*sc.speed //multiplies with speed
		if(user.lying) //less odds if laying
			cutchance *= 0.5
		if(wdildo.sharpness >= IS_SHARP && sc.speed > SEX_SPEED_LOW && prob(cutchance))
			ouchietext = pick("OUCH! \the [wdildo] cuts [target]'s insides!", "ACK! \the [wdildo] poked [target]'s walls!", "OW! \the [wdildo] cut [target]'s insides!", "ACK! \the [wdildo] stabs [target]'s womb!")
			target.visible_message(span_userdanger(ouchietext))
			target.apply_damage(rand(10,20), BRUTE, BODY_ZONE_CHEST)
			pain_amt *= 2
		if(wdildo.sharpness == IS_BLUNT && sc.speed > SEX_SPEED_MID && prob(cutchance))
			ouchietext = pick("OUCH! \the [wdildo] scrapes [target]'s insides!", "GUH! \the [wdildo] bruises [target]'s womb!", "OW! \the [wdildo] is pulls [target]'s nipple!", "AGH! \the [wdildo] smashes [target]'s womb!")
			target.visible_message(span_userdanger(ouchietext))
			target.apply_damage(rand(10,20), BRUTE, BODY_ZONE_CHEST)
			pain_amt *= 2

		var/mob/living/carbon/human/targetussy = target
		var/woundchance = 4*sc.speed //multiplies with speed
		if(user.lying) //less odds if laying
			woundchance *= 0.5
		if(prob(woundchance))
			if(prob(90))
				target.visible_message(span_userdanger("OUCH! \the [wdildo] bleeds [target]'s nipple!!!"))
				var/obj/item/bodypart/chest/gr = targetussy.get_bodypart(BODY_ZONE_CHEST)
				gr.add_wound(/datum/wound/slash, TRUE, FALSE)
				pain_amt *= 4
			else
				target.visible_message(span_userdanger("AHH!!! \the [wdildo] TEARS [target]'s nipple!!!"))
				var/obj/item/bodypart/chest/gr = targetussy.get_bodypart(BODY_ZONE_CHEST)
				gr.add_wound(/datum/wound/slash/large, TRUE, FALSE)
				pain_amt *= 6

	if(istype(user.get_active_held_item(), /obj/item/ammo_casing/caseless/rogue))
		var/obj/item/ammo_casing/caseless/rogue/adildo = dildo
		var/cutchance = 15*sc.speed //multiplies with speed
		if(user.lying) //less odds if laying
			cutchance *= 0.5
		if(sc.speed > SEX_SPEED_LOW && prob(cutchance))
			ouchietext = pick("OUCH! \the [adildo] cuts [target]'s insides!", "ACK! \the [adildo] poked [target]'s walls!", "OW! \the [adildo] cut [target]'s insides!", "ACK! \the [adildo] stabs [target]'s womb!")
			target.visible_message(span_userdanger(ouchietext))
			target.apply_damage(rand(5,10), BRUTE, BODY_ZONE_CHEST)
			pain_amt *= 2

	if(istype(user.get_active_held_item(), /obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/contdildo = dildo
		var/spillchance = 15*sc.speed //multiplies with speed
		if(target.lying) //double spill odds if lying down due gravity and stuff.
			spillchance *= 2
		if(contdildo.spillable && prob(spillchance) && contdildo.reagents.total_volume)
			var/obj/item/organ/targetbreasts = target.getorganslot(ORGAN_SLOT_BREASTS)
			if(targetbreasts.reagents.total_volume >= (targetbreasts.reagents.maximum_volume -0.5))
				target.visible_message(span_notice("[contdildo] splashes it's contents around [target]'s hole as it is packed full!"))
				contdildo.reagents.reaction(target, TOUCH, sc.speed, FALSE)
				contdildo.reagents.remove_all(sc.speed)
			else
				target.visible_message(span_notice(pick("[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] fill [target]'s nipple.", "[user] feeds [target]'s nipple with [english_list(contdildo.reagents.reagent_list)] from \The [contdildo]", "[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] splash into [target]'s nipple.", "[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] flood into [target]'s nipple.")))
				contdildo.reagents.trans_to(targetbreasts, sc.speed, 1, TRUE, FALSE, targetbreasts, FALSE, INJECT, FALSE, TRUE)
			playsound(target, 'sound/misc/mat/endin.ogg', 100, TRUE)
			pain_amt = -8 //liquid ease pain i guess
			target.heal_bodypart_damage(0,1,0,TRUE) //water on burn i guess.

	//om nom nom
	if(istype(user.get_active_held_item(), /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/fooddildo = dildo
		var/stuffchance = 15*sc.force //multiplies with force
		pain_amt *= 0.25 //since it is based on force
		if(user.lying) //nom nom easier while laying
			stuffchance *= 2
		if(prob(stuffchance) && sc.force > SEX_FORCE_LOW && fooddildo.canconsume(target, user))
			fooddildo.sussyeat(target, user, BODY_ZONE_CHEST, TRUE)
			target.visible_message(span_info(pick("Chunks of \the [fooddildo] fill [user]'s nipple.", "[user] feeds [user]'s nipple with chunks of \The [fooddildo]", "Chunks of \the [fooddildo] gets stuffed into [user]'s nipple.", "Chunks of \the [fooddildo] gets packed into [user]'s nipple.")), span_info(pick("Chunks of \the [fooddildo] fill my nipple.", "I feed my nipple with chunks of \The [fooddildo]", "Chunks of \the [fooddildo] gets stuffed into my nipple.", "Chunks of \the [fooddildo] gets packed into my nipple.")))
			playsound(target.loc, 'sound/misc/mat/insert (2).ogg', 100, TRUE)
			target.heal_bodypart_damage(1,0,0,TRUE) //mm nutritions.

	user.sexcon.perform_sex_action(target, 2, pain_amt, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/object_nipple_other/on_finish(mob/living/user, mob/living/target)
	var/obj/item/dildo = get_funobject_in_hand(user)
	user.visible_message(span_warning("[user] pulls \the [dildo] from [target]'s nipple."))

/datum/sex_action/object_nipple_other/is_finished(mob/living/user, mob/living/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
