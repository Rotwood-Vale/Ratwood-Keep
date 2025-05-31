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

	var/next_cast = 0

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

/// ========== WARRIOR ==========

/mob/living/carbon/human/species/human/northern/dungeon_base/warrior/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_warrior)

/datum/outfit/job/roguetown/npc/dungeon_warrior
	name = "Dungeon Warrior"

	pre_equip(mob/living/carbon/human/H)
		..()
		// Экипировка
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

/mob/living/carbon/human/species/human/northern/dungeon_base/warrior/Life()
	. = ..()
	if(world.time >= next_cast)
		next_cast = world.time + 100
		var/list/enemies = list()
		for(var/mob/living/L in view(3, src))
			if(L != src && L.stat != DEAD && disjoint_lists(L.faction, src.faction))
				enemies += L
		if(enemies.len)
			var/mob/living/target = pick(enemies)
			spawn(50)
				if(target && get_dist(src, target) <= 3)
					say("Watch your steps!")
					warrior_strike(src, target)

/// ========== PALADIN ==========

/mob/living/carbon/human/species/human/northern/dungeon_base/paladin/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_paladin)

/mob/living/carbon/human/species/human/northern/dungeon_base/paladin/Life()
	. = ..()
	if(world.time >= next_cast)
		next_cast = world.time + 300
		var/list/enemies = list()
		for(var/mob/living/L in view(3, src))
			if(L != src && L.stat != DEAD && disjoint_lists(L.faction, src.faction))
				enemies += L
		if(enemies.len)
			var/mob/living/target = pick(enemies)
			spawn(50)
				if(get_dist(src, target) <= 7)
					say("BE STILL!")
					target.Stun(20)
			spawn(100)
				if(get_dist(src, target) <= 3)
					say("CRUSH THE HEAD!")
					headstrike_dungeon(src, target)
			spawn(200)
				if(stat == CONSCIOUS)
					say("The gods mend our flesh!")
					var/obj/effect/proc_holder/spell/targeted/lesser_heal_npc/H = new(src)
					H.cast(null, src)

/// ========== CLERIC ==========

/mob/living/carbon/human/species/human/northern/dungeon_base/cleric/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_cleric)

/mob/living/carbon/human/species/human/northern/dungeon_base/cleric/Life()
	. = ..()
	if(world.time >= next_cast)
		next_cast = world.time + 100
		say("Dark gods! Spread your blessing!")
		var/obj/effect/proc_holder/spell/targeted/lesser_heal_npc/H = new(src)
		H.cast(null, src)

		spawn(50)
			var/list/enemies = list()
			for(var/mob/living/L in view(7, src))
				if(L != src && disjoint_lists(L.faction, src.faction))
					enemies += L
			if(enemies.len)
				say("My gods rebuke you!!")
				var/obj/effect/proc_holder/spell/targeted/churnnpc/C = new(src)
				C.cast(enemies, src)

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
