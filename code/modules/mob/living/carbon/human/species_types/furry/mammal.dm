/datum/species/mammal
	name = "Anthromorph" //Called so because the species is so much more universal than just mammals
	id = "mammal"
	//flavor_text = "A term encompassing most humanoids with animal-like qualities."
	default_color = "4B4B4B"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAIR,
		FACEHAIR,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	attack_verb = "slash"
	//attack_sound = 'sound/weapons/slash.ogg'
	//miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = GROSS | MEAT | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	//limbs_icon = 'icons/mob/species/mammal_parts_greyscale.dmi'

/datum/species/mammal/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/third_color
	var/random = rand(1,7)
	switch(random)
		if(1)
			main_color = "FFFFFF"
			second_color = "333333"
			third_color = "333333"
		if(2)
			main_color = "FFFFDD"
			second_color = "DD6611"
			third_color = "AA5522"
		if(3)
			main_color = "DD6611"
			second_color = "FFFFFF"
			third_color = "DD6611"
		if(4)
			main_color = "CCCCCC"
			second_color = "FFFFFF"
			third_color = "FFFFFF"
		if(5)
			main_color = "AA5522"
			second_color = "CC8833"
			third_color = "FFFFFF"
		if(6)
			main_color = "FFFFDD"
			second_color = "FFEECC"
			third_color = "FFDDBB"
		if(7) //Oh no you've rolled the sparkle dog
			main_color = random_color()
			second_color = random_color()
			third_color = random_color()
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = third_color
	return returned

