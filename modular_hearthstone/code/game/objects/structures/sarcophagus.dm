/obj/structure/closet/crate/coffin/sarcophagus
	name = "sarcophagus"
	icon_state = "sarcophagus"
	desc = "A place for the dignified dead to rest."
	anchored = TRUE
	resistance_flags = null
	open_sound_volume = 25
	close_sound_volume = 50
	max_integrity = 120
	icon = 'modular_hearthstone/icons/obj/crypt.dmi'
	open_sound = 'sound/foley/doors/stoneopen.ogg'
	close_sound = 'sound/foley/doors/stoneclose.ogg'

/obj/structure/closet/crate/coffin/sarcophagus/alt
	icon_state = "sarcophagus2"

/obj/structure/closet/crate/coffin/sarcophagus/alt2
	icon_state = "sarcophagus3"

/obj/structure/closet/crate/coffin/sarcophagus/alt3
	icon_state = "sarcophagus4"


/obj/structure/sarcophagus
	name = "sarcophagus"
	icon = 'modular_hearthstone/icons/obj/crypt.dmi'
	icon_state = "sarcophagus_abandoned"
	anchored = TRUE
	density = TRUE

/obj/structure/sarcophagus/alt
	icon_state = "sarcophagus_abandoned2"

/obj/structure/closet/crate/coffin/sarcophagus/open(mob/living/user)
	if(opened)
		return
	if(user)
		if(!can_open(user))
			return
	if(do_after(usr, 30, target = src))
		playsound(loc, open_sound, open_sound_volume, FALSE, -3)
		opened = TRUE
		if(!dense_when_open)
			density = FALSE
	//	climb_time *= 0.5 //it's faster to climb onto an open thing
		dump_contents()
		update_icon()
		return 1


/obj/structure/closet/crate/coffin/sarcophagus/close(mob/living/user)
	if(!opened)
		return FALSE
	if(user)
		if(!can_close(user))
			return FALSE
	if(do_after(usr, 30, target = src))
		take_contents()
		playsound(loc, close_sound, close_sound_volume, FALSE, -3)
	//	climb_time = initial(climb_time)
		opened = FALSE
		density = TRUE
		update_icon()
		return TRUE

/obj/effect/spawner/lootdrop/roguetown/dungeon/corpses
	loot = list(
	/mob/living/carbon/human/species/skeleton/dead/footman = 5,
	/mob/living/carbon/human/species/skeleton/dead/footman2 = 7,
	/mob/living/carbon/human/species/skeleton/dead/knight = 1,
	/mob/living/carbon/human/species/skeleton/dead/noble = 3,
		)
	lootcount = 1



/obj/structure/closet/crate/coffin/sarcophagus/dungeon
	name = "sarcophagus"
	icon_state = "sarcophagus"

/obj/structure/closet/crate/coffin/sarcophagus/dungeon/alt
	icon_state = "sarcophagus2"

/obj/structure/closet/crate/coffin/sarcophagus/dungeon/alt2
	icon_state = "sarcophagus3"

/obj/structure/closet/crate/coffin/sarcophagus/dungeon/alt3
	icon_state = "sarcophagus4"


/obj/structure/closet/crate/coffin/sarcophagus/dungeon/PopulateContents()
	..()
	if(prob(60))
		new	/mob/living/carbon/human/species/skeleton/dead/footman2(src)
		if(prob(40))
			new	/mob/living/carbon/human/species/skeleton/dead/noble(src)
			if(prob(30))
				new 	/mob/living/carbon/human/species/skeleton/dead/knight(src)
	else
		new /mob/living/carbon/human/species/skeleton/dead/footman(src)
	if(prob(30))
		new /obj/item/rogueweapon/sword (src)
		if(prob(20))
			new /obj/item/rogueweapon/sword/short (src)
			if(prob(60))
				new /obj/item/rogueweapon/sword/iron/messer (src)
				if(prob(60))
					new /obj/item/rogueweapon/sword/sabre(src)
					if(prob(60))
						new /obj/item/rogueweapon/sword/rapier (src)
						if(prob(60))
							new /obj/item/rogueweapon/sword/silver (src)
							if(prob(10))
								new /obj/item/rogueweapon/sword/long (src)
								if(prob(10))
									new /obj/item/rogueweapon/greatsword (src)
									if(prob(60))
										new /obj/item/rogueweapon/spear (src)
										if(prob(60))
											new /obj/item/rogueweapon/spear/billhook (src)
											if(prob(20))
												new /obj/item/rogueweapon/halberd (src)
												if(prob(20))
													new /obj/item/storage/belt/rogue/pouch/coins/mid (src)
													if(prob(10))
														new /obj/item/storage/belt/rogue/pouch/coins/rich (src)
	else
		new /obj/item/rogueweapon/sword/iron/short/chipped (src)
		if(prob(50))
			new	/obj/item/storage/belt/rogue/pouch/coins/poor (src)








/obj/structure/bed/rogue/shit/bier
	name = "bier"
	desc = "A stand on which a corpse is placed to lie in state or to be carried to the grave."
	icon = 'modular_hearthstone/icons/obj/crypt.dmi'
	icon_state = "bier"
	anchored = TRUE
	density = TRUE


/obj/effect/spawner/lootdrop/roguetown/sarcophagi
	name = "sarcophagi"
	loot = list(
	/obj/structure/closet/crate/coffin/sarcophagus/dungeon = 10,
	/obj/structure/closet/crate/coffin/sarcophagus/dungeon/alt = 10,
	/obj/structure/closet/crate/coffin/sarcophagus/dungeon/alt2 = 10,
	/obj/structure/closet/crate/coffin/sarcophagus/dungeon/alt3 = 10,
	/obj/structure/closet/crate/coffin/sarcophagus = 5,
	/obj/structure/closet/crate/coffin/sarcophagus/alt = 5,
	/obj/structure/closet/crate/coffin/sarcophagus/alt2 = 5,
	/obj/structure/closet/crate/coffin/sarcophagus/alt3 = 5,
	/obj/structure/sarcophagus = 1,
	/obj/structure/sarcophagus/alt =1.
	)
	lootcount = 1