/obj/item/natural/hide
	name = "hide"
	icon_state = "hide"
	desc = "Hide from one of Gott's creachers."
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sellprice = 20

/obj/item/natural/hide/cured
	name = "cured leather"
	icon_state = "leather"
	desc = "A hide piece that has been cured and may now be worked."
	sellprice = 7
	bundletype = /obj/item/natural/bundle/curred_hide

/obj/item/natural/bundle/curred_hide
	name = "bundle of cured leather"
	desc = "A bunch of cured leather pieces bundled together."
	icon_state = "clothroll1"
	possible_item_intents = list(/datum/intent/use)
	maxamount = 10
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/hide/cured
	stackname = "cured leather"
	icon1 = "clothroll1"
	icon1step = 5
	icon2 = "clothroll2"
	icon2step = 10
	color = "#7a4c45"

/obj/item/natural/cured/masterwork //This has to be a different typepath so recipes dont use this type of leather
	name = "masterwork cured leather"
	icon_state = "leather"
	desc = "A hide piece that has been masterfully cured and may now be used by a talented craftsman."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sellprice = 20
	bundletype = null
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=2, color=rgb(255, 215, 0))

/obj/item/natural/bundle/curred_hide/masterwork
	name = "bundle of masterwork leather"
	desc = "A bunch of masterwork leather pieces bundled together."
	possible_item_intents = list(/datum/intent/use)
	maxamount = 10
	stacktype = /obj/item/natural/cured/masterwork
	stackname = "masterwork cured leather"
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=2, color=rgb(255, 215, 0))

/obj/item/natural/fur
	name = "fur"
	icon_state = "wool1"
	desc = "Fur from one of Gott's creachers."
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	color = "#5c5243"
	sellprice = 40

//RTD make this a storage item and make clickign on animals with things put it in storage
/obj/item/natural/saddle
	name = "saddle"
	icon_state = "saddle"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK_L
	resistance_flags = FLAMMABLE
	gripped_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	sellprice = 10
	twohands_required = TRUE

/obj/item/natural/saddle/attack(mob/living/target, mob/living/carbon/human/user)
	if(istype(target, /mob/living/simple_animal))
		testing("yea1")
		var/mob/living/simple_animal/S = target
		if(S.can_saddle && !S.ssaddle)
			testing("yea2")
			if(!target.has_buckled_mobs())
				user.visible_message(span_warning("[user] tries to saddle [target]..."))
				if(do_after(user, 40, target = target))
					S.name = input("Choose a new name for your mount!","Name", S.name)
					playsound(loc, 'sound/foley/saddledismount.ogg', 100, FALSE)
					user.dropItemToGround(src)
					S.ssaddle = src
					src.forceMove(S)
					S.update_icon()
		return
	..()

/mob/living/simple_animal
	var/can_saddle = FALSE
	var/obj/item/ssaddle

