GLOBAL_LIST_INIT(named_penis_sizes, list(
	"small" = 1,
	"average" = 2,
	"large" = 3,
))

GLOBAL_LIST_INIT(named_ball_sizes, list(
	"small" = 1,
	"average" = 2,
	"large" = 3,
))

GLOBAL_LIST_INIT(named_breast_sizes, list(
	"flat" = 0,
	"sery small" = 1,
	"small" = 2,
	"normal" = 3,
	"large" = 4,
	"enormous" = 5,
	"towering" = 6,
	"gigantic" = 7,
	"gargantuan" = 8,
	"colossal" = 9,
	"ungodly big" = 10,
))

GLOBAL_LIST_INIT(named_belly_sizes, list(
	"flat" = 0,
	"small" = 1,
	"medium" = 2,
	"large" = 3,
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

/proc/color_pick_sanitized_lumi(mob/user, description, title, default_value, min_lumi = 0.07, max_lumi = 1.0)
	var/color = input(user, description, title, default_value) as color|null
	if(!color)
		return
	color = sanitize_hexcolor(color)
	var/list/hsl = rgb2hsl(hex2num(copytext(color,1,3)),hex2num(copytext(color,3,5)),hex2num(copytext(color,5,7)))
	var/lumi = hsl[3]
	if(lumi < min_lumi)
		to_chat(user, "<span class='warning'>The picked color is too dark!</span>")
		return
	if(lumi > max_lumi)
		to_chat(user, "<span class='warning'>The picked color is too bright!</span>")
		return
	return color
