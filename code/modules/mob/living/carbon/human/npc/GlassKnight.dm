/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight
	name = "Mirror Knight"
	icon = 'icons/roguetown/topadd/delinefortune/GlassKnight.dmi'
	icon_state = "GlassKnightAlive"
	icon_living = "GlassKnightAlive"
	icon_dead = "GlassKnightDead"
	faction = list("dungeon")
	gender = NEUTER
	speak_chance = 0
	health = 1200
	maxHealth = 1200
	melee_damage_lower = 70
	melee_damage_upper = 120
	vision_range = 6
	aggro_vision_range = 8
	see_in_dark = 6
	turns_per_move = 4
	move_to_delay = 1
	aggressive = TRUE
	ranged = FALSE
	dodgetime = 20
	retreat_distance = 0
	retreat_health = 0
	minimum_distance = 0
	environment_smash = ENVIRONMENT_SMASH_WALLS
	simple_detect_bonus = 15
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	mob_biotypes = MOB_ORGANIC | MOB_HUMANOID
	base_intents = list(/datum/intent/sword/cut)
	var/enraged = FALSE
	var/next_special_cast = 0
	var/special_cooldown = 80
	var/is_clone = FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/Life()
	. = ..()
	if(world.time >= next_special_cast)
		UseSpecialAbility()
		next_special_cast = world.time + special_cooldown

	if(blood_volume < 300)
		blood_volume += 700

/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/proc/UseSpecialAbility()
	var/roll = rand(1, 5)
	switch(roll)
		if(1) MirrorGuard()
		if(2) MirrorClone()
		if(3) ShatterStrike()
		if(4) MirrorFlash()
		if(5) MirrorStep()

/proc/find_nearest_enemy(mob/living/self, range = 7)
	var/closest
	var/min_dist = 999
	for(var/mob/living/M in view(range, self))
		if(M == self || M.stat == DEAD || !islist(M.faction)) continue
		if(disjoint_lists(M.faction, self.faction))
			var/d = get_dist(self, M)
			if(d < min_dist)
				min_dist = d
				closest = M
	return closest

/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/proc/MirrorGuard()
	src.visible_message(span_emote("[src] raises a shimmering mirror shield!"))
	src.visible_message(span_notice("[src]'s armor gleams with refracted energy!"))

/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/proc/MirrorClone()
	if(src.is_clone)
		return

	for(var/i in 1 to 3)
		var/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/clone = new(get_turf(src))
		clone.name = "Mirror Image"
		clone.alpha = 128
		clone.health = 100
		clone.maxHealth = 100
		clone.is_clone = TRUE
		clone.visible_message(span_warning("A mirror clone of [src] emerges!"))

		spawn(100)
			if(clone)
				clone.visible_message(span_notice("[clone] shimmers and vanishes."))
				qdel(clone)

/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/proc/ShatterStrike()
	src.visible_message(span_emote("[src] delivers a crushing blow that sends shards flying!"))
	var/mob/living/M = find_nearest_enemy(src)
	if(M)
		M.apply_damage(rand(30, 45), BRUTE)
		src.visible_message(span_danger("[M] is shattered by [src]'s blade!"))
		for(var/mob/living/N in range(1, M))
			if(N != src && N != M && disjoint_lists(N.faction, src.faction))
				N.apply_damage(rand(8, 14), BRUTE)
				src.visible_message(span_warning("[N] is struck by flying shards!"))

/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/proc/MirrorFlash()
	src.visible_message(span_emote("[src] flashes with blinding mirrorlight!"))
	for(var/mob/living/M in view(3, src))
		if(M != src && M.stat != DEAD && disjoint_lists(M.faction, src.faction))
			M.Stun(5)
			M.apply_damage(rand(10, 40), BURN)
			src.visible_message(span_warning("[M] is dazzled by the flash!"))

/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/proc/MirrorStep()
	speak_emote = ("[src] vanishes and reappears behind the target!")
	var/mob/living/M = find_nearest_enemy(src)
	if(M)
		var/turf/T = get_step(M, M.dir)
		if(T)
			src.forceMove(T)
			M.apply_damage(rand(30, 80), BRUTE)
			src.visible_message(span_danger("[M] is slashed from behind by [src]!"))

/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/CalmDown()
	. = ..()
	LesserHealSelf()

/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/proc/LesserHealSelf()
	if(stat == DEAD || QDELETED(src))
		return

	if(health >= maxHealth)
		return

	visible_message(span_warning("[src] steadies itself as healing light washes over its armor."))

	var/healing = rand(800)
	adjustHealth(healing)

	if(blood_volume < BLOOD_VOLUME_NORMAL)
		blood_volume = min(blood_volume + 100, BLOOD_VOLUME_NORMAL)

	update_damage_overlays()
