/datum/artificer_recipe/guns/barrel_bs
	name = "Blacksteel Gun Barrel (+Steel Barrel)"
	required_item = /obj/item/ingot/blacksteel
	created_item = /obj/item/gunbarrel/blacksteel
	additional_items = list(/obj/item/gunbarrel = 1)
	hammers_per_item = 5
	skill_level = 4

/datum/artificer_recipe/guns/parts_bs
	name = "Blacksteel gun Lock (+1 Cog)"
	required_item = /obj/item/ingot/blacksteel
	created_item = /obj/item/gunlock/blacksteel
	additional_items = list(/obj/item/roguegear/bronze = 1)
	hammers_per_item = 5
	skill_level = 4

/datum/artificer_recipe/guns/stock_bs
	name = "Runed Gun Stock (+1 Psycross)"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/gunstock/blacksteel
	additional_items = list(/obj/item/clothing/neck/roguetown/psicross = 1)
	hammers_per_item = 5
	skill_level = 4

/datum/artificer_recipe/guns/runelock
	name = "Runelock (+1 Stock) (+1 Lock) (+1 Barrel) (BLACKSTEEL!)"
	required_item = /obj/item/ingot/steel
	additional_items = list(/obj/item/gunlock/blacksteel = 1,
							/obj/item/gunstock/blacksteel = 1,
							/obj/item/gunbarrel/blacksteel = 1)
	created_item = list(/obj/item/gun/ballistic/revolver/grenadelauncher/runelock_rk)
	hammers_per_item = 10
	skill_level = 4

/datum/artificer_recipe/guns/arquebuspistol
	name = "Arquebus (+1 Stock) (+1 Lock) (+1 Barrel)"
	required_item = /obj/item/ingot/steel
	additional_items = list(/obj/item/gunlock = 1,
							/obj/item/gunstock = 1,
							/obj/item/gunbarrel = 1)
	created_item = list(/obj/item/gun/ballistic/firearm/arquebus_pistol)
	hammers_per_item = 10
	skill_level = 4

/datum/artificer_recipe/contraptions/engiflask
	name = "Compact Gunpowderflask (+1 Bronze Cog)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear/bronze = 1)
	created_item = /obj/item/powderflask/artificer
	hammers_per_item = 12
	skill_level = 4

/datum/artificer_recipe/ammunition/rbullets
	name = "Runed Bullets"
	required_item = /obj/item/ingot/blacksteel
	created_item = list(/obj/item/ammo_casing/caseless/runelock,
						/obj/item/ammo_casing/caseless/runelock,
						/obj/item/ammo_casing/caseless/runelock, 
						/obj/item/ammo_casing/caseless/runelock, 
						/obj/item/ammo_casing/caseless/runelock, 
					)
	hammers_per_item = 10
	skill_level = 4

/obj/item/gunlock/blacksteel
	name = "Blacksteel Gun Lock"
	icon_state = "gunlock_bs"
	desc = "The 'firing' part of a gun. Reinforced with blacksteel"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_redmoon/modules/artificerandguns/runelock.dmi'

/obj/item/gunstock/blacksteel
	name = "Imbued Gun Stock"
	icon_state = "gunstock_bs"
	desc = "The 'holding' part of a gun. Has a runes and a Psycross cut into it"
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_redmoon/modules/artificerandguns/runelock.dmi'

/obj/item/gunbarrel/blacksteel
	name = "Blacksteel Gun Barrel"
	icon_state = "gunbarrel_bs"
	desc = "The 'aiming' part of a gun. Reinforced with blacksteel"
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_redmoon/modules/artificerandguns/runelock.dmi'

/obj/item/ammo_casing/caseless/runelock
	desc = "A small blacksteel bullet, perfectly crafted covered in Psydonite runes. Deadly when projected at very high velocity."
	name = "runed bullet"
	icon = 'modular_redmoon/modules/artificerandguns/runelock.dmi'
	icon_state = "musketball_bs"

/obj/projectile/bullet/reusable/runelock
	speed = 0.1

/obj/item/powderflask/artificer
	name = "Mechanised powderflask"
	icon = 'modular_redmoon/modules/artificerandguns/runelock.dmi'
	desc = "A neatly engineered gunpowder flask that compresses powder for size decreasement and cuts it for you so you dont have to measure it that much."
	icon_state = "engiflask"
	item_state = "powderflask"
	slot_flags = SLOT_BELT_L | SLOT_BELT_R | ITEM_SLOT_NECK | ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_SMALL
	grid_height = 64
	grid_width = 32

/datum/outfit/job/roguetown/puritan/pre_equip
	beltl = /obj/item/ammo_holder/bullet/runed
	beltr = /obj/item/gun/ballistic/revolver/grenadelauncher/runelock_rk
