/obj/effect/proc_holder/spell/invoked/strengthen_undead
	name = "Strengthen Undead"
	desc = "Suffuse a target with necrotic energies, mending the undead and paralyzing the living."
	invocation = "Kral'chal!"
	invocation_type = "shout"
	overlay_state = "raiseskele"
	releasedrain = 30
	chargetime = 5
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokegen
	sound = 'sound/magic/whiteflame.ogg'
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	charge_max = 15 SECONDS
	miracle = FALSE
	cost = 4
	chargedrain = 1
	xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/strengthen_undead/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(50, 50))
					target.update_damage_overlays()
				if(affecting.heal_wounds(50))
					target.update_damage_overlays()
			target.visible_message(span_danger("[target] reforms under the vile energy!"), span_notice("I'm remade by dark magic!"))
			return TRUE
		target.visible_message(span_info("Necrotic energy floods over [target]!"), span_userdanger("I feel colder as the dark energy floods into me!"))
		if(iscarbon(target))
			target.apply_status_effect(/datum/status_effect/debuff/weaken_living)
		else
			target.adjustBruteLoss(20)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/eyebite
	name = "Eyebite"
	desc = "Impale a target's eyes with arcane fangs, moderately wounding and temporarily blinding them."
	invocation = "Trk'chi'Esri!"
	invocation_type = "shout"
	overlay_state = "raiseskele"
	releasedrain = 30
	chargetime = 15
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokegen
	sound = 'sound/items/beartrap.ogg'
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	charge_max = 15 SECONDS
	miracle = FALSE
	cost = 3
	xp_gain = TRUE
	chargedrain = 2

/obj/effect/proc_holder/spell/invoked/eyebite/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_info("A loud crunching sound has come from [target]!"), span_userdanger("I feel arcane teeth biting into my eyes!"))
		target.adjustBruteLoss(30)
		target.blind_eyes(2)
		target.blur_eyes(10)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/raise_undead
	name = "Raise Undead"
	desc = "Reanimate a corpse as a skeleton. Reanimate many skeletons. Reanimate all the skeletons! There's a skeleton inside everyone and they wish to be free! The body must have all limbs and its head."
	clothes_req = FALSE
	range = 7
	overlay_state = "raiseskele"
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 40
	chargetime = 60
	chargedrain = 3
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	invocation = "Hgf'ant'kthar!"
	invocation_type = "shout"
	charge_max = 30 SECONDS
	cost = 10
	xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/raise_undead_lesser
	name = "Lesser Raise Undead"
	cost = 6
	desc = "Reanimate a corpse as a skeleton. You can maintain two sapient skeletons, the rest will be mindless. The body must have all limbs and its head."
	clothes_req = FALSE
	range = 7
	overlay_state = "raiseskele"
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 40
	chargetime = 60
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	invocation = "Hygf'akni'kthakchratah!"
	invocation_type = "shout"
	charge_max = 30 SECONDS
	chargedrain = 2
	xp_gain = TRUE

/**
  * Raises a minion from a corpse. Prioritizing ownership to original player > ghosts > npc.
  *
  * Vars:
  * * targets: list of mobs that are targetted.
  * * user: spell caster.
  */
/obj/effect/proc_holder/spell/invoked/raise_undead/cast(list/targets, mob/living/carbon/human/user)
	. = ..()

	if(!("undead" in user.faction))
		user.faction |= "undead"
	var/obj = targets[1]

	if(!obj || !istype(obj, /mob/living/carbon/human))
		to_chat(user, span_warning("I need to cast this spell on a corpse."))
		return FALSE

	// bandaid until goblin skeleton immortality is fixed
	if(istype(obj, /mob/living/carbon/human/species/goblin))
		to_chat(user, span_warning("I cannot raise goblins."))
		return FALSE

	var/mob/living/carbon/human/target = obj

	if(target.stat != DEAD)
		to_chat(user, span_warning("I cannot raise the living."))
		return FALSE

	if(HAS_TRAIT(target, TRAIT_SPECIALUNDEAD))
		to_chat(user, span_warning("This is an undead far beyond my perview. I cannot make it mine."))
		return FALSE

	var/obj/item/bodypart/target_head = target.get_bodypart(BODY_ZONE_HEAD)
	var/obj/item/bodypart/target_larm = target.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/target_rarm = target.get_bodypart(BODY_ZONE_R_ARM)
	var/obj/item/bodypart/target_lleg = target.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/target_rleg = target.get_bodypart(BODY_ZONE_R_LEG)
	if(!target_head)
		to_chat(user, span_warning("This corpse is headless."))
		return FALSE
	if(!target_larm)
		to_chat(user, span_warning("This corpse is missing a left arm."))
		return FALSE
	if(!target_rarm)
		to_chat(user, span_warning("This corpse is missing a right arm."))
		return FALSE
	if(!target_lleg)
		to_chat(user, span_warning("This corpse is missing a left leg."))
		return FALSE
	if(!target_rleg)
		to_chat(user, span_warning("This corpse is missing a right leg."))
		return FALSE

	var/offer_refused = FALSE

	target.visible_message(span_warning("[target.real_name]'s body is engulfed by dark energy..."), runechat_message = TRUE)

	if(target.ckey) //player still inside body

		var/offer = alert(target, "Do you wish to be reanimated as a minion?", "RAISED BY NECROMANCER", "Yes", "No")
		var/offer_time = world.time

		if(offer == "No" || world.time > offer_time + 5 SECONDS)
			to_chat(target, span_danger("Another soul will take over."))
			offer_refused = TRUE

		else if(offer == "Yes")
			to_chat(target, span_danger("You rise as a minion."))
			target.turn_to_minion(user, target.ckey)
			target.visible_message(span_warning("[target.real_name]'s eyes light up with an evil glow."), runechat_message = TRUE)
			return TRUE

	if(!target.ckey || offer_refused) //player is not inside body or has refused, poll for candidates

		var/list/candidates = pollCandidatesForMob("Do you want to play as a Necromancer's minion?", null, null, null, 100, target, POLL_IGNORE_NECROMANCER_SKELETON)

		// theres at least one candidate
		if(LAZYLEN(candidates))
			var/mob/C = pick(candidates)
			target.turn_to_minion(user, C.ckey)
			target.visible_message(span_warning("[target.real_name]'s eyes light up with an eerie glow."), runechat_message = TRUE)

		//no candidates, raise as npc
		else
			target.turn_to_minion(user)
			target.visible_message(span_warning("[target.real_name]'s eyes light up with a weak glow."), runechat_message = TRUE)

		return TRUE

	return FALSE

/mob/living/carbon/human/proc/set_necrotarget(value)
	necrotarget = value

/obj/effect/proc_holder/spell/invoked/raise_undead_lesser/cast(list/targets, mob/living/carbon/human/user)
	. = ..()

	if(!("undead" in user.faction))
		user.faction |= "undead"
	var/obj = targets[1]

	if(!obj || !istype(obj, /mob/living/carbon/human))
		to_chat(user, span_warning("I need to cast this spell on a corpse."))
		return FALSE

	// bandaid until goblin skeleton immortality is fixed
	if(istype(obj, /mob/living/carbon/human/species/goblin))
		to_chat(user, span_warning("I cannot raise goblins."))
		return FALSE

	// bandaid like the goblins, should also prevent farming the sewers for a free skeleton army
	if(istype(obj, /mob/living/carbon/human/species/human/northern/bum))
		to_chat(user, span_warning("I cannot raise this wretch."))
		return FALSE

	var/mob/living/carbon/human/target = obj

	if(target.stat != DEAD)
		to_chat(user, span_warning("I cannot raise the living."))
		return FALSE

	if(HAS_TRAIT(target, TRAIT_SPECIALUNDEAD))
		to_chat(user, span_warning("This is an undead far beyond my perview. I cannot make it mine."))
		return FALSE

	var/obj/item/bodypart/target_head = target.get_bodypart(BODY_ZONE_HEAD)
	var/obj/item/bodypart/target_larm = target.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/target_rarm = target.get_bodypart(BODY_ZONE_R_ARM)
	var/obj/item/bodypart/target_lleg = target.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/target_rleg = target.get_bodypart(BODY_ZONE_R_LEG)
	if(!target_head)
		to_chat(user, span_warning("This corpse is headless."))
		return FALSE
	if(!target_larm)
		to_chat(user, span_warning("This corpse is missing a left arm."))
		return FALSE
	if(!target_rarm)
		to_chat(user, span_warning("This corpse is missing a right arm."))
		return FALSE
	if(!target_lleg)
		to_chat(user, span_warning("This corpse is missing a left leg."))
		return FALSE
	if(!target_rleg)
		to_chat(user, span_warning("This corpse is missing a right leg."))
		return FALSE

	//Sanitychecker for lesser raise undead skeleton cap
	if(target.necrotarget == TRUE)
		to_chat(user, span_warning("I am already trying to raise this corpse."))
		return FALSE

	target.set_necrotarget(TRUE)
	target.visible_message(span_warning("[target.real_name]'s body is engulfed by dark energy..."), runechat_message = TRUE)

	if(user.mind.boneboys < user.mind.bonemax)
		to_chat(user, span_warning("I have the capacity to sustain another self aware skeleton!"))

		var/offer_refused = FALSE

		if(target.ckey) //player still inside body

			var/offer = alert(target, "Do you wish to be reanimated as a minion?", "RAISED BY NECROMANCER", "Yes", "No")
			var/offer_time = world.time

			if(offer == "No" || world.time > offer_time + 5 SECONDS)
				to_chat(target, span_danger("Another soul will take over."))
				offer_refused = TRUE

			else if(offer == "Yes")
				to_chat(target, span_danger("You rise as a minion."))
				target.turn_to_minion(user, target.ckey)
				target.visible_message(span_warning("[target.real_name]'s eyes light up with an evil glow."), runechat_message = TRUE)
				user.mind.adjust_boneboys(1)
				target.mind.set_boneboy(TRUE)
				target.mind.set_bonenecro(user)
				target.set_necrotarget(FALSE)
				return TRUE

		if(!target.ckey || offer_refused) //player is not inside body or has refused, poll for candidates

			var/list/candidates = pollCandidatesForMob("Do you want to play as a Necromancer's minion?", null, null, null, 100, target, POLL_IGNORE_NECROMANCER_SKELETON)

			// theres at least one candidate
			if(LAZYLEN(candidates))
				var/mob/C = pick(candidates)
				target.turn_to_minion(user, C.ckey)
				target.visible_message(span_warning("[target.real_name]'s eyes light up with an eerie glow."), runechat_message = TRUE)
				user.mind.adjust_boneboys(1)
				target.mind.set_boneboy(TRUE)
				target.mind.set_bonenecro(user)

			//no candidates, raise as npc
			else
				to_chat(user, span_warning("There are no souls to raise, this one shall be mindless.."))
				target.turn_to_minion(user)
				target.visible_message(span_warning("[target.real_name]'s eyes light up with a weak glow."), runechat_message = TRUE)

			target.set_necrotarget(FALSE)
			return TRUE
			////Not enough cap, raise as npc
	else if(user.mind.boneboys >= user.mind.bonemax)
		to_chat(user, span_warning("I cannot sustain another self aware skeleton, this one shall be mindless.."))
		to_chat(target, span_warning("I feel my soul being drawn downward as a foreign presence invades my body!"))
		target.client.try_descend() //Couldn't figure out how to eject to ghost despite spending like an hour looking, so instead shunt to underworld. Let them skip the waiting line
		target.turn_to_minion(user)
		target.visible_message(span_warning("[target.real_name]'s eyes light up with a weak glow."), runechat_message = TRUE)

		target.set_necrotarget(FALSE)
		return TRUE

	target.set_necrotarget(TRUE)
	return FALSE

/mob/living/proc/handle_necromancy()
	if(src.mind.boneboy == FALSE)
		return
	if(src.mind.bonenecro == null)
		return
	var/mob/living/carbon/human/user = src.mind.bonenecro
	user.mind.adjust_boneboys(-1)
	to_chat(user, span_warning("One of my sapient skeleton's bindings has come undone, I may now raise another."))
	src.mind.set_boneboy(FALSE)
	src.mind.set_bonenecro(null)


/**
  * Turns a mob into a skeletonized minion. Used for raising undead minions.
  * If a ckey is provided, the minion will be controlled by the player, NPC otherwise.
  *
  * Vars:
  * * master: master of the minion.
  * * ckey (optional): ckey of the player that will control the minion.
  */
/mob/living/carbon/human/proc/turn_to_minion(mob/living/carbon/human/master, ckey)

	if(!master)
		return FALSE

	src.revive(TRUE, TRUE)

	if(ckey) //player
		src.ckey = ckey
		ADD_TRAIT(src, TRAIT_ZIZO_MARKED, TRAIT_GENERIC)
	else //npc
		aggressive = 1
		mode = AI_HUNT
		wander = TRUE

	if(!mind)
		mind_initialize()

	mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 3, TRUE)
	mind.adjust_skillrank_up_to(/datum/skill/combat/axes, 3, TRUE)
	mind.adjust_skillrank_up_to(/datum/skill/combat/crossbows, 3, TRUE)
	mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 3, TRUE)
	mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 3, TRUE)
	mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 3, TRUE)
	mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 1, TRUE) //Some basic skills, for actual undead servants. Don't have to be all combat
	mind.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 1, TRUE)
	mind.adjust_skillrank_up_to(/datum/skill/craft/masonry, 1, TRUE)
	mind.adjust_skillrank_up_to(/datum/skill/labor/lumberjacking, 1, TRUE)
	mind.adjust_skillrank_up_to(/datum/skill/labor/mining, 1, TRUE)
	mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 1, TRUE)
	mind.current.job = null

	dna.species.species_traits |= NOBLOOD
	dna.species.soundpack_m = new /datum/voicepack/skeleton()
	dna.species.soundpack_f = new /datum/voicepack/skeleton()


	cmode_music = 'sound/music/combat_cult.ogg'

	patron = master.patron
	mob_biotypes |= MOB_UNDEAD
	faction = list("undead")
	ambushable = FALSE
	underwear = "Nude"

	for(var/obj/item/bodypart/BP in bodyparts)
		BP.skeletonize()

	var/obj/item/organ/eyes/eyes = getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(src,1)
		QDEL_NULL(eyes)

	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(src)

	if(charflaw)
		QDEL_NULL(charflaw)

	can_do_sex = FALSE //where my bonger go

	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC) //Why wasn't this a thing from the start
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LIMBATTACHMENT, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSLEEP, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
	update_body()

	to_chat(src, span_userdanger("My master is [master.real_name]."))

	master.minions += src

	return TRUE

/obj/effect/proc_holder/spell/invoked/projectile/sickness
	name = "Ray of Sickness"
	desc = "Fire a bolt of magical burning poison at a target. Onset may be slow."
	clothes_req = FALSE
	invocation = "Royk'talashi!"
	invocation_type = "shout"
	range = 15
	projectile_type = /obj/projectile/magic/sickness
	overlay_state = "raiseskele"
	sound = list('sound/misc/portal_enter.ogg')
	active = FALSE
	releasedrain = 30
	chargetime = 10
	chargedrain = 1
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	charge_max = 15 SECONDS
	cost = 3
	xp_gain = TRUE

/obj/effect/proc_holder/spell/self/command_undead
	name = "Command Undead"
	desc = "Broadcast a message to all your undead minions!"
	overlay_state = "raiseskele"
	sound = list('sound/magic/magnet.ogg')
	invocation = "Zuth'gorash vel'thar dral'oth!"
	invocation_type = "whisper"
	antimagic_allowed = TRUE
	chargedloop = /datum/looping_sound/invokegen
	charge_max = 15 SECONDS
	chargedrain = 1
	cost = 2
	xp_gain = TRUE

/obj/effect/proc_holder/spell/self/command_undead/cast(mob/user = usr)
	..()

	var/message = input("Speak to your minions!", "LICH") as text|null

	if(!message)
		return

	var/mob/living/carbon/human/lich_player = user

	to_chat(lich_player, span_boldannounce("Lich [lich_player.real_name] commands: [message]"))

	for(var/mob/player in lich_player.minions)
		if(player.mind)
			to_chat(player, span_boldannounce("Lich [lich_player.real_name] commands: [message]"))

/obj/effect/proc_holder/spell/invoked/revoke_unlife
	name = "Revoke Unlife"
	cost = 1
	desc = "Revoke the unlife of a misbehaving minions, banishing the soul straight to the underworld. Allowing you to raise the corpse once more with a different, more malleable soul."
	clothes_req = FALSE
	range = 7
	overlay_state = "raiseskele"
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 40
	chargedrain = 1
	chargetime = 2 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	invocation = "Hgf'ant'Zeshlesh!"
	invocation_type = "shout"
	charge_max = 2 SECONDS
	xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/revoke_unlife/cast(list/targets, mob/living/carbon/human/user)
	. = ..()

	var/obj = targets[1]

	if(!obj || !istype(obj, /mob/living/carbon/human))
		to_chat(user, span_warning("I should cast this spell on a misbehaving minion."))
		return
	var/mob/living/carbon/human/target = obj

	if(target.stat == DEAD)
		to_chat(user, span_warning("This one is already dead, best reanimate it."))
		return

	if(!(target in user.minions))
		to_chat(user, span_warning("This is not one of mine."))
		return

	if(!target.client)
		target.death()
		to_chat(user, span_warning("The strings are cut, the mindless one comes undone."))
		return

	to_chat(target, span_warning("I have disappointed my Master! I feel Necra's scythe catch upon my very soul!"))
	target.death()
	sleep(1 SECONDS)
	target.client.try_descend()
	to_chat(user, span_warning("The disappointment is no more, its husk free for a more.. Malleable soul."))


