/obj/item/contraption
	name = "random piece of machinery"
	desc = "A cog with teeth meticulously crafted for tight interlocking."
	icon_state = "gear"
	var/on_icon
	var/off_icon
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = /obj/item/ingot/bronze
	slot_flags = ITEM_SLOT_HIP
	var/obj/item/accepted_power_source = /obj/item/roguegear/bronze
	/// This is the amount of charges we get per power source
	var/charge_per_source = 5
	var/current_charge = 0
	var/misfire_chance
	var/sneaky_misfire_chance
	/// Are we misfiring? Important for chain reactions.
	var/misfiring = FALSE
	obj_flags_ignore = TRUE
	/// If this contraption should accept cogs that alter its behaviour
	var/cog_accept = TRUE

/obj/item/contraption/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,
"sx" = -6,
"sy" = -2,
"nx" = 9,
"ny" = -1,
"wx" = -6,
"wy" = -1,
"ex" = -2,
"ey" = -3,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 21,
"sturn" = -18,
"wturn" = -18,
"eturn" = 21,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/contraption/examine(mob/user)
	. = ..()
	if(!istype(user, /mob/living))
		return
	var/mob/living/player = user
	var/skill = player.mind.get_skill_level(/datum/skill/craft/engineering)
	if(current_charge)
		. += span_warning("The contraption has [current_charge] charges left.")
	if(!current_charge)
		. += span_warning("This contraption requires a new [initial(accepted_power_source.name)] to function.")
	if(misfire_chance && skill < 6)
		if(skill > 2)
			. += span_warning("You calculate this contraptions chance of failure to be anywhere between [max(0, (misfire_chance - skill) - rand(4))]% and [max(2, (misfire_chance - skill) + rand(3))]%.")
		else
			. += span_warning("It seems slightly unstable...")
	if(skill >= 6 && sneaky_misfire_chance)
		. += span_warning("This contraption has a chance for catastrophic failure in the hands of the inexperient.")

/obj/item/contraption/proc/battery_collapse(obj/O, mob/living/user)
	to_chat(user, span_info("The [accepted_power_source.name] wastes away into nothing."))
	playsound(src, pick('sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg'), 100, FALSE)
	shake_camera(user, 1, 1)
	var/datum/effect_system/spark_spread/S = new()
	var/turf/front = get_turf(src)
	S.set_up(1, 1, front)
	S.start()
	return

/obj/item/contraption/proc/misfire(obj/O, mob/living/user)
	user.mind.add_sleep_experience(/datum/skill/craft/engineering, (user.STAINT * 5))
	to_chat(user, span_info("Oh fuck."))
	playsound(src, 'sound/misc/bell.ogg', 100)
	addtimer(CALLBACK(src, PROC_REF(misfire_result), O, user), rand(5, 30))

/obj/item/contraption/proc/misfire_result(obj/O, mob/living/user)
	misfiring = TRUE
	explosion(src, light_impact_range = 3, flame_range = 1, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	qdel(src)

/obj/item/contraption/proc/charge_deduction(obj/O, mob/living/user, deduction)
	current_charge -= deduction
	if(!current_charge)
		addtimer(CALLBACK(src, PROC_REF(battery_collapse), O, user), 5)

/obj/item/contraption/attackby(obj/item/I, mob/user, params)
	var/datum/effect_system/spark_spread/S = new()
	var/turf/front = get_turf(src)
	if(istype(I, /obj/item/roguegear/wood) && cog_accept)
		var/obj/item/roguegear/wood/cog = I
		if(cog.misfire_modification || cog.misfire_modification == 0)
			misfire_chance = cog.misfire_modification
		if(cog.name_prefix)
			name = "[cog.name_prefix] [initial(name)]"
		else if(!cog.name_prefix)
			name = initial(name)
		qdel(cog)
		playsound(src, pick('sound/combat/hits/onwood/fence_hit1.ogg', 'sound/combat/hits/onwood/fence_hit2.ogg', 'sound/combat/hits/onwood/fence_hit3.ogg'), 100, FALSE)
		shake_camera(user, 1, 1)
		S.set_up(1, 1, front)
		S.start()
		to_chat(user, "<span class='warning'>[cog.name] inserted!</span>")
	if(istype(I, accepted_power_source))
		user.changeNext_move(CLICK_CD_FAST)
		S.set_up(1, 1, front)
		S.start()
		if(current_charge)
			to_chat(user, span_info("I try to insert the [I.name] but theres already \a [initial(accepted_power_source.name)] inside!"))
			playsound(src, 'sound/combat/hits/blunt/woodblunt (2).ogg', 100, TRUE)
			shake_camera(user, 1, 1)
		else
			to_chat(user, span_info("I insert the [I.name] and the [name] starts ticking."))
			current_charge = charge_per_source
			playsound(src, 'sound/combat/hits/blunt/woodblunt (2).ogg', 100, TRUE)
			qdel(I)
			addtimer(CALLBACK(src, PROC_REF(play_clock_sound)), 5)
	if(istype(I, /obj/item/rogueweapon/hammer))
		hammer_action(I, user)
	..()

/obj/item/contraption/proc/hammer_action(obj/item/I, mob/user)
	user.changeNext_move(CLICK_CD_FAST)
	flick(off_icon, src)
	user.visible_message(span_info("[user] beats the [name] into submission!"))
	playsound(src, pick('sound/combat/hits/onmetal/sheet (1).ogg', 'sound/combat/hits/onmetal/sheet (2).ogg', 'sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg'), 100, TRUE)
	shake_camera(user, 1, 1)
	var/datum/effect_system/spark_spread/S = new()
	var/turf/front = get_turf(I)
	S.set_up(1, 1, front)
	S.start()
	var/probability = rand(1, 100)
	if(!current_charge)
		misfire(I, user)
		return
	if(probability <= 5)
		misfire(I, user)
	else if(probability <= 40)
		if(current_charge < charge_per_source)
			current_charge += 1
		misfire_chance = rand(1, 30)
	else
		misfire_chance = rand(10, 100)

/obj/item/contraption/proc/play_clock_sound()
	playsound(src, 'sound/misc/clockloop.ogg', 25, TRUE)

/obj/item/contraption/attack_obj(obj/O, mob/living/user)
	if(!current_charge)
		flick(off_icon, src)
		to_chat(user, span_info("The contraption beeps! It requires \a [initial(accepted_power_source.name)]!"))
		playsound(src, 'sound/magic/magic_nulled.ogg', 100, TRUE)
		return

/obj/item/contraption/wood_metalizer
	name = "wood metalizer"
	desc = "A creation of genious or insanity. This cursed contraption is somehow able to turn wood into metal."
	icon_state = "metalizer"
	on_icon = "metalizer_flick"
	off_icon = "metalizer_off"
	w_class = WEIGHT_CLASS_BULKY
	misfire_chance = 15
	charge_per_source = 5

/obj
	/// This is the result when the wood metalizer artifact is used on this item
	var/metalizer_result
	/// The smelting result, used by the smelter or by the portable smelter
	var/smeltresult
	/// The lock ID, used with keys, if a key has the same lock ID it will work on this lock
	var/lockid
	/// Lockhash goes hand in hand with lock ID. Horrible system. Still very necessary.
	var/lockhash
	/// Is this locked?
	var/locked

/obj/item/contraption/wood_metalizer/attack_obj(obj/O, mob/living/user)
	..()
	if(!current_charge)
		return
	if(!O.metalizer_result)
		to_chat(user, span_info("The [name] refuses to function."))
		playsound(user, 'sound/items/flint.ogg', 100, FALSE)
		flick(off_icon, src)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(O)
		S.set_up(1, 1, front)
		S.start()
		return
	var/skill = user.mind.get_skill_level(/datum/skill/craft/engineering)
	if(istype(O, /obj/structure/mineral_door/wood)) //This is to ensure the new door will retain its lock
		var/obj/structure/mineral_door/wood/I = O
		var/obj/structure/mineral_door/wood/new_door = new I.metalizer_result(get_turf(I))
		new_door.locked = I.locked
		if(I.lockid)
			new_door.lockid = I.lockid
		qdel(I)
	else
		var/newdir = O.dir
		var/obj/I = O
		var/obj/result = new I.metalizer_result(get_turf(I))
		result.dir = newdir
		qdel(I)
	flick(on_icon, src)
	charge_deduction(O, user, 1)
	shake_camera(user, 1, 1)
	playsound(src, 'sound/magic/swap.ogg', 100, TRUE)
	user.mind.add_sleep_experience(/datum/skill/craft/engineering, (user.STAINT / 2))
	if(misfire_chance && prob(max(0, misfire_chance - user.goodluck(2) - skill)))
		misfire(O, user)
	return

/obj/item/contraption/wood_metalizer/misfire_result()
	misfiring = TRUE
	for(var/obj/object in oview(3, src))
		if(object.metalizer_result)  // Check if the object is within the flame range
			new object.metalizer_result(get_turf(object))
			playsound(object, 'sound/magic/swap.ogg', 100, TRUE)
			qdel(object)
	explosion(src, light_impact_range = 3, flame_range = 1, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	qdel(src)

/obj/item/contraption/smelter
	name = "portable smelter"
	desc = "Furnaces are a thing of the past. The future is here!"
	icon_state = "smelter"
	on_icon = "smelter_flick"
	off_icon = "smelter_off"
	w_class = WEIGHT_CLASS_BULKY
	accepted_power_source = /obj/item/rogueore/coal
	misfire_chance = 10
	charge_per_source = 6

/obj/item/contraption/smelter/misfire_result()
	misfiring = TRUE
	for(var/obj/object in oview(3, src))
		if(object.smeltresult)  // Check if the object is within the flame range
			if(istype(object, /obj/item/ingot))
				continue
			if(istype(object, /obj/item/contraption))
				var/obj/item/contraption/I = object
				if(I.misfiring)
					continue
				addtimer(CALLBACK(I, PROC_REF(misfire_result)), rand(5))
				continue
			object.popcorn_smelt()

	explosion(src, flame_range = 3, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	qdel(src)

/obj/proc/popcorn_smelt()
	var/turf/T = get_turf(src)
	moveToNullspace()
	playsound(T, pick('sound/combat/hits/burn (1).ogg','sound/combat/hits/burn (2).ogg'), 50)
	new /obj/effect/decal/cleanable/ash(T)
	addtimer(CALLBACK(src, PROC_REF(popcorn_smelt_result), T), rand(10, 40))

/obj/proc/popcorn_smelt_result(turf)
	new smeltresult(turf)
	playsound(turf, pick('sound/combat/hits/onmetal/sheet (1).ogg', 'sound/combat/hits/onmetal/sheet (2).ogg'), 100, TRUE)
	qdel(src)

/obj/item/contraption/smelter/attack_obj(obj/O, mob/living/user)
	..()
	if(!current_charge)
		return
	if(!O.smeltresult)
		to_chat(user, span_info("The [name] refuses to function."))
		playsound(user, 'sound/items/flint.ogg', 100, FALSE)
		flick(off_icon, src)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(O)
		S.set_up(1, 1, front)
		S.start()
		return
	user.mind.add_sleep_experience(/datum/skill/craft/engineering, (user.STAINT / 3))
	charge_deduction(O, user, 1)
	flick(on_icon, src)
	playsound(loc, 'sound/misc/machinevomit.ogg', 50, TRUE)
	addtimer(CALLBACK(src, PROC_REF(smelt_part2), O, user), 5)
	return

/obj/item/contraption/smelter/proc/smelt_part2(obj/O, mob/living/user)
	var/skill = user.mind.get_skill_level(/datum/skill/craft/engineering)
	var/turf/turf = get_turf(O)
	playsound(O, pick('sound/combat/hits/burn (1).ogg','sound/combat/hits/burn (2).ogg'), 100)
	new /obj/effect/decal/cleanable/ash(turf)
	O.moveToNullspace()
	if(misfire_chance && prob(max(0, misfire_chance - user.goodluck(2) - skill)))
		misfire(O, user)
	addtimer(CALLBACK(O, PROC_REF(popcorn_smelt_result), turf), 20)
	return

/obj/item/contraption/lock_imprinter
	name = "lock imprinter"
	desc = "A useful contraption that facilitates a locksmiths job on alreay instaled locks."
	icon_state = "imprinter"
	on_icon = "imprinter_flick"
	off_icon = "imprinter_off"
	w_class = WEIGHT_CLASS_BULKY
	accepted_power_source = /obj/item/customlock
	misfire_chance = 0
	sneaky_misfire_chance = 20
	charge_per_source = 2
	cog_accept = FALSE
	var/list/allowed_locks = list(/obj/structure/mineral_door, /obj/structure/closet, /obj/structure/roguemachine/steward, /obj/structure/roguemachine/vendor, /obj/structure/roguemachine/merchantvend)
	var/stored_lock_id = "artificer"
	var/stored_lock_hash = 354
	var/mode = "Examiner"

/obj/item/contraption/lock_imprinter/examine(mob/user)
	. = ..()
	if(!istype(user, /mob/living))
		return
	var/mob/living/player = user
	var/skill = player.mind.get_skill_level(/datum/skill/craft/engineering)
	if(skill >= 2)
		. += span_warning("The [name] is currently in [mode] mode.")
		if(skill >= 4)
			if(stored_lock_id)
				. += span_warning("The current stored Lock ID is [stored_lock_id].")
			else
				. += span_warning("There is no stored Lock ID.")
		else
			. += span_warning("I cannot yet fully understand this contraption.")

/obj/item/contraption/lock_imprinter/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/key))
		var/obj/item/key/the_key = I
		user.changeNext_move(CLICK_CD_FAST)
		flick(off_icon, src)
		playsound(user, 'sound/foley/doors/unlock.ogg', 100, TRUE)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(src)
		S.set_up(1, 1, front)
		S.start()
		stored_lock_id = the_key.lockid
		stored_lock_hash = the_key.lockhash
		user.visible_message(span_notice("[user] inserts \a [the_key] into the [name] and it starts ticking..."))
		addtimer(CALLBACK(src, PROC_REF(play_clock_sound)), 5)

/obj/item/contraption/lock_imprinter/attack_obj(obj/O, mob/living/user)
	..()
	if(!current_charge)
		return
	var/skill = user.mind.get_skill_level(/datum/skill/craft/engineering)
	var/valid_lock
	for(var/type in allowed_locks)
		if(istype(O, type))
			valid_lock = TRUE
			if(mode == "Examiner")
				if(O.lockid)
					to_chat(user, span_warning("The [name] identifies this lock's ID as [O.lockid]."))
				else
					to_chat(user, span_warning("The [name] identifies an absense of a lock or lock ID."))
				playsound(loc, 'sound/misc/beep.ogg', 50, TRUE)
				flick(off_icon, src)
				break
			if(mode == "Imprinter")
				O.lockid = stored_lock_id
				O.lockhash = stored_lock_hash
				flick(on_icon, src)
				shake_camera(user, 1, 1)
				user.visible_message(span_notice("[user] holds the [name] up to the [O.name] causing sparks to fly!"))
				playsound(src, pick('sound/combat/hits/onmetal/sheet (1).ogg', 'sound/combat/hits/onmetal/sheet (2).ogg', 'sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg'), 100, TRUE)
				charge_deduction(O, user, 1)
				var/datum/effect_system/spark_spread/S = new()
				var/turf/front = get_turf(O)
				S.set_up(1, 1, front)
				S.start()
				user.mind.add_sleep_experience(/datum/skill/craft/engineering, (user.STAINT)) // Only imprinting gives EXP
				message_admins("[user] has used [name] to change the lock of [O] to [stored_lock_id] hash [stored_lock_hash] in [ADMIN_VERBOSEJMP(front)]")
				log_game("[user] has used [name] to change the lock of [O] to [stored_lock_id] hash [stored_lock_hash] in [ADMIN_VERBOSEJMP(front)]")
				if(!skill && prob(sneaky_misfire_chance))
					misfire(O, user)
				break
			if(mode == "Unlocker")
				var/turf/front = get_turf(O)
				if(O.locked)
					O.locked = FALSE
					playsound(user, 'sound/foley/doors/unlock.ogg', 150, TRUE)
					playsound(user, 'sound/foley/doors/lockrattlemetal.ogg', 100, TRUE)
					message_admins("[user] has used [name] to unlock [O] in [ADMIN_VERBOSEJMP(front)]")
					log_game("[user] has used [name] to unlock [O] in [ADMIN_VERBOSEJMP(front)]")
				else
					O.locked = TRUE
					playsound(user, 'sound/foley/doors/lock.ogg', 150, TRUE)
					message_admins("[user] has used [name] to lock [O] in [ADMIN_VERBOSEJMP(front)]")
					log_game("[user] has used [name] to lock [O] in [ADMIN_VERBOSEJMP(front)]")
				user.visible_message(span_notice("[user] holds the [name] up to the [O.name] causing sparks to fly!"))
				var/datum/effect_system/spark_spread/S = new()
				S.set_up(1, 1, front)
				S.start()
				var/oldx = O.pixel_x
				animate(O, pixel_x = oldx+1, time = 0.5)
				animate(pixel_x = oldx-1, time = 0.5)
				animate(pixel_x = oldx, time = 0.5)
				flick(on_icon, src)
				charge_deduction(O, user, 1)
				if(!skill && prob(sneaky_misfire_chance))
					misfire(O, user)
				break
		if(!valid_lock)
			to_chat(user, span_info("The [name] refuses to function."))
			playsound(user, 'sound/items/flint.ogg', 100, FALSE)
			flick(off_icon, src)
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_turf(O)
			S.set_up(1, 1, front)
			S.start()

/obj/item/contraption/lock_imprinter/hammer_action(obj/item/I, mob/user)
	user.changeNext_move(CLICK_CD_FAST)
	flick(off_icon, src)
	user.visible_message(span_info("[user] beats the [name] into submission!"))
	playsound(src, pick('sound/combat/hits/onmetal/sheet (1).ogg', 'sound/combat/hits/onmetal/sheet (2).ogg', 'sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg'), 100, TRUE)
	shake_camera(user, 1, 1)
	var/datum/effect_system/spark_spread/S = new()
	var/turf/front = get_turf(I)
	S.set_up(1, 1, front)
	S.start()
	switch(mode)
		if("Examiner")
			mode = "Imprinter"
		if("Imprinter")
			mode = "Unlocker"
		if("Unlocker")
			mode = "Examiner"

/obj/item/contraption/whisper
	name = "bronze whisperer"
	desc = "Whisperers come from this strange device."
	icon_state = "whisper"
	on_icon = "whisper_flick"
	off_icon = "whisper_off"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	misfire_chance = 15
	charge_per_source = 5

/obj/item/contraption/whisper/attack_self(mob/living/user)
	..()
	if(!current_charge)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	var/input_text = input(user, "Enter your message:", "Message")
	if(input_text)
		for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text)
		for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text)
		for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines)//make the listenstone hear scomstone
			S.repeat_message(input_text)
	var/skill = user.mind.get_skill_level(/datum/skill/craft/engineering)

	flick(on_icon, src)
	charge_deduction(src, user, 1)
	shake_camera(user, 1, 1)
	playsound(src, 'sound/misc/beep.ogg', 100, TRUE)
	if(misfire_chance && prob(max(0, misfire_chance - user.goodluck(2) - skill)))
		misfire(src, user)
	return

/obj/item/contraption/whisper/misfire_result()
	misfiring = TRUE
	explosion(src, light_impact_range = 3, flame_range = 1, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	qdel(src)
