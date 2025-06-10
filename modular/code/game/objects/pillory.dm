#define PILLORY_HEAD_OFFSET 2 // How much we need to move the player to center their head

/obj/structure/pillory
	name = "Pillory"
	desc = "To keep the criminals locked!"
	icon_state = "pillory_single"
	icon = 'modular/icons/obj/pillory.dmi'
	can_buckle = TRUE
	max_buckled_mobs = 1
	buckle_lying = 0
	buckle_prevents_pull = TRUE
	anchored = TRUE
	density = TRUE
	layer = ABOVE_ALL_MOB_LAYER
	plane = GAME_PLANE_UPPER
	locked = FALSE
	var/latched = FALSE
	var/base_icon = "pillory_single"
	var/list/accepted_id = list()
	var/keylock = TRUE

/obj/structure/pillory/double/custom
	keylock = FALSE

/obj/structure/pillory/double
	icon_state = "pillory_double"
	base_icon = "pillory_double"

/obj/structure/pillory/reinforced
	icon_state = "pillory_reinforced"
	base_icon = "pillory_reinforced"

/obj/structure/pillory/bounty/town_square
	accepted_id = list("keep_dungeon", "keep_barracks", "town_dungeon", "town_barracks", "bog_dungeon", "bog_barracks", "church")

/obj/structure/pillory/bounty/keep_dungeon
	accepted_id = list("keep_dungeon")

/obj/structure/pillory/reinforced/town_dungeon
	accepted_id = list("town_dungeon")

/obj/structure/pillory/reinforced/bog_dungeon
	accepted_id = list("bog_dungeon")


/obj/structure/pillory/Initialize()
	LAZYINITLIST(buckled_mobs)
	. = ..()

/obj/structure/pillory/examine(mob/user)
	. = ..()

	var/msg = "It is [latched ? "latched" : "unlatched"] and [locked ? "locked." : "unlocked."]<br/>"
	. += msg

/obj/structure/pillory/attack_right(mob/living/user)
	. = ..()
	if(!buckled_mobs.len)
		to_chat(user, span_warning("What's the point of latching it with nobody inside?"))
		return
	if(user in buckled_mobs)
		to_chat(user, span_warning("I can't reach the latch!"))
		return
	if(locked)
		to_chat(usr, span_warning("Unlock it first!"))
		return
	togglelatch(user)
	
/obj/structure/pillory/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/customlock/finished))
		var/obj/item/customlock/finished/K = P
		if(keylock)
			to_chat(user, span_warning("[src] already has a lock."))
		else
			keylock = TRUE
			accepted_id = list(K.lockhash)
			to_chat(user, span_notice("You add [K] to [P]."))
			qdel(P)
		return
	if(user in buckled_mobs)
		to_chat(user, span_warning("I can't reach the lock!"))
		return
	if(!latched && keylock)
		to_chat(user, span_warning("It's not latched shut!"))
		return
	if(istype(P, /obj/item/key))
		var/obj/item/key/K = P
		if (!keylock)
			to_chat(user, span_warning("\The [src] lacks a lock."))
			return
		if(K.lockid in accepted_id)
			togglelock(user)
			return
		else
			to_chat(user, span_warning("Wrong key."))
			playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
			return
	if(istype(P, /obj/item/storage/keyring))
		var/obj/item/storage/keyring/K = P
		for(var/obj/item/key/KE in K.contents)
			if(KE.lockid in accepted_id)
				togglelock(user)
				return
	if(istype(P, /obj/item/lockpick))
		trypicklock(P, user)
		return

/obj/structure/pillory/proc/trypicklock(obj/item/I, mob/user)
	if(!latched)
		to_chat(user, "<span class='warning'>This cannot be picked while it is unlatched.</span>")
		return
	if(!keylock)
		return
	else
		var/lockprogress = 0
		var/locktreshold = 100

		var/mob/living/L = user

		var/pickskill = user.mind.get_skill_level(/datum/skill/misc/lockpicking)
		var/perbonus = L.STAPER/2
		var/luckbonus = L.STALUC/4
		var/picktime = 70
		var/pickchance = 35
		var/moveup = 10

		picktime -= (pickskill * 10)
		picktime = clamp(picktime, 10, 70)

		moveup += (pickskill * 3)
		moveup = clamp(moveup, 10, 30)

		pickchance += pickskill * 10
		pickchance += perbonus
		pickchance += luckbonus
		pickchance = clamp(pickchance, 1, 95)

		while(!QDELETED(I) &&(lockprogress < locktreshold))
			if(!do_after(user, picktime, target = src))
				break
			if(prob(pickchance))
				lockprogress += moveup
				playsound(src.loc, pick('sound/items/pickgood1.ogg','sound/items/pickgood2.ogg'), 5, TRUE)
				to_chat(user, "<span class='warning'>Click...</span>")
				if(L.mind)
					var/amt2raise = L.STAINT
					var/boon = L.STALUC/4
					L.mind.add_sleep_experience(/datum/skill/misc/lockpicking, amt2raise + boon)
				if(lockprogress >= locktreshold)
					to_chat(user, "<span class='deadsay'>The locking mechanism gives.</span>")
					togglelock(user)
					break
				else
					continue
			else
				playsound(loc, 'sound/items/pickbad.ogg', 40, TRUE)
				I.take_damage(1)
				to_chat(user, "<span class='warning'>Clack.</span>")
				continue
		return

/obj/structure/pillory/proc/togglelatch(mob/living/user, silent)
	user.changeNext_move(CLICK_CD_MELEE)
	if(latched)
		user.visible_message(span_warning("[user] unlatches [src]."), \
			span_notice("I unlatch [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		latched = FALSE
	else
		user.visible_message(span_warning("[user] latches [src]."), \
			span_notice("I latch [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		latched = TRUE

/obj/structure/pillory/proc/togglelock(mob/living/user, silent)
	user.changeNext_move(CLICK_CD_MELEE)
	if (!latched)
		to_chat(user, span_warning("\The [src] is not latched shut."))
	if(locked)
		user.visible_message(span_warning("[user] unlocks [src]."), \
			span_notice("I unlock [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		locked = FALSE
	else
		user.visible_message(span_warning("[user] locks [src]."), \
			span_notice("I lock [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		locked = TRUE

/obj/structure/pillory/buckle_mob(mob/living/M, force = FALSE, check_loc = TRUE)
	if (!anchored)
		return FALSE

	if(locked)
		to_chat(usr, span_warning("Unlock it first!"))
		return FALSE

	if ((!istype(M, /mob/living/carbon/human)) || HAS_TRAIT(M, TRAIT_TINY))
		to_chat(usr, span_warning("It doesn't look like [M.p_they()] can fit into this properly!"))
		return FALSE // Can't hold non-humanoids

	for(var/obj/item/grabbing/G in M.grabbedby)
		if(G.grab_state == 1)
			return ..(M, force, FALSE)
	to_chat(usr, span_warning("I must grab them more forcefully to put them in the pillory."))
	return FALSE

/obj/structure/pillory/post_buckle_mob(mob/living/M)
	if (!istype(M, /mob/living/carbon/human))
		return

	var/mob/living/carbon/human/H = M

	if(H.dna)
		if(H.dna.species)
			var/datum/species/S = H.dna.species

			if(istype(S))
				//H.cut_overlays()
				H.update_body_parts_head_only()
				switch(H.dna.species.name)
					if("Dwarf", "Dwarf", "Kobold", "Goblin", "Verminvolk")
						H.set_mob_offsets("bed_buckle", _x = 0, _y = PILLORY_HEAD_OFFSET)
				icon_state = "[base_icon]-over"
				update_icon()
				H.setDir(SOUTH) //Makes the person always face south, in case someone constructed the pillory on the wrong direction
			else
				unbuckle_all_mobs()
		else
			unbuckle_all_mobs()
	else
		unbuckle_all_mobs()

	..()



/obj/structure/pillory/post_unbuckle_mob(mob/living/M)
	//M.regenerate_icons()
	M.reset_offsets("bed_buckle")
	..()

/obj/structure/pillory/unbuckle_mob(mob/living/user)
	if(latched)
		if(user.STASTR >= 18)
			if(do_after(user, 25))
				user.visible_message(span_warning("[user] breaks [src] open!"))
				locked = FALSE
				latched = FALSE
				..()
		else
			to_chat(usr, span_warning("Unlock it first!"))
			return FALSE
	else
		..()

	..()

#undef PILLORY_HEAD_OFFSET


/obj/structure/pillory/bounty
	name = "Excidium Pillory"
	desc = "Make the criminals pay for their crimes!"
	icon_state = "pillory_device"
	base_icon = "pillory_device"
	var/mob/living/carbon/human/bounty_hunter
	var/datum/bounty/active_bounty
	var/bounty_redemption_time = 3 MINUTES
	var/bounty_step_reward = 50
	var/bounty_timer

/obj/structure/pillory/bounty/Destroy()
	. = ..()
	if(bounty_timer)
		deltimer(bounty_timer)
		bounty_timer = null
	bounty_hunter = null

/obj/structure/pillory/bounty/post_buckle_mob(mob/living/M)
	if(!istype(M, /mob/living/carbon/human))
		return

	check_bounty(M)
	..()

/obj/structure/pillory/bounty/post_unbuckle_mob(mob/living/M)
	active_bounty = null
	bounty_hunter = null
	if(bounty_timer)
		deltimer(bounty_timer)
		bounty_timer = null
	..()

/obj/structure/pillory/bounty/proc/check_bounty(mob/living/carbon/human/victim)
	var/datum/bounty/found_bounty
	var/mob/living/carbon/human/hunter = usr
	if(!istype(hunter) || hunter == victim) return

	for(var/datum/bounty/bounty as anything in GLOB.head_bounties)
		if(bounty?.target == victim.real_name)
			found_bounty = bounty
			break
	if(!found_bounty) return

	if(!(hunter in SStreasury.bank_accounts))
		say("No account found, unable to redeem bounty. Submit your fingers to a shylock for inspection.")
		return
	say("Detected a bounty of [found_bounty.amount] mammons on [victim.real_name]!")
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, say), "Bounty redemption to [hunter] starts now, reward in [DisplayTimeText(bounty_redemption_time)]."), 2 SECONDS)
	bounty_hunter = hunter
	active_bounty = found_bounty
	bounty_timer(victim, found_bounty)

/obj/structure/pillory/bounty/proc/bounty_timer(mob/living/carbon/human/victim)
	bounty_timer = addtimer(CALLBACK(src, PROC_REF(bounty_redeem), victim), bounty_redemption_time, TIMER_STOPPABLE)

/obj/structure/pillory/bounty/proc/bounty_redeem(mob/living/carbon/human/victim)
	pay_bounty(bounty_step_reward, victim, active_bounty)

/obj/structure/pillory/bounty/proc/pay_bounty(amount = 0, mob/living/carbon/human/victim)
	if(amount <= 0 || !active_bounty) return 0
	var/reward_amount = min(active_bounty.amount, amount)

	if(reward_amount <= 0 && !(victim in buckled_mobs)) return 0

	if(!SStreasury.give_money_account(reward_amount, bounty_hunter, "+[reward_amount] from [active_bounty.target] bounty"))
		say("Treasury empty, unable to redeem bounty!")
		return 0
	active_bounty.amount -= reward_amount
	if(active_bounty.amount <= 0)
		GLOB.head_bounties -= active_bounty
		qdel(active_bounty)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, say), "Bounty has been exhausted!"), 1 SECONDS)
		if(reward_amount < 0)
			return 0
	say("Rewarded [bounty_hunter] with [reward_amount] mammon!")
	bounty_timer(bounty_hunter, victim)

	return reward_amount
