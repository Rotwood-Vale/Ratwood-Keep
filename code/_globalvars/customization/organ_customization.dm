GLOBAL_LIST_INIT(named_penis_sizes, list(
	"Small" = 1,
	"Average" = 2,
	"Large" = 3,
))

GLOBAL_LIST_INIT(named_ball_sizes, list(
	"Small" = 1,
	"Average" = 2,
	"Large" = 3,
))

GLOBAL_LIST_INIT(named_breast_sizes, list(
	"Flat" = 0,
	"AA Cup" = 1,
	"A Cup" = 2,
	"B Cup" = 3,
	"C Cup" = 4,
	"D Cup" = 5,
	"DD Cup" = 6,
	"F Cup" = 7,
	"FF Cup" = 8,
	"G Cup" = 9,
	"H Cup" = 10,
))

GLOBAL_LIST_INIT(customizer_choices, build_customizer_choices())
GLOBAL_LIST_INIT(customizers, build_customizers())

/proc/build_customizer_choices()
	. = list()
	for(var/type in typesof(/datum/customizer_choice))
		if(is_abstract(type))
			continue
		.[type] = new type()
	return .

/proc/build_customizers()
	. = list()
	for(var/type in typesof(/datum/customizer))
		if(is_abstract(type))
			continue
		.[type] = new type()
	return .
