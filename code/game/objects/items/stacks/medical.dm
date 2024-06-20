/obj/item/stack/medical
	name = "medical pack"
	singular_name = "medical pack"
	icon = 'icons/obj/stack_objects.dmi'
	amount = 6
	max_amount = 6
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 7
	resistance_flags = FLAMMABLE
	max_integrity = 40
	novariants = FALSE
	item_flags = NOBLUDGEON
	var/self_delay = 50
	var/other_delay = 100
	var/repeating = FALSE

/obj/item/stack/medical/attack(mob/living/M, mob/user)
	. = ..()
	try_heal(M, user)


/obj/item/stack/medical/proc/try_heal(mob/living/M, mob/user, silent = FALSE)
	if(!M.can_inject(user, TRUE))
		return
	if(M == user)
		if(!silent)
			user.visible_message(span_notice("[user] starts to apply \the [src] on [user.p_them()]self..."), span_notice("I begin applying \the [src] on myself..."))
		if(!do_mob(user, M, self_delay, extra_checks=CALLBACK(M, TYPE_PROC_REF(/mob/living, can_inject), user, TRUE)))
			return
	else if(other_delay)
		if(!silent)
			user.visible_message(span_notice("[user] starts to apply \the [src] on [M]."), span_notice("I begin applying \the [src] on [M]..."))
		if(!do_mob(user, M, other_delay, extra_checks=CALLBACK(M, TYPE_PROC_REF(/mob/living, can_inject), user, TRUE)))
			return

	if(heal(M, user))
		log_combat(user, M, "healed", src.name)
		use(1)
		if(repeating && amount > 0)
			try_heal(M, user, TRUE)

/obj/item/stack/medical/proc/heal(mob/living/M, mob/user)
	return

/obj/item/stack/medical/proc/heal_carbon(mob/living/carbon/C, mob/user, brute, burn)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, span_warning("[C] doesn't have \a [parse_zone(user.zone_selected)]!"))
		return
	if(affecting.status == BODYPART_ORGANIC) //Limb must be organic to be healed - RR
		if(affecting.brute_dam && brute || affecting.burn_dam && burn)
			user.visible_message(span_green("[user] applies \the [src] on [C]'s [affecting.name]."), span_green("I apply \the [src] on [C]'s [affecting.name]."))
			if(affecting.heal_damage(brute, burn))
				C.update_damage_overlays()
			return TRUE
		to_chat(user, span_warning("[C]'s [affecting.name] can not be healed with \the [src]!"))
		return
	to_chat(user, span_warning("\The [src] won't work on a robotic limb!"))

/obj/item/stack/medical/bruise_pack
	name = "bruise pack"
	singular_name = "bruise pack"
	desc = ""
	icon_state = "brutepack"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	var/heal_brute = 40
	self_delay = 20
	grind_results = list(/datum/reagent/medicine/C2/libital = 10)

/obj/item/stack/medical/bruise_pack/heal(mob/living/M, mob/user)
	if(M.stat == DEAD)
		to_chat(user, span_warning("[M] is dead! You can not help [M.p_them()]."))
		return
	if(isanimal(M))
		var/mob/living/simple_animal/critter = M
		if (!(critter.healable))
			to_chat(user, span_warning("I cannot use \the [src] on [M]!"))
			return FALSE
		else if (critter.health == critter.maxHealth)
			to_chat(user, span_notice("[M] is at full health."))
			return FALSE
		user.visible_message(span_green("[user] applies \the [src] on [M]."), span_green("I apply \the [src] on [M]."))
		M.heal_bodypart_damage((heal_brute/2))
		return TRUE
	if(iscarbon(M))
		return heal_carbon(M, user, heal_brute, 0)
	to_chat(user, span_warning("I can't heal [M] with the \the [src]!"))

/obj/item/stack/medical/bruise_pack/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is bludgeoning [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (BRUTELOSS)

/obj/item/stack/medical/gauze
	name = "bandages"
	desc = ""
	gender = PLURAL
	singular_name = "bandage"
	icon_state = "gauze"
	var/stop_bleeding = 3000
	self_delay = 100
	max_amount = 12
	grind_results = list(/datum/reagent/cellulose = 2)
	//dropshrink = 0.5

/obj/item/stack/medical/gauze/heal(mob/living/M, mob/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.bleedsuppress && H.bleed_rate) //so you can't stack bleed suppression
			H.suppress_bloodloss(stop_bleeding)
			to_chat(user, span_notice("I bandage [M]."))
			return TRUE
	to_chat(user, span_warning("I can not use \the [src] on [M]."))
/*
/obj/item/stack/medical/gauze/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER || I.get_sharpness())
		if(get_amount() < 2)
			to_chat(user, span_warning("I need at least two gauzes to do this!"))
			return
		new /obj/item/stack/sheet/cloth(user.drop_location())
		user.visible_message(span_notice("[user] cuts [src] into pieces of cloth with [I]."), \
					 span_notice("I cut [src] into pieces of cloth with [I]."), \
					 span_hear("I hear cutting."))
		use(2)
	else
		return ..()*/

/obj/item/stack/medical/gauze/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] begins tightening \the [src] around [user.p_their()] neck! It looks like [user.p_they()] forgot how to use medical supplies!"))
	return OXYLOSS

/obj/item/stack/medical/gauze/improvised
	name = "improvised gauze"
	singular_name = "improvised gauze"
	desc = ""
	stop_bleeding = 900

/obj/item/stack/medical/gauze/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250

/obj/item/stack/medical/ointment
	name = "ointment"
	desc = ""
	gender = PLURAL
	singular_name = "ointment"
	icon_state = "ointment"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	var/heal_burn = 40
	self_delay = 20
	grind_results = list(/datum/reagent/medicine/C2/lenturi = 10)

/obj/item/stack/medical/ointment/heal(mob/living/M, mob/user)
	if(M.stat == DEAD)
		to_chat(user, span_warning("[M] is dead! You can not help [M.p_them()]."))
		return
	if(iscarbon(M))
		return heal_carbon(M, user, 0, heal_burn)
	to_chat(user, span_warning("I can't heal [M] with the \the [src]!"))

/obj/item/stack/medical/ointment/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is squeezing \the [src] into [user.p_their()] mouth! [user.p_do(TRUE)]n't [user.p_they()] know that stuff is toxic?"))
	return TOXLOSS

/obj/item/stack/medical/suture
	name = "suture"
	desc = ""
	gender = PLURAL
	singular_name = "suture"
	icon_state = "suture"
	self_delay = 30
	other_delay = 10
	amount = 15
	max_amount = 15
	repeating = TRUE
	var/heal_brute = 10
	grind_results = list(/datum/reagent/medicine/spaceacillin = 2)

/obj/item/stack/medical/suture/medicated
	name = "medicated suture"
	icon_state = "suture_purp"
	desc = ""
	heal_brute = 15
	grind_results = list(/datum/reagent/medicine/polypyr = 2)

/obj/item/stack/medical/suture/heal(mob/living/M, mob/user)
	. = ..()
	if(M.stat == DEAD)
		to_chat(user, span_warning("[M] is dead! You can not help [M.p_them()]."))
		return
	if(iscarbon(M))
		return heal_carbon(M, user, heal_brute, 0)
	if(isanimal(M))
		var/mob/living/simple_animal/critter = M
		if (!(critter.healable))
			to_chat(user, span_warning("I cannot use \the [src] on [M]!"))
			return FALSE
		else if (critter.health == critter.maxHealth)
			to_chat(user, span_notice("[M] is at full health."))
			return FALSE
		user.visible_message(span_green("[user] applies \the [src] on [M]."), span_green("I apply \the [src] on [M]."))
		M.heal_bodypart_damage(heal_brute)
		return TRUE

	to_chat(user, span_warning("I can't heal [M] with the \the [src]!"))

/obj/item/stack/medical/mesh
	name = "regenerative mesh"
	desc = ""
	gender = PLURAL
	singular_name = "regenerative mesh"
	icon_state = "regen_mesh"
	self_delay = 30
	other_delay = 10
	amount = 15
	max_amount = 15
	repeating = TRUE
	var/heal_burn = 10
	var/is_open = TRUE ///This var determines if the sterile packaging of the mesh has been opened.
	grind_results = list(/datum/reagent/medicine/spaceacillin = 2)

/obj/item/stack/medical/mesh/Initialize()
	..()
	if(amount == max_amount)	 //only seal full mesh packs
		is_open = FALSE
		icon_state = "regen_mesh_closed"


/obj/item/stack/medical/mesh/update_icon()
	if(!is_open)
		return
	. = ..()

/obj/item/stack/medical/mesh/heal(mob/living/M, mob/user)
	. = ..()
	if(M.stat == DEAD)
		to_chat(user, span_warning("[M] is dead! You can not help [M.p_them()]."))
		return
	if(iscarbon(M))
		return heal_carbon(M, user, 0, heal_burn)
	to_chat(user, span_warning("I can't heal [M] with the \the [src]!"))


/obj/item/stack/medical/mesh/try_heal(mob/living/M, mob/user, silent = FALSE)
	if(!is_open)
		to_chat(user, span_warning("I need to open [src] first."))
		return
	. = ..()

/obj/item/stack/medical/mesh/AltClick(mob/living/user)
	if(!is_open)
		to_chat(user, span_warning("I need to open [src] first."))
		return
	. = ..()

/obj/item/stack/medical/mesh/attack_hand(mob/user)
	if(!is_open & user.get_inactive_held_item() == src)
		to_chat(user, span_warning("I need to open [src] first."))
		return
	. = ..()

/obj/item/stack/medical/mesh/attack_self(mob/user)
	if(!is_open)
		is_open = TRUE
		to_chat(user, span_notice("I open the sterile mesh package."))
		update_icon()
		playsound(src, 'sound/blank.ogg', 20, TRUE)
		return
	. = ..()

	/*
	The idea is for these medical devices to work like a hybrid of the old brute packs and tend wounds,
	they heal a little at a time, have reduced healing density and does not allow for rapid healing while in combat.
	However they provice graunular control of where the healing is directed, this makes them better for curing work-related cuts and scrapes.

	The interesting limb targeting mechanic is retained and i still believe they will be a viable choice, especially when healing others in the field.
	 */

