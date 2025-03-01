/obj/effect/proc_holder/spell
	var/fears_mount = FALSE // активация спелла пугает маунта

/obj/effect/proc_holder/spell/invoked/projectile
	fears_mount = TRUE

/obj/effect/proc_holder/spell/proc/mount_fear_check(mob/living/user)
	return FALSE

/obj/effect/proc_holder/spell/invoked/projectile/mount_fear_check(mob/living/user)
	if(!user.buckled)
		return FALSE
	if(isliving(user.buckled))
		var/mob/living/buckle_mob = user.buckled
		if(buckle_mob.mind)
			return FALSE // игрок-маунт не знает страха
		var/datum/component/riding/riding_component = buckle_mob.GetComponent(/datum/component/riding)
		if(riding_component.violently_drop_rider(src, user))
			user.visible_message(span_warning("[user] feared [user.gender == MALE ? "his" : "her"] mount!"), span_warning("My mount was feared by my powers! OUCH!"))
		return TRUE

/datum/component/riding/proc/violently_drop_rider(datum/source, mob/living/user, forced = FALSE)
	if(!ishostile(parent))
		return FALSE
	var/mob/living/simple_animal/hostile/buckle_mob = parent

	buckle_mob.get_sound("pain")
	force_dismount(user)

	user.set_resting(TRUE, TRUE)
	var/obj/item/bodypart/damaged_during_falling = user.get_bodypart(pick(BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
	if(user.badluck(5))
		to_chat(user, span_warningbig("UNLUCKY FALLING! OH [uppertext(user.patron.name)]!!"))
		if(damaged_during_falling == BODY_ZONE_PRECISE_GROIN)
			damaged_during_falling.add_wound(/datum/wound/fracture/groin)
		else
			damaged_during_falling.add_wound(/datum/wound/fracture)
	user.apply_damage(50, BRUTE, damaged_during_falling)
	user.emote("scream")
	return TRUE
