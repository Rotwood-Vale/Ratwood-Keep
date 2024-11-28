/proc/accuracy_check(zone, mob/living/user, mob/living/target, obj/item/I, associated_skill, datum/intent/used_intent)
	var/hit = "Hit"
	used_intent = user.used_intent
	if(!zone)
		zone = user.zone_selected									//Double enforcing the target body part, just in case
		if(!zone)
			zone = zone_simpmob_target(zone)						//Else, have a random body part selected
	if(user == target)
		return list(zone, hit)
	if(zone == BODY_ZONE_CHEST)										//Targeting the chest always hits
		return list(zone, hit)
	if(used_intent.type == INTENT_GRAB)
		if(!(target.mobility_flags & MOBILITY_STAND))				//If they're grounded, you can just grab them
			return list(zone, hit)
		if(user.grab_state <= GRAB_AGGRESSIVE)
			return list(zone, hit)

	var/ace_mod = zone_ace_mod(zone)								//Sub-location hit modifier
	var/chance2hit = 0
	var/chance2acehit = 0
	var/facing = relative_angular_facing(user, target)				//Which side of the target you are attacking

	if(user.mind)													//15 points per skill level, 95 bonus at Legendary
		chance2hit += (user.mind.get_skill_level(associated_skill) * 15)

	if(target.grabbedby == user)									//If you are grabbing or being grabbed, there is a To-Hit bonus
		if(used_intent.reach == 1)
			chance2hit += 30
	if(user.grabbedby == target)
		if(used_intent.reach == 1)
			chance2hit += 30

	if(!get_dist(user, target))
		chance2hit += 50

	if(user.simpmob_attack >= 1)									//To compensate for NPCs lack of skills
		chance2hit += (user.simpmob_attack)							//Not to be confused with actual SimpleAnimals, which use their own variant of accuracy

	if(user.domhand != user.active_hand_index)						//Attacking with your offhand will penalize your To-Hit
		chance2hit -= 25

	if(used_intent)
		if(used_intent.blade_class == BCLASS_STAB)					//Thrusting attacks are the most accurate
			chance2hit += round(user.STAPER * 1.5)
		else if(used_intent.blade_class == BCLASS_CUT)				//Slashing is still semi-aimed
			chance2hit += user.STAPER
		else if(used_intent.blade_class == BCLASS_PUNCH)			//It is easiest to aim your fists
			chance2hit += (30 + user.STAPER)
		else if(used_intent == INTENT_GRAB)
			chance2hit += (30 + user.STAPER)
		else if(used_intent == INTENT_KICK)
			chance2hit += (20 + user.STAPER)
		else if(used_intent == INTENT_BITE)
			chance2hit += (20 + user.STAPER)
		else if(used_intent.reach >= 2)								//Using a polearm's reach attack at close range reduces the To-Hit chance
			if(get_dist(user, target) <= 1)
				chance2hit -= 35
	
	if(!(target.mobility_flags & MOBILITY_STAND))					//If they're grounded, you get a bonus to your To-Hit
		chance2hit += 40

	if(I)
		var/strmod = (user.STASTR - I.minstr)
		if(I.wlength == WLENGTH_SHORT)								//Small weapons like daggers are easier to aim
			chance2hit += 25
		if(I.wbalance > 0)
			chance2hit += user.STASPD
		if(I.minstr > 0)											//Using a weapon while below minimum strength requirement will penalize your To-Hit
			if(strmod <= 0)
				chance2hit += (strmod * 2) 
		if(I.wielded)												//Two Handing a weapon will add part of your Strength score to your To-Hit
			chance2hit += (user.STASTR * 1.5)
		chance2hit += (user.STAPER / 2)								//Using weapons gives you half your Perception as a To-Hit bonus

	if(user.mob_size != target.mob_size)							//Size modifier. Easier to hit bigger enemies, harder to hit smaller enemies.
		chance2hit += ((target.mob_size - user.mob_size) * 10)

	if(istype(user.rmb_intent, /datum/rmb_intent/aimed))			//Taking time to aim attacks gives Perception + 10
		chance2hit += (user.STAPER + 10)
	if(istype(user.rmb_intent, /datum/rmb_intent/swift))			//Swinging as fast as you can reduces your To-Hit
		chance2hit -= (35 - user.STASPD)

																	//Being cracked out on hyper cocaine doesn't mean you're going to be accurate
	if(user.has_status_effect(/datum/status_effect/buff/moondust) || user.has_status_effect(/datum/status_effect/buff/moondust_purest))
		chance2hit *= 0.4
	if(user.has_status_effect(/datum/status_effect/debuff/moondust_crash))
		chance2hit *= 0.8

	var/facing_zone = facing_zone(zone)
	if(facing == NORTH)												//Attacks from the front, normal
	else if(facing == NORTHEAST) 									//Attacks from the fore-right
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = (ace_mod / 1.5)
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 1.5)
		if(facing_zone == BODY_ZONE_FACING_L_ARM)
			zone = BODY_ZONE_CHEST
		if(facing_zone == BODY_ZONE_FACING_L_LEG)
			chance2hit = (chance2hit / 2)
	else if(facing == EAST)											//Attacks from the right
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = (ace_mod / 2)										//Side attacks halve To-Hit to the face
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 2)										//Side attacks double To-Hit to the ears
		if(facing_zone == BODY_ZONE_FACING_L_ARM)
			zone = BODY_ZONE_R_ARM										//Targeting the far arm or leg will hit the near arm or leg instead
		if(facing_zone == BODY_ZONE_FACING_L_LEG)
			zone = BODY_ZONE_R_LEG
	else if(facing == SOUTHEAST)									//Attacks from the aft-right
		if(facing_zone == BODY_ZONE_FACING_FRONT)						//The face can not be attacked from behind
			ace_mod = 0
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 1.5)
		if(facing_zone == BODY_ZONE_FACING_L_ARM)
			zone = BODY_ZONE_CHEST
		if(facing_zone == BODY_ZONE_FACING_L_LEG)
			chance2hit = (chance2hit / 2)
	else if(facing == SOUTH)										//Attacks from the rear
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = (ace_mod * 0)
	else if(facing == SOUTHWEST)									//Attacks from the aft-left
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = 0
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 1.5)
		if(facing_zone == BODY_ZONE_FACING_R_ARM)
			zone = BODY_ZONE_CHEST
		if(facing_zone == BODY_ZONE_FACING_R_LEG)
			chance2hit = (chance2hit / 2)
	else if(facing == WEST)											//Attacks from the left
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = (ace_mod / 2)
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 2)
		if(facing_zone == BODY_ZONE_FACING_R_ARM)
			zone = BODY_ZONE_L_ARM
		if(facing_zone == BODY_ZONE_FACING_R_LEG)
			zone = BODY_ZONE_L_LEG
	else if(facing == NORTHWEST)									//Attacks from the fore-left
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = (ace_mod / 1.5)
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 1.5)
		if(facing_zone == BODY_ZONE_FACING_R_ARM)
			zone = BODY_ZONE_CHEST
		if(facing_zone == BODY_ZONE_FACING_R_LEG)
			chance2hit = (chance2hit / 2)
	
	if(zone == BODY_ZONE_HEAD)										//Head is the smallest of the Major Body Zones
		chance2hit *= 0.8

	chance2acehit = CLAMP((round(chance2hit * ace_mod)), 0, 100) 	//Ability to hit sub-locations
	chance2hit = CLAMP((round(chance2hit)), 0, 100) 				//Ability to hit the target
	var/tohit = rand(1,100)
	if(tohit <= chance2acehit)
		if(user.client?.prefs.showrolls)
			var/subzone = check_subzone(zone)
			if(subzone)
				to_chat(user, span_greentext("Good Hit!!"))
			if(GLOB.Debug2)
				if(!subzone)
					to_chat(user, span_nicegreen("Hit!"))
				to_chat(user, span_smallgreen("Roll under [chance2acehit] to Ace Hit: [tohit]"))
				to_chat(target, span_smallred("They rolled [tohit] against [chance2acehit]%"))
		hit = "Hit"
		return list(zone, hit)
	else
		if(tohit <= chance2hit)
			if(user.client?.prefs.showrolls && GLOB.Debug2)
				to_chat(user, span_nicegreen("Hit!"))
				to_chat(user, span_smallgreen("Roll under [chance2hit] to Hit: [tohit]"))
				to_chat(target, span_smallred("They rolled [tohit] against [chance2hit]%"))
			hit = "Hit"
			zone = check_zone(zone)
			return list(zone, hit)
		else
			if(user.client?.prefs.showrolls)
				to_chat(user, span_warning("I Missed!"))
				if(GLOB.Debug2)
					to_chat(user, span_smallgreen("Roll under [chance2hit] to Hit: [tohit]"))
					to_chat(target, span_smallred("They rolled [tohit] against [chance2hit]%"))
			user.aftermiss()
			hit = "Miss"
			zone = check_zone(zone)
			return list(zone, hit)

/proc/simple_accuracy_check(zone, mob/living/simple_animal/user, mob/living/target, datum/intent/used_intent)
	var/hit = "Hit"
	used_intent = user.used_intent
	if(!zone)
		return
	if(user == target)
		return list(zone, hit)
	if(zone == BODY_ZONE_CHEST)
		return list(zone, hit)

	var/ace_mod = zone_ace_mod(zone)
	var/chance2hit = (user.simpmob_attack)
	var/chance2acehit = 0

	chance2hit += (user.STAPER + (user.STASTR / 2))

	if(user.grabbedby == target)									//To-Hit penalty if you are being grabbed while shooting
		chance2hit -= 20

	if(user.mob_size != target.mob_size)							//Size modifier. Easier to hit bigger enemies, harder to hit smaller enemies.
		chance2hit += ((target.mob_size - user.mob_size) * 10)

	if(!(target.mobility_flags & MOBILITY_STAND))					//If they're grounded, you get a bonus to your To-Hit
		chance2hit += 40

	chance2acehit = CLAMP((round(chance2hit * ace_mod)), 0, 100)	//Ability to hit sub-locations
	chance2hit = CLAMP((round(chance2hit)), 0, 100)					//Ability to hit the target
	var/tohit = rand(1,100)
	if(tohit <= chance2acehit)
		if(GLOB.Debug2)
			to_chat(target,span_danger("[user] cleanly hit me!! ") + span_warning("Rolled [tohit] against [chance2acehit]%"))
		hit = "Hit"
		return list(zone, hit)
	else
		if(tohit <= chance2hit)
			if(GLOB.Debug2)
				to_chat(target, span_smallred("[user] hit me! ") + span_warning("Rolled [tohit] against [chance2hit]%"))
			hit = "Hit"
			zone = check_zone(zone)
			return list(zone, hit)
		else
			target.visible_message(span_warning("[user] missed!"))
			if(GLOB.Debug2)
				to_chat(target, span_warning("Rolled [tohit] against [chance2hit]%"))
			playsound(get_turf(user), pick(user.attack_sound), 100, FALSE)
			playsound(get_turf(user), pick(used_intent.miss_sound), 100, FALSE)
			hit = "Miss"
			zone = check_zone(zone)
			return list(zone, hit)

/proc/projectile_accuracy_check(zone, obj/projectile/P, mob/living/target)
	var/mob/living/user = P.firer
	var/associated_skill
	if(P.fired_from)												//Checking if the projectile is from a weapon
		if(ispath(/obj/item))
			var/obj/item/I = P.fired_from
			associated_skill = I.associated_skill
	if(user.ranged_ability && !P.fired_from)						//Checking if the projectile is from a spell and NOT a weapon
		if(ispath(/obj/effect/proc_holder/spell))
			var/obj/effect/proc_holder/spell/invoked/projectile/S = user.ranged_ability
			associated_skill = S.associated_skill
	var/hit = "Hit"
	if(!zone)
		zone = user.zone_selected									//Double enforcing the target body part (for spells)
		if(!zone)
			zone = zone_simpmob_target(zone)						//Else, have a random body part selected
	if(user == target)
		return list(zone, hit)

	var/ace_mod = zone_ace_mod(zone)								//Sub-location hit modifier
	var/chance2hit = ((user.STAPER * 2) + user.STASPD + 15)
	var/chance2acehit = 0
	var/datum/point/vector/previous = P.trajectory.return_vector_after_increments(1,-1)		//Backstepping the projectile to better account for angular attack vectors
	var/projlast = previous.return_turf()
	var/facing = relative_angular_facing(projlast, target)			//Which side of the target you are attacking
	var/dist = abs(P.range - P.decayedRange)

	if(P.ricochets >= 1)											//In the event of a ricochet hit
		var/luck = (rand(1, 20) + (user.STALUC))					//Opposed 1d20+Luck rolls
		var/luckcheck = (rand(1, 20) + (target.STALUC))
		if(luck < luckcheck)
			hit = "Hit"
			zone = zone_simpmob_target(zone)						//Random body part hit by ricochet strikes
			return list(zone, hit)
		else
			hit = "Miss"
			zone = check_zone(zone)
			return list(zone, hit)

	if(user.mind)													//12 points per skill level, 72 bonus at Legendary
		chance2hit += (user.mind.get_skill_level(associated_skill) * 12)

	if(user.mob_size != target.mob_size)							//Size modifier. Easier to hit bigger enemies, harder to hit smaller enemies.
		chance2hit += ((target.mob_size - user.mob_size) * 10)

	if(user.active_hand_index)
		if(associated_skill == /datum/skill/combat/bows)
			if(user.domhand == user.active_hand_index)				//Bows go in your offhand, primehand for drawing and aiming
				chance2hit -= 25
		else if(user.domhand != user.active_hand_index)				//Attacking with your offhand will penalize your To-Hit
			chance2hit -= 25

	if(!(target.mobility_flags & MOBILITY_STAND))					//If they're grounded nearby, you get a bonus to your To-Hit
		chance2hit += (30 - (dist * 10))								//Bonus inversely scales by distance, neutral at 4 tiles distance and negative beyond

	if(user.grabbedby())											//Attack penalty if you are being grabbed
		chance2hit -= (60 - (user.STASTR * 3))

	if(istype(user.used_intent, /datum/intent/arc))
		dist *= 1.5
	
	chance2hit -= (dist * (6 - ((user.mind.get_skill_level(associated_skill)) * 1)))

	var/facing_zone = facing_zone(zone)
	if(facing == NORTH)												//Attacks from the front, normal
	else if(facing == NORTHEAST) 									//Attacks from the fore-right
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = (ace_mod / 1.5)
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 1.5)
		if(facing_zone == BODY_ZONE_FACING_L_ARM)
			zone = BODY_ZONE_CHEST
		if(facing_zone == BODY_ZONE_FACING_L_LEG)
			chance2hit = (chance2hit / 2)
	else if(facing == EAST)											//Attacks from the right
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = (ace_mod / 2)										//Side attacks halve To-Hit to the face
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 2)										//Side attacks double To-Hit to the ears
		if(facing_zone == BODY_ZONE_FACING_L_ARM)
			zone = BODY_ZONE_R_ARM										//Targeting the far arm or leg will hit the near arm or leg instead
		if(facing_zone == BODY_ZONE_FACING_L_LEG)
			zone = BODY_ZONE_R_LEG
	else if(facing == SOUTHEAST)									//Attacks from the aft-right
		if(facing_zone == BODY_ZONE_FACING_FRONT)						//The face can not be attacked from behind
			ace_mod = 0
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 1.5)
		if(facing_zone == BODY_ZONE_FACING_L_ARM)
			zone = BODY_ZONE_CHEST
		if(facing_zone == BODY_ZONE_FACING_L_LEG)
			chance2hit = (chance2hit / 2)
	else if(facing == SOUTH)										//Attacks from the rear
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = (ace_mod * 0)
	else if(facing == SOUTHWEST)									//Attacks from the aft-left
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = 0
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 1.5)
		if(facing_zone == BODY_ZONE_FACING_R_ARM)
			zone = BODY_ZONE_CHEST
		if(facing_zone == BODY_ZONE_FACING_R_LEG)
			chance2hit = (chance2hit / 2)
	else if(facing == WEST)											//Attacks from the left
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = (ace_mod / 2)
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 2)
		if(facing_zone == BODY_ZONE_FACING_R_ARM)
			zone = BODY_ZONE_L_ARM
		if(facing_zone == BODY_ZONE_FACING_R_LEG)
			zone = BODY_ZONE_L_LEG
	else if(facing == NORTHWEST)									//Attacks from the fore-left
		if(facing_zone == BODY_ZONE_FACING_FRONT)
			ace_mod = (ace_mod / 1.5)
		if(zone == BODY_ZONE_PRECISE_EARS)
			ace_mod = (ace_mod * 1.5)
		if(facing_zone == BODY_ZONE_FACING_R_ARM)
			zone = BODY_ZONE_CHEST
		if(facing_zone == BODY_ZONE_FACING_R_LEG)
			chance2hit = (chance2hit / 2)

	if(zone == BODY_ZONE_CHEST)
		chance2hit *= 2

	chance2acehit = CLAMP((round(chance2hit * ace_mod)), 0, 100)		//Ability to hit sub-locations
	chance2hit = CLAMP((round(chance2hit)), 0, 100)						//Ability to hit the target
	var/scatterhit = CLAMP((round(chance2hit * 1.5)), 0, 100)			//Chance to hit a random part on a miss
	var/tohit = rand(1,100)
	if(tohit <= chance2acehit)
		if(user.client?.prefs.showrolls)
			var/subzone = check_subzone(zone)
			if(subzone)
				to_chat(user, span_greentext("Good Hit!!"))
			if(GLOB.Debug2)
				if(!subzone)
					to_chat(user, span_nicegreen("Hit!"))
				to_chat(user, span_smallgreen("Roll under [chance2acehit] to Ace Hit... [tohit]"))
		hit = "Hit"
		return list(zone, hit)
	else
		if(tohit <= chance2hit)
			if(user.client?.prefs.showrolls && GLOB.Debug2)
				to_chat(user, span_nicegreen("Hit!"))
				to_chat(user, span_smallgreen("Roll under [chance2hit] to Hit... [tohit]"))
			hit = "Hit"
			zone = check_zone(zone)
			return list(zone, hit)
		else
			if(tohit <= scatterhit)
				if(user.client?.prefs.showrolls)
					to_chat(user, span_smallgreen("I managed to hit them."))
					if(GLOB.Debug2)
						to_chat(user, span_smallgreen("Roll under [scatterhit] to Scatter: [tohit]"))
				hit = "Hit"
				zone = zone_simpmob_target(zone)
				return list(zone, hit)
			else
				if(user.client?.prefs.showrolls)
					to_chat(user, span_warning("Missed!!"))
					if(GLOB.Debug2)
						to_chat(user, span_smallgreen("Roll under [chance2hit] to Hit: [tohit]"))
				hit = "Miss"
				zone = check_zone(zone)
				return list(zone, hit)

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
	if(!cmode)																	//Combat Mode must be enabled
		return FALSE
	if(stat)																	//Defender must be consious
		return FALSE
	if(!canparry && !candodge)													//mob can do neither of these
		return FALSE
	if(user == src)																//Ignore defense when targeting self
		return FALSE
	if(!can_see_cone(user))														//You can not defend against what you can not see
		return FALSE
	if(client && used_intent)
		if(client.charging && used_intent.tranged && !used_intent.tshield)		//Defender can not defend while charging an ability without a shield
			return FALSE

	var/mob/living/D = src												//The Defender
	var/mob/living/A = user												//The Attacker
	var/defense_score = simpmob_defend											//Base score and offset for NPC mobs

	switch(d_intent)
		if(INTENT_PARRY)												//// PARRYING ////
			if(HAS_TRAIT(src, TRAIT_CHUNKYFINGERS))
				return FALSE
			if(pulledby == A && pulledby.grab_state >= GRAB_AGGRESSIVE)		//You can not parry the person who is grabbing you
				return FALSE
			if(pulling == A && grab_state >= GRAB_AGGRESSIVE)				//Nor if you are grabbing them
				return FALSE
			if(world.time < next_parry)
				if(!istype(rmb_intent, /datum/rmb_intent/riposte))				//Defense Stance allows you to quickly re-parry
					return FALSE
			if(has_status_effect(/datum/status_effect/debuff/feinted))			//You can not parry an attack that feinted you
				return FALSE
			if(has_status_effect(/datum/status_effect/debuff/riposted))			//You can not parry a counter attack to your own parried attack
				return FALSE
			if(intenty && !intenty.canparry)									//You have to be able to parry to parry
				return FALSE

			defense_score += ((STAINT + STAPER) * 2)							//Base parry ability is based on seeing and predicting the enemy's attack

			defense_score -= ((A.STASTR - D.STASTR) * 5)						//Contested Strength check

			if(m_intent == MOVE_INTENT_RUN)										//Defender receives a penalty to parry while sprinting, scaled by Speed stat
				defense_score -= (5 * (20 - STASPD))

			defense_score += (D.rmb_intent.def_bonus)							//Any defense bonus from poise

			var/drained = D.defdrain
			var/weapon_parry = FALSE
			var/offhand_defense = 0
			var/mainhand_defense = 0
			var/obj/item/mainhand = get_active_held_item()
			var/obj/item/offhand = get_inactive_held_item()
			var/obj/item/used_weapon = mainhand
			var/obj/item/rogueweapon/shield/buckler/skiller = get_inactive_held_item()  // buckler code
			var/obj/item/rogueweapon/shield/buckler/skillerbuck = get_active_held_item()
			var/defender_skill = 0
			var/attacker_skill = 0

			if(istype(offhand, /obj/item/rogueweapon/shield/buckler))
				skiller.bucklerskill(D)
			if(istype(mainhand, /obj/item/rogueweapon/shield/buckler))
				skillerbuck.bucklerskill(D)  //buckler code end

			if(mainhand)														//Check any item in active hand for skills
				if(mainhand.can_parry)
					mainhand_defense += (D.mind ? (D.mind.get_skill_level(mainhand.associated_skill) * 15) : 0)
					mainhand_defense += mainhand.wdefense
					mainhand_defense += mainhand.wparrybonus
					mainhand_defense += D.used_intent.iparrybonus		//Attack intent based parry bonus

			if(offhand)															//Check any item in other hand for skills
				if(offhand.can_parry)
					offhand_defense += (D.mind ? (D.mind.get_skill_level(offhand.associated_skill) * 15) : 0)
					offhand_defense += offhand.wdefense
					offhand_defense += offhand.wparrybonus
					offhand_defense += D.used_intent.iparrybonus			//Attack intent based parry bonus
			if(mainhand_defense < offhand_defense)
				used_weapon = offhand

			defense_score += (mainhand_defense + (offhand_defense * 0.5))

																				//Checking Defense Score to determine if Unarmed Combat
			if(defense_score <= (D.mind ? (D.mind.get_skill_level(/datum/skill/combat/unarmed) * 15) : 0))
				defender_skill = D.mind?.get_skill_level(/datum/skill/combat/unarmed)
				defense_score += (defender_skill * 10)
				weapon_parry = FALSE
			else
				defender_skill += D?.mind?.get_skill_level(used_weapon?.associated_skill)
				weapon_parry = TRUE

			if(A.mind)															//Attacker's combat ability applying penalties
				if(intenty.masteritem)
					attacker_skill = A.mind.get_skill_level(intenty.masteritem.associated_skill)
					defense_score -= (attacker_skill * 10)
					if((intenty.masteritem.wbalance > 0) && (A.STASPD > D.STASPD))	//Attacker has a swift weapon, giving a penalty to parry
						defense_score -= (intenty.masteritem.wbalance * ((A.STASPD - D.STASPD) * 5))
				else
					defense_score = (A.mind.get_skill_level(/datum/skill/combat/unarmed) * 15)

			defense_score -= (A.simpmob_attack * 0.5)							//NPC mob combat ability bonus

			if(!(mobility_flags & MOBILITY_STAND))								//Disadvantage while parrying from the ground
				defense_score = (defense_score * 0.65)

			defense_score = clamp(defense_score, 0, 95)

			drained = max(drained + (A.STASTR - D.STASTR), 5)					//If the Defender has lower Strength, it drains more energy to parry

			if(used_weapon)
				next_parry = ((world.time + setparrytime) - used_weapon.wparryspeed) //Faster weapons can re-parry sooner
			else
				next_parry = ((world.time + setparrytime) - round(D.STASPD*0.5))	//If Unarmed

			var/parryroll = rand(1, 100)
			if(D.client?.prefs.showrolls && GLOB.Debug2)
				to_chat(D, span_info("Under [defense_score] to parry... [parryroll]"))
			if(parryroll > defense_score)										//Rolling above the defense score fails
				to_chat(D, span_warning("The enemy defeated my parry!"))
				return FALSE

			if(weapon_parry == TRUE)
				if(do_parry(used_weapon, drained, A)) //show message

					if((mobility_flags & MOBILITY_STAND) && can_train_combat_skill(D, used_weapon.associated_skill, attacker_skill - SKILL_LEVEL_NOVICE))
						mind.add_sleep_experience(used_weapon.associated_skill, max(round(STAINT / 2), 0), FALSE)

					var/obj/item/AB = intenty.masteritem

					//attacker skill gain

					if(A.mind)
						var/attacker_skill_type
						if(AB)
							attacker_skill_type = AB.associated_skill
						else
							attacker_skill_type = /datum/skill/combat/unarmed
						if((A.mobility_flags & MOBILITY_STAND) && can_train_combat_skill(A, attacker_skill_type, defender_skill - SKILL_LEVEL_NOVICE))
							A.mind.add_sleep_experience(attacker_skill_type, max(round(STAINT / 2), 0), FALSE)

					if(prob(66) && AB)
						if((used_weapon.flags_1 & CONDUCT_1) && (AB.flags_1 & CONDUCT_1))
							flash_fullscreen("whiteflash")
							A.flash_fullscreen("whiteflash")
							var/datum/effect_system/spark_spread/S = new()
							var/turf/front = get_step(D, D.dir)
							S.set_up(1, 1, front)
							S.start()
						else
							flash_fullscreen("blackflash2")
					else
						flash_fullscreen("blackflash2")

					var/dam2take = round((get_complex_damage(AB, A, used_weapon.blade_dulling) / 2), 1)
					if(dam2take)
						used_weapon.take_damage(max(dam2take, 1), BRUTE, used_weapon.d_type)
					return TRUE
				else
					return FALSE

			if(weapon_parry == FALSE)
				if(do_unarmed_parry(drained, A))
					if((mobility_flags & MOBILITY_STAND) && can_train_combat_skill(D, /datum/skill/combat/unarmed, attacker_skill - SKILL_LEVEL_NOVICE))
						D.mind?.add_sleep_experience(/datum/skill/combat/unarmed, max(round(STAINT/2), 0), FALSE)
					flash_fullscreen("blackflash2")
					return TRUE
				else
					testing("failparry")
					return FALSE
																		//// DODGING ////
		if(INTENT_DODGE)
			if(!(mobility_flags & MOBILITY_MOVE))								//Defender can not dodge if they are immobile
				return FALSE
			if(pulledby && pulledby.grab_state >= GRAB_AGGRESSIVE)
				return FALSE
			if(pulling == A)
				return FALSE
			if(world.time < last_dodge + dodgetime)
				if(!istype(rmb_intent, /datum/rmb_intent/swift))				//Swift stance allows for rapid dodging, where stamina allows
					return FALSE
			if(has_status_effect(/datum/status_effect/debuff/riposted))
				return FALSE
			last_dodge = world.time
			if(D.loc == A.loc)
				return FALSE
			if(intenty)
				if(!intenty.candodge)
					return FALSE
			if(candodge)
				var/list/dirry = list()
				var/dx = x - A.x
				var/dy = y - A.y
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
					turfy = get_step(D,x)
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
					to_chat(D, span_boldwarning("There's nowhere to dodge to!"))
					return FALSE
				else
					if(do_dodge(A, turfy))
						flash_fullscreen("blackflash2")
						A.aftermiss()
						return TRUE
					else
						return FALSE
			else
				return FALSE
		if(INTENT_NODEF)
			return FALSE

/mob/proc/do_parry(obj/item/W, parrydrain as num, mob/living/user)
	if(ishuman(src))
		var/mob/living/carbon/human/D = src
		if(D.rogfat_add(parrydrain))
			if(W)
				playsound(get_turf(D), pick(W.parrysound), 100, FALSE)
			if(istype(rmb_intent, /datum/rmb_intent/riposte))
				D.visible_message(span_boldwarning("<b>[D]</b> ripostes [user] with [W]!"))
			else
				D.visible_message(span_boldwarning("<b>[D]</b> parries [user] with [W]!"))
			return TRUE
		else
			to_chat(D, span_warning("I'm too tired to parry!"))
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
	var/mob/living/D = src
	var/mob/living/A = user
	var/mob/living/carbon/human/DH
	var/mob/living/carbon/human/AH
	var/obj/item/I
	var/obj/item/DI = D.get_active_held_item()
	var/drained = 5
	var/dodge_speed = floor(D.STASPD / 2)
	if(ishuman(src))
		DH = src
	if(ishuman(user))
		AH = user
		I = AH.used_intent.masteritem
	var/dodge_score = D.simpmob_defend
	if(D.rogfat >= D.maxrogfat)
		return FALSE
	if(!(D.mobility_flags & MOBILITY_STAND))							//Can't dodge when knocked down
		return FALSE
	if(D)
		if(D?.check_dodge_skill())
			dodge_score += ((D.STASPD * 15) + (D.STAPER * 4))
		else
			dodge_score += ((D.STASPD * 10) + (D.STAPER * 4))
	if(A)
		dodge_score -= (A.mind ? (A.STASPD * 5) : A.simpmob_attack)

	if(I)
		if(AH?.mind)
			dodge_score -= (AH.mind.get_skill_level(I.associated_skill) * 10)
		if(I.wbalance > 0)												//Enemy weapon is quick, so they get a bonus based on spddiff
			dodge_score -= ((A.STASPD - D.STASPD) * 5)
	else
		if(AH?.mind)
			dodge_score -= (AH.mind.get_skill_level(/datum/skill/combat/unarmed) * 10)

	if(D.rmb_intent)
		dodge_score += (D.rmb_intent.def_bonus)								//Dodge bonus from Poise

				//// ADD WEAPON INTENT MODIFIERS HERE ////
	if(istype(DI, /obj/item/rogueweapon))
		switch(DI.wlength)
			if(WLENGTH_NORMAL)
				dodge_score -= 5
				drained += 2
			if(WLENGTH_LONG)
				dodge_score -= 10
				drained += 5
			if(WLENGTH_GREAT)
				dodge_score -= 15
				dodge_speed = floor(dodge_speed * 0.8)
				drained += 8
		dodge_score += (DI.wdodgebonus)
	
	dodge_score += (D.used_intent.idodgebonus)							//Some weapon intents help with dodging

	if(DH)
		if(!DH?.check_armor_skill() || DH?.legcuffed)
			DH.Knockdown(1)
			return FALSE
		if(I)															//Attacker attacked us with a weapon
			if(!I.associated_skill)										//Attacker's weapon doesn't have a skill because its improvised, so penalty to attack
				dodge_score += 10
			else
				if(DH.mind)
					dodge_score += (DH.mind.get_skill_level(I.associated_skill) * 10)

		else //the enemy attacked us unarmed or is nonhuman
			if(AH)
				if(AH.used_intent.unarmed)
					if(DH.mind)
						dodge_score += (DH.mind.get_skill_level(/datum/skill/combat/unarmed) * 10)

		switch(DH.worn_armor_class)
			if(ARMOR_CLASS_LIGHT)
				dodge_speed -= 10
				drained += 5
			if(ARMOR_CLASS_MEDIUM)
				dodge_score *= 0.5
				dodge_speed = floor(dodge_speed * 0.5)
				drained += 10
			if(ARMOR_CLASS_HEAVY)
				dodge_score *= 0.2
				dodge_speed = floor(dodge_speed * 0.25)
				drained += 20

		dodge_score = clamp(dodge_score, 0, 95)
		var/dodgeroll = rand(1, 100)

		if(D.client?.prefs.showrolls && GLOB.Debug2)
			to_chat(src, span_info("Roll under [dodge_score] to dodge... [dodgeroll]"))
		if(dodgeroll > dodge_score)
			return FALSE
		if(!DH.rogfat_add(max(drained, 5)))
			to_chat(src, span_warning("I'm too tired to dodge!"))
			return FALSE
	else																//Defender is non human
		dodge_score = clamp(dodge_score, 0, 95)
		var/dodgeroll = rand(1, 100)

		if(D.client?.prefs.showrolls && GLOB.Debug2)
			to_chat(src, span_info("Roll under [dodge_score] to dodge... [dodgeroll]"))
		if(dodgeroll > dodge_score)
			return FALSE
	dodgecd = TRUE
	dodge_speed = (11 - dodge_speed)
	playsound(src, 'sound/combat/dodge.ogg', 100, FALSE)
	throw_at(turfy, 1, dodge_speed, src, FALSE)
	if(drained > 0)
		src.visible_message(span_warning("<b>[src]</b> dodges [user]'s attack!"))
	else
		src.visible_message(span_warning("<b>[src]</b> easily dodges [user]'s attack!"))
	dodgecd = FALSE
//		if(DH)
//			if(DH.IsOffBalanced())
//				DH.Knockdown(1)
//				to_chat(DH, span_danger("I tried to dodge off-balance!"))
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
