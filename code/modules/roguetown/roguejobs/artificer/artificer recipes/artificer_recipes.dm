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
	i_type = "Weapons"
	appro_skill = /datum/skill/craft/engineering
	craftdiff = 1
	
// --------- BRONZE RECIPES -----------

/datum/artificer_recipe/wood/bow
	name = "Bow Frame"
	required_item = /obj/item/grown/log/tree/small/plank
	created_item = /obj/item/grown/log/tree/bowpartial
	extra_planks_needed = 2
	hammers_per_plank = 2
	craftdiff = 1
