/obj/item/remove_bintegrity(amt as num, mob/user)
	if(user && HAS_TRAIT(user, TRAIT_SHARPER_BLADES))
		amt = amt * 0.7
	. = ..()
