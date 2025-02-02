/datum/sex_action/object_anal
	name = "Fuck ass with object"
	var/ouchietext = "owie"
	do_time = 5 SECONDS //slower on your own but not as much as ass since this is on your front.

/datum/sex_action/object_anal/shows_on_menu(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!get_funobject_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/object_anal/can_perform(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!get_funobject_in_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/object_anal/on_start(mob/living/user, mob/living/target)
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

	user.visible_message(span_warning("[user] stuffs \the [dildo] in their ass..."))

/datum/sex_action/object_anal/on_perform(mob/living/user, mob/living/target)
	var/pain_amt = 3 //base pain amt to use
	var/obj/item/dildo = user.get_active_held_item()
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks their ass with \the [dildo]."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 50, TRUE, -2, ignore_walls = FALSE)

	var/obj/item/organ/vagina/userass = user.getorganslot(ORGAN_SLOT_ANUS)

	if(prob(2))
		if(dildo.w_class < WEIGHT_CLASS_SMALL && !userass.contents.len)
			to_chat(user, span_userdanger("Oh shit \the [dildo] is so small it slipped and now it's inside my hole."))
			dildo.extinguish()
			dildo.forceMove(userass)
			userass.contents += dildo
		else if (dildo.w_class < WEIGHT_CLASS_SMALL && userass.contents.len)
			to_chat(user, span_userdanger("Ah shit \the [dildo] is so small i dropped it on the ground."))
			user.dropItemToGround(dildo)

	if(dildo.get_temperature() >= 150+T0C)
		ouchietext = pick("OUCH! \the [dildo] burns my ass!", "YOUCH! \the [dildo] burns my asshole!", "OW! \the [dildo] chars my guts!", "AGH! \the [dildo] burns my ass!")
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
			ouchietext = pick("OUCH! \the [wdildo] cuts my insides!", "ACK! \the [wdildo] poked my guts!", "OW! \the [wdildo] cut my asshole!", "ACK! \the [wdildo] stabs my guts!")
			to_chat(user, span_userdanger(ouchietext))
			user.apply_damage(rand(10,20), BRUTE, BODY_ZONE_PRECISE_GROIN)
			pain_amt *= 2
		if(wdildo.sharpness == IS_BLUNT && sc.speed > SEX_SPEED_MID && prob(cutchance))
			ouchietext = pick("OUCH! \the [wdildo] scrapes my insides!", "GUH! \the [wdildo] bruises my guts!", "OW! \the [wdildo] is pulls my ass!", "AGH! \the [wdildo] smashes my guts!")
			to_chat(user, span_userdanger(ouchietext))
			user.apply_damage(rand(10,20), BRUTE, BODY_ZONE_PRECISE_GROIN)
			pain_amt *= 2

		var/mob/living/carbon/human/userussy = user
		var/woundchance = 4*sc.speed //multiplies with speed
		if(user.lying) //less odds if laying
			woundchance *= 0.5
		if(prob(woundchance))
			if(prob(90))
				to_chat(user, span_userdanger("OUCH! \the [wdildo] bleeds my ass!!!"))
				var/obj/item/bodypart/chest/gr = userussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
				gr.add_wound(/datum/wound/slash, TRUE, FALSE)
				pain_amt *= 4
			else
				to_chat(user, span_userdanger("AHH!!! \the [wdildo] TEARS my ass!!!"))
				var/obj/item/bodypart/chest/gr = userussy.get_bodypart(BODY_ZONE_PRECISE_GROIN)
				gr.add_wound(/datum/wound/slash/large, TRUE, FALSE)
				pain_amt *= 6

	if(istype(user.get_active_held_item(), /obj/item/ammo_casing/caseless/rogue))
		var/obj/item/ammo_casing/caseless/rogue/adildo = dildo
		var/cutchance = 15*sc.speed //multiplies with speed
		if(user.lying) //less odds if laying
			cutchance *= 0.5
		if(sc.speed > SEX_SPEED_LOW && prob(cutchance))
			ouchietext = pick("OUCH! \the [adildo] cuts my insides!", "ACK! \the [adildo] poked my guts!", "OW! \the [adildo] cut my asshole!", "ACK! \the [adildo] stabs my guts!")
			to_chat(user, span_userdanger(span_userdanger(ouchietext)))
			user.apply_damage(rand(5,10), BRUTE, BODY_ZONE_PRECISE_GROIN)
			pain_amt *= 2

	if(istype(user.get_active_held_item(), /obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/contdildo = dildo
		var/spillchance = 15*sc.speed //multiplies with speed
		if(user.lying) //double spill odds if lying down due gravity and stuff.
			spillchance *= 2
		if(contdildo.spillable && prob(spillchance) && contdildo.reagents.total_volume)
			if(userass.reagents.total_volume >= (userass.reagents.maximum_volume -0.5))
				user.visible_message(span_notice("[contdildo] splashes it's contents around [user]'s hole as it is packed full!"))
				contdildo.reagents.reaction(user, TOUCH, sc.speed, FALSE)
				contdildo.reagents.remove_all(sc.speed)
			else
				user.visible_message(span_notice(pick("[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] fill [user]'s ass.", "[user] feeds [user]'s ass with [english_list(contdildo.reagents.reagent_list)] from \The [contdildo]", "[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] splash into [user]'s ass.", "[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] flood into [user]'s ass.")), span_notice(pick("[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] fill my ass.", "I feed my ass with [english_list(contdildo.reagents.reagent_list)] from \The [contdildo]", "[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] splash into my ass.", "[english_list(contdildo.reagents.reagent_list)] from \the [contdildo] flood into me.")))
				contdildo.reagents.trans_to(userass, sc.speed, 1, TRUE, FALSE, userass, FALSE, INJECT, FALSE, TRUE)
			playsound(user.loc, 'sound/misc/mat/endin.ogg', 100, TRUE)
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
			fooddildo.sussyeat(user, user, BODY_ZONE_PRECISE_GROIN, FALSE)
			user.visible_message(span_info(pick("Chunks of \the [fooddildo] fill [user]'s ass.", "[user] feeds [user]'s ass with chunks of \The [fooddildo]", "Chunks of \the [fooddildo] gets stuffed into [user]'s ass.", "Chunks of \the [fooddildo] gets packed into [user]'s asshole.")), span_info(pick("Chunks of \the [fooddildo] fill my ass.", "I feed my ass with chunks of \The [fooddildo]", "Chunks of \the [fooddildo] gets stuffed into my ass.", "Chunks of \the [fooddildo] gets packed into my asshole.")))
			playsound(user.loc, 'sound/misc/mat/insert (2).ogg', 100, TRUE)
			user.heal_bodypart_damage(1,0,0,TRUE) //mm nutritions.

	user.sexcon.perform_sex_action(user, 2, pain_amt, TRUE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/object_anal/on_finish(mob/living/user, mob/living/target)
	var/obj/item/dildo = get_funobject_in_hand(user)
	user.visible_message(span_warning("[user] pulls \the [dildo] from their ass."))

/datum/sex_action/object_anal/is_finished(mob/living/user, mob/living/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
