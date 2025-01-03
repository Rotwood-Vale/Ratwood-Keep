/obj/machinery/light/rogue/smelter
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "каменная печь"
	desc = "Каменная печь, закаленная временем и жаром."
	icon_state = "cavesmelter0"
	base_state = "cavesmelter"
	anchored = TRUE
	density = TRUE
	climbable = TRUE
	climb_time = 0
	climb_offset = 10
	on = TRUE
	var/list/ore = list()
	var/maxore = 1
	var/cooking = 0
	fueluse = 30 MINUTES
	start_fuel = 5 MINUTES
	fuel_modifier = 0.33
	crossfire = FALSE

/obj/machinery/light/rogue/smelter/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/rogueweapon/tongs))
		var/obj/item/rogueweapon/tongs/T = W
		if(ore.len && !T.hingot)
			var/obj/item/I = ore[ore.len]
			ore -= I
			I.forceMove(T)
			T.hingot = I
			user.visible_message(span_info("[user] достает [I] из [src]."))
			if(on)
				var/tyme = world.time
				T.hott = tyme
				addtimer(CALLBACK(T, TYPE_PROC_REF(/obj/item/rogueweapon/tongs, make_unhot), tyme), 50)
			T.update_icon()
			return
		if(on)
			return

	if(W.firefuel)
		if (..())
			return

	if((ore.len < maxore) && W.smeltresult)
		W.forceMove(src)
		ore += W
		user.visible_message("<span class='warning'>[user] кладет что-то в плавильню.</span>")
		cooking = 0
		return
	else
		to_chat(user, span_warning("[W.name] не может быть переплавлен."))
	return ..()


/obj/machinery/light/rogue/smelter/attack_hand(mob/user, params)
	if(on)
		to_chat(user, span_warning("Слишком горячо."))
		return
	if(ore.len)
		var/obj/item/I = ore[ore.len]
		ore -= I
		I.loc = user.loc
		user.put_in_active_hand(I)
		user.visible_message(span_info("[user] достает [I] из [src]."))
	else
		return ..()

/obj/machinery/light/rogue/smelter/process()
	..()
	if(maxore > 1)
		return
	if(on)
		if(ore.len)
			if(cooking < 20)
				cooking++
				playsound(src.loc,'sound/misc/smelter_sound.ogg', 50, FALSE)
			else
				if(cooking == 20)
					for(var/obj/item/I in ore)	
						if(I.smeltresult)
							ore -= I
							var/obj/item/R = new I.smeltresult(src)
							ore += R
							qdel(I)
					playsound(src,'sound/misc/smelter_fin.ogg', 100, FALSE)
					cooking = 21

/obj/machinery/light/rogue/smelter/burn_out()
	cooking = 0
	..()

/obj/machinery/light/rogue/smelter/great
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "большая печь"
	icon_state = "smelter0"
	base_state = "smelter"
	anchored = TRUE
	density = TRUE
	maxore = 4
	climbable = FALSE

/obj/machinery/light/rogue/smelter/great/process()
	..()
	if(on)
		if(ore.len)
			if(cooking < 30)
				cooking++
				playsound(src.loc,'sound/misc/smelter_sound.ogg', 50, FALSE)
			else
				if(cooking == 30)

					var/alloy //moving each alloy to it's own var allows for possible additions later
					var/steelalloy
					var/bronzealloy
					var/blacksteelalloy

					for(var/obj/item/I in ore)
						if(I.smeltresult == /obj/item/rogueore/coal)
							steelalloy = steelalloy + 1
						if(I.smeltresult == /obj/item/ingot/iron)
							steelalloy = steelalloy + 2
						if(I.smeltresult == /obj/item/ingot/tin)
							bronzealloy = bronzealloy + 1
						if(I.smeltresult == /obj/item/ingot/copper)
							bronzealloy = bronzealloy + 2
						if(I.smeltresult == /obj/item/ingot/silver)
							blacksteelalloy = blacksteelalloy + 1
						if(I.smeltresult == /obj/item/ingot/steel)
							blacksteelalloy = blacksteelalloy + 2

					if(steelalloy == 7)
						testing("СТАЛЬ СПЛАВЛЕНА")
						maxore = 3 // Coal no longer turns to steel
						alloy = /obj/item/ingot/steel
					else if(bronzealloy == 7)
						testing("БРОНЗА СПЛАВЛЕНА")
						alloy = /obj/item/ingot/bronze
					else if(blacksteelalloy == 7)
						testing("ЧЕРНАЯ СТАЛЬ СПЛАВЛЕНА")
						alloy = /obj/item/ingot/blacksteel
					else
						alloy = null
						
					if(alloy)
						for(var/obj/item/I in ore)
							ore -= I
							qdel(I)
						for(var/i in 1 to maxore)
							var/obj/item/R = new alloy(src)
							ore += R
					else
						for(var/obj/item/I in ore)
							if(I.smeltresult)
								ore -= I
								var/obj/item/R = new I.smeltresult(src)
								ore += R
								qdel(I)
					maxore = initial(maxore)
					playsound(src,'sound/misc/smelter_fin.ogg', 100, FALSE)
					visible_message(span_notice("[src] завершена."))
					cooking = 31
