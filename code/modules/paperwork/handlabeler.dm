/obj/item/hand_labeler
	name = "hand labeler"
	desc = ""
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "labeler0"
	item_state = "flight"
	var/label = null
	var/labels_left = 30
	var/mode = 0

/obj/item/hand_labeler/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is pointing [src] at [user.p_them()]self. [user.p_theyre(TRUE)] going to label [user.p_them()]self as a suicide!"))
	labels_left = max(labels_left - 1, 0)
	user.real_name += " (suicide)"

	// NOT EVEN DEATH WILL TAKE AWAY THE STAIN
	user.mind.name += " (suicide)"

	mode = 1
	icon_state = "labeler[mode]"
	label = "suicide"

	return OXYLOSS

/obj/item/hand_labeler/afterattack(atom/A, mob/user,proximity)
	. = ..()
	if(!proximity)
		return
	if(!mode)	//if it's off, give up.
		return

	if(!labels_left)
		to_chat(user, span_warning("No labels left!"))
		return
	if(!label || !length(label))
		to_chat(user, span_warning("No text set!"))
		return
	if(length(A.name) + length(label) > 64)
		to_chat(user, span_warning("Label too big!"))
		return
	if(ismob(A))
		to_chat(user, span_warning("I can't label creatures!")) // use a collar
		return

	user.visible_message(span_notice("[user] labels [A] as [label]."), \
						 span_notice("I label [A] as [label]."))
	A.name = "[A.name] ([label])"
	labels_left--


/obj/item/hand_labeler/attack_self(mob/user)
	if(!user.IsAdvancedToolUser())
		to_chat(user, span_warning("I don't have the dexterity to use [src]!"))
		return
	mode = !mode
	icon_state = "labeler[mode]"
	if(mode)
		to_chat(user, span_notice("I turn on [src]."))
		//Now let them chose the text.
		var/str = copytext(reject_bad_text(input(user,"Label text?","Set label","")),1,MAX_NAME_LEN)
		if(!str || !length(str))
			to_chat(user, span_warning("Invalid text!"))
			return
		label = str
		to_chat(user, span_notice("I set the text to '[str]'."))
	else
		to_chat(user, span_notice("I turn off [src]."))

/obj/item/hand_labeler/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/hand_labeler_refill))
		to_chat(user, span_notice("I insert [I] into [src]."))
		qdel(I)
		labels_left = initial(labels_left)	//Yes, it's capped at its initial value

/obj/item/hand_labeler_refill
	name = "hand labeler paper roll"
	icon = 'icons/obj/bureaucracy.dmi'
	desc = ""
	icon_state = "labeler_refill"
	item_state = "electropack"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
