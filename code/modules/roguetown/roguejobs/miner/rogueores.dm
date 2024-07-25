/obj/item/rogueore
	name = "ore"
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ore"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/rogueore/gold
	name = "raw gold"
	desc = "A clump of dirty lustrous nuggets!"
	icon_state = "oregold1"
	smeltresult = /obj/item/ingot/gold
	sellprice = 10

/obj/item/rogueore/gold/Initialize()
	icon_state = "oregold[rand(1,3)]"
	..()


/obj/item/rogueore/silver
	name = "raw silver"
	desc = "A gleaming ore of moonlight hue."
	icon_state = "oresilv1"
	smeltresult = /obj/item/ingot/silver
	sellprice = 8

/obj/item/rogueore/silver/Initialize()
	icon_state = "oresilv[rand(1,3)]"
	..()


/obj/item/rogueore/iron
	name = "raw iron"
	desc = "A dark ore of rugged strength."
	icon_state = "oreiron1"
	smeltresult = /obj/item/ingot/iron
	sellprice = 5

/obj/item/rogueore/iron/Initialize()
	icon_state = "oreiron[rand(1,3)]"
	..()


/obj/item/rogueore/copper
	name = "raw copper"
	desc = "A burnished ore with reddish gleams."
	icon_state = "orecop1"
	smeltresult = /obj/item/ingot/copper
	sellprice = 3

/obj/item/rogueore/copper/Initialize()
	icon_state = "orecop[rand(1,3)]"
	..()

/obj/item/rogueore/coal
	name = "coal"
	desc = "Dark lumps that become smoldering embers later in life."
	icon_state = "orecoal1"
	firefuel = 60 MINUTES
	smeltresult = /obj/item/rogueore/coal
	sellprice = 1

/obj/item/rogueore/coal/Initialize()
	icon_state = "orecoal[rand(1,3)]"
	..()

/obj/item/ingot
	name = "ingot"
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ingot"
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null
	var/datum/anvil_recipe/currecipe
	var/quality = SMELTERY_LEVEL_NORMAL
	var/smelted = FALSE

/obj/item/ingot/Initialize(mapload, smelt_quality)
	. = ..()
	if(smelt_quality)
		quality = smelt_quality
		smelted = TRUE
		switch(quality)
			if(SMELTERY_LEVEL_SPOIL)
				name = "spoilt-quality [name]"
			if(SMELTERY_LEVEL_POOR)
				name = "poor-quality [name]"
			if(SMELTERY_LEVEL_GOOD)
				name = "good-quality [name]"
			if(SMELTERY_LEVEL_EXPERT)         //This ores are getting the same quality as good. Can be expanded for better ones in the future
				name = "good-quality [name]"
			if(SMELTERY_LEVEL_MASTER)
				name = "good-quality [name]"
			if(SMELTERY_LEVEL_LEGENDARY)
				name = "good-quality [name]"

/obj/item/ingot/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/rogueweapon/tongs))
		var/obj/item/rogueweapon/tongs/T = I
		if(!T.hingot)
			forceMove(T)
			T.hingot = src
			T.hott = null
			T.update_icon()
			return
	..()

/obj/item/ingot/Destroy()
	if(currecipe)
		QDEL_NULL(currecipe)
	if(istype(loc, /obj/machinery/anvil))
		var/obj/machinery/anvil/A = loc
		A.hingot = null
		A.update_icon()
	..()

/obj/item/ingot/gold
	name = "gold bar"
	desc = "Solid wealth in your hands."
	icon_state = "ingotgold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 100

/obj/item/ingot/iron
	name = "iron bar"
	desc = "Forged strength. Essential for crafting."
	icon_state = "ingotiron"
	smeltresult = /obj/item/ingot/iron
	sellprice = 25
/obj/item/ingot/copper
	name = "copper bar"
	desc = "An ingot of malleable essence."
	icon_state = "ingotcop"
	smeltresult = /obj/item/ingot/copper
	sellprice = 10
/obj/item/ingot/silver
	name = "silver bar"
	desc = "This bar radiates purity. Treasured by the realms."
	icon_state = "ingotsilv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 60
/obj/item/ingot/steel
	name = "steel bar"
	desc = "This ingot is a stalwart defender of the kingdom."
	icon_state = "ingotsteel"
	smeltresult = /obj/item/ingot/steel
	sellprice = 40
