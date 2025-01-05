/datum/crafting_recipe/roguetown/gravemarker
	name = "надгробный знак"
	result = /obj/structure/gravemarker
	reqs = list(/obj/item/grown/log/tree/stick = 1)
	time = 10 SECONDS
	verbage_simple = "tie together"
	verbage = "ties together"
	craftsound = 'sound/foley/Building-01.ogg'
	structurecraft = /obj/structure/closet/dirthole
	skill_level = 0

/datum/crafting_recipe/roguetown/gravemarker/TurfCheck(mob/user, turf/T)
	if(!(locate(/obj/structure/closet/dirthole) in T))
		to_chat(user, span_warning("Здесь нет могилы."))
		return FALSE
	for(var/obj/structure/closet/dirthole/D in T)
		if(D.stage != 4)
			to_chat(user, span_warning("Могила не засыпана."))
			return FALSE
	if(locate(/obj/structure/gravemarker) in T)
		to_chat(user, span_warning("Эта могила уже освящена."))
		return FALSE
	return TRUE

/obj/structure/gravemarker
	name = "надгробный знак"
	desc = "Простой знак в честь усопшего.."
	icon = 'icons/turf/roguefloor.dmi'
	icon_state = "gravemarker1"
	density = FALSE
	max_integrity = 0
	static_debris = list(/obj/item/grown/log/tree/stick = 1)
	anchored = TRUE
	layer = 2.91

/obj/structure/gravemarker/Destroy()
	var/turf/T = get_turf(src)
	if(T)
		new /obj/item/grown/log/tree/stick(T)
	return ..()

/mob/dead/new_player/proc/reducespawntime(amt)
	if(ckey)
		if(amt)
			if(GLOB.respawntimes[ckey])
				GLOB.respawntimes[ckey] = GLOB.respawntimes[ckey] + amt

/obj/structure/gravemarker/OnCrafted(dir, user)
	icon_state = "gravemarker[rand(1,3)]"
	for(var/obj/structure/closet/dirthole/hole in loc)
		if(pacify_coffin(hole, user))
			break
	return ..()
