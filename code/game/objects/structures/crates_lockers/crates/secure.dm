/obj/structure/closet/crate/secure
	desc = ""
	name = "secure crate"
	icon_state = "securecrate"
	secure = TRUE
	locked = TRUE
	max_integrity = 500
	armor = list("blunt" = 30, "slash" = 40, "stab" = 50, "bullet" = 50, "laser" = 50, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	var/tamperproof = 0
	damage_deflection = 25

/obj/structure/closet/crate/secure/update_icon()
	..()
	if(broken)
		add_overlay("securecrateemag")
	else if(locked)
		add_overlay("securecrater")
	else
		add_overlay("securecrateg")

/obj/structure/closet/crate/secure/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1)
	if(prob(tamperproof) && damage_amount >= DAMAGE_PRECISION)
		boom()
	else
		return ..()


/obj/structure/closet/crate/secure/proc/boom(mob/user)
	if(user)
		to_chat(user, span_danger("The crate's anti-tamper system activates!"))
		log_bomber(user, "has detonated a", src)
	for(var/atom/movable/AM in src)
		qdel(AM)
	explosion(get_turf(src), 0, 1, 5, 5)
	qdel(src)

/obj/structure/closet/crate/secure/weapon
	desc = ""
	name = "weapons crate"
	icon_state = "weaponcrate"

/obj/structure/closet/crate/secure/plasma
	desc = ""
	name = "plasma crate"
	icon_state = "plasmacrate"

/obj/structure/closet/crate/secure/gear
	desc = ""
	name = "gear crate"
	icon_state = "secgearcrate"

/obj/structure/closet/crate/secure/hydroponics
	desc = ""
	name = "secure hydroponics crate"
	icon_state = "hydrosecurecrate"

/obj/structure/closet/crate/secure/engineering
	desc = ""
	name = "secure engineering crate"
	icon_state = "engi_secure_crate"

/obj/structure/closet/crate/secure/science
	name = "secure science crate"
	desc = ""
	icon_state = "scisecurecrate"

/obj/structure/closet/crate/secure/owned
	name = "private crate"
	desc = ""
	icon_state = "privatecrate"
	var/datum/bank_account/buyer_account
	var/privacy_lock = TRUE

/obj/structure/closet/crate/secure/owned/examine(mob/user)
	. = ..()
	. += span_notice("It's locked with a privacy lock, and can only be unlocked by the buyer's ID.")

/obj/structure/closet/crate/secure/owned/Initialize(mapload, datum/bank_account/_buyer_account)
	. = ..()
	buyer_account = _buyer_account

/obj/structure/closet/crate/secure/owned/togglelock(mob/living/user, silent)
	if(privacy_lock)
		if(!broken)
			var/obj/item/card/id/id_card = user.get_idcard(TRUE)
			if(id_card)
				if(id_card.registered_account)
					if(id_card.registered_account == buyer_account)
						if(iscarbon(user))
							add_fingerprint(user)
						locked = !locked
						user.visible_message(span_notice("[user] unlocks [src]'s privacy lock."),
										span_notice("I unlock [src]'s privacy lock."))
						privacy_lock = FALSE
						update_icon()
					else if(!silent)
						to_chat(user, span_notice("Bank account does not match with buyer!"))
				else if(!silent)
					to_chat(user, span_notice("No linked bank account detected!"))
			else if(!silent)
				to_chat(user, span_notice("No ID detected!"))
		else if(!silent)
			to_chat(user, span_warning("[src] is broken!"))
	else ..()
