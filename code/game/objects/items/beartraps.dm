//Legcuffs

/obj/item/restraints/legcuffs
	name = "leg cuffs"
	desc = ""
	gender = PLURAL
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "handcuff"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	flags_1 = CONDUCT_1
	throwforce = 0
	w_class = WEIGHT_CLASS_NORMAL
	slowdown = 7
	breakouttime = 30 SECONDS

/obj/item/restraints/legcuffs/beartrap
	icon = 'icons/roguetown/items/misc.dmi'
	name = "mantrap"
	gender = NEUTER
	throw_speed = 1
	throw_range = 1
	icon_state = "beartrap"
	desc = ""
	var/armed = 0
	var/trap_damage = 90
	embedding = list("embedded_unsafe_removal_time" = 40, "embedded_pain_chance" = 10, "embedded_pain_multiplier" = 1, "embed_chance" = 0, "embedded_fall_chance" = 0)
	max_integrity = 100

/obj/item/restraints/legcuffs/beartrap/attack_hand(mob/user)
	if(iscarbon(user) && armed && isturf(loc))
		var/mob/living/carbon/C = user
		var/def_zone = "[(C.active_hand_index == 2) ? "r" : "l" ]_arm"
		var/obj/item/bodypart/BP = C.get_bodypart(def_zone)
		if(!BP)
			return FALSE
		if(C.badluck(5))
			add_mob_blood(C)
			if(!BP.is_object_embedded(src))
				BP.add_embedded_object(src)
			close_trap()
			C.visible_message(span_boldwarning("[C] triggers \the [src]."), \
					span_userdanger("I trigger \the [src]!"))
			C.emote("agony")
			C.Stun(80)
			BP.add_wound(/datum/wound/fracture)
			BP.update_disabled()
			C.apply_damage(trap_damage, BRUTE, def_zone)
			C.update_sneak_invis(TRUE)
			C.consider_ambush()
			return FALSE
		else
			var/used_time = 10 SECONDS
			if(C.mind)
				used_time -= max((C.mind.get_skill_level(/datum/skill/craft/hunting) * 2 SECONDS), 2 SECONDS)
			if(do_after(user, used_time, target = src))
				armed = FALSE
				w_class = WEIGHT_CLASS_NORMAL
				update_icon()
				alpha = 255
				C.visible_message(span_notice("[C] disarms \the [src]."), \
						span_notice("I disarm \the [src]."))
				return FALSE
			else
				add_mob_blood(C)
				if(!BP.is_object_embedded(src))
					BP.add_embedded_object(src)
				close_trap()
				C.visible_message(span_boldwarning("[C] triggers \the [src]."), \
						span_userdanger("I trigger \the [src]!"))
				C.emote("agony")
				BP.add_wound(/datum/wound/fracture)
				BP.update_disabled()
				C.apply_damage(trap_damage, BRUTE, def_zone)
				C.update_sneak_invis(TRUE)
				C.consider_ambush()
				return FALSE
	..()

/obj/item/restraints/legcuffs/beartrap/attackby(obj/item/W, mob/user)
	if(W.force && armed)
		user.visible_message(span_warning("[user] triggers \the [src] with [W]."), \
				span_danger("I trigger \the [src] with [W]!"))
		W.take_damage(20)
		close_trap()
		if(isliving(user))
			var/mob/living/L = user
			L.update_sneak_invis(TRUE)
			L.consider_ambush()
		return
	..()

/obj/item/restraints/legcuffs/beartrap/armed
	armed = TRUE

/obj/item/restraints/legcuffs/beartrap/armed/camouflage
	armed = TRUE
	alpha = 80

/obj/item/restraints/legcuffs/beartrap/Initialize()
	. = ..()
	update_icon()

/obj/item/restraints/legcuffs/beartrap/update_icon()
	. = ..()
	icon_state = "[initial(icon_state)][armed]"

/obj/item/restraints/legcuffs/beartrap/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is sticking [user.p_their()] head in the [src.name]! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(loc, 'sound/blank.ogg', 50, TRUE, -1)
	return (BRUTELOSS)

/obj/item/restraints/legcuffs/beartrap/attack_self(mob/user)
	..()
	if(ishuman(user) && !user.stat && !user.restrained())
		var/mob/living/L = user
		if(do_after(user, 50 - (L.STASTR*2), target = user))
			if(prob(50))
				armed = !armed
				update_icon()
				if(armed == TRUE)
					w_class = WEIGHT_CLASS_BULKY
				else
					w_class = WEIGHT_CLASS_NORMAL
				to_chat(user, span_notice("[src] is now [armed ? "armed" : "disarmed"]"))
			else
				user.visible_message(span_warning("You couldn't get the shoddy [src.name] [armed ? "shut close!" : "to open up!"]"))
/obj/item/restraints/legcuffs/beartrap/proc/close_trap()
	armed = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	alpha = 255
	update_icon()
	playsound(src.loc, 'sound/items/beartrap.ogg', 300, TRUE, -1)

/obj/item/restraints/legcuffs/beartrap/Crossed(AM as mob|obj)
	if(armed && isturf(loc))
		if(isliving(AM))
			var/mob/living/L = AM
			var/snap = TRUE
			if(istype(L.buckled, /obj/vehicle))
				var/obj/vehicle/ridden_vehicle = L.buckled
				if(!ridden_vehicle.are_legs_exposed) //close the trap without injuring/trapping the rider if their legs are inside the vehicle at all times.
					close_trap()
					ridden_vehicle.visible_message(span_danger("[ridden_vehicle] triggers \the [src]."))
					return ..()
			if(L.throwing)
				return ..()

			if(L.movement_type & (FLYING|FLOATING)) //don't close the trap if they're flying/floating over it.
				return ..()

			var/def_zone = BODY_ZONE_CHEST
			if(snap && iscarbon(L))
				var/mob/living/carbon/C = L
				if(C.mobility_flags & MOBILITY_STAND)
					def_zone = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
					var/obj/item/bodypart/BP = C.get_bodypart(def_zone)
					if(BP)
						add_mob_blood(C)
						if(!BP.is_object_embedded(src))
							BP.add_embedded_object(src)
						C.emote("agony")
						//BP.set_disabled(BODYPART_DISABLED_WOUND)
						//BP.add_wound(/datum/wound/fracture)
			else if(snap && isanimal(L))
				var/mob/living/simple_animal/SA = L
				if(SA.mob_size <= MOB_SIZE_TINY) //don't close the trap if they're as small as a mouse.
					snap = FALSE
			if(snap)
				close_trap()
				L.visible_message(span_danger("[L] triggers \the [src]."), \
						span_danger("I trigger \the [src]!"))
				L.apply_damage(trap_damage, BRUTE, def_zone)
				L.Stun(80)
				L.consider_ambush()
	..()
