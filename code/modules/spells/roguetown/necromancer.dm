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
	name = "Raise Undead"
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
	charge_max = 30 SECONDS

/obj/effect/proc_holder/spell/invoked/raise_undead/cast(list/targets, mob/living/carbon/human/user)
	. = ..()

	var/mob/living/carbon/target = targets[1]

	if(!target)
		to_chat(user, span_warning("I need to cast this spell on a corpse."))
		return FALSE

	if(isliving(target))
		to_chat(user, span_warning("I cannot raise the living."))
		return FALSE

	
	//Undead should be played by corpse's owner > random candidate > npc  in order of priority
	if(target.ckey)
		

	
	//Raise the corpse as a zombie or skeleton depending on the decay level


	// 	var/mob/living/carbon/target = new /mob/living/carbon/human/species/skeleton/npc(T)
	// 	user.minions += target
	// 	var/list/candidates = pollCandidatesForMob("Do you want to play as a Necromancer's skeleton?", null, null, null, 100, target, POLL_IGNORE_NECROMANCER_SKELETON)
	// 	if(LAZYLEN(candidates))
	// 		var/mob/C = pick(candidates)
	// 		if(istype(C,/mob/dead/new_player))
	// 			var/mob/dead/new_player/N = C
	// 			N.close_spawn_windows()
	// 		target.key = C.key
	// 		target.visible_message(span_warning("[target]'s eyes light up with an eerie glow!"))
	// 		target.mind.AddSpell(new /obj/effect/proc_holder/spell/self/suicidebomb/lesser)
	// 		target.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	// 		target.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	// 		target.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	// 		target.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	// 		target.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	// 		target.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	// 	else
	// 		target.visible_message(span_warning("[target]'s eyes remain dully devoid of life. The spell failed to capture a soul from the ether."))
	// 	return TRUE
	// to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
	// return FALSE

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

/obj/effect/proc_holder/spell/self/suicidebomb
	name = "Calcic Outburst"
	desc = "Explode in a wonderful blast of osseous shrapnel."
	overlay_state = "tragedy"
	chargedrain = 0
	chargetime = 0
	charge_max = 2 MINUTES
	sound = 'sound/magic/swap.ogg'
	warnie = "spellwarning"
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	stat_allowed = TRUE
	var/exp_heavy = 0
	var/exp_light = 2
	var/exp_flash = 3
	var/exp_fire = 0

/obj/effect/proc_holder/spell/self/suicidebomb/cast(list/targets, mob/living/user = usr)
	. = ..()
	if(!user)
		return
	if(alert(user, "Do you wish to sacrifice this vessel in a powerful explosion?", "ELDRITCH BLAST", "Yes", "No") == "No")
		return FALSE
	user.visible_message(span_danger("[user] begins to shake violently, a blindingly bright light beginning to emanate from them!"), span_danger("Powerful energy begins to expand outwards from inside me!"))

	user.Immobilize(50)
	user.Knockdown(50)

	var/turf/T = get_turf(user)
	sleep(5 SECONDS)

	var/datum/antagonist/lich/lichman = user.mind.has_antag_datum(/datum/antagonist/lich)
	if(lichman)
		lichman.consume_phylactery(0)
	else
		user.death()

	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = 'sound/misc/explode/incendiary (1).ogg')

	return TRUE

/obj/effect/proc_holder/spell/self/suicidebomb/lesser
	name = "Lesser Calcic Outburst"
	exp_heavy = 0
	exp_light = 1
	exp_flash = 2
	exp_fire = 0

/obj/effect/proc_holder/spell/self/command_undead
	name = "Command the Dead"
	desc = "!"
	overlay_state = "raiseskele"
	sound = list('sound/magic/magnet.ogg')
	invocation = "Zuth'gorash vel'thar dral'oth!"
	invocation_type = "shout"
	antimagic_allowed = TRUE
	charge_max = 15 SECONDS

/obj/effect/proc_holder/spell/self/command_undead/cast(mob/user = usr)
	..()
	var/message = input("Speak to your minions!", "LICH") as text|null
	if(!message) return

	var/mob/living/carbon/human/lich_player = user
	
	for(var/mob/player in lich_player.minions)
		if(player.mind)
			to_chat(player, span_boldannounce("Lich [lich_player.real_name] commands: [message]"))

