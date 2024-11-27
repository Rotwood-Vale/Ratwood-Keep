//Contains the target item datums for Steal objectives.

/datum/objective_item
	var/name = "A silly bike horn! Honk!"
	var/targetitem = /obj/item/bikehorn		//typepath of the objective item
	var/difficulty = 9001							//vaguely how hard it is to do this objective
	var/list/excludefromjob = list()				//If you don't want a job to get a certain objective (no captain stealing his own medal, etcetc)
	var/list/altitems = list()				//Items which can serve as an alternative to the objective (darn you blueprints)
	var/list/special_equipment = list()

/datum/objective_item/proc/check_special_completion() //for objectives with special checks (is that slime extract unused? does that intellicard have an ai in it? etcetc)
	return 1

/datum/objective_item/proc/TargetExists()
	return TRUE

/datum/objective_item/steal/New()
	..()
	if(TargetExists())
		GLOB.possible_items += src
	else
		qdel(src)

/datum/objective_item/steal/Destroy()
	GLOB.possible_items -= src
	return ..()

/datum/objective_item/steal/rogue/ledger
	name = "the merchant's catatoma."
	targetitem = /obj/item/book/rogue/secret/ledger
	difficulty = 2
	excludefromjob = list("Merchant")

/datum/objective_item/steal/rogue/mkey
	name = "the master key."
	targetitem = /obj/item/roguekey/lord
	difficulty = 3
	excludefromjob = list("Lord", "Royal Guard")

/datum/objective_item/steal/rogue/spices
	name = "a pepper mill."
	targetitem = /obj/item/reagent_containers/food/condiment/peppermill
	difficulty = 1
	excludefromjob = list("Cook")

/datum/objective_item/steal/rogue/crown
	name = "the Lord's crown."
	targetitem = /obj/item/clothing/head/roguetown/crown/serpcrown
	difficulty = 3
	excludefromjob = list("Grand Duke", "Consort", "Royal Guard")


////////////////////////////////////////////////////////////

/datum/objective_item/steal/magboots
	name = "the chief engineer's advanced magnetic boots."
	targetitem =  /obj/item/clothing/shoes/magboots/advance
	difficulty = 5
	excludefromjob = list("Chief Engineer")

/datum/objective_item/steal/capmedal
	name = "the medal of captaincy."
	targetitem = /obj/item/clothing/accessory/medal/gold/captain
	difficulty = 5
	excludefromjob = list("Captain")

/datum/objective_item/steal/hypo
	name = "the hypospray."
	targetitem = /obj/item/reagent_containers/hypospray/CMO
	difficulty = 5
	excludefromjob = list("Chief Medical Officer")

/datum/objective_item/steal/reflector
	name = "a reflector trenchcoat."
	targetitem = /obj/item/clothing/suit/hooded/ablative
	difficulty = 3
	excludefromjob = list("Head of Security", "Warden")

/datum/objective_item/steal/documents
	name = "any set of secret documents of any organization."
	targetitem = /obj/item/documents //Any set of secret documents. Doesn't have to be NT's
	difficulty = 5

//Items with special checks!
/datum/objective_item/steal/plasma
	name = "28 moles of plasma (full tank)."
	targetitem = /obj/item/tank
	difficulty = 3
	excludefromjob = list("Chief Engineer","Research Director","Station Engineer","Scientist","Atmospheric Technician")

/datum/objective_item/steal/plasma/check_special_completion(obj/item/tank/T)
	var/target_amount = text2num(name)
	var/found_amount = 0
	found_amount += T.air_contents.gases[/datum/gas/plasma] ? T.air_contents.gases[/datum/gas/plasma][MOLES] : 0
	return found_amount>=target_amount

/datum/objective_item/steal/blueprints
	name = "the station blueprints."
	targetitem = /obj/item/areaeditor/blueprints
	difficulty = 10
	excludefromjob = list("Chief Engineer")
	altitems = list(/obj/item/photo)

/datum/objective_item/steal/blueprints/check_special_completion(obj/item/I)
	if(istype(I, /obj/item/areaeditor/blueprints))
		return TRUE
	if(istype(I, /obj/item/photo))
		var/obj/item/photo/P = I
		if(P.picture.has_blueprints)	//if the blueprints are in frame
			return TRUE
	return FALSE

/datum/objective_item/steal/slime
	name = "an unused sample of slime extract."
	targetitem = /obj/item/slime_extract
	difficulty = 3
	excludefromjob = list("Research Director","Scientist")

/datum/objective_item/steal/slime/check_special_completion(obj/item/slime_extract/E)
	if(E.Uses > 0)
		return 1
	return 0

//Unique Objectives
/datum/objective_item/unique/docs_red
	name = "the \"Red\" secret documents."
	targetitem = /obj/item/documents/syndicate/red
	difficulty = 10

/datum/objective_item/unique/docs_blue
	name = "the \"Blue\" secret documents."
	targetitem = /obj/item/documents/syndicate/blue
	difficulty = 10

/datum/objective_item/special/New()
	..()
	if(TargetExists())
		GLOB.possible_items_special += src
	else
		qdel(src)

/datum/objective_item/special/Destroy()
	GLOB.possible_items_special -= src
	return ..()

//Old ninja objectives.
/datum/objective_item/special/pinpointer/nuke
	name = "the captain's pinpointer."
	targetitem = /obj/item/pinpointer
	difficulty = 10

/datum/objective_item/special/ddrill
	name = "a diamond drill."
	targetitem = /obj/item/pickaxe/drill/diamonddrill
	difficulty = 10

/datum/objective_item/special/boh
	name = "a bag of holding."
	targetitem = /obj/item/storage/backpack/holding
	difficulty = 10

/datum/objective_item/special/corgimeat
	name = "a piece of corgi meat."
	targetitem = /obj/item/reagent_containers/food/snacks/meat/slab/corgi
	difficulty = 5

/datum/objective_item/stack/New()
	..()
	if(TargetExists())
		GLOB.possible_items_special += src
	else
		qdel(src)

/datum/objective_item/stack/Destroy()
	GLOB.possible_items_special -= src
	return ..()

//Stack objectives get their own subtype
/datum/objective_item/stack
	name = "5 cardboard."
	targetitem = /obj/item/stack/sheet/cardboard
	difficulty = 9001

/datum/objective_item/stack/check_special_completion(obj/item/stack/S)
	var/target_amount = text2num(name)
	var/found_amount = 0

	if(istype(S, targetitem))
		found_amount = S.amount
	return found_amount>=target_amount

/datum/objective_item/stack/diamond
	name = "10 diamonds."
	targetitem = /obj/item/stack/sheet/mineral/diamond
	difficulty = 10

/datum/objective_item/stack/gold
	name = "50 gold bars."
	targetitem = /obj/item/stack/sheet/mineral/gold
	difficulty = 15

/datum/objective_item/stack/uranium
	name = "25 refined uranium bars."
	targetitem = /obj/item/stack/sheet/mineral/uranium
	difficulty = 10
