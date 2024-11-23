/obj/item/book/mimery
	name = "Guide to Dank Mimery"
	desc = ""
	icon_state ="bookmime"

/obj/item/book/mimery/attack_self(mob/user,)
	user.set_machine(src)
	var/dat = "<B>Guide to Dank Mimery</B><BR>"
	dat += "Teaches one of three classic pantomime routines, allowing a practiced mime to conjure invisible objects into corporeal existence.<BR>"
	dat += "Once you have mastered your routine, this book will have no more to say to you.<BR>"
	dat += "<HR>"
	dat += "<A href='byond://?src=[REF(src)];invisible_wall=1'>Invisible Wall</A><BR>"
	dat += "<A href='byond://?src=[REF(src)];invisible_chair=1'>Invisible Chair</A><BR>"
	dat += "<A href='byond://?src=[REF(src)];invisible_box=1'>Invisible Box</A><BR>"
	user << browse(dat, "window=book")

/obj/item/book/mimery/Topic(href, href_list)
	..()
	if (usr.stat || usr.restrained() || src.loc != usr)
		return
	if (!ishuman(usr))
		return
	var/mob/living/carbon/human/H = usr
	if(H.is_holding(src) && H.mind)
		H.set_machine(src)
		if (href_list["invisible_wall"])
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/conjure/mime_wall(null))
		if (href_list["invisible_chair"])
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/conjure/mime_chair(null))
		if (href_list["invisible_box"])
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/conjure/mime_box(null))
	to_chat(usr, span_notice("The book disappears into thin air."))
	qdel(src)
