#define DAMAGE_WEAK_FLAIL 17
#define DAMAGE_NORMAL_FLAIL 23 // WAS 15
#define DAMAGE_GOOD_FLAIL 28

#define AP_FLAIL_STRIKE 5
#define AP_FLAIL_SMASH 60

/obj/item/rogueweapon/flail
	force = DAMAGE_NORMAL_FLAIL
	w_class = WEIGHT_CLASS_NORMAL
	grid_width = 32
	grid_height = 96

/obj/item/rogueweapon/flail/sflail
	force = DAMAGE_GOOD_FLAIL

/*--------------\
| Strike intent |	small AP
\--------------*/
/datum/intent/flail/strike
	misscost = 5
	penfactor = AP_FLAIL_STRIKE

/datum/intent/flail/strike/long
	reach = 2
	misscost = 8


/*--------------\
| Smash intent |	20% force increase and huge AP, requires charging and has higher penalties
\--------------*/
/datum/intent/flail/strike/smash
	recovery = 10
	misscost = 10
	damfactor = 1.2
	penfactor = AP_FLAIL_SMASH

/datum/intent/flail/strike/smash/long
	reach = 2
	recovery = 12
	misscost = 12

/obj/item/rogueweapon/thresher/wflail
	force = DAMAGE_NORMAL_FLAIL
	force_wielded = DAMAGE_GOOD_FLAIL
	possible_item_intents = list(/datum/intent/flail/strike/long)
	gripped_intents = list(/datum/intent/flail/strike/long, /datum/intent/flail/strike/smash/long)
