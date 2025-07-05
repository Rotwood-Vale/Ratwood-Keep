/obj/item/alch
	name = "dust"
	desc = ""
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "irondust"
	w_class = WEIGHT_CLASS_TINY
	experimental_inhand = FALSE
	/*
		So, you're here about potions: TLDR - the cauldron takes up to 4 items, from this, makes 1 recipe. Major gives 3 points, med 2 points,minor 1 point.
		If no recipe gets above 5 points, it makes nothing,otherwise It then makes the recipe with the HIGHEST POINTS.
		all 3 of the below variables should be NULL or the type-path of the recipe to make.
	*/
	var/major_pot = null
	var/med_pot = null
	var/minor_pot = null
	//Dont worry, these 3 are just to cache the 'smell' of their pot on initialization to not have to re-look every examine.
	//No need to set them.
	var/major_smell
	var/med_smell
	var/minor_smell
	///Same as the smells, just caching what the potion name is
	var/major_name
	var/med_name
	var/minor_name

//BEGIN THE HERBS

/obj/item/alch/atropa
	name = "atropa"
	icon_state = "atropa"

	// major_pot = /datum/alch_cauldron_recipe/doompoison
	// med_pot = /datum/alch_cauldron_recipe/berrypoison
	// minor_pot = /datum/alch_cauldron_recipe/stam_poison

/obj/item/alch/matricaria
	name = "matricaria"
	icon_state = "matricaria"

	// major_pot = /datum/alch_cauldron_recipe/berrypoison
	// med_pot = /datum/alch_cauldron_recipe/per_potion
	// minor_pot = /datum/alch_cauldron_recipe/doompoison

/obj/item/alch/symphitum
	name = "symphitum"
	icon_state = "symphitum"

	// major_pot = /datum/alch_cauldron_recipe/health_potion
	// med_pot = /datum/alch_cauldron_recipe/stam_poison
	// minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/taraxacum
	name = "taraxacum"
	icon_state = "taraxacum"

	// major_pot = /datum/alch_cauldron_recipe/stam_poison
	// med_pot = /datum/alch_cauldron_recipe/health_potion
	// minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/euphrasia
	name = "euphrasia"
	icon_state = "euphrasia"

	// major_pot = /datum/alch_cauldron_recipe/spd_potion
	// med_pot = /datum/alch_cauldron_recipe/stam_poison
	// minor_pot = /datum/alch_cauldron_recipe/int_potion

/obj/item/alch/paris
	name = "paris"
	icon_state = "paris"

	// major_pot = /datum/alch_cauldron_recipe/big_stam_poison
	// med_pot = /datum/alch_cauldron_recipe/berrypoison
	// minor_pot = /datum/alch_cauldron_recipe/stam_poison

/obj/item/alch/calendula
	name = "calendula"
	icon_state = "calendula"

	// major_pot = /datum/alch_cauldron_recipe/big_health_potion
	// med_pot = /datum/alch_cauldron_recipe/end_potion
	// minor_pot = /datum/alch_cauldron_recipe/health_potion

/obj/item/alch/mentha
	name = "mentha"
	icon_state = "mentha"

	// major_pot = /datum/alch_cauldron_recipe/per_potion
	// med_pot = /datum/alch_cauldron_recipe/int_potion
	// minor_pot = /datum/alch_cauldron_recipe/stamina_potion

/obj/item/alch/urtica
	name = "urtica"
	icon_state = "urtica"

	// major_pot = /datum/alch_cauldron_recipe/health_potion
	// med_pot = /datum/alch_cauldron_recipe/spd_potion
	// minor_pot = /datum/alch_cauldron_recipe/stamina_potion

/obj/item/alch/salvia
	name = "salvia"
	icon_state = "salvia"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	body_parts_covered = NONE
	w_class = WEIGHT_CLASS_TINY
	alternate_worn_layer  = 8.9 //On top of helmet

	// major_pot = /datum/alch_cauldron_recipe/con_potion
	// med_pot = /datum/alch_cauldron_recipe/str_potion
	// minor_pot = /datum/alch_cauldron_recipe/end_potion

/obj/item/alch/hypericum
	name = "hypericum"
	icon_state = "hypericum"

	// major_pot = /datum/alch_cauldron_recipe/stamina_potion
	// med_pot = /datum/alch_cauldron_recipe/big_mana_potion
	// minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/benedictus
	name = "benedictus"
	icon_state = "benedictus"

	// major_pot = /datum/alch_cauldron_recipe/big_stamina_potion
	// med_pot = /datum/alch_cauldron_recipe/stamina_potion
	// minor_pot = /datum/alch_cauldron_recipe/int_potion

/obj/item/alch/valeriana
	name = "valeriana"
	icon_state = "valeriana"

	// major_pot = /datum/alch_cauldron_recipe/health_potion
	// med_pot = /datum/alch_cauldron_recipe/spd_potion
	// minor_pot = /datum/alch_cauldron_recipe/stam_poison

/obj/item/alch/artemisia
	name = "artemisia"
	icon_state = "artemisia"

	// major_pot = /datum/alch_cauldron_recipe/lck_potion
	// med_pot = /datum/alch_cauldron_recipe/spd_potion
	// minor_pot = /datum/alch_cauldron_recipe/health_potion

/obj/item/alch/rosa
	name = "rosa"
	icon_state = "rosa"
	item_state = "rosa"
	icon = 'icons/roguetown/misc/alchemy.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK|ITEM_SLOT_MOUTH
	body_parts_covered = NONE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	muteinmouth = FALSE
	alternate_worn_layer  = 8.9 //On top of helmet
	mill_result = /obj/item/reagent_containers/food/snacks/grown/rogue/rosa_petals

/obj/item/alch/rosa/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_MOUTH)
		icon_state = "rosa_mouth"
		user.update_inv_mouth()
	else
		icon_state = "rosa"
		user.update_icon()
