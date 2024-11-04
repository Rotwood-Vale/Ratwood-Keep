/obj/item/bodypart/proc/prosthetic_attachment(var/mob/living/carbon/human/H, var/mob/user)
	if(!ishuman(H))
		return

	if(user.zone_selected != body_zone) //so we can't replace a leg with an arm, or a human arm with a monkey arm.
		to_chat(user, span_warning("[src] isn't the right type for [parse_zone(user.zone_selected)]."))
		return -1

	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(affecting)
		return

	if(user.temporarilyRemoveItemFromInventory(src))
		attach_limb(H)
		user.visible_message(span_notice("[user] attaches [src] to [H]."))
		return 1

/obj/item/bodypart/l_arm/rprosthetic
	name = "wooden arm (L)"
	desc = "A left arm of wood."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pr_arm"
	resistance_flags = FLAMMABLE
	obj_flags = CAN_BE_HIT
	status = BODYPART_ROBOTIC
	brute_reduction = 0
	burn_reduction = 0
	max_damage = 20
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 300
	sellprice = 20
	fingers = FALSE //can't swing weapons but can pick stuff up and punch

/obj/item/bodypart/l_arm/rprosthetic/iron
	name = "iron arm (L)"
	desc = "A left arm of iron."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pri_arm"
	prosthetic_prefix = "pri"
	brute_reduction = 5
	burn_reduction = 5
	sellprice = 30

/obj/item/bodypart/l_arm/rprosthetic/steel
	name = "steel arm (L)"
	desc = "A left arm of steel."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "prs_arm"
	prosthetic_prefix = "prs"
	brute_reduction = 10
	burn_reduction = 10
	sellprice = 40

/obj/item/bodypart/l_arm/rprosthetic/clock
	name = "clockwork arm (L)"
	desc = "A left arm of cogs and gold."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "prc_arm"
	prosthetic_prefix = "prc"
	fingers = TRUE
	sellprice = 50

/obj/item/bodypart/l_arm/rprosthetic/attack(mob/living/M, mob/user)
	prosthetic_attachment(M, user)

/obj/item/bodypart/r_arm/rprosthetic
	name = "wooden arm (R)"
	desc = "A right arm of wood."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pr_arm"
	resistance_flags = FLAMMABLE
	obj_flags = CAN_BE_HIT
	status = BODYPART_ROBOTIC
	brute_reduction = 0
	burn_reduction = 0
	max_damage = 20
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 300
	sellprice = 20
	fingers = FALSE //can't swing weapons but can pick stuff up and punch

/obj/item/bodypart/r_arm/rprosthetic/iron
	name = "iron arm (R)"
	desc = "A right arm of iron."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pri_arm"
	prosthetic_prefix = "pri"
	brute_reduction = 5
	burn_reduction = 5
	sellprice = 30

/obj/item/bodypart/r_arm/rprosthetic/steel
	name = "steel arm (R)"
	desc = "A right arm of steel."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "prs_arm"
	prosthetic_prefix = "prs"
	brute_reduction = 10
	burn_reduction = 10
	sellprice = 40

/obj/item/bodypart/r_arm/rprosthetic/clock
	name = "clockwork arm (R)"
	desc = "A right arm of cogs and gold."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "prc_arm"
	prosthetic_prefix = "prc"
	fingers = TRUE
	sellprice = 50

/obj/item/bodypart/r_arm/rprosthetic/attack(mob/living/M, mob/user)
	prosthetic_attachment(M, user)

/obj/item/bodypart/l_leg/rprosthetic
	name = "peg leg (L)"
	desc = "A left leg of wood."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pr_leg"
	resistance_flags = FLAMMABLE
	obj_flags = CAN_BE_HIT
	status = BODYPART_ROBOTIC
	brute_reduction = 0
	burn_reduction = 0
	max_damage = 20
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 300
	sellprice = 20
	organ_slowdown = 1.3

/obj/item/bodypart/l_leg/rprosthetic/iron
	name = "iron leg (L)"
	desc = "A left leg of iron."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pri_leg"
	prosthetic_prefix = "pri"
	organ_slowdown = 1.2
	brute_reduction = 5
	burn_reduction = 5
	sellprice = 30

/obj/item/bodypart/l_leg/rprosthetic/steel
	name = "steel leg (L)"
	desc = "A left leg of steel."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "prs_leg"
	prosthetic_prefix = "prs"
	organ_slowdown = 1.1
	brute_reduction = 10
	burn_reduction = 10
	sellprice = 40

/obj/item/bodypart/l_leg/rprosthetic/clock
	name = "clockwork leg (L)"
	desc = "A left leg of cogs and gold."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "prc_leg"
	prosthetic_prefix = "prc"
	organ_slowdown = 0
	sellprice = 50

/obj/item/bodypart/l_leg/rprosthetic/attack(mob/living/M, mob/user)
	prosthetic_attachment(M, user)

/obj/item/bodypart/r_leg/rprosthetic
	name = "peg leg (R)"
	desc = "A right leg of wood."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pr_leg"
	resistance_flags = FLAMMABLE
	obj_flags = CAN_BE_HIT
	status = BODYPART_ROBOTIC
	brute_reduction = 0
	burn_reduction = 0
	max_damage = 20
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 300
	sellprice = 20
	organ_slowdown = 1.3

/obj/item/bodypart/r_leg/rprosthetic/iron
	name = "iron leg (R)"
	desc = "A right leg of iron."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pri_leg"
	prosthetic_prefix = "pri"
	organ_slowdown = 1.2
	brute_reduction = 5
	burn_reduction = 5
	sellprice = 30

/obj/item/bodypart/r_leg/rprosthetic/steel
	name = "steel leg (R)"
	desc = "A right leg of steel."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "prs_leg"
	prosthetic_prefix = "prs"
	organ_slowdown = 1.1
	brute_reduction = 10
	burn_reduction = 10
	sellprice = 40

/obj/item/bodypart/r_leg/rprosthetic/clock
	name = "clockwork leg (R)"
	desc = "A right leg of cogs and gold."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "prc_leg"
	prosthetic_prefix = "prc"
	organ_slowdown = 0
	sellprice = 50

/obj/item/bodypart/r_leg/rprosthetic/attack(mob/living/M, mob/user)
	prosthetic_attachment(M, user)