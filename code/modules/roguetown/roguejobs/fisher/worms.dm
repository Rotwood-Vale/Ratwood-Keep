/obj/item/reagent_containers/food/snacks
	var/list/fishloot = null
	var/list/sizemod = null
	var/list/raritymod = null

/obj/item/natural/worms
	name = "worm"
	desc = "The favorite bait of the courageous fishermen who venture these dark waters."
	icon_state = "worm1"
	throwforce = 10
	color = "#b65f49"
	w_class = WEIGHT_CLASS_TINY
	bundletype = /obj/item/natural/bundle/worms
	var/fishloot = list(/obj/item/reagent_containers/food/snacks/fish/carp = 5,
					/obj/item/reagent_containers/food/snacks/fish/eel = 2)
	drop_sound = 'sound/foley/dropsound/food_drop.ogg'

/obj/item/natural/worms/grubs
	name = "grub"
	desc = "Bait for the desperate, or the daring."
	color = null
	bundletype = null
	fishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/carp = 5,
		/obj/item/reagent_containers/food/snacks/fish/clownfish = 1,
	)
