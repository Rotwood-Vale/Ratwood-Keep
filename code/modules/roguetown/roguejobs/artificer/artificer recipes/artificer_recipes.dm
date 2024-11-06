/datum/artificer_recipe
	var/name
	var/list/additional_items = list()
	var/appro_skill = /datum/skill/craft/engineering
	var/required_item
	var/created_item
	var/craftdiff = 0
	var/obj/item/needed_item
	/// How many wood planks does this recipe need?
	var/extra_planks_needed = 0
	/// If tha current plank has been hammered all the times it needs to
	var/hammered = FALSE
	/// How many times does each plank need to be hammered? Scales with craftdiff
	var/hammers_per_plank = 0
	var/progress
	/// I_type is like "sub category"
	var/i_type

	var/datum/parent

/datum/artificer_recipe/New(datum/P, ...)
	parent = P
	hammers_per_plank = (hammers_per_plank * craftdiff)
	. = ..()

/datum/artificer_recipe/proc/advance(obj/item/I, mob/user)
	if(progress == 100)
		return TRUE
	if(needed_item && hammered)
		to_chat(user, span_info("Now it's time to add \a [initial(needed_item.name)]."))
		return FALSE
	if(additional_items.len)
		needed_item = pick(additional_items)
		additional_items -= needed_item
		return TRUE
	if(hammers_per_plank == 0)
		hammered = TRUE
		if(extra_planks_needed > 0)
			to_chat(user, span_info("The construction is well nailed but requires another plank."))
			return
		else if(extra_planks_needed == 0)
			to_chat(user, span_info("The construction is well nailed!."))
			return
	if(extra_planks_needed == 0 && !needed_item)
		progress = 100
		return
	if(extra_planks_needed && !hammered && hammers_per_plank)
		switch(user.mind.get_skill_level(appro_skill))
			if(SKILL_LEVEL_NONE to SKILL_LEVEL_NOVICE)
				hammers_per_plank = max(0, hammers_per_plank - 0.5)
			if(SKILL_LEVEL_APPRENTICE to SKILL_LEVEL_JOURNEYMAN)
				hammers_per_plank = max(0, hammers_per_plank - 1)
			if(SKILL_LEVEL_EXPERT to SKILL_LEVEL_MASTER)
				hammers_per_plank = max(0, hammers_per_plank - 2)
			if(SKILL_LEVEL_LEGENDARY to INFINITY)
				hammers_per_plank = max(0, hammers_per_plank - 3)
		user.visible_message(span_warning("[user] nails the plank."))
		return

/datum/artificer_recipe/proc/item_added(mob/user)
	user.visible_message(span_info("[user] adds [initial(needed_item.name)]."))
	needed_item = null

/datum/artificer_recipe/proc/plank_add(mob/user)
	user.visible_message(span_info("[user] adds a plank."))
	playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
	if(extra_planks_needed > 0)
		extra_planks_needed -= 1
		hammers_per_plank = (initial(hammers_per_plank) * craftdiff)
		hammered = FALSE

// --------- GENERAL -----------

/datum/artificer_recipe/wood //This looks a bit silly but due to how these datums work is necessary for other things to inherit from it
	name = "Wooden Upgrade Cog"
	appro_skill = /datum/skill/craft/engineering
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/cart_upgrade/level_1
	extra_planks_needed = 1
	hammers_per_plank = 5
	craftdiff = 1
	i_type = "General"

/datum/artificer_recipe/wood/upgrade2
	name = "Advanced Wooden Upgrade Cog (+1 Essence of Lumber)"
	created_item = /obj/item/cart_upgrade/level_2
	additional_items = list(/obj/item/grown/log/tree/small/essence = 1)
	extra_planks_needed = 1
	hammers_per_plank = 5
	craftdiff = 2

/datum/artificer_recipe/bronze
	name = "Bronze Cog"
	appro_skill = /datum/skill/craft/engineering
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/roguegear
	extra_planks_needed = 0
	hammers_per_plank = 10
	craftdiff = 1
	i_type = "General"

/datum/artificer_recipe/bronze/locks
	name = "Lock"
	created_item = /obj/item/customlock
	hammers_per_plank = 5
	craftdiff = 1

/datum/artificer_recipe/bronze/keys
	name = "Keys 2x"
	created_item = list(/obj/item/key_custom_blank, /obj/item/key_custom_blank)
	hammers_per_plank = 5
	craftdiff = 1

// --------- TOOLS -----------

/datum/artificer_recipe/wood/tools
	name = "Wooden Mallet"
	created_item = /obj/item/rogueweapon/hammer/wood
	extra_planks_needed = 0
	hammers_per_plank = 8
	i_type = "Tools"

/datum/artificer_recipe/bronze/tools
	name = "Bronze Lamptern"
	created_item = /obj/item/ingot/bronze
	created_item = /obj/item/flashlight/flare/torch/lantern/bronzelamptern
	extra_planks_needed = 0
	hammers_per_plank = 3
	craftdiff = 3
	i_type = "Tools"
	
// --------- WEAPON -----------

/datum/artificer_recipe/wood/weapons //Again, a bit silly, but is important
	name = "Wooden Staff"
	created_item = /obj/item/rogueweapon/woodstaff
	extra_planks_needed = 2
	hammers_per_plank = 2
	i_type = "Weapons"

/datum/artificer_recipe/wood/weapons/bow // easier recipe for bows
	name = "Wooden Bow (+1 Fiber)"
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	extra_planks_needed = 1
	hammers_per_plank = 3
	additional_items = list(/obj/item/natural/fibers = 1)

/datum/artificer_recipe/wood/weapons/wsword
	name = "Wooden Sword"
	created_item = /obj/item/rogueweapon/mace/wsword
	extra_planks_needed = 1
	hammers_per_plank = 3

/datum/artificer_recipe/wood/weapons/wshield
	name = "Wooden Shield"
	created_item = /obj/item/rogueweapon/shield/wood/crafted
	extra_planks_needed = 2
	hammers_per_plank = 3
	craftdiff = 2

/obj/item/rogueweapon/shield/wood/crafted
	sellprice = 6

/datum/artificer_recipe/wood/weapons/hshield
	name = "Heater Shield (+1 Hide)"
	created_item = /obj/item/rogueweapon/shield/heater/crafted
	additional_items = list(/obj/item/natural/hide = 1)
	extra_planks_needed = 2
	hammers_per_plank = 2
	craftdiff = 3

/obj/item/rogueweapon/shield/heater/crafted
	sellprice = 6

// --------- PROSTHETICS -----------

/datum/artificer_recipe/wood/prosthetics
	name = "Left Wooden Arm (+1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/wood
	i_type = "Prosthetics"
	extra_planks_needed = 2
	hammers_per_plank = 2
	craftdiff = 2
	additional_items = list(/obj/item/roguegear = 1)

/datum/artificer_recipe/wood/prosthetics/arm_right
	name = "Right Wooden Arm (+1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/wood

/datum/artificer_recipe/wood/prosthetics/leg_left
	name = "Left Wooden Leg (+1 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/wood

/datum/artificer_recipe/wood/prosthetics/leg_right
	name = "Right Wooden Leg (+1 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/wood

// --------- BRONZE -----------

/datum/artificer_recipe/bronze/prosthetic
	name = "Bronze Left Arm (+1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/bronze
	hammers_per_plank = 5
	craftdiff = 4
	additional_items = list(/obj/item/roguegear = 1)
	i_type = "Prosthetics"

/datum/artificer_recipe/bronze/prosthetic/arm_right
	name = "Bronze Right Arm (+1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/bronze

// --------- GOLD -----------

/datum/artificer_recipe/gold/prosthetic // Guh this need a gold subtype oh well maybe some day there will be a golden cock! COG I MEAN GOD OMG
	name = "Gold Left Arm (+2 Cog)"
	appro_skill = /datum/skill/craft/engineering
	required_item = /obj/item/ingot/gold
	created_item = /obj/item/bodypart/l_arm/prosthetic/gold
	additional_items = list(/obj/item/roguegear = 2)
	extra_planks_needed = 0
	hammers_per_plank = 5
	craftdiff = 5
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
	appro_skill = /datum/skill/craft/engineering
	required_item = /obj/item/ingot/steel
	created_item = /obj/item/bodypart/l_arm/prosthetic/steel
	additional_items = list(/obj/item/ingot/steel = 1, /obj/item/roguegear = 1)
	extra_planks_needed = 0
	hammers_per_plank = 5
	craftdiff = 4
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

// --------- IRON -----------

datum/artificer_recipe/iron/prosthetic //These are the inexpensive alternatives
	name = "Iron Left Arm (+1 Wooden Cog)"
	appro_skill = /datum/skill/craft/engineering
	required_item = /obj/item/ingot/iron
	created_item = /obj/item/bodypart/l_arm/prosthetic/iron
	additional_items = list(/obj/item/cart_upgrade/level_1 = 1)
	extra_planks_needed = 1
	hammers_per_plank = 2
	craftdiff = 2
	i_type = "Prosthetics"

/datum/artificer_recipe/iron/prosthetic/arm_right
	name = "Iron Right Arm (+1 Wooden Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/iron

/datum/artificer_recipe/iron/prosthetic/leg_left
	name = "Iron Left Leg (+1 Wooden Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/iron

/datum/artificer_recipe/iron/prosthetic/leg_right
	name = "Iron Right Leg (+1 Wooden Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/iron
