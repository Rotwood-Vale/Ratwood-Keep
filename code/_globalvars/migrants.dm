GLOBAL_LIST_INIT(migrant_waves, build_migrant_waves())
GLOBAL_LIST_INIT(migrant_roles, build_migrant_roles())

/proc/build_migrant_waves()
	. = list()
	for(var/type in typesof(/datum/migrant_wave))
		if(is_abstract(type))
			continue
		.[type] = new type()
	return .

/proc/build_migrant_roles()
	. = list()
	for(var/type in typesof(/datum/migrant_role))
		if(is_abstract(type))
			continue
		.[type] = new type()
	return .
