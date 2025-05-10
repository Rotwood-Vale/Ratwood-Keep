/obj/effect/spawner/npc_dungeon
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "random_loot"
	layer = OBJ_LAYER

/obj/effect/spawner/npc_dungeon/Initialize(mapload)
	. = ..()
	var/turf/T = get_turf(src)
	if(!T)
		return

	var/roll = rand(1, 100)

	if(roll <= 20)
		var/mob/living/carbon/human/species/human/northern/dungeon_base/warrior/W = new(T)
		W.equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_warrior)
	else if(roll <= 40)
		var/mob/living/carbon/human/species/human/northern/dungeon_base/paladin/P = new(T)
		P.equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_paladin)
	else if(roll <= 60)
		var/mob/living/carbon/human/species/human/northern/dungeon_base/cleric/C = new(T)
		C.equipOutfit(new /datum/outfit/job/roguetown/npc/dungeon_cleric)

	qdel(src)
