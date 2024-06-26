/obj/item/dildo
	name = "unfinished dildo"
	desc = "You have to finish it first."
	icon = 'modular/icons/obj/lewd/dildo.dmi'
	icon_state = "unfinished"
	item_state = "dildo"
	lefthand_file = 'modular/icons/mob/inhands/lewd/items_lefthand.dmi'
	righthand_file = 'modular/icons/mob/inhands/lewd/items_righthand.dmi'
	force = 1
	throwforce = 10
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = CAN_BE_HIT
	sellprice = 1
	var/dildo_type = "human"
	var/dildo_size = "small"
	var/pleasure = 4
	var/can_custom = TRUE
	var/dildo_material
	var/hole = "vagina"

/obj/item/dildo/New()
	. = ..()
	name = "unfinished [dildo_material] dildo"

/obj/item/dildo/attack_self(mob/living/user)
	. = ..()
	if(!istype(user))
		return
	if(can_custom)
		customize(user)
	if(!can_custom)
		var/choice = input(user, "Choose a hole to fuck.","Hole") as null|anything in list("vagina", "ass", "mouth")
		hole = choice

/obj/item/dildo/proc/customize(mob/living/user)
	if(!can_custom)
		return FALSE
	if(src && !user.incapacitated() && in_range(user,src))
		var/shape_choice = input(user, "Choose a shape for your dildo.","Dildo Shape") as null|anything in list("knotted", "human", "flared")
		if(src && shape_choice && !user.incapacitated() && in_range(user,src))
			dildo_type = shape_choice
	update_appearance()
	if(src && !user.incapacitated() && in_range(user,src))
		var/size_choice = input(user, "Choose a size for your dildo.","Dildo Size") as null|anything in list("small", "medium", "big")
		if(src && size_choice && !user.incapacitated() && in_range(user,src))
			dildo_size = size_choice
			switch(dildo_size)
				if("small")
					pleasure = 4
				if("medium")
					pleasure = 6
				if("big")
					pleasure = 8
	update_appearance()
	return TRUE

/obj/item/dildo/proc/update_appearance()
	icon_state = "dildo_[dildo_type]_[dildo_size]"
	name = "[dildo_size] [dildo_type] [dildo_material] dildo"
	desc = "To quench the woman's thirst."
	can_custom = FALSE

/obj/item/dildo/wood
	color = "#7D4033"
	resistance_flags = FLAMMABLE
	dildo_material = "wooden"
	sellprice = 1

/obj/item/dildo/iron
	color = "#9EA48E"
	dildo_material = "iron"
	sellprice = 5

/obj/item/dildo/steel
	color = "#9BADB7"
	dildo_material = "steel"
	sellprice = 10

/obj/item/dildo/silver
	color = "#C6D5E1"
	dildo_material = "silver"
	sellprice = 30

/obj/item/dildo/gold
	color = "#A0A075"
	dildo_material = "golden"
	sellprice = 50

/obj/item/dildo/attack(mob/living/carbon/human/target, mob/living/user)
	if(can_custom)
		return
	if(user.mmb_intent)
		return ..()
	if(!istype(target))
		return
	if(!user.can_do_sex())
		to_chat(user, "<span class='warning'>I can't do this.</span>")
		return

	var/target_mouth = TRUE
	var/target_groin = TRUE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_MOUTH))
		target_mouth = FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		target_groin = FALSE

	if(hole == "vagina")
		if(!target_groin)
			to_chat(user, "<span class='warning'>[target] is not naked!</span>")
			return
		if(target.gender == MALE)
			to_chat(user, "<span class='warning'>[target] has no vagina!</span>")
			return
		if(do_after(user, 2))
			if(target.gender == FEMALE)
				if(prob(33))
					if(user == target)
						target.visible_message("<span class='love'>[target] masturbates with [src].</span>")
					if(user != target)
						target.visible_message("<span class='[!target.cmode ? "love" : "warning"]'>[user] fucks [target] with [src].</span>")
				if(target.virginity)
					target.visible_message("<span class='warning'>[target] loses her purity!</span>")
					target.flash_fullscreen("redflash3")
					target.virginity = FALSE

				playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
				target.sexcon.adjust_horny(pleasure, "dildo")
	if(hole == "ass")
		if(!target_groin)
			to_chat(user, "<span class='warning'>[target] is not naked!</span>")
			return

		else
			if(do_after(user, 2))
				if(prob(33))
					if(user == target)
						target.visible_message("<span class='love'>[target] fuck their ass with [src].</span>")
					if(user != target)
						target.visible_message("<span class='[!target.cmode ? "love" : "warning"]'>[user] fucks [target]'s ass with [src].</span>")

				playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
				target.sexcon.adjust_horny(pleasure, "dildo")

	if(hole == "mouth")
		if(!target_mouth)
			to_chat(user, "<span class='warning'>[target]'s mouth is covered!</span>")
			return

		else
			if(do_after(user, 2))
				if(prob(33))
					if(user == target)
						target.visible_message("<span class='love'>[target] sucks [src].</span>")
					if(user != target)
						target.visible_message("<span class='[!target.cmode ? "love" : "warning"]'>[user] forces [target] to suck [src].</span>")

				playsound(target, pick('sound/misc/mat/mouthend (1).ogg','sound/misc/mat/mouthend (2).ogg'), 50, FALSE, ignore_walls = FALSE)
