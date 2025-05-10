
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


/mob/living/carbon/human/species/human/northern/dungeon_base/npc_idle()
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)

	if(!target || target.stat == DEAD || get_dist(src, target) > 5)
		for(var/mob/living/L in view(5, src))
			if(should_target(L))
				target = L
				break

	if(target && get_dist(src, target) <= 2)
		use_combat_abilities()
		return

	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc, pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src, pick(GLOB.cardinals)))
	else if(prob(10))
		face_atom(get_step(src, pick(GLOB.cardinals)))

// === Sub (ah~~~) classes ===

// 1. Warrior
/mob/living/carbon/human/species/human/northern/dungeon_base/warrior/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_warrior)

/datum/outfit/job/roguetown/npc/dungeon_warrior
	name = "Dungeon Warrior"

	pre_equip(mob/living/carbon/human/H)
		..()
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
		armor = /obj/item/clothing/cloak/tabard/crusader/tief
		neck = /obj/item/clothing/neck/roguetown/coif
		gloves = /obj/item/clothing/gloves/roguetown/chain/iron
		pants = /obj/item/clothing/under/roguetown/chainlegs
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/advanced
		shoes = /obj/item/clothing/shoes/roguetown/armor
		r_hand = /obj/item/rogueweapon/spear

		H.STASTR = 14
		H.STASPD = 10
		H.STACON = 13
		H.STAEND = 14
		H.STAINT = 8
		H.STAPER = 15

/mob/living/carbon/human/species/human/northern/dungeon_base/warrior/use_combat_abilities()
	if(src.stat != CONSCIOUS || world.time < next_cast)
		return

	next_cast = world.time + 100

	// Найти врагов рядом
	var/list/enemies_in_range = list()
	for(var/mob/living/L in view(3, src))
		if(L != src && L.stat != DEAD && (L.faction == null || disjoint_lists(L.faction, src.faction)))
			enemies_in_range += L

	if(!enemies_in_range.len)
		return

	var/mob/living/target = pick(enemies_in_range)

	spawn(50) // 10 SECONDS
		if(target && get_dist(src, target) <= 3)
			src.say("Watch your steps!")
			warrior_strike(src, target)


// 2. Paladin
/mob/living/carbon/human/species/human/northern/dungeon_base/paladin/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_paladin)

/datum/outfit/job/roguetown/npc/dungeon_paladin
	name = "Dungeon Paladin"

	pre_equip(mob/living/carbon/human/H)
		..()
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
		mask = /obj/item/clothing/mask/rogue/facemask
		armor = /obj/item/clothing/cloak/tabard/crusader/tief
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
		neck = /obj/item/clothing/neck/roguetown/gorget
		pants = /obj/item/clothing/under/roguetown/chainlegs
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
		armor = /obj/item/clothing/cloak/tabard/crusader/tief
		neck = /obj/item/clothing/neck/roguetown/coif
		gloves = /obj/item/clothing/gloves/roguetown/chain/iron
		pants = /obj/item/clothing/under/roguetown/chainlegs
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		shoes = /obj/item/clothing/shoes/roguetown/armor
		r_hand = /obj/item/rogueweapon/sword
		l_hand = /obj/item/rogueweapon/shield/wood

		H.STASTR = 15
		H.STASPD = 15
		H.STACON = 15
		H.STAEND = 14
		H.STAINT = 8
		H.STAPER = 15


/mob/living/carbon/human/species/human/northern/dungeon_base/paladin/use_combat_abilities()
	if(src.stat != CONSCIOUS || world.time < next_cast)
		return

	next_cast = world.time + 300

	// Найти случайную вражескую цель в радиусе 3
	var/list/enemies_in_range = list()
	for(var/mob/living/L in view(3, src))
		if(L != src && L.stat != DEAD && (L.faction == null || disjoint_lists(L.faction, src.faction)))
			enemies_in_range += L

	if(!enemies_in_range.len)
		return

	var/mob/living/target = pick(enemies_in_range)

	// Спелл 1: Паралич
	spawn(50) // 5 SECONDS
		if(target && get_dist(src, target) <= 7)
			src.say("BE STILL!")
			target.visible_message(
				span_warning("[target] is gripped by unholy paralysis!"),
				span_userdanger("You feel your limbs freeze under a dreadful presence!")
			)
			target.Stun(20)

	// Спелл 2: Удар по голове
	spawn(100) // 10 SECONDS
		if(target && get_dist(src, target) <= 3)
			src.say("CRUSH THE HEAD!")
			headstrike_dungeon(src, target)

	// Спелл 3: Лечение себя
	spawn(200) // 20 SECONDS
		if(src.stat == CONSCIOUS)
			src.say("The gods mend our flesh!")
			var/obj/effect/proc_holder/spell/targeted/lesser_heal_npc/H = new(src)
			H.cast(null, src)

// 3. Cleric
/mob/living/carbon/human/species/human/northern/dungeon_base/cleric

/mob/living/carbon/human/species/human/northern/dungeon_base/cleric/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_cleric)

/datum/outfit/job/roguetown/npc/dungeon_cleric
	name = "Dungeon Cleric"

	pre_equip(mob/living/carbon/human/H)

		..()
		mask = /obj/item/clothing/mask/rogue/facemask
		head = /obj/item/clothing/head/roguetown/necrahood
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/necra
		neck = /obj/item/clothing/neck/roguetown/gorget
		gloves = /obj/item/clothing/gloves/roguetown/leather/advanced
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/advanced
		shoes = /obj/item/clothing/shoes/roguetown/armor/leather/advanced
		r_hand = /obj/item/rogueweapon/mace/wsword

		H.STASTR = 12
		H.STASPD = 10
		H.STACON = 12
		H.STAEND = 12
		H.STAINT = 11

/mob/living/carbon/human/species/human/northern/dungeon_base/cleric/use_combat_abilities()
	if(src.stat != CONSCIOUS || world.time < next_cast)
		return

	next_cast = world.time + 200


	src.say("Dark gods! Spread your blessing!")
	var/obj/effect/proc_holder/spell/targeted/lesser_heal_npc/H = new(src)
	H.cast(null, src)

	sleep(50) // 5 SECONDS

	var/list/enemies = list()
	for(var/mob/living/L in view(8, src))
		if(L != src && (L.faction == null || disjoint_lists(L.faction, faction)))
			enemies += L

	if(enemies.len)
		src.say("My gods rebuke you!!")
		var/obj/effect/proc_holder/spell/targeted/churnnpc/C = new(src)
		C.cast(enemies, src)



*/

// NPC SPELLS // DONT GIVE THEM TO PLAYERS  YOU RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR

/obj/effect/proc_holder/spell/targeted/lesser_heal_npc/cast(list/targets, mob/living/user)
	. = ..()
	if(!user)
		return FALSE

	var/list/heal_targets = list()
	for(var/mob/living/M in view(3, user))
		if(M.stat != DEAD && istype(M, /mob/living) && (!M.faction || !disjoint_lists(M.faction, user.faction)))
			heal_targets += M

	if(!heal_targets.len)
		return FALSE

	user.visible_message(
		span_warning("[user] raises a hand and healing light surrounds his allies!"),
		span_userdanger("A soothing warmth radiates from your ally!")
	)

	for(var/mob/living/M in heal_targets)
		spawn()
			if(QDELETED(M) || M.stat == DEAD)
				return
			M.adjustBruteLoss(-100)
			M.adjustFireLoss(-100)
			M.adjustOxyLoss(-100)
			M.adjustToxLoss(-100)
			if(M.blood_volume < BLOOD_VOLUME_NORMAL)
				M.blood_volume = min(M.blood_volume + 100, BLOOD_VOLUME_NORMAL)
			M.update_damage_overlays()

	return TRUE

/obj/effect/proc_holder/spell/targeted/churnnpc
	name = "Churn Undead NPC"
	range = 8
	overlay_state = "necra"
	releasedrain = 30
	charge_max = 20 SECONDS
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation_type = "whisper"


/obj/effect/proc_holder/spell/targeted/lesser_heal_npc/cast(list/targets, mob/living/user)
	. = ..()
	if(!user)
		return FALSE

	var/list/heal_targets = list()
	for(var/mob/living/M in view(7, user))
		if(M != user && M.stat != DEAD && !disjoint_lists(M.faction, user.faction))
			heal_targets += M

	src.visible_message(span_warning("Cleric raises a hand and healing light surrounds their fellows."))

	for(var/mob/living/M in heal_targets)
		spawn()
			if(QDELETED(M) || M.stat == DEAD)
				return

			var/list/zones = list(
				BODY_ZONE_HEAD,
				BODY_ZONE_CHEST,
				BODY_ZONE_R_ARM,
				BODY_ZONE_L_ARM,
				BODY_ZONE_R_LEG,
				BODY_ZONE_L_LEG)

			for(var/zone in zones)
				M.apply_damage(-100, BRUTE, zone)
				M.apply_damage(-100, BURN, zone)

			M.adjustOxyLoss(-100)
			M.adjustToxLoss(-100)
			M.adjustFireLoss(-100)

			if(M.blood_volume < BLOOD_VOLUME_NORMAL)
				M.blood_volume = min(M.blood_volume + 100, BLOOD_VOLUME_NORMAL)

			M.update_damage_overlays()

	return TRUE

/proc/warrior_strike(mob/living/target)
	if(!istype(target) || target.stat == DEAD || get_dist(src, target) > 3)
		return FALSE

	target.visible_message(
		span_warning("[target] takes a heavy kick to the left leg!"),
		span_userdanger("Your left leg nearly buckles!")
	)

	target.apply_damage(rand(20, 70), BRUTE, BODY_ZONE_L_LEG)

	return TRUE

/proc/display_results(mob/user, mob/living/target, msg_others, msg_self = null)
	if(!target)
		return
	target.visible_message(msg_others, msg_self)

/proc/headstrike_dungeon(mob/living/user, mob/living/target)
	if(!user || !target || target.stat == DEAD || get_dist(user, target) > 3)
		return FALSE

	if(target == user || (target.faction && !disjoint_lists(user.faction, target.faction)))
		return FALSE

	playsound(user, 'sound/magic/churn.ogg', 100, TRUE)

	target.visible_message(
		span_warning("[target] is bashed in the head with unholy force!"),
		span_userdanger("Your head rings from a heavy blow!")
	)

	target.apply_damage(rand(10, 60), BRUTE, BODY_ZONE_HEAD)

	return TRUE


/proc/disjoint_lists(list/A, list/B)
	for(var/val in A)
		if(val in B)
			return FALSE
	return TRUE
