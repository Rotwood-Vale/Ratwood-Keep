//////////////////////////
/////Initial Building/////
//////////////////////////

/proc/make_datum_references_lists()
	//Species
	for(var/species_path in subtypesof(/datum/species))
		var/datum/species/species = new species_path()
		GLOB.species_list[species.name] = species_path
	sortList(GLOB.species_list, GLOBAL_PROC_REF(cmp_typepaths_asc))

	//Surgery steps
	for(var/path in subtypesof(/datum/surgery_step))
		GLOB.surgery_steps += new path()
	sortList(GLOB.surgery_steps, GLOBAL_PROC_REF(cmp_typepaths_asc))

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

	init_subtypes(/datum/anvil_recipe, GLOB.anvil_recipes)

	for(var/i in 0 to 20)
		GLOB.mouseicons_human += file("icons/effects/mousemice/swang/[i * 5].dmi")

	// Faiths
	for(var/path in subtypesof(/datum/faith))
		var/datum/faith/faith = new path()
		GLOB.faithlist[path] = faith
		if(faith.preference_accessible)
			GLOB.preference_faiths[path] = faith

	// Patron Gods
	for(var/path in subtypesof(/datum/patron))
		var/datum/patron/patron = new path()
		GLOB.patronlist[path] = patron
		LAZYINITLIST(GLOB.patrons_by_faith[patron.associated_faith])
		GLOB.patrons_by_faith[patron.associated_faith][path] = patron
		if(patron.preference_accessible)
			GLOB.preference_patrons[path] = patron

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

