/client/verb/toggle_tail()
	set category = "Options"
	set name = "Toggle Tail Visibility"

	var/mob/living/carbon/human/H = usr
	H.tail_toggle = !H.tail_toggle
	H.update_body_parts(TRUE)
