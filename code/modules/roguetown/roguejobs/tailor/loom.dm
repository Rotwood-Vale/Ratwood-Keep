/obj/machinery/loom
	icon = 'icons/roguetown/misc/structure.dmi'
	name = "ткацкий станок"
	desc = "Деревянная рама с натянутыми нитями, готовая для плетения ткани."
	icon_state = "loom"
	var/storedfiber = 0
	var/maxfiber = 50
	max_integrity = 200
	density = TRUE

/obj/machinery/loom/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/natural/bundle/fibers))
		var/obj/item/natural/bundle/fibers/W = I
		if(src.storedfiber + W.amount > src.maxfiber)
			W.amount = (W.amount - (src.maxfiber - src.storedfiber))
			to_chat(user, "Вы натягиваете немного волокон на [src].")
			src.storedfiber = src.maxfiber
			if(W.amount == 1)
				new /obj/item/natural/fibers(get_turf(user))
				qdel(W)
		else
			src.storedfiber = src.storedfiber + W.amount
			to_chat(user, "Вы натягиваете волокно на [src].")
			qdel(W)
	if(istype(I, /obj/item/natural/fibers))
		var/obj/item/natural/fibers/W = I
		if(src.storedfiber < src.maxfiber)
			src.storedfiber++
			to_chat(user, "Вы натягиваете волокно на [src].")
			qdel(W)
		else
			to_chat(user, "Невозможно добавить больше волокон.")
	. = ..()

/obj/machinery/loom/attack_right(mob/user)
	var/mob/living/L = user
	if(isliving(user) && L.stat == CONSCIOUS && !user.get_active_held_item())
		if(src.storedfiber > 0)
			to_chat(user, "Вы снимаете прядь с [src].")
			src.storedfiber--
			var/obj/item/natural/fibers/F = new (src.loc)
			L.put_in_hands(F)
		else
			to_chat(user, "На [src] ничего нет.")

/obj/machinery/loom/attack_hand(mob/user)
	var/mob/living/weaver = user
	var/weavetime = 2 SECONDS //time to weave a cloth, duh
	var/skilltimemod = 0.2 SECONDS //how much each level of skill lowers the time to weave
	var/skill = weaver.mind.get_skill_level(/datum/skill/misc/sewing)
	if(isliving(user) && weaver.stat == CONSCIOUS)
		if(src.storedfiber < 2)
			to_chat(user, "Недостаточно волокон для этого.")
		else
			to_chat(user, "Вы начинаете ткать полотно...")
			while(src.storedfiber > 1)
				if(!do_after(weaver, (weavetime - (skilltimemod*skill)),target = src) || src.storedfiber < 2)
					break
				src.storedfiber -= 2
				new /obj/item/natural/cloth(get_turf(src))
				weaver.mind.add_sleep_experience(/datum/skill/misc/sewing, (weaver.STAINT*0.5))//you get less exp from using the loom

/obj/machinery/loom/examine(mob/user)
	to_chat(user, span_notice("На [src] натянуто [storedfiber] прядей волокна."))
	. = ..()
