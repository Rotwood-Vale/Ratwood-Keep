//The vile Vore Monster
/mob/living/simple_animal/hostile/retaliate/rogue/headless
	icon = 'icons/roguetown/mob/monster/lamia.dmi'
	name = "headless"
	desc = "A horrible beast of gluttony. Its body is built like a barrel with a maw that opens only to darkness."
	icon_state = "headless"
	icon_living = "headless"
	icon_dead = "headless_dead"
	gender = NEUTER
	emote_hear = null
	emote_see = null
	speak_chance = 1
	see_in_dark = 9
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/bite, /datum/intent/simple/claw)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1,
						/obj/item/reagent_containers/food/snacks/fat = 2,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)
	faction = list("orcs")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_REPTILE
	health = 350
	maxHealth = 350
	melee_damage_lower = 25
	melee_damage_upper = 35
	vision_range = 9
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 0
	minimum_distance = 0
	food_type = list()
	footstep_type = null
	pooptype = null
	STACON = 6
	STASTR = 13
	STASPD = 10
	deaggroprob = 0
	defprob = 10
	defdrain = 5
	del_on_deaggro = 999 SECONDS
	retreat_health = 0.1
	food = 0
	dodgetime = 15
	aggressive = 1
	remains_type = null
	body_eater = TRUE

	ai_controller = /datum/ai_controller/headless
	AIStatus = AI_OFF
	can_have_ai = FALSE

	var/mob/living/swallowed_mob
	var/health_at_swallow = 1000
	var/stomach_burn_cooldown = 0
	var/stomach_burn_delay = 10
	var/swallow_cooldown = 0
	var/swallow_cooldown_delay = 30 SECONDS

/mob/living/simple_animal/hostile/retaliate/rogue/headless/Initialize()
	. = ..()
	AddElement(/datum/element/ai_flee_while_injured, 0.75, retreat_health)

/mob/living/simple_animal/hostile/retaliate/rogue/headless/AttackingTarget()
	//If its a carbon, your cooldown is up, and your above 30% health you can eat them
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		/*
		* If your in crit then instantly swallowed.
		* If cooldown is up and the headless still
		* has health then they will attempt to swallow active combatants.
		*/
		if(C.stat != CONSCIOUS || (swallow_cooldown < world.time && health > maxHealth * 0.2))
			SwallowEnemy(target)
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/headless/Life()
	if(isliving(swallowed_mob))
		//Vomit your captive if you take 40 damage since swallowing them
		if(health < health_at_swallow - 40)
			SpitUp()
		if(swallowed_mob)
			if(stomach_burn_cooldown < world.time)
				//Yes they take burn damage. No i wont explain why.
				var/acid_damage = 20
				if(swallowed_mob.stat != CONSCIOUS)
					//To prevent someone being stuck in crit.
					acid_damage += 30
				swallowed_mob.adjustFireLoss(acid_damage)
				stomach_burn_cooldown = world.time + stomach_burn_delay
			if(swallowed_mob.stat == DEAD)
				//They are full dead.
				swallowed_mob.dust(drop_items = TRUE)
				swallowed_mob = null
				body_eater = TRUE
				adjustBruteLoss(-50)
				visible_message(span_notice("The [src] starts to rapidly heal."))
				//Half the cooldown since they successfully killed their target. Worst possible outcome has occured.
				swallow_cooldown = world.time + (swallow_cooldown_delay / 2)
	return ..()

//Consume the corpses of allies code.
/mob/living/simple_animal/hostile/retaliate/rogue/headless/CanAttack(atom/the_target)
	. = ..()
	if(!.)
		if(body_eater && isliving(the_target))
			var/mob/living/L = the_target
			if(L.stat == DEAD)
				return TRUE


//Headless prefer to eat whole bodies
/mob/living/simple_animal/hostile/retaliate/rogue/headless/DismemberBody(mob/living/L)
	SwallowEnemy(L)

/mob/living/simple_animal/hostile/retaliate/rogue/headless/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "torso"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "torso"
		if(BODY_ZONE_PRECISE_NOSE)
			return "torso"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "belly"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "claw"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "claw"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "foot"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "foot"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "torso"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "arm"
		if(BODY_ZONE_L_ARM)
			return "arm"
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/headless/death(gibbed)
	SpitUp()
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/headless/proc/SwallowEnemy(mob/living/L)
	if(swallowed_mob)
		return
	visible_message(span_notice("[src] grabs [L] and swallows them."))
	playsound(loc, 'sound/misc/eat.ogg', 25, TRUE)
	L.forceMove(src)
	swallowed_mob = L
	health_at_swallow = health
	body_eater = FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/headless/proc/SpitUp()
	if(swallowed_mob)
		visible_message(span_notice("[src] vomits a disheveled [swallowed_mob]."))
		playsound(loc, 'sound/vo/vomit.ogg', 25, TRUE)
		swallowed_mob.forceMove(get_turf(src))
		swallowed_mob = null
		body_eater = TRUE
	swallow_cooldown = world.time + swallow_cooldown_delay
