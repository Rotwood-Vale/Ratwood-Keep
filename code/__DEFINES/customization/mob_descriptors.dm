#define MOB_DESCRIPTOR_SLOT_NOTHING 1
#define MOB_DESCRIPTOR_SLOT_FACE_SHAPE 2
#define MOB_DESCRIPTOR_SLOT_FACE_EXPRESSION 3
#define MOB_DESCRIPTOR_SLOT_BODY 4
#define MOB_DESCRIPTOR_SLOT_SKIN 5
#define MOB_DESCRIPTOR_SLOT_VOICE 6
#define MOB_DESCRIPTOR_SLOT_STATURE 7
#define MOB_DESCRIPTOR_SLOT_PROMINENT 8
#define MOB_DESCRIPTOR_SLOT_AGE 9
#define MOB_DESCRIPTOR_SLOT_PENIS 10
#define MOB_DESCRIPTOR_SLOT_TESTICLES 11
#define MOB_DESCRIPTOR_SLOT_BREASTS 12
#define MOB_DESCRIPTOR_SLOT_VAGINA 13

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
