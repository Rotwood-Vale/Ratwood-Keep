/datum/job/roguetown/templar
	ru_title = "Храмовник"
	ru_f_title = "Храмовница"
	ru_tutorial = "Храмовники есть воины Ордена Десяти, которые отказались от богатств и титулов в пользу веры, \
	будь то из-за религиозного фанатизма или прошлых позоров. Они охраняют храм и подчиняются жрецу, внимательно \
	следя за ересью и ночными чудовищами. В тревожных снах они мучаются мыслями, была ли пролитая ими кровь пролита зазря."
	allowed_patrons = ALL_DIVINE_PATRONS

/datum/outfit/job/roguetown/templar
	allowed_patrons = ALL_DIVINE_PATRONS

/obj/item/squeeze_me
	name = "Squeeze Me"
	desc = "Xylix's gift."
	icon_state = "xylixhelm"
	icon = 'modular_redmoon/icons/hats.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/squeeze_me/attack_self(mob/user)
	. = ..()
	user.visible_message(span_notice("[user] squeezing something..."), \
						span_notice("I begin squeezing something..."))
	var/visoptions = list("Astrata", "Astrata (Alt)", "Noc", "Dendor", "Necra", "Necra (Alt)", "Pestra", "Malum", "Ravox", "Eora", "Xylix", "Xylix (Cage)", "Abyssor")
	var/selected = input(user, "Доспехи какого Ордена тебе нужны?", "XYLIX GIFT") as anything in visoptions
	if(!selected)
		return
	switch(selected)
		if("Astrata")
			new /obj/item/clothing/head/roguetown/helmet/heavy/templar/astrata (user.loc)
			new /obj/item/clothing/cloak/templar/astratan (user.loc)
		if("Astrata (Alt)")
			new /obj/item/clothing/head/roguetown/helmet/heavy/templar/astrata/alt (user.loc)
			new /obj/item/clothing/cloak/templar/astratan (user.loc)
		if("Noc")
			new /obj/item/clothing/head/roguetown/helmet/heavy/templar/noc (user.loc)
			new /obj/item/clothing/cloak/tabard/crusader/noc (user.loc)
		if("Dendor")
			new /obj/item/clothing/head/roguetown/helmet/heavy/templar/dendor (user.loc)
			new /obj/item/clothing/cloak/tabard/crusader/dendor (user.loc)
		if("Necra")
			new /obj/item/clothing/head/roguetown/helmet/heavy/templar/necra (user.loc)
			new /obj/item/clothing/cloak/templar/necran (user.loc)
		if("Necra (Alt)")
			new /obj/item/clothing/head/roguetown/helmet/heavy/templar/necra/alt (user.loc)
			new /obj/item/clothing/cloak/templar/necran (user.loc)
		if("Pestra")
			new /obj/item/clothing/head/roguetown/helmet/heavy/pestrahelm (user.loc)
			new /obj/item/clothing/cloak/tabard/crusader/pestra (user.loc)
		if("Malum")
			new /obj/item/clothing/head/roguetown/helmet/heavy/templar/malum (user.loc)
			new /obj/item/clothing/cloak/templar/malummite (user.loc)
		if("Ravox")
			new /obj/item/clothing/head/roguetown/helmet/heavy/templar/ravox (user.loc)
			new /obj/item/clothing/cloak/tabard/crusader/ravox (user.loc)
		if("Eora")
			new /obj/item/clothing/head/roguetown/helmet/heavy/eorahelm (user.loc)
			new /obj/item/clothing/cloak/tabard/crusader/eora (user.loc)
		if("Xylix")
			new /obj/item/clothing/head/roguetown/helmet/heavy/xylixhelm (user.loc)
			new /obj/item/clothing/cloak/tabard/crusader/xylix (user.loc)
		if("Xylix (Cage)")
			new /obj/item/clothing/head/roguetown/helmet/heavy/xylixcagehelm (user.loc)
			new /obj/item/clothing/cloak/tabard/crusader/xylix (user.loc)
		if("Abyssor")
			new /obj/item/clothing/head/roguetown/helmet/heavy/abyssorhelm (user.loc)
			new /obj/item/clothing/cloak/abyssortabard (user.loc)
	playsound(src, 'sound/ravein/small/hello_my_friend.ogg', 40, 1)
	qdel(src)
