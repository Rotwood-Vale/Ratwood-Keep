/datum/roguestock/import/normalredpotion
	name = "Crate of Health Potions"
	desc = "Red that keeps men alive."
	item_type = /obj/structure/closet/crate/chest/steward/normalredpotion
	export_price = 150
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/normalredpotion/Initialize()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)

/datum/roguestock/import/fbi_open_up
	name = "Crate with Xylix Miracle"
	desc = "A miracle for opening everything locked up."
	item_type = /obj/structure/closet/crate/chest/steward/fbi_open_up
	export_price = 3000
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/fbi_open_up/Initialize()
	. = ..()
	new /obj/item/fbi_open_up(src)
