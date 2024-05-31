/obj/item
	var/baitchance = 0
	var/list/fishloot = null

/obj/item/natural/worms
	name = "worm"
	desc = ""
	icon_state = "worm1"
	throwforce = 10
	baitchance = 75
	color = "#b65f49"
	w_class = WEIGHT_CLASS_TINY
	fishloot = list(/obj/item/reagent_containers/food/snacks/fish/carp = 10,
					/obj/item/reagent_containers/food/snacks/fish/eel = 5,
					/obj/item/reagent_containers/food/snacks/fish/angler = 1)
	drop_sound = 'sound/foley/dropsound/food_drop.ogg'
	var/amt = 1

/obj/item/natural/worms/update_icon()
	icon_state = "worm[amt]"
	if(amt > 1)
		name = "[initial(name)]s"
	else
		name = initial(name)

/obj/item/natural/worms/leeches
	name = "leech"
	baitchance = 100
	color = "#472783"
	fishloot = list(/obj/item/reagent_containers/food/snacks/fish/carp = 5,
					/obj/item/reagent_containers/food/snacks/fish/eel = 5,
					/obj/item/reagent_containers/food/snacks/fish/angler = 1)
	embedding = list(
		"embed_chance" = 100,
		"embedded_unsafe_removal_time" = 0, 
		"embedded_pain_chance" = 0,
		"embedded_fall_chance" = 0,
		"embedded_bloodloss"= 0,
	)

/obj/item/natural/worms/leeches/update_icon()
	. = ..()
	if(amt > 1)
		name = "[initial(name)]es"

/obj/item/natural/worms/leeches/attack(mob/living/M, mob/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			return
		if(!get_location_accessible(H, check_zone(user.zone_selected)))
			to_chat(user, "<span class='warning'>Something in the way.</span>")
			return
		var/used_time = 70 - (H.mind.get_skill_level(/datum/skill/misc/medicine) * 10)
		if(!do_mob(user, H, used_time))
			return
		if(!H)
			return
		user.dropItemToGround(src)
		src.forceMove(H)
		affecting.add_embedded_object(src, silent = TRUE, crit_message = FALSE)
		if(M == user)
			user.visible_message("<span class='notice'>[user] places a leech on [user.p_their()] [affecting].</span>", "<span class='notice'>I place a leech on my [affecting].</span>")
		else
			user.visible_message("<span class='notice'>[user] places a leech on [M]'s [affecting].</span>", "<span class='notice'>I place a leech on [M]'s [affecting].</span>")

/obj/item/natural/worms/leeches/on_embed_life(mob/living/user, obj/item/bodypart/bodypart)
	if(!user)
		return
	user.blood_volume = max(user.blood_volume - 1, 0)
	user.adjustToxLoss(-2)
	if(user.blood_volume <= 0)
		if(bodypart)
			bodypart.remove_embedded_object(src)
		else
			user.simple_remove_embedded_object(src)
		return TRUE
	return FALSE

/obj/item/natural/worms/grubs
	name = "grub"
	baitchance = 100
	color = null
	fishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/carp = 5,
		/obj/item/reagent_containers/food/snacks/fish/angler = 1,
		/obj/item/reagent_containers/food/snacks/fish/clownfish = 1,
	)
