
/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt
	name = "Bolt of Lightning"
	desc = ""
	clothes_req = FALSE
	overlay_state = "lightning"
	sound = 'sound/magic/lightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/lightning
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1
	xp_gain = TRUE

/obj/projectile/magic/lightning
	name = "bolt of lightning"
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	light_color = LIGHT_COLOR_WHITE
	damage = 15
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#ffffff"
	light_range = 7

/obj/projectile/magic/lightning/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			L.electrocute_act(1, src)
	qdel(src)
/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt/god
	name = "Bolt of Lightning"
	desc = ""
	clothes_req = FALSE
	overlay_state = "lightning"
	sound = 'sound/magic/lightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/lightning/god
	releasedrain = 0
	chargedrain = 0
	chargetime = 0
	charge_max = 0 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 0
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane

/obj/projectile/magic/lightning/god
	name = "bolt of lightning"
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	light_color = LIGHT_COLOR_WHITE
	damage = 10
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#ffffff"
	light_range = 7

/obj/projectile/magic/lightning/god/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			L.electrocute_act(1, src)
	qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/bloodlightning
	name = "Blood Bolt"
	desc = ""
	clothes_req = FALSE
	overlay_state = "bloodlightning"
	sound = 'sound/magic/vlightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/bloodlightning
	releasedrain = 30
	chargedrain = 1
	chargetime = 25
	charge_max = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood

/obj/projectile/magic/bloodlightning
	name = "blood bolt"
	tracer_type = /obj/effect/projectile/tracer/blood
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	damage = 35
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#802121"
	light_range = 7

/obj/projectile/magic/bloodlightning/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			L.electrocute_act(1, src)
	qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/bloodsteal
	name = "Blood Steal"
	desc = ""
	clothes_req = FALSE
	overlay_state = "bloodsteal"
	sound = 'sound/magic/vlightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/bloodsteal
	releasedrain = 30
	chargedrain = 1
	chargetime = 25
	charge_max = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood

/obj/projectile/magic/bloodsteal
	name = "blood steal"
	tracer_type = /obj/effect/projectile/tracer/bloodsteal
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	damage = 25
	damage_type = BRUTE
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#e74141"
	light_range = 7
	var/mob/living/carbon/human/sender

/obj/projectile/magic/bloodsteal/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/datum/antagonist/vampirelord/VDrinker = sender.mind.has_antag_datum(/datum/antagonist/vampirelord)
			H.blood_volume = max(H.blood_volume-45, 0)
			H.handle_blood()
			H.visible_message(span_danger("[target] has their blood ripped from their body!!"), \
					span_userdanger("My blood erupts from my body!"), \
					span_hear("..."), COMBAT_MESSAGE_RANGE, target)
			new /obj/effect/decal/cleanable/blood/puddle(H.loc)
			VDrinker.handle_vitae(400)						
	qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/fireball
	name = "Fireball"
	desc = ""
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue
	overlay_state = "fireball"
	sound = list('sound/magic/fireball.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2
	xp_gain = TRUE

/obj/projectile/magic/aoe/fireball/rogue
	name = "fireball"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 0
	exp_fire = 1
	damage = 10
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	aoe_range = 0


/obj/projectile/magic/aoe/fireball/rogue/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK



/obj/effect/proc_holder/spell/invoked/projectile/fireball/greater
	name = "Greater Fireball"
	desc = ""
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue/great
	overlay_state = "fireball_wide"
	sound = list('sound/magic/fireball.ogg')
	active = FALSE
	releasedrain = 50
	chargedrain = 1
	chargetime = 15
	charge_max = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokegen
	cost = 5
	xp_gain = TRUE

/obj/projectile/magic/aoe/fireball/rogue/great
	name = "fireball"
	exp_heavy = 0
	exp_light = 1
	exp_flash = 2
	exp_fire = 2
	flag = "magic"


/obj/effect/proc_holder/spell/invoked/projectile/spitfire
	name = "Fire Bolt"
	desc = ""
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue2
	overlay_state = "fireball_multi"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 3 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2
	xp_gain = TRUE

/obj/projectile/magic/aoe/fireball/rogue2
	name = "fireball"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 1
	exp_fire = -1
	damage = 20
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	aoe_range = 0

/obj/effect/proc_holder/spell/invoked/projectile/godfire //event only, admin only
	name = "godfire"
	desc = ""
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue3
	overlay_state = "fireball"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	releasedrain = 0
	chargedrain = 0
	chargetime = 0
	charge_max = 0 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 0
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane

/obj/projectile/magic/aoe/fireball/rogue3
	name = "fireball"
	exp_heavy = 0
	exp_light = 1
	exp_flash = 1
	exp_fire = -1
	damage = 20
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	aoe_range = 0

/obj/effect/proc_holder/spell/invoked/projectile/fetch
	name = "Fetch"
	desc = ""
	clothes_req = FALSE
	range = 15
	projectile_type = /obj/projectile/magic/fetch
	overlay_state = ""
	sound = list('sound/magic/magnet.ogg')
	active = FALSE
	releasedrain = 5
	chargedrain = 0
	chargetime = 0
	warnie = "spellwarning"
	overlay_state = "fetch"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1
	xp_gain = TRUE

/obj/projectile/magic/fetch/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[target] repells the fetch!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK

/obj/effect/proc_holder/spell/targeted/conjure_item/summon_sword
	name = "Summon Sword"
	desc = ""
	invocation_type = "none"
	include_user = TRUE
	range = -1
	clothes_req = FALSE
	item_type = /obj/item/rogueweapon/sword/energy_katana

	school = "conjuration"
	charge_max = 0
	cooldown_min = 0
	action_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	action_icon_state = "graggarsword"
	action_background_icon_state = "bg_demon"
	invocation = "Let's finish this."
	invocation_type = "shout"


/obj/effect/proc_holder/spell/invoked/Disappear
	name = "Disappear"
	overlay_state = "Smoke Bomb"
	releasedrain = 0
	chargedrain = 0
	chargetime = 0
	charge_max = 0 SECONDS
	range = 0
	warnie = "sydwarning"
	movement_interrupt = FALSE
	invocation = "You won't be missed."
	invocation_type = "shout"
	sound = 'sound/misc/area.ogg'
	associated_skill = /datum/skill/magic/arcane
/obj/effect/proc_holder/spell/invoked/Disappear/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message(span_warning("[target] loses shape, almost becoming non-existent!"), span_notice("You feel your very existence being ripped from this world!"))
		animate(target, alpha = 60, time = 1 SECONDS, easing = EASE_IN)
		target.mob_timers[MT_INVISIBILITY] = world.time + 20 SECONDS
		addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 20 SECONDS)
		addtimer(CALLBACK(target, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[target] fades back into view."), span_notice("You regain your bearings once more.")), 20 SECONDS)
	return FALSE
