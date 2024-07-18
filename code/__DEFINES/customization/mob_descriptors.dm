#define MOB_DESCRIPTOR_SLOT_NOTHING 1
#define MOB_DESCRIPTOR_SLOT_FACE 2
#define MOB_DESCRIPTOR_SLOT_BODY 3
#define MOB_DESCRIPTOR_SLOT_SKIN 4
#define MOB_DESCRIPTOR_SLOT_VOICE 5
#define MOB_DESCRIPTOR_SLOT_STATURE 6
#define MOB_DESCRIPTOR_SLOT_PROMINENT 7


#define MOB_DESCRIPTOR(descriptor_type) GLOB.mob_descriptors[descriptor_type]

GLOBAL_LIST_INIT(mob_descriptors, build_descriptor_types())

/proc/build_descriptor_types()
	. = list()
	for(var/type in typesof(/datum/mob_descriptor))
		if(is_abstract(type))
			continue
		.[type] = new type()
	return .

#define DESCRIPTOR_CHOICE(choice_type) GLOB.descriptor_choices[choice_type]
GLOBAL_LIST_INIT(descriptor_choices, build_descriptor_choices())

/proc/build_descriptor_choices()
	. = list()
	for(var/type in typesof(/datum/descriptor_choice))
		if(is_abstract(type))
			continue
		.[type] = new type()
	return .
