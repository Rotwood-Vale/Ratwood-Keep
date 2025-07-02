/datum/artificer_recipe
	var/name
	var/list/additional_items = list()
	var/appro_skill = /datum/skill/craft/engineering
	var/required_item
	var/created_item
	/// Craft Difficulty here only matters for exp calculation and locking recipes based on skill level
	var/skill_level = 0
	var/obj/item/needed_item
	/// If tha current item has been hammered all the times it needs to
	var/hammered = FALSE
	/// How many times does this need to be hammered?
	var/hammers_per_item = 0
	var/progress
	/// I_type is like "sub category"
	var/i_type

	var/datum/parent

// Small design rules for Artificer!
// If you make any crafteable by the Artificer trough here make sure it interacts with Artificer Contraptions!

/datum/artificer_recipe/proc/advance(obj/item/I, mob/user)
	if(progress == 100)
		return
	if(hammers_per_item == 0)
		hammered = TRUE
		user.visible_message(span_warning("[user] hammers the contraption."))
		if(additional_items.len)
			needed_item = pick(additional_items)
			additional_items -= needed_item
		if(needed_item)
			to_chat(user, span_info("Now it's time to add \a [initial(needed_item.name)]."))
			return
	if(!needed_item && hammered)
		progress = 100
		return
	if(!hammered && hammers_per_item)
		switch(user.mind.get_skill_level(appro_skill))
			if(SKILL_LEVEL_NONE to SKILL_LEVEL_NOVICE)
				hammers_per_item = max(0, hammers_per_item -= 0.5)
			if(SKILL_LEVEL_APPRENTICE to SKILL_LEVEL_JOURNEYMAN)
				hammers_per_item = max(0, hammers_per_item -= 1)
			if(SKILL_LEVEL_EXPERT to SKILL_LEVEL_MASTER)
				hammers_per_item = max(0, hammers_per_item -= 2)
			if(SKILL_LEVEL_LEGENDARY to INFINITY)
				hammers_per_item = max(0, hammers_per_item -= 3)
		user.visible_message(span_warning("[user] hammers the contraption."))
		return

/datum/artificer_recipe/proc/item_added(mob/user)
	user.visible_message(span_info("[user] adds [initial(needed_item.name)]."))
	if(istype(needed_item, /obj/item/natural/wood/plank))
		playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
	needed_item = null
	hammers_per_item = initial(hammers_per_item)
	hammered = FALSE

// --------- GENERAL -----------

/datum/artificer_recipe
	appro_skill = /datum/skill/craft/engineering

/datum/artificer_recipe/general
	i_type = "General"

/datum/artificer_recipe/wood //TNevermind this being silly, I was silly and this needs to be redone proper
	name = "Wooden Cog"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/roguegear/wood/basic
	hammers_per_item = 5
	skill_level = 1
	i_type = "General"

/datum/artificer_recipe/wood/reliable
	name = "Reliable Wooden Cog (+1 Essence of Lumber)"
	created_item = /obj/item/roguegear/wood/reliable
	additional_items = list(/obj/item/grown/log/tree/small/essence = 1)
	hammers_per_item = 10
	skill_level = 2

/datum/artificer_recipe/wood/unstable
	name = "Unstable Wooden Cog (+1 Essence of Wilderness)"
	created_item = /obj/item/roguegear/wood/unstable
	additional_items = list(/obj/item/natural/cured/essence = 1)
	hammers_per_item = 10
	skill_level = 3

/datum/artificer_recipe/bronze
	name = "Bronze Cog"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/roguegear/bronze
	hammers_per_item = 10
	skill_level = 1
	i_type = "General"
/*
//Copper and Tin cogs make sense, but for some reason we're making bronze cogs? And we have no copper or tin cogs yet, nor uses. Commented out for later.
/datum/artificer_recipe/general/copper/cog
	name = "Copper Cog"
	required_item = /obj/item/ingot/copper
	created_item = /obj/item/roguegear/bronze
	hammers_per_item = 10
	skill_level = 1

/datum/artificer_recipe/general/tin/cog
	name = "Tin Cog"
	required_item = /obj/item/ingot/tin
	created_item = /obj/item/roguegear/bronze
	hammers_per_item = 10
	skill_level = 1
*/
/datum/artificer_recipe/bronze/locks
	name = "Locks 5x"
	created_item = list(/obj/item/customlock, /obj/item/customlock, /obj/item/customlock, /obj/item/customlock, /obj/item/customlock)
	hammers_per_item = 5
	skill_level = 1

/datum/artificer_recipe/bronze/keys
	name = "Keys 5x"
	created_item = list(/obj/item/key_custom_blank, /obj/item/key_custom_blank, /obj/item/key_custom_blank, /obj/item/key_custom_blank, /obj/item/key_custom_blank)
	hammers_per_item = 5
	skill_level = 1

// --------- TOOLS -----------

/datum/artificer_recipe/wood/tools
	name = "Wooden Mallet"
	created_item = /obj/item/rogueweapon/hammer/wood
	hammers_per_item = 8
	i_type = "Tools"

/datum/artificer_recipe/bronze/tools
	name = "Bronze Lamptern"
	created_item = /obj/item/flashlight/flare/torch/lantern/bronzelamptern
	hammers_per_item = 9
	skill_level = 3
	i_type = "Tools"


/datum/artificer_recipe/bronze/tools/waterpurifier
	name = "Self-Purifying Waterskin (+1 waterskin)"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/reagent_containers/glass/bottle/waterskin/purifier
	additional_items = list(/obj/item/reagent_containers/glass/bottle/waterskin)

/datum/artificer_recipe/bronze/tools/grappler
	name = "Grappler (+1 ironpick)(+2 bronze gears)(+1 rope)"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/grapplinghook
	additional_items = list(/obj/item/rogueweapon/pick, /obj/item/roguegear/bronze, /obj/item/roguegear/bronze, /obj/item/rope)
	skill_level = 4

// --------- Contraptions -----------

/datum/artificer_recipe/contraptions
	i_type = "Contraptions"

/datum/artificer_recipe/contraptions/metalizer
	name = "Wood Metalizer (+1 Wooden Cog)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear/wood/basic = 1)
	created_item = /obj/item/contraption/wood_metalizer
	hammers_per_item = 12
	skill_level = 4

/datum/artificer_recipe/contraptions/smelter
	name = "Portable Smelter (+1 Coal)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/rogueore/coal = 1)
	created_item = /obj/item/contraption/smelter
	hammers_per_item = 10
	skill_level = 3

/datum/artificer_recipe/contraptions/imprinter
	name = "Lock Imprinter (+1 Reliable Wooden Cog)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear/wood/reliable = 1)
	created_item = /obj/item/contraption/lock_imprinter
	hammers_per_item = 12
	skill_level = 4
/datum/artificer_recipe/contraptions/whisperer
	name = "Bronze Whisperer (+1 bronze gear +1 tin ingot)"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/contraption/whisper
	additional_items = list(/obj/item/roguegear/bronze,/obj/item/ingot/tin)
	hammers_per_item = 10
	skill_level = 3

/datum/artificer_recipe/contraptions/smokebombs
	name = "smokebomb(s) (6) (+1 Coal)"
	required_item = /obj/item/ingot/iron
	additional_items = list(/obj/item/rogueore/coal = 1)
	created_item = list(/obj/item/smokebomb,
						/obj/item/smokebomb,
						/obj/item/smokebomb,
						/obj/item/smokebomb,
						/obj/item/smokebomb,
						/obj/item/smokebomb,)
	hammers_per_item = 12
	skill_level = 3

/datum/artificer_recipe/contraptions/artificerarmor
	name = "Artificer armor (+3 Copper ingot)(+1 Bronze gear)"
	required_item = /obj/item/ingot/copper
	additional_items = list(/obj/item/ingot/copper,/obj/item/ingot/copper, /obj/item/ingot/copper, /obj/item/roguegear/bronze)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/artificerarmor
	hammers_per_item = 12
	skill_level = 4

/datum/artificer_recipe/contraptions/volticgauntlet
	name = "Voltic Gauntlet (+1 Tin ingot)(+2 Bronze gear)(+1 cinnabar ore)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear/bronze, /obj/item/roguegear/bronze,/obj/item/ingot/tin, /obj/item/rogueore/cinnabar)
	created_item = /obj/item/clothing/gloves/roguetown/active/voltic
	hammers_per_item = 12
	skill_level = 4

/datum/artificer_recipe/contraptions/coolingbackpack
	name = "Cooling Backpack (+1 bronze gear, +Backpack)" // why are these recipes capitalized differently than every other crafting recipe my ocddddddddddd
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/storage/backpack/rogue/backpack/artibackpack
	additional_items = list(/obj/item/roguegear/bronze, /obj/item/storage/backpack/rogue/backpack)
	skill_level = 5
// --------- WEAPON -----------

/datum/artificer_recipe/wood/weapons //Again, a bit silly, but is important
	name = "Wooden Staff (+1 Plank)"
	created_item = /obj/item/rogueweapon/woodstaff
	additional_items = list(/obj/item/natural/wood/plank = 1)
	hammers_per_item = 3
	i_type = "Weapons"

/datum/artificer_recipe/wood/weapons/bow // easier recipe for bows
	name = "Wooden Bow (+1 Fiber) (+1 Plank)"
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	hammers_per_item = 3
	additional_items = list(/obj/item/natural/wood/plank = 1, /obj/item/natural/fibers = 1)

/datum/artificer_recipe/wood/weapons/wsword
	name = "Wooden Sword (+1 Plank)"
	created_item = /obj/item/rogueweapon/mace/wsword
	additional_items = list(/obj/item/natural/wood/plank = 1)
	hammers_per_item = 3

/datum/artificer_recipe/wood/weapons/wshield
	name = "Wooden Shield (+1 Plank)"
	created_item = /obj/item/rogueweapon/shield/wood/crafted
	additional_items = list(/obj/item/natural/wood/plank = 1)
	hammers_per_item = 6
	skill_level = 2

/obj/item/rogueweapon/shield/wood/crafted
	sellprice = 6

/datum/artificer_recipe/wood/weapons/hshield
	name = "Heater Shield (+1 Cured Leather)"
	created_item = /obj/item/rogueweapon/shield/heater/crafted
	additional_items = list(/obj/item/natural/wood/plank = 1, /obj/item/natural/hide/cured = 1)
	hammers_per_item = 6
	skill_level = 3

/obj/item/rogueweapon/shield/heater/crafted
	sellprice = 6

/datum/artificer_recipe/wood/weapons/steamshield
	name = "Steam Shield (+1 wood plank)(+2 Bronze gear)(+2 bronze ingot)"
	additional_items = list(/obj/item/roguegear/bronze, /obj/item/roguegear/bronze,/obj/item/natural/wood/plank, /obj/item/ingot/bronze,/obj/item/ingot/bronze)
	created_item = /obj/item/rogueweapon/shield/artificer
	hammers_per_item = 12
	skill_level = 3

/// CROSSBOW

/datum/artificer_recipe/wood/weapons/crossbow
	name = "Crossbow (+1 Steel) (+1 Fiber)"
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/fibers)
	hammers_per_item = 10
	skill_level = 4

// --------- AMMUNITION -----------

/datum/artificer_recipe/ammunition
	i_type = "Ammunition"

/datum/artificer_recipe/ammunition/bolts
	name = "Crossbow Bolts 20x (+2 planks, +1 Iron)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/natural/wood/plank, /obj/item/natural/wood/plank, /obj/item/ingot/iron)
	created_item = list(/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt,
						/obj/item/ammo_casing/caseless/rogue/bolt
					)
	hammers_per_item = 6
	skill_level = 2

/datum/artificer_recipe/ammunition/arrows
	name = "Arrows 20x (+2 Planks, +1 Iron)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/natural/wood/plank, /obj/item/natural/wood/plank,  /obj/item/ingot/iron)
	created_item = list(/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron
					)
	hammers_per_item = 6
	skill_level = 2

/datum/artificer_recipe/ammunition/musket
	name = "Musket balls 8x "
	required_item = /obj/item/ingot/tin		//more uses for tin, and historically some musketballs were lead-tin alloys.
	created_item = list(/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead
					)
	hammers_per_item = 10
	skill_level = 2

/datum/artificer_recipe/ammunition/grapeshot
	name = "Grapeshot 8x "
	required_item = /obj/item/ingot/tin
	created_item = list(/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot
					)
	hammers_per_item = 10
	skill_level = 2

/datum/artificer_recipe/ammunition/pyrobolt_five
	name = "pyroclastic bolt x5 (+1 iron) (+1 fyritius)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/ingot/iron, /obj/item/reagent_containers/food/snacks/grown/rogue/fyritius)
	created_item = list(
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro
				)
	hammers_per_item = 6
	skill_level = 2


/datum/artificer_recipe/ammunition/pyroarrow_five
	name = "pyroclastic arrow x5 (+1 iron) (+1 fyritius)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/ingot/iron, /obj/item/reagent_containers/food/snacks/grown/rogue/fyritius)
	created_item = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro
				)
	hammers_per_item = 6
	skill_level = 2

// --------- PROSTHETICS -----------

/datum/artificer_recipe/prosthetics
	i_type = "Prosthetics"

/datum/artificer_recipe/prosthetics/wood/arm_left
	name = "Left Wooden Arm (+2 Plank) (+1 Wooden Cog)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/natural/wood/plank = 2, /obj/item/roguegear/wood/basic = 1)
	created_item = /obj/item/bodypart/l_arm/prosthetic/wood
	hammers_per_item = 4
	skill_level = 2

/datum/artificer_recipe/prosthetics/wood/arm_right
	name = "Right Wooden Arm (+2 Plank) (+1 Wooden Cog)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/natural/wood/plank = 2, /obj/item/roguegear/wood/basic = 1)
	created_item = /obj/item/bodypart/r_arm/prosthetic/wood
	hammers_per_item = 4
	skill_level = 2

/datum/artificer_recipe/prosthetics/wood/leg_left
	name = "Left Wooden Leg (+2 Plank) (+1 Wooden Cog)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/natural/wood/plank = 2, /obj/item/roguegear/wood/basic = 1)
	created_item = /obj/item/bodypart/l_leg/prosthetic/wood
	hammers_per_item = 4
	skill_level = 2

/datum/artificer_recipe/prosthetics/wood/leg_right
	name = "Right Wooden Leg (+2 Plank) (+1 Wooden Cog)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/natural/wood/plank = 2, /obj/item/roguegear/wood/basic = 1)
	created_item = /obj/item/bodypart/r_leg/prosthetic/wood
	hammers_per_item = 4
	skill_level = 2

/datum/artificer_recipe/prosthetics/wood/eye
	name = "Wooden Eyeball"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/organ/eyes/robotic/wooden
	hammers_per_item = 5
	skill_level = 2

// --------- BRONZE -----------

/datum/artificer_recipe/bronze/prosthetic
	name = "Bronze Left Arm (+1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/bronze
	hammers_per_item = 15
	skill_level = 4
	additional_items = list(/obj/item/roguegear/bronze = 1)
	i_type = "Prosthetics"

/datum/artificer_recipe/bronze/prosthetic/arm_right
	name = "Bronze Right Arm (+1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/bronze

// --------- GOLD -----------

/datum/artificer_recipe/gold/prosthetic // Guh this need a gold subtype oh well maybe some day there will be a golden cock! COG I MEAN GOD OMG
	name = "Gold Left Arm (+2 Cog)"
	required_item = /obj/item/ingot/gold
	created_item = /obj/item/bodypart/l_arm/prosthetic/gold
	additional_items = list(/obj/item/roguegear/bronze = 2)
	hammers_per_item = 20
	skill_level = 5
	i_type = "Prosthetics"

/datum/artificer_recipe/gold/prosthetic/arm_right
	name = "Gold Right Arm (+2 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/gold

/datum/artificer_recipe/gold/prosthetic/leg_left
	name = "Gold Left Leg (+2 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/gold

/datum/artificer_recipe/gold/prosthetic/leg_right
	name = "Gold Right Leg (+2 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/gold

// --------- STEEL -----------

/datum/artificer_recipe/steel/prosthetic
	name = "Steel Left Arm (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/steel
	required_item = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel = 1, /obj/item/roguegear/bronze = 1)
	hammers_per_item = 15
	skill_level = 4
	i_type = "Prosthetics"

/datum/artificer_recipe/steel/prosthetic/arm_right
	name = "Steel Right Arm (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/steel

/datum/artificer_recipe/steel/prosthetic/leg_left
	name = "Steel Left Leg (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/steel

/datum/artificer_recipe/steel/prosthetic/leg_right
	name = "Steel Right Leg (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/steel

// --------- GUNS -----------

/datum/artificer_recipe/guns
	i_type = "Firearms"

/datum/artificer_recipe/guns/barrel
	name = "Gun Barrel (+1 Steel)"
	required_item = /obj/item/ingot/steel
	created_item = /obj/item/gunbarrel
	additional_items = list(/obj/item/ingot/steel = 1)
	hammers_per_item = 5
	skill_level = 2

/datum/artificer_recipe/guns/parts
	name = "Gun Lock (+1 Cog)"
	required_item = /obj/item/ingot/steel
	created_item = /obj/item/gunlock
	additional_items = list(/obj/item/roguegear/bronze = 1)
	hammers_per_item = 5
	skill_level = 3

/datum/artificer_recipe/guns/stock
	name = "Gun Stock"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/gunstock
	hammers_per_item = 5
	skill_level = 2

/datum/artificer_recipe/guns/arquebus
	name = "Arquebus (+1 Stock) (+1 Lock) (+1 Barrel)"
	required_item = /obj/item/ingot/steel
	additional_items = list(/obj/item/gunlock = 1,
							/obj/item/gunstock = 1,
							/obj/item/gunbarrel = 1)
	created_item = list(/obj/item/gun/ballistic/firearm/arquebus)
	hammers_per_item = 10
	skill_level = 4

/datum/artificer_recipe/guns/blunderbuss
	name = "Blunderbuss (+1 Stock) (+1 Lock) (+1 Barrel)"
	required_item = /obj/item/ingot/steel
	additional_items = list(/obj/item/gunlock = 1,
							/obj/item/gunstock = 1,
							/obj/item/gunbarrel = 1)
	created_item = list(/obj/item/gun/ballistic/firearm/blunderbuss)
	hammers_per_item = 10
	skill_level = 4

// --------- IRON -----------

/datum/artificer_recipe/iron/prosthetic //These are the inexpensive alternatives
	name = "Iron Left Arm (+1 Plank) (+1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/iron
	required_item = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/wood/plank = 1, /obj/item/roguegear/bronze = 1)
	hammers_per_item = 4
	skill_level = 2
	i_type = "Prosthetics"

/datum/artificer_recipe/iron/prosthetic/arm_right
	name = "Iron Right Arm (+1 Plank) (+1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/iron

/datum/artificer_recipe/iron/prosthetic/leg_left
	name = "Iron Left Leg (+1 Plank) (+1 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/iron

/datum/artificer_recipe/iron/prosthetic/leg_right
	name = "Iron Right Leg (+1 Plank) (+1 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/iron


// ------------ Explosives expansion----------
/datum/artificer_recipe/general
	i_type = "General"

/datum/artificer_recipe/general/coaldust
	name = "Coal dust"
	required_item = /obj/item/rogueore/coal
	created_item = list(/obj/item/rogueore/coaldust, /obj/item/rogueore/sulfur, /obj/item/rogueore/selitre)
	hammers_per_item = 5
	skill_level = 2

/datum/artificer_recipe/general/tntbomb
	name = "Gun powder sticks"
	required_item = /obj/item/rogueore/coal
	additional_items = list(/obj/item/paper/scroll,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/sulfur,
							/obj/item/rogueore/sulfur,
						 	/obj/item/rogueore/selitre,
						 	/obj/item/rogueore/selitre)
	created_item = /obj/item/tntstick
	hammers_per_item = 5
	skill_level = 4

/datum/artificer_recipe/general/satchelbomb
	name = "Gun powder satchel"
	required_item = /obj/item/storage/backpack/rogue/satchel
	additional_items = list(/obj/item/tntstick,
							/obj/item/tntstick,
							/obj/item/tntstick)
	created_item = /obj/item/satchel_bomb
	hammers_per_item = 5
	skill_level = 5

/datum/artificer_recipe/general/impactexplosive
	name = "Explosive Grenade"
	required_item = /obj/item/ingot/copper
	additional_items = list(/obj/item/paper/scroll,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/sulfur,
						 	/obj/item/rogueore/selitre)
	created_item = /obj/item/impact_grenade/explosion
	hammers_per_item = 5
	skill_level = 4

/datum/artificer_recipe/general/impactsmoke
	name = "Smoke Grenade"
	required_item = /obj/item/ingot/copper
	additional_items = list(/obj/item/paper/scroll,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/sulfur,
						 	/obj/item/rogueore/selitre)
	created_item = /obj/item/impact_grenade/smoke
	hammers_per_item = 5
	skill_level = 4

/datum/artificer_recipe/general/impactpoisonsmoke
	name = "Poison Smoke Grenade"
	required_item = /obj/item/ingot/copper
	additional_items = list(/obj/item/paper/scroll,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/sulfur,
						 	/obj/item/rogueore/selitre,
						 	/obj/item/reagent_containers/powder/alch/berryp = 3)
	created_item = /obj/item/impact_grenade/smoke/poison_gas
	hammers_per_item = 5
	skill_level = 4

/* // To do- Find something that will work as an ingredient without being a reagent for healing
/datum/artificer_recipe/general/impacthealingsmoke
	name = "Healing Smoke Grenade"
	required_item = /obj/item/ingot/copper
	additional_items = list(/obj/item/paper/scroll = 1,
							/obj/item/rogueore/coaldust = 3,
							/obj/item/rogueore/sulfur = 1,
						 	/obj/item/rogueore/selitre = 1)
	created_item = /obj/item/impact_grenade/smoke
	hammers_per_item = 5
	skill_level = 4
*/

/datum/artificer_recipe/general/impactfiresmoke
	name = "Conflagaration Smoke Grenade"
	required_item = /obj/item/ingot/copper
	additional_items = list(/obj/item/paper/scroll,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/sulfur,
						 	/obj/item/rogueore/selitre,
						 	/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius)
	created_item = /obj/item/impact_grenade/smoke/fire_gas
	hammers_per_item = 5
	skill_level = 4


/datum/artificer_recipe/general/impactblindingsmoke
	name = "Blinding Smoke Grenade"
	required_item = /obj/item/ingot/copper
	additional_items = list(/obj/item/paper/scroll,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/coaldust,
							/obj/item/rogueore/sulfur,
						 	/obj/item/rogueore/selitre,
						 	/obj/item/ash,
						 	/obj/item/ash,
						 	/obj/item/ash)
	created_item = /obj/item/impact_grenade/smoke/blind_gas
	hammers_per_item = 5
	skill_level = 4

