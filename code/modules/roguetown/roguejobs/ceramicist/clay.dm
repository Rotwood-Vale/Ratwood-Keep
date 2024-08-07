/obj/item/natural/clay
	name = "clay"
	icon_state = "stone1"
	desc = "A handful of damp, malleable clay"
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 0
	throwforce = 0
	slot_flags = null
	obj_flags = null
	w_class = WEIGHT_CLASS_TINY
    var/glazed_result = null // What does this item turn into when glazed in a kiln?

    var/cooking = 0
    var/cooktime = 1 MINUTES

/obj/item/natural/clay/Initialize()
	. = ..()


/obj/item/proc/glaze(input as num)
	return

/obj/item/natural/clay/glaze(input as num, atom/A)
	if(!input)
		return
	if(cooktime)
		if(cooking < cooktime)
			cooking = cooking + input
			if(cooking >= cooktime)
				return glaze_act(A)
			return
	burning(input)

/obj/item/natural/clay/glaze_act(atom/A)
	var/obj/item/result = new /obj/item/ash(A) // Base case.
	if(istype(A,/obj/machinery/light/rogue/oven/kiln))
		if(glazed_result)
			result = new glazed_result(A)
		return result
	return result