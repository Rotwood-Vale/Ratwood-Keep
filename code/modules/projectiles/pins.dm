/obj/item/firing_pin
	name = "electronic firing pin"
	desc = ""
	icon = 'icons/obj/device.dmi'
	icon_state = "firing_pin"
	item_state = "pen"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("poked")
	var/fail_message = span_warning("INVALID USER.")
	var/selfdestruct = 0 // Explode when user check is failed.
	var/force_replace = 0 // Can forcefully replace other pins.
	var/pin_removeable = 0 // Can be replaced by any pin.
	var/obj/item/gun/gun

/obj/item/firing_pin/New(newloc)
	..()
	if(istype(newloc, /obj/item/gun))
		gun = newloc

/obj/item/firing_pin/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag)
		if(istype(target, /obj/item/gun))
			var/obj/item/gun/G = target
			if(G.pin && (force_replace || G.pin.pin_removeable))
				G.pin.forceMove(get_turf(G))
				G.pin.gun_remove(user)
				to_chat(user, span_notice("I remove [G]'s old pin."))

			if(!G.pin)
				if(!user.temporarilyRemoveItemFromInventory(src))
					return
				gun_insert(user, G)
				to_chat(user, span_notice("I insert [src] into [G]."))
			else
				to_chat(user, span_notice("This firearm already has a firing pin installed."))

/obj/item/firing_pin/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(user, span_notice("I override the authentication mechanism."))

/obj/item/firing_pin/proc/gun_insert(mob/living/user, obj/item/gun/G)
	gun = G
	forceMove(gun)
	gun.pin = src
	return

/obj/item/firing_pin/proc/gun_remove(mob/living/user)
	gun.pin = null
	gun = null
	return

/obj/item/firing_pin/proc/pin_auth(mob/living/user)
	return TRUE

/obj/item/firing_pin/proc/auth_fail(mob/living/user)
	if(user)
		user.show_message(fail_message, MSG_VISUAL)
	if(selfdestruct)
		if(user)
			user.show_message("<span class='danger'>SELF-DESTRUCTING...</span><br>", MSG_VISUAL)
			to_chat(user, span_danger("[gun] explodes!"))
		explosion(get_turf(gun), -1, 0, 2, 3)
		if(gun)
			qdel(gun)


/obj/item/firing_pin/magic
	name = "magic crystal shard"
	desc = ""


// Test pin, works only near firing range.
/obj/item/firing_pin/test_range
	name = "test-range firing pin"
	desc = ""
	fail_message = span_warning("TEST RANGE CHECK FAILED.")
	pin_removeable = TRUE

/obj/item/firing_pin/test_range/pin_auth(mob/living/user)
	if(!istype(user))
		return FALSE
	return FALSE


// Implant pin, checks for implant
/obj/item/firing_pin/implant
	name = "implant-keyed firing pin"
	desc = ""
	fail_message = span_warning("IMPLANT CHECK FAILED.")
	var/obj/item/implant/req_implant = null

/obj/item/firing_pin/implant/pin_auth(mob/living/user)
	if(user)
		for(var/obj/item/implant/I in user.implants)
			if(req_implant && I.type == req_implant)
				return TRUE
	return FALSE

/obj/item/firing_pin/implant/mindshield
	name = "mindshield firing pin"
	desc = ""
	icon_state = "firing_pin_loyalty"

/obj/item/firing_pin/implant/pindicate
	name = "syndicate firing pin"
	icon_state = "firing_pin_pindi"
	req_implant = /obj/item/implant/weapons_auth



// Honk pin, clown's joke item.
// Can replace other pins. Replace a pin in cap's laser for extra fun!
/obj/item/firing_pin/clown
	name = "hilarious firing pin"
	desc = ""
	color = "#FFFF00"
	fail_message = span_warning("HONK!")
	force_replace = TRUE

/obj/item/firing_pin/clown/pin_auth(mob/living/user)
	playsound(src, 'sound/blank.ogg', 50, TRUE)
	return FALSE

// Ultra-honk pin, clown's deadly joke item.
// A gun with ultra-honk pin is useful for clown and useless for everyone else.
/obj/item/firing_pin/clown/ultra/pin_auth(mob/living/user)
	playsound(src.loc, 'sound/blank.ogg', 50, TRUE)
	if(user && (!(HAS_TRAIT(user, TRAIT_CLUMSY)) && !(user.mind && user.mind.assigned_role == "Clown")))
		return FALSE
	return TRUE

/obj/item/firing_pin/clown/ultra/gun_insert(mob/living/user, obj/item/gun/G)
	..()
	G.clumsy_check = FALSE

/obj/item/firing_pin/clown/ultra/gun_remove(mob/living/user)
	gun.clumsy_check = initial(gun.clumsy_check)
	..()

// Now two times deadlier!
/obj/item/firing_pin/clown/ultra/selfdestruct
	desc = ""
	selfdestruct = TRUE


// DNA-keyed pin.
// When you want to keep your toys for myself.
/obj/item/firing_pin/dna
	name = "DNA-keyed firing pin"
	desc = ""
	icon_state = "firing_pin_dna"
	fail_message = span_warning("DNA CHECK FAILED.")
	var/unique_enzymes = null

/obj/item/firing_pin/dna/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag && iscarbon(target))
		var/mob/living/carbon/M = target
		if(M.dna && M.dna.unique_enzymes)
			unique_enzymes = M.dna.unique_enzymes
			to_chat(user, span_notice("DNA-LOCK SET."))

/obj/item/firing_pin/dna/pin_auth(mob/living/carbon/user)
	if(user && user.dna && user.dna.unique_enzymes)
		if(user.dna.unique_enzymes == unique_enzymes)
			return TRUE
	return FALSE

/obj/item/firing_pin/dna/auth_fail(mob/living/carbon/user)
	if(!unique_enzymes)
		if(user && user.dna && user.dna.unique_enzymes)
			unique_enzymes = user.dna.unique_enzymes
			to_chat(user, span_notice("DNA-LOCK SET."))
	else
		..()

/obj/item/firing_pin/dna/dredd
	desc = ""
	selfdestruct = TRUE

// Laser tag pins
/obj/item/firing_pin/tag
	name = "laser tag firing pin"
	desc = ""
	fail_message = span_warning("SUIT CHECK FAILED.")
	var/obj/item/clothing/suit/suit_requirement = null
	var/tagcolor = ""

/obj/item/firing_pin/tag/pin_auth(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/M = user
		if(istype(M.wear_armor, suit_requirement))
			return TRUE
	to_chat(user, span_warning("I need to be wearing [tagcolor] laser tag armor!"))
	return FALSE

/obj/item/firing_pin/Destroy()
	if(gun)
		gun.pin = null
	return ..()
