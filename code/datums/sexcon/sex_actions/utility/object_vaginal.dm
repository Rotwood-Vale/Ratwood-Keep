//non dildo items, thank me later for the big funnies and exploits -- vide noir
/datum/sex_action/object_vaginal
	name = "Fuck cunt with object"
	var/ouchietext = "owie"
	do_time = 4 SECONDS //slower on your own but not as much as ass since this is on your front.

/datum/sex_action/object_vaginal/shows_on_menu(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	if(!get_funobject_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/object_vaginal/can_perform(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	if(!get_funobject_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/object_vaginal/on_start(mob/living/user, mob/living/target)
	var/obj/item/dildo = user.get_active_held_item()
	if(dildo.get_temperature() >= 150+T0C)
		to_chat(user, span_userdanger("\the [dildo] is flaming hot, this will hurt!"))
		to_chat(user, span_smallred("Nothing I do except extinguishing this will help."))

	if(istype(user.get_active_held_item(), /obj/item/rogueweapon))
		var/obj/item/rogueweapon/wdildo = dildo
		if(wdildo.sharpness >= IS_SHARP)
			to_chat(user, span_userdanger("\the [wdildo] is sharp, this will hurt!"))
			to_chat(user, span_smallred("I must control my <bold>speed</bold> for lesser risk."))
		if(wdildo.sharpness == IS_BLUNT)
			to_chat(user, span_userdanger("\the [wdildo] will mush my insides if i am not careful.!"))
			to_chat(user, span_smallred("I must control my <bold>speed</bold> for lesser risk."))

	if(istype(user.get_active_held_item(), /obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/contdildo = dildo
		if(contdildo.spillable)
			to_chat(user, span_info("\the [contdildo] will likely spill inside me."))
			to_chat(user, span_smallred("I can pump it with <bold>speed</bold> for faster success."))

	if(istype(user.get_active_held_item(), /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/fooddildo = dildo
		to_chat(user, span_info("\the [fooddildo] is food, this is the wrong hole, but..."))
		to_chat(user, span_smallred("I can <bold>force</bold> this in for faster success."))

	user.visible_message(span_warning("[user] stuffs \the [dildo] in their cunt..."))

/datum/sex_action/object_vaginal/on_perform(mob/living/user, mob/living/target)
	var/pain_amt = 3 //base pain amt to use
	var/obj/item/dildo = user.get_active_held_item()
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks their cunt with \the [dildo]."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	var/obj/item/organ/vagina/uservagina = user.getorganslot(ORGAN_SLOT_VAGINA)

	if(prob(2))
		if(dildo.w_class < WEIGHT_CLASS_SMALL && !uservagina.contents.len)
			to_chat(user, span_userdanger("Oh shit \the [dildo] is so small it slipped and now it's inside my hole."))
			dildo.extinguish()
			dildo.forceMove(uservagina)
			uservagina.contents += dildo
		else if (dildo.w_class < WEIGHT_CLASS_SMALL && uservagina.contents.len)
			to_chat(user, span_userdanger("Ah shit \the [dildo] is so small i dropped it on the ground."))
			user.dropItemToGround(dildo)

	if(dildo.get_temperature() >= 150+T0C)
		ouchietext = pick("OUCH! \the [dildo] burns my cunt!", "YOUCH! \the [dildo] burns my pussy!", "OW! \the [dildo] chars my walls!", "AGH! \the [dildo] burns my cunt!")
		to_chat(user, span_userdanger(ouchietext))
		user.apply_damage(rand(4,6), BURN, BODY_ZONE_PRECISE_GROIN)
		pain_amt *= 2

	var/datum/sex_controller/sc = user.sexcon
	if(istype(user.get_active_held_item(), /obj/item/rogueweapon))
		var/obj/item/rogueweapon/wdildo = dildo
		var/cutchance = 15*sc.speed //multiplies with speed
		if(user.lying) //less odds if laying
			cutchance *= 0.5
		if(wdildo.sharpness >= IS_SHARP && sc.speed > SEX_SPEED_LOW && prob(cutchance))
			ouchietext = pick("OUCH! \the [wdildo] cuts my insides!", "ACK! \the [wdildo] poked my walls!", "OW! \the [wdildo] cut my lower lips!", "ACK! \the [wdildo] stabs my womb!")
			to_chat(user, span_userdanger(ouchietext))
			user.apply_damage(rand(10,20), BRUTE, BODY_ZONE_PRECISE_GROIN)
			pain_amt *= 2
		if(wdildo.sharpness == IS_BLUNT && sc.speed > SEX_SPEED_MID && prob(cutchance))
			ouchietext = pick("OUCH! \the [wdildo] scrapes my insides!", "GUH! \the [wdildo] bruises my womb!", "OW! \the [wdildo] is pulls my cunt!", "AGH! \the [wdildo] smashes my womb!")
			to_chat(user, span_userdanger(ouchietext))
			user.apply_damage(rand(10,20), BRUTE, BODY_ZONE_PRECISE_GROIN)
			pain_amt *= 2

		var/mob/living/carbon/human/userussy = user
		var/woundchance = 4*sc.speed //multiplies with speed
		if(user.lying) //less odds if laying
			woundchance *= 0.5
		if(prob(woundchance))
			if(prob(90))
				to_chat(user, span_userdanger("OUCH! \the [wdildo] bleeds my cunt!!!"))
				var/obj/item/bodypart/chest/gr = userussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
				gr.add_wound(/datum/wound/slash, TRUE, FALSE)
				pain_amt *= 4
			else
				to_chat(user, span_userdanger("AHH!!! \the [wdildo] TEARS my cunt!!!"))
				var/obj/item/bodypart/chest/gr = userussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
				gr.add_wound(/datum/wound/slash/large, TRUE, FALSE)
				pain_amt *= 6

	if(istype(user.get_active_held_item(), /obj/item/ammo_casing/caseless/rogue))
		var/obj/item/ammo_casing/caseless/rogue/adildo = dildo
		var/cutchance = 15*sc.speed //multiplies with speed
		if(user.lying) //less odds if laying
			cutchance *= 0.5
		if(sc.speed > SEX_SPEED_LOW && prob(cutchance))
			ouchietext = pick("OUCH! \the [adildo] cuts my insides!", "ACK! \the [adildo] poked my walls!", "OW! \the [adildo] cut my lower lips!", "ACK! \the [adildo] stabs my womb!")
			to_chat(user, span_userdanger(span_userdanger(ouchietext)))
			user.apply_damage(rand(5,10), BRUTE, BODY_ZONE_PRECISE_GROIN)
			pain_amt *= 2

	if(istype(user.get_active_held_item(), /obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/contdildo = dildo
		var/spillchance = 15*sc.speed //multiplies with speed
		if(user.lying) //double spill odds if lying down due gravity and stuff.
			spillchance *= 2
		if(contdildo.spillable && prob(spillchance) && contdildo.reagents.total_volume)
			if(uservagina.reagents.total_volume >= (uservagina.reagents.maximum_volume -0.5))
				user.visible_message(span_notice("[contdildo] splashes it's contents around [user]'s hole as it is packed full!"))
				contdildo.reagents.reaction(user, TOUCH, sc.speed, FALSE)
				contdildo.reagents.remove_all(sc.speed)
			else
				user.visible_message(span_notice(pick("[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] fill [user]'s cunt.", "[user] feeds [user]'s cunt with [english_list(contdildo.reagents.reagent_list)] from \The [contdildo]", "[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] splash into [user]'s cunt.", "[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] flood into [user]'s cunt.")), span_notice(pick("[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] fill my cunt.", "I feed my cunt with [english_list(contdildo.reagents.reagent_list)] from \The [contdildo]", "[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] splash into my cunt.", "[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] flood into my pussy.")))
				contdildo.reagents.trans_to(uservagina, sc.speed, 1, TRUE, FALSE, uservagina, FALSE, INJECT, FALSE, TRUE)
			playsound(user, 'sound/misc/mat/endin.ogg', 100, TRUE)
			pain_amt = -8 //liquid ease pain i guess
			user.heal_bodypart_damage(0,1,0,TRUE) //water on burn i guess.

	//om nom nom
	if(istype(user.get_active_held_item(), /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/fooddildo = dildo
		var/stuffchance = 15*sc.force //multiplies with force
		pain_amt *= 0.25 //since it is based on force
		if(user.lying) //nom nom easier while laying
			stuffchance *= 2
		if(prob(stuffchance) && sc.force > SEX_FORCE_LOW && fooddildo.canconsume(user, user))
			user.visible_message(span_info(pick("Chunks of \the [fooddildo] fill [user]'s cunt.", "[user] feeds [user]'s cunt with chunks of \The [fooddildo]", "Chunks of \the [fooddildo] gets stuffed into [user]'s cunt.", "Chunks of \the [fooddildo] gets packed into [user]'s pussy.")), span_info(pick("Chunks of \the [fooddildo] fill my cunt.", "I feed my cunt with chunks of \The [fooddildo]", "Chunks of \the [fooddildo] gets stuffed into my cunt.", "Chunks of \the [fooddildo] gets packed into my pussy.")))
			fooddildo.sussyeat(user, user, BODY_ZONE_PRECISE_GROIN, TRUE)
			playsound(user.loc, 'sound/misc/mat/insert (2).ogg', 100, TRUE)
			user.heal_bodypart_damage(1,0,0,TRUE) //mm nutritions, food have less bites than liquids by far.

	user.sexcon.perform_sex_action(user, 2, pain_amt, TRUE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/object_vaginal/on_finish(mob/living/user, mob/living/target)
	var/obj/item/dildo = get_funobject_in_hand(user)
	user.visible_message(span_warning("[user] pulls \the [dildo] from their cunt."))

/datum/sex_action/object_vaginal/is_finished(mob/living/user, mob/living/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
