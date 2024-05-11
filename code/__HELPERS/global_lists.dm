//////////////////////////
/////Initial Building/////
//////////////////////////

/proc/make_datum_references_lists()
	//Species
	for(var/spath in subtypesof(/datum/species))
		var/datum/species/S = new spath()
		GLOB.species_list[S.name] = spath
	sortList(GLOB.species_list, GLOBAL_PROC_REF(cmp_typepaths_asc))

	//Surgeries
	for(var/path in subtypesof(/datum/surgery))
		GLOB.surgeries_list += new path()
	sortList(GLOB.surgeries_list, GLOBAL_PROC_REF(cmp_typepaths_asc))

	//Materials
	for(var/path in subtypesof(/datum/material))
		var/datum/material/D = new path()
		GLOB.materials_list[D.id] = D
	sortList(GLOB.materials_list, GLOBAL_PROC_REF(cmp_typepaths_asc))

	// Keybindings
	init_keybindings()

	GLOB.emote_list = init_emote_list()

	init_subtypes(/datum/crafting_recipe, GLOB.crafting_recipes)

	init_subtypes(/datum/advclass, GLOB.adv_classes)

	init_subtypes(/datum/anvil_recipe, GLOB.anvil_recipes)

	for(var/i in 0 to 20)
		GLOB.mouseicons_human += file("icons/effects/mousemice/swang/[i * 5].dmi")

	// Patron Gods
	for(var/god in subtypesof(/datum/patrongods))
		var/datum/patrongods/A = new god()
		GLOB.patronlist[A.name] = A

//creates every subtype of prototype (excluding prototype) and adds it to list L.
//if no list/L is provided, one is created.
/proc/init_subtypes(prototype, list/L)
	if(!istype(L))
		L = list()
	for(var/path in subtypesof(prototype))
		L += new path()
	return L

//returns a list of paths to every subtype of prototype (excluding prototype)
//if no list/L is provided, one is created.
/proc/init_paths(prototype, list/L)
	if(!istype(L))
		L = list()
		for(var/path in subtypesof(prototype))
			L+= path
		return L

