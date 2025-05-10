

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
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		shoes = /obj/item/clothing/shoes/roguetown/armor
		r_hand = /obj/item/rogueweapon/spear

		H.STASTR = 14
		H.STASPD = 10
		H.STACON = 13
		H.STAEND = 14
		H.STAINT = 8
		H.STAPER = 15

/mob/living/carbon/human/species/human/northern/dungeon_base/warrior/use_combat_abilities()
	if(src.stat != CONSCIOUS || src.stat != CONSCIOUS || world.time < next_cast)
		return

	next_cast = world.time + 10

	if(!target || get_dist(src, target) > 2)
		return

	var/list/possible_zones = list(
		BODY_ZONE_HEAD,
		BODY_ZONE_CHEST,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_LEG,
		BODY_ZONE_L_LEG
	)

	var/zone = pick(possible_zones)
	warrior_strike(target, zone)

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
		cloak = /obj/item/clothing/cloak/templar/necran
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
		neck = /obj/item/clothing/neck/roguetown/gorget
		pants = /obj/item/clothing/under/roguetown/chainlegs
		gloves = /obj/item/clothing/gloves/roguetown/chain/iron
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		shoes = /obj/item/clothing/shoes/roguetown/armor
		r_hand = /obj/item/rogueweapon/sword
		l_hand = /obj/item/rogueweapon/shield/wood

		H.STASTR = 17
		H.STASPD = 13
		H.STACON = 18
		H.STAEND = 15
		H.STAINT = 9
		H.STAPER = 15


/mob/living/carbon/human/species/human/northern/dungeon_base/cleric/use_combat_abilities()
	if(!is_alive(src) || src.stat != CONSCIOUS || world.time < next_cast)
		return

	next_cast = world.time + 300

	spawn(50) // 5 SECONDS
		if(istype(src.target, /mob/living) && get_dist(src, src.target) <= 7)
			var/mob/living/L = src.target
			src.say("BE STILL!")
			L.visible_message(
				span_warning("[L] is gripped by unholy paralysis!"),
				span_userdanger("You feel your limbs freeze under a dreadful presence!")
			)
			L.Stun(20)

	spawn(100) // 10 SECONDS
		if(istype(src.target, /mob/living) && get_dist(src, src.target) <= 2)
			src.say("CRUSH THE HEAD!")
			headstrike_dungeon(src)

	spawn(200) // 20 SECONDS
		if(is_alive(src))
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
	if(!is_alive(src) || src.stat != CONSCIOUS || world.time < next_cast)
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
		src.say("My gods do rebuke you!!")
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

/obj/effect/proc_holder/spell/targeted/lesser_heal_npc
	name = "Miracle NPC"
	overlay_state = "lesserheal"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	cast_without_targets = TRUE
	sound = 'sound/magic/heal.ogg'
	invocation_type = "whisper"
	charge_max = 10 SECONDS

/obj/effect/proc_holder/spell/targeted/lesser_heal_npc/cast(list/targets, mob/living/user)
	. = ..()
	if(!user)
		return FALSE

	var/list/heal_targets = list()
	for(var/mob/living/M in view(3, user))
		if(M.stat != DEAD && !disjoint_lists(M.faction, user.faction))
			heal_targets += M

	src.visible_message(span_warning("Cleric raises a hand and healing light surrounds his fellows."))

	for(var/mob/living/M in heal_targets)
		spawn()
			if(QDELETED(M) || M.stat == DEAD)
				break
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
			L.Stun(20)
			L.Knockdown(20)
			if(prob(30))
				explosion(get_turf(L), heavy_impact_range = 1, flame_range = 1, smoke = FALSE)
			L.apply_damage(rand(10, 25), BRUTE)

	return TRUE

/proc/headstrike_dungeon(mob/living/user)
	if(!user || !user.target)
		return FALSE

	var/mob/living/target = user.target

	if(!isturf(user.loc) || get_dist(user, target) > 2 || target.stat == DEAD)
		return FALSE

	if(target == user || (target.faction && !disjoint_lists(user.faction, target.faction)))
		return FALSE

	playsound(user, 'sound/magic/churn.ogg', 100, TRUE)

	target.visible_message(
		span_warning("[target] is bashed in the head with unholy force!"),
		span_userdanger("Your head rings from a heavy blow!")
	)
	target.apply_damage(rand(10, 50), BRUTE, BODY_ZONE_HEAD)
	M.add_nausea(50)

	return TRUE


/proc/warrior_strike(mob/living/target, zone)
	if(!istype(target) || target.stat == DEAD || get_dist(src, target) > 2)
		return

	switch(zone)
		if(BODY_ZONE_HEAD)
			src.visible_message(
				span_warning("[target] is bashed in the head with unholy force!"),
				span_userdanger("Your head rings from a heavy blow!")
			)
		if(BODY_ZONE_CHEST)
			src.visible_message(
				span_warning("[target] takes a crushing blow to the chest!"),
				span_userdanger("You gasp for air as pain shoots through your ribs!")
			)
		if(BODY_ZONE_R_ARM)
			src.visible_message(
				span_warning("[target]'s right arm is slashed violently!"),
				span_userdanger("Your right arm burns with pain!")
			)
		if(BODY_ZONE_L_ARM)
			src.visible_message(
				span_warning("[target]'s left arm is battered hard!"),
				span_userdanger("You feel your left arm go numb!")
			)
		if(BODY_ZONE_R_LEG)
			src.visible_message(
				span_warning("[target] takes a heavy kick to the right leg!"),
				span_userdanger("Your right leg nearly gives out!")
			)
		if(BODY_ZONE_L_LEG)
			src.visible_message(
				span_warning("[target] takes a heavy kick to the left leg!"),
				span_userdanger("Your left leg nearly buckles!")
			)

	target.apply_damage(rand(20, 70), BRUTE, zone)







/proc/disjoint_lists(list/A, list/B)
	for(var/val in A)
		if(val in B)
			return FALSE
	return TRUE
