/datum/action/cooldown/mob_cooldown/lay_chicken_egg
	name = "Lay Egg"
	button_icon = 'icons/obj/magic.dmi'
	button_icon_state = "fireball"
	desc = "Lays... a chicken egg..."
	cooldown_time = 30 SECONDS
	/// The range of the fire

	/// The sound played when you use this ability
	//var/fire_sound = 'sound/magic/fireball.ogg'
	/// Time to wait between spawning each fire turf

	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')


/datum/action/cooldown/mob_cooldown/lay_chicken_egg/Activate(atom/target_atom)
	disable_cooldown_actions()
	attack_sequence(target_atom)
	StartCooldown()
	enable_cooldown_actions()
	return TRUE


/*
		if(locate(/obj/structure/fluff/nest) in loc)
			visible_message(span_alertalien("[src] [pick(layMessage)]"))
			production = max(production - 30, 0)
			var/obj/item/reagent_containers/food/snacks/egg/E = new egg_type(get_turf(src))
			E.pixel_x = rand(-6,6)
			E.pixel_y = rand(-6,6)
			if(eggsFertile)
				if(chicken_count < MAX_CHICKENS && prob(50))
					E.fertile = TRUE
					*/
