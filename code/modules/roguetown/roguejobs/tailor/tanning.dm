/obj/machinery/tanningrack
	name = "сушилка"
	desc = "Сушилка для выделки кожи из шкур, которую можно передвигать с помощью деревянного кола."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "dryrack"
	var/obj/item/natural/hide/hide
	max_integrity = 200
	density = TRUE
	climbable = TRUE
	anchored = TRUE
	blade_dulling = DULLING_BASHCHOP
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')

/obj/machinery/tanningrack/examine(mob/user)
	. = ..()
	if(hide)
		. += span_warning("Здесь натянута шкура, готовая к обработке. Мне понадобиться нож для этого.")
	if(!anchored)
		. += span_warning("Сушилка не закреплена и может быть передвинута.")

/obj/machinery/tanningrack/attack_hand(mob/user, params)
	if(hide)
		var/obj/item/I = hide
		hide = null
		I.loc = user.loc
		user.put_in_active_hand(I)
		update_icon()

/obj/machinery/tanningrack/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/natural/hide) && !istype(I, /obj/item/natural/hide/cured))
		if(!hide)
			I.forceMove(src)
			hide = I
			update_icon()
			return
		else
			to_chat(user, span_warning("Здесь уже натянута шкура!"))
			return
	if((user.used_intent.type == /datum/intent/dagger/cut || user.used_intent.type == /datum/intent/sword/cut || user.used_intent.type == /datum/intent/axe/cut) && hide)
		if(anchored)
			var/skill_level = user.mind.get_skill_level(/datum/skill/craft/hunting)
			var/work_time = (120 - (skill_level * 15))
			var/pieces_to_spawn = rand(1, min(skill_level + 1, 6)) //Random number from 1 to skill level
			var/sound_played = FALSE
			to_chat(user, span_warning("Начинаю соскребать волосы и мездру со шкуры..."))
			if(!do_after(user, work_time, target = user))
				return
			playsound(src,pick('sound/items/book_open.ogg','sound/items/book_page.ogg'), 100, FALSE)
			hide = null
			user.mind.add_sleep_experience(/datum/skill/craft/hunting, user.STAINT * 2) //these numbers may need some revision
			update_icon()
			for(var/i = 0; i < pieces_to_spawn; i++)
				if(prob(skill_level + user.goodluck(2)))
					new /obj/item/natural/cured/essence(get_turf(user))
					if(!sound_played)
						sound_played = TRUE
						to_chat(user, span_warning("Дендор благоволит..."))
						playsound(src,pick('sound/items/gem.ogg'), 100, FALSE)
				else
					new /obj/item/natural/hide/cured(get_turf(user))
			return
		else
			to_chat(user, span_warning("Нужно закрепить сушилку деревянным колом, прежде чем обрабатывать шкуру."))
			return
	if(istype(I, /obj/item/grown/log/tree/stake))
		if(anchored)
			anchored = FALSE
			to_chat(user, span_warning("[src] теперь можно передвинуть."))
		else
			anchored = TRUE
			to_chat(user, span_warning("Вы закрепляете [src]."))
		playsound(src,pick('sound/foley/woodclimb.ogg'), 100, TRUE)
		return
	..()

/obj/machinery/tanningrack/update_icon()
	cut_overlays()
	if(hide)
		var/obj/item/I = hide
		I.pixel_x = 0
		I.pixel_y = 0
		var/mutable_appearance/M = new /mutable_appearance(I)
		M.pixel_y = 0
		M.pixel_x = 0
		add_overlay(M)
