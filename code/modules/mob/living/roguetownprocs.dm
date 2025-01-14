/proc/accuracy_check(zone, mob/living/user, mob/living/target, associated_skill, datum/intent/used_intent, obj/item/I)
	var/chance2hit = 0
	if(!zone)
		return triple_accuracy_failure(user, target, src, chance2hit)
	if(user == target)
		return zone
	if(!(target.mobility_flags & MOBILITY_STAND))
		return zone
	if((target.dir == turn(get_dir(target,user), 180)))
		return zone
	if((target.pulledby == user && user.grab_state >= GRAB_PASSIVE) || (user.pulledby == target && target.grab_state >= GRAB_PASSIVE))
		chance2hit += 50
	if(target.grab_state >= GRAB_AGGRESSIVE || user.grab_state >= GRAB_AGGRESSIVE)
		chance2hit += 50


	var/skilled_recovery = 0
	if(user.mind && associated_skill)
		skilled_recovery = user.mind.get_skill_level(associated_skill)

	if(user.mind)
		if(!associated_skill) // This is just for improvised weapons(chairs as weapons, etc. Though imo, using improvised weapons should use Unarmed.)
			chance2hit += 15
		else
			chance2hit += (user.mind.get_skill_level(associated_skill) * 15) // Adjusted the numbers. Base C2H is your skill level x 15. So, it's higher/more impactful the higher your skill.

	if(!user.mind)
		var/chance = 50
		if(prob(chance))
			return zone
		else
			if(prob(chance))
				var/secondary_zone = check_zone(zone)
				return secondary_zone
			else
				if(prob(chance))
					return BODY_ZONE_CHEST
				else
					if(prob(chance))
						return triple_accuracy_failure_npc(user, target)

	var/mob/T = target
	if(T && !T.cmode)
		chance2hit += 200 // Changed to fit with the theme of "minor dodges", if someone isn't in combat mode you always have a 100% chance to hit any zone.

	var/list/acc_zone_penalties = list(
		// Precision Zones (Small/Difficult targets) : These are the targets that are small, mobile or difficult to hit precisely.
		BODY_ZONE_PRECISE_SKULL = -25, // Top of the head
		BODY_ZONE_PRECISE_EARS = -25, // Yeah, ears. Good luck with that in the intensity of combat.
		BODY_ZONE_PRECISE_R_EYE = -35, // Same with eyes, tiny target. Better luck with a Dagger, but with a sword? Come on.
		BODY_ZONE_PRECISE_L_EYE = -35, // See above
		BODY_ZONE_PRECISE_NOSE = -30, // Bigger than the eyes, but there are better ways to go about giving someone a nosejob.
		BODY_ZONE_PRECISE_MOUTH = -30, // Mouths are generally small on the face and used for kissing, not stabbing.
		BODY_ZONE_PRECISE_NECK = -30, // While the neck may seem big, it's quite thin and very hard to hit in a real fight where your opponent isn't a training dummy.
		BODY_ZONE_PRECISE_STOMACH = -10, // Smaller target than the CHEST.
		BODY_ZONE_PRECISE_GROIN = -15, // Larger than a lot of areas but usually not stationary so long as the target has hips and legs.
		BODY_ZONE_PRECISE_L_HAND = -15, // In the middle of combat? The Hands and Feet are fast and /incredibly/ unpredictable, you could land a few solid hits if you're skilled, but they're not a big, easy target at all.
		BODY_ZONE_PRECISE_R_HAND = -15, // See above
		BODY_ZONE_PRECISE_L_FOOT = -20, // See above above
		BODY_ZONE_PRECISE_R_FOOT = -20, // See above above above

		// General Body Zones
		BODY_ZONE_HEAD = -15, // Head is a comparatively large target compared to most of the precision zones, but still mobile.
		BODY_ZONE_CHEST = 0,
		BODY_ZONE_L_ARM = -5, // Larger target but similarly fast and unpredictable like the attached hands and feet.
		BODY_ZONE_R_ARM = -5, // See above
		BODY_ZONE_L_LEG = -10, // See above
		BODY_ZONE_R_LEG = -10 // See above
	)
	// Gone over the numbers again for the current lethality system and to ensure the assumed Skill Level is Journeyman.
	// Combined with the new "Skilled Recovery", being an Expert should FEEL like you're an Expert. At least in comparison to being Journeyman.

	if(zone in acc_zone_penalties)
		chance2hit += acc_zone_penalties[zone]

	// Gives shorter weapons accuracy buffs and larger, more unwieldy weapons an accuracy debuff. Decapitating someone in the middle of combat in one clean swipe is not easy.
	if(I)
		switch(I.wlength)
			if(WLENGTH_SHORT) // Daggers and such, easy to control.
				chance2hit += 10
			if(WLENGTH_NORMAL) // Standard One-Handed Weapons, good control.
				chance2hit += 5
			if(WLENGTH_LONG) // Two-Handed weapons, decent control.
				chance2hit += 0
			if(WLENGTH_GREAT) // Long/Large weapons, harder to control.
				chance2hit -= 5

	// Stabbing is much more precise generally speaking
	// Cutting is less precise but still more precise than blunt weapons
	// When using a blunt weapon, you utilize the inertia of the swing, which makes it harder to redirect your attack on a moving/dodging target
	if(used_intent)
		switch(used_intent.blade_class)
			if(BCLASS_STAB)
				chance2hit += 8 // Stabbing is precise
			if(BCLASS_CUT)
				chance2hit += 4 // Cutting is more precise than a big inertia based swing
			if(BCLASS_BLUNT)
				chance2hit -= 5 // Once again, most of the force with blunt weapons comes from the swing, if your target moves, it's harder to adjust.
								// I might eventually include something like this if I end up making a dodge/parry rework/overhaul for that system.
			if(BCLASS_SMASH)
				chance2hit -= 15 // Smash is just an even more inertia reliant swing. I'm not so sure that this'll even make much of an impact on maces,
								// since the main problem seems to be their balance as opposed to the fact they can hit chest.

	// Reworks the PER bonus that I felt either wasn't particularly impactful or ended up too overscaled with this system.
	if(user.mind)
		chance2hit += (user.STAPER)
	if(istype(user.rmb_intent, /datum/rmb_intent/aimed))
		chance2hit += 15 // Equivalent to one Skill Level's worth of accuracy.
	if(istype(user.rmb_intent, /datum/rmb_intent/swift))
		chance2hit -= 15 // Equivalent to one Skill Level's worth of accuracy.

	// Clamped C2H so we don't get 115% or -50% rolls.
	chance2hit = CLAMP(chance2hit, 5, 95)

	// Important Var, it's the special snowflake that contains the cumulative penalty you'll see below.
	var/cumulative_penalty = 0

	// First roll, we roll to hit and take a penalty from the limb we're trying to target. The penalty is intended to be offset by the character's skills, perception.
	// You'll likely need Aimed Intent if you wanna hit those small spots like the eyes!
	if(prob(chance2hit + cumulative_penalty))
		if(user.mind && user.client && user.client.prefs && user.client.prefs.showrolls)
			// Tasty, tasty feedback
			var/msg_success = "Successful hit! There was a [chance2hit]% chance to hit!"
			to_chat(user, "<span style='color: green;'>[msg_success]</span>")
		return zone
	else
		if(zone == BODY_ZONE_CHEST)
			if(prob(chance2hit + cumulative_penalty))
				return chest_accuracy_failure(user, target, src, chance2hit)
			else
				return triple_accuracy_failure(user, target, src, chance2hit)

		// Alright, "cumulative penalty" is pretty self explanatory, so I'll be quick. When you make an attack on a small zone like the eyes, you get a penalty, in the previous version,
		// You would get basically what amounts to a reroll. So if you target the top of the skull and miss, you get to roll again to hit the head. I thought that's dumb.
		// So now, instead of the version where we skip the head and go straight to the CHEST, you get to reroll the zone but instead you get the penalties from both zones!
		// If you attack the eyes, you get their acc penalty which is -50, your "secondary_zone" penalty will also be added, for the Head, that's -20. So /-70/ if you miss the eyes.  
		cumulative_penalty += (acc_zone_penalties[zone] || 0)

		// First Accuracy Fail Roll
		if(prob(chance2hit + cumulative_penalty + (skilled_recovery * 5)))
			return accuracy_failure(zone, user, target, src, chance2hit)
		else
			cumulative_penalty += (acc_zone_penalties[zone] || 0)
			if(prob(chance2hit + cumulative_penalty + (skilled_recovery * 10)))
				return double_accuracy_failure(user, target, src, chance2hit)
			else
				return triple_accuracy_failure(user, target, src, chance2hit)

/proc/accuracy_failure(zone, mob/living/user, mob/living/target, var/src, var/chance2hit)
	var/secondary_zone = check_zone(zone)

	if(user.mind && user.client && user.client.prefs && user.client.prefs.showrolls)
		// Debugging good.
		var/msg = "Accuracy fail! They dodged but I made a skilled recovery on the first attempt! There was a [chance2hit]% chance to hit!"
		to_chat(user, span_warning(msg))
		playsound(target, 'sound/combat/dodge.ogg', 25)
	else
		var/nodebugmsg = "Damnit! They dodged but I made a skilled recovery on the first attempt!"
		to_chat(user, span_warning(nodebugmsg))
		playsound(target, 'sound/combat/dodge.ogg', 25)
	return secondary_zone

/proc/chest_accuracy_failure(mob/living/user, mob/living/target, var/src, var/chance2hit)

	if(user.mind && user.client && user.client.prefs && user.client.prefs.showrolls)
		// Debugging good.
		var/msg = "Accuracy fail! They dodged but I made a skilled recovery on the first attempt! There was a [chance2hit]% chance to hit!"
		to_chat(user, span_warning(msg))
		playsound(target, 'sound/combat/dodge.ogg', 25)
	else
		var/nodebugmsg = "Damnit! They dodged but I made a skilled recovery on the first attempt!"
		to_chat(user, span_warning(nodebugmsg))
		playsound(target, 'sound/combat/dodge.ogg', 25)
	return BODY_ZONE_CHEST

/proc/double_accuracy_failure(mob/living/user, mob/living/target, var/src, var/chance2hit)

	if(user.mind && user.client && user.client.prefs && user.client.prefs.showrolls)
		var/msg2 = "Double accuracy fail! They dodged but I made a skilled recovery on the second attempt! There was a [chance2hit]% chance to hit!"
		to_chat(user, span_warning(msg2))
		playsound(target, 'sound/combat/dodge.ogg', 50)
	else
		var/nodebugmsg2 = "Damnit! They dodged but I made a skilled recovery on the second attempt!"
		to_chat(user, span_warning(nodebugmsg2))
		playsound(target, 'sound/combat/dodge.ogg', 50)
	return BODY_ZONE_CHEST

/proc/triple_accuracy_failure(mob/living/user, mob/living/target, var/src, var/chance2hit, atom/A)
	if(!user)
		return FALSE

	if(!user.used_intent)
		user.used_intent = new /datum/intent/unarmed
	var/turf/T = get_turf(target)
	var/datum/intent/i = user.used_intent

	if(user.mind && user.client && user.client.prefs && user.client.prefs.showrolls)
		// This is just for seeing how awfully you failed. -70 commonly puts you at 0 for your roll. Maybe aim for something easier to hit, Mr.Novice Swordsmanship...
		triple_accuracy_failure_rolls_on(user, target, i, T, chance2hit)
	else
		triple_accuracy_failure_rolls_off(user, target, i, T, chance2hit)
	return FALSE

/proc/triple_accuracy_failure_rolls_on(mob/living/user, mob/living/target, datum/intent/i, turf/T, var/chance2hit)
	var/msg3 = "Triple Accuracy Fail! Missed with a [chance2hit]% chance to hit!"
	to_chat(user, span_warning(msg3))
	playsound(target, "sound/combat/dodge.ogg", 75)
	user.do_attack_animation(T, i.animname, null, 0)
	if(i.miss_sound)
		playsound(get_turf(user), i.miss_sound, 75, FALSE)
	target.visible_message(span_warning("<b>[target]</b> dodges [user]'s attack!"))
	user.aftermiss()

/proc/triple_accuracy_failure_rolls_off(mob/living/user, mob/living/target, datum/intent/i, turf/T, var/chance2hit)
	var/nodebugmsg3 = "Damnit! They dodged at the last second! I missed!"
	to_chat(user, span_warning(nodebugmsg3))
	playsound(target, "sound/combat/dodge.ogg", 75)
	user.do_attack_animation(target, i.animname, null, 0)
	if(i.miss_sound)
		playsound(get_turf(user), i.miss_sound, 75, FALSE)
	target.visible_message(span_warning("<b>[target]</b> dodges [user]'s attack!"))
	user.aftermiss()

/proc/triple_accuracy_failure_npc(mob/living/user, mob/living/target, datum/intent/i, turf/T, var/chance2hit)
	playsound(target, "sound/combat/dodge.ogg", 75)
	var/anim_effect = (i && i.animname != "" ? i.animname : "strike")
	user.do_attack_animation(target, anim_effect, null, 0)
	if(i && i.miss_sound)
		playsound(get_turf(user), i.miss_sound, 75, FALSE)
	target.visible_message(span_warning("<b>[target]</b> dodges [user]'s attack!"))
	user.aftermiss()


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


/mob/living/proc/checkdefense(datum/intent/intenty, mob/living/user)
	testing("begin defense")
	if(!cmode)
		return FALSE
	if(stat)
		return FALSE
	if(!canparry && !candodge) //mob can do neither of these
		return FALSE
	if(!cmode)
		return FALSE
	if(user == src)
		return FALSE
	if(!(mobility_flags & MOBILITY_MOVE))
		return FALSE

	if(client && used_intent)
		if(client.charging && used_intent.tranged && !used_intent.tshield)
			return FALSE

	var/prob2defend = user.defprob
	var/mob/living/H = src
	var/mob/living/U = user
	if(H && U)
		prob2defend = 0

	if(!can_see_cone(user))
		if(d_intent == INTENT_PARRY)
			return FALSE
		else
			prob2defend = max(prob2defend-15,0)

//	if(!cmode) // not currently used, see cmode check above
//		prob2defend = max(prob2defend-15,0)

	if(m_intent == MOVE_INTENT_RUN)
		prob2defend = max(prob2defend-15,0)

	switch(d_intent)
		if(INTENT_PARRY)
			if(triple_accuracy_failure())
				return FALSE
			if(HAS_TRAIT(src, TRAIT_CHUNKYFINGERS))
				return FALSE
			if(pulledby == user && pulledby.grab_state >= GRAB_AGGRESSIVE)
				return FALSE
			if(pulling == user && grab_state >= GRAB_AGGRESSIVE)
				return FALSE
			if(world.time < last_parry + setparrytime)
				if(!istype(rmb_intent, /datum/rmb_intent/riposte))
					return FALSE
			if(has_status_effect(/datum/status_effect/debuff/feinted))
				return FALSE
			if(has_status_effect(/datum/status_effect/debuff/riposted))
				return FALSE
			last_parry = world.time
			if(intenty && !intenty.canparry)
				return FALSE
			var/drained = user.defdrain
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
				skiller.bucklerskill(H)
			if(istype(mainhand, /obj/item/rogueweapon/shield/buckler))
				skillerbuck.bucklerskill(H)  //buckler code end

			if(mainhand)
				if(mainhand.can_parry)
					mainhand_defense += (H.mind ? (H.mind.get_skill_level(mainhand.associated_skill) * 20) : 20)
					mainhand_defense += (mainhand.wdefense * 10)
			if(offhand)
				if(offhand.can_parry)
					offhand_defense += (H.mind ? (H.mind.get_skill_level(offhand.associated_skill) * 20) : 20)
					offhand_defense += (offhand.wdefense * 10)

			if(mainhand_defense >= offhand_defense)
				highest_defense += mainhand_defense
			else
				used_weapon = offhand
				highest_defense += offhand_defense

			var/defender_skill = 0
			var/attacker_skill = 0

			if(highest_defense <= (H.mind ? (H.mind.get_skill_level(/datum/skill/combat/unarmed) * 20) : 20))
				defender_skill = H.mind?.get_skill_level(/datum/skill/combat/unarmed)
				prob2defend += (defender_skill * 20)
				weapon_parry = FALSE
			else
				defender_skill = H.mind?.get_skill_level(used_weapon.associated_skill)
				prob2defend += highest_defense
				weapon_parry = TRUE

			if(U.mind)
				if(intenty.masteritem)
					attacker_skill = U.mind.get_skill_level(intenty.masteritem.associated_skill)
					prob2defend -= (attacker_skill * 20)
					if((intenty.masteritem.wbalance > 0) && (user.STASPD > src.STASPD)) //enemy weapon is quick, so get a bonus based on spddiff
						prob2defend -= ( intenty.masteritem.wbalance * ((user.STASPD - src.STASPD) * 10) )
				else
					attacker_skill = U.mind.get_skill_level(/datum/skill/combat/unarmed)
					prob2defend -= (attacker_skill * 20)

			// parrying while knocked down sucks ass
			if(!(mobility_flags & MOBILITY_STAND))
				prob2defend *= 0.65
			prob2defend = clamp(prob2defend, 5, 90)
			if(src.client?.prefs.showrolls)
				to_chat(src, span_info("Roll to parry... [prob2defend]%"))

			if(prob(prob2defend))
				if(intenty.masteritem)
					if(intenty.masteritem.wbalance < 0 && user.STASTR > src.STASTR) //enemy weapon is heavy, so get a bonus scaling on strdiff
						drained = drained + ( intenty.masteritem.wbalance * ((user.STASTR - src.STASTR) * -5) )
			else
				to_chat(src, span_warning("The enemy defeated my parry!"))
				return FALSE

			drained = max(drained, 5)

			if(weapon_parry == TRUE)
				if(do_parry(used_weapon, drained, user)) //show message

					if((mobility_flags & MOBILITY_STAND) && can_train_combat_skill(src, used_weapon.associated_skill, attacker_skill - SKILL_LEVEL_NOVICE))
						mind.add_sleep_experience(used_weapon.associated_skill, max(round(STAINT/2), 0), FALSE)

					var/obj/item/AB = intenty.masteritem

					//attacker skill gain

					if(U.mind)
						var/attacker_skill_type
						if(AB)
							attacker_skill_type = AB.associated_skill
						else
							attacker_skill_type = /datum/skill/combat/unarmed
						if((U.mobility_flags & MOBILITY_STAND) && can_train_combat_skill(U, attacker_skill_type, defender_skill - SKILL_LEVEL_NOVICE))
							U.mind.add_sleep_experience(attacker_skill_type, max(round(STAINT/2), 0), FALSE)

					if(prob(66) && AB)
						if((used_weapon.flags_1 & CONDUCT_1) && (AB.flags_1 & CONDUCT_1))
							flash_fullscreen("whiteflash")
							user.flash_fullscreen("whiteflash")
							var/datum/effect_system/spark_spread/S = new()
							var/turf/front = get_step(src,src.dir)
							S.set_up(1, 1, front)
							S.start()
						else
							flash_fullscreen("blackflash2")
					else
						flash_fullscreen("blackflash2")

					var/dam2take = round((get_complex_damage(AB,user,used_weapon.blade_dulling)/2),1)
					if(dam2take)
						used_weapon.take_damage(max(dam2take,1), BRUTE, used_weapon.d_type)
					return TRUE
				else
					return FALSE

			if(weapon_parry == FALSE)
				if(do_unarmed_parry(drained, user))
					if((mobility_flags & MOBILITY_STAND) && can_train_combat_skill(H, /datum/skill/combat/unarmed, attacker_skill - SKILL_LEVEL_NOVICE))
						H.mind?.add_sleep_experience(/datum/skill/combat/unarmed, max(round(STAINT/2), 0), FALSE)
					flash_fullscreen("blackflash2")
					return TRUE
				else
					testing("failparry")
					return FALSE
		if(INTENT_DODGE)
			if(triple_accuracy_failure())
				return FALSE
			if(pulledby && pulledby.grab_state >= GRAB_AGGRESSIVE)
				return FALSE
			if(pulling == user)
				return FALSE
			if(world.time < last_dodge + dodgetime)
				if(!istype(rmb_intent, /datum/rmb_intent/riposte))
					return FALSE
			if(has_status_effect(/datum/status_effect/debuff/riposted))
				return FALSE
			last_dodge = world.time
			if(src.loc == user.loc)
				return FALSE
			if(intenty)
				if(!intenty.candodge)
					return FALSE
			if(candodge)
				var/list/dirry = list()
				var/dx = x - user.x
				var/dy = y - user.y
				if(abs(dx) < abs(dy))
					if(dy > 0)
						dirry += NORTH
						dirry += WEST
						dirry += EAST
					else
						dirry += SOUTH
						dirry += WEST
						dirry += EAST
				else
					if(dx > 0)
						dirry += EAST
						dirry += SOUTH
						dirry += NORTH
					else
						dirry += WEST
						dirry += NORTH
						dirry += SOUTH
				var/turf/turfy
				for(var/x in shuffle(dirry.Copy()))
					turfy = get_step(src,x)
					if(turfy)
						if(turfy.density)
							continue
						for(var/atom/movable/AM in turfy)
							if(AM.density)
								continue
						break
				if(pulledby)
					return FALSE
				if(!turfy)
					to_chat(src, span_boldwarning("There's nowhere to dodge to!"))
					return FALSE
				else
					if(do_dodge(user, turfy))
						flash_fullscreen("blackflash2")
						user.aftermiss()
						return TRUE
					else
						return FALSE
			else
				return FALSE

/mob/proc/do_parry(obj/item/W, parrydrain as num, mob/living/user)
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.rogfat_add(parrydrain))
			if(W)
				playsound(get_turf(src), pick(W.parrysound), 100, FALSE)
			if(istype(rmb_intent, /datum/rmb_intent/riposte))
				src.visible_message(span_boldwarning("<b>[src]</b> ripostes [user] with [W]!"))
			else
				src.visible_message(span_boldwarning("<b>[src]</b> parries [user] with [W]!"))
			return TRUE
		else
			to_chat(src, span_warning("I'm too tired to parry!"))
			return FALSE //crush through
	else
		if(W)
			playsound(get_turf(src), pick(W.parrysound), 100, FALSE)
		return TRUE

/mob/proc/do_unarmed_parry(parrydrain as num, mob/living/user)
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.rogfat_add(parrydrain))
			playsound(get_turf(src), pick(parry_sound), 100, FALSE)
			src.visible_message(span_warning("<b>[src]</b> parries [user]!"))
			return TRUE
		else
			to_chat(src, span_boldwarning("I'm too tired to parry!"))
			return FALSE
	else
		playsound(get_turf(src), pick(parry_sound), 100, FALSE)
		return TRUE


/mob/proc/do_dodge(mob/user, turf/turfy)
	if(dodgecd)
		return FALSE
	var/mob/living/L = src
	var/mob/living/U = user
	var/mob/living/carbon/human/H
	var/mob/living/carbon/human/UH
	var/obj/item/I
	var/drained = 10
	if(ishuman(src))
		H = src
	if(ishuman(user))
		UH = user
		I = UH.used_intent.masteritem
	var/prob2defend = U.defprob
	if(L.rogfat >= L.maxrogfat)
		return FALSE
	if(L)
		if(H?.check_dodge_skill())
			prob2defend = prob2defend + (L.STASPD * 14)
		else
			prob2defend = prob2defend + (L.STASPD * 10)
	if(U)
		prob2defend = prob2defend - (U.STASPD * 10)
	if(I)
		if(I.wbalance > 0 && U.STASPD > L.STASPD) //nme weapon is quick, so they get a bonus based on spddiff
			prob2defend = prob2defend - ( I.wbalance * ((U.STASPD - L.STASPD) * 10) )
		if(I.wbalance < 0 && L.STASPD > U.STASPD) //nme weapon is slow, so its easier to dodge if we're faster
			prob2defend = prob2defend + ( I.wbalance * ((U.STASPD - L.STASPD) * -10) )
		if(UH?.mind)
			prob2defend = prob2defend - (UH.mind.get_skill_level(I.associated_skill) * 10)
	if(H)
		if(!H?.check_armor_skill() || H?.legcuffed)
			H.Knockdown(1)
			return FALSE
		/* Commented out due to gaping imbalance
			if(H?.check_dodge_skill())
				drained = drained - 5  commented out for being too much. It was giving effectively double stamina efficiency compared to everyone else.
			if(H.mind)
				drained = drained + max((H.checkwornweight() * 10)-(mind.get_skill_level(/datum/skill/misc/athletics) * 10),0)
			else
				drained = drained + (H.checkwornweight() * 10)
		*/
		if(I) //the enemy attacked us with a weapon
			if(!I.associated_skill) //the enemy weapon doesn't have a skill because its improvised, so penalty to attack
				prob2defend = prob2defend + 10
			else
				if(H.mind)
					prob2defend = prob2defend + (H.mind.get_skill_level(I.associated_skill) * 10)
				/* Commented out due to encumbrance being seemingly broken and nonfunctional
				var/thing = H.encumbrance
				if(thing > 0)
					drained = drained + (thing * 10)
				*/
		else //the enemy attacked us unarmed or is nonhuman
			if(UH)
				if(UH.used_intent.unarmed)
					if(UH.mind)
						prob2defend = prob2defend - (UH.mind.get_skill_level(/datum/skill/combat/unarmed) * 10)
					if(H.mind)
						prob2defend = prob2defend + (H.mind.get_skill_level(/datum/skill/combat/unarmed) * 10)
		// dodging while knocked down sucks ass
		if(!(L.mobility_flags & MOBILITY_STAND))
			prob2defend *= 0.25
		prob2defend = clamp(prob2defend, 5, 90)
		if(client?.prefs.showrolls)
			to_chat(src, span_info("Roll to dodge... [prob2defend]%"))
		if(!prob(prob2defend))
			return FALSE
		if(!H.rogfat_add(max(drained,5)))
			to_chat(src, span_warning("I'm too tired to dodge!"))
			return FALSE
	else //we are a non human
		prob2defend = clamp(prob2defend, 5, 90)
		if(client?.prefs.showrolls)
			to_chat(src, span_info("Roll to dodge... [prob2defend]%"))
		if(!prob(prob2defend))
			return FALSE
	dodgecd = TRUE
	playsound(src, 'sound/combat/dodge.ogg', 100, FALSE)
	throw_at(turfy, 1, 2, src, FALSE)
	if(drained > 0)
		src.visible_message(span_warning("<b>[src]</b> dodges [user]'s attack!"))
	else
		src.visible_message(span_warning("<b>[src]</b> easily dodges [user]'s attack!"))
	dodgecd = FALSE
//		if(H)
//			if(H.IsOffBalanced())
//				H.Knockdown(1)
//				to_chat(H, span_danger("I tried to dodge off-balance!"))
//		if(isturf(loc))
//			var/turf/T = loc
//			if(T.landsound)
//				playsound(T, T.landsound, 100, FALSE)
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
