#define GLORY_KILL_COLOR "#00FFFF"

/datum/component/glory_kill
	/// Is this ready to be glory killed
	var/ready = FALSE
	/// WHAT THE FUCK ARE THE MESSAGES SAID BY THIS FUCK WHEN HE'S GLORY KILLED WITH AN EMPTY HAND?
	var/list/messages_unarmed
	/// SAME AS ABOVE BUT CRUSHER
	var/list/messages_crusher
	/// SAME AS ABOVE THE ABOVE BUT PKA
	var/list/messages_pka
	/// SAME AS ABOVE BUT WITH A HONKING KNIFE ON THE FUCKING THING
	var/list/messages_pka_bayonet
	/// Health to give to our executioner
	var/health_given = 200
	/// With how much health our sate shall be sealed
	var/threshold = 100
	/// Multiply crusher drop chance by (only for asteroid mobs)
	var/crusher_drop_mod = 1

/datum/component/glory_kill/Initialize(messages_unarmed, messages_pka, messages_pka_bayonet, messages_crusher, health_given, threshold, crusher_drop_mod)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	if(messages_unarmed)
		src.messages_unarmed = messages_unarmed
	if(messages_pka)
		src.messages_pka = messages_pka
	if(messages_pka_bayonet)
		src.messages_pka_bayonet = messages_pka_bayonet
	if(messages_crusher)
		src.messages_crusher = messages_crusher
	if(health_given)
		src.health_given = health_given
	if(threshold)
		src.threshold = threshold
	if(crusher_drop_mod)
		src.crusher_drop_mod = crusher_drop_mod

	return ..()

/datum/component/glory_kill/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_CLICK_ALT, PROC_REF(glory_kill))
/*	RegisterSignal(parent, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(health_modified)) */
	RegisterSignal(parent, COMSIG_MOB_DEATH, PROC_REF(on_death))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(examined))

/datum/component/glory_kill/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_CLICK_ALT,/* COMSIG_MOB_APPLY_DAMAGE*/, COMSIG_MOB_DEATH, COMSIG_MOB_EXAMINATE))
	. = ..()

/datum/component/glory_kill/proc/health_modified(mob/living/owner, damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness)
	if(((owner.health - damage) <= threshold) && !ready && (owner.stat != DEAD))
		glory(owner)
	else if(ready)
		unglory(owner)

/datum/component/glory_kill/proc/glory(mob/living/owner)
	ready = TRUE
	owner.add_atom_colour(GLORY_KILL_COLOR, TEMPORARY_COLOUR_PRIORITY)

/datum/component/glory_kill/proc/unglory(mob/living/owner)
	ready = FALSE
	owner.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, GLORY_KILL_COLOR)

/datum/component/glory_kill/proc/glory_kill(mob/living/owner, mob/living/slayer)
	if(!ready)
		return
	if(!slayer.canUseTopic(owner, TRUE))
		return
	/// Let's give our slayer a chance (totally not abusable by spamming alt-click)
	if(istype(owner, /mob/living/simple_animal/hostile))
		var/mob/living/simple_animal/hostile/hostile = owner
		if(hostile.ranged)
			if(hostile.ranged_cooldown >= world.time)
				hostile.ranged_cooldown += 10
			else
				hostile.ranged_cooldown = 10 + world.time
	if(do_mob(slayer, owner, 1 SECONDS) && (owner.stat != DEAD))
		var/message
		if(!slayer.get_active_held_item() || (!istype(slayer.get_active_held_item(), /obj/item/twohanded/kinetic_crusher) && !istype(slayer.get_active_held_item(), /obj/item/gun/energy/kinetic_accelerator)))
			message = pick(messages_unarmed)
		else if(istype(slayer.get_active_held_item(), /obj/item/twohanded/kinetic_crusher))
			message = pick(messages_crusher)
		else if(istype(slayer.get_active_held_item(), /obj/item/gun/energy/kinetic_accelerator))
			message = pick(messages_pka)
			var/obj/item/gun/energy/kinetic_accelerator/KA = slayer.get_active_held_item()
			if(KA && KA.bayonet)
				message = pick(messages_pka | messages_pka_bayonet)
		if(message)
			owner.visible_message(span_danger("<b>[slayer] [message]</b>"))
		else
			owner.visible_message(span_danger("<b>[slayer] does something generally considered brutal to [owner]... Whatever that may be!</b>"))
		if(istype(owner, /mob/living/simple_animal/hostile/retaliate/rogue/asteroid))
			var/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/asteroid = owner
		/*	playsound(asteroid.loc, asteroid.death_sound, 150, TRUE, -1) */
			asteroid.crusher_drop_mod *= crusher_drop_mod
		if(istype(owner, /mob/living/simple_animal))
			var/mob/living/simple_animal/simple = owner
			simple.adjustHealth(simple.maxHealth, TRUE, TRUE)
		if(owner.mob_biotypes & MOB_ORGANIC)
			new /obj/effect/gibspawner/generic(owner.loc)
		else if(owner.mob_biotypes & MOB_ROBOTIC)
			new /obj/effect/gibspawner/robot(owner.loc)
		slayer.heal_overall_damage(health_given, health_given)
	else
		to_chat(slayer, span_danger("You fail to glory kill [owner]!"))

/datum/component/glory_kill/proc/examined(mob/living/owner, mob/living/user, list/examine_list)
	if(ready)
		examine_list += "<b>[owner] is staggered and can be <font color='[GLORY_KILL_COLOR]'>glory killed</font>!</b>"

/datum/component/glory_kill/proc/on_death(mob/living/owner, gibbed)
	if(gibbed)
		qdel(src)
		return
	unglory(owner)

#undef GLORY_KILL_COLOR
