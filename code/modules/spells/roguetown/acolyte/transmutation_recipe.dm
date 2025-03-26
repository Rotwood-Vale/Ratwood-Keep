//transmutation
//church's unique skill and crafts
//skill_level = 2 level minumum !!!!!!!!!!!!!!

/datum/crafting_recipe/roguetown/coaldust
	name = "Turn coal into components"
	reqs = list(/obj/item/rogueore/coal = 1)
	result = list(/obj/item/rogueore/coaldust, /obj/item/rogueore/sulfur, /obj/item/rogueore/selitre) 
	skillcraft = /datum/skill/misc/transmutation
	skill_level = 2 // 2 level minimum

/datum/crafting_recipe/roguetown/coalback
	name = "Turn dust into a coal"
	result = list(/obj/item/rogueore/coal/ = 1)
	reqs = list(/obj/item/rogueore/coaldust = 3)
	skillcraft = /datum/skill/misc/transmutation
	skill_level = 2 // 2 level minimum
	
/datum/crafting_recipe/roguetown/tntbomb
	name = "Put gunpowder into the paper shell"
	result = list(/obj/item/tntstick)
	reqs = list(/obj/item/paper/scroll = 1, /obj/item/rogueore/coaldust = 2, /obj/item/rogueore/sulfur = 2, /obj/item/rogueore/selitre = 2)
	skill_level = 4 

/datum/crafting_recipe/roguetown/satchelbomb
	name = "Put gunpowder sticks into the satchel"
	result = list(/obj/item/satchel_bomb)
	reqs = list(/obj/item/tntstick =3, /obj/item/storage/backpack/rogue/satchel = 1 )
	skill_level = 5

/datum/crafting_recipe/roguetown/impactexp
	name = "Put explosion payload into a grenade shell"
	result = list(/obj/item/impact_grenade/explosion)
	reqs = list(/obj/item/paper/scroll = 1, /obj/item/natural/hide = 1, /obj/item/rogueore/coaldust = 1, /obj/item/rogueore/sulfur = 1, /obj/item/rogueore/selitre = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/smokegas
	name = "Put smoke payload into a grenade shell"
	result = list(/obj/item/impact_grenade/smoke)
	reqs = list(/obj/item/paper/scroll = 1, /obj/item/natural/hide = 1, /obj/item/rogueore/coaldust = 3, /obj/item/rogueore/sulfur = 1, /obj/item/rogueore/selitre = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/poisongas
	name = "Put poison and smoke payloads into a grenade shell"
	result = list(/obj/item/impact_grenade/poison_gas)
	reqs = list(/obj/item/paper/scroll = 1, /obj/item/natural/hide = 1, /obj/item/rogueore/coaldust = 3, /obj/item/rogueore/sulfur = 1, /obj/item/rogueore/selitre = 1, /datum/reagent/berrypoison = 5)
	skill_level = 3	

/datum/crafting_recipe/roguetown/healinggas
	name = "Put poison and smoke payloads into a grenade shell"
	result = list(/obj/item/impact_grenade/poison_gas)
	reqs = list(/obj/item/paper/scroll = 1, /obj/item/natural/hide = 1, /obj/item/rogueore/coaldust = 3, /obj/item/rogueore/sulfur = 1, /obj/item/rogueore/selitre = 1, datum/reagent/medicine/lesserhealthpot = 5)
	skill_level = 3		

/datum/crafting_recipe/roguetown/firegas
	name = "Put burning payload into a grenade shell"
	result = list(/obj/item/impact_grenade/fire_gas)
	reqs = list(/obj/item/paper/scroll = 1, /obj/item/natural/hide = 1, /obj/item/rogueore/coaldust = 3, /obj/item/rogueore/sulfur = 1, /obj/item/rogueore/selitre = 1, /obj/item/reagent_containers/food/snacks/fat = 2)
	skill_level = 3	

/datum/crafting_recipe/roguetown/blindgas
	name = "Put dusty and smoke payload into a grenade shell"
	result = list(/obj/item/impact_grenade/blind_gas)
	reqs = list(/obj/item/paper/scroll = 1, /obj/item/natural/hide = 1, /obj/item/rogueore/coaldust = 3, /obj/item/rogueore/sulfur = 1, /obj/item/rogueore/selitre = 1, /obj/item/ash = 3)
	skill_level = 3	

/datum/crafting_recipe/roguetown/mutegas
	name = "Put chocking payload into a grenade shell"
	result = list(/obj/item/impact_grenade/mute_gas)
	reqs = list(/obj/item/paper/scroll = 1, /obj/item/natural/hide = 1, /obj/item/rogueore/coaldust = 3, /obj/item/rogueore/sulfur = 1, /obj/item/rogueore/selitre = 1, /obj/item/ash = 3)
	skill_level = 3	
