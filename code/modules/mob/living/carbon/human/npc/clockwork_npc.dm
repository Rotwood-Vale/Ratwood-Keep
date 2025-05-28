/mob/living/simple_animal/hostile/retaliate/rogue/gearwarden
	name = "The Gearwarden"
	desc = "An ancient war machine, long forgotten, still faithful to a kingdom now in dust."
	icon = 'icons/roguetown/mob/monster/swiper.dmi'
	icon_state = "fox"
	icon_living = "fox"
	icon_dead = "fox_dead"
	speak_chance = 2
	turns_per_move = 5
	see_in_dark = 7
	move_to_delay = 4
	aggressive = TRUE
	ranged = FALSE
	dodgetime = 30
	base_intents = list(/datum/intent/simple/bite)
	health = 1000
	maxHealth = 1000
	melee_damage_lower = 25
	melee_damage_upper = 35
	vision_range = 8
	aggro_vision_range = 10
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	simple_detect_bonus = 25
	retreat_distance = 0
	minimum_distance = 1
	retreat_health = 0.2
	food = 0
	food_type = list()
	footstep_type = FOOTSTEP_MOB_HEAVY
	STACON = 16
	STASTR = 15
	STASPD = 5
	defprob = 30
	ranged_cooldown = 0
	attack_verb_simple = "slashes"
	attack_verb_continuous = "slashes"
	var/next_special = 0

/mob/living/simple_animal/hostile/retaliate/rogue/gearwarden/Life()
	. = ..()
	if(world.time >= next_special)
		GearwardenSpecial()
		next_special = world.time + 100

/mob/living/simple_animal/hostile/retaliate/rogue/gearwarden/proc/GearwardenSpecial()
	var/picked = pick("spin", "pulse", "shrapnel")
	switch(picked)
		if("spin")
			GearwardenSpin()
		if("pulse")
			GearwardenPulse()
		if("shrapnel")
			GearwardenShrapnel()

/mob/living/simple_animal/hostile/retaliate/rogue/gearwarden/proc/GearwardenSpin()
	visible_message(span_danger("[src]'s gears screech as it begins to rotate violently!"))
	for(var/mob/living/M in range(2, src))
		if(M.stat != DEAD && disjoint_lists(M.faction, src.faction))
			M.apply_damage(rand(15, 30), BRUTE)
			M.Knockdown(10)

/mob/living/simple_animal/hostile/retaliate/rogue/gearwarden/proc/GearwardenPulse()
	visible_message(span_warning("[src] releases a concussive force!"))
	for(var/mob/living/M in view(4, src))
		if(M.stat != DEAD && disjoint_lists(M.faction, src.faction))
			M.Stun(5)
			M.apply_damage(rand(10, 15), BRUTE)

/mob/living/simple_animal/hostile/retaliate/rogue/gearwarden/proc/GearwardenShrapnel()
	visible_message(span_danger("Explosive bolts launch from [src]'s core in all directions!"))
	for(var/turf/T in range(5, src))
		if(prob(30))
			explosion(T, light_impact_range = 1, flame_range = 0, smoke = FALSE)

