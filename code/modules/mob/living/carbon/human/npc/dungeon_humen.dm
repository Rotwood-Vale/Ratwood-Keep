

/mob/living/carbon/human/species/human/northern/dungeon_base
	aggressive = TRUE
	mode = AI_IDLE
	gender = MALE
	faction = list("dungeon")
	ambushable = FALSE
	dodgetime = 20
	flee_in_pain = FALSE
	wander = TRUE
	var/combat_loop_running =  FALSE
	var/next_cast = 0
	possible_rmb_intents = list()

/mob/living/carbon/human/species/human/northern/dungeon_base/examine(mob/user)
	to_chat(user, "You don't recognize this person.")
	return

/mob/living/carbon/human/species/human/northern/dungeon_base/Initialize()
	. = ..()
	set_species(/datum/species/human/northern)
	spawn(1)
		after_creation()

/mob/living/carbon/human/species/human/northern/dungeon_base/after_creation()
	..()
	gender = pick(MALE, FEMALE)
	job = "Wanderer"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CANNOT_HARVEST_LUX, TRAIT_GENERIC)

/mob/living/carbon/human/species/human/northern/dungeon_base/proc/use_combat_abilities()
	return

/mob/living/carbon/human/species/human/northern/dungeon_base/retaliate(mob/living/L)
	. = ..()
	if(target)
		aggressive = TRUE
		wander = TRUE

		if(isliving(target) && target.client)
			spawn(10 SECONDS)
				if(target && aggressive)
					use_combat_abilities()

/mob/living/carbon/human/species/human/northern/dungeon_base/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/human/northern/dungeon_base/npc_idle()
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)

	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc, pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src, pick(GLOB.cardinals)))
	else if(prob(10))
		face_atom(get_step(src, pick(GLOB.cardinals)))
/*

// === Sub (ah~~~) classes ===

// 1. Warrior
/mob/living/carbon/human/species/human/northern/dungeon_base_warrior
	parent_type = /mob/living/carbon/human/species/human/northern/dungeon_base_base
	aggressive = TRUE
	wander = TRUE

/mob/living/carbon/human/species/human/northern/dungeon_base_warrior/after_creation()
	..()
	job = "dungeon_base Warrior"
	equipOutfit(new /datum/outfit/job/dungeon_base/warrior)


// 2. Paladin
/mob/living/carbon/human/species/human/northern/dungeon_base_paladin
	parent_type = /mob/living/carbon/human/species/human/northern/dungeon_base_base
	aggressive = TRUE
	wander = FALSE

/mob/living/carbon/human/species/human/northern/dungeon_base_paladin/after_creation()
	..()
	job = "dungeon_base Paladin"
	equipOutfit(new /datum/outfit/job/dungeon_base/paladin)

*/

// 3. Cleric
/mob/living/carbon/human/species/human/northern/dungeon_base/cleric

/obj/effect/proc_holder/spell/invoked/lesser_heal_npc

/obj/effect/proc_holder/spell/targeted/churnnpc

/mob/living/carbon/human/species/human/northern/dungeon_base/cleric/after_creation()
	..()

/mob/living/carbon/human/species/human/northern/dungeon_base/cleric/use_combat_abilities()
	if(world.time < next_cast)
		return

	next_cast = world.time + 200

	var/mob/living/target_to_heal = null

	var/list/allies = list()
	for(var/mob/living/M in view(7, src))
		if(M != src && M.health < M.maxHealth && !disjoint_lists(M.faction, faction))
			allies += M

	if(allies.len)
		target_to_heal = pick(allies)
	else if(src.health < src.maxHealth)
		target_to_heal = src

	if(target_to_heal)
		src.say("Dark gods do heals one of their followers!")
		var/obj/effect/proc_holder/spell/invoked/lesser_heal_npc/H = new(src)
		H.cast(list(target_to_heal), src)

	sleep(50) // 5 секунд

	var/list/enemies = list()
	for(var/mob/living/L in view(8, src))
		if(L != src && (L.faction == null || disjoint_lists(L.faction, faction)))
			enemies += L

	if(enemies.len)
		src.say("Undermaiden rebukes!!")
		var/obj/effect/proc_holder/spell/targeted/churnnpc/C = new(src)
		C.cast(enemies, src)


/*
// 4. Mage
/mob/living/carbon/human/species/human/northern/dungeon_base_mage
	parent_type = /mob/living/carbon/human/species/human/northern/dungeon_base_base
	aggressive = TRUE
	wander = TRUE

/mob/living/carbon/human/species/human/northern/dungeon_base_mage/after_creation()
	..()
	job = "dungeon_base Mage"
	equipOutfit(new /datum/outfit/job/dungeon_base/mage)


// 5. Rogue
/mob/living/carbon/human/species/human/northern/dungeon_base_rogue
	parent_type = /mob/living/carbon/human/species/human/northern/dungeon_base_base
	aggressive = TRUE
	wander = TRUE

/mob/living/carbon/human/species/human/northern/dungeon_base_rogue/after_creation()
	..()
	job = "dungeon_base Rogue"
	equipOutfit(new /datum/outfit/job/dungeon_base/rogue)


// 6. Soldier
/mob/living/carbon/human/species/human/northern/dungeon_base_trooper
	parent_type = /mob/living/carbon/human/species/human/northern/dungeon_base_base
	aggressive = TRUE
	wander = FALSE

/mob/living/carbon/human/species/human/northern/dungeon_base_trooper/after_creation()
	..()
	job = "dungeon_base Trooper"
	equipOutfit(new /datum/outfit/job/dungeon_base/trooper)


*/

// NPC SPELLS // DONT GIVE THEM TO PLAYERS  YOU RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR

/obj/effect/proc_holder/spell/invoked/lesser_heal_npc
	name = "Miracle NPC"
	overlay_state = "lesserheal"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/heal.ogg'
	invocation_type = "whisper"
	charge_max = 10 SECONDS

/obj/effect/proc_holder/spell/invoked/lesser_heal_npc/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]

		if(target.stat == DEAD || target.health >= target.maxHealth)
			return FALSE

		// YOUR FRACTION only
		if(disjoint_lists(user.faction, target.faction))
			return FALSE

		target.visible_message(span_info("[target] is bathed in unholy light!"), span_notice("Warmth flows through me..."))
		target.adjustOxyLoss(-100)
		target.adjustToxLoss(-100)
		target.adjustBruteLoss(-100)
		target.adjustFireLoss(-100)

		return TRUE // I REPEAT NPC ONLY YOU R WORD

	/obj/effect/proc_holder/spell/targeted/churnnpc
	name = "Churn Undead NPC"
	range = 8
	overlay_state = "necra"
	releasedrain = 30
	charge_max = 20 SECONDS
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation = "The Undermaiden rebukes!"
	invocation_type = "shout"


/obj/effect/proc_holder/spell/targeted/churnnpc/cast(list/targets, mob/living/user = usr)
	if(!user)
		return FALSE

	var/list/user_faction = islist(user.faction) ? user.faction : list()

	for(var/mob/living/L in targets)
		if(L == user || L.stat == DEAD)
			continue

		if(!L.faction || disjoint_lists(L.faction, user_faction))
			L.visible_message(
				span_warning("[L] is struck by unholy wrath!"),
				span_userdanger("Unholy force burns through me!")
			)
			L.Stun(40)
			L.Knockdown(40)
			if(prob(80))
				explosion(get_turf(L), heavy_impact_range = 1, flame_range = 1, smoke = FALSE)
			L.apply_damage(rand(10, 25), BRUTE)

	return TRUE

/proc/disjoint_lists(list/A, list/B)
	for(var/val in A)
		if(val in B)
			return FALSE
	return TRUE
