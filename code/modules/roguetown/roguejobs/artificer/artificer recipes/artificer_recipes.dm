/datum/artificer_recipe
	var/name
	var/list/additional_items = list()
	var/appro_skill = /datum/skill/craft/engineering
	var/required_item
	var/created_item
	/// Craft Difficulty here only matters for exp calculation and locking recipes based on skill level
	var/craftdiff = 0
	var/obj/item/needed_item
	/// If tha current item has been hammered all the times it needs to
	var/hammered = FALSE
	/// How many times does this need to be hammered?
	var/hammers_per_item = 0
	var/progress
	/// I_type is like "sub category"
	var/i_type

	var/datum/parent

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

/datum/artificer_recipe/wood //This looks a bit silly but due to how these datums work is necessary for other things to inherit from it
	name = "Wooden Upgrade Cog"
	appro_skill = /datum/skill/craft/engineering
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/cart_upgrade/level_1
	additional_items = list(/obj/item/natural/wood/plank = 1)
	hammers_per_item = 5
	craftdiff = 1
	i_type = "General"

/datum/artificer_recipe/wood/upgrade2
	name = "Advanced Wooden Upgrade Cog (+1 Essence of Lumber)"
	created_item = /obj/item/cart_upgrade/level_2
	additional_items = list(/obj/item/natural/wood/plank = 1, /obj/item/grown/log/tree/small/essence = 1)
	hammers_per_item = 10
	craftdiff = 2

/datum/artificer_recipe/bronze
	name = "Bronze Cog"
	appro_skill = /datum/skill/craft/engineering
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/roguegear
	hammers_per_item = 10
	craftdiff = 1
	i_type = "General"

/datum/artificer_recipe/bronze/locks
	name = "Lock"
	created_item = /obj/item/customlock
	hammers_per_item = 5
	craftdiff = 1

/datum/artificer_recipe/bronze/keys
	name = "Keys 2x"
	created_item = list(/obj/item/key_custom_blank, /obj/item/key_custom_blank)
	hammers_per_item = 5
	craftdiff = 1

// --------- TOOLS -----------

/datum/artificer_recipe/wood/tools
	name = "Wooden Mallet"
	created_item = /obj/item/rogueweapon/hammer/wood
	hammers_per_item = 8
	i_type = "Tools"

/datum/artificer_recipe/bronze/tools
	name = "Bronze Lamptern"
	created_item = /obj/item/ingot/bronze
	created_item = /obj/item/flashlight/flare/torch/lantern/bronzelamptern
	hammers_per_item = 9
	craftdiff = 3
	i_type = "Tools"
	
// --------- WEAPON -----------

/datum/artificer_recipe/wood/weapons //Again, a bit silly, but is important
	name = "Wooden Staff"
	created_item = /obj/item/rogueweapon/woodstaff
	additional_items = list(/obj/item/natural/wood/plank = 2)
	hammers_per_item = 3
	i_type = "Weapons"

/datum/artificer_recipe/wood/weapons/bow // easier recipe for bows
	name = "Wooden Bow (+1 Fiber)"
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	hammers_per_item = 3
	additional_items = list(/obj/item/natural/wood/plank = 1, /obj/item/natural/fibers = 1)

/datum/artificer_recipe/wood/weapons/wsword
	name = "Wooden Sword"
	created_item = /obj/item/rogueweapon/mace/wsword
	additional_items = list(/obj/item/natural/wood/plank = 1)
	hammers_per_item = 3

/datum/artificer_recipe/wood/weapons/wshield
	name = "Wooden Shield"
	created_item = /obj/item/rogueweapon/shield/wood/crafted
	additional_items = list(/obj/item/natural/wood/plank = 2)
	hammers_per_item = 6
	craftdiff = 2

/obj/item/rogueweapon/shield/wood/crafted
	sellprice = 6

/datum/artificer_recipe/wood/weapons/hshield
	name = "Heater Shield (+1 Hide)"
	created_item = /obj/item/rogueweapon/shield/heater/crafted
	additional_items = list(/obj/item/natural/wood/plank = 2, /obj/item/natural/hide = 1)
	hammers_per_item = 6
	craftdiff = 3

/obj/item/rogueweapon/shield/heater/crafted
	sellprice = 6

// --------- PROSTHETICS -----------

/datum/artificer_recipe/wood/prosthetics
	name = "Left Wooden Arm (+1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/wood
	additional_items = list(/obj/item/natural/wood/plank = 2, /obj/item/roguegear = 1)
	i_type = "Prosthetics"
	hammers_per_item = 4
	craftdiff = 2

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
	hammers_per_item = 15
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
	hammers_per_item = 20
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
	created_item = /obj/item/bodypart/l_arm/prosthetic/steel
	required_item = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel = 1, /obj/item/roguegear = 1)
	hammers_per_item = 15
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

/datum/artificer_recipe/iron/prosthetic //These are the inexpensive alternatives
	name = "Iron Left Arm (+1 Wooden Cog)"
	appro_skill = /datum/skill/craft/engineering
	created_item = /obj/item/bodypart/l_arm/prosthetic/iron
	required_item = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/wood/plank = 1, /obj/item/cart_upgrade/level_1 = 1)
	hammers_per_item = 4
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

/obj/item/contraption
	name = "random piece of machinery"
	desc = "A cog with teeth meticulously crafted for tight interlocking."
	icon_state = "gear"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = /obj/item/ingot/bronze
	slot_flags = ITEM_SLOT_HIP
	var/obj/item/accepted_power_source = /obj/item/roguegear
	var/obj/item/current_source
	/// This is the amount of charges we get per power source
	var/charge_per_source = 5
	var/current_charge = 0
	var/missfire_chance

/obj/item/contraption/examine(mob/user)
	. = ..()
	if(!istype(user, /mob/living))
		return
	var/mob/living/player = user
	var/skill = player.mind.get_skill_level(/datum/skill/craft/engineering)
	if(current_source)
		. += span_warning("The contraption has [current_charge] charges left.")
	if(!current_source)
		. += span_warning("This contraption requires a new [initial(accepted_power_source.name)] to function.")
	if(missfire_chance)
		if(skill > 2)
			. += span_warning("You calculate this contraptions chance of failure to be anywhere between [max(0, (missfire_chance - skill) - rand(4))]% and [max(2, (missfire_chance - skill) + rand(3))]%.")
		else
			. += span_warning("It seems slightly unstable...")

/obj/item/contraption/proc/battery_collapse(obj/O, mob/living/user)
	sleep(5)
	to_chat(user, span_info("The [current_source.name] wastes away into nothing."))
	playsound(src, pick('sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg'), 100, FALSE)
	shake_camera(user, 1, 1)
	var/datum/effect_system/spark_spread/S = new()
	var/turf/front = get_turf(src)
	S.set_up(1, 1, front)
	S.start()
	qdel(current_source)
	current_source = null
	return

/obj/item/contraption/proc/misfire(obj/O, mob/living/user)
	var/skill = user.mind.get_skill_level(/datum/skill/craft/engineering)
	if(prob(max(0, missfire_chance - user.goodluck(2) - skill)))
		to_chat(user, span_info("Oh fuck."))
		sleep(rand(5, 30))
		explosion(src, light_impact_range = 3, flame_range = 1, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
		qdel(src)

/obj/item/contraption/attackby(obj/item/I, mob/user, params)
	if(istype(I, accepted_power_source))
		if(current_source)
			to_chat(user, span_info("I try to insert the [I.name] but theres already \a [initial(accepted_power_source.name)] inside!"))
			playsound(src, 'sound/combat/hits/blunt/woodblunt (2).ogg', 100, TRUE)
			shake_camera(user, 1, 1)
		else
			to_chat(user, span_info("I insert the [I.name] and the [name] starts ticking."))
			current_charge = charge_per_source
			I.forceMove(src)
			current_source = I
			playsound(src, 'sound/combat/hits/blunt/woodblunt (2).ogg', 100, TRUE)
			qdel(I)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(src)
		S.set_up(1, 1, front)
		S.start()
	..()

/obj/item/contraption/attack_obj(obj/O, mob/living/user)
	if(!current_source)
		to_chat(user, span_info("The contraption beeps! It requires \a [initial(accepted_power_source.name)]!"))
		playsound(src, 'sound/magic/magic_nulled.ogg', 100, TRUE)
		return

/obj/item/contraption/wood_metalizer
	name = "wood metalizer"
	desc = "A creation of genious or insanity. This cursed contraption is somehow able to turn wood into metal."
	icon_state = "scomstone"
	w_class = WEIGHT_CLASS_BULKY
	smeltresult = /obj/item/ingot/bronze
	missfire_chance = 15
	charge_per_source = 5

/obj
	/// This is the result when the wood metalizer artifact is used on this item
	var/metalizer_result
	/// The smelting result, used by the smelter or by the portable smelter
	var/smeltresult

/obj/item/contraption/wood_metalizer/attack_obj(obj/O, mob/living/user)
	..()
	if(!current_source)
		return
	if(!current_charge)
		battery_collapse(O, user)
		return
	if(!O.metalizer_result)
		to_chat(user, span_info("The [name] refuses to function."))
		playsound(user, 'sound/items/flint.ogg', 100, FALSE)
		flick("scomstone2", src)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(O)
		S.set_up(1, 1, front)
		S.start()
		return
	else
		new O.metalizer_result(get_turf(O))
		flick("scomstone1", src)
		current_charge -= 1
		shake_camera(user, 1, 1)
		playsound(src, 'sound/magic/swap.ogg', 100, TRUE)
		qdel(O)
		user.mind.add_sleep_experience(/datum/skill/craft/engineering, (user.STAINT / 2))
		if(missfire_chance)
			misfire(O, user)
		if(!current_charge)
			battery_collapse(O, user)
		return

/obj/item/contraption/smelter
	name = "portable smelter"
	desc = "Furnaces are a thing of the past. The future is here!"
	icon_state = "scomstone"
	w_class = WEIGHT_CLASS_BULKY
	smeltresult = /obj/item/ingot/bronze
	missfire_chance = 10
	charge_per_source = 6

/obj/item/contraption/smelter/attack_obj(obj/O, mob/living/user)
	..()
	if(!current_source)
		return
	if(!current_charge)
		battery_collapse(O, user)
	if(!O.smeltresult)
		to_chat(user, span_info("The [name] refuses to function."))
		playsound(user, 'sound/items/flint.ogg', 100, FALSE)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(O)
		S.set_up(1, 1, front)
		S.start()
		return
	else
		var/obj/to_spawn = O.smeltresult
		var/turf/turf = get_turf(O)
		current_charge -= 1
		playsound(O, 'sound/items/firesnuff.ogg', 100)
		new /obj/effect/decal/cleanable/ash(turf)
		qdel(O)
		if(missfire_chance)
			misfire(O, user)
		if(!current_charge)
			battery_collapse(O, user)
		sleep(20)
		new to_spawn(turf)
		playsound(turf, pick('sound/combat/hits/onmetal/sheet (1).ogg', 'sound/combat/hits/onmetal/sheet (2).ogg'), 100, TRUE)
		user.mind.add_sleep_experience(/datum/skill/craft/engineering, (user.STAINT / 3))
		return
