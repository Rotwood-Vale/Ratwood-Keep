#define STATUS_EFFECT_LEASH_PET /datum/status_effect/leash_pet
#define STATUS_EFFECT_LEASH_OWNER /datum/status_effect/leash_owner
#define STATUS_EFFECT_LEASH_FREEPET /datum/status_effect/leash_freepet
#define MOVESPEED_ID_LEASH      "LEASH"

/////STATUS EFFECTS/////
//These are mostly used as flags for the states each member can be in

/datum/status_effect/leash_owner
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/leash_owner

/atom/movable/screen/alert/status_effect/leash_owner
	name = "Leash Master"
	desc = "You've got a leash, and a cute pet on the other end."
	icon_state = "leash_master" //These call icons that don't exist, so no icon comes up. Which is good.
		//As a result, the descriptions also don't proc, which is fine.

/datum/status_effect/leash_freepet
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/leash_freepet

/atom/movable/screen/alert/status_effect/leash_freepet
	name = "Escaped Pet"
	desc = "You're on a leash, but you've no Master. If anyone grabs the leash they'll gain control!"
	icon_state = "leash_freepet"

/datum/status_effect/leash_pet
	id = "leashed"
	status_type = STATUS_EFFECT_UNIQUE
	var/mob/redirect_component
	alert_type = /atom/movable/screen/alert/status_effect/leash_pet

/atom/movable/screen/alert/status_effect/leash_pet
	name = "Leashed Pet"
	desc = "You're on the leash now! Be good for your Master now.."
	icon_state = "leash_pet"


/datum/status_effect/leash_pet/on_apply()
	redirect_component = WEAKREF(owner.AddComponent(/datum/component/redirect))
	redirect_component = owner
	if(!owner.stat)
		to_chat(owner, "<span class='userdanger'>You have been leashed!</span>")
	return ..()


///// OBJECT /////
//The leash object itself
//The component variables are used for hooks, used later.

/obj/item/leash
	name = "rope leash"
	desc = "A simple rope, with a knot at the end for easy attachment onto bindings."
	icon = 'modular/icons/obj/items/leashes_collars.dmi'
	icon_state = "leash"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	equip_sound = 'sound/foley/equip/rummaging-01.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	throw_range = 4
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BELT
	force = 1
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	var/leash_used = 0 //A flag to see if the leash has been used yet, because for some reason picking up an unused leash is weird
	var/mob/living/leash_pet = null //Variable to store our pet later
	var/mob/living/leash_master = null //And our master too
	var/mob/mobhook_leash_pet
	var/mob/mobhook_leash_master //Needed to watch for these entities to move
	var/mob/mobhook_leash_freepet
	var/leash_location[3] //Three digit list for us to store coordinates later

//Called when someone is clicked with the leash
/obj/item/leash/attack(mob/living/carbon/C, mob/living/user, attackchain_flags, damage_multiplier) //C is the target, user is the one with the leash
	if(C.has_status_effect(/datum/status_effect/leash_pet)) //If the pet is already leashed, do not leash them. For the love of god.
		to_chat(user, "<span class='notice'>[C] has already been leashed.</span>")
		return

	if(C.cmode && C.mobility_flags & MOBILITY_STAND)
		to_chat(user, span_warning("I can't leash them, they're too tense!"))
		return
	
	if(!src.leash_pet == null)
		to_chat(user, span_warning("This leash is already attached to [leash_pet]!"))
		return

	if(istype(C.get_item_by_slot(SLOT_NECK), /obj/item/clothing/neck/roguetown/collar) || istype(C.get_item_by_slot(SLOT_HANDCUFFED), /obj/item/rope/chain) || istype(C.get_item_by_slot(SLOT_NECK), /obj/item/clothing/neck/roguetown/talkstone) || istype(C.get_item_by_slot(SLOT_NECK), /obj/item/clothing/neck/roguetown/gorget/prisoner) || istype(C.get_item_by_slot(SLOT_NECK), /obj/item/clothing/neck/roguetown/gorget/alt))
		
		var/leash_attempt_message = "[user] raises \the [src] to [C]'s neck!"
		for(var/mob/viewing in viewers(C, null))
			if(viewing == C)
				to_chat(C, "<span class='warning'>[user] begins raising \the [src] to my neck!</span>")
			else if(viewing == user)
				to_chat(user, "<span class='warning'>I begin raising \the [src] to [C]'s neck!</span>")
			else
				viewing.show_message("<span class='warning'>[leash_attempt_message]</span>", 1)
		
		var/leashtime = 50
		if(C.handcuffed)
			leashtime = 5
		if(do_mob(user, C, leashtime)) //do_mob adds a progress bar, but then we also check to see if they have a collar
			log_combat(user, C, "leashed", addition="playfully")
			//TODO: Figure out how to make an easy breakout for leashed leash_pets
			C.apply_status_effect(/datum/status_effect/leash_pet)//Has now been leashed
			user.apply_status_effect(/datum/status_effect/leash_owner) //Is the leasher
			leash_pet = C //Save pet reference for later
			leash_master = user //Save dom reference for later
			mobhook_leash_pet = leash_pet.AddComponent(/datum/component/redirect, list(COMSIG_MOVABLE_MOVED = CALLBACK(src, .proc/on_pet_move)))
			RegisterSignal(leash_pet, COMSIG_MOVABLE_MOVED, .proc/on_pet_move)
			mobhook_leash_master = leash_master.AddComponent(/datum/component/redirect, list(COMSIG_MOVABLE_MOVED = CALLBACK(src, .proc/on_master_move)))
			RegisterSignal(leash_master, COMSIG_MOVABLE_MOVED, .proc/on_master_move)
			leash_used = 1

			if(!leash_pet.has_status_effect(/datum/status_effect/leash_owner)) //Add slowdown if the pet didn't leash themselves
				leash_pet.add_movespeed_modifier(MOVESPEED_ID_LEASH)
			for(var/mob/viewing in viewers(user, null))
				if(viewing == leash_master)
					to_chat(leash_master, "<span class='warning'>You have hooked \the [src] onto [leash_pet]!</span>")
				else if(viewing == leash_pet)
					to_chat(leash_pet, "<span class='warning'>[leash_master] has hooked \a [src] onto my collar!</span>")
				else
					viewing.show_message("<span class='warning'>[leash_pet] has been leashed by [leash_master]!</span>", 1)
			
			if(leash_pet.has_status_effect(/datum/status_effect/leash_owner)) //Pet leashed themself. They are not the dom
				leash_pet.apply_status_effect(/datum/status_effect/leash_freepet)
				mobhook_leash_freepet = leash_pet
				leash_pet.remove_status_effect(/datum/status_effect/leash_owner)
				mobhook_leash_master = null
			while(1) //While true loop. The mark of a genius coder.  ##MAINLOOP START
				sleep(2) //Check every other tick
				if(leash_pet == null) //No pet, break loop
					return
				if(!(leash_pet.get_item_by_slot(SLOT_NECK))) //The pet has slipped their collar and is not the pet anymore.
					for(var/mob/viewing in viewers(user, null))
						if(viewing == leash_master)
							to_chat(leash_master, "<span class='notice'>[leash_pet] has escaped their collar!!</span>", 1)
						else if(viewing == leash_pet)
							to_chat(leash_pet, "<span class='notice'>You have slipped free of your collar!</span>")
						else
							viewing.show_message("<span class='notice'>[leash_pet] has slipped out of their collar!</span>")
					leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
					mobhook_leash_pet = null
					leash_used = 0

				if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet)) //If there is no pet, there is no dom. Loop breaks.
					mobhook_leash_master = null
					UnregisterSignal(mobhook_leash_master, COMSIG_MOVABLE_MOVED)
					mobhook_leash_pet = null
					UnregisterSignal(mobhook_leash_pet, COMSIG_MOVABLE_MOVED)
					mobhook_leash_freepet = null
					UnregisterSignal(mobhook_leash_freepet, COMSIG_MOVABLE_MOVED)
					if(leash_pet.has_status_effect(/datum/status_effect/leash_freepet))
						leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
					if(leash_pet.has_movespeed_modifier(MOVESPEED_ID_LEASH))
						leash_pet.remove_movespeed_modifier(MOVESPEED_ID_LEASH)
					if(!leash_master == null)
						leash_master.remove_status_effect(/datum/status_effect/leash_owner)
					leash_used = 0 //reset the leash to neutral
					leash_pet = null
					return

	else //No collar, no fun
		var/leash_message = pick("Your pet needs a collar")
		to_chat(user, "<span class='notice'>[leash_message]</span>")

//Called when the leash is used in hand
//Tugs the pet closer
/obj/item/leash/attack_self(mob/living/user)
	if(!leash_pet == null) //No pet, no tug.
		return

	//Yank the pet. Yank em in close.
	if(leash_pet.x > leash_master.x + 1)
		step(leash_pet, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
		if(leash_pet.y > leash_master.y)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.x < leash_master.x - 1)
		step(leash_pet, EAST, 1)
		if(leash_pet.y > leash_master.y)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.y > leash_master.y + 1)
		step(leash_pet, SOUTH, 1)
		if(leash_pet.x > leash_master.x)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)
	if(leash_pet.y < leash_master.y - 1)
		step(leash_pet, NORTH, 1)
		if(leash_pet.x > leash_master.x)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)

	log_combat(leash_master, leash_pet, "leash-yanked")
	leash_pet.visible_message(span_warning("[leash_master] yanks [leash_pet] closer with \the [src.name]."))

/obj/item/leash/MiddleClick(mob/user, params)
	if(leash_pet == null) //No pet, can't unclip what isn't clipped
		to_chat(user, "There is no pet to unhook.")
		return
	
	for(var/mob/viewing in viewers(user, null))
		if(viewing == leash_master)
			to_chat(leash_master, "I have unclasped \the [src] from [leash_pet]'s collar!")
		else if(viewing == leash_pet)
			to_chat(leash_pet, "[leash_master] has unlatched \the [src] from my collar!")
		else
			viewing.show_message("\The [src] has been unhooked from [leash_pet]'s collar.", 1)

	leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
	leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
	leash_pet.remove_movespeed_modifier(MOVESPEED_ID_LEASH)
	leash_master.remove_status_effect(/datum/status_effect/leash_owner)
	mobhook_leash_master = null
	UnregisterSignal(mobhook_leash_master, COMSIG_MOVABLE_MOVED)
	mobhook_leash_pet = null
	UnregisterSignal(mobhook_leash_pet, COMSIG_MOVABLE_MOVED)
	leash_pet = null
	leash_master = null
	leash_used = 0
	

/obj/item/leash/proc/on_master_move()
	//Make sure the dom still has a pet
	if(leash_master == null) //There must be a master
		return
	if(leash_pet == null) //There must be a pet
		return
	if(leash_pet == leash_master) //Pet is the master
		return
	if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet))
		mobhook_leash_master = null //Probably redundant, but it's nice to be safe
		UnregisterSignal(mobhook_leash_master, COMSIG_MOVABLE_MOVED)
		leash_master.remove_status_effect(/datum/status_effect/leash_owner)
		leash_used = 0
		return

	//If the master moves, pull the pet in behind
	sleep(2) //A small sleep so the pet kind of bounces back after they make the step
	//Also, the sleep means that the distance check for master happens before the pet, to prevent both from proccing.

	if(leash_master == null) //Just to stop error messages
		return
	if(leash_pet == null)
		return
	if(leash_pet.x > leash_master.x + 2)
		step(leash_pet, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
		if(leash_pet.y > leash_master.y)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.x < leash_master.x - 2)
		step(leash_pet, EAST, 1)
		if(leash_pet.y > leash_master.y)
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.y > leash_master.y + 2)
		step(leash_pet, SOUTH, 1)
		if(leash_pet.x > leash_master.x)
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)
	if(leash_pet.y < leash_master.y - 2)
		step(leash_pet, NORTH, 1)
		if(leash_pet.x > leash_master.x)
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)

	//Knock the pet over if they get further behind. Shouldn't happen too often.
	sleep(3) //This way running normally won't just yank the pet to the ground.
	if(leash_master == null) //Just to stop error messages. Break the loop early if something removed the master
		return
	if(leash_pet == null)
		return
	if(leash_pet.x > leash_master.x + 2 || leash_pet.x < leash_master.x - 2 || leash_pet.y > leash_master.y + 2 || leash_pet.y < leash_master.y - 2)
		var/leash_knockdown_message = "[leash_pet] got pulled to the ground by their leash!"
		to_chat(leash_master, "<span class='notice'>[leash_knockdown_message]</span>")
		to_chat(leash_pet, "<span class='notice'>[leash_knockdown_message]</span>")
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)

	//This code is to check if the pet has gotten too far away, and then break the leash.
	sleep(3) //Wait to snap the leash
	if(leash_master == null) //Just to stop error messages
		return
	if(leash_pet == null)
		return
	if(leash_pet.x > leash_master.x + 4 || leash_pet.x < leash_master.x - 4 || leash_pet.y > leash_master.y + 4 || leash_pet.y < leash_master.y - 4)
		var/leash_break_message = "The leash snapped free from [leash_pet]!"
		for(var/mob/viewing in viewers(leash_pet, null))
			if(viewing == leash_master)
				to_chat(leash_master, "<span class='warning'>The leash snapped free from your pet!</span>")
			if(viewing == leash_pet)
				to_chat(leash_pet, "<span class='warning'>Your leash has popped from your collar!</span>")
			else
				viewing.show_message("<span class='warning'>[leash_break_message]</span>", 1)
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)
		leash_pet.adjustOxyLoss(5)
		leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
		leash_pet.remove_movespeed_modifier(MOVESPEED_ID_LEASH)
		leash_master.remove_status_effect(/datum/status_effect/leash_owner)
		mobhook_leash_master = null
		UnregisterSignal(mobhook_leash_master, COMSIG_MOVABLE_MOVED)
		mobhook_leash_pet = null
		UnregisterSignal(mobhook_leash_pet, COMSIG_MOVABLE_MOVED)
		leash_pet = null
		leash_master = null
		leash_used = 0

/obj/item/leash/proc/on_pet_move()
	//This should only work if there is a pet and a master.
	//This is here pretty much just to stop the console from flooding with errors
	if(leash_master == null)
		return
	if(leash_pet == null)
		return
	//Make sure the pet is still a pet
	if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet))
		UnregisterSignal(mobhook_leash_pet, COMSIG_MOVABLE_MOVED)
		mobhook_leash_pet = null //Probably redundant, but it's nice to be safe
		leash_pet = null
		leash_master = null
		return

	//The pet has escaped. There is no DOM. GO PET RUN.
	if(leash_pet.has_status_effect(/datum/status_effect/leash_freepet))//If the pet is free, break
		return

	//If the pet gets too far away, they get tugged back
	sleep(2)//A small sleep so the pet kind of bounces back after they make the step
	if(leash_master == null)
		return
	if(leash_pet == null)
		return
	//West tug
	if(leash_pet.x > leash_master.x + 2)
		step(leash_pet, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
	//East tug
	if(leash_pet.x < leash_master.x - 2)
		step(leash_pet, EAST, 1)
	//South tug
	if(leash_pet.y > leash_master.y + 2)
		step(leash_pet, SOUTH, 1)
	//North tug
	if(leash_pet.y < leash_master.y - 2)
		step(leash_pet, NORTH, 1)

/obj/item/leash/proc/on_freepet_move()
	//Pet is on the run. Let's drag the leash behind them.
	if(!leash_master == null) //If there is a master, don't do this
		return
	if(leash_pet == null) //If there is no pet, don't do this
		mobhook_leash_freepet = null
		mobhook_leash_pet = null
		return
	if(leash_pet.is_holding_item_of_type(/obj/item/leash)) //If the pet is holding the leash, don't do this
		return

	sleep(2)
	if(leash_pet == null)
		return
	//Double move to catch the leash up to the pet
	if(src.x > leash_pet.x + 2)
		. = step(src, WEST, 1)
	if(src.x < leash_pet.x - 2)
		. = step(src, EAST, 1)
	if(src.y > leash_pet.y + 2)
		. = step(src, SOUTH, 1)
	if(src.y < leash_pet.y - 2)
		. = step(src, NORTH, 1)
	//Primary dragging code
	if(src.x > leash_pet.x + 1)
		. = step(src, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
		if(src.y > leash_pet.y)//Check the other axis, and tug them into alignment so they are behind the pet
			. = step(src, SOUTH, 1)
		if(src.y < leash_pet.y)
			. = step(src, NORTH, 1)
	if(src.x < leash_pet.x - 1)
		. = step(src, EAST, 1)
		if(src.y > leash_pet.y)
			. = step(src, SOUTH, 1)
		if(src.y < leash_pet.y)
			. = step(src, NORTH, 1)
	if(src.y > leash_pet.y + 1)
		. = step(src, SOUTH, 1)
		if(src.x > leash_pet.x)
			. = step(src, WEST, 1)
		if(src.x < leash_pet.x)
			. = step(src, EAST, 1)
	if(src.y < leash_pet.y - 1)
		. = step(src, NORTH, 1)
		if(src.x > leash_pet.x)
			. = step(src, WEST, 1)
		if(src.x < leash_pet.x)
			. = step(src, EAST, 1)

	sleep(1)
	//Just to prevent error messages
	if(leash_pet == null)
		return
	if(src.x > leash_pet.x + 4 || src.x < leash_pet.x - 4 || src.y > leash_pet.y + 4 || src.y < leash_pet.y - 4)
		var/leash_break_message = "The leash snapped free from [leash_pet]!"
		for(var/mob/viewing in viewers(leash_pet, null))
			if(viewing == leash_pet)
				to_chat(leash_pet, "<span class='warning'>Your leash has popped from your collar!</span>")
			else
				viewing.show_message("<span class='warning'>[leash_break_message]</span>", 1)
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)
		leash_pet.adjustOxyLoss(5)
		leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
		leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
		mobhook_leash_pet = null
		UnregisterSignal(mobhook_leash_pet, COMSIG_MOVABLE_MOVED)
		mobhook_leash_freepet = null
		UnregisterSignal(mobhook_leash_freepet, COMSIG_MOVABLE_MOVED)
		leash_pet = null
		leash_used = 0

//The proc below in question is the one causing all the errors apparently

/obj/item/leash/dropped(mob/user, silent)
	 //Drop the leash, and the leash effects stop
	. = ..()
	if(leash_pet == null) //There is no pet. Stop this silliness
		return
	if(leash_master == null)
		return
	//Dropping procs any time the leash changes slots. So, we will wait a tick and see if the leash was actually dropped
	addtimer(CALLBACK(src, .proc/drop_effects, user, silent), 1)

/obj/item/leash/proc/drop_effects(mob/user, silent)
	if(leash_master.is_holding_item_of_type(/obj/item/leash) || istype(leash_master.get_item_by_slot(SLOT_BELT), /obj/item/leash))
		return  //Dom still has the leash as it turns out. Cancel the proc.
	for(var/mob/viewing in viewers(leash_master, null))
		viewing.show_message("<span class='notice'>[leash_master] has dropped the leash.</span>", 1)
	//DOM HAS DROPPED LEASH. PET IS FREE. SCP HAS BREACHED CONTAINMENT.
	leash_pet.remove_movespeed_modifier(MOVESPEED_ID_LEASH)
	RegisterSignal(leash_pet, COMSIG_MOVABLE_MOVED, .proc/on_freepet_move)
	mobhook_leash_freepet = leash_pet.AddComponent(/datum/component/redirect, list(COMSIG_MOVABLE_MOVED = CALLBACK(src, .proc/on_freepet_move)))
	leash_master.remove_status_effect(/datum/status_effect/leash_owner) //No dom with no leash. We will get a new dom if the leash is picked back up.
	leash_master = null
	mobhook_leash_master = null
	UnregisterSignal(mobhook_leash_master, COMSIG_MOVABLE_MOVED)

/obj/item/leash/equipped(mob/user)
	. = ..()
	if(leash_used == 0) //Don't apply statuses with a fresh leash. Keeps things clean on the backend.
		return
	addtimer(CALLBACK(src, .proc/equip_effects, user), 2)

/obj/item/leash/proc/equip_effects(mob/user)
	if(leash_pet == null)
		return
	leash_master = user
	if(leash_master.has_status_effect(/datum/status_effect/leash_freepet) || leash_master.has_status_effect(/datum/status_effect/leash_pet)) //Pet picked up their own leash.
		leash_master = null
		return
	leash_master.apply_status_effect(/datum/status_effect/leash_owner)
	mobhook_leash_master = leash_master.AddComponent(/datum/component/redirect, list(COMSIG_MOVABLE_MOVED = CALLBACK(src, .proc/on_master_move)))
	RegisterSignal(leash_master, COMSIG_MOVABLE_MOVED, .proc/on_master_move)
	leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
	mobhook_leash_freepet = null
	UnregisterSignal(mobhook_leash_freepet, COMSIG_MOVABLE_MOVED)
	leash_pet.add_movespeed_modifier(MOVESPEED_ID_LEASH)


