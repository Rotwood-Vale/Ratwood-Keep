/obj/item/needle
	name = "needle"
	icon_state = "needle"
	desc = "This sharp needle can sew wounds, cloth and can be used for self defence if you're crazy."
	icon = 'icons/roguetown/items/misc.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	force = 0
	throwforce = 0
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	anvilrepair = /datum/skill/craft/blacksmithing
	tool_behaviour = TOOL_SUTURE
	/// Amount of uses left
	var/stringamt = 20
	var/maxstring = 20
	/// If this needle is infinite
	var/infinite = FALSE
	/// If this needle can be used to repair items
	var/can_repair = TRUE

/obj/item/needle/examine()
	. = ..()
	if(!infinite)
		if(stringamt > 0)
			. += span_bold("It has [stringamt] uses left.")
		else
			. += span_bold("It has no uses left.")
	else
		. += "Can be used indefinitely."

/obj/item/needle/Initialize()
	. = ..()
	update_icon()

/obj/item/needle/update_overlays()
	. = ..()
	if(stringamt <= 0)
		return
	. += "[icon_state]string"

/obj/item/needle/use(used)
	if(infinite)
		return TRUE
	stringamt = stringamt - used
//	if(stringamt <= 0)
//		qdel(src)

/obj/item/needle/attack(mob/living/M, mob/user)
	sew(M, user)

/obj/item/needle/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/natural/fibers))
		if(maxstring - stringamt < 5)
			to_chat(user, span_warning("Not enough room for more thread!"))
			return
		else
			to_chat(user, "I begin threading the needle with additional fibers...")
			if(do_after(user, 6 SECONDS - user.mind.get_skill_level(/datum/skill/misc/sewing), target = I))
				stringamt += 5
				to_chat(user, "I replenish the needle's thread!")
				qdel(I)
			return
	return ..()



/obj/item/needle/attack_obj(obj/O, mob/living/user)
	var/obj/item/I = O
	if(can_repair)
		if(stringamt < 1)
			to_chat(user, span_warning("The needle has no thread left!"))
			return
		if(I.sewrepair && I.max_integrity)
			if(I.obj_integrity == I.max_integrity)
				to_chat(user, span_warning("This is not broken."))
				return
			if(user.mind.get_skill_level(/datum/skill/misc/sewing) < I.required_repair_skill)
				to_chat(user, span_warning("I don't know how to repair this..."))
				return
			if(!I.ontable())
				to_chat(user, span_warning("I should put this on a table first."))
				return
			playsound(loc, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
			var/sewtime = 70
			if(user.mind)
				sewtime = (70 - ((user.mind.get_skill_level(/datum/skill/misc/sewing)) * 10))
			var/datum/component/storage/target_storage = I.GetComponent(/datum/component/storage) //Vrell - Part of storage item repair fix
			if(do_after(user, sewtime, target = I))
				playsound(loc, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
				user.visible_message(span_info("[user] repairs [I]!"))
				if(I.obj_broken == TRUE)
					I.obj_broken = FALSE
				I.obj_integrity = I.max_integrity
				user.mind?.adjust_experience(/datum/skill/misc/sewing, user.STAINT, TRUE)

				//Vrell - Part of storage item repair fix
				if(target_storage)
					target_storage.being_repaired = FALSE
				return
			else
				//Vrell - Part of storage item repair fix
				if(target_storage)
					target_storage.being_repaired = FALSE
		return
	return ..()

/obj/item/needle/proc/sew(mob/living/target, mob/living/user)
	if(!istype(user))
		return FALSE
	var/mob/living/doctor = user
	var/mob/living/carbon/human/patient = target
	var/boon = doctor?.mind?.get_learning_boon(/datum/skill/misc/medicine)
	if(stringamt < 1)
		to_chat(user, span_warning("The needle has no thread left!"))
		return
	if(!get_location_accessible(patient, check_zone(doctor.zone_selected)))
		to_chat(doctor, span_warning("Something in the way."))
		return FALSE
	var/list/sewable
	var/obj/item/bodypart/affecting
	if(iscarbon(patient))
		affecting = patient.get_bodypart(check_zone(doctor.zone_selected))
		if(!affecting)
			to_chat(doctor, span_warning("That limb is missing."))
			return FALSE
		if(affecting.bandage)
			to_chat(doctor, span_warning("There is a bandage in the way."))
			return FALSE
		sewable = affecting.get_sewable_wounds()
	else
		sewable = patient.get_sewable_wounds()
	if(!length(sewable))
		to_chat(doctor, span_warning("There aren't any wounds to be sewn."))
		return FALSE
	var/datum/wound/target_wound = input(doctor, "Which wound?", "[src]") as null|anything in sewable
	if(!target_wound)
		return FALSE

	var/moveup = 10
	if(doctor.mind)
		moveup = ((doctor.mind.get_skill_level(/datum/skill/misc/medicine)+1) * 5)
	while(!QDELETED(target_wound) && !QDELETED(src) && \
		!QDELETED(user) && (target_wound.sew_progress < target_wound.sew_threshold) && \
		stringamt >= 1)
		if(!do_after(doctor, 20, target = patient))
			break
		playsound(loc, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
		target_wound.sew_progress = min(target_wound.sew_progress + moveup, target_wound.sew_threshold)
		if(target_wound.sew_progress < target_wound.sew_threshold)
			continue
		if(doctor.mind)
			var/amt2raise = doctor.STAINT *5
			doctor.mind.adjust_experience(/datum/skill/misc/medicine, amt2raise * boon)
		use(1)
		target_wound.sew_wound()
		if(patient == doctor)
			doctor.visible_message(span_notice("[doctor] sews \a [target_wound.name] on [doctor.p_them()]self."), span_notice("I stitch \a [target_wound.name] on my [affecting]."))
		else
			if(affecting)
				doctor.visible_message(span_notice("[doctor] sews \a [target_wound.name] on [patient]'s [affecting]."), span_notice("I stitch \a [target_wound.name] on [patient]'s [affecting]."))
			else
				doctor.visible_message(span_notice("[doctor] sews \a [target_wound.name] on [patient]."), span_notice("I stitch \a [target_wound.name] on [patient]."))
		log_combat(doctor, patient, "sew", "needle")
		return TRUE
	return FALSE

/obj/item/needle/thorn
	name = "needle"
	icon_state = "thornneedle"
	desc = "This rough needle can be used to sew cloth and wounds."
	stringamt = 5
	maxstring = 5
	anvilrepair = null

/obj/item/needle/pestra
	name = "needle of pestra"
	desc = span_green("This needle has been blessed by the goddess of medicine herself!")
	infinite = TRUE
