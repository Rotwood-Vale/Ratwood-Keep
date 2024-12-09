/* Library Items
 *
 * Contains:
 *		Bookcase
 *		Book
 *		Barcode Scanner
 */

/*
 * Bookcase
 */

/obj/structure/bookcase
	name = "bookcase"
	icon = 'icons/roguetown/misc/bookshelf.dmi'
	icon_state = "bookcase"
	var/based = "a"
	desc = ""
	anchored = FALSE
	density = TRUE
	opacity = 1
	resistance_flags = FLAMMABLE
	max_integrity = 200
	armor = list("blunt" = 0, "slash" = 0, "stab" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0)
	var/state = 0
	var/list/allowed_books = list(/obj/item/book, /obj/item/storage/book) //Things allowed in the bookcase

/obj/structure/bookcase/examine(mob/user)
	. = ..()
//	if(!anchored)
//		. += span_notice("The <i>bolts</i> on the bottom are unsecured.")
//	else
//		. += span_notice("It's secured in place with <b>bolts</b>.")
//	switch(state)
///		if(0)
//	//		. += span_notice("There's a <b>small crack</b> visible on the back panel.")
//	//	if(1)
//	//		. += span_notice("There's space inside for a <i>wooden</i> shelf.")
//	//	if(2)
//	//		. += span_notice("There's a <b>small crack</b> visible on the shelf.")

/obj/structure/bookcase/Initialize(mapload)
	. = ..()
	if(!mapload)
		return
	based = pick("a","b","c","d","e","f","g","h")
	state = 2
	anchored = TRUE
	for(var/obj/item/I in loc)
		if(istype(I, /obj/item/book))
			I.forceMove(src)
	update_icon()

/obj/structure/bookcase/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!istype(user))
		return
	if(contents.len)
		var/obj/item/book/choice = input(user, "Which book would you like to remove from the shelf?") as null|obj in contents.Copy()
		if(choice)
			if(!(user.mobility_flags & MOBILITY_USE) || user.stat || user.restrained() || !in_range(loc, user))
				return
			if(ishuman(user))
				if(!user.get_active_held_item())
					user.put_in_hands(choice)
			else
				choice.forceMove(drop_location())
			update_icon()


/obj/structure/bookcase/deconstruct(disassembled = TRUE)
//	new /obj/item/stack/sheet/mineral/wood(loc, 4)
	for(var/obj/item/book/B in contents)
		B.forceMove(get_turf(src))
	qdel(src)


/obj/structure/bookcase/update_icon()
	if((contents.len >= 1) && (contents.len <= 15))
		icon_state = "[based][contents.len]"
	else
		icon_state = "bookcase"


/obj/structure/bookcase/manuals/medical
	name = "medical manuals bookcase"

/obj/structure/bookcase/manuals/medical/Initialize()
	. = ..()
	new /obj/item/book/manual/wiki/medical_cloning(src)
	update_icon()


/obj/structure/bookcase/manuals/engineering
	name = "engineering manuals bookcase"

/obj/structure/bookcase/manuals/engineering/Initialize()
	. = ..()
	new /obj/item/book/manual/wiki/engineering_construction(src)
	new /obj/item/book/manual/wiki/engineering_hacking(src)
	new /obj/item/book/manual/wiki/engineering_guide(src)
	new /obj/item/book/manual/wiki/engineering_singulo_tesla(src)
	new /obj/item/book/manual/wiki/robotics_cyborgs(src)
	update_icon()


/obj/structure/bookcase/manuals/research_and_development
	name = "\improper R&D manuals bookcase"

/obj/structure/bookcase/manuals/research_and_development/Initialize()
	. = ..()
	new /obj/item/book/manual/wiki/research_and_development(src)
	update_icon()

/*
 * Barcode Scanner
 */
/*
/obj/item/barcodescanner
	name = "barcode scanner"
	icon = 'icons/obj/library.dmi'
	icon_state ="scanner"
	desc = ""
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	var/obj/machinery/computer/libraryconsole/bookmanagement/computer	//Associated computer - Modes 1 to 3 use this
	var/obj/item/book/book			//Currently scanned book
	var/mode = 0							//0 - Scan only, 1 - Scan and Set Buffer, 2 - Scan and Attempt to Check In, 3 - Scan and Attempt to Add to Inventory

/obj/item/barcodescanner/attack_self(mob/user)
	mode += 1
	if(mode > 3)
		mode = 0
	to_chat(user, "[src] Status Display:")
	var/modedesc
	switch(mode)
		if(0)
			modedesc = ""
		if(1)
			modedesc = ""
		if(2)
			modedesc = ""
		if(3)
			modedesc = ""
		else
			modedesc = ""
	to_chat(user, " - Mode [mode] : [modedesc]")
	if(computer)
		to_chat(user, "<font color=green>Computer has been associated with this unit.</font>")
	else
		to_chat(user, "<font color=red>No associated computer found. Only local scans will function properly.</font>")
	to_chat(user, "\n")
*/
