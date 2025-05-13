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
		if(infinite || maxstring - stringamt <= 0) //is the needle infinite OR does it have all of its uses left
			to_chat(user, span_warning("The needle has no need to be refilled."))
			return

		to_chat(user, "I begin threading the needle with additional fibers...")
		if(do_after(user, 6 SECONDS - user.mind.get_skill_level(/datum/skill/misc/sewing), target = I))
			var/refill_amount
			refill_amount = min(5, (maxstring - stringamt))
			stringamt += refill_amount
			to_chat(user, "I replenish the needle's thread by [refill_amount] uses!")
			qdel(I)
		return



/obj/item/needle/attack_obj(obj/O, mob/living/user)
	if(isnull(O))
		return
	var/obj/item/I = O
	if(can_repair)
		if(stringamt < 1)
			to_chat(user, span_warning("The needle has no thread left!"))
			return
		if(!I.sewrepair || !I.max_integrity)
			to_chat(user, span_warning("[I] can't be repaired!"))
			return
		if(I.sewrepair && I.max_integrity)
			if(I.obj_integrity == I.max_integrity)
				to_chat(user, span_warning("[I] is not damaged!"))
				return
			if(!I.ontable())
				to_chat(user, span_warning("I should put this on a table first."))
				return
			var/armor_value = 0
			var/skill_level = user.mind.get_skill_level(/datum/skill/misc/sewing)
			var/armor_list = I.armor.getList()
			for(var/key in armor_list) // Here we are checking if the armor value of the item is 0 so we can know if the item is armor without having to make a snowflake var
				armor_value += armor_list[key]
			if((armor_value == 0 && skill_level < 1) || (armor_value > 0 && skill_level < 2))
				to_chat(user, span_warning("I should probably not be doing this..."))
			playsound(loc, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
			var/skill_multiplied = (skill_level * 10)
			var/sewtime = (60 - skill_multiplied)
			if(!do_after(user, sewtime, target = I))
				return
			if((armor_value == 0 && skill_level > 0) || (armor_value > 0 && skill_level > 1)) //If not armor but skill level at least 1 or Armor and skill level at least 2
				user.visible_message(span_info("[user] repairs [I]!"))
				I.obj_integrity = min(I.obj_integrity + skill_multiplied, I.max_integrity)
			else
				if(prob(20 - user.STALUC)) //Unlucky here!
					I.take_damage(150, BRUTE, "slash")
					user.visible_message(span_info("[user] was extremely unlucky and ruined [I] while trying to unskillfuly repair it!"))
					playsound(src, 'sound/foley/cloth_rip.ogg', 50, TRUE)
				else if(prob(user.STALUC)) //Lucky here!
					I.obj_integrity = min(I.obj_integrity + 50, I.max_integrity)
					playsound(src, 'sound/magic/ahh2.ogg', 50, TRUE)
					user.visible_message(span_info("A miracle! [user] somehow managed to repair [I] while not having a single clue what he was doing!"))
				else
					I.take_damage(50, BRUTE, "slash")
					user.visible_message(span_info("[user] damaged [I] due to a lack of skill!"))
					playsound(src, 'sound/foley/cloth_rip.ogg', 50, TRUE)
				user.mind.add_sleep_experience(/datum/skill/misc/sewing, (user.STAINT) / 2) // Only failing if we have no idea what we're doing
		return
	return ..()

/obj/item/needle/proc/sew(mob/living/target, mob/living/user)
	if(!istype(user))
		return FALSE
	var/mob/living/doctor = user
	var/mob/living/carbon/human/patient = target
	if(stringamt < 1)
		to_chat(user, span_warning("The needle has no thread left!"))
		return
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
		moveup = ((doctor.mind.get_skill_level(/datum/skill/misc/treatment)+1) * 5)
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
			doctor.mind.add_sleep_experience(/datum/skill/misc/treatment, doctor.STAINT * 2.5)
		use(1)
		target_wound.sew_wound()
		if(patient == doctor)
			doctor.visible_message(span_notice("[doctor] sews \a [target_wound.name] on [doctor.p_them()]self."), span_notice("I stitch \a [target_wound.name] on my [affecting.name]."))
		else
			if(affecting)
				doctor.visible_message(span_notice("[doctor] sews \a [target_wound.name] on [patient]'s [affecting.name]."), span_notice("I stitch \a [target_wound.name] on [patient]'s [affecting.name]."))
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
