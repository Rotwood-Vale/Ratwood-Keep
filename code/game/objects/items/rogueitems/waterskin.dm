/obj/item/reagent_containers/glass/bottle/waterskin
	name = "waterskin"
	desc = "A leather waterskin."
	icon_state = "waterskin"
	amount_per_transfer_from_this = 6
	possible_transfer_amounts = list(3,6,9)
	volume = 64
	dropshrink = 0.5
	sellprice = 5
	closed = FALSE
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	obj_flags = CAN_BE_HIT
	reagent_flags = OPENCONTAINER
	w_class =  WEIGHT_CLASS_NORMAL
	drinksounds = list('sound/items/drink_bottle (1).ogg','sound/items/drink_bottle (2).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')
	sewrepair = TRUE

/obj/item/reagent_containers/glass/bottle/waterskin/milk // Filled subtype used by the cheesemaker
	list_reagents = list(/datum/reagent/consumable/milk = 64)

/obj/item/reagent_containers/glass/bottle/waterskin/purifier
	name = "purifying waterskin"
	desc = "Bronze tubes spiral about from the mouth of this waterskin in complex, dizzying patterns."
	icon_state = "water-purifier"

/obj/item/reagent_containers/glass/bottle/waterskin/purifier/proc/cleanwater(mob/living/carbon/human/user)
	playsound(user, 'sound/items/waterfilter.ogg', 40, TRUE)
	to_chat(user, span_notice("I hear whizzing clockwork and gurgling water within [src]."))
	if (prob(25))
		new /obj/effect/temp_visual/small_smoke(user.loc)
		to_chat(user, span_notice("The device sputters and spews a cloud of steam." + span_warning(" How annoying!")))

