//BOSS NPC: Mirror Knight

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
	if(isliving(target))
		spawn(50) // 5 секунд
			if(target && aggressive)
				UseSpecialAbility()

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


// BOSS NPC: Great Wolf

/mob/living/simple_animal/hostile/retaliate/rogue/GreatWolf
	name = "Great Wolf"
	icon = 'icons/roguetown/topadd/delinefortune/BossGreatWolf.dmi'
	icon_state = "GreatWolfAlive"
	icon_living = "GreatWolfAlive"
	icon_dead = "GreatWolfDead"
	faction = list("orcs", "wolfs","dungeon","wolves")
	gender = NEUTER
	speak_chance = 2
	turns_per_move = 5
	see_in_dark = 7
	move_to_delay = 2
	aggressive = TRUE
	ranged = FALSE
	dodgetime = 30
	base_intents = list(/datum/intent/sword/cut)
	mob_biotypes = MOB_ORGANIC|MOB_BEAST

	health = 1500
	maxHealth = 1500
	melee_damage_lower = 60
	melee_damage_upper = 120
	retreat_distance = 0
	minimum_distance = 0
	retreat_health = 0 // 0 = For Motherland, there is no option to retreat
	vision_range = 7
	aggro_vision_range = 10
	environment_smash = ENVIRONMENT_SMASH_WALLS
	simple_detect_bonus = 25
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	food = 0

	body_eater = TRUE
	pooptype = null
	STACON = 50
	STASTR = 30
	STASPD = 15
	STAPER = 9
	defprob = 35
	ranged_cooldown = 0

	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat,
				/obj/item/bodypart,
				/obj/item/organ)

	var/enraged = FALSE
	var/next_special_cast = 0
	var/special_cooldown = 80 // 8 секунд

/mob/living/simple_animal/hostile/retaliate/rogue/GreatWolf/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	possible_rmb_intents += /datum/rmb_intent/swift

/mob/living/simple_animal/hostile/retaliate/rogue/MirrorKnight/Life()
	. = ..()
	if(isliving(target))
		spawn(50) // 5 секунд
			if(target && aggressive)
				UseSpecialAbility()

	if(world.time >= next_special_cast)
		UseSpecialAbility()
		next_special_cast = world.time + special_cooldown

	if(blood_volume < 300)
		blood_volume += 700 //WE LOVE ROGUE CODE WE LOVE ROGUE CODE MOST MOBS WILL DIE OF BLOOD LOSS AND CRIT

/mob/living/simple_animal/hostile/retaliate/rogue/GreatWolf/proc/UseSpecialAbility()
	var/roll = rand(1, 4)
	switch(roll)
		if(1) GhostBlade()
		if(2) MoonLeap()
		if(3) DarkHowl()
		if(4) SealOfTheLastBreath()

/mob/living/simple_animal/hostile/retaliate/rogue/GreatWolf/proc/GhostBlade()
	src.show_message(span_emote("swings a spectral blade through the air!"))
	var/turf/T = get_turf(target)
	if(!T) return
	var/turf/start = get_turf(src)
	if(!start) return

	for(var/turf/path in range(6, start))
		if(get_dist(path, T) <= 1)
			for(var/mob/living/M in path.contents)
				if(M != src && M.stat != DEAD)
					M.apply_damage(rand(50, 80), BRUTE)
					if(prob(40))
						M.Stun(2)
					M.visible_message(span_danger("[M] is slashed by a ghostly crescent!"))

/mob/living/simple_animal/hostile/retaliate/rogue/GreatWolf/proc/MoonLeap()
	src.show_message(span_emote("leaps into the air with supernatural strength!"))
	if(!target || !isturf(target.loc)) return
	var/turf/T = get_turf(target)

	forceMove(T)

	for(var/mob/living/M in range(1, T))
		if(M != src && M.stat != DEAD)
			M.Knockdown(30)
			M.apply_damage(rand(50, 80), BRUTE)
			M.visible_message(span_danger("[M] is knocked back by the crushing impact!"))

/mob/living/simple_animal/hostile/retaliate/rogue/GreatWolf/proc/DarkHowl()
	src.show_message(span_emote("unleashes a deafening, psychic howl!"))
	playsound(src, pick('sound/vo/mobs/wwolf/howldist (1).ogg', 'sound/vo/mobs/wwolf/howldist (2).ogg'), 100, TRUE)
	for(var/mob/living/M in view(7, src))
		if(M != src && M.stat != DEAD)
			M.Stun(10)
			M.apply_damage(rand(10, 50), BURN)
			M.visible_message(span_warning("[M] reels in pain from the psychic howl!"))

/mob/living/simple_animal/hostile/retaliate/rogue/GreatWolf/proc/SealOfTheLastBreath()
	src.show_message(span_emote("strikes his enemy with all its might!"))
	var/turf/T = get_turf(target)
	if(!T) return
	for(var/turf/A in range(2, T))
		if(prob(70))
			explosion(A, light_impact_range = 1, heavy_impact_range = 1, flame_range = 0, smoke = FALSE)