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
//		return
		if(istype(P, /obj/item/natural/bundle))
			say("Single item entries only. Please unstack.")
			return
		else
			for(var/datum/roguestock/R in SStreasury.stockpile_datums)
				if(istype(P,R.item_type))
					if(!R.check_item(P))
						continue
					if(!R.transport_item)
						R.held_items[1] += 1 //stacked logs need to check for multiple
						qdel(P)
						stock_announce("[R.name] has been stockpiled.")
					else
						var/area/A = GLOB.areas_by_type[R.transport_item]
						if(!A)
							say("Couldn't find where to send the submission.")
							return
						P.submitted_to_stockpile = TRUE
						var/list/turfs = list()
						for(var/turf/T in A)
							turfs += T
						var/turf/T = pick(turfs)
						P.forceMove(T)
						playsound(T, 'sound/misc/hiss.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					return
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

	var/datum/browser/popup = new(user, "FEEDINGHOLE", "", 370, 220)
	popup.set_content(contents)
	popup.open()
