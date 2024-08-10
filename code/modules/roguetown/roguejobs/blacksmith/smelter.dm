
/obj/item
	var/smeltresult

/obj/machinery/light/rogue/smelter
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "stone furnace"
	desc = "A stone furnace, weathered by time and heat."
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
	var/actively_smelting = FALSE // Are we currently smelting?
	fueluse = 5 MINUTES
	crossfire = FALSE

/obj/machinery/light/rogue/smelter/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/rogueweapon/tongs))
		if(!actively_smelting) // Prevents an exp gain exploit. - Stonekeep exploit fix by Foxtrot
			var/obj/item/rogueweapon/tongs/T = W
			if(ore.len && !T.hingot)
				var/obj/item/I = ore[ore.len]
				ore -= I
				I.forceMove(T)
				T.hingot = I
				if(user.mind && isliving(user) && T.hingot?.smeltresult) // Prevents an exploit with coal and runtimes with everything else
					if(!istype(T.hingot, /obj/item/rogueore) && T.hingot?.smelted) // Burning items to ash won't level smelting.
						var/mob/living/L = user
						var/boon = user.mind.get_learning_boon(/datum/skill/craft/smelting)
						var/amt2raise = L.STAINT*2 // Smelting is already a timesink, this is justified to accelerate levelling
						if(amt2raise > 0)
							user.mind.adjust_experience(/datum/skill/craft/smelting, amt2raise * boon, FALSE)
				user.visible_message("<span class='info'>[user] retrieves [I] from [src].</span>")
				if(on)
					var/tyme = world.time
					T.hott = tyme
					addtimer(CALLBACK(T, TYPE_PROC_REF(/obj/item/rogueweapon/tongs, make_unhot), tyme), 50)
				T.update_icon()
				return
			if(on)
				to_chat(user, "<span class='info'>Nothing to retrieve from inside.</span>")
				return // Safety for not smelting our tongs
			else
				to_chat(user, "<span class='warning'>\The [src] is currently smelting. Wait for it to finish, or douse it with water to retrieve items from it.</span>")
				return
	
	if(istype(W, /obj/item/rogueore/coal) && fueluse <= 0)
		return ..()
	if(W.smeltresult)
		if(ore.len < maxore)
			W.forceMove(src)
			ore += W
			if(!isliving(user) || !user.mind)
				ore[W] = SMELTERY_LEVEL_SPOIL
			else
				var/datum/mind/smelter_mind = user.mind
				var/smelter_exp = smelter_mind.get_skill_level(/datum/skill/craft/smelting)
				//Fine to Legendary removed; caused issues of exploits. But you still gain EXP to stop making sub-par quality armor.
				ore[W] = floor(rand(smelter_exp*15, max(63, smelter_exp*25))/25) // (0-25 spoil, 25-50 poor, 50-75, normal, 75-onwards good) no skill = 0, 63, novice = 15, 63, apprentice = 30, 63, skilled = 45, 75, expert = 60, 100, master = 75, 125, legendary = 100, 150, (may want to add a tier above good)
			user.visible_message(span_warning("[user] puts something in the smelter."))
			cooking = 0
			return
		else
			to_chat(user, span_warning("[W.name] can be smelted, but [src] is full."))
	else
		to_chat(user, span_warning("[W.name] cannot be smelted."))
	return ..()


/obj/machinery/light/rogue/smelter/attack_hand(mob/user, params)
	if(on)
		to_chat(user, "<span class='warning'>It's too hot to retrieve bars with your hands.</span>")
		return
	if(ore.len)
		var/obj/item/I = ore[ore.len]
		ore -= I
		I.loc = user.loc
		user.put_in_active_hand(I)
		user.visible_message("<span class='info'>[user] retrieves \the [I] from \the [src].</span>")
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
				actively_smelting = TRUE
			else
				if(cooking == 20)
					for(var/obj/item/I in ore)
						if(I.smeltresult)
							var/obj/item/R = new I.smeltresult(src, ore[I])
							ore -= I
							ore += R
							qdel(I)
					playsound(src,'sound/misc/smelter_fin.ogg', 100, FALSE)
					cooking = 21
					actively_smelting = FALSE

/obj/machinery/light/rogue/smelter/burn_out()
	cooking = 0
	actively_smelting = FALSE
	..()

/obj/machinery/light/rogue/smelter/great
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "great furnace"
	desc = "The pinnacle of dwarven engineering and the miracle of Malum's blessed fire crystal, allowing for greater alloys to be made."
	icon_state = "smelter0"
	base_state = "smelter"
	anchored = TRUE
	density = TRUE
	maxore = 4
	fueluse = 10 MINUTES
	climbable = FALSE

/obj/machinery/light/rogue/smelter/great/process()
	..()
	if(on)
		if(ore.len)
			if(cooking < 30)
				cooking++
				playsound(src.loc,'sound/misc/smelter_sound.ogg', 50, FALSE)
				actively_smelting = TRUE
			else
				if(cooking == 30)
					var/alloy
					for(var/obj/item/I in ore)
						if(I.smeltresult == /obj/item/rogueore/coal)
							alloy = alloy + 1
						if(I.smeltresult == /obj/item/ingot/iron)
							alloy = alloy + 2
					if(alloy == 7)
						testing("ALLOYED")
						alloy = /obj/item/ingot/steel
					else
						alloy = null
					if(alloy)
						var/floor_mean_quality = SMELTERY_LEVEL_SPOIL // the smelting quality of all ores added together, divided by the number of ores, and then rounded to the lowest integer (this isn't done until after the for loop)
						var/ore_deleted = 0
						for(var/obj/item/I in ore)
							floor_mean_quality += ore[I]
							ore_deleted += 1
							ore -= I
							qdel(I)
						floor_mean_quality = floor(floor_mean_quality/ore_deleted)
						for(var/i in 1 to maxore)
							var/obj/item/R = new alloy(src, floor_mean_quality)
							ore += R
					else
						for(var/obj/item/I in ore)
							if(I.smeltresult)
								var/obj/item/R = new I.smeltresult(src, ore[I])
								ore -= I
								ore += R
								qdel(I)
					playsound(src,'sound/misc/smelter_fin.ogg', 100, FALSE)
					visible_message("<span class='notice'>\The [src] finished smelting.</span>")
					cooking = 31
					actively_smelting = FALSE
