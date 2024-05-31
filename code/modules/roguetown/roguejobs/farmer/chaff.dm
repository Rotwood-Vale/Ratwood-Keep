/obj/item/natural/chaff
	icon = 'icons/roguetown/items/produce.dmi'
	var/foodextracted = null
	name = "chaff"
	icon_state = "chaff1"
	desc = ""
	var/chafftype = 1
	var/canthresh = TRUE
	//dropshrink = 0.75

/obj/item/natural/chaff/attack_right(mob/user)
	if(foodextracted && !user.get_active_held_item())
		to_chat(user, "<span class='warning'>I start to shuck [src]...</span>")
		if(move_after(user,40, target = src)) //ROGTODO make this based on farming skill and speed
			user.visible_message("<span class='notice'>[user] shucks [src].</span>", \
								"<span class='notice'>I shuck [src].</span>")
			testing("1")
			var/obj/item/G = new foodextracted(get_turf(src))
			user.put_in_active_hand(G)
			new /obj/item/natural/fibers(get_turf(src))
			qdel(src)

/obj/item/natural/chaff/proc/thresh()
	if(foodextracted && canthresh)
		new foodextracted(loc)
		new /obj/item/natural/fibers(loc)
		qdel(src)

/obj/item/natural/chaff/attackby(obj/item/I, mob/living/user, params)
	testing("attackb")
	if(istype(I, /obj/item/rogueweapon/pitchfork))
		if(user.used_intent.type == DUMP_INTENT)
			var/obj/item/rogueweapon/pitchfork/W = I
			if(I.wielded)
				if(isturf(loc))
					var/stuff = 0
					for(var/obj/item/natural/chaff/R in loc)
						if(W.forked.len <= 19)
							R.forceMove(W)
							W.forked += R
							stuff++
					if(stuff)
						to_chat(user, "<span class='notice'>I pick up the stalks with the pitchfork.</span>")
					else
						to_chat(user, "<span class='warning'>I'm carrying enough with the pitchfork.</span>")
					W.update_icon()
					return

	if(istype(I, /obj/item/rogueweapon/mace/woodclub))//reused some commented out code
		var/statboost = user.STASTR*3 + (user?.mind?.get_skill_level(/datum/skill/labor/farming)*5) //a person with no skill and 10 strength will thresh about a third of the stalks on average
		var/threshchance = clamp(statboost, 20, 100)
		for(var/obj/item/natural/chaff/C in get_turf(src))
			if(C == src)//so it doesnt delete itself and stop the loop
				continue
			if(prob(threshchance))
				C.thresh()
		user.visible_message("<span class='notice'>[user] threshes the stalks!</span>", \
							"<span class='notice'>I thresh the stalks.</span>")
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(loc,"plantcross", 100, FALSE)
		playsound(loc,"smashlimb", 50, FALSE)
		src.thresh()
		return
	..()
