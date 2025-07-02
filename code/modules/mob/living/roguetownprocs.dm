/proc/accuracy_check(zone, mob/living/user, mob/living/target, associated_skill, datum/intent/used_intent, obj/item/I)
	if(!zone)
		return
	if(user == target)
		return zone
	if(zone == BODY_ZONE_CHEST)
		return zone
	// This is a more thorough check, but probably unnecessary.
	// if((user.r_grab && (user.r_grab in target.grabbedby)) || (user.l_grab && user.l_grab in target.grabbedby) || (user.mouth && user.mouth in target.grabbedby))
	if(target.pulledby == user)
		if(user.grab_state >= GRAB_AGGRESSIVE)
			return zone
	if(!(target.mobility_flags & MOBILITY_STAND))
		return zone
	if( (target.dir == turn(get_dir(target,user), 180)))
		return zone

	var/chance2hit = 0

	if(check_zone(zone) == zone)
		chance2hit += 10

	if(user.mind)
		chance2hit += (user.mind.get_skill_level(associated_skill) * 7)

	if(used_intent)
		if(used_intent.blade_class == BCLASS_STAB)
			chance2hit += user.STAPER
		if(used_intent.blade_class == BCLASS_CUT)
			chance2hit += round(user.STAPER/2)

	if(I)
		if(I.wlength == WLENGTH_SHORT)
			chance2hit += 10

		chance2hit += ((user.STAPER-10)*5)
		if(istype(I, /obj/item/rogueweapon/sword))
			var/obj/item/rogueweapon/sword/S = I
			chance2hit += S.accuracy_bonus

	chance2hit += zone_difficulty(zone)		//This makes it harder to hit places that are hyper specific.

	if(istype(user.rmb_intent, /datum/rmb_intent/aimed))
		chance2hit += (user.STAPER)*2
	if(istype(user.rmb_intent, /datum/rmb_intent/swift))
		chance2hit -= 20

	chance2hit = CLAMP(chance2hit, 5, 99)

	if(prob(chance2hit))
		return zone
	else
		var/accuracy2hit = chance2hit+25
		if(prob(accuracy2hit))
			if(check_zone(zone) == zone)
				return zone
			else
				if(user.client?.prefs.showrolls)
					to_chat(user, span_warning("Accuracy fail! [accuracy2hit]%"))
				return check_zone(zone)
		else
			if(user.client?.prefs.showrolls)
				to_chat(user, span_warning("Double accuracy fail! [chance2hit]%"))
			return BODY_ZONE_CHEST

/proc/zone_difficulty(zone)
	switch(zone)
		//Hyper specific targetting is very difficult
		if(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE,
		   BODY_ZONE_PRECISE_SKULL, BODY_ZONE_PRECISE_EARS,
		   BODY_ZONE_PRECISE_NOSE, BODY_ZONE_PRECISE_MOUTH,
		   BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND,
		   BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT)
			return -25

		// Head, arms, legs are all harder to hit then chest, but doable
		if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_NECK,
		   BODY_ZONE_L_ARM, BODY_ZONE_R_ARM,
		   BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			return -10

		// Groin/stomach maybe mild difficulty
		if(BODY_ZONE_PRECISE_GROIN, BODY_ZONE_PRECISE_STOMACH)
			return -5

		// Chest is easiest
		if(BODY_ZONE_CHEST)
			return 0

	return 0

/mob/proc/get_generic_parry_drain()
	return 30

/mob/living/proc/checkmiss(mob/living/user)
	if(user == src)
		return FALSE
	if(stat)
		return FALSE
	if(!(mobility_flags & MOBILITY_STAND))
		return FALSE
	if(user.badluck(4))
		var/list/usedp = list("Critical miss!", "Damn! Critical miss!", "No! Critical miss!", "It can't be! Critical miss!", "Betrayed by lady luck! Critical miss!", "Bad luck! Critical miss!", "Curse creation! Critical miss!", "What?! Critical miss!")
		to_chat(user, span_boldwarning("[pick(usedp)]"))
		flash_fullscreen("blackflash2")
		user.aftermiss()
		return TRUE

/mob/living/proc/checkdefense(datum/intent/intenty, mob/living/attacker)
	testing("begin defense")
	if(!cmode)
		return FALSE
	if(incapacitated())
		return FALSE
	if(!canparry && !candodge) //mob can do neither of these
		return FALSE
	if(attacker == src)
		return FALSE
	if(!(mobility_flags & MOBILITY_MOVE))
		return FALSE

	if(client?.charging && used_intent?.tranged && !used_intent.tshield)
		return FALSE

	switch(d_intent)
		if(INTENT_PARRY)
			return checkparry(intenty, attacker)
		if(INTENT_DODGE)
			return checkdodge(intenty, attacker)

/// origin is used for multi-step dodges like NPC jukes
/mob/living/proc/get_dodge_destinations(mob/living/attacker, atom/origin = src)
	var/dodge_dir = get_dir(attacker, origin)
	if(!dodge_dir) // dir is 0, so we're on the same tile.
		return null
	var/list/dirry = list(turn(dodge_dir, -90), dodge_dir, turn(dodge_dir, 90))
	// pick a random dir
	var/list/turf/dodge_candidates = list()
	for(var/dir_to_check in dirry)
		var/turf/dodge_candidate = get_step(origin, dir_to_check)
		if(!dodge_candidate)
			continue
		if(dodge_candidate.density)
			continue
		var/has_impassable_atom = FALSE
		for(var/atom/movable/AM in dodge_candidate)
			if(!AM.CanPass(src, dodge_candidate))
				has_impassable_atom = TRUE
				break
		if(has_impassable_atom)
			continue
		dodge_candidates += dodge_candidate
	return dodge_candidates

/mob/living/proc/checkdodge(datum/intent/intenty, mob/living/attacker)
	if(!candodge)
		return FALSE
	if(pulledby)
		return FALSE
	if(pulling == attacker)
		return FALSE
	if(world.time < last_dodge + dodgetime)
		if(!istype(rmb_intent, /datum/rmb_intent/riposte))
			return FALSE
	if(has_status_effect(/datum/status_effect/debuff/riposted))
		return FALSE
	last_dodge = world.time
	if(intenty && !intenty.candodge)
		return FALSE
	var/dodge_dir = get_dir(src, attacker)
	if(!dodge_dir) // dir is 0, so we're on the same tile.
		return FALSE
	var/list/turf/dodge_candidates = get_dodge_destinations(attacker)
	if(!length(dodge_candidates))
		to_chat(src, span_boldwarning("There's nowhere to dodge to!"))
		return FALSE
	var/turf/dodge_turf = pick(dodge_candidates)
	if(!do_dodge(attacker, dodge_turf))
		return FALSE // failed to dodge
	flash_fullscreen("blackflash2")
	attacker.aftermiss()
	return TRUE

/mob/living/proc/checkparry(datum/intent/enemy_intent, mob/living/attacker)
	/// The base skill used for weapon skill checks if the attacker or defender has no mind.
	var/const/NPC_BASE_WEAPON_SKILL = SKILL_LEVEL_NOVICE
	/// The base skill used for unarmed skill checks if the attacker or defender has no mind.
	var/const/NPC_BASE_UNARMED_SKILL = SKILL_LEVEL_NOVICE
	/// The bonus to defense probability from each level in the associated skill for a weapon in the active hand.
	var/const/MAINHAND_SKILL_BONUS = 20
	/// The bonus to defense probability from each point of defense on a weapon in the active hand.
	var/const/MAINHAND_WDEFENSE_BONUS = 10
	/// The bonus to defense probability from each level in the associated skill for a weapon in the inactive hand.
	var/const/OFFHAND_SKILL_BONUS = 20
	/// The bonus to defense probability from each point of defense on the weapon in the inactive hand.
	var/const/OFFHAND_WDEFENSE_BONUS = 10
	/// The bonus to defense probability from each level in the unarmed skill.
	var/const/UNARMED_SKILL_BONUS = 20
	/// The penalty to defense probability from each level in the attacker's skill, if the attacker is using a weapon.
	var/const/ATTACKER_WEAPON_SKILL_PENALTY = 20
	/// The penalty to defense probability from each level in the attacker's skill, if the attacker is unarmed.
	var/const/ATTACKER_UNARMED_SKILL_PENALTY = 20
	/// The penalty to defense probability when sprinting.
	var/const/SPRINT_PENALTY = 15
	/// The penalty to defense probability per point of speed difference, scaled by wbalance.
	var/const/ATTACKER_SWIFT_WEAPON_PENALTY = 10
	/// How much less likely are we to succeed at a parry when not standing?
	var/const/FLOORED_PROB_MULTIPLIER = 0.65
	/// What is the minimum final chance to parry, no matter what?
	var/const/MIN_PARRY_CHANCE = 5
	/// What is the maximum final chance to parry, no matter what?
	var/const/MAX_PARRY_CHANCE = 90
	/// The minimum stamina drain when parrying.
	var/const/MIN_STAMINA_DRAIN = 5
	/// The additional stamina drain per point of strength difference, scaled by wbalance.
	var/const/ATTACKER_HEAVY_WEAPON_STAM_PENALTY = 5
	/// What fraction of the damage returned by get_complex_damage is applied to the weapon on a successful parry?
	var/const/PARRY_DAMAGE_RATIO = 0.5
	/// The probability of creating fancy sparks when a metal weapon parries another metal weapon.
	var/const/PARRY_SPARK_CHANCE = 66
	if(HAS_TRAIT(src, TRAIT_CHUNKYFINGERS))
		return FALSE
	if(pulledby == attacker && pulledby.grab_state >= GRAB_AGGRESSIVE)
		return FALSE
	if(pulling == attacker && grab_state >= GRAB_AGGRESSIVE)
		return FALSE
	if(world.time < last_parry + setparrytime)
		if(!istype(rmb_intent, /datum/rmb_intent/riposte))
			return FALSE
	if(has_status_effect(/datum/status_effect/debuff/feinted))
		return FALSE
	if(has_status_effect(/datum/status_effect/debuff/riposted))
		return FALSE
	last_parry = world.time
	if(enemy_intent && !enemy_intent.canparry)
		return FALSE
	if(!can_see_cone(attacker))
		return FALSE

	var/drained = attacker.defdrain
	var/weapon_parry = FALSE
	var/offhand_defense = 0
	var/mainhand_defense = 0
	var/highest_defense = 0
	var/obj/item/mainhand = get_active_held_item()
	var/obj/item/offhand = get_inactive_held_item()
	var/obj/item/used_weapon = mainhand
	var/obj/item/rogueweapon/shield/buckler/skiller = get_inactive_held_item()  // buckler code
	var/obj/item/rogueweapon/shield/buckler/skillerbuck = get_active_held_item()

	if(istype(offhand, /obj/item/rogueweapon/shield/buckler))
		skiller.bucklerskill(src)
	if(istype(mainhand, /obj/item/rogueweapon/shield/buckler))
		skillerbuck.bucklerskill(src)  //buckler code end

	if(mainhand)
		if(mainhand.can_parry)
			mainhand_defense += (mind ? mind.get_skill_level(mainhand.associated_skill) : NPC_BASE_WEAPON_SKILL) * MAINHAND_SKILL_BONUS
			mainhand_defense += mainhand.wdefense * MAINHAND_WDEFENSE_BONUS
	if(offhand)
		if(offhand.can_parry)
			offhand_defense += (mind ? mind.get_skill_level(offhand.associated_skill) : NPC_BASE_WEAPON_SKILL) * OFFHAND_SKILL_BONUS
			offhand_defense += offhand.wdefense * OFFHAND_WDEFENSE_BONUS

	if(mainhand_defense >= offhand_defense)
		highest_defense += mainhand_defense
	else
		used_weapon = offhand
		highest_defense += offhand_defense

	var/defender_skill = 0
	var/attacker_skill = 0
	
	var/prob2defend = attacker.defprob
	if(m_intent == MOVE_INTENT_RUN)
		prob2defend -= SPRINT_PENALTY
	
	if(highest_defense <= (mind ? mind.get_skill_level(/datum/skill/combat/unarmed) : NPC_BASE_UNARMED_SKILL) * UNARMED_SKILL_BONUS)
		defender_skill = mind?.get_skill_level(/datum/skill/combat/unarmed)
		prob2defend += defender_skill * UNARMED_SKILL_BONUS
		weapon_parry = FALSE
	else
		defender_skill = mind?.get_skill_level(used_weapon.associated_skill)
		prob2defend += highest_defense
		weapon_parry = TRUE

	if(enemy_intent.masteritem)
		attacker_skill = attacker.mind ? attacker.mind.get_skill_level(enemy_intent.masteritem.associated_skill) : NPC_BASE_WEAPON_SKILL
		prob2defend -= attacker_skill * ATTACKER_WEAPON_SKILL_PENALTY
		if((enemy_intent.masteritem.wbalance > 0) && (attacker.STASPD > STASPD)) //enemy weapon is quick, so get a bonus based on spddiff
			prob2defend -= enemy_intent.masteritem.wbalance * ((attacker.STASPD - STASPD) * ATTACKER_SWIFT_WEAPON_PENALTY)
	else
		attacker_skill = attacker.mind ? attacker.mind.get_skill_level(/datum/skill/combat/unarmed) : NPC_BASE_UNARMED_SKILL
		prob2defend -= attacker_skill * ATTACKER_UNARMED_SKILL_PENALTY

	// parrying while knocked down sucks ass
	if(!(mobility_flags & MOBILITY_STAND))
		prob2defend *= FLOORED_PROB_MULTIPLIER
	prob2defend = clamp(prob2defend, MIN_PARRY_CHANCE, MAX_PARRY_CHANCE)
	if(client?.prefs.showrolls)
		to_chat(src, span_info("Roll to parry... [prob2defend]%"))

	if(prob(prob2defend))
		if(enemy_intent.masteritem && enemy_intent.masteritem.wbalance < 0 && attacker.STASTR > STASTR) //enemy weapon is heavy, so get a bonus scaling on strdiff
			drained += enemy_intent.masteritem.wbalance * ((STASTR - attacker.STASTR) * ATTACKER_HEAVY_WEAPON_STAM_PENALTY)
	else
		to_chat(src, span_warning("The enemy defeated my parry!"))
		return FALSE

	drained = max(drained, MIN_STAMINA_DRAIN)

	if(weapon_parry)
		if(!do_parry(used_weapon, drained, attacker))
			return FALSE // failed to parry

		// defender skill gain
		if((mobility_flags & MOBILITY_STAND) && can_train_combat_skill(src, used_weapon.associated_skill, attacker_skill - SKILL_LEVEL_NOVICE))
			mind.add_sleep_experience(used_weapon.associated_skill, round(STAINT/2), FALSE)

		var/obj/item/attacker_weapon = enemy_intent.masteritem

		//attacker skill gain
		if(attacker.mind)
			var/attacker_skill_type
			if(attacker_weapon)
				attacker_skill_type = attacker_weapon.associated_skill
			else
				attacker_skill_type = /datum/skill/combat/unarmed
			if((attacker.mobility_flags & MOBILITY_STAND) && can_train_combat_skill(attacker, attacker_skill_type, defender_skill - SKILL_LEVEL_NOVICE))
				attacker.mind.add_sleep_experience(attacker_skill_type, round(STAINT/2), FALSE)

		// make sparks fly when metal weapons meet
		if(prob(PARRY_SPARK_CHANCE) && (attacker_weapon?.flags_1 & CONDUCT_1) && (used_weapon.flags_1 & CONDUCT_1))
			flash_fullscreen("whiteflash")
			attacker.flash_fullscreen("whiteflash")
			var/turf/front = get_step(src, dir)
			do_sparks(1, TRUE, front)
		else
			flash_fullscreen("blackflash2")

		var/dam2take = round(get_complex_damage(attacker_weapon,attacker,used_weapon.blade_dulling) * PARRY_DAMAGE_RATIO,1)
		if(dam2take)
			used_weapon.take_damage(dam2take, BRUTE, used_weapon.d_type)
		return TRUE
	else
		if(!do_unarmed_parry(drained, attacker)) // failed the unarmed parry
			testing("failparry")
			return FALSE
		if(mind && (mobility_flags & MOBILITY_STAND) && can_train_combat_skill(src, /datum/skill/combat/unarmed, attacker_skill - SKILL_LEVEL_NOVICE))
			mind.add_sleep_experience(/datum/skill/combat/unarmed, round(STAINT/2), FALSE)
		flash_fullscreen("blackflash2")
		return TRUE

/mob/living/carbon/human/do_parry(obj/item/used_weapon, parrydrain as num, mob/living/user)
	if(!stamina_add(parrydrain))
		to_chat(src, span_warning("I'm too tired to parry!"))
		return FALSE //crush through
	..() // play the sound
	if(istype(rmb_intent, /datum/rmb_intent/riposte))
		visible_message(span_boldwarning("<b>[src]</b> ripostes [user] with [used_weapon]!"))
	else
		visible_message(span_boldwarning("<b>[src]</b> parries [user] with [used_weapon]!"))
	return TRUE

/mob/proc/do_parry(obj/item/used_weapon, parrydrain as num, mob/living/user)
	if(used_weapon)
		playsound(get_turf(src), pick(used_weapon.parrysound), 100, FALSE)
	return TRUE

/mob/proc/do_unarmed_parry(parrydrain as num, mob/living/user)
	playsound(get_turf(src), pick(parry_sound), 100, FALSE)
	return TRUE

/mob/living/carbon/human/do_unarmed_parry(parrydrain as num, mob/living/user)
	if(!stamina_add(parrydrain))
		to_chat(src, span_boldwarning("I'm too tired to parry!"))
		return FALSE
	..() // play the sound
	visible_message(span_warning("<b>[src]</b> parries [user]!"))
	return TRUE

/mob/living/proc/do_dodge(mob/living/user, turf/turfy)
	if(dodgecd)
		return FALSE
	var/obj/item/used_item = user.used_intent.masteritem
	var/prob2defend = user.defprob
	if(stamina >= max_stamina)
		return FALSE
	if(!check_armor_skill() || get_item_by_slot(SLOT_LEGCUFFED))
		Knockdown(1)
		return FALSE
	if(check_dodge_skill())
		prob2defend += STASPD * 14
	else
		prob2defend += STASPD * 10
	if(used_item)
		if(used_item.wbalance > 0 && user.STASPD > STASPD) //enemy weapon is quick, so it's harder to dodge if they're faster
			prob2defend -= used_item.wbalance * ((user.STASPD - STASPD) * 10)
		if(used_item.wbalance < 0 && STASPD > user.STASPD) //enemy weapon is slow, so its easier to dodge if we're faster
			prob2defend += used_item.wbalance * ((STASPD - user.STASPD) * 10)
		if(user.mind)
			prob2defend -= user.mind.get_skill_level(used_item.associated_skill) * 10
	prob2defend -= user.STASPD * 10
	if(used_item) //the enemy attacked us with a weapon
		if(!used_item.associated_skill) //the enemy weapon doesn't have a skill because its improvised, so penalty to attack
			prob2defend += 10
		else if(mind)
			prob2defend += mind.get_skill_level(used_item.associated_skill) * 10
	else if(user.used_intent.unarmed) //the enemy attacked us unarmed
		if(user.mind)
			prob2defend -= user.mind.get_skill_level(/datum/skill/combat/unarmed) * 10
		if(mind)
			prob2defend = prob2defend + mind.get_skill_level(/datum/skill/combat/unarmed) * 10
	// dodging while knocked down sucks ass
	if(!(mobility_flags & MOBILITY_STAND))
		prob2defend *= 0.25
	prob2defend = clamp(prob2defend, 5, 90)
	if(client?.prefs.showrolls)
		to_chat(src, span_info("Roll to dodge... [prob2defend]%"))
	if(!prob(prob2defend))
		return FALSE
	if(!stamina_add(10))
		to_chat(src, span_warning("I'm too tired to dodge!"))
		return FALSE
	dodgecd = TRUE
	playsound(src, 'sound/combat/dodge.ogg', 100, FALSE)
	throw_at(turfy, 1, 2, src, FALSE)
	visible_message(span_warning("<b>[src]</b> dodges [user]'s attack!"))
	dodgecd = FALSE
	return TRUE

/mob/proc/food_tempted(obj/item/W, mob/user)
	return

/mob/proc/taunted(mob/user)
	return

/mob/proc/shood(mob/user)
	return

/mob/proc/beckoned(mob/user)
	return

/mob/proc/get_punch_dmg()
	return


/mob/proc/add_family_hud(antag_hud_type, antag_hud_name)
	var/datum/atom_hud/antag/hud = GLOB.huds[antag_hud_type]
	hud.join_hud(src)
	set_antag_hud(src, antag_hud_name)


/mob/proc/remove_family_hud(antag_hud_type)
	var/datum/atom_hud/antag/hud = GLOB.huds[antag_hud_type]
	hud.leave_hud(src)
	set_antag_hud(src, null)
