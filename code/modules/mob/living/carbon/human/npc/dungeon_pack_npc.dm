/mob/living/carbon/human/species/human/northern/dungeon_base
	aggressive = TRUE
	mode = AI_IDLE
	gender = MALE
	faction = list("dungeon")
	ambushable = FALSE
	dodgetime = 20
	defprob = 35
	flee_in_pain = FALSE
	wander = TRUE

	var/combat_loop_running = FALSE
	var/next_cast = 0

/mob/living/carbon/human/species/human/northern/dungeon_base/examine(mob/user)
	to_chat(user, "You don't recognize this person.")

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

/mob/living/carbon/human/species/human/northern/dungeon_base/Life(datum/controller/process/mobs/parent)
	. = ..()
	npc_idle()
	npc_combat()

/mob/living/carbon/human/species/human/northern/dungeon_base/retaliate(mob/living/L)
	. = ..()
	if(target)
		aggressive = TRUE
		wander = TRUE
		if(isliving(target) && target.client)
			spawn(5 SECONDS)
				if(target && aggressive)
					UseSpecialAbility()

/mob/living/carbon/human/species/human/northern/dungeon_base/npc_idle()
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)

	if(!target || target.stat == DEAD || get_dist(src, target) > 5)
		for(var/mob/living/L in view(5, src))
			if(should_target(L))
				target = L
				break

	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc, pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src, pick(GLOB.cardinals)))
	else if(prob(10))
		face_atom(get_step(src, pick(GLOB.cardinals)))

/mob/living/carbon/human/species/human/northern/dungeon_base/proc/npc_combat()
	if(world.time < next_cast)
		return
	if(!target || target.stat == DEAD || get_dist(src, target) > 7)
		return

	use_combat_abilities()
	next_cast = world.time + 100

// === Sub (ah~~~) classes ===

// 1. Warrior
/mob/living/carbon/human/species/human/northern/dungeon_base/warrior
	after_creation()
		..()
		equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_warrior)
		possible_rmb_intents += /datum/rmb_intent/swift

/mob/living/carbon/human/species/human/northern/dungeon_base/warrior/use_combat_abilities()
	if(src.stat != CONSCIOUS || world.time < next_cast)
		return

	next_cast = world.time + 100

	var/mob/living/T = find_nearest_enemy(src, 3)
	if(T && get_dist(src, T) <= 3)
		perform_warrior_strike(T)

/proc/find_nearest_enemy(mob/living/self, range = 5)
	var/closest
	var/min_dist = 999
	for(var/mob/living/L in view(range, self))
		if(L == self || L.stat == DEAD || !islist(L.faction)) continue
		if(disjoint_lists(L.faction, self.faction))
			var/d = get_dist(self, L)
			if(d < min_dist)
				min_dist = d
				closest = L
	return closest

/mob/living/carbon/human/species/human/northern/dungeon_base/warrior/proc/perform_warrior_strike(mob/living/target)
	if(!target || target.stat != CONSCIOUS  || get_dist(src, target) > 3)
		return

	src.say("Watch your steps!")
	warrior_strike(src, target)

// === Warrior Loadout ===

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

// 2. Paladin
/mob/living/carbon/human/species/human/northern/dungeon_base/paladin/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_paladin)
	possible_rmb_intents += /datum/rmb_intent/swift

/mob/living/carbon/human/species/human/northern/dungeon_base/paladin/use_combat_abilities()
	if(src.stat != CONSCIOUS || world.time < next_cast)
		return

	next_cast = world.time + 10

	var/list/enemies_in_range = list()
	for(var/mob/living/L in view(7, src))
		if(L != src && L.stat != DEAD && (L.faction == null || disjoint_lists(L.faction, src.faction)))
			enemies_in_range += L

	if(!enemies_in_range.len)
		return

	var/mob/living/target = pick(enemies_in_range)
	if(!target || target.stat != CONSCIOUS)
		return

	var/roll = rand(1, 3)

	if(roll == 1 && get_dist(src, target) <= 7)
		src.say("Stay still!")
		target.visible_message(
			span_warning("[target] is gripped by unholy hands!"),
			span_userdanger("You feel your limbs freeze under a dreadful presence!")
		)
		target.Stun(20)

	else if(roll == 2 && get_dist(src, target) <= 3)
		src.say("Watch your head!")
		headstrike_dungeon(src, target)

	else if(roll == 3 && src.stat == CONSCIOUS)
		src.say("The gods mend our flesh!")
		var/obj/effect/proc_holder/spell/targeted/lesser_heal_npc/H = new(src)
		H.cast(null, src)

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
		H.STAPER = 17

// 3. Cleric
/mob/living/carbon/human/species/human/northern/dungeon_base/cleric

/mob/living/carbon/human/species/human/northern/dungeon_base/cleric/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_cleric)
	possible_rmb_intents += /datum/rmb_intent/swift

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

	next_cast = world.time + 100  // 10 секунд

	var/roll = rand(1, 2)

	if(roll == 1)
		// === Churn Undead ===
		var/list/targets = list()
		for(var/mob/living/L in view(8, src))
			if(L != src && L.stat != DEAD && (!L.faction || disjoint_lists(L.faction, src.faction)))
				targets += L

		if(targets.len)
			src.say("ZIZO REBUKES!!")
			var/obj/effect/proc_holder/spell/targeted/churnnpc/C = new(src)
			C.cast(targets, src)

	else if(roll == 2)
		// === Lesser Heal ===
		src.say("Blessings upon our wounded!")
		var/obj/effect/proc_holder/spell/targeted/lesser_heal_npc/H = new(src)
		H.cast(null, src)



//ADVENTURERS NPCS

// === Adventurer NPCs ===

/mob/living/carbon/human/species/human/northern/dungeon_base/warriorfighter
	after_creation()
		..()
		equipOutfit(new /datum/outfit/job/roguetown/adventurer/warriorfighter)
		possible_rmb_intents += /datum/rmb_intent/swift

/datum/outfit/job/roguetown/adventurer/warriorfighter
	name = "Dwarven Warrior"

/datum/outfit/job/roguetown/adventurer/warriorfighter/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/winged
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backr = /obj/item/rogueweapon/shield/wood
	backl = /obj/item/storage/backpack/rogue/satchel
	if(prob(25))
		mask = /obj/item/clothing/mask/rogue/facemask
	if(prob(25))
		gloves = /obj/item/clothing/gloves/roguetown/chain
	else
		gloves = /obj/item/clothing/gloves/roguetown/leather/angle
	if(prob(50))
		beltl = /obj/item/rogueweapon/mace/steel
	else if(prob(50))
		beltl = /obj/item/rogueweapon/stoneaxe/battle
	else
		r_hand = /obj/item/rogueweapon/halberd
		beltl = /obj/item/rogueweapon/huntingknife

	H.STASTR = 17
	H.STAPER = 17
	H.STASPD = 17
	H.STACON = 17
	H.STAEND = 17
	H.STAINT = 13

/datum/outfit/job/roguetown/adventurer/bladesinger
	name = "Bladesinger Mage"

/mob/living/carbon/human/species/human/northern/dungeon_base/bladesinger
	after_creation()
		..()
		equipOutfit(new /datum/outfit/job/roguetown/adventurer/bladesinger)
		possible_rmb_intents += /datum/rmb_intent/swift

/datum/outfit/job/roguetown/adventurer/bladesinger/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/leather/vest
	backr = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger = 1)
	gloves = /obj/item/clothing/gloves/roguetown/leather
	cloak = /obj/item/clothing/cloak/raincloak/red
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	shoes = /obj/item/clothing/shoes/roguetown/armor
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/sword/iron/short
	head = /obj/item/clothing/head/roguetown/helmet/leather

	H.STASTR = 12
	H.STASPD = 17
	H.STACON = 12
	H.STAEND = 12
	H.STAINT = 17

/datum/outfit/job/roguetown/adventurer/rogue
	name = "Wilderness Rogue"

/mob/living/carbon/human/species/human/northern/dungeon_base/rogue
	after_creation()
		..()
		equipOutfit(new /datum/outfit/job/roguetown/adventurer/rogue)
		possible_rmb_intents += /datum/rmb_intent/swift

/datum/outfit/job/roguetown/adventurer/rogue/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	cloak = pick(/obj/item/clothing/cloak/raincloak/brown, /obj/item/clothing/cloak/raincloak/green)
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/bait = 1, /obj/item/rogueweapon/huntingknife = 1)
	beltl = /obj/item/ammo_holder/quiver/arrows


	H.STASTR = 12
	H.STAPER = 17
	H.STASPD = 17
	H.STACON = 12
	H.STAEND = 17
	H.STAINT = 12

/datum/outfit/job/roguetown/adventurer/cleric
	name = "Wandering Cleric"

/mob/living/carbon/human/species/human/northern/dungeon_base/cleric
	after_creation()
		..()
		equipOutfit(new /datum/outfit/job/roguetown/adventurer/cleric)
		possible_rmb_intents += /datum/rmb_intent/swift

/datum/outfit/job/roguetown/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/white
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/mace
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/wood
	backpack_contents = list(/obj/item/rogueweapon/huntingknife)


	H.STASTR = 12
	H.STASPD = 17
	H.STACON = 12
	H.STAEND = 17
	H.STAINT = 12

/datum/outfit/job/roguetown/adventurer/brawler
	name = "Unarmed Brawler"

/mob/living/carbon/human/species/human/northern/dungeon_base/brawler
	after_creation()
		..()
		equipOutfit(new /datum/outfit/job/roguetown/adventurer/brawler)
		possible_rmb_intents += /datum/rmb_intent/swift

/datum/outfit/job/roguetown/adventurer/brawler/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/armor
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/huntingknife/idagger
	beltl = /obj/item/rogueweapon/huntingknife/idagger


	H.STASTR = 17
	H.STASPD = 17
	H.STACON = 17
	H.STAEND = 17
	H.STAINT = 12


























// NPC SPELLS // DONT GIVE THEM TO PLAYERS  YOU RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR

// CLERIC

// ========== CHURN NPC =========

/obj/effect/proc_holder/spell/targeted/churnnpc
	name = "Churn Undead NPC"
	range = 8
	overlay_state = "necra"
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation_type = "whisper"

/obj/effect/proc_holder/spell/targeted/churnnpc/cast(list/targets, mob/living/user)
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
			L.Stun(10)
			L.Knockdown(10)
			if(prob(50))
				explosion(get_turf(L), light_impact_range = 1, flame_range = 1, smoke = FALSE)
			if(prob(20))
				explosion(get_turf(L), heavy_impact_range = 1, flame_range = 1, smoke = FALSE)
			L.apply_damage(rand(10, 50), BRUTE)

	return TRUE


// ========== LESSER HEAL NPC ==========
/obj/effect/proc_holder/spell/targeted/lesser_heal_npc
	name = "Lesser Heal (NPC)"
	overlay_state = "lesserheal"
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/heal.ogg'
	invocation_type = "whisper"
	antimagic_allowed = TRUE

/obj/effect/proc_holder/spell/targeted/lesser_heal_npc/cast(list/targets, mob/living/user)
	. = ..()
	if (!user)
		return FALSE

	var/list/heal_targets = list()
	for (var/mob/living/M in view(7, user))
		if (M.stat != DEAD && !disjoint_lists(M.faction, user.faction))
			heal_targets += M

	if (!heal_targets.len)
		return FALSE

	src.visible_message(span_warning("[user] raises a hand and healing light surrounds their allies."))

	for (var/mob/living/M in heal_targets)
		spawn()
			if (!M || QDELETED(M) || M.stat == DEAD)
				return

			var/healing = 30

			M.visible_message(span_notice("[M] begins to regenerate under divine power."))

			M.apply_status_effect(/datum/status_effect/buff/healing, healing)

			if (M.blood_volume < BLOOD_VOLUME_NORMAL)
				M.blood_volume = min(M.blood_volume + 100, BLOOD_VOLUME_NORMAL)

			M.update_damage_overlays()

	return TRUE


// ========== WARRIOR STRIKE ==========

/proc/warrior_strike(mob/living/user, mob/living/target)
	if(!istype(target) || target.stat != CONSCIOUS  || get_dist(user, target) > 3)
		return FALSE

	target.visible_message(
		span_warning("[target] takes a heavy kick to the leg!"),
		span_userdanger("Your leg nearly buckles!")
	)

	if(prob(30))
		target.Stun(20)
		target.apply_damage(rand(20, 70), BRUTE, BODY_ZONE_R_LEG)

	if(prob(30))
		target.Stun(20)
		target.apply_damage(rand(20, 70), BRUTE, BODY_ZONE_L_LEG)

	if(prob(5))
		target.apply_damage(rand(20, 70), BRUTE, BODY_ZONE_L_LEG)
		var/obj/item/bodypart/leg_l = target.get_bodypart(BODY_ZONE_L_LEG)
		var/datum/wound/W = new /datum/wound/dislocation()
		W.apply_to_bodypart(leg_l)

	if(prob(5))
		target.apply_damage(rand(20, 70), BRUTE, BODY_ZONE_R_LEG)
		var/obj/item/bodypart/leg_r = target.get_bodypart(BODY_ZONE_R_LEG)
		var/datum/wound/W2 = new /datum/wound/dislocation()
		W2.apply_to_bodypart(leg_r)

	else
		target.apply_damage(rand(5, 10), BRUTE, BODY_ZONE_L_LEG)

	return TRUE

/// ========== HEAD STRIKE ==========

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
	if(prob(30))
		var/atom/throw_target = get_edge_target_turf(user, get_dir(user, target))
		target.throw_at(throw_target, 5, 4)
		target.adjust_blurriness(3)
		target.emote("cry")
		target.apply_damage(rand(10, 60), BRUTE, BODY_ZONE_HEAD)
	if(prob(20)) //STUN
		target.Stun(20)
		target.Knockdown(20)
		target.apply_damage(rand(10, 60), BRUTE, BODY_ZONE_HEAD)
	if(prob(5)) //CRIT
		var/obj/item/bodypart/head = target.get_bodypart(BODY_ZONE_HEAD)
		var/datum/wound/W2 = new /datum/wound/fracture()
		W2.apply_to_bodypart(head)
		target.apply_damage(rand(40, 100), BRUTE, BODY_ZONE_HEAD)

	else //you are lucky
		target.apply_damage(rand(10, 15), BRUTE, BODY_ZONE_HEAD)

	return TRUE

/// ========== FIST SLAM ==========

/proc/shield_slam_dungeon(mob/living/user, mob/living/target)
	if(!user || !target || target.stat == DEAD || get_dist(user, target) > 3)
		return FALSE

	if(target == user || (target.faction && !disjoint_lists(user.faction, target.faction)))
		return FALSE

	user.say("Fall back!")

	target.visible_message(
		span_warning("[target] is slammed in the chest by a heavy fist!"),
		span_userdanger("The wind is knocked out of your lungs!")
	)

	if(prob(40))
		target.apply_damage(rand(20, 50), BRUTE, BODY_ZONE_CHEST)

	if(prob(20))
		target.Paralyze(20)
		target.apply_damage(rand(20, 50), BRUTE, BODY_ZONE_CHEST)
		target.emote("gasp")

	if(prob(5))
		target.apply_damage(rand(20, 50), BRUTE, BODY_ZONE_CHEST)
		var/datum/wound/W2 = new /datum/wound/fracture()
		W2.apply_to_bodypart(BODY_ZONE_HEAD)

	else
		target.apply_damage(rand(5, 15), BRUTE, BODY_ZONE_CHEST)

	return TRUE

/// ========== SPINE CRUSHER ==========

/proc/spinecrusher_dungeon(mob/living/user, mob/living/target)
	if(!user || !target || target.stat == DEAD || get_dist(user, target) > 2)
		return FALSE

	if(target == user || (target.faction && !disjoint_lists(user.faction, target.faction)))
		return FALSE

	user.say("You're not walking away from this.")

	target.visible_message(
		span_warning("[target] receives a devastating blow to the back!"),
		span_userdanger("Pain shoots through your spine!")
	)

	if(prob(30))
		target.Stun(30)
		target.apply_damage(rand(10, 15), BRUTE, BODY_ZONE_CHEST)

	if(prob(20))
		target.apply_damage(rand(20, 40), BRUTE, BODY_ZONE_CHEST)

	if(prob(5))
		target.apply_damage(rand(20, 40), BRUTE, BODY_ZONE_CHEST)
		var/obj/item/bodypart/chest = target.get_bodypart(BODY_ZONE_CHEST)
		if(chest)
			var/datum/wound/W2 = new /datum/wound/fracture()
			W2.apply_to_bodypart(chest)

	else
		target.apply_damage(rand(10, 20), BRUTE, BODY_ZONE_CHEST)

	return TRUE


/// ========== WRESTLER ==========

/mob/living/carbon/human/species/human/northern/dungeon_base/wrestler/Life()
	. = ..()
	if(world.time >= next_cast)
		next_cast = world.time + 150
		if(target && target.stat == CONSCIOUS && get_dist(src, target) <= 1)
			say("You’re going down!")
			target.Stun(50)
			target.Knockdown(50)
			spawn(100)
				var/list/enemies = list()
				for(var/mob/living/L in view(5, src))
					if(L != src && L.stat == CONSCIOUS && disjoint_lists(L.faction, src.faction))
						enemies += L
				if(enemies.len)
					target = pick(enemies)

/// ========== ROGUE ==========

/mob/living/carbon/human/species/human/northern/dungeon_base/rogue/Life()
	. = ..()
	if(world.time >= next_cast)
		next_cast = world.time + 150
		var/list/enemies = list()
		for(var/mob/living/L in view(7, src))
			if(L != src && L.stat != DEAD && disjoint_lists(L.faction, src.faction))
				enemies += L
		if(enemies.len)
			var/mob/living/target = pick(enemies)
			say("Shadows guide me...")
			step_towards(src, target)
			target.visible_message(span_warning("[src] suddenly appears behind [target]!"))
			spawn(20)
				if(get_dist(src, target) <= 1)
					src.visible_message(span_danger("[src] strikes from the shadows!"))
					target.apply_damage(rand(20, 80), BRUTE)
			spawn(100)
				if(get_dist(src, target) <= 2)
					say("Let’s slow you down.")
					target.apply_damage(rand(10, 20), BRUTE, BODY_ZONE_L_LEG)
					target.Slowdown(40)

/// ========== MAGE ==========

/mob/living/carbon/human/species/human/northern/dungeon_base/mage/Life()
	. = ..()
	if(world.time >= next_cast)
		next_cast = world.time + 180
		var/list/enemies = list()
		for(var/mob/living/L in view(8, src))
			if(L != src && L.stat != DEAD && disjoint_lists(L.faction, src.faction))
				enemies += L
		if(enemies.len)
			var/mob/living/target = pick(enemies)
			say("Arcana, strike true!")
			target.visible_message(span_warning("A bolt of arcane energy slams into [target]!"))
			target.apply_damage(rand(30, 60), BURN)
			if(prob(30))
				explosion(get_turf(target), 0, 1)
			spawn(100)
				say("Feel your soul burn!")
				target.apply_damage(rand(15, 45), BURN)
				target.Slowdown(30)

/// ========== SILENCER ==========

/mob/living/carbon/human/species/human/northern/dungeon_base/silencer/Life()
	. = ..()
	if(world.time >= next_cast)
		next_cast = world.time + 300
		say("Silence!")
		for(var/mob/living/L in view(5, src))
			if(L != src && L.stat != DEAD && disjoint_lists(L.faction, src.faction))
				to_chat(L, span_warning("A wave of oppressive silence washes over you..."))
				L.Stun(10)
		spawn(100)
			say("Your thoughts are not your own...")
			var/list/enemies = list()
			for(var/mob/living/L in view(7, src))
				if(L != src && L.stat != DEAD && disjoint_lists(L.faction, src.faction))
					enemies += L
			if(enemies.len)
				var/mob/living/target = pick(enemies)
				target.apply_damage(rand(30, 70), BRUTE, BODY_ZONE_HEAD)
				target.Stun(30)
				target.adjust_blurriness(3)

/// ========== SHARED ==========

/proc/disjoint_lists(list/A, list/B)
	for(var/x in A)
		if(x in B) return FALSE
	return TRUE
