// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.

/obj/item/organ/tail
	name = "tail"
	desc = ""
	icon_state = "severedtail"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	var/tail_type = "None"

/obj/item/organ/tail/cat
	name = "cat tail"
	desc = ""
	tail_type = "Cat"

/obj/item/organ/tail/lizard
	name = "sissean tail"
	desc = ""
	color = "#116611"
	tail_type = "Smooth"
