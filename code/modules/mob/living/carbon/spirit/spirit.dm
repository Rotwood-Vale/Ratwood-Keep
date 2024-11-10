/mob/living/carbon/spirit
	name = "Wanderer"
	verb_say = "moans"
	initial_language_holder = /datum/language_holder/universal
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "hollow"
	gender = NEUTER
	pass_flags = PASSTABLE
	var/owned_lantern = null
	mob_biotypes = MOB_SPIRIT|MOB_HUMANOID
	gib_type = /obj/effect/decal/cleanable/blood/gibs
	bodyparts = list(/obj/item/bodypart/chest/spirit, /obj/item/bodypart/head/spirit, /obj/item/bodypart/l_arm/spirit,
					 /obj/item/bodypart/r_arm/spirit, /obj/item/bodypart/r_leg/spirit, /obj/item/bodypart/l_leg/spirit)
	hud_type = /datum/hud/spirit
	density = FALSE // ghosts can pass through other mobs
	var/paid = FALSE
	var/beingmoved = FALSE
	var/livingname = null
	var/datum/mind/prevmind // the mind it had before becoming a spirit. used primarily for pacification
	var/being_spoken_with = FALSE // Prevents this spirit being a consecutive target of Speak with Soul spell.
	var/mob/speaking_with // Holds a reference to the summoning mob for notification purposes.

/obj/item/bodypart/chest/spirit
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"

/obj/item/bodypart/head/spirit
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"

/obj/item/bodypart/l_arm/spirit
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"

/obj/item/bodypart/l_leg/spirit
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"

/obj/item/bodypart/r_arm/spirit
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"

/obj/item/bodypart/r_leg/spirit
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"


/mob/living/carbon/spirit/Initialize(mapload, cubespawned=FALSE, mob/spawner)
	set_light(2, 2, "#547fa4")
	coin_upkeep()
	verbs += /mob/living/proc/mob_sleep
	verbs += /mob/living/proc/lay_down
	ADD_TRAIT(src, TRAIT_PACIFISM, TRAIT_GENERIC)
	var/first_part = pick("Sorrowful", "Forlorn", "Regretful", "Piteous", "Rueful", "Dejected", "Desolate", "Mournful", "Melancholic", "Woeful")
	var/second_part = pick("Wanderer", "Traveler", "Pilgrim", "Vagabond", "Nomad", "Wayfarer", "Spirit", "Specter", "Wraith", "Phantom")
	name = first_part + " " + second_part
	GLOB.spirit_list += src

	//initialize limbs
	create_bodyparts()
	create_internal_organs()
	. = ..()
	var/L = new /obj/item/flashlight/lantern/shrunken(src.loc)
	owned_lantern = L
	put_in_hands(L)
	AddComponent(/datum/component/footstep, FOOTSTEP_MOB_BAREFOOT, 1, 2)
	addtimer(CALLBACK(src, PROC_REF(give_patron_toll)), 15 MINUTES)

/mob/living/carbon/spirit/IgniteMob() // Override so they don't catch on fire.
	return

/mob/living/carbon/spirit/proc/give_patron_toll()
	if(QDELETED(src) || paid)
		return
	for(var/item in held_items)
		if(istype(item, /obj/item/underworld/coin))
			return
	put_in_hands(new /obj/item/underworld/coin/notracking(get_turf(src)))
	if(patron)
		to_chat(src, span_danger("Your suffering has not gone unnoticed, [patron] has rewarded you with your toll."))
	else
		to_chat(src, span_danger("Your suffering has not gone unnoticed, your patron has rewarded you with your toll."))
	playsound(src, 'sound/combat/caught.ogg', 80, TRUE, -1)

/mob/living/carbon/spirit/create_internal_organs()
	internal_organs += new /obj/item/organ/lungs
	internal_organs += new /obj/item/organ/heart
	internal_organs += new /obj/item/organ/brain
	internal_organs += new /obj/item/organ/tongue
	internal_organs += new /obj/item/organ/eyes
	internal_organs += new /obj/item/organ/ears
	internal_organs += new /obj/item/organ/liver
	internal_organs += new /obj/item/organ/stomach
	..()

/mob/living/carbon/spirit/Destroy()
	if(owned_lantern)
		qdel(owned_lantern)
	GLOB.spirit_list -= src
	return ..()

/mob/living/carbon/spirit/updatehealth()
	. = ..()
	var/slow = 0
	if(!HAS_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN))
		var/health_deficiency = (maxHealth - health)
		if(health_deficiency >= 45)
			slow += (health_deficiency / 25)
	add_movespeed_modifier(MOVESPEED_ID_MONKEY_HEALTH_SPEEDMOD, TRUE, 100, override = TRUE, multiplicative_slowdown = slow)

/mob/living/carbon/spirit/Stat()
	..()
	if(statpanel("Status"))
		stat(null, "Intent: [a_intent]")
		stat(null, "Move Mode: [m_intent]")
	return

/mob/living/carbon/spirit/toggle_move_intent(mob/user) // Override so they can't run.
	return

/mob/living/carbon/spirit/toggle_rogmove_intent(intent, silent = FALSE) // Override so they can't run.
	return

/mob/living/carbon/spirit/mmb_intent_change(input as text) // There's no need for them to change MMB intents
	return

/mob/living/carbon/spirit/returntolobby()
	set name = "{RETURN TO LOBBY}"
	set category = "Options"
	set hidden = 1

	if(key)
		GLOB.respawntimes[key] = world.time

	log_game("[key_name(usr)] respawned from underworld")

	to_chat(src, span_info("Returned to lobby successfully."))

	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		return
	client.screen.Cut()
	client.screen += client.void
//	stop_all_loops()
	SSdroning.kill_rain(src.client)
	SSdroning.kill_loop(src.client)
	SSdroning.kill_droning(src.client)
	remove_client_colour(/datum/client_colour/monochrome)
	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		return

	var/mob/dead/new_player/M = new /mob/dead/new_player()
	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		qdel(M)
		return

	M.key = key
	qdel(src)
	return

/mob/living/carbon/spirit/attack_animal(mob/living/simple_animal/M)
	if(beingmoved)
		return
	beingmoved = TRUE
	to_chat(src, "<B><font size=3 color=red>Your soul is dragged to an infathomably cruel place where it endures severe torment. You've all but given up hope when you feel a presence drag you back to that Forest.</font></B>")
	playsound(src, 'sound/combat/caught.ogg', 80, TRUE, -1)
	for(var/obj/effect/landmark/underworld/A in GLOB.landmarks_list)
		forceMove(A.loc)
	beingmoved = FALSE

///Get the underworld spirit associated with this mob (from the mind)
/mob/proc/get_spirit()
	var/mind_key = key || mind?.key
	if(!mind_key)
		return
	for(var/mob/living/carbon/spirit/spirit in GLOB.spirit_list)
		if((ckey(spirit.key) == ckey(mind_key)) || (ckey(spirit.mind?.key) == ckey(mind_key)))
			if(!mind || spirit.prevmind == mind) // prior respawn detection
				return spirit
			break

/mob/living/carbon/spirit/get_spirit()
	return src

/// Proc that will search inside a given atom for any corpses, and send the associated ghost to the lobby if possible
/proc/pacify_coffin(atom/movable/coffin, mob/user, deep = TRUE, give_pq = PQ_GAIN_BURIAL)
	if(!coffin)
		return FALSE
	var/success = FALSE
	if(isliving(coffin))
		if(pacify_corpse(coffin, user))
			success = TRUE
	for(var/mob/living/corpse in coffin)
		if(pacify_corpse(corpse, user))
			success = TRUE
		// no break. mass graves ahoy!
	//if this is a deep search, we will also search the FIRST closet immediately inside the coffin and pacify the occupants
	if(deep)
		for(var/obj/structure/closet/stuffing in coffin.contents)
			if(pacify_coffin(stuffing, user, deep = FALSE, give_pq = FALSE))
				success = TRUE
			break // only the first
	// Success is actually the ckey of the last attacker so we can prevent PQ farming from fragging people // DOESNT WORK "success" is not a ckey, just a bool for now
	if(success && deep) // deep is here for no double-message
		to_chat(user, span_rose("I gain a faint sense of peace.")) // flavor this however you want
		if(give_pq && user?.ckey && (user.ckey != success))
			adjust_playerquality(give_pq, user.ckey)
	return success

/// Proc that funeralizes a corpse by setting a variable in its mind, for reliable respawns.
/proc/pacify_corpse(mob/living/corpse, mob/user, coin_pq = PQ_GAIN_BURIAL_COIN)
	if(QDELETED(corpse) || QDELETED(corpse.mind) || (corpse.stat != DEAD))
		return FALSE
	if(copytext(corpse.key, 1, 2) == "@") // lazy version of IsMobAdminGhosted()
		return FALSE
	if(corpse.mind.funeral)
		to_chat(user, span_red("This one has already been buried."))
		return FALSE
	var/attacker_ckey = corpse.lastattackerckey || TRUE
	var/mob/living/carbon/human/human_corpse
	if(ishuman(corpse))
		human_corpse = corpse
	if(istype(human_corpse.mouth, /obj/item/roguecoin) && !HAS_TRAIT(corpse, TRAIT_BURIED_COIN_GIVEN))
		var/obj/item/roguecoin/coin = human_corpse.mouth
		if(coin.quantity >= 1) // stuffing their mouth full of a fuck ton of coins wont do shit
			ADD_TRAIT(human_corpse, TRAIT_BURIED_COIN_GIVEN, TRAIT_GENERIC)
			if(coin_pq && user?.ckey && (user.ckey != attacker_ckey))
				adjust_playerquality(coin_pq, user.ckey)
			qdel(human_corpse.mouth)
			human_corpse.update_inv_mouth()
			for(var/obj/effect/landmark/underworld/coin_spawn in GLOB.landmarks_list)
				var/turf/fallen = get_turf(coin_spawn)
				fallen = locate(fallen.x + rand(-3, 3), fallen.y + rand(-3, 3), fallen.z)
				new /obj/item/underworld/coin/notracking(fallen)
				fallen.visible_message(span_warning("A coin falls from above!"))
				break
	corpse.mind.remove_antag_datum(/datum/antagonist/zombie)
	corpse.mind.funeral = TRUE
	var/user_acknowledgement = user ? user.real_name : "a mysterious force"
	var/corpse_name = corpse.real_name || "*no name*"
	var/corpse_key = corpse.mind.key || "*no key*"
	testing("pacify_corpse success ([corpse_name], [corpse_key])")
	user.log_message("memorialized [corpse_name][corpse.mind.name ? " (mind-name [corpse.mind.name])" : ""], played by [corpse_key].", LOG_GAME)
	var/peace_message = span_rose("My soul finds peace buried in creation, thanks to [user_acknowledgement].")

	var/mob/living/carbon/spirit/spirit = corpse.get_spirit() // much less expensive to use now

	if(!CONFIG_GET(flag/force_respawn_on_funeral))
		// time to (expensively) search for whatever the mob is, to deliver the mail.
		var/mob/currentlyin
		if(corpse.mind.key)
			currentlyin = get_mob_by_key(corpse.mind.key) // the most expensive operation here
		if(currentlyin)
			if(corpse.mind == currentlyin.mind) // should only succeed if in body or ghosted, from the same character.
				to_chat(currentlyin, peace_message)
				to_chat(currentlyin, span_notice("You can now use 'Journey to the Underworld' in your Spirit tab to instantly return to the lobby."))
			else if(spirit)
				spirit.funeral_return(peace_message)
// /client/proc/funeral_login(), called on /client/New(), is set up to notify you if you're funeralized

	else // Config sez all ghosts gotta go straight to the lobby, simple as.
		if(spirit && spirit.speaking_with)
			to_chat(spirit.speaking_with, "The soul returns to the underworld.")
		var/mob/dead/observer/ghost = burial_rite_make_ghost(corpse)
		if(ghost && ghost.client)
			to_chat(ghost, peace_message)
			burial_rite_return_ghost_to_lobby(ghost)
			// /client/proc/funeral_login() will take care of the d/ced bois.
			// At this point, if you're not caught by the logic, you're on a different mind (character) entirely.
	return TRUE

// Teleports spirit to underworld spawn and pays its toll
/mob/living/carbon/spirit/proc/funeral_return(peace_message)
	to_chat(src, peace_message)
	var/paidfor = paid
	paid = TRUE
	if(speaking_with)
		to_chat(speaking_with, "The soul is being pulled away...")
	for(var/obj/effect/landmark/underworld/underspawn in shuffle(GLOB.landmarks_list))
		to_chat(src, span_warning("Something pulls me back towards my judgement..."))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(funeral_teleport), src, underspawn, paidfor), 5 SECONDS)
		break // No need to worry about Speak with Soul spell, that checks for funeral

/proc/funeral_teleport(mob/living/carbon/spirit/spirit, obj/effect/landmark/underworld/underspawn, paidfor)
	if(!QDELETED(spirit)) // in case they already used carriage
		spirit.visible_message(span_warning("[spirit] vanishes!"), span_warning("I'm whisked away!"))
		if(spirit.speaking_with)
			to_chat(spirit.speaking_with, "The soul returns to the underworld.")
		if(!paidfor)
			to_chat(spirit, span_notice("My toll has been paid for!") + "\n\
										The carriage is open to me...")
		for(var/obj/item/I in spirit.held_items) // won't need these anymore
			. |= spirit.dropItemToGround(I)
		spirit.loc = underspawn.loc
		spirit.invisibility = initial(spirit.invisibility) // remove effect from soulspeak spell immediately
		spirit.SetParalyzed(0)
		spirit.being_spoken_with = FALSE
		spirit.speaking_with = null
		spirit.set_resting(FALSE)


// used by force-respawn, and by living corpses using the underworld verb
// should be fine to use with disconnected people, as we'll have things to clean them up anyways
/proc/burial_rite_make_ghost(mob/living/corpse)
	var/mob/dead/observer/ghost
	if(!corpse.key)
		ghost = corpse.get_ghost(even_if_they_cant_reenter = TRUE, ghosts_with_clients = FALSE)
		//Try to find underworld spirit, if there is no ghost
		if(!ghost)
			var/mob/living/carbon/spirit/spirit = corpse.get_spirit()
			if(spirit)
				ghost = spirit.ghostize(force_respawn = TRUE)
				if(ghost)
					qdel(spirit)
				else
					message_admins("[ADMIN_LOOKUPFLW(spirit)] as underworld spirit had its body buried but failed to ghost for some reason. Might be stuck somehow.")
		return ghost
	else
		ghost = corpse.ghostize(force_respawn = TRUE)
		return ghost

/proc/burial_rite_return_ghost_to_lobby(mob/dead/observer/ghost)
	if(isadminobserver(ghost))
		ghost.log_message("skipped force-respawn due to being an admin ghost.", LOG_GAME)
		return

	if(ghost.key)
		GLOB.respawntimes[ghost.key] = world.time - RESPAWNTIME

	if(ghost.client)
		ghost.client.screen.Cut()
		ghost.client.screen += ghost.client.void
		SSdroning.kill_rain(ghost.client)
		SSdroning.kill_loop(ghost.client)
		SSdroning.kill_droning(ghost.client)
		ghost.remove_client_colour(/datum/client_colour/monochrome)
		ghost.log_message("was returned to lobby from burial rites.", LOG_GAME)
	else
		ghost.log_message("had no client in game during burial rites.", LOG_GAME)

	var/mob/dead/new_player/M = new /mob/dead/new_player()
	M.funeral_respawn = TRUE // informs the player as to why they were respawned

	M.key = ghost.key
	if(ghost.client)
		ghost.client.verbs -= GLOB.ghost_verbs
