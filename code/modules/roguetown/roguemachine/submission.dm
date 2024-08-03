/*				//Var for keeping track of timer
var/global/feeding_hole_wheat_count = 0
var/global/feeding_hole_reset_timer
*/
			//WIP for now it does really nothing, but people will be gaslighted into thinking it does.
/obj/structure/feedinghole
	name = "FEEDING HOLE"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "feedinghole"
	density = FALSE
	pixel_y = 32

/obj/structure/feedinghole/attackby(obj/item/P, mob/user, params)
/*	if(feeding_hole_wheat_count < 5)
		user << "You hear squeaks coming from the hole, but it seems inactive."

		return*/
	if(ishuman(user))
		attemptstockpile(P)
	return ..()

/obj/structure/feedinghole/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	var/contents = "<center>FEEDING HOLE<BR>"

	contents += "----------<BR>"

	contents += "Feed the hole<BR>"

	contents += "</center>"

	var/datum/browser/popup = new(user, "FEEDINGHOLE", "", 370, 400)
	popup.set_content(contents)
	popup.open()

/obj/structure/feedinghole/attack_right(mob/user)
	if(ishuman(user))
		for(var/obj/I in get_turf(src))
			attemptstockpile(I, user, FALSE, FALSE)
		say("Bulk stockpiling in progress...")
		playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
		playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)

// ripped out of stockpile machine, this deserves a future refactor
/obj/structure/feedinghole/proc/attemptstockpile(obj/item/I, mob/H, sound = TRUE)
	for(var/datum/roguestock/R in SStreasury.stockpile_datums)
		if(istype(I, /obj/item/natural/bundle))
			var/obj/item/natural/bundle/B = I
			if(B.stacktype == R.item_type)
				R.held_items[1] += B.amount
				qdel(B)
				if(sound == TRUE)
					playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
			continue
		else if(istype(I,R.item_type))
			if(!R.check_item(I))
				continue
			if(!R.transport_item)
				R.held_items[1] += 1 //stacked logs need to check for multiple
				qdel(I)
				if(sound == TRUE)
					playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
			else
				var/area/A = GLOB.areas_by_type[R.transport_item]
				if(!A)
					say("Couldn't find where to send the submission.")
					return
				I.submitted_to_stockpile = TRUE
				var/list/turfs = list()
				for(var/turf/T in A)
					turfs += T
				var/turf/T = pick(turfs)
				I.forceMove(T)
				if(sound == TRUE)
					playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
			return
