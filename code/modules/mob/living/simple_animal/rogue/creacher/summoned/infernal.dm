/mob/living/simple_animal/hostile/retaliate/rogue/infernal/AIShouldSleep(list/possible_targets)
	if(!FindTarget(possible_targets, 1))
		addtimer(CALLBACK(src,PROC_REF(despawncheck)), del_on_deaggro)
		return TRUE
	else
		return FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/infernal
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	var/despawn_on_idle = TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/proc/despawncheck()
	if (!despawn_on_idle)
		return
	if(nearbyhumanpresent(5))	//check for humans in range
		return	//return if humans in range
	if(AIStatus == AI_IDLE)
		new /obj/effect/particle_effect/smoke/bad(src.loc)
		src.visible_message(span_notice("[src] returns to it's plane of origin."))
		dropcomponents()
		qdel(src)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/Move(newloc)
	if(binded)
		to_chat(src,span_warning("You're currently bound and unable to move!"))
		return
	.=..()

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/Initialize()
	. = ..()
	ADD_TRAIT(src,TRAIT_NOFIRE, "[type]")
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/DestroyObjectsInDirection(direction)
	var/turf/T = get_step(targets_from, direction)
	if(QDELETED(T))
		return
	if(T.Adjacent(targets_from))
		if(CanSmashTurfs(T))
			T.attack_animal(src)
			return
	for(var/obj/O in T.contents)
		if(!O.Adjacent(targets_from))
			continue
		if((ismachinery(O) || isstructure(O)) && environment_smash >= ENVIRONMENT_SMASH_STRUCTURES && !O.IsObscured())
			O.attack_animal(src)
			return


/mob/living/simple_animal/hostile/retaliate/rogue/infernal/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/imp
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "infernal imp"
	icon_state = "imp"
	icon_living = "imp"
	icon_dead = "vvd"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 3
	base_intents = list(/datum/intent/unarmed/claw)
	butcher_results = list()
	faction = list("infernal")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 70
	maxHealth = 70
	ranged = TRUE
	projectiletype = /obj/projectile/magic/firebolt
	obj_damage = 75
	melee_damage_lower = 15
	melee_damage_upper = 17
	vision_range = 8
	aggro_vision_range = 11
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 20
	retreat_distance = 6
	minimum_distance = 5
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 7
	STASTR = 6
	STASPD = 12
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0
	food = 0
	attack_sound = 'sound/combat/hits/bladed/smallslash (1).ogg'
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	ranged_message = "throws fire"
	dodgetime = 30
	aggressive = 1
	summon_primer = "You are an imp, a small creature spending it's time in the infernal plane amusing itself and eating meat. Now you've been pulled from your home into a new world, that is decidedly lacking in fire. How you react to these events, only time can tell."
	tier = 1

/obj/projectile/magic/firebolt
	name = "ball of fire"
	icon_state = "firebolt"
	damage = 20
	damage_type = BURN
	nodamage = FALSE
	armor_penetration = 0
	flag = "magic"
	hitsound = 'sound/blank.ogg'

/obj/projectile/magic/firebolt/on_hit(target)
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			M.visible_message(span_warning("[src] vanishes on contact with [target]!"))
			qdel(src)
			return BULLET_ACT_BLOCK
	. = ..()


/mob/living/simple_animal/hostile/retaliate/rogue/infernal/imp/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/imp/dropcomponents()
	var/turf/leavespot = get_turf(src)
	new /obj/item/natural/obsidian(leavespot)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/imp/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	spill_embedded_objects()
	update_icon()
	sleep(1)
	qdel(src)


/mob/living/simple_animal/hostile/retaliate/rogue/infernal/imp/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/imp/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/hellhound
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "hell hound"
	icon_state = "hellhound"
	icon_living = "hellhound"
	icon_dead = "vvd"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 6
	see_in_dark = 6
	move_to_delay = 4
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list()
	faction = list("infernal")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 170
	maxHealth = 170
	obj_damage = 75
	melee_damage_lower = 20
	melee_damage_upper = 25
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	simple_detect_bonus = 20
	retreat_distance = 0
	minimum_distance = 0
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 7
	STASTR = 9
	STASPD = 13
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0
	food = 0
	attack_sound = list('sound/vo/mobs/vw/attack (1).ogg','sound/vo/mobs/vw/attack (2).ogg','sound/vo/mobs/vw/attack (3).ogg','sound/vo/mobs/vw/attack (4).ogg')
	dodgetime = 30
	aggressive = 1
	summon_primer = "You are an hellhound, a moderate sized canine made of heat and flame. You spend time in the infernal plane hunting and incinerating things to your hearts content. Now you've been pulled from your home into a new world, that is decidedly lacking in fire. How you react to these events, only time can tell."
	var/flame_cd
	tier = 2

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/hellhound/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/hellhound/dropcomponents()
	var/turf/leavespot = get_turf(src)
	new /obj/item/natural/melded/t1(leavespot)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/hellhound/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	spill_embedded_objects()
	update_icon()
	qdel(src)


/mob/living/simple_animal/hostile/retaliate/rogue/infernal/hellhound/AttackingTarget()
	if(SEND_SIGNAL(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, target) & COMPONENT_HOSTILE_NO_PREATTACK)
		return FALSE //but more importantly return before attack_animal called
	SEND_SIGNAL(src, COMSIG_HOSTILE_ATTACKINGTARGET, target)
	in_melee = TRUE
	if(!target)
		return
	if(world.time >= src.flame_cd + 100)
		var/mob/living/targetted = target
		targetted.adjust_fire_stacks(5)
		targetted.IgniteMob()
		targetted.visible_message(span_danger("[src] sets [target] on fire!"))
		src.flame_cd = world.time
	return target.attack_animal(src)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "infernal watcher"
	icon_state = "watcher"
	icon_living = "watcher"
	icon_dead = "vvd"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	move_to_delay = 9
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list()
	faction = list("infernal")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 600
	maxHealth = 600
	obj_damage = 75
	melee_damage_lower = 20
	melee_damage_upper = 30
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	simple_detect_bonus = 20
	retreat_distance = 4
	minimum_distance = 3
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 13
	STASTR = 12
	STASPD = 8
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 10 SECONDS
	retreat_health = 0
	food = 0
	attack_sound = list('sound/misc/lava_death.ogg')
	dodgetime = 30
	aggressive = 1
//	stat_attack = UNCONSCIOUS
	ranged = TRUE
	ranged_cooldown = 40
	projectiletype = /obj/projectile/magic/aoe/fireball/rogue
	ranged_message = "stares"
	summon_primer = "You are an infernal watcher, a creature of lava and rock. You have watched over the chaos of the infernal plane long enough that it was been pointless to keep count. Now you've been pulled from your home into a new world, that is decidedly lacking in fire. How you react to these events, only time can tell."
	tier = 3

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)	//no wounding the watcher
	return

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher/MeleeAction(patience = TRUE)
	for(var/t in RANGE_TURFS(1, src))
		new /obj/effect/hotspot(t)
		src.visible_message(span_danger("[src] emits a burst of flames from it's core!"))
	if(rapid_melee > 1)
		var/datum/callback/cb = CALLBACK(src, PROC_REF(CheckAndAttack))
		var/delay = SSnpcpool.wait / rapid_melee
		for(var/i in 1 to rapid_melee)
			addtimer(cb, (i - 1)*delay)
	else
		AttackingTarget()
	if(patience)
		GainPatience()

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher/dropcomponents()
	var/turf/leavespot = get_turf(src)
	new /obj/item/natural/melded/t2(leavespot)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/moltencore(deathspot)
	new /obj/item/natural/moltencore(deathspot)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/melded/t1(deathspot)
	spill_embedded_objects()
	update_icon()
	qdel(src)


/mob/living/simple_animal/hostile/retaliate/rogue/infernal/fiend/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)	//no wounding the fiend
	return

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/fiend
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "fiend"
	icon_state = "fiend"
	icon_living = "fiend"
	icon_dead = "vvd"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 10
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list()
	faction = list("infernal")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 700
	maxHealth = 700
	obj_damage = 75
	melee_damage_lower = 30
	melee_damage_upper = 40
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_WALLS
	simple_detect_bonus = 20
	retreat_distance = 4
	minimum_distance = 4
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STAEND = 15
	STACON = 13
	STASTR = 12
	STASPD = 8
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 10 SECONDS
	retreat_health = 0
	food = 0
	attack_sound = list('sound/misc/lava_death.ogg')
	dodgetime = 30
	aggressive = 1
	ranged = TRUE
	rapid = TRUE
	projectiletype = /obj/projectile/magic/aoe/fireball/rogue
	ranged_message = "throws fire"
	var/flame_cd = 0
	var/summon_cd = 0
	summon_primer = "You are fiend, a large sized demon from the infernal plane. You have imps and hounds at your beck and call, able to do whatever you wished. Now you've been pulled from your home into a new world, that is decidedly lacking in fire. How you react to these events, only time can tell."
	tier = 4

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/fiend/dropcomponents()
	var/turf/leavespot = get_turf(src)
	new /obj/item/natural/melded/t3(leavespot)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/fiend/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/abyssalflame(deathspot)
	new /obj/item/natural/moltencore(deathspot)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/melded/t2(deathspot)
	spill_embedded_objects()
	update_icon()
	qdel(src)


/mob/living/simple_animal/hostile/retaliate/rogue/infernal/fiend/OpenFire(atom/A)
	if(CheckFriendlyFire(A))
		return
	visible_message(span_danger("<b>[src]</b> [ranged_message] at [A]!"))

	if(world.time >= src.flame_cd + 250)
		var/mob/living/targetted = target
		create_meteors(targetted)
		src.flame_cd = world.time

	if(world.time >= src.summon_cd + 600)
		callforbackup()

		src.summon_cd = world.time

	if(rapid > 1)
		var/datum/callback/cb = CALLBACK(src, PROC_REF(Shoot), A)
		for(var/i in 1 to rapid)
			addtimer(cb, (i - 1)*rapid_fire_delay)
	else
		Shoot(A)
	ranged_cooldown = world.time + ranged_cooldown_time


/mob/living/simple_animal/hostile/retaliate/rogue/infernal/fiend/proc/create_meteors(atom/target)
	if(!target)
		return
	target.visible_message(span_boldwarning("Fire rains from the sky!"))
	var/turf/targetturf = get_turf(target)
	for(var/turf/turf as anything in RANGE_TURFS(4,targetturf))
		if(prob(20))
			new /obj/effect/temp_visual/target(turf)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/fiend/proc/callforbackup()
	var/list/spawnLists = list(/mob/living/simple_animal/hostile/retaliate/rogue/infernal/imp,/mob/living/simple_animal/hostile/retaliate/rogue/infernal/imp, /mob/living/simple_animal/hostile/retaliate/rogue/infernal/hellhound, /mob/living/simple_animal/hostile/retaliate/rogue/infernal/hellhound)
	var/reinforcement_count = 3
	src.visible_message(span_notice("[src] summons reinforcements from the infernal abyss."))
	while(reinforcement_count > 0)
		var/list/turflist = list()
		for(var/turf/t in RANGE_TURFS(1, src))
			turflist += t

		var/turf/picked = pick(turflist)


		var/spawnTypes = pick_n_take(spawnLists)
		new spawnTypes(picked)
		reinforcement_count--
		continue
