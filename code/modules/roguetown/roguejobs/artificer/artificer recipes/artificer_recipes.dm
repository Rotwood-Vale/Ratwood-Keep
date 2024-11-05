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
		hammers_per_plank -= 1
		user.visible_message(span_warning("[user] nails the plank."))
		return
	if(needed_item && hammered)
		to_chat(user, span_info("Now it's time to add \a [initial(needed_item.name)]."))
		return FALSE
	if(additional_items.len && hammered)
		needed_item = pick(additional_items)
		additional_items -= needed_item
		return TRUE

/datum/artificer_recipe/proc/item_added(mob/user)
	user.visible_message(span_info("[user] adds [initial(needed_item.name)]."))
	needed_item = null

/datum/artificer_recipe/proc/plank_add(mob/user)
	user.visible_message(span_info("[user] adds a plank."))
	playsound(src, 'sound/misc/wood_saw.ogg', 100, TRUE)
	if(extra_planks_needed > 0)
		extra_planks_needed -= 1
		hammers_per_plank = initial(hammers_per_plank)
		hammered = FALSE

/datum/artificer_recipe/wood
	i_type = "General"
	appro_skill = /datum/skill/craft/engineering
	required_item = /obj/item/grown/log/tree/small/plank
	craftdiff = 1
	
// --------- WEAPON -----------

/datum/artificer_recipe/wood/weapons
	i_type = "Weapons"

/datum/artificer_recipe/wood/weapons/bow
	name = "Bow Frame"
	created_item = /obj/item/grown/log/tree/bowpartial
	extra_planks_needed = 1
	hammers_per_plank = 3

/datum/artificer_recipe/wood/weapons/staff
	name = "Wooden Staff"
	created_item = /obj/item/rogueweapon/woodstaff
	extra_planks_needed = 2
	hammers_per_plank = 2

/datum/artificer_recipe/wood/weapons/wsword
	name = "Wooden Sword"
	created_item = /obj/item/rogueweapon/mace/wsword
	extra_planks_needed = 1
	hammers_per_plank = 3

/datum/artificer_recipe/wood/weapons/wshield
	name = "Wooden Shield"
	created_item = /obj/item/rogueweapon/shield/wood/crafted
	extra_planks_needed = 3
	hammers_per_plank = 5
	craftdiff = 2

/obj/item/rogueweapon/shield/wood/crafted
	sellprice = 6

/datum/artificer_recipe/wood/weapons/hshield
	name = "Heater Shield"
	created_item = /obj/item/rogueweapon/shield/heater/crafted
	additional_items = list(/obj/item/natural/hide = 1)
	extra_planks_needed = 3
	hammers_per_plank = 2
	craftdiff = 3

/obj/item/rogueweapon/shield/heater/crafted
	sellprice = 6

// --------- TOOLS -----------

/datum/artificer_recipe/wood/tools
	i_type = "Tools"

/datum/artificer_recipe/wood/tools/mallet
	name = "Wooden Mallet"
	created_item = /obj/item/rogueweapon/hammer/wood
	extra_planks_needed = 0
	hammers_per_plank = 8

// --------- PROSTHETICS -----------

/datum/artificer_recipe/wood/prosthetics
	i_type = "Prosthetics"
	extra_planks_needed = 2
	hammers_per_plank = 2
	craftdiff = 2
	additional_items = list(/obj/item/roguegear = 1)

/datum/artificer_recipe/wood/prosthetics/arm_left
	name = "Left Wooden Arm (+1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/wood

/datum/artificer_recipe/wood/prosthetics/arm_right
	name = "Right Wooden Arm (+1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/wood


/datum/artificer_recipe/wood/prosthetics/leg_left
	name = "Left Wooden Leg (+1 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/wood


/datum/artificer_recipe/wood/prosthetics/leg_right
	name = "Right Wooden Leg (+1 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/wood

// --------- WEAPON -----------

/datum/artificer_recipe/wood/general
	i_type = "General"

/datum/artificer_recipe/wood/general/upgrade1
	name = "Upgrade Cog"
	created_item = /obj/item/cart_upgrade/level_1
	extra_planks_needed = 1
	hammers_per_plank = 5

/datum/artificer_recipe/wood/general/upgrade2
	name = "Advanced Upgrade Cog"
	created_item = /obj/item/cart_upgrade/level_2
	additional_items = list(/obj/item/grown/log/tree/small/essence = 1)
	extra_planks_needed = 1
	hammers_per_plank = 5
	craftdiff = 2
