
/obj/item/banner/standard
	force = 10
	force_wielded = 15
	possible_item_intents = list(SPEAR_THRUST, SPEAR_BASH)
	gripped_intents = list(SPEAR_THRUST, SPEAR_BASH)
	name = "ashen tide banner"
	icon_state = "ashen"
	icon = 'modular_hearthstone/icons/obj/banners.dmi'
	pixel_y = 0
	pixel_x = 0
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	layer = ABOVE_MOB_LAYER
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 8
	max_blade_int = 100
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	wdefense = 5
	thrown_bclass = BCLASS_STAB
	throwforce = 20
	resistance_flags = FLAMMABLE


/obj/item/banner/standard/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = 6,"sy" = 8,"nx" = 7,"ny" = 3,"wx" = -10,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/banner/standard/ashen

/obj/item/banner/standard/blacksteel_legion
	name = "blacksteel legion banner"
	icon_state = "blacksteel"


/obj/item/banner/standard/eagle
	name = "band of eagle banner"
	icon_state = "eagle"

///Crafting - Standard


/datum/crafting_recipe/roguetown/standard
	name = "ashen banner"
	result = list(/obj/item/banner/standard/ashen)
	reqs = list(/obj/item/natural/cloth = 2, /obj/item/rogueweapon/woodstaff = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	craftdiff = 0

/datum/crafting_recipe/roguetown/standard/blacksteel_legion
	name = "blacksteel banner"
	result = list(/obj/item/banner/standard/blacksteel_legion)

/datum/crafting_recipe/roguetown/standard/eagle
	name = "eagle banner"
	result = list(/obj/item/banner/standard/eagle)



///Crafting - Banner

/datum/crafting_recipe/roguetown/structure/banner
	name = "plant banner (Ashen)"
	result = list(/obj/structure/fluff/standard/ashen)
	reqs = list(/obj/item/banner/standard/ashen = 1)
	verbage_simple = "plants"
	verbage = "plants"
	craftdiff = 0
	craftsound = 'sound/foley/dropsound/gen_drop.ogg'

/datum/crafting_recipe/roguetown/structure/banner/blacksteel
	name = "plant banner (Blacksteel)"
	result = list(/obj/structure/fluff/standard/blacksteel_legion)
	reqs = list(/obj/item/banner/standard/blacksteel_legion = 1)

/datum/crafting_recipe/roguetown/structure/banner/eagle
	name = "plant banner (Eagle)"
	result = list(/obj/structure/fluff/standard/eagle)
	reqs = list(/obj/item/banner/standard/eagle = 1)

/obj/structure/fluff/standard
	name = "Ashen Banner"
	desc = ""
	icon = 'modular_hearthstone/icons/obj/banners.dmi'
	icon_state = "ashen"
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

/obj/structure/fluff/standard/ashen

/obj/structure/fluff/standard/blacksteel_legion
	name = "Blacksteel Banner"
	desc = ""
	icon_state = "blacksteel"

/obj/structure/fluff/standard/eagle
	name = "Band of the Eagle Banner"
	desc = ""
	icon_state = "eagle"

/obj/structure/fluff/standard/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr) && (in_range(src, usr) || usr.contents.Find(src)))
		if(!ishuman(usr))
			return
		visible_message(span_notice("[usr] lifts the [src]."))
		if(do_after(usr, 30, target = src))
			playsound(src,'sound/foley/dropsound/cloth_drop.ogg', 100, FALSE)
			if(istype(src, /obj/structure/fluff/standard/ashen))
				new /obj/item/banner/standard/ashen (get_turf(src))
			if (istype(src, /obj/structure/fluff/standard/blacksteel_legion))
				new /obj/item/banner/standard/blacksteel_legion (get_turf(src))
			if(istype(src, /obj/structure/fluff/standard/eagle))
				new /obj/item/banner/standard/eagle (get_turf(src))
			qdel(src)

