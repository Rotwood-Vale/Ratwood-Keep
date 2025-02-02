//weird lewd magic eating.
/obj/item/reagent_containers/food/snacks/proc/sussyeat(mob/living/M, mob/living/user, def_zone, pussy = FALSE)
	var/eatverbnew = pick("stuff","slip","push","tuck","pack","feed")
	var/eatloc = ""
	if(pussy)
		eatloc = pick("pussy","cunt","vagina","kitty","slit")
	else
		eatloc =pick("ass","asshole","butt","pucker","bum")
	if(iscarbon(M))
		if(!canconsume(M, user))
			return FALSE

		var/fullness = M.nutrition + 10
		for(var/datum/reagent/consumable/C in M.reagents.reagent_list) //we add the nutrition value of what we're currently digesting
			fullness += C.nutriment_factor * C.volume / C.metabolization_rate

		if(M == user)								//If you're eating it myself.
			switch(M.nutrition)
				if(NUTRITION_LEVEL_FAT to INFINITY)
					user.visible_message(span_notice("[user] forces [M.p_them()]self to [eatverbnew] \the [src] up [M.p_their()] [eatloc]."), span_notice("I force myself to [eatverbnew] \the [src] up my [eatloc]."))
				if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_FAT)
					user.visible_message(span_notice("[user] [eatverbnew]s \the [src] up [M.p_their()] [eatloc]."), span_notice("I [eatverbnew] \the [src] up my [eatloc]."))
				if(0 to NUTRITION_LEVEL_STARVING)
					user.visible_message(span_notice("[user] hastily [eatverbnew]s \the [src] up [M.p_their()] [eatloc], stuffing it deep!"), span_notice("I hastily [eatverbnew] \the [src] up my [eatloc], stuffing it deep!"))
					M.changeNext_move(CLICK_CD_MELEE * 0.5)
		else
			if(!isbrain(M))		//If you're feeding it to someone else.
				if(M.nutrition in NUTRITION_LEVEL_FAT to INFINITY)
					M.visible_message(span_warning("[user] cannot force any more of [src] up [M]'s [eatloc]!"), \
										span_warning("[user] cannot force any more of [src] up your[eatloc]!"))
					return FALSE
				else
					M.visible_message(span_danger("[user] tries to stuff [M] [src]."), \
										span_danger("[user] tries to stuff me [src]."))
				if(iscarbon(M))
					var/mob/living/carbon/C = M
					var/obj/item/bodypart/CH = C.get_bodypart(BODY_ZONE_HEAD)
					if(C.cmode)
						if(!CH.grabbedby)
							to_chat(user, span_info("[C.p_they(TRUE)] steals [C.p_their()] [eatloc] from it."))
							return FALSE
				if(!do_mob(user, M))
					return
				log_combat(user, M, "fed", reagents.log_list())
			else
				to_chat(user, span_warning("[M] doesn't seem to have a [eatloc]!"))
				return

		if(reagents)								//Send the reagents to the organ storage for slower processing
			if(M.satiety > -200)
				M.satiety -= junkiness
			if(reagents.total_volume)
				var/fraction = min(bitesize / reagents.total_volume, 1)
				var/amt2take = reagents.total_volume / (bitesize - bitecount)
				if((bitecount >= bitesize) || (bitesize == 1))
					amt2take = reagents.total_volume
				if(!pussy)
					var/obj/item/organ/userass = user.getorganslot(ORGAN_SLOT_ANUS)
					reagents.trans_to(userass, amt2take, TRUE, 4, FALSE, M, FALSE, INJECT)
				else
					var/obj/item/organ/userpussy = user.getorganslot(ORGAN_SLOT_VAGINA)
					reagents.trans_to(userpussy, amt2take, TRUE, 4, FALSE, M, FALSE, INJECT)
				bitecount++
				On_Consumealt(M)
				checkLiked(fraction, M)
				if(bitecount >= bitesize)
					qdel(src)
				return TRUE
		qdel(src)
		return FALSE

	return 0

/obj/item/reagent_containers/food/snacks/proc/On_Consumealt(mob/living/eater)
	if(!eater)
		return

	if(eat_effect)
		eater.apply_status_effect(eat_effect)

	if(!reagents.total_volume)
		var/mob/living/location = loc
		var/obj/item/trash_item = generate_trash(location)
		qdel(src)
		if(istype(location))
			location.put_in_hands(trash_item)

//weird lewd magic eating end.
// /mob/living/proc/check_funny_knockdown(mob/living/user)
// 	var/mob/living/carbon/human/funnyuser = user
// 	if(!issimple(funnyuser))
// 		for(var/obj/item/organ/forgan in funnyuser.internal_organs)
// 			forgan.organ_jumped()

