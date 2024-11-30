/mob/living/carbon/proc/monkeyize(tr_flags = (TR_KEEPITEMS | TR_KEEPVIRUS | TR_KEEPSTUNS | TR_KEEPREAGENTS | TR_DEFAULTMSG))
	if (notransform)
		return
	//Handle items on mob

	//first implants & organs
	var/list/stored_implants = list()
	var/list/int_organs = list()

	if (tr_flags & TR_KEEPIMPLANTS)
		for(var/X in implants)
			var/obj/item/implant/IMP = X
			stored_implants += IMP
			IMP.removed(src, 1, 1)

	var/list/missing_bodyparts_zones = get_missing_limbs()

	var/obj/item/cavity_object

	var/obj/item/bodypart/chest/CH = get_bodypart(BODY_ZONE_CHEST)
	if(CH.cavity_item)
		cavity_object = CH.cavity_item
		CH.cavity_item = null

	if(tr_flags & TR_KEEPITEMS)
		var/Itemlist = get_equipped_items(TRUE)
		Itemlist += held_items
		for(var/obj/item/W in Itemlist)
			dropItemToGround(W)

	//Make mob invisible and spawn animation
	notransform = TRUE
	Paralyze(22, ignore_canstun = TRUE)
	icon = null
	cut_overlays()
	invisibility = INVISIBILITY_MAXIMUM

	new /obj/effect/temp_visual/monkeyify(loc)
	sleep(22)
	var/mob/living/carbon/monkey/O = new /mob/living/carbon/monkey( loc )

	// hash the original name?
	if(tr_flags & TR_HASHNAME)
		O.name = "monkey ([copytext(md5(real_name), 2, 6)])"
		O.real_name = "monkey ([copytext(md5(real_name), 2, 6)])"

	//handle DNA and other attributes
	dna.transfer_identity(O)
	O.updateappearance(icon_update=0)

	if(tr_flags & TR_KEEPSE)
		O.dna.mutation_index = dna.mutation_index
		O.dna.set_se(1, GET_INITIALIZED_MUTATION(RACEMUT))

	if(suiciding)
		O.set_suicide(suiciding)
	if(hellbound)
		O.hellbound = hellbound
	O.a_intent = INTENT_HARM

	//keep viruses?
	if (tr_flags & TR_KEEPVIRUS)
		O.diseases = diseases
		diseases = list()
		for(var/thing in O.diseases)
			var/datum/disease/D = thing
			D.affected_mob = O

	//keep damage?
	if (tr_flags & TR_KEEPDAMAGE)
		O.setToxLoss(getToxLoss(), 0)
		O.adjustBruteLoss(getBruteLoss(), 0)
		O.setOxyLoss(getOxyLoss(), 0)
		O.setCloneLoss(getCloneLoss(), 0)
		O.adjustFireLoss(getFireLoss(), 0)
		O.setOrganLoss(ORGAN_SLOT_BRAIN, getOrganLoss(ORGAN_SLOT_BRAIN))
		O.updatehealth()
		O.radiation = radiation

	//re-add implants to new mob
	if (tr_flags & TR_KEEPIMPLANTS)
		for(var/Y in implants)
			var/obj/item/implant/IMP = Y
			IMP.implant(O, null, 1)

	//re-add organs to new mob. this order prevents moving the mind to a brain at any point
	if(tr_flags & TR_KEEPORGANS)
		for(var/X in O.internal_organs)
			var/obj/item/organ/I = X
			I.Remove(O, 1)

		if(mind)
			mind.transfer_to(O)

		for(var/X in internal_organs)
			var/obj/item/organ/I = X
			int_organs += I
			I.Remove(src, 1)

		for(var/X in int_organs)
			var/obj/item/organ/I = X
			I.Insert(O, 1)

	var/obj/item/bodypart/chest/torso = O.get_bodypart(BODY_ZONE_CHEST)
	if(cavity_object)
		torso.cavity_item = cavity_object //cavity item is given to the new chest
		cavity_object.forceMove(O)

	for(var/missing_zone in missing_bodyparts_zones)
		var/obj/item/bodypart/BP = O.get_bodypart(missing_zone)
		BP.drop_limb(1)
		if(!(tr_flags & TR_KEEPORGANS)) //we didn't already get rid of the organs of the newly spawned mob
			for(var/X in O.internal_organs)
				var/obj/item/organ/G = X
				if(BP.body_zone == check_zone(G.zone))
					qdel(G) //we lose the organs in the missing limbs
		qdel(BP)

	//transfer stuns
	if(tr_flags & TR_KEEPSTUNS)
		O.Stun(AmountStun(), ignore_canstun = TRUE)
		O.Knockdown(AmountKnockdown(), ignore_canstun = TRUE)
		O.Immobilize(AmountImmobilized(), ignore_canstun = TRUE)
		O.Paralyze(AmountParalyzed(), ignore_canstun = TRUE)
		O.Unconscious(AmountUnconscious(), ignore_canstun = TRUE)
		O.Sleeping(AmountSleeping(), ignore_canstun = TRUE)

	//transfer reagents
	if(tr_flags & TR_KEEPREAGENTS)
		reagents.trans_to(O, reagents.total_volume)

	//transfer mind if we didn't yet
	if(mind)
		mind.transfer_to(O)


	if (tr_flags & TR_DEFAULTMSG)
		to_chat(O, "<B>I are now a monkey.</B>")

	for(var/A in loc.vars)
		if(loc.vars[A] == src)
			loc.vars[A] = O

	transfer_observers_to(O)

	. = O

	qdel(src)

//////////////////////////           Humanize               //////////////////////////////
//Could probably be merged with monkeyize but other transformations got their own procs, too

/mob/living/carbon/proc/humanize(tr_flags = (TR_KEEPITEMS | TR_KEEPVIRUS | TR_KEEPSTUNS | TR_KEEPREAGENTS | TR_DEFAULTMSG))
	if (notransform)
		return
	//Handle items on mob

	//first implants & organs
	var/list/stored_implants = list()
	var/list/int_organs = list()

	if (tr_flags & TR_KEEPIMPLANTS)
		for(var/X in implants)
			var/obj/item/implant/IMP = X
			stored_implants += IMP
			IMP.removed(src, 1, 1)

	var/list/missing_bodyparts_zones = get_missing_limbs()

	var/obj/item/cavity_object

	var/obj/item/bodypart/chest/CH = get_bodypart(BODY_ZONE_CHEST)
	if(CH.cavity_item)
		cavity_object = CH.cavity_item
		CH.cavity_item = null

	//now the rest
	if (tr_flags & TR_KEEPITEMS)
		var/Itemlist = get_equipped_items(TRUE)
		Itemlist += held_items
		for(var/obj/item/W in Itemlist)
			dropItemToGround(W, TRUE)
			if (client)
				client.screen -= W



	//Make mob invisible and spawn animation
	notransform = TRUE
	Paralyze(22, ignore_canstun = TRUE)

	icon = null
	cut_overlays()
	invisibility = INVISIBILITY_MAXIMUM
	new /obj/effect/temp_visual/monkeyify/humanify(loc)
	sleep(22)

	var/mob/living/carbon/human/O = new( loc )
	for(var/obj/item/C in O.loc)
		if(C.anchored)
			continue
		O.equip_to_appropriate_slot(C)

	dna.transfer_identity(O)
	O.updateappearance(mutcolor_update=1)

	if(cmptext("monkey",copytext(O.dna.real_name,1,7)))
		O.real_name = random_unique_name(O.gender)
		O.dna.generate_unique_enzymes(O)
	else
		O.real_name = O.dna.real_name
	O.name = O.real_name

	if(tr_flags & TR_KEEPSE)
		O.dna.mutation_index = dna.mutation_index
		O.dna.set_se(0, GET_INITIALIZED_MUTATION(RACEMUT))
		O.domutcheck()

	if(suiciding)
		O.set_suicide(suiciding)
	if(hellbound)
		O.hellbound = hellbound

	//keep viruses?
	if (tr_flags & TR_KEEPVIRUS)
		O.diseases = diseases
		diseases = list()
		for(var/thing in O.diseases)
			var/datum/disease/D = thing
			D.affected_mob = O
		O.med_hud_set_status()

	//keep damage?
	if (tr_flags & TR_KEEPDAMAGE)
		O.setToxLoss(getToxLoss(), 0)
		O.adjustBruteLoss(getBruteLoss(), 0)
		O.setOxyLoss(getOxyLoss(), 0)
		O.setCloneLoss(getCloneLoss(), 0)
		O.adjustFireLoss(getFireLoss(), 0)
		O.adjustOrganLoss(ORGAN_SLOT_BRAIN, getOrganLoss(ORGAN_SLOT_BRAIN))
		O.updatehealth()
		O.radiation = radiation

	//re-add implants to new mob
	if (tr_flags & TR_KEEPIMPLANTS)
		for(var/Y in implants)
			var/obj/item/implant/IMP = Y
			IMP.implant(O, null, 1)

	if(tr_flags & TR_KEEPORGANS)
		for(var/X in O.internal_organs)
			var/obj/item/organ/I = X
			I.Remove(O, 1)

		if(mind)
			mind.transfer_to(O)
		for(var/X in internal_organs)
			var/obj/item/organ/I = X
			int_organs += I
			I.Remove(src, 1)

		for(var/X in int_organs)
			var/obj/item/organ/I = X
			I.Insert(O, 1)


	var/obj/item/bodypart/chest/torso = get_bodypart(BODY_ZONE_CHEST)
	if(cavity_object)
		torso.cavity_item = cavity_object //cavity item is given to the new chest
		cavity_object.forceMove(O)

	for(var/missing_zone in missing_bodyparts_zones)
		var/obj/item/bodypart/BP = O.get_bodypart(missing_zone)
		BP.drop_limb(1)
		if(!(tr_flags & TR_KEEPORGANS)) //we didn't already get rid of the organs of the newly spawned mob
			for(var/X in O.internal_organs)
				var/obj/item/organ/G = X
				if(BP.body_zone == check_zone(G.zone))
					qdel(G) //we lose the organs in the missing limbs
		qdel(BP)

	//transfer stuns
	if(tr_flags & TR_KEEPSTUNS)
		O.Stun(AmountStun(), ignore_canstun = TRUE)
		O.Knockdown(AmountKnockdown(), ignore_canstun = TRUE)
		O.Immobilize(AmountImmobilized(), ignore_canstun = TRUE)
		O.Paralyze(AmountParalyzed(), ignore_canstun = TRUE)
		O.Unconscious(AmountUnconscious(), ignore_canstun = TRUE)
		O.Sleeping(AmountSleeping(), ignore_canstun = TRUE)

	//transfer reagents
	if(tr_flags & TR_KEEPREAGENTS)
		reagents.trans_to(O, reagents.total_volume)

	if(mind)
		mind.transfer_to(O)

	O.a_intent = INTENT_HELP
	if (tr_flags & TR_DEFAULTMSG)
		to_chat(O, "<B>I are now a human.</B>")

	transfer_observers_to(O)

	. = O

	for(var/A in loc.vars)
		if(loc.vars[A] == src)
			loc.vars[A] = O

	qdel(src)

/mob/living/carbon/human/proc/corgize()
	if (notransform)
		return
	notransform = TRUE
	Paralyze(1, ignore_canstun = TRUE)
	for(var/obj/item/W in src)
		dropItemToGround(W)
	regenerate_icons()
	icon = null
	invisibility = INVISIBILITY_MAXIMUM
	for(var/t in bodyparts)	//this really should not be necessary
		qdel(t)

	var/mob/living/simple_animal/pet/dog/corgi/new_corgi = new /mob/living/simple_animal/pet/dog/corgi (loc)
	new_corgi.a_intent = INTENT_HARM
	new_corgi.key = key

	to_chat(new_corgi, "<B>I are now a Corgi. Yap Yap!</B>")
	. = new_corgi
	qdel(src)

/mob/living/carbon/proc/gorillize()
	if(notransform)
		return
	notransform = TRUE
	Paralyze(1, ignore_canstun = TRUE)

	SSblackbox.record_feedback("amount", "gorillas_created", 1)

	var/Itemlist = get_equipped_items(TRUE)
	Itemlist += held_items
	for(var/obj/item/W in Itemlist)
		dropItemToGround(W, TRUE)

	regenerate_icons()
	icon = null
	invisibility = INVISIBILITY_MAXIMUM
	var/mob/living/simple_animal/hostile/gorilla/new_gorilla = new (get_turf(src))
	new_gorilla.a_intent = INTENT_HARM
	if(mind)
		mind.transfer_to(new_gorilla)
	else
		new_gorilla.key = key
	to_chat(new_gorilla, "<B>I are now a gorilla. Ooga ooga!</B>")
	. = new_gorilla
	qdel(src)

/mob/living/carbon/human/Animalize()

	var/list/mobtypes = typesof(/mob/living/simple_animal)
	var/mobpath = input("Which type of mob should [src] turn into?", "Choose a type") in sortList(mobtypes, GLOBAL_PROC_REF(cmp_typepaths_asc))

	if(!safe_animal(mobpath))
		to_chat(usr, span_danger("Sorry but this mob type is currently unavailable."))
		return

	if(notransform)
		return
	notransform = TRUE
	Paralyze(1, ignore_canstun = TRUE)

	for(var/obj/item/W in src)
		dropItemToGround(W)

	regenerate_icons()
	icon = null
	invisibility = INVISIBILITY_MAXIMUM

	for(var/t in bodyparts)
		qdel(t)

	var/mob/new_mob = new mobpath(src.loc)

	new_mob.key = key
	new_mob.a_intent = INTENT_HARM


	to_chat(new_mob, span_boldnotice("I suddenly feel more... animalistic."))
	. = new_mob
	qdel(src)

/mob/proc/Animalize()

	var/list/mobtypes = typesof(/mob/living/simple_animal)
	var/mobpath = input("Which type of mob should [src] turn into?", "Choose a type") in sortList(mobtypes, GLOBAL_PROC_REF(cmp_typepaths_asc))

	if(!safe_animal(mobpath))
		to_chat(usr, span_danger("Sorry but this mob type is currently unavailable."))
		return

	var/mob/new_mob = new mobpath(src.loc)

	new_mob.key = key
	new_mob.a_intent = INTENT_HARM
	to_chat(new_mob, span_boldnotice("I feel more... animalistic."))

	. = new_mob
	qdel(src)

/* Certain mob types have problems and should not be allowed to be controlled by players.
 *
 * This proc is here to force coders to manually place their mob in this list, hopefully tested.
 * This also gives a place to explain -why- players shouldnt be turn into certain mobs and hopefully someone can fix them.
 */
/mob/proc/safe_animal(MP)

//Bad mobs! - Remember to add a comment explaining what's wrong with the mob
	if(!MP)
		return 0	//Sanity, this should never happen.

	if(ispath(MP, /mob/living/simple_animal/hostile/construct))
		return 0 //Verbs do not appear for players.

//Good mobs!
	if(ispath(MP, /mob/living/simple_animal/pet/cat))
		return 1
	if(ispath(MP, /mob/living/simple_animal/pet/dog/corgi))
		return 1
	if(ispath(MP, /mob/living/simple_animal/crab))
		return 1
	if(ispath(MP, /mob/living/simple_animal/hostile/carp))
		return 1
	if(ispath(MP, /mob/living/simple_animal/hostile/mushroom))
		return 1
	if(ispath(MP, /mob/living/simple_animal/shade))
		return 1
	if(ispath(MP, /mob/living/simple_animal/hostile/killertomato))
		return 1
	if(ispath(MP, /mob/living/simple_animal/mouse))
		return 1 //It is impossible to pull up the player panel for mice (Fixed! - Nodrak)
	if(ispath(MP, /mob/living/simple_animal/hostile/bear))
		return 1 //Bears will auto-attack mobs, even if they're player controlled (Fixed! - Nodrak)
	if(ispath(MP, /mob/living/simple_animal/parrot))
		return 1 //Parrots are no longer unfinished! -Nodrak

	//Not in here? Must be untested!
	return 0
