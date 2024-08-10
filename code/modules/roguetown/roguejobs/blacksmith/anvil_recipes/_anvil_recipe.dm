/datum/anvil_recipe
	var/name
	var/list/additional_items = list()
	var/material_quality = 0 // accumulated per added ingot (decided by quality of smelting per ingot)
	var/num_of_materials = 1 // why are additional_items and req_bar 2 different things?! THE SLOP!
	var/skill_quality = 0 // accumulated per hit, variant on the skill of the smith.
	var/appro_skill = /datum/skill/craft/blacksmithing
	var/req_bar
	var/created_item
	var/craftdiff = 0
	var/needed_item
	var/needed_item_text
	var/quality_mod = 0
	var/progress
	var/i_type

	var/datum/parent

/datum/anvil_recipe/New(datum/P, ...)
	parent = P
	. = ..()

/datum/anvil_recipe/proc/advance(mob/user, breakthrough = FALSE)
	if(progress == 100)
		to_chat(user, span_info("It's ready."))
		user.visible_message(span_warning("[user] strikes the bar!"))
		return FALSE
	if(needed_item)
		to_chat(user, span_info("Now it's time to add a [needed_item_text]."))
		user.visible_message(span_warning("[user] strikes the bar!"))
		return FALSE
	var/moveup = 1
	var/proab = 3
	var/skill_level
	if(user.mind)
		skill_level = user.mind.get_skill_level(appro_skill)
		moveup += round((skill_level * 6) * (breakthrough == 1 ? 1.5 : 1))
		moveup -= 3 * craftdiff
		if(!user.mind.get_skill_level(appro_skill))
			proab = 23
	if(prob(proab))
		moveup = 0
	progress = min(progress + moveup, 100)
	if(progress == 100 && additional_items.len)
		needed_item = pick(additional_items)
		var/obj/item/I = new needed_item()
		needed_item_text = I.name
		qdel(I)
		additional_items -= needed_item
		progress = 0
	if(!moveup)
		user.visible_message(span_warning("[user] fumbles with the bar!"))
		return FALSE
	else
		if(user.mind && isliving(user))
			skill_quality += (rand(skill_level*8, skill_level*17)*moveup)
			var/mob/living/L = user
			var/boon = user.mind.get_learning_boon(appro_skill)
			var/amt2raise = L.STAINT/2 // (L.STAINT+L.STASTR)/4 optional: add another stat that isn't int
			//i feel like leveling up takes forever regardless, this would just make it faster
			if(amt2raise > 0)
				user.mind.adjust_experience(appro_skill, amt2raise * boon, FALSE)
		if(breakthrough)
			user.visible_message(span_warning("[user] strikes the bar!"))
		else
			user.visible_message(span_info("[user] strikes the bar!"))
			var/obj/item/rogueweapon/heldstuff = user.get_active_held_item()
			if(istype(heldstuff, /obj/item/rogueweapon/hammer/stone))
				heldstuff.obj_integrity -= 1
				if(heldstuff.obj_integrity <= 0)
					heldstuff.obj_destruction()
		return TRUE

/datum/anvil_recipe/proc/item_added(mob/user)
	needed_item = null
	user.visible_message(span_info("[user] adds [needed_item_text]"))
	needed_item_text = null

/datum/anvil_recipe/proc/handle_creation(obj/item/I)
	material_quality = floor(material_quality/num_of_materials)-2
	skill_quality = floor((skill_quality/num_of_materials)/1500)+material_quality
	var/modifier
	switch(skill_quality)
		if(BLACKSMITH_LEVEL_MIN to BLACKSMITH_LEVEL_SPOIL)
			I.name = "spoilt [I.name]"
			modifier = 0.3
		if(BLACKSMITH_LEVEL_AWFUL)
			I.name = "awful [I.name]"
			modifier = 0.5
		if(BLACKSMITH_LEVEL_CRUDE)
			I.name = "crude [I.name]"
			modifier = 0.8
		if(BLACKSMITH_LEVEL_ROUGH)
			I.name = "rough [I.name]"
			modifier = 0.9
		if(BLACKSMITH_LEVEL_COMPETENT)
			I.desc = "[I.desc] It is competently made."
/*		- We disabled this due to 1.3 fucking modifier on all swords/armor is fucking broken. 130% durability or bonus damage atop strength - abysmal dogshit.
		if(BLACKSMITH_LEVEL_FINE)
			I.name = "fine [I.name]"
			modifier = 1.1
		if(BLACKSMITH_LEVEL_FLAWLESS)
			I.name = "flawless [I.name]"
			modifier = 1.2
		if(BLACKSMITH_LEVEL_LEGENDARY to BLACKSMITH_LEVEL_MAX)
			I.name = "legendary [I.name]"
			modifier = 1.3
*/
	if(!modifier)
		return
	I.obj_integrity *= modifier
	I.max_integrity  *= modifier
	I.sellprice *= modifier
	if(istype(I, /obj/item/rogueweapon))
		var/obj/item/rogueweapon/W = I
		W.force *= modifier
		W.throwforce *= modifier
		W.block_chance *= modifier
		W.armor_penetration *= modifier
		W.wdefense *= modifier
	if(istype(I, /obj/item/clothing))
		var/obj/item/clothing/C = I
		C.damage_deflection *= modifier
		C.integrity_failure /= modifier
		C.armor = C.armor.multiplymodifyAllRatings(modifier)
		C.equip_delay_self *= modifier
