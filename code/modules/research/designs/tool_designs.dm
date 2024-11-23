
/////////////////////////////////////////
/////////////////Tools///////////////////
/////////////////////////////////////////

/datum/design/handdrill
	name = "Hand Drill"
	desc = ""
	id = "handdrill"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3500, /datum/material/silver = 1500, /datum/material/titanium = 2500)
	build_path = /obj/item/screwdriver/power
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/jawsoflife
	name = "Jaws of Life"
	desc = ""
	id = "jawsoflife" // added one more requirment since the Jaws of Life are a bit OP
	build_path = /obj/item/crowbar/power
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 4500, /datum/material/silver = 2500, /datum/material/titanium = 3500)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/exwelder
	name = "Experimental Welding Tool"
	desc = ""
	id = "exwelder"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 500, /datum/material/plasma = 1500, /datum/material/uranium = 200)
	build_path = /obj/item/weldingtool/experimental
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING


/datum/design/rcd_loaded
	name = "Rapid Construction Device"
	desc = ""
	id = "rcd_loaded"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 60000, /datum/material/glass = 5000)  // costs more than what it did in the autolathe, this one comes loaded.
	build_path = /obj/item/construction/rcd/loaded
	category = list("Tool Designs")
	departmental_flags =  DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_CARGO


/datum/design/rcd_upgrade/frames
	name = "RCD frames designs upgrade"
	desc = ""
	id = "rcd_upgrade_frames"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 2500, /datum/material/silver = 1500, /datum/material/titanium = 2000)
	build_path = /obj/item/rcd_upgrade/frames
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/rcd_upgrade/simple_circuits
	name = "RCD simple circuits designs upgrade"
	desc = ""
	id = "rcd_upgrade_simple_circuits"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 2500, /datum/material/silver = 1500, /datum/material/titanium = 2000)
	build_path = /obj/item/rcd_upgrade/simple_circuits
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/rcd_upgrade/silo_link
	name = "Advanced RCD silo link upgrade"
	desc = ""
	id = "rcd_upgrade_silo_link"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2500, /datum/material/glass = 2500, /datum/material/silver = 2500, /datum/material/titanium = 2500, /datum/material/bluespace = 2500)
	build_path = /obj/item/rcd_upgrade/silo_link
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/////////////////////////////////////////
//////////////Alien Tools////////////////
/////////////////////////////////////////

/datum/design/alienwrench
	name = "Alien Wrench"
	desc = ""
	id = "alien_wrench"
	build_path = /obj/item/wrench/abductor
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 2500, /datum/material/plasma = 1000, /datum/material/titanium = 2000, /datum/material/diamond = 2000)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/alienwirecutters
	name = "Alien Wirecutters"
	desc = ""
	id = "alien_wirecutters"
	build_path = /obj/item/wirecutters/abductor
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 2500, /datum/material/plasma = 1000, /datum/material/titanium = 2000, /datum/material/diamond = 2000)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/alienscrewdriver
	name = "Alien Screwdriver"
	desc = ""
	id = "alien_screwdriver"
	build_path = /obj/item/screwdriver/abductor
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 2500, /datum/material/plasma = 1000, /datum/material/titanium = 2000, /datum/material/diamond = 2000)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/aliencrowbar
	name = "Alien Crowbar"
	desc = ""
	id = "alien_crowbar"
	build_path = /obj/item/crowbar/abductor
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 2500, /datum/material/plasma = 1000, /datum/material/titanium = 2000, /datum/material/diamond = 2000)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/alienwelder
	name = "Alien Welding Tool"
	desc = ""
	id = "alien_welder"
	build_path = /obj/item/weldingtool/abductor
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 2500, /datum/material/plasma = 5000, /datum/material/titanium = 2000, /datum/material/diamond = 2000)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/alienmultitool
	name = "Alien Multitool"
	desc = ""
	id = "alien_multitool"
	build_path = /obj/item/multitool/abductor
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 2500, /datum/material/plasma = 5000, /datum/material/titanium = 2000, /datum/material/diamond = 2000)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING
