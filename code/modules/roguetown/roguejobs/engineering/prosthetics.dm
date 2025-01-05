/obj/item/bodypart/proc/prosthetic_attachment(var/mob/living/carbon/human/H, var/mob/user)
	if(!ishuman(H))
		return

	if(user.zone_selected != body_zone) //so we can't replace a leg with an arm, or a human arm with a monkey arm.
		to_chat(user, span_warning("[src] не подходит для [parse_zone(user.zone_selected)]."))
		return -1

	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(affecting)
		return

	if(user.temporarilyRemoveItemFromInventory(src))
		attach_limb(H)
		user.visible_message(span_notice("[user] прикрепляет [src] к [H]."))
		return 1

/obj/item/bodypart/l_arm/prosthetic
	name = "debug left arm"
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pr_arm"
	resistance_flags = NONE
	obj_flags = CAN_BE_HIT
	status = BODYPART_ROBOTIC
	brute_reduction = 0
	burn_reduction = 0
	max_damage = 0
	w_class = WEIGHT_CLASS_TINY
	max_integrity = 0
	sellprice = 0
	fingers = FALSE 

/obj/item/bodypart/r_arm/prosthetic
	name = "debug right arm"
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pr_arm"
	resistance_flags = NONE
	obj_flags = CAN_BE_HIT
	status = BODYPART_ROBOTIC
	brute_reduction = 0
	burn_reduction = 0
	max_damage = 0
	w_class = WEIGHT_CLASS_TINY
	max_integrity = 0
	sellprice = 0
	fingers = FALSE

/obj/item/bodypart/l_leg/prosthetic
	name = "debug left leg"
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pr_leg"
	resistance_flags = NONE
	obj_flags = CAN_BE_HIT
	status = BODYPART_ROBOTIC
	brute_reduction = 0
	burn_reduction = 0
	max_damage = 0
	w_class = WEIGHT_CLASS_TINY
	max_integrity = 0
	sellprice = 0
	organ_slowdown = 0

/obj/item/bodypart/r_leg/prosthetic
	name = "debug right leg"
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "pr_leg"
	resistance_flags = NONE
	obj_flags = CAN_BE_HIT
	status = BODYPART_ROBOTIC
	brute_reduction = 0
	burn_reduction = 0
	max_damage = 0
	w_class = WEIGHT_CLASS_TINY
	max_integrity = 0
	sellprice = 0
	organ_slowdown = 0

/obj/item/bodypart/l_arm/prosthetic/attack(mob/living/M, mob/user)
	prosthetic_attachment(M, user)

/obj/item/bodypart/r_arm/prosthetic/attack(mob/living/M, mob/user)
	prosthetic_attachment(M, user)

/obj/item/bodypart/l_leg/prosthetic/attack(mob/living/M, mob/user)
	prosthetic_attachment(M, user)

/obj/item/bodypart/r_leg/prosthetic/attack(mob/living/M, mob/user)
	prosthetic_attachment(M, user)

// --------- WOOD PROSTHETICS -----------

/obj/item/bodypart/l_arm/prosthetic/wood
	name = "деревянная левая рука"
	desc = "Левая рука, вырезанная из дерева."
	icon_state = "prarm" 
	resistance_flags = FLAMMABLE
	max_damage = 20
	w_class = WEIGHT_CLASS_SMALL
	max_integrity = 300
	sellprice = 20
	metalizer_result = /obj/item/bodypart/l_arm/prosthetic/iron

/obj/item/bodypart/r_arm/prosthetic/wood
	name = "деревянная правая рука"
	desc = "Правая рука, вырезанная из дерева."
	icon_state = "prarm" 
	resistance_flags = FLAMMABLE
	max_damage = 20
	w_class = WEIGHT_CLASS_SMALL
	max_integrity = 300
	sellprice = 20
	metalizer_result = /obj/item/bodypart/r_arm/prosthetic/iron

/obj/item/bodypart/l_leg/prosthetic/wood
	name = "деревянная левая нога"
	desc = "Левая нога, вырезанная из дерева."
	icon_state = "pleg" 
	resistance_flags = FLAMMABLE
	max_damage = 20
	w_class = WEIGHT_CLASS_SMALL
	max_integrity = 300
	sellprice = 20
	organ_slowdown = 1.3
	metalizer_result = /obj/item/bodypart/l_leg/prosthetic/iron

/obj/item/bodypart/r_leg/prosthetic/wood
	name = "деревянная правая нога"
	desc = "Правая нога, вырезанная из дерева."
	icon_state = "pleg" 
	resistance_flags = FLAMMABLE
	max_damage = 20
	w_class = WEIGHT_CLASS_SMALL
	max_integrity = 300
	sellprice = 20
	organ_slowdown = 1.3
	metalizer_result = /obj/item/bodypart/r_leg/prosthetic/iron


// --------- IRON PROSTHETICS -----------


/obj/item/bodypart/l_arm/prosthetic/iron
	name = "железная левая рука"
	desc = "Левая рука, выкованная из железа."
	icon_state = "prarm" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	brute_reduction = 5
	burn_reduction = 5
	sellprice = 30

/obj/item/bodypart/r_arm/prosthetic/iron
	name = "железная правая рука"
	desc = "Правая рука, выкованная из железа."
	icon_state = "prarm" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	brute_reduction = 5
	burn_reduction = 5
	sellprice = 30

/obj/item/bodypart/l_leg/prosthetic/iron
	name = "железная левая нога"
	desc = "Левая нога, выкованная из железа."
	icon_state = "pleg" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	organ_slowdown = 1.2
	brute_reduction = 5
	burn_reduction = 5
	sellprice = 30

/obj/item/bodypart/r_leg/prosthetic/iron
	name = "железная правая нога"
	desc = "Правая нога, выкованная из железа."
	icon_state = "pleg" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	organ_slowdown = 1.2
	brute_reduction = 5
	burn_reduction = 5
	sellprice = 30


// --------- STEEL PROSTHETICS -----------

/obj/item/bodypart/l_arm/prosthetic/steel
	name = "стальная левая рука"
	desc = "Левая рука, выкованная из стали."
	icon_state = "prarm" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	brute_reduction = 10
	burn_reduction = 10
	sellprice = 40

/obj/item/bodypart/r_arm/prosthetic/steel
	name = "стальная правая рука"
	desc = "Правая рука, выкованная из стали."
	icon_state = "prarm" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	brute_reduction = 10
	burn_reduction = 10
	sellprice = 40

/obj/item/bodypart/l_leg/prosthetic/steel
	name = "стальная левая нога"
	desc = "Левая нога, выкованная из стали."
	icon_state = "pleg" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	organ_slowdown = 1.1
	brute_reduction = 10
	burn_reduction = 10
	sellprice = 40

/obj/item/bodypart/r_leg/prosthetic/steel
	name = "стальная правая нога"
	desc = "Правая нога, выкованная из стали."
	icon_state = "pleg" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	organ_slowdown = 1.1
	brute_reduction = 10
	burn_reduction = 10
	sellprice = 40
	
// --------- GOLD PROSTHETICS -----------

/obj/item/bodypart/l_arm/prosthetic/gold
	name = "золотая левая рука"
	desc = "Левая рука из шестерёнок и золота."
	icon_state = "prarm" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_BULKY
	fingers = TRUE
	sellprice = 70


/obj/item/bodypart/r_arm/prosthetic/gold
	name = "золотая правая рука"
	desc = "Правая рука из шестерёнок и золота."
	icon_state = "prarm" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_BULKY
	fingers = TRUE
	sellprice = 70

/obj/item/bodypart/l_leg/prosthetic/gold
	name = "золотая левая нога"
	desc = "Левая нога из шестерёнок и золота."
	icon_state = "pleg" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_BULKY
	organ_slowdown = 0
	sellprice = 70

/obj/item/bodypart/r_leg/prosthetic/gold
	name = "золотая правая нога"
	desc = "Правая нога из шестерёнок и золота."
	icon_state = "pleg" 
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_BULKY
	organ_slowdown = 0
	sellprice = 70

// --------- BRONZE PROSTHETICS -----------

/obj/item/bodypart/l_arm/prosthetic/bronze
	name = "бронзовая левая рука"
	desc = "Сменная левая рука, искусно выкованная из бронзы."
	icon_state = "prarm" 
	resistance_flags = FIRE_PROOF
	max_damage = 20
	max_integrity = 350
	sellprice = 40
	fingers = TRUE

/obj/item/bodypart/r_arm/prosthetic/bronze
	name = "бронзовая правая рука"
	desc = "Сменная правая рука, искусно выкованная из бронзы."
	icon_state = "prarm" 
	resistance_flags = FIRE_PROOF
	max_damage = 20
	max_integrity = 350
	sellprice = 40
	fingers = TRUE 
