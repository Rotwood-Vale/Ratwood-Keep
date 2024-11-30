
//Apprenticeship contract - moved to antag_spawner.dm
/////////////////////////////////////////Necromantic Stone///////////////////

/obj/item/necromantic_stone
	name = "necromantic stone"
	desc = ""
	icon = 'icons/obj/wizard.dmi'
	icon_state = "necrostone"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/list/spooky_scaries = list()
	var/unlimited = 0

/obj/item/necromantic_stone/unlimited
	unlimited = 1

/obj/item/necromantic_stone/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	if(!istype(M))
		return ..()

	if(!istype(user) || !user.canUseTopic(M, BE_CLOSE))
		return

	if(M.stat != DEAD)
		to_chat(user, span_warning("This artifact can only affect the dead!"))
		return

	for(var/mob/dead/observer/ghost in GLOB.dead_mob_list) //excludes new players
		if(ghost.mind && ghost.mind.current == M && ghost.client)  //the dead mobs list can contain clientless mobs
			ghost.reenter_corpse()
			break

	if(!M.mind || !M.client)
		to_chat(user, span_warning("There is no soul connected to this body..."))
		return

	check_spooky()//clean out/refresh the list
	if(spooky_scaries.len >= 3 && !unlimited)
		to_chat(user, span_warning("This artifact can only affect three undead at a time!"))
		return

	M.set_species(/datum/species/skeleton, icon_update=0)
	M.revive(full_heal = TRUE, admin_revive = TRUE)
	spooky_scaries |= M
	to_chat(M, "<span class='danger'>I have been revived by </span><B>[user.real_name]!</B>")
	to_chat(M, span_danger("[user.p_theyre(TRUE)] my master now, assist [user.p_them()] even if it costs you my new life!"))

	equip_roman_skeleton(M)

	desc = ""

/obj/item/necromantic_stone/proc/check_spooky()
	if(unlimited) //no point, the list isn't used.
		return

	for(var/X in spooky_scaries)
		if(!ishuman(X))
			spooky_scaries.Remove(X)
			continue
		var/mob/living/carbon/human/H = X
		if(H.stat == DEAD)
			H.dust(TRUE)
			spooky_scaries.Remove(X)
			continue
	listclearnulls(spooky_scaries)

//Funny gimmick, skeletons always seem to wear roman/ancient armour
/obj/item/necromantic_stone/proc/equip_roman_skeleton(mob/living/carbon/human/H)
	for(var/obj/item/I in H)
		H.dropItemToGround(I)

	var/hat = pick(/obj/item/clothing/head/helmet/roman, /obj/item/clothing/head/helmet/roman/legionnaire)
	H.equip_to_slot_or_del(new hat(H), SLOT_HEAD)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/costume/roman(H), SLOT_PANTS)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/roman(H), SLOT_SHOES)
	H.put_in_hands(new /obj/item/claymore(H), TRUE)
	H.equip_to_slot_or_del(new /obj/item/twohanded/spear(H), SLOT_BACK)


/obj/item/voodoo
	name = "wicker doll"
	desc = ""
	icon = 'icons/obj/wizard.dmi'
	icon_state = "voodoo"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	var/mob/living/carbon/human/target = null
	var/list/mob/living/carbon/human/possible = list()
	var/obj/item/voodoo_link = null
	var/cooldown_time = 30 //3s
	var/cooldown = 0
	max_integrity = 10
	resistance_flags = FLAMMABLE

/obj/item/voodoo/attackby(obj/item/I, mob/user, params)
	if(target && cooldown < world.time)
		if(I.get_temperature())
			to_chat(target, span_danger("I suddenly feel very hot!"))
			target.adjust_bodytemperature(50)
			GiveHint(target)
		else if(is_pointed(I))
			to_chat(target, span_danger("I feel a stabbing pain in [parse_zone(user.zone_selected)]!"))
			target.Paralyze(40)
			GiveHint(target)
		else if(istype(I, /obj/item/bikehorn))
			to_chat(target, span_danger("HONK"))
			SEND_SOUND(target, 'sound/blank.ogg')
			target.adjustEarDamage(0,3)
			GiveHint(target)
		cooldown = world.time +cooldown_time
		return

	if(!voodoo_link)
		if(I.loc == user && istype(I) && I.w_class <= WEIGHT_CLASS_SMALL)
			if (user.transferItemToLoc(I,src))
				voodoo_link = I
				to_chat(user, "You attach [I] to the doll.")
				update_targets()

/obj/item/voodoo/check_eye(mob/user)
	if(loc != user)
		user.reset_perspective(null)
		user.unset_machine()

/obj/item/voodoo/attack_self(mob/user)
	if(!target && possible.len)
		target = input(user, "Select my victim!", "Voodoo") as null|anything in sortNames(possible)
		return

	if(user.zone_selected == BODY_ZONE_CHEST)
		if(voodoo_link)
			target = null
			voodoo_link.forceMove(drop_location())
			to_chat(user, span_notice("I remove the [voodoo_link] from the doll."))
			voodoo_link = null
			update_targets()
			return

	if(target && cooldown < world.time)
		switch(user.zone_selected)
			if(BODY_ZONE_PRECISE_MOUTH)
				var/wgw =  sanitize(input(user, "What would you like the victim to say", "Voodoo", null)  as text)
				target.say(wgw, forced = "voodoo doll")
				log_game("[key_name(user)] made [key_name(target)] say [wgw] with a voodoo doll.")
			if(BODY_ZONE_PRECISE_R_EYE)
				user.set_machine(src)
				user.reset_perspective(target)
				spawn(100)
					user.reset_perspective(null)
					user.unset_machine()
			if(BODY_ZONE_R_LEG,BODY_ZONE_L_LEG)
				to_chat(user, span_notice("I move the doll's legs around."))
				var/turf/T = get_step(target,pick(GLOB.cardinals))
				target.Move(T)
			if(BODY_ZONE_R_ARM,BODY_ZONE_L_ARM)
				target.click_random_mob()
				GiveHint(target)
			if(BODY_ZONE_HEAD)
				to_chat(user, span_notice("I smack the doll's head with my hand."))
				target.Dizzy(10)
				to_chat(target, span_warning("I suddenly feel as if my head was hit with a hammer!"))
				GiveHint(target,user)
		cooldown = world.time + cooldown_time

/obj/item/voodoo/proc/update_targets()
	possible = list()
	if(!voodoo_link)
		return
	var/list/prints = voodoo_link.return_fingerprints()
	if(!length(prints))
		return FALSE
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		if(prints[md5(H.dna.uni_identity)])
			possible |= H

/obj/item/voodoo/proc/GiveHint(mob/victim,force=0)
	if(prob(50) || force)
		var/way = dir2text(get_dir(victim,get_turf(src)))
		to_chat(victim, span_notice("I feel a dark presence from [way]."))
	if(prob(20) || force)
		var/area/A = get_area(src)
		to_chat(victim, span_notice("I feel a dark presence from [A.name]."))

/obj/item/voodoo/suicide_act(mob/living/carbon/user)
    user.visible_message(span_suicide("[user] links the voodoo doll to [user.p_them()]self and sits on it, infinitely crushing [user.p_them()]self! It looks like [user.p_theyre()] trying to commit suicide!"))
    user.gib()
    return(BRUTELOSS)

/obj/item/voodoo/fire_act(added, maxstacks)
	if(target)
		target.adjust_fire_stacks(20)
		target.IgniteMob()
		GiveHint(target,1)
	return ..()

//Provides a decent heal, need to pump every 6 seconds
/obj/item/organ/heart/cursed/wizard
	pump_delay = 60
	heal_brute = 25
	heal_burn = 25
	heal_oxy = 25

//Warp Whistle: Provides uncontrolled long distance teleportation.

/obj/item/warpwhistle
	name = "warp whistle"
	desc = ""
	icon = 'icons/obj/wizard.dmi'
	icon_state = "whistle"
	var/on_cooldown = 0 //0: usable, 1: in use, 2: on cooldown
	var/mob/living/carbon/last_user

/obj/item/warpwhistle/proc/interrupted(mob/living/carbon/user)
	if(!user || QDELETED(src) || user.notransform)
		on_cooldown = FALSE
		return TRUE
	return FALSE

/obj/item/warpwhistle/proc/end_effect(mob/living/carbon/user)
	user.invisibility = initial(user.invisibility)
	user.status_flags &= ~GODMODE
	user.update_mobility()

/obj/item/warpwhistle/attack_self(mob/living/carbon/user)
	if(!istype(user) || on_cooldown)
		return
	on_cooldown = TRUE
	last_user = user
	var/turf/T = get_turf(user)
	playsound(T,'sound/blank.ogg', 200, TRUE)
	user.mobility_flags &= ~MOBILITY_MOVE
	new /obj/effect/temp_visual/tornado(T)
	sleep(20)
	if(interrupted(user))
		return
	user.invisibility = INVISIBILITY_MAXIMUM
	user.status_flags |= GODMODE
	sleep(20)
	if(interrupted(user))
		end_effect(user)
		return
	var/breakout = 0
	while(breakout < 50)
		var/turf/potential_T = find_safe_turf()
		if(T.z != potential_T.z || abs(get_dist_euclidian(potential_T,T)) > 50 - breakout)
			do_teleport(user, potential_T, channel = TELEPORT_CHANNEL_MAGIC)
			user.mobility_flags &= ~MOBILITY_MOVE
			T = potential_T
			break
		breakout += 1
	new /obj/effect/temp_visual/tornado(T)
	sleep(20)
	end_effect(user)
	if(interrupted(user))
		return
	on_cooldown = 2
	addtimer(VARSET_CALLBACK(src, on_cooldown, 0), 4 SECONDS)

/obj/item/warpwhistle/Destroy()
	if(on_cooldown == 1 && last_user) //Flute got dunked somewhere in the teleport
		end_effect(last_user)
	return ..()

/obj/effect/temp_visual/tornado
	icon = 'icons/obj/wizard.dmi'
	icon_state = "tornado"
	name = "tornado"
	desc = ""
	layer = FLY_LAYER
	randomdir = 0
	duration = 40
	pixel_x = 500

/obj/effect/temp_visual/tornado/Initialize()
	. = ..()
	animate(src, pixel_x = -500, time = 40)
