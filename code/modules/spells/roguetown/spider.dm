// Spider spells/abilities
// A natural variant of the conjure_web spell.
/obj/effect/proc_holder/spell/self/spin_web
	name = "Spin Web"
	desc = "Spin webs where you stand"
	range = -1
	overlay_state = "null"
	releasedrain = 10
	charge_max = 3 SECONDS
	sound = 'sound/blank.ogg'
	invocation = null
	invocation_type = "none" //can be none, whisper, emote and shout
	antimagic_allowed = TRUE

/obj/effect/proc_holder/spell/self/spin_web/cast(list/targets,mob/user = usr)
	. = ..()
	if(isopenturf(user.loc))
		var/turf/open/T = user.loc
		var/foundsurface
		for(var/X in GLOB.cardinals)
			var/turf/TU = get_step(T, X)
			if(TU && (isclosedturf(TU) || locate(/obj/structure/spider/stickyweb) in TU))
				foundsurface = TRUE
				break
		if(foundsurface)
			if(!locate(/obj/structure/spider/stickyweb) in T)
				new /obj/structure/spider/stickyweb(T)
				return TRUE
		to_chat(user, span_warning("It is too open or there are no adjacent webs for me to use."))
		return FALSE
	to_chat(user, span_warning("I cannot spin webs on closed space."))
	return FALSE

/obj/effect/proc_holder/spell/invoked/conjure_web
	name = "Conjure Web"
	desc = "Conjure webs where you point"
	range = 3
	overlay_state = "null"
	releasedrain = 30
	charge_max = 20 SECONDS
	sound = 'sound/magic/webspin.ogg'
	invocation = null
	invocation_type = "none" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/conjure_web/cast(list/targets,mob/user = usr)
	. = ..()
	var/turf/T = get_turf(targets[1])
	if(isopenturf(T))
		var/foundsurface
		for(var/X in GLOB.cardinals)
			var/turf/TU = get_step(T, X)
			if(TU && (isclosedturf(TU) || locate(/obj/structure/spider/stickyweb) in TU))
				foundsurface = TRUE
				break
		if(foundsurface)
			if(!locate(/obj/structure/spider/stickyweb) in T)
				new /obj/structure/spider/stickyweb(T)
				return TRUE
		to_chat(user, span_warning("It is too open or there are no adjacent webs for me to use."))
		return FALSE
	to_chat(user, span_warning("I cannot conjure webs on closed space."))
	return FALSE

/obj/effect/proc_holder/spell/invoked/summon_spider
	name = "Summon Spider"
	desc = "Summons forth a spider"
	range = 3
	overlay_state = "null"
	releasedrain = 60
	charge_max = 320 SECONDS
	chargetime = 60
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	movement_interrupt = FALSE
	sound = list('sound/magic/magnet.ogg') //same as raise_undead for familiarity.
	chargedloop = /datum/looping_sound/invokegen
	invocation = "Come forth, fresh prey awaits beyond your webs!"
	invocation_type = "whisper" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/summon_spider/cast(list/targets,mob/user = usr)
	. = ..()
	var/turf/T = get_turf(targets[1])
	if(isopenturf(T))
		if(prob(35))
			new /mob/living/simple_animal/hostile/retaliate/rogue/spider(T)
		else
			new /mob/living/simple_animal/hostile/retaliate/rogue/spider/mutated(T)
		return TRUE
	to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
	return FALSE

/obj/effect/proc_holder/spell/invoked/web_walk
	name = "Web Walk"
	desc = "Grants the target the ability to walk on webs"
	selection_type = "range"
	range = 5
	overlay_state = "null"
	releasedrain = 30
	chargedrain = 0
	charge_max = 10 SECONDS
	movement_interrupt = FALSE
	sound = 'sound/magic/webspin.ogg' //could use a new sound for this
	invocation = null
	invocation_type = "whisper" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/web_walk/cast(list/targets,mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			to_chat(user, "<span class='red'>I cannot grant this boon on those warded against magic and spells!</span>")
			return FALSE
		if(prob(10))
			target.visible_message(span_warning("The light dims around [target], for just a moment."), span_warning("You feel an uncomfortable presence staring at you, and then leave."))
			target.Stun(rand(10))
			target.add_stress(/datum/stressevent/spiderspell)
		if(target.has_status_effect(/datum/status_effect/buff/web_walk))
			to_chat(user, "<span class='red'>My target is already one with the web.</span>")
			return TRUE
		target.apply_status_effect(/datum/status_effect/buff/web_walk)
		if(!HAS_TRAIT(target, TRAIT_WEBWALK))
			ADD_TRAIT(target, TRAIT_WEBWALK, TRAIT_GENERIC)
			addtimer(CALLBACK(target, PROC_REF(remove_webwalk), target, TRAIT_WEBWALK, TRAIT_GENERIC), 60 SECONDS)
		invocation = "Walk amongst the webs and let us chase our foes."
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/web_walk/proc/remove_webwalk(mob/living/target, trait, source)
	REMOVE_TRAIT(target, trait, source)

/datum/status_effect/buff/web_walk
	id = "web walk"
	alert_type = /atom/movable/screen/alert/status_effect/buff/web_walk
	effectedstats = list("speed" = 2)
	duration = 60 SECONDS

/atom/movable/screen/alert/status_effect/buff/web_walk
	name = "Web Walk"
	desc = "I feel slightly faster and can move freely on the webs of spiders."
	icon_state = "buff"

/datum/status_effect/buff/web_walk/on_apply()
	. = ..()
	to_chat(owner, "<span class='green'>I feel slightly faster and more familiar with the webs of spiders.</span>")

// Flavor stressevent for low-odd spell 'failures'.
/datum/stressevent/spiderspell
	timer = 3 MINUTES
	stressadd = 5
	desc = "<span class='red'>I felt something unnatural watching me.</span>"