//Love potion - Charged Pink
/obj/item/lovepotion
	name = "love potion"
	desc = "A pink potion with a faintly sweet and fruity aroma emanating from the bottle. The label reads \"Love Potion\" and says it will make nearly anyone desire you."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "lovebottle"

/obj/item/lovepotion/attack(mob/living/carbon/human/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, span_warning("A love potion can only be metabolized by living beings. I'd best not waste it!"))
		return ..()
	if(user == M)
		to_chat(user, span_warning("It's too risky to consume this potion myself. Instead, I should feed it to someone I desire!"))
		return ..()
	if(M.has_status_effect(STATUS_EFFECT_INLOVE))
		to_chat(user, span_warning("[M] is already consumed by obsession for someone else!"))
		return ..()

	M.visible_message(span_danger("[user] starts to feed [M] a love potion!"),
		span_danger("[user] starts to feed you a love potion!"))

	if(!do_after(user, 50, target = M))
		return
	to_chat(user, span_notice("I feed [M] the love potion!"))
	to_chat(M, span_notice("I taste strawberries as the potion pours down my throat. My heart pounds against my chest as my mind becomes clouded with thoughts of [user]. Be this true love or be this obsession, it matters not. For I will have [user]."))
	if(M.mind)
		M.mind.store_memory("You are obsessed with [user].")
		M.mind.add_special_person(user, "#FFC0CB")
	M.faction |= "[REF(user)]"
	M.apply_status_effect(STATUS_EFFECT_INLOVE, user)
	qdel(src)
