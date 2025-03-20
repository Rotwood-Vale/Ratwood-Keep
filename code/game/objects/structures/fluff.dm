//Fluff structures serve no purpose and exist only for enriching the environment. They can be destroyed with a wrench.

/obj/structure/fluff
	name = "fluff structure"
	desc = ""
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "minibar"
	anchored = TRUE
	density = FALSE
	opacity = 0
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 150
	var/deconstructible = TRUE

/obj/structure/fluff/paper
	name = "dense lining of papers"
	desc = ""
	icon = 'icons/obj/fluff.dmi'
	icon_state = "paper"
	deconstructible = FALSE

/obj/structure/fluff/paper/corner
	icon_state = "papercorner"

/obj/structure/fluff/paper/stack
	name = "dense stack of papers"
	desc = ""
	icon_state = "paperstack"

/obj/structure/fluff/big_chain
	name = "giant chain"
	desc = ""
	icon = 'icons/effects/32x96.dmi'
	icon_state = "chain"
	layer = ABOVE_OBJ_LAYER
	anchored = TRUE
	density = TRUE
	deconstructible = FALSE

/obj/structure/fluff/railing
	name = "railing"
	desc = ""
	icon = 'icons/obj/railing.dmi'
	icon_state = "railing"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE
	flags_1 = ON_BORDER_1
	climbable = TRUE
	var/passcrawl = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/railing/Initialize()
	. = ..()
	var/lay = getwlayer(dir)
	if(lay)
		layer = lay

/obj/structure/fluff/railing/proc/getwlayer(dirin)
	switch(dirin)
		if(NORTH)
			layer = BELOW_MOB_LAYER-0.01
		if(WEST)
			layer = BELOW_MOB_LAYER
		if(EAST)
			layer = BELOW_MOB_LAYER
		if(SOUTH)
			layer = ABOVE_MOB_LAYER
			plane = GAME_PLANE_UPPER

/obj/structure/fluff/railing/CanPass(atom/movable/mover, turf/target)
//	if(istype(mover) && (mover.pass_flags & PASSTABLE))
//		return 1
	if(istype(mover, /obj/projectile))
		return 1
	if(mover.throwing)
		return 1
	if(isobserver(mover))
		return 1
	if(isliving(mover))
		var/mob/living/M = mover
		if(!(M.mobility_flags & MOBILITY_STAND))
			if(passcrawl)
				return TRUE
	if(icon_state == "woodrailing" && dir in CORNERDIRS)
		var/list/baddirs = list()
		switch(dir)
			if(SOUTHEAST)
				baddirs = list(SOUTHEAST, SOUTH, EAST)
			if(SOUTHWEST)
				baddirs = list(SOUTHWEST, SOUTH, WEST)
			if(NORTHEAST)
				baddirs = list(NORTHEAST, NORTH, EAST)
			if(NORTHWEST)
				baddirs = list(NORTHWEST, NORTH, WEST)
		if(get_dir(loc, target) in baddirs)
			return 0
	else if(get_dir(loc, target) == dir)
		return 0
	return 1

/obj/structure/fluff/railing/CheckExit(atom/movable/O, turf/target)
//	if(istype(O) && (O.pass_flags & PASSTABLE))
//		return 1
	if(istype(O, /obj/projectile))
		return 1
	if(O.throwing)
		return 1
	if(isobserver(O))
		return 1
	if(isliving(O))
		var/mob/living/M = O
		if(!(M.mobility_flags & MOBILITY_STAND))
			if(passcrawl)
				return TRUE
	if(icon_state == "woodrailing" && dir in CORNERDIRS)
		var/list/baddirs = list()
		switch(dir)
			if(SOUTHEAST)
				baddirs = list(SOUTHEAST, SOUTH, EAST)
			if(SOUTHWEST)
				baddirs = list(SOUTHWEST, SOUTH, WEST)
			if(NORTHEAST)
				baddirs = list(NORTHEAST, NORTH, EAST)
			if(NORTHWEST)
				baddirs = list(NORTHWEST, NORTH, WEST)
		if(get_dir(O.loc, target) in baddirs)
			return 0
	else if(get_dir(O.loc, target) == dir)
		return 0
	return 1

/obj/structure/fluff/railing/OnCrafted(dirin)
	. = ..()
	var/lay = getwlayer(dir)
	if(lay)
		layer = lay

/obj/structure/fluff/railing/corner
	icon_state = "railing_corner"
	density = FALSE

/obj/structure/fluff/railing/wood
	icon_state = "woodrailing"
	blade_dulling = DULLING_BASHCHOP
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/railing/stonehedge
	icon_state = "stonehedge"
	blade_dulling = DULLING_BASHCHOP
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/railing/border
	name = "border"
	desc = ""
	icon_state = "border"
	passcrawl = FALSE

/obj/structure/fluff/railing/fence
	name = "palisade"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	attacked_sound = 'sound/misc/woodhit.ogg'
	destroy_sound = 'sound/misc/treefall.ogg'
	icon_state = "fence"
	density = TRUE
	opacity = TRUE
	anchored = TRUE
	layer = 2.91
	climbable = FALSE
	max_integrity = 400
	passcrawl = FALSE
	climb_offset = 6

/obj/structure/fluff/railing/fence/Initialize()
	. = ..()
	smooth_fences()

/obj/structure/fluff/railing/fence/Destroy()
	for(var/obj/structure/fluff/railing/fence/F in orange(1))
		if(F.dir == dir)
			F.smooth_fences(TRUE)
	return ..()

/obj/structure/fluff/railing/fence/OnCrafted(dirin)
	. = ..()
	smooth_fences()

/obj/structure/fluff/railing/fence/proc/smooth_fences(neighbors)
	cut_overlays()
	if((dir == WEST) || (dir == EAST))
		var/turf/T = get_step(src, NORTH)
		if(T)
			for(var/obj/structure/fluff/railing/fence/F in T)
				if(F.dir == dir)
					if(!neighbors)
						F.smooth_fences(TRUE)
					var/mutable_appearance/MA = mutable_appearance(icon,"fence_smooth_above")
					MA.dir = dir
					add_overlay(MA)
		T = get_step(src, SOUTH)
		if(T)
			for(var/obj/structure/fluff/railing/fence/F in T)
				if(F.dir == dir)
					if(!neighbors)
						F.smooth_fences(TRUE)
					var/mutable_appearance/MA = mutable_appearance(icon,"fence_smooth_below")
					MA.dir = dir
					add_overlay(MA)

/obj/structure/fluff/railing/fence/CanPass(atom/movable/mover, turf/target)
	if(get_dir(loc, target) == dir)
		return 0
	return 1

/obj/structure/fluff/railing/fence/CheckExit(atom/movable/O, turf/target)
	if(istype(O, /obj/projectile))
		return 1
	if(get_dir(O.loc, target) == dir)
		return 0
	return 1

/obj/structure/bars
	name = "bars"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "bars"
	density = TRUE
	anchored = TRUE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 700
	damage_deflection = 12
	integrity_failure = 0.15
	dir = SOUTH
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN
	attacked_sound = list("sound/combat/hits/onmetal/metalimpact (1).ogg", "sound/combat/hits/onmetal/metalimpact (2).ogg")
	leanable = TRUE
	smeltresult = /obj/item/ingot/iron

/obj/structure/bars/CanPass(atom/movable/mover, turf/target)
	if(isobserver(mover))
		return 1
	if(istype(mover) && (mover.pass_flags & PASSGRILLE))
		return 1
	if(mover.throwing && !ismob(mover))
		return prob(66)
	return !density
	..()

/obj/structure/bars/chainlink
	icon_state = "chainlink"

obj/structure/bars/steel
	name = "steel bars"
	max_integrity = 2000

/obj/structure/bars/tough
	max_integrity = 9000
	damage_deflection = 40

/obj/structure/bars/obj_break(damage_flag)
	icon_state = "[initial(icon_state)]b"
	density = FALSE
	..()

/obj/structure/bars/cemetery
	icon_state = "cemetery"

/obj/structure/bars/passage
	icon_state = "passage0"
	density = TRUE
	max_integrity = 1500

/obj/structure/bars/passage/steel
	name = "steel bars"
	max_integrity = 2000

/obj/structure/bars/passage/redstone_triggered()
	if(obj_broken)
		return
	if(density)
		icon_state = "passage1"
		density = FALSE
	else
		icon_state = "passage0"
		density = TRUE

/obj/structure/bars/passage/shutter
	icon_state = "shutter0"
	density = TRUE
	opacity = TRUE

/obj/structure/bars/passage/shutter/redstone_triggered()
	if(obj_broken)
		return
	if(density)
		icon_state = "shutter1"
		density = FALSE
		opacity = FALSE
	else
		icon_state = "shutter0"
		density = TRUE
		opacity = TRUE

/obj/structure/bars/passage/shutter/open
	icon_state = "shutter1"
	density = FALSE
	opacity = FALSE

/obj/structure/bars/grille
	name = "grille"
	desc = ""
	icon_state = "floorgrille"
	density = FALSE
	layer = TABLE_LAYER
	plane = GAME_PLANE
	damage_deflection = 5
	blade_dulling = DULLING_BASHCHOP
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
	attacked_sound = list('sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg')
	var/togg = FALSE

/obj/structure/bars/grille/Initialize()
	AddComponent(/datum/component/squeak, list('sound/foley/footsteps/FTMET_A1.ogg','sound/foley/footsteps/FTMET_A2.ogg','sound/foley/footsteps/FTMET_A3.ogg','sound/foley/footsteps/FTMET_A4.ogg'), 100)
	dir = pick(GLOB.cardinals)
	return ..()

/obj/structure/bars/grille/obj_break(damage_flag)
	obj_flags = CAN_BE_HIT
	..()

/obj/structure/bars/grille/redstone_triggered()
	if(obj_broken)
		return
	testing("togge")
	togg = !togg
	playsound(src, 'sound/foley/trap_arm.ogg', 100)
	if(togg)
		testing("togge1")
		icon_state = "floorgrilleopen"
		obj_flags = CAN_BE_HIT
		var/turf/T = loc
		if(istype(T))
			for(var/mob/living/M in loc)
				T.Entered(M)
	else
		testing("togge2")
		icon_state = "floorgrille"
		obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP


/obj/structure/bars/pipe
	name = "bronze pipe"
	desc = ""
	icon_state = "pipe"
	density = FALSE
	layer = TABLE_LAYER
	plane = GAME_PLANE
	damage_deflection = 5
	blade_dulling = DULLING_BASHCHOP
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
	attacked_sound = list('sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg')
	var/togg = FALSE
	smeltresult = /obj/item/ingot/bronze

/obj/structure/bars/pipe/left
	name = "bronze pipe"
	desc = ""
	icon_state = "pipe2"
	dir = WEST
	pixel_x = 19

//===========================

/obj/structure/fluff/clock
	name = "clock"
	desc = ""
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "clock"
	density = FALSE
	anchored = FALSE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 100
	integrity_failure = 0.5
	dir = SOUTH
	break_sound = "glassbreak"
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = 'sound/combat/hits/onglass/glasshit.ogg'
	var/broke = FALSE
	var/datum/looping_sound/clockloop/soundloop
	drag_slowdown = 3
	metalizer_result = /obj/item/roguegear/bronze

/obj/structure/fluff/clock/Initialize()
	soundloop = new(src, FALSE)
	soundloop.start()
	. = ..()

/obj/structure/fluff/clock/Destroy()
	if(soundloop)
		soundloop.stop()
	return ..()

/obj/structure/fluff/clock/obj_break(damage_flag)
	if(!broke)
		broke = TRUE
		icon_state = "b[initial(icon_state)]"
		if(soundloop)
			soundloop.stop()
		attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	..()

/obj/structure/fluff/clock/attack_right(mob/user)
	if(user.mind && isliving(user))
		if(user.mind.special_items && user.mind.special_items.len)
			var/item = input(user, "What will I take?", "STASH") as null|anything in user.mind.special_items
			if(item)
				if(user.Adjacent(src))
					if(user.mind.special_items[item])
						var/path2item = user.mind.special_items[item]
						user.mind.special_items -= item
						var/obj/item/I = new path2item(user.loc)
						user.put_in_hands(I)
			return

/obj/structure/fluff/clock/examine(mob/user)
	. = ..()
	if(!broke)
		var/day = "... actually, WHAT dae is it?"
		switch(GLOB.dayspassed)
			if(1)
				day = "Moon's dae."
			if(2)
				day = "Tiw's dae."
			if(3)
				day = "Wedding's dae."
			if(4)
				day = "Thule's dae."
			if(5)
				day = "Freyja's dae."
			if(6)
				day = "Saturn's dae."
			if(7)
				day = "Sun's dae."
		. += "Oh no, it's [station_time_timestamp("hh:mm")] on a [day]"

/obj/structure/fluff/clock/CanPass(atom/movable/mover, turf/target)
	if(get_dir(loc, mover) == dir)
		return 0
	return 1

/obj/structure/fluff/clock/CheckExit(atom/movable/O, turf/target)
	if(get_dir(O.loc, target) == dir)
		return 0
	return 1

/obj/structure/fluff/wallclock
	name = "clock"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "wallclock"
	density = FALSE
	anchored = TRUE
	layer = BELOW_MOB_LAYER
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 100
	integrity_failure = 0.5
	var/datum/looping_sound/clockloop/soundloop
	break_sound = "glassbreak"
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = 'sound/combat/hits/onglass/glasshit.ogg'
	var/broke = FALSE
	pixel_y = 32
	metalizer_result = /obj/item/roguegear/bronze

/obj/structure/fluff/wallclock/Destroy()
	if(soundloop)
		soundloop.stop()
	return ..()

/obj/structure/fluff/wallclock/examine(mob/user)
	. = ..()
	if(!broke)
		var/day = "... actually, WHAT dae is it?"
		switch(GLOB.dayspassed)
			if(1)
				day = "Moon's dae."
			if(2)
				day = "Tiw's dae."
			if(3)
				day = "Wedding's dae."
			if(4)
				day = "Thule's dae."
			if(5)
				day = "Freyja's dae."
			if(6)
				day = "Saturn's dae."
			if(7)
				day = "Sun's dae."
		. += "Oh no, it's [station_time_timestamp("hh:mm")] on a [day]"

/obj/structure/fluff/wallclock/Initialize()
	soundloop = new(src, FALSE)
	soundloop.start()
	. = ..()

/obj/structure/fluff/wallclock/obj_break(damage_flag)
	if(!broke)
		broke = TRUE
		icon_state = "b[initial(icon_state)]"
		if(soundloop)
			soundloop.stop()
		attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	..()

/obj/structure/fluff/wallclock/l
	pixel_y = 0
	pixel_x = -32
/obj/structure/fluff/wallclock/r
	pixel_y = 0
	pixel_x = 32
//vampire
/obj/structure/fluff/wallclock/vampire
	name = "ancient clock"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "wallclockvampire"
	density = FALSE
	anchored = TRUE
	layer = BELOW_MOB_LAYER
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 100
	integrity_failure = 0.5
	pixel_y = 32

/obj/structure/fluff/wallclock/vampire/l
	pixel_y = 0
	pixel_x = -32
/obj/structure/fluff/wallclock/vampire/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/fluff/signage
	name = "sign"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "shitsign"
	density = TRUE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 500
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')

/obj/structure/fluff/signage/examine(mob/user)
	. = ..()
	if(!user.is_literate())
		. += "I have no idea what it says."
	else
		. += "It says \"TOWN ON ROCKHILL\""

/obj/structure/fluff/buysign
	icon_state = "signwrote"
	name = "sign"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
/obj/structure/fluff/buysign/examine(mob/user)
	. = ..()
	if(!user.is_literate())
		. += "I have no idea what it says."
	else
		. += "It says \"IMPORTS\""

/obj/structure/fluff/sellsign
	icon_state = "signwrote"
	name = "sign"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
/obj/structure/fluff/sellsign/examine(mob/user)
	. = ..()
	if(!user.is_literate())
		. += "I have no idea what it says."
	else
		. += "It says \"EXPORTS\""


/obj/structure/fluff/customsign
	name = "sign"
	desc = ""
	icon_state = "sign"
	var/wrotesign
	max_integrity = 500
	blade_dulling = DULLING_BASHCHOP
	icon = 'icons/roguetown/misc/structure.dmi'

/obj/structure/fluff/customsign/examine(mob/user)
	. = ..()
	if(wrotesign)
		if(!user.is_literate())
			. += "I have no idea what it says."
		else
			. += "It says \"[wrotesign]\"."

/obj/structure/fluff/customsign/attackby(obj/item/W, mob/user, params)
	if(!user.cmode)
		if(!user.is_literate())
			to_chat(user, span_warning("I don't know any verba."))
			return
		if((user.used_intent.blade_class == BCLASS_STAB) && (W.wlength == WLENGTH_SHORT))
			if(wrotesign)
				to_chat(user, span_warning("Something is already carved here."))
				return
			else
				var/inputty = stripped_input(user, "What would you like to carve here?", "", null, 200)
				if(inputty && !wrotesign)
					wrotesign = inputty
					icon_state = "signwrote"
	..()

/obj/structure/fluff/statue
	name = "statue"
	desc = ""
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "bstatue"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	blade_dulling = DULLING_BASH
	max_integrity = 300
	dir = SOUTH

/obj/structure/fluff/statue/OnCrafted(dirin, user)
	dirin = turn(dirin, 180)
	. = ..()

/obj/structure/fluff/statue/attack_right(mob/user)
	if(user.mind && isliving(user))
		if(user.mind.special_items && user.mind.special_items.len)
			var/item = input(user, "What will I take?", "STASH") as null|anything in user.mind.special_items
			if(item)
				if(user.Adjacent(src))
					if(user.mind.special_items[item])
						var/path2item = user.mind.special_items[item]
						user.mind.special_items -= item
						var/obj/item/I = new path2item(user.loc)
						user.put_in_hands(I)
			return


/obj/structure/fluff/statue/CanPass(atom/movable/mover, turf/target)
	if(get_dir(loc, mover) == dir)
		return 0
	return !density

/obj/structure/fluff/statue/CheckExit(atom/movable/O, turf/target)
	if(get_dir(O.loc, target) == dir)
		return 0
	return !density

/obj/structure/fluff/statue/gargoyle
	icon_state = "gargoyle"

/obj/structure/fluff/statue/gargoyle/candles
	icon_state = "gargoyle_candles"

/obj/structure/fluff/statue/gargoyle/moss
	icon_state = "mgargoyle"

/obj/structure/fluff/statue/gargoyle/moss/candles
	icon_state = "mgargoyle_candles"

/obj/structure/fluff/statue/knight
	icon_state = "knightstatue_l"

/obj/structure/fluff/statue/astrata
	name = "astrata statue"
	desc = "A stone statue of the sun Goddess Astrata. Bless."
	icon_state = "astrata"
	icon = 'icons/roguetown/misc/tallandwide.dmi'

/obj/structure/fluff/statue/astrata/gold
	name = "ornamental astrata statue"
	desc = "An ornamental stone statue of the sun Goddess Astrata, decorated with golden jewelry. Bless."
	icon_state = "astrata_bling"

/obj/structure/fluff/statue/knight/r
	icon_state = "knightstatue_r"

/obj/structure/fluff/statue/knight/interior
	icon_state = "oknightstatue_l"

/obj/structure/fluff/statue/knight/interior/r
	icon_state = "oknightstatue_r"

/obj/structure/fluff/statue/knightalt
	icon_state = "knightstatue2_l"

/obj/structure/fluff/statue/knightalt/r
	icon_state = "knightstatue2_r"


/obj/structure/fluff/statue/myth
	icon_state = "myth"
	density = TRUE

/obj/structure/fluff/statue/psy
	icon_state = "psy"
	icon = 'icons/roguetown/misc/96x96.dmi'
	pixel_x = -32

/obj/structure/fluff/statue/small
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "elfs"

/obj/structure/fluff/statue/pillar
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "pillar"

/obj/structure/fluff/statue/femalestatue
	icon = 'icons/roguetown/misc/ay.dmi'
	icon_state = "1"
	pixel_x = -32
	pixel_y = -16

/obj/structure/fluff/statue/femalestatue/Initialize()
	. = ..()
	var/matrix/M = new
	M.Scale(0.7,0.7)
	src.transform = M

/obj/structure/fluff/statue/scare
	name = "scarecrow"
	icon_state = "td"

/obj/structure/fluff/statue/tdummy
	name = "practice dummy"
	icon_state = "p_dummy"
	icon = 'icons/roguetown/misc/structure.dmi'

/obj/structure/fluff/statue/tdummy/attackby(obj/item/W, mob/user, params)
	if(!user.cmode)
		if(W.associated_skill)
			if(user.mind)
				if(isliving(user))
					var/mob/living/L = user
					var/probby = (L.STALUC / 10) * 100
					probby = min(probby, 99)
					user.changeNext_move(CLICK_CD_MELEE)
					if(W.max_blade_int)
						W.remove_bintegrity(5)
					L.stamina_add(rand(4,6))
					if(!(L.mobility_flags & MOBILITY_STAND))
						probby = 0
					if(L.STAINT < 3)
						probby = 0
					if(prob(probby) && !user.buckled)
						user.visible_message(span_info("[user] trains on [src]!"))
						var/amt2raise = L.STAINT * 0.35
						if(!can_train_combat_skill(user, W.associated_skill, SKILL_LEVEL_APPRENTICE))
							to_chat(user, span_warning("I've learned all I can from doing this, it's time for the real thing."))
							amt2raise = 0
						if(amt2raise > 0)
							user.mind.add_sleep_experience(W.associated_skill, amt2raise, FALSE)
						playsound(loc,pick('sound/combat/hits/onwood/education1.ogg','sound/combat/hits/onwood/education2.ogg','sound/combat/hits/onwood/education3.ogg'), rand(50,100), FALSE)
					else
						user.visible_message(span_danger("[user] trains on [src], but [src] ripostes!"))
						L.AdjustKnockdown(1)
						L.throw_at(get_step(L, get_dir(src,L)), 2, 2, L, spin = FALSE)
						playsound(loc, 'sound/combat/hits/kick/stomp.ogg', 100, TRUE, -1)
					flick(pick("p_dummy_smashed","p_dummy_smashedalt"),src)
					return
	..()

/obj/structure/fluff/statue/spider
	name = "mother"
	icon_state = "spidercore"

/obj/structure/fluff/statue/spider/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/honey))
		if(user.mind)
			if(user.mind.special_role == "Dark Elf")
				playsound(loc,'sound/misc/eat.ogg', rand(30,60), TRUE)
				if(SSticker.mode)
					var/datum/game_mode/chaosmode/C = SSticker.mode
					C.delfcontrib += 1
					if(C.delfcontrib >= C.delfgoal)
						say("Well done, the brood will grow...",language = /datum/language/elvish)
					else
						say("Please bring me [C.delfgoal-C.delfcontrib] more honeys, children!",language = /datum/language/elvish)
				qdel(W)
				return TRUE
	..()

/obj/structure/fluff/statue/evil
	name = "idol"
	desc = "A statue built to the robber-god, Matthios, who stole the gift of fire from the underworld. It is said that he grants the wishes of those pagan bandits (free folk) who feed him money and valuable metals."
	icon_state = "evilidol"
	icon = 'icons/roguetown/misc/structure.dmi'

// What items the idol will accept
	var/treasuretypes = list(
		/obj/item/roguecoin,
		/obj/item/roguegem,
		/obj/item/clothing/ring,
		/obj/item/ingot,
		/obj/item/clothing/neck/roguetown/psicross,
		/obj/item/reagent_containers/glass/cup,
		/obj/item/roguestatue,
		/obj/item/riddleofsteel,
		/obj/item/listenstone,
		/obj/item/clothing/neck/roguetown/shalal,
		/obj/item/clothing/neck/roguetown/horus,
		/obj/item/rogue/painting,
		/obj/item/clothing/head/roguetown/crown/serpcrown,
		/obj/item/clothing/head/roguetown/vampire,
		/obj/item/scomstone
	)

/obj/structure/fluff/statue/evil/attackby(obj/item/W, mob/user, params)
	if(!HAS_TRAIT(user, TRAIT_COMMIE))
		return
	var/donatedamnt = W.get_real_price()
	if(user.mind)
		if(user)
			if(W.sellprice <= 0)
				to_chat(user, span_warning("This item is worthless."))
				return
			var/proceed_with_offer = FALSE
			for(var/TT in treasuretypes)
				if(istype(W, TT))
					proceed_with_offer = TRUE
					break
			if(proceed_with_offer)
				playsound(loc,'sound/items/carvty.ogg', 50, TRUE)
				qdel(W)
				for(var/mob/player in GLOB.player_list)
					if(player.mind)
						if(player.mind.has_antag_datum(/datum/antagonist/bandit))
							var/datum/antagonist/bandit/bandit_players = player.mind.has_antag_datum(/datum/antagonist/bandit)
							bandit_players.favor += donatedamnt
							bandit_players.totaldonated += donatedamnt
							to_chat(player, ("<font color='yellow'>[user.name] donates [donatedamnt] to the shrine! You now have [bandit_players.favor] favor.</font>"))

			else
				to_chat(user, span_warning("This item isn't a good offering."))
				return
	..()

/obj/structure/fluff/psycross
	name = "pantheon cross"
	icon_state = "psycross"
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	break_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	density = FALSE
	anchored = TRUE
	blade_dulling = DULLING_BASHCHOP
	layer = BELOW_MOB_LAYER
	max_integrity = 100
	sellprice = 40
	flags_1 = HEAR_1
	var/chance2hear = 30
	buckleverb = "crucifie"
	can_buckle = 1
	buckle_lying = 0
	breakoutextra = 10 MINUTES
	dir = NORTH
	buckle_requires_restraints = 1
	buckle_prevents_pull = 1

/obj/structure/fluff/psycross/post_buckle_mob(mob/living/M)
	..()
	M.set_mob_offsets("bed_buckle", _x = 0, _y = 2)
	M.setDir(SOUTH)

/obj/structure/fluff/psycross/post_unbuckle_mob(mob/living/M)
	..()
	M.reset_offsets("bed_buckle")

/obj/structure/fluff/psycross/CanPass(atom/movable/mover, turf/target)
	if(get_dir(loc, mover) == dir)
		return 0
	return !density

/obj/structure/fluff/psycross/CheckExit(atom/movable/O, turf/target)
	if(get_dir(O.loc, target) == dir)
		return 0
	return !density

/obj/structure/fluff/psycross/copper
	name = "pantheon cross"
	icon_state = "psycrosschurch"
	break_sound = null
	attacked_sound = list("sound/combat/hits/onmetal/metalimpact (1).ogg", "sound/combat/hits/onmetal/metalimpact (2).ogg")
	chance2hear = 66

/obj/structure/fluff/psycross/crafted
	name = "wooden pantheon cross"
	icon_state = "psycrosscrafted"
	max_integrity = 80
	chance2hear = 10

/obj/structure/fluff/psycross/attackby(obj/item/W, mob/living/carbon/human/user, params)
	if(user.mind)
		if((user.mind.assigned_role == "Priest") || ((user.mind.assigned_role == "Acolyte") && (user.patron.type == /datum/patron/divine/eora)))
			if(istype(W, /obj/item/reagent_containers/food/snacks/grown/apple))
				var/marriage
				var/obj/item/reagent_containers/food/snacks/grown/apple/A = W
				if(A.bitten_names.len)
					if(A.bitten_names.len == 2)
						var/list/found_mobs = list()
						for(var/mob/M in viewers(src, 7))
							testing("check [M]")
							if(found_mobs.len >= 2)
								break
							if(!ishuman(M))
								continue
							var/mob/living/carbon/human/C = M
							for(var/X in A.bitten_names)
								if(C.real_name == X)
									testing("foundbiter [C.real_name]")
									found_mobs += C
						testing("foundmobslen [found_mobs.len]")
						if(found_mobs.len == 2)
							var/mob/living/carbon/human/FirstPerson
							var/mob/living/carbon/human/SecondPerson
							for(var/mob/living/carbon/human/M in found_mobs)
								if(M.marriedto)
									continue
								if(!FirstPerson)
									FirstPerson = M
								else
									if(!SecondPerson)
										SecondPerson = M
							if(!FirstPerson || !SecondPerson)
								testing("fail22")
								return
							var/surname2use
							var/index = findtext(FirstPerson.real_name, " ")
							var/SecondPersonFirstName
							FirstPerson.original_name = FirstPerson.real_name
							SecondPerson.original_name = SecondPerson.real_name
							if(!index)
								surname2use = FirstPerson.dna.species.random_surname()
							else
								if(findtext(FirstPerson.real_name, " of ") || findtext(FirstPerson.real_name, " the "))
									surname2use = FirstPerson.dna.species.random_surname()
									FirstPerson.change_name(copytext(FirstPerson.real_name, 1,index))
								else
									surname2use = copytext(FirstPerson.real_name, index)
									FirstPerson.change_name(copytext(FirstPerson.real_name, 1,index))
							index = findtext(SecondPerson.real_name, " ")
							if(index)
								SecondPerson.change_name(copytext(SecondPerson.real_name, 1,index))
							SecondPersonFirstName = SecondPerson.real_name
							FirstPerson.change_name(FirstPerson.real_name + surname2use)
							SecondPerson.change_name(SecondPerson.real_name + surname2use)
							FirstPerson.marriedto = SecondPerson.real_name
							SecondPerson.marriedto = FirstPerson.real_name
							FirstPerson.adjust_triumphs(1)
							SecondPerson.adjust_triumphs(1)
							priority_announce("Rejoice, for [user.real_name] has united [FirstPerson.real_name] and [SecondPersonFirstName] in marriage!", title = "Holy Union!", sound = 'sound/misc/bell.ogg')
							marriage = TRUE
							qdel(A)
//							if(FirstPerson.has_stress(/datum/stressevent/nobel))
//								SecondPerson.add_stress(/datum/stressevent/nobel)
//							if(SecondPerson.has_stress(/datum/stressevent/nobel))
//								FirstPerson.add_stress(/datum/stressevent/nobel)

				if(!marriage)
					A.burn()
					return
	. = ..()

/obj/structure/fluff/psycross/proc/check_prayer(mob/living/L,message)
	if(!L || !message)
		return FALSE
	var/message2recognize = sanitize_hear_message(message)
	if(findtext(message2recognize, "zizo"))
		L.add_stress(/datum/stressevent/psycurse)
		L.adjust_fire_stacks(100)
		L.IgniteMob()
		return FALSE
	if(length(message2recognize) > 15)
		if(L.mob_timers[MT_PSYPRAY])
			if(world.time < L.mob_timers[MT_PSYPRAY] + 1 MINUTES)
				L.mob_timers[MT_PSYPRAY] = world.time
				return FALSE
		else
			L.mob_timers[MT_PSYPRAY] = world.time
		if(!prob(chance2hear))
			return FALSE
		else
			L.playsound_local(L, 'sound/misc/notice (2).ogg', 100, FALSE)
			L.add_stress(/datum/stressevent/psyprayer)
			return TRUE

/obj/structure/fluff/psycross/copper/Destroy()
	addomen("psycross")
	return ..()

/obj/structure/fluff/psycross/proc/AOE_flash(mob/user, range = 15, power = 5, targeted = FALSE)
	var/list/mob/targets = get_flash_targets(get_turf(src), range, FALSE)
	for(var/mob/living/carbon/C in targets)
		flash_carbon(C, user, power, targeted, TRUE)
	return TRUE

/obj/structure/fluff/psycross/proc/get_flash_targets(atom/target_loc, range = 15)
	if(!target_loc)
		target_loc = loc
	if(isturf(target_loc) || (ismob(target_loc) && isturf(target_loc.loc)))
		return viewers(range, get_turf(target_loc))
	else
		return typecache_filter_list(target_loc.GetAllContents(), GLOB.typecache_living)

/obj/structure/fluff/psycross/proc/flash_carbon(mob/living/carbon/M, mob/user, power = 15, targeted = TRUE, generic_message = FALSE)
	if(!istype(M))
		return
	if(user)
		log_combat(user, M, "[targeted? "flashed(targeted)" : "flashed(AOE)"]", src)
	else //caused by emp/remote signal
		M.log_message("was [targeted? "flashed(targeted)" : "flashed(AOE)"]",LOG_ATTACK)
	if(generic_message && M != user)
		to_chat(M, span_danger("[src] emits a blinding light!"))
	if(M.flash_act())
		var/diff = power - M.confused
		M.confused += min(power, diff)

/obj/structure/fluff/beach_towel
	name = "beach towel"
	desc = ""
	icon = 'icons/obj/fluff.dmi'
	icon_state = "railing"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/beach_umbrella
	name = "beach umbrella"
	desc = ""
	icon = 'icons/obj/fluff.dmi'
	icon_state = "brella"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/beach_umbrella/security
	icon_state = "hos_brella"

/obj/structure/fluff/beach_umbrella/science
	icon_state = "rd_brella"

/obj/structure/fluff/beach_umbrella/engine
	icon_state = "ce_brella"

/obj/structure/fluff/beach_umbrella/cap
	icon_state = "cap_brella"

/obj/structure/fluff/beach_umbrella/syndi
	icon_state = "syndi_brella"

/obj/structure/fluff/clockwork
	name = "Clockwork Fluff"
	icon = 'icons/obj/clockwork_objects.dmi'
	deconstructible = FALSE

/obj/structure/fluff/clockwork/alloy_shards
	name = "replicant alloy shards"
	desc = ""
	icon_state = "alloy_shards"

/obj/structure/fluff/clockwork/alloy_shards/small
	icon_state = "shard_small1"

/obj/structure/fluff/clockwork/alloy_shards/medium
	icon_state = "shard_medium1"

/obj/structure/fluff/clockwork/alloy_shards/medium_gearbit
	icon_state = "gear_bit1"

/obj/structure/fluff/clockwork/alloy_shards/large
	icon_state = "shard_large1"

/obj/structure/fluff/clockwork/blind_eye
	name = "blind eye"
	desc = ""
	icon_state = "blind_eye"

/obj/structure/fluff/clockwork/fallen_armor
	name = "fallen armor"
	desc = ""
	icon_state = "fallen_armor"

/obj/structure/fluff/clockwork/clockgolem_remains
	name = "clockwork golem scrap"
	desc = ""
	icon_state = "clockgolem_dead"

/obj/structure/fluff/statue/shisha
	name = "shisha pipe"
	desc = "A traditional shisha pipe, this one is broken."
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "zbuski"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	blade_dulling = DULLING_BASH
	max_integrity = 300

/obj/structure/fluff/headstake
	name = "head on a stake"
	desc = ""
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "headstake"
	density = FALSE
	anchored = TRUE
	dir = SOUTH
	var/obj/item/grown/log/tree/stake/stake
	var/obj/item/bodypart/head/victim


/obj/structure/fluff/headstake/CheckParts(list/parts_list)
	..()
	victim = locate(/obj/item/bodypart/head) in parts_list
	name = "[victim.name] on a stake"
	update_icon()
	stake = locate(/obj/item/grown/log/tree/stake) in parts_list

///obj/structure/fluff/headstake/Initialize()
//	. = ..()

/obj/structure/fluff/headstake/OnCrafted(dirin, user)
	dir = SOUTH
	pixel_x = rand(-8, 8)
	return

/obj/structure/fluff/headstake/update_icon()
	..()
	var/obj/item/bodypart/head/H = locate() in contents
	var/mutable_appearance/MA = new()
	if(H)
		MA.copy_overlays(H)
		H.pixel_y = rand(9, 11)
		H.pixel_x = pixel_x
		H.dir = SOUTH
		add_overlay(H)

/obj/structure/fluff/headstake/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	to_chat(user, span_notice("I take down [src]."))
	victim.forceMove(drop_location())
	victim = null
	stake.forceMove(drop_location())
	stake = null
	qdel(src)

/obj/structure/fluff/littlebanners
	name = "hanging little banners"
	desc = ""
	icon = 'icons/obj/structures/decor.dmi'
	icon_state = "hangingbanners_wr"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	blade_dulling = DULLING_BASH
	resistance_flags = FLAMMABLE
	max_integrity = 20
	integrity_failure = 0.33
	dir = SOUTH
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')


/obj/structure/fluff/littlebanners/greenblue
	icon_state = "hangingbanners_gb"

/obj/structure/fluff/littlebanners/greenred
	icon_state = "hangingbanners_gr"

/obj/structure/fluff/littlebanners/bluewhite
	icon_state = "hangingbanners_bw"

/obj/structure/fluff/littlebanners/greenwhite
	icon_state = "hangingbanners_gw"

/obj/structure/fluff/littlebanners/bluered
	icon_state = "hangingbanners_br"

/obj/structure/fluff/littlebanners/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr) && (in_range(src, usr) || usr.contents.Find(src)))
		if(!ishuman(usr))
			return
		visible_message(span_notice("[usr] tears down [src]."))
		if(do_after(usr, 30, target = src))
			playsound(src,'sound/foley/dropsound/cloth_drop.ogg', 100, FALSE)
			new /obj/item/natural/cloth (get_turf(src))
			new /obj/item/natural/cloth (get_turf(src))
			new /obj/item/natural/cloth (get_turf(src))
			new /obj/item/natural/cloth (get_turf(src))
			qdel(src)

///Crafting

/datum/crafting_recipe/roguetown/structure/littlebanners
	name = "fair banners red-white"
	result = list(/obj/structure/fluff/littlebanners)
	reqs = list(/obj/item/natural/cloth = 4, /obj/item/natural/fibers)
	verbage_simple = "construct"
	verbage = "constructs"
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/littlebanners/greenblue
	name = "fair banners green-blue"
	result = list(/obj/structure/fluff/littlebanners/greenblue)

/datum/crafting_recipe/roguetown/structure/littlebanners/greenred
	name = "fair banners green-red"
	result = list(/obj/structure/fluff/littlebanners/greenred)

/datum/crafting_recipe/roguetown/structure/littlebanners/bluewhite
	name = "fair banners blue-white"
	result = list(/obj/structure/fluff/littlebanners/bluewhite)

/datum/crafting_recipe/roguetown/structure/littlebanners/greenwhite
	name = "fair banners green-white"
	result = list(/obj/structure/fluff/littlebanners/greenwhite)

/datum/crafting_recipe/roguetown/structure/littlebanners/bluered
	name = "fair banners blue-red"
	result = list(/obj/structure/fluff/littlebanners/bluered)

/obj/structure/fluff/canopy
	name = "Canopy"
	desc = ""
	icon = 'icons/obj/structures/decor.dmi'
	icon_state = "canopy"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	blade_dulling = DULLING_BASH
	resistance_flags = FLAMMABLE
	max_integrity = 20
	integrity_failure = 0.33
	dir = SOUTH
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')

/obj/structure/fluff/canopy/green
	icon_state = "canopyg"

/obj/structure/fluff/canopy/booth
	icon_state = "canopyr-booth"

/obj/structure/fluff/canopy/booth/booth02
	icon_state = "canopyr-booth-2"

/obj/structure/fluff/canopy/booth/booth_green
	icon_state = "canopyg-booth"

/obj/structure/fluff/canopy/booth/booth_green02
	icon_state = "canopyg-booth-2"

/obj/structure/fluff/canopy/side
	icon_state = "canopyb-side"

/obj/structure/fluff/canopy/side/end
	icon_state = "canopyb-side-end"

/obj/structure/fluff/canopy/booth/CanPass(atom/movable/mover, turf/target)
	if(get_dir(loc, mover) == dir)
		return 0
	return !density

/obj/structure/fluff/canopy/booth/CheckExit(atom/movable/O, turf/target)
	if(get_dir(O.loc, target) == dir)
		return 0
	return !density

/obj/structure/fluff/canopy/MouseDrop(mob/over)
	. = ..()

///Crafting

/datum/crafting_recipe/roguetown/structure/display_booth01
	name = "display booth"
	result = list(/obj/structure/fluff/canopy, /obj/structure/table/wood/crafted)
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/cloth = 2)
	verbage_simple = "construct"
	verbage = "constructs"

/datum/crafting_recipe/roguetown/structure/display_booth02
	name = "display booth green"
	result = list(/obj/structure/fluff/canopy/green, /obj/structure/table/wood/crafted)
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/cloth = 2)
	verbage_simple = "construct"
	verbage = "constructs"


/datum/crafting_recipe/roguetown/structure/booth
	name = "market booth"
	result = list(/obj/structure/fluff/canopy/booth)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/cloth = 2)
	verbage_simple = "construct"
	verbage = "constructs"
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/booth02
	name = "market booth"
	result = list(/obj/structure/fluff/canopy/booth/booth02)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/cloth = 2)
	verbage_simple = "construct"
	verbage = "constructs"
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/booth_green
	name = "green market booth"
	result = list(/obj/structure/fluff/canopy/booth/booth_green)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/cloth = 2)
	verbage_simple = "construct"
	verbage = "constructs"
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/booth_green_02
	name = "green market booth02"
	result = list(/obj/structure/fluff/canopy/booth/booth_green02)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/cloth = 2)
	verbage_simple = "construct"
	verbage = "constructs"
	skill_level = 0

/obj/structure/fluff/canopy/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr) && (in_range(src, usr) || usr.contents.Find(src)))
		if(!ishuman(usr))
			return
		visible_message(span_notice("[usr] tears down [src]."))
		if(do_after(usr, 30, target = src))
			playsound(src,'sound/foley/dropsound/cloth_drop.ogg', 100, FALSE)
			new /obj/item/grown/log/tree/small  (get_turf(src))
			new /obj/item/natural/cloth (get_turf(src))
			qdel(src)
