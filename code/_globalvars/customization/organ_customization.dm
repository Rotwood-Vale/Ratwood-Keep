GLOBAL_LIST_INIT(organ_choices, build_organ_choices())
GLOBAL_LIST_INIT(organ_customizers, build_organ_customizers())

/proc/build_organ_choices()
	var/list/organ_choice_list = list()
	for(var/type in typesof(/datum/organ_choice))
		if(is_abstract(type))
			continue
		organ_choice_list[type] = new type()
	return organ_choice_list

/proc/build_organ_customizers()
	var/list/organ_customizer_list = list()
	for(var/type in typesof(/datum/organ_customizer))
		if(is_abstract(type))
			continue
		organ_customizer_list[type] = new type()
	return organ_customizer_list
