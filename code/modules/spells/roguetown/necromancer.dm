/obj/effect/proc_holder/spell/invoked/bonechill
	name = "Bone Chill"
	overlay_state = "raiseskele"
	releasedrain = 30
	chargetime = 5
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	charge_max = 15 SECONDS
	miracle = FALSE

/obj/effect/proc_holder/spell/invoked/bonechill/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(50, 50))
					target.update_damage_overlays()
				if(affecting.heal_wounds(50))
					target.update_damage_overlays()
			target.visible_message(span_danger("[target] reforms under the vile energy!"), span_notice("I'm remade by dark magic!"))
			return TRUE
		target.visible_message(span_info("Necrotic energy floods over [target]!"), span_userdanger("I feel colder as the dark energy floods into me!"))
		if(iscarbon(target))
			target.Paralyze(50)
		else
			target.adjustBruteLoss(20)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/eyebite
	name = "Eyebite"
	overlay_state = "raiseskele"
	releasedrain = 30
	chargetime = 15
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/suit/roguetown/shirt/robe/necromancer)
	sound = 'sound/items/beartrap.ogg'
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	charge_max = 15 SECONDS
	miracle = FALSE

/obj/effect/proc_holder/spell/invoked/eyebite/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_info("A loud crunching sound has come from [target]!"), span_userdanger("I feel arcane teeth biting into my eyes!"))
		target.adjustBruteLoss(30)
		target.blind_eyes(2)
		target.blur_eyes(10)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/raise_undead
	name = "Raise Greater Undead"
	desc = ""
	clothes_req = FALSE
	range = 7
	overlay_state = "raiseskele"
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 40
	chargetime = 60
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	charge_max = 60 SECONDS

/obj/effect/proc_holder/spell/invoked/raise_undead/cast(list/targets, mob/living/user)
	. = ..()
	var/turf/T = get_turf(targets[1])
	if(isopenturf(T))
		var/mob/living/carbon/target = new /mob/living/carbon/human/species/skeleton/npc(T)
		var/list/candidates = pollCandidatesForMob("Do you want to play as a Necromancer's skeleton?", null, null, null, 100, target, POLL_IGNORE_NECROMANCER_SKELETON)
		if(LAZYLEN(candidates))
			var/mob/C = pick(candidates)
			target.key = C.key
			target.visible_message(span_warning("[target]'s eyes light up with an eerie glow!"))
		else
			target.visible_message(span_warning("[target]'s eyes remain dully devoid of life. The spell failed to capture a soul from the ether."))
		return TRUE
	to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
	return FALSE

/obj/effect/proc_holder/spell/invoked/raise_lesser_undead
	name = "Raise Lesser Undead"
	desc = ""
	clothes_req = FALSE
	range = 7
	overlay_state = "raiseskele"
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 40
	chargetime = 60
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	charge_max = 60 SECONDS

/obj/effect/proc_holder/spell/invoked/raise_lesser_undead/cast(list/targets, mob/living/user)
	. = ..()
	var/turf/T = get_turf(targets[1])
	var/skeleton_roll = rand(1,100)
	if(isopenturf(T))
		switch(skeleton_roll)
			if(1 to 20)
				new /mob/living/simple_animal/hostile/rogue/skeleton/axe(T)
			if(21 to 40)
				new /mob/living/simple_animal/hostile/rogue/skeleton/spear(T)
			if(41 to 60)
				new /mob/living/simple_animal/hostile/rogue/skeleton/guard(T)
			if(61 to 80)
				new /mob/living/simple_animal/hostile/rogue/skeleton/bow(T)
			if(81 to 100)
				new /mob/living/simple_animal/hostile/rogue/skeleton(T)
		return TRUE
	else
		to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
		return FALSE

/obj/effect/proc_holder/spell/invoked/projectile/sickness
	name = "Ray of Sickness"
	desc = ""
	clothes_req = FALSE
	range = 15
	projectile_type = /obj/projectile/magic/sickness
	overlay_state = "raiseskele"
	sound = list('sound/misc/portal_enter.ogg')
	active = FALSE
	releasedrain = 30
	chargetime = 10
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	charge_max = 15 SECONDS
