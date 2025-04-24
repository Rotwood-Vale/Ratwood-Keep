
/obj/item/bomb
	name = "bottle bomb"
	desc = "Dangerous explosion, in a bottle."
	icon_state = "clear_bomb"
	var/lit_state = "clear_bomb_lit"
	icon = 'icons/roguetown/items/cooking.dmi'
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	var/fuze = 50
	var/lit = FALSE
	var/prob2fail = 1 //23 was lunacy

/obj/item/bomb/spark_act()
	light()

/obj/item/bomb/fire_act()
	light()

/obj/item/bomb/ex_act()
	if(!QDELETED(src))
		lit = TRUE
		explode(TRUE)

/obj/item/bomb/proc/light()
	if(!lit)
		START_PROCESSING(SSfastprocess, src)
		icon_state = lit_state
		lit = TRUE
		playsound(src.loc, 'sound/items/firelight.ogg', 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/bomb/extinguish()
	snuff()

/obj/item/bomb/proc/snuff()
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
		icon_state = initial(icon_state)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/bomb/proc/explode(skipprob)
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(T)
		if(lit)
			if(!skipprob && prob(prob2fail))
				snuff()
			else
				explosion(T, light_impact_range = 1, hotspot_range = 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
				qdel(src)

		else
			if(prob(prob2fail))
				snuff()
			else
				playsound(T, 'sound/items/firesnuff.ogg', 100)
				new /obj/item/shard (T)
				qdel(src)

/obj/item/bomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	explode()

/obj/item/bomb/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/smokebomb
	name = "Smoke bomb"
	desc = "Harmless smoke explosion, in a shell."
	icon_state = "bomb_smoke"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 0.5

/obj/item/smokebomb/proc/explodes(skipprob)
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	playsound(T, 'sound/misc/explode/incendiary (1).ogg', 100)
	for(T in view(1, T))
		new/obj/effect/particle_effect/smoke(T)
	qdel(src)

/obj/item/smokebomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	explodes()
/obj/item/smokebomb/attack_self(mob/user)
	..()
	explodes()


/obj/item/tntstick
	name = "Blackpowder stick"
	desc = "A bit of gunpowder in paper shell..."
	icon_state = "tnt_stick"
	var/lit_state = "tnt_stick-lit"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	var/fuze = 5 SECONDS
	var/lit = FALSE
	var/prob2fail = 1

/obj/item/tntstick/spark_act()
	light()

/obj/item/tntstick/fire_act()
	light()

/obj/item/tntstick/ex_act()
	if(!QDELETED(src))
		lit = TRUE
		explode(TRUE)

/obj/item/tntstick/proc/light()
	if(!lit)
		START_PROCESSING(SSfastprocess, src)
		icon_state = lit_state
		lit = TRUE
		playsound(src.loc, 'sound/items/firelight.ogg', 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()
/obj/item/tntstick/attack_self(mob/user)
	..()
	extinguish()

/obj/item/tntstick/extinguish()
	snuff()

/obj/item/tntstick/proc/snuff()
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
		icon_state = initial(icon_state)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/tntstick/proc/explode(skipprob)
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(T)
		if(lit)
			if(!skipprob && prob(prob2fail))
				snuff()
			else
				explosion(T, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 4, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))

				qdel(src) //go into walls /turf/closed/wall/ and see /turf/closed/wall/ex_act. Its bounded with /proc/explosion
		else
			if(prob(prob2fail))
				snuff()

/obj/item/tntstick/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/satchel_bomb
	name = "Bomb satchel"
	desc = "A satchel full of gunpowder..."
	icon_state = "satchel_bomb"
	var/lit_state = "satchel_bomb-lit"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 0
	throw_range = 2
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.3
	var/fuze = 10 SECONDS
	var/lit = FALSE
	var/prob2fail = 1

/obj/item/satchel_bomb/spark_act()
	light()

/obj/item/satchel_bomb/fire_act()
	light()

/obj/item/satchel_bomb/ex_act()
    if(!QDELETED(src))
        lit = TRUE
        explode(TRUE)

/obj/item/satchel_bomb/proc/light()
	if(!lit)
		START_PROCESSING(SSfastprocess, src)
		icon_state = lit_state
		lit = TRUE
		playsound(src.loc, 'sound/items/firelight.ogg', 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/satchel_bomb/attack_self(mob/user)
	..()
	extinguish()

/obj/item/satchel_bomb/extinguish()
	snuff()

/obj/item/satchel_bomb/proc/snuff()
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
		icon_state = initial(icon_state)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/satchel_bomb/proc/explode(skipprob)
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(T)
		if(lit)
			if(!skipprob && prob(prob2fail))
				snuff()
			else
				explosion(T, devastation_range = 3, light_impact_range = 10, hotspot_range = 1, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))

				qdel(src)

		else
			if(prob(prob2fail))
				snuff()

/obj/item/satchel_bomb/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)


/obj/item/impact_grenade
	name = "Impact grenade"
	desc = "Some substance, hidden under paper"
	icon_state = "impact_grenade"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 1

	// Define a base explodes() proc that subtypes can override because its now explodes proc
	proc/explodes()
		STOP_PROCESSING(SSfastprocess, src)
		qdel(src) // Delete the grenade after use boy (ALWAYS USE IT)

/obj/item/impact_grenade/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	explodes() //

/obj/item/impact_grenade/attack_self(mob/user)
	..()
	explodes()

/obj/item/impact_grenade/explosion
	name = "Impact grenade"
	desc = "Some substance, hidden under some paper and skin. This one sparks..."

	explodes()
		STOP_PROCESSING(SSfastprocess, src)
		var/turf/T = get_turf(src)
		if(T)
			explosion(T, heavy_impact_range = 0, light_impact_range = 2, hotspot_range = 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
			qdel(src)

/obj/item/impact_grenade/smoke
	name = "Impact grenade"
	desc = "Some substance, hidden under some paper and skin. This one emits clouds of harmless smoke..."

	explodes()
		STOP_PROCESSING(SSfastprocess, src)
		var/turf/T = get_turf(src)
		playsound(T, 'sound/misc/explode/incendiary (1).ogg', 100)
		for(T in view(2, T))
			new /obj/effect/particle_effect/smoke(T)
		qdel(src)

/obj/item/impact_grenade/poison_gas
	name = "Impact grenade"
	desc = "Some substance, hidden under some paper and skin. The smell of this one makes you to gasp..."

	explodes()
		STOP_PROCESSING(SSfastprocess, src)
		var/turf/T = get_turf(src)
		playsound(T, 'sound/misc/explode/incendiary (1).ogg', 100)
		for(T in view(2, T))
			new /obj/effect/particle_effect/smoke/poison_gas(T)
		qdel(src)

/obj/item/impact_grenade/healing_gas
	name = "Impact grenade"
	desc = "Some substance, hidden under some paper and skin. The smell of this one reminds you the taste of red..."

	explodes()
		STOP_PROCESSING(SSfastprocess, src)
		var/turf/T = get_turf(src)
		playsound(T, 'sound/misc/explode/incendiary (1).ogg', 100)
		for(T in view(2, T))
			new /obj/effect/particle_effect/smoke/healing_gas(T)
		qdel(src)

/obj/item/impact_grenade/fire_gas
	name = "Impact grenade"
	desc = "Some substance, hidden under some paper and skin. Smells like a chicken and burns your hand..."

	explodes()
		STOP_PROCESSING(SSfastprocess, src)
		var/turf/T = get_turf(src)
		playsound(T, 'sound/misc/explode/incendiary (1).ogg', 100)
		for(T in view(2, T))
			new /obj/effect/particle_effect/smoke/fire_gas(T)
		qdel(src)

/obj/item/impact_grenade/blind_gas
	name = "Impact grenade"
	desc = "Some substance, hidden under some paper and skin. The smell that comes from this one makes your eyes to cry."

	explodes()
		STOP_PROCESSING(SSfastprocess, src)
		var/turf/T = get_turf(src)
		playsound(T, 'sound/misc/explode/incendiary (1).ogg', 100)
		for(T in view(2, T))
			new /obj/effect/particle_effect/smoke/blind_gas(T)
		qdel(src)

/obj/item/impact_grenade/mute_gas
	name = "Impact grenade"
	desc = "Some substance, hidden under some paper and skin. Smell of this one makes your mind clean and not able to say a word."

	explodes()
		STOP_PROCESSING(SSfastprocess, src)
		var/turf/T = get_turf(src)
		playsound(T, 'sound/misc/explode/incendiary (1).ogg', 100)
		for(T in view(2, T))
			new /obj/effect/particle_effect/smoke/mute_gas(T)
		qdel(src)