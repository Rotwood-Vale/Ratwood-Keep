
/datum/roguestock/stockpile/stone
	payout_price = 0
	passive_generation = 15

/datum/roguestock/stockpile/gold
	payout_price = 15
	withdraw_price = 80
	export_price = 80

/datum/roguestock/stockpile/silver // Используется в крафте оружия против нечисти И драгоценностях
	payout_price = 15
	withdraw_price = 65
	export_price = 65

/datum/roguestock/stockpile/cured
	payout_price = 5
	withdraw_price = 10
	export_price = 10

/datum/roguestock/stockpile/hide
	payout_price = 10
	withdraw_price = 15
	export_price = 15

/datum/roguestock/stockpile/fur
	payout_price = 10
	withdraw_price = 15
	export_price = 15

/datum/roguestock/stockpile/grain
	payout_price = 1

/datum/roguestock/stockpile/oat
	payout_price = 1

/datum/roguestock/stockpile/apple
	payout_price = 2
	withdraw_price = 5

/datum/roguestock/stockpile/meat
	payout_price = 5
	withdraw_price = 10
	export_price = 10

/datum/roguestock/stockpile/beet
	payout_price = 2
	withdraw_price = 6
	export_price = 6

/datum/roguestock/stockpile/cabbage
	payout_price = 2
	withdraw_price = 6
	export_price = 6

/datum/roguestock/stockpile/potato
	payout_price = 2
	withdraw_price = 6
	export_price = 6

/datum/roguestock/stockpile/onion
	payout_price = 2
	withdraw_price = 6
	export_price = 6

/datum/roguestock/stockpile/poultry
	payout_price = 5
	withdraw_price = 10
	export_price = 10

/datum/roguestock/stockpile/fishmince
	name = "Fish Mince"
	desc = "Descaled and ground fish meat."
	item_type = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	held_items = list(0, 0)
	payout_price = 2
	withdraw_price = 4
	transport_fee = 1
	export_price = 3
	importexport_amt = 10

/datum/roguestock/stockpile/fat
	name = "Fat"
	desc = "Greasy flesh from an animal."
	item_type = /obj/item/reagent_containers/food/snacks/fat
	payout_price = 3
	withdraw_price = 5
	transport_fee = 1
	export_price = 5
	importexport_amt = 5

/datum/roguestock/stockpile/honey
	name = "Honey"
	desc = "Definitely not spider milk. Delicacy."
	item_type = /obj/item/reagent_containers/food/snacks/rogue/honey
	payout_price = 3
	withdraw_price = 5
	transport_fee = 2
	export_price = 5
	importexport_amt = 1

/datum/roguestock/stockpile/silk
	name = "Silk"
	desc = "Silken strands. Their usage in clothing is exotic in all places save the underdark"
	item_type = /obj/item/natural/silk
	payout_price = 2
	withdraw_price = 4
	transport_fee = 2
	export_price = 5
	importexport_amt = 1
