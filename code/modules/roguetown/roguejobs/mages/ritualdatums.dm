#define isstack(A) (istype(A, /obj/item/stack))
GLOBAL_LIST_INIT(runeritualslist, generate_runeritual_types())
GLOBAL_LIST_INIT(allowedrunerituallist, generate_allowed_runeritual_types())
GLOBAL_LIST_INIT(t1summoningrunerituallist, generate_t1summoning_rituallist())
GLOBAL_LIST_INIT(t2summoningrunerituallist, generate_t2summoning_rituallist())
GLOBAL_LIST_INIT(t3summoningrunerituallist, generate_t3summoning_rituallist())
GLOBAL_LIST_INIT(t4summoningrunerituallist, generate_t4summoning_rituallist())
GLOBAL_LIST_INIT(t2wallrunerituallist, generate_t2wall_rituallist())
GLOBAL_LIST_INIT(t4wallrunerituallist, generate_t4wall_rituallist())
GLOBAL_LIST_INIT(buffrunerituallist, generate_buff_rituallist())
GLOBAL_LIST_INIT(t2buffrunerituallist, generate_t2buff_rituallist())
GLOBAL_LIST_INIT(t2enchantmentrunerituallist,generate_t2enchantment_rituallist())
GLOBAL_LIST_INIT(t4enchantmentrunerituallist,generate_t4enchantment_rituallist())

/proc/generate_runeritual_types()	//debug list
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in typesof(/datum/runerituals))
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals
/proc/generate_allowed_runeritual_types()	//list of all non-summoning rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in subtypesof(/datum/runerituals))
		if(istype(runeritual, /datum/runerituals/summoning || /datum/runerituals/wall))
			continue
		if(runeritual.blacklisted)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/proc/generate_t1summoning_rituallist()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in subtypesof(/datum/runerituals/summoning))
		if(runeritual.tier > 1)
			continue
		if(runeritual.blacklisted)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/proc/generate_t2summoning_rituallist()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in subtypesof(/datum/runerituals/summoning))
		if(runeritual.tier > 2)
			continue
		if(runeritual.blacklisted)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/proc/generate_t3summoning_rituallist()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in subtypesof(/datum/runerituals/summoning))
		if(runeritual.tier > 3)
			continue
		if(runeritual.blacklisted)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/proc/generate_t4summoning_rituallist()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in subtypesof(/datum/runerituals/summoning))
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/proc/generate_t2wall_rituallist()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in typesof(/datum/runerituals/wall))
		if(runeritual.tier > 2)
			continue
		if(runeritual.blacklisted)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/proc/generate_t4wall_rituallist()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in subtypesof(/datum/runerituals/wall))
		if(runeritual.tier < 3)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/proc/generate_buff_rituallist()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in subtypesof(/datum/runerituals/buff))
		if(runeritual.tier > 1)
			continue
		if(runeritual.blacklisted)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/proc/generate_t2buff_rituallist()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in subtypesof(/datum/runerituals/buff))
		if(runeritual.blacklisted)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/proc/generate_t2enchantment_rituallist()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in subtypesof(/datum/runerituals/enchanting))
		if(runeritual.blacklisted)
			continue
		if(runeritual.tier > 2)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals


/proc/generate_t4enchantment_rituallist()	//list of all rituals for player use
	RETURN_TYPE(/list)
	var/list/runerituals = list()
	for(var/datum/runerituals/runeritual as anything in subtypesof(/datum/runerituals/enchanting))
		if(runeritual.blacklisted)
			continue
		runerituals[initial(runeritual.name)] = runeritual
	return runerituals

/datum/runerituals
	var/name
	var/desc
	var/list/required_atoms = list()
	var/list/result_atoms = list()
	var/list/banned_atom_types = list()
	var/mob_to_summon
	var/blacklisted = FALSE
	var/tier = 0				/// Tier var is used for 'tier' of ritual, if the ritual has tiers. EX: Summoning rituals. If it doesn't have tiers, set tier to 0.


/datum/runerituals/proc/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	if(!length(result_atoms))
		return FALSE

	for(var/result in result_atoms)
		new result(loc)
	return TRUE

/datum/runerituals/proc/parse_required_item(atom/item_path, number_of_things)
	// If we need a human, there is a high likelihood we actually need a (dead) body
	if(ispath(item_path, /mob/living/carbon/human))
		return "bod[number_of_things > 1 ? "ies" : "y"]"
	if(ispath(item_path, /mob/living))
		return "carcass[number_of_things > 1 ? "es" : ""] of any kind"
	return "[initial(item_path.name)]\s"

/**
 * Called after on_finished_recipe returns TRUE
 * and a ritual was successfully completed.
 *
 * Goes through and cleans up (deletes)
 * all atoms in the selected_atoms list.
 *
 * Remove atoms from the selected_atoms
 * (either in this proc or in on_finished_recipe)
 * to NOT have certain atoms deleted on cleanup.
 *
 * Arguments
 * * selected_atoms - a list of all atoms we intend on destroying.
 */
/datum/runerituals/proc/cleanup_atoms(list/selected_atoms)
	SHOULD_CALL_PARENT(TRUE)

	for(var/atom/sacrificed as anything in selected_atoms)
		if(isliving(sacrificed))
			continue

		if(isstack(sacrificed))
			var/obj/item/stack/sac_stack = sacrificed
			var/how_much_to_use = 0
			for(var/requirement in required_atoms)
				// If it's not requirement type and type is not a list, skip over this check
				if(!istype(sacrificed, requirement) && !islist(requirement))
					continue
				// If requirement *is* a list and the stack *is* in the list, skip over this check
				if(islist(requirement) && !is_type_in_list(sacrificed, requirement))
					continue
				how_much_to_use = min(required_atoms[requirement], sac_stack.amount)
				break
			sac_stack.use(how_much_to_use)
			continue

		if(istype(sacrificed, /obj/item/reagent_containers/glass))
			var/obj/item/reagent_containers/glass/RC = sacrificed
			for(var/req_type in required_atoms)
				var/amount = required_atoms[req_type]
				if (RC.reagents.has_reagent(req_type, amount))
					RC.reagents.remove_reagent(req_type, amount)
					selected_atoms -= sacrificed
			continue

		selected_atoms -= sacrificed
		qdel(sacrificed)

/datum/runerituals/buff
	blacklisted = TRUE
	tier = 1
	var/buff
/datum/runerituals/knowledge
	name = "knowledge gain"
	tier = 1
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/manacrystal = 1)

/datum/runerituals/knowledge/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return TRUE

/datum/runerituals/buff/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return TRUE

/datum/runerituals/buff/strength
	name = "arcane augmentation of strength"
	buff = /datum/status_effect/buff/magicstrength
	tier = 2
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/manacrystal = 2,/obj/item/natural/elementalshard = 2)

/datum/runerituals/buff/lesserstrength
	name = "lesser arcane augmentation of strength"
	buff = /datum/status_effect/buff/magicstrength/lesser
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/elementalmote = 2,/obj/item/natural/manacrystal = 1)

/datum/runerituals/buff/constitution
	name = "fortify constitution"
	buff = /datum/status_effect/buff/magicconstitution
	tier = 2
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/manacrystal = 2, /obj/item/natural/obsidian = 4)

/datum/runerituals/buff/lesserconstitution
	name = "lesser fortify constitution"
	buff = /datum/status_effect/buff/magicconstitution/lesser
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/manacrystal = 1, /obj/item/natural/obsidian = 2)

/datum/runerituals/buff/speed
	name = "haste"
	buff = /datum/status_effect/buff/magicspeed
	tier = 2
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/artifact = 2, /obj/item/natural/leyline = 2)

/datum/runerituals/buff/lesserspeed
	name = "lesser haste"
	buff = /datum/status_effect/buff/magicspeed/lesser
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/artifact = 1, /obj/item/natural/leyline = 1)

/datum/runerituals/buff/perception
	name = "arcane eyes"
	buff = /datum/status_effect/buff/magicperception
	tier = 2
	blacklisted = FALSE
	required_atoms = list(/obj/item/reagent_containers/food/snacks/grown/rogue/manabloom = 2, /obj/item/natural/hellhoundfang = 1)

/datum/runerituals/buff/lesserperception
	name = "lesser arcane eyes"
	buff = /datum/status_effect/buff/magicperception/lesser
	blacklisted = FALSE
	required_atoms = list(/obj/item/reagent_containers/food/snacks/grown/rogue/manabloom = 1, /obj/item/natural/infernalash = 2)

/datum/runerituals/buff/endurance
	name = "vitalized endurance"
	buff = /datum/status_effect/buff/magicendurance
	tier = 2
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/obsidian = 2, /obj/item/natural/iridescentscale = 1)

/datum/runerituals/buff/lesserendurance
	name = "lesser vitalized endurance"
	buff = /datum/status_effect/buff/magicendurance/lesser
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/obsidian = 2, /obj/item/natural/fairydust = 2)

/datum/runerituals/buff/nightvision
	name = "darksight"
	buff = /datum/status_effect/buff/darkvision
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/manacrystal = 2, /obj/item/natural/iridescentscale = 1, /obj/item/natural/elementalshard = 1)
/datum/runerituals/enchantment


/datum/runerituals/wall
	name = "lesser arcyne wall"
	tier = 1
	blacklisted = FALSE
	required_atoms = list(/obj/item/natural/elementalmote = 2, /obj/item/natural/manacrystal = 1, /obj/item/natural/melded/t1 = 1)

/datum/runerituals/wall/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return 1

/datum/runerituals/wall/t2
	name = "greater arcyne wall"
	tier = 2
	required_atoms = list(/obj/item/natural/elementalmote = 4, /obj/item/natural/manacrystal = 2, /obj/item/natural/melded/t1 = 1)

/datum/runerituals/wall/t2/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return 2

/datum/runerituals/wall/t3
	name = "arcyne fortress"
	tier = 3
	required_atoms = list(/obj/item/natural/artifact = 3, /obj/item/natural/manacrystal = 3, /obj/item/natural/melded/t3 = 1)


/datum/runerituals/teleport
	name = "planar convergence"
	tier = 3
	required_atoms = list(/obj/item/natural/artifact = 1, /obj/item/natural/leyline = 1, /obj/item/natural/melded/t2 = 1) //adjust this later
/datum/runerituals/teleport/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return TRUE

////////////////SUMMONING RITUALS///////////////////
/datum/runerituals/summoning
	name = "summoning ritual parent"
	desc = "summoning parent rituals."
	blacklisted = TRUE



/datum/runerituals/summoning/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return summon_ritual_mob(user, loc, mob_to_summon)

/datum/runerituals/summoning/proc/summon_ritual_mob(mob/living/user, turf/loc, mob/living/mob_to_summon)
	var/mob/living/simple_animal/summoned
	if(isliving(mob_to_summon))
		summoned = mob_to_summon
	else
		summoned = new mob_to_summon(loc)
		ADD_TRAIT(summoned, TRAIT_PACIFISM, TRAIT_GENERIC)	//can't kill while planar bound.
		summoned.status_flags += GODMODE//It's not meant to be killable until released from it's planar binding.
		summoned.candodge = FALSE
		animate(summoned, color = "#ff0000",time = 5)
		summoned.move_resist = MOVE_FORCE_EXTREMELY_STRONG
		summoned.binded = TRUE
		summoned.SetParalyzed(900)
		return summoned



/datum/runerituals/summoning/imp
	name = "summoning lesser infernal"
	desc = "summons an infernal imp"
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/obj/item/ash = 2, /obj/item/natural/obsidian = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/infernal/imp

/datum/runerituals/summoning/hellhound
	name = "summoning hellhound"
	desc = "summons a hellhound"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/obj/item/natural/infernalash = 3, /obj/item/natural/obsidian = 2, /obj/item/natural/melded/t1 = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/infernal/hellhound

/datum/runerituals/summoning/watcher
	name = "summoning infernal watcher"
	desc = "summons an infernal watcher"
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/obj/item/natural/hellhoundfang = 2, /obj/item/natural/obsidian = 2, /obj/item/natural/melded/t2 =1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher

/datum/runerituals/summoning/archfiend
	name = "summoning fiend"
	desc = "summons an fiend"
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/obj/item/natural/moltencore = 1, /obj/item/natural/obsidian = 3, /obj/item/natural/melded/t3 =1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/infernal/fiend

/datum/runerituals/summoning/sprite
	name = "summoning sprite"
	desc = "summons an fae sprite"
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/obj/item/reagent_containers/food/snacks/grown/rogue/manabloom = 1, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/fae/sprite

/datum/runerituals/summoning/glimmer
	name = "summoning glimmerwing"
	desc = "summons an fae spirit"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/obj/item/reagent_containers/food/snacks/grown/rogue/manabloom = 2, /obj/item/natural/fairydust = 3, /obj/item/natural/melded/t1 = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/fae/glimmerwing

/datum/runerituals/summoning/dryad
	name = "summoning dryad"
	desc = "summons an drayd"
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/obj/item/reagent_containers/food/snacks/grown/rogue/manabloom = 2, /obj/item/natural/iridescentscale = 2, /obj/item/natural/melded/t2 = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/fae/dryad

/datum/runerituals/summoning/sylph
	name = "summoning sylph"
	desc = "summons an archfae"
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/obj/item/reagent_containers/food/snacks/grown/rogue/manabloom = 1, /obj/item/natural/heartwoodcore = 1, /obj/item/natural/melded/t3 = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/fae/sylph

/datum/runerituals/summoning/crawler
	name = "summoning elemental crawler"
	desc = "summons a minor elemental"
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/obj/item/natural/stone = 2, /obj/item/natural/manacrystal = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/elemental/crawler

/datum/runerituals/summoning/warden
	name = "summoning elemental warden"
	desc = "summons an elemental"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/obj/item/natural/elementalmote = 3, /obj/item/natural/manacrystal = 2, /obj/item/natural/melded/t1 = 1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/elemental/warden

/datum/runerituals/summoning/behemoth
	name = "summoning elemental behemoth"
	desc = "summons a large elemental"
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/obj/item/natural/elementalshard = 2, /obj/item/natural/manacrystal = 2, /obj/item/natural/melded/t2 =1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/elemental/behemoth

/datum/runerituals/summoning/collossus
	name = "summoning elemental collossus"
	desc = "summons an huge elemental"
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/obj/item/natural/elementalfragment = 1, /obj/item/natural/manacrystal = 1, /obj/item/natural/melded/t3 =1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/elemental/collossus

/datum/runerituals/summoning/abberant
	name = "summoning abberant from the void"
	desc = "summons a long forgotten creature"
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/obj/item/natural/melded/t5 =1)
	mob_to_summon = /mob/living/simple_animal/hostile/retaliate/rogue/voiddragon

////////////////ENCHANTING RITUALS///////////////////
/datum/runerituals/enchanting
	name = "Enchanting"
	desc = "Parent enchanting."
	blacklisted = TRUE

/datum/runerituals/enchanting/woodcut
	name = "Woodcutting"
	desc = "Good for cutting wood."
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1, /obj/item/natural/manacrystal = 1)
	result_atoms = list(/obj/item/enchantmentscroll/woodcut)

/datum/runerituals/enchanting/mining
	name = "Mining"
	desc = "Good for mining rock."
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1, /obj/item/natural/artifact = 1)
	result_atoms = list(/obj/item/enchantmentscroll/mining)

/datum/runerituals/enchanting/xylix
	name = "Xylix's Grace"
	desc = "How fortunate!"
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1, /obj/item/natural/leyline = 1)
	result_atoms = list(/obj/item/enchantmentscroll/xylix)

/datum/runerituals/enchanting/light
	name = "Unyielding Light"
	desc = "Provides light!"
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/elementalmote = 2)
	result_atoms = list(/obj/item/enchantmentscroll/light)

/datum/runerituals/enchanting/holding
	name = "Compact Storing"
	desc = "Makes things hold more!"
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/infernalash = 2, /obj/item/natural/fairydust = 2)
	result_atoms = list(/obj/item/enchantmentscroll/holding)

/datum/runerituals/enchanting/revealing
	name = "Revealing Light"
	desc = "Doubles brightness!"
	blacklisted = FALSE
	tier = 1
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1, /obj/item/natural/fairydust = 2)
	result_atoms = list(/obj/item/enchantmentscroll/revealing)

/datum/runerituals/enchanting/nightvision
	name = "Dark Vision"
	desc = "Provides dark sight!"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/iridescentscale = 1, /obj/item/natural/manacrystal = 1, /obj/item/natural/melded/t1 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/nightvision)

/datum/runerituals/enchanting/featherstep
	name = "Feather Step"
	desc = "Provides dark sight!"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/iridescentscale = 1, /obj/item/natural/fairydust = 1, /obj/item/natural/melded/t1 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/featherstep)

/datum/runerituals/enchanting/fireresist
	name = "Fire Resistance"
	desc = "Provides resistance from fire!"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/hellhoundfang = 1, /obj/item/natural/infernalash = 1, /obj/item/natural/melded/t1 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/fireresist)

/datum/runerituals/enchanting/climbing
	name = "Spider movements"
	desc = "Better climbing!"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/elementalshard = 1, /obj/item/natural/infernalash = 1, /obj/item/natural/melded/t1 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/climbing)

/datum/runerituals/enchanting/thievery
	name = "Thievery"
	desc = "Better pickpocketting and lockpicks!"
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/hellhoundfang = 1, /obj/item/natural/obsidian = 1, /obj/item/natural/melded/t1 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/thievery)

/datum/runerituals/enchanting/trekk
	name = "Swamp Trekking"
	desc = "Provides easy movement through swamps."
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/elementalshard = 1, /obj/item/natural/artifact = 1, /obj/item/natural/melded/t1 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/trekk)

/datum/runerituals/enchanting/smithing
	name = "Smithing"
	desc = "Better smithing."
	blacklisted = FALSE
	tier = 2
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/elementalshard = 1, /obj/item/natural/elementalmote = 1, /obj/item/natural/melded/t1 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/smithing)
/datum/runerituals/enchanting/lifesteal
	name = "Lyfestealing"
	desc = "Steals health from foes."
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/heartwoodcore = 1, /obj/item/natural/hellhoundfang = 2, /obj/item/natural/melded/t2 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/lifesteal)

/datum/runerituals/enchanting/frostveil
	name = "Frostveil"
	desc = "Chills foes."
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/elementalfragment = 1, /obj/item/natural/elementalshard = 2, /obj/item/natural/melded/t2 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/frostveil)

/datum/runerituals/enchanting/phoenixguard
	name = "phoenixguard"
	desc = "burns attackers."
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/moltencore = 1, /obj/item/natural/iridescentscale = 2, /obj/item/natural/melded/t2 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/phoenixguard)

/datum/runerituals/enchanting/woundclosing
	name = "Wound closing"
	desc = "Closes wounds."
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/heartwoodcore = 1, /obj/item/natural/iridescentscale = 2, /obj/item/natural/melded/t2 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/woundclosing)

/datum/runerituals/enchanting/returningweapon
	name = "Returning Weapon"
	desc = "Summons weapons."
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/elementalfragment = 1, /obj/item/natural/fairydust = 2, /obj/item/natural/elementalmote = 2, /obj/item/natural/melded/t2 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/returningweapon)

/datum/runerituals/enchanting/archery
	name = "Archery"
	desc = "Of bowmanship."
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/hellhoundfang = 2, /obj/item/natural/leyline = 2, /obj/item/natural/melded/t2 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/archery)

/datum/runerituals/enchanting/leaping
	name = "Leaping"
	desc = "Further leaping."
	blacklisted = FALSE
	tier = 3
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/moltencore = 2, /obj/item/natural/leyline = 2, /obj/item/natural/melded/t2 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/leaping)

/datum/runerituals/enchanting/freeze
	name = "Freezing"
	desc = "Freezes Foes into cubes of ice."
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/sylvanessence = 1, /obj/item/natural/moltencore = 2, /obj/item/natural/melded/t3 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/freeze)

/datum/runerituals/enchanting/infernalflame
	name = "Infernal Flame"
	desc = "Burns Foes."
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/abyssalflame = 1, /obj/item/natural/obsidian = 4, /obj/item/natural/melded/t3 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/infernalflame)

/datum/runerituals/enchanting/briars
	name = "Briar's Curse"
	desc = "Harder hitting weapons at a cost."
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/sylvanessence = 1, /obj/item/natural/heartwoodcore = 2, /obj/item/natural/melded/t3 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/briars)

/datum/runerituals/enchanting/rewind
	name = "Temporal Rewind"
	desc = "Rewinds time."
	blacklisted = FALSE
	tier = 4
	required_atoms = list(/datum/reagent/mercury = 15,/obj/item/paper/scroll = 1,/obj/item/natural/elementalrelic = 1, /obj/item/natural/heartwoodcore = 2, /obj/item/natural/melded/t3 = 1)
	result_atoms = list(/obj/item/enchantmentscroll/rewind)