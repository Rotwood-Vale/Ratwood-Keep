
SUBSYSTEM_DEF(library)
	name = "library"
	wait = 1
	priority = FIRE_PRIORITY_WATER_LEVEL
	var/library_value = 0
	var/list/stockpile_datums = list()
	var/multiple_item_penalty = 0.66
	var/next_library_check = 0

/datum/controller/subsystem/library/Initialize()
	library_value = rand(100,300)
	return ..()

/datum/controller/subsystem/library/fire(resumed = 0)
	if(world.time > next_library_check)
		next_library_check = world.time + rand(5 MINUTES, 8 MINUTES)
		var/list/stockpile_items = list()

		if(SSticker.current_state == GAME_STATE_PLAYING)

		var/area/A = GLOB.areas_by_type[/area/rogue/indoors/town/library]
		var/amt_to_generate = 0

		for(var/obj/item/I in A)
			if(!isturf(I.loc))
				continue
			if(I.get_real_price() <= 0 || !istype(I, /obj/item/book/granter/spell))
				continue
			if(!I.submitted_to_stockpile)
				I.submitted_to_stockpile = TRUE
			if(I.type in stockpile_items)
				stockpile_items[I.type] *= multiple_item_penalty
			else
				stockpile_items[I.type] = I.get_real_price()

			amt_to_generate += (stockpile_items[I.type])

		amt_to_generate = round(amt_to_generate)

		//increase ink
		give_ink_library(amt_to_generate, "library")

		//inform the tower staff
		var/people_told = 0
		for(var/mob/living/carbon/human/X in GLOB.human_list)
			switch(X.job)
				if("Court Magician", "Magicians Apprentice")
					people_told += 1
					send_ooc_note("Arcyne ink from library: +[amt_to_generate]", name = X.real_name)
					if(people_told > 3)
						return

/datum/controller/subsystem/library/proc/give_ink_library(amt, source)
	if(!amt)
		return
	library_value += amt

/datum/controller/subsystem/library/proc/remove_ink_library(amt, source)
	if(!amt)
		return
	library_value -= amt
