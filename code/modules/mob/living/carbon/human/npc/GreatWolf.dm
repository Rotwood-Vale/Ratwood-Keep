/mob/living/simple_animal/hostile/retaliate/rogue/choir/Obsidian
	name = "Obsidian Choir"
	icon = 'icons/roguetown/topadd/delinefortune/BossGreatWolf.dmi'
	summon_primer = "You are a shard of the Obsidian Choir, a being of screeching resonance and shadow-song."
	icon_state = "GreatWolfAlive"
	icon_living = "GreatWolfAlive"
	icon_dead = "GreatWolfDead"
	gender = NEUTER
	speak_chance = 2
	turns_per_move = 5
	see_in_dark = 7
	move_to_delay = 4
	aggressive = TRUE
	ranged = FALSE
	dodgetime = 30
	base_intents = list(/datum/intent/simple/bite)
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 800
	maxHealth = 800
	melee_damage_lower = 18
	melee_damage_upper = 26
	vision_range = 7
	aggro_vision_range = 10
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 25
	retreat_distance = 4
	minimum_distance = 3
	retreat_health = 0.3
	food = 0
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 14
	STASTR = 10
	STASPD = 9
	defprob = 35
	ranged_cooldown = 0

	var/enraged = FALSE
	var/phase_triggered = FALSE
	var/next_cast = 0

/mob/living/simple_animal/hostile/retaliate/rogue/choir/obsidian/Life()
	. = ..()
	if(world.time >= next_cast)
		ChoirAttack()
		next_cast = world.time + 80

/mob/living/simple_animal/hostile/retaliate/rogue/choir/obsidian/proc/ChoirAttack()
	if(enraged && prob(20))
		ChoirVoidPulse()
	else if(prob(25))
		ChoirRuneCircle()
	else if(prob(50))
		ChoirShriek()
	else
		ChoirPulse()

/mob/living/simple_animal/hostile/retaliate/rogue/choir/obsidian/proc/ChoirPulse()
	say("A dark tone vibrates from the stones...")
	for(var/mob/living/M in view(3, src))
		if(M.stat != DEAD && disjoint_lists(M.faction, src.faction))
			M.Knockdown(15)
			M.apply_damage(rand(10,20), BRUTE)

/mob/living/simple_animal/hostile/retaliate/rogue/choir/obsidian/proc/ChoirShriek()
	say("A sudden screech pierces the air!")
	for(var/mob/living/M in view(5, src))
		if(M.stat != DEAD && disjoint_lists(M.faction, src.faction))
			M.Stun(8)
			M.apply_damage(rand(5,15), BURN)

/mob/living/simple_animal/hostile/retaliate/rogue/choir/obsidian/proc/ChoirVoidPulse()
	say("The Choir vibrates into a sickening harmony!")
	for(var/mob/living/M in view(6, src))
		if(M.stat != DEAD && disjoint_lists(M.faction, src.faction))
			M.apply_damage(rand(15,30), TOX)
			M.visible_message(span_danger("[M] is struck by void resonance!"))

/mob/living/simple_animal/hostile/retaliate/rogue/choir/obsidian/proc/ChoirRuneCircle()
	say("Runes light up in black flame around the choir!")
	for(var/turf/T in range(5, src))
		if(prob(60))
			explosion(get_turf(T), heavy_impact_range = 1, flame_range = 1, smoke = FALSE)

