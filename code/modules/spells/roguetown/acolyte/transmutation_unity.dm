/obj/item/shunned_blood_potion
name = "Shunned blood"
	desc = "A bottle, full of blood. This one blood belongs to one of shunned races."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "lovebottle"

/obj/item/shunned_blood_potion/attack(mob/living/carbon/human/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, span_warning("Shunned blood can only be metabolized by living beings. I'd best not waste it!"))
		return ..()
	if(M.has_status_effect(STATUS_SHUNNED_BLOOD))
		to_chat(user, span_warning("[M] has shunned race's legacy already..."))
		return ..()
	if(M.has_status_effect(STATUS_SHUNNED_BLOOD))
		to_chat(user, span_warning("[M] has shunned race's legacy already..."))
		return ..()

	M.visible_message(span_danger("[user] starts to feed [M] shunned blood..."),
		span_danger("[user] starts to feed you some blood..."))

	if(!do_after(user, 50, target = M))
		return
	to_chat(user, span_notice("I feed [M] the a portion of shunned blood!"))
	to_chat(M, span_notice("I taste some... Corruption on my tongue..."))
	M.apply_status_effect(STATUS_SHUNNED_BLOOD, user)
	qdel(src)
