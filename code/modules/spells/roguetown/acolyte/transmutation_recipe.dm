//transmutation
//church's unique skill and crafts
//skill_level = 2 level minumum !!!!!!!!!!!!!!

/datum/crafting_recipe/roguetown/coaldust
	name = "Turn coal into components"
	reqs = list(/obj/item/rogueore/coal = 1)
	skillcraft = /datum/skill/misc/transmutation
	skill_level = 2 // 2 level minimum

/datum/crafting_recipe/roguetown/coaldust/New()
	..()

	// lootbox
	var/list/possible_results = list(
		list(/obj/item/rogueore/coaldust), // coaldust
		list(/obj/item/rogueore/coaldust, /obj/item/rogueore/sulfur), // coaldust + sulfur
		list(/obj/item/rogueore/coaldust, /obj/item/rogueore/selitre), // coaldust + selitre
		list(/obj/item/rogueore/coaldust, /obj/item/rogueore/sulfur, /obj/item/rogueore/selitre) // All three
	)

	// pick rando,
	result = pick(possible_results)

/datum/crafting_recipe/roguetown/coalback
	name = "Turn dust into a coal"
	result = list(/obj/item/rogueore/coal/ = 1)
	reqs = list(/obj/item/rogueore/coaldust = 3)

	skillcraft = /datum/skill/misc/transmutation
	skill_level = 2 // 2 level minimum
	

/*
/datum/crafting_recipe/roguetown/tntbomb
	name = "Blackpowder stick"
	result = list(/obj/item/rogueore/coal/dust)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /datum/reagent/mercury = 5)
	skill_level = 2 //2 level minumum

/datum/crafting_recipe/roguetown/tntbomb
	name = "Blackpowder stick"
	result = list(/obj/item/rogueore/coal/dust)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /datum/reagent/mercury = 5)
	skill_level = 2

/datum/crafting_recipe/roguetown/tntbomb
	name = "Blackpowder stick"
	result = list(/obj/item/tntstick)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /datum/reagent/mercury = 5)
	skill_level = 2


/obj/item/tntstick
/obj/item/satchel_bomb
/obj/item/impact_grenade/explosion
/obj/item/impact_grenade/smoke
/obj/item/impact_grenade/poison_gas
/obj/item/impact_grenade/healing_gas
/obj/item/impact_grenade/fire_gas
/obj/item/impact_grenade/blind_gas
/obj/item/impact_grenade/mute_gas
*/
