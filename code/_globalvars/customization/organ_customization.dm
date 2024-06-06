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
	"A - Very Small" = 1,
	"B - Small" = 2,
	"C - Normal" = 3,
	"D - Large" = 4,
	"D - Enormous" = 5,
	"DD - Enormous" = 6,
	"F - Enormous" = 7,
	"FF - Enormous" = 8,
	"G - Enormous" = 9,
	"H - Enormous" = 10,
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

/proc/color_pick_sanitized_lumi(mob/user, description, title, default_value, min_lumi = 0.1, max_lumi = 1.0)
	var/color = input(user, description, title, default_value) as color|null
	if(!color)
		return
	color = sanitize_hexcolor(color)
	var/list/hsl = rgb2hsl(hex2num(copytext(color,1,3)),hex2num(copytext(color,3,5)),hex2num(copytext(color,5,7)))
	hsl[3] = clamp(hsl[3], min_lumi, max_lumi)
	var/list/RGB = hsl2rgb(arglist(hsl))
	return "[num2hex(RGB[1],2)][num2hex(RGB[2],2)][num2hex(RGB[3],2)]"
