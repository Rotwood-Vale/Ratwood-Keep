
/obj/item/roguegem
	name = "rontz"
	icon_state = "ruby_cut"
	icon = 'icons/roguetown/items/gems.dmi'
	desc = "Its facets shine so brightly.."
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH
	dropshrink = 0.4
	drop_sound = 'sound/items/gem.ogg'
	sellprice = 100
	static_price = FALSE
	mill_result = /obj/item/reagent_containers/powder/rontz

/obj/item/reagent_containers/powder/rontz
	name = "rontz dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "rontz_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 80

/datum/reagent/gemdust
	name = "Gemstone Dust"
	description = "Glassy."
	color = "#d7d0be" 
	overdose_threshold = 0
	metabolization_rate = 1

/datum/reagent/gemdust/on_mob_life(mob/living/carbon/M)
		M.adjust_blurriness(3)
		M.confused = max(M.confused+3,0)
		M.adjustBruteLoss(2)
		M.emote(pick("cough"))
		..()
		. = 1


/obj/item/roguegem/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -1,"sy" = 0,"nx" = 11,"ny" = 1,"wx" = 0,"wy" = 1,"ex" = 4,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = 0,"wturn" = 0,"eturn" = 39,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/roguegem/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(loc, pick('sound/items/gems (1).ogg','sound/items/gems (2).ogg'), 100, TRUE, -2)
	..()

/obj/item/roguegem/green
	name = "gemerald"
	icon_state = "emerald_cut"
	sellprice = 42
	desc = "Glints with verdant brilliance."
	mill_result = /obj/item/reagent_containers/powder/gemerald

/obj/item/reagent_containers/powder/gemerald
	name = "gemerald dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "gemerald_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 33

/obj/item/roguegem/blue
	name = "blortz"
	icon_state = "quartz_cut"
	sellprice = 88
	desc = "Pale blue, like a frozen tear." // i am not sure if this is really quartz.
	mill_result = /obj/item/reagent_containers/powder/blortz

/obj/item/reagent_containers/powder/blortz
	name = "blortz dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "blortz_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 70

/obj/item/roguegem/yellow
	name = "toper"
	icon_state = "topaz_cut"
	sellprice = 20
	desc = "Its amber hues remind you of the sunset."
	mill_result = /obj/item/reagent_containers/powder/toper

/obj/item/reagent_containers/powder/toper
	name = "toper dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "toper_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 16

/obj/item/roguegem/violet
	name = "saffira"
	icon_state = "sapphire_cut"
	sellprice = 56
	desc = "This gem is admired by many wizards."
	mill_result = /obj/item/reagent_containers/powder/saffira

/obj/item/reagent_containers/powder/saffira
	name = "saffira dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "saffira_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 44

/obj/item/roguegem/diamond
	name = "dorpel"
	icon_state = "diamond_cut"
	sellprice = 121
	desc = "Beautifully clear, it demands respect."
	mill_result = /obj/item/reagent_containers/powder/dorpel

/obj/item/reagent_containers/powder/dorpel
	name = "dorpel dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "dorpel_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 97

/obj/item/roguegem/random
	name = "random gem"
	desc = "You shouldn't be seeing this."
	icon_state = null

/obj/item/roguegem/random/Initialize()
	var/newgem = list(/obj/item/roguegem = 5, /obj/item/roguegem/green = 15, /obj/item/roguegem/blue = 10, /obj/item/roguegem/yellow = 20, /obj/item/roguegem/violet = 10, /obj/item/roguegem/diamond = 5, /obj/item/riddleofsteel = 1)
	var/pickgem = pickweight(newgem)
	new pickgem(get_turf(src))
	qdel(src)


/// riddle


/obj/item/riddleofsteel
	name = "riddle of steel"
	icon_state = "ros"
	icon = 'icons/roguetown/items/gems.dmi'
	desc = "Flesh, mind..."
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH
	dropshrink = 0.4
	drop_sound = 'sound/items/gem.ogg'
	sellprice = 400
	mill_result = /obj/item/reagent_containers/powder/mfire

/obj/item/reagent_containers/powder/mfire
	name = "malum's fire"
	desc = "...Matter over mind."
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "mfire"
	volume = 15
	list_reagents = list(/datum/reagent/mfire = 15)
	grind_results = list(/datum/reagent/mfire = 15)
	sellprice = 300

/datum/reagent/mfire
	name = "Malum's Fire"
	description = "Divine Burning."
	color = "#ffc229" 
	overdose_threshold = 0
	metabolization_rate = 0.5

/datum/reagent/mfire/on_mob_life(mob/living/carbon/M)
	if(HAS_TRAIT(M, TRAIT_MALUMSGRACE)) 
		M.apply_status_effect(/datum/status_effect/buff/mfire)
		if(holder.has_reagent(/datum/reagent/mfire))
			holder.remove_reagent(/datum/reagent/mfire, 15)
	if(HAS_TRAIT(M, TRAIT_CRACKHEAD)) // Baotha says you can do this drug too
		M.apply_status_effect(/datum/status_effect/buff/mfire)
		if(holder.has_reagent(/datum/reagent/mfire))
			holder.remove_reagent(/datum/reagent/mfire, 15)
	else
		M.adjust_fire_stacks(1) // You snorted divine fire and you're not one of his faithful? Burn.
		var/burndmg = max(0.3*M.fire_stacks, 0.3)
		M.adjustFireLoss(burndmg, 0)
	..()
	. = 1

/obj/item/riddleofsteel/Initialize()
	..()
	set_light(2, 1, "#ff0d0d")

/obj/item/reagent_containers/powder/mfire/Initialize()
	..()
	set_light(2, 1, "#ec6510")

/obj/item/reagent_containers/powder/sublimate // Gotten through alchemy, combine milled gemstone with moondust. Higher value dust, more sublimate.
	name = "arcyne sublimate"
	desc = "The stuff of gizaels and magic."
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "sublimate"
	volume = 30
	list_reagents = list(
		/datum/reagent/gemdust = 5,
		/datum/reagent/medicine/manapot = 25) // Enough manna pot to give 20% fatigue bar, but gemdust to make it obnoxious compared to manna potion.
	grind_results = list(
		/datum/reagent/gemdust = 5,
		/datum/reagent/medicine/manapot = 25)
