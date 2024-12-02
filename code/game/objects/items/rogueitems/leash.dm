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
	name = "Controlling Leash"
	desc = "You've got a leash and a pet on the other end!"
	icon_state = "leash_master" 

/datum/status_effect/leash_freepet
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/leash_freepet

/atom/movable/screen/alert/status_effect/leash_freepet
	name = "Escaped Pet"
	desc = "You're on a leash, but you've no master. If anyone grabs the leash they'll gain control!"
	icon_state = "leash_freepet"

/datum/status_effect/leash_pet
	id = "leashed"
	status_type = STATUS_EFFECT_UNIQUE
	var/mob/redirect_component
	alert_type = /atom/movable/screen/alert/status_effect/leash_pet

/atom/movable/screen/alert/status_effect/leash_pet
	name = "Leashed"
	desc = "You're bound by a leash. Your movement is restricted. Walkies time!"
	icon_state = "leash_pet"

/datum/status_effect/leash_pet/on_apply()
	redirect_component = owner
	if(!owner.stat)
		to_chat(owner, span_userdanger("You have been leashed!"))
	return ..()

///// OBJECT /////
//The leash object itself
//The component variables are used for hooks, used later.

/obj/item/rope/leash
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
	possible_item_intents = list(/datum/intent/leash, /datum/intent/tie)
	var/mob/living/leash_pet = null //Variable to store our pet later
	var/mob/living/leash_master = null //And our master too
	var/mob/mobhook_leash_pet
	var/mob/mobhook_leash_master //Needed to watch for these entities to move
	var/mob/mobhook_leash_freepet

/obj/item/rope/leash/process(delta_time)
	if(!leash_pet) //No pet, break loop
		return PROCESS_KILL
	if(!(leash_pet.get_item_by_slot(ITEM_SLOT_NECK))) //The pet has slipped their collar and is not the pet anymore.
		leash_pet.visible_message(
			span_warning("[leash_pet] has slipped out of their collar!"),
			span_warning("You have slipped out of your collar!"),
			target = leash_master,
			target_message = span_warning("[leash_pet] has slipped out of their collar!")
		)
		leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
	if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet)) //If there is no pet, there is no dom. Loop breaks.
		//QDEL_NULL(mobhook_leash_master)
		UnregisterSignal(mobhook_leash_master, COMSIG_MOVABLE_MOVED)
		//QDEL_NULL(mobhook_leash_pet)
		UnregisterSignal(mobhook_leash_pet, COMSIG_MOVABLE_MOVED)
		//QDEL_NULL(mobhook_leash_freepet)
		UnregisterSignal(mobhook_leash_freepet, COMSIG_MOVABLE_MOVED)
		leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
		//leash_pet.remove_movespeed_modifier(/datum/movespeed_modifier/leash)
		leash_master?.remove_status_effect(/datum/status_effect/leash_owner)
		leash_pet = null
		return PROCESS_KILL

/obj/item/rope/leash/attack(mob/living/carbon/C, mob/living/user)
	if(user.used_intent.type != /datum/intent/tie || user.used_intent.type != /datum/intent/leash)
		..()
		return

	if(!istype(C))
		return
	
	if(user.used_intent.type == /datum/intent/leash)
		try_leash(C,user)
		return

	if(user.aimheight > 4)
		try_cuff_arms(C, user)
		return

	if(user.aimheight <= 4)
		try_cuff_legs(C, user)
		return

//Triggers after clicking is cleared as viable

/obj/item/rope/leash/proc/try_leash(mob/living/carbon/C, mob/living/user)
	if(C.leashed) //No multileash drifting pls
		return

	if(C.has_status_effect(/datum/status_effect/leash_pet)) //If the pet is already leashed, do not leash them. For the love of god.
		to_chat(user, span_notice("[C] has already been leashed."))
		return


	if(C.cmode && C.mobility_flags & MOBILITY_STAND)
		to_chat(user, span_warning("I can't leash them, they're too tense!"))
		return

	var/surrender_mod = 1
	if(C.surrendering)
		surrender_mod = 0.5

	if(!istype(C.get_item_by_slot(SLOT_NECK), /obj/item/clothing/neck/roguetown/collar) || !istype(C.get_item_by_slot(SLOT_HANDCUFFED), /obj/item/rope/chain) || !istype(C.get_item_by_slot(SLOT_NECK), /obj/item/clothing/neck/roguetown/talkstone) || !istype(C.get_item_by_slot(SLOT_NECK), /obj/item/clothing/neck/roguetown/gorget/prisoner) || !istype(C.get_item_by_slot(SLOT_NECK), /obj/item/clothing/neck/roguetown/gorget/alt))
		var/leash_message = pick("[C] needs a collar before you can attach a leash to it.")
		to_chat(user, span_notice("[leash_message]"))
		return
	C.visible_message(span_warning("[user] is trying to leash [C]'s neck with [src.name]!"), \
						span_userdanger("[user] is trying to leash my neck with [src.name]!"))
	playsound(loc, cuffsound, 100, TRUE, -2)
	var/leashtime = 50
	if(C.handcuffed)
		leashtime = 5
	if(!(do_mob(user, C, leashtime * surrender_mod)))
		to_chat(user, span_warning("I fail to tie up [C]!"))
		return

	apply_leash(C, user)
	C.visible_message(span_warning("[user] leashes [C] with [src.name]."), \
						span_danger("[user] leashes me with [src.name]."))
	SSblackbox.record_feedback("tally", "leashes", 1, type)
	log_combat(user, C, "leashed", addition="playfully")

/obj/item/rope/leash/proc/apply_leash(mob/living/carbon/target, mob/living/user)
	if(target.leashed)
		return

	target.apply_status_effect(/datum/status_effect/leash_pet)//Has now been leashed
	user.apply_status_effect(/datum/status_effect/leash_owner) //Is the leasher
	leash_pet = target //Save pet reference for later
	leash_master = user //Save dom reference for later
	RegisterSignal(leash_pet, COMSIG_MOVABLE_MOVED, PROC_REF(on_pet_move))
	mobhook_leash_pet = leash_pet
	RegisterSignal(leash_master, COMSIG_MOVABLE_MOVED, PROC_REF(on_master_move))
	mobhook_leash_master = leash_master

	if(leash_pet.has_status_effect(/datum/status_effect/leash_owner)) //Pet leashed themself. They are not the dom, may be where freepet issue is
		leash_pet.apply_status_effect(/datum/status_effect/leash_freepet)
		leash_pet.remove_status_effect(/datum/status_effect/leash_owner)
	START_PROCESSING(SSfastprocess, src) // The original while loop here ran every 2 deciseconds, and so does SSfastprocess.

	var/obj/item/leash = src
	target.leashed = leash
	target.update_inv_leashed()

	return


//Called when the leash is used in hand
//Tugs the pet closer
/obj/item/rope/leash/attack_self(mob/living/user)
	if(!leash_pet) //No pet, no tug.
		return
	//Yank the pet. Yank em in close.
	apply_tug_mob_to_mob(leash_pet, leash_master, 1)
	log_combat(leash_master, leash_pet, "leash-yanked")
	leash_pet.visible_message(span_warning("[leash_master] yanks [leash_pet] closer with \the [src.name]."))

/obj/item/rope/leash/proc/on_master_move()
	SIGNAL_HANDLER
	//Make sure the dom still has a pet
	if(!leash_master) //There must be a master
		return
	if(!leash_pet) //There must be a pet
		return
	if(leash_pet == leash_master) //Pet is the master
		return
	if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet))
		UnregisterSignal(mobhook_leash_master, COMSIG_MOVABLE_MOVED)
		mobhook_leash_master = null
		leash_master.remove_status_effect(/datum/status_effect/leash_owner)
		return
	addtimer(CALLBACK(src, PROC_REF(after_master_move)), 0.2 SECONDS)

/obj/item/rope/leash/proc/after_master_move()
	//If the master moves, pull the pet in behind
	//Also, the timer means that the distance check for master happens before the pet, to prevent both from proccing.

	if(!leash_master) //Just to stop error messages
		return
	if(!leash_pet)
		return
	apply_tug_mob_to_mob(leash_pet, leash_master, 1)

	//Knock the pet over if they get further behind. Shouldn't happen too often.
	sleep(3) //This way running normally won't just yank the pet to the ground.
	if(!leash_master) //Just to stop error messages. Break the loop early if something removed the master
		return
	if(!leash_pet)
		return
	if(get_dist(leash_pet, leash_master) > 3)
		leash_pet.visible_message(
			span_warning("[leash_pet] is pulled to the ground by their leash!"),
			span_warning("You are pulled to the ground by your leash!")
		)
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)

	//This code is to check if the pet has gotten too far away, and then break the leash.
	sleep(3) //Wait to snap the leash
	if(!leash_master) //Just to stop error messages
		return
	if(!leash_pet)
		return
	if(get_dist(leash_pet, leash_master) > 4)
		leash_pet.visible_message(
			span_warning("The leash snaps free from [leash_pet]'s collar!"),
			span_warning("Your leash pops from your collar!"),
			target = leash_master,
			target_message = span_warning("The leash snaps free from your pet's collar!")
		)
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)
		leash_pet.adjustOxyLoss(5)
		leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
//		leash_pet.remove_movespeed_modifier(/datum/movespeed_modifier/leash)
		leash_master.remove_status_effect(/datum/status_effect/leash_owner)
		UnregisterSignal(mobhook_leash_master, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(mobhook_leash_pet, COMSIG_MOVABLE_MOVED)
		mobhook_leash_master = null
		mobhook_leash_pet = null
		leash_pet = null
		leash_master = null

/obj/item/rope/leash/proc/on_pet_move()
	SIGNAL_HANDLER
	//This should only work if there is a pet and a master.
	//This is here pretty much just to stop the console from flooding with errors
	if(!leash_master)
		return
	if(!leash_pet)
		return
	//Make sure the pet is still a pet
	if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet))
		//QDEL_NULL(mobhook_leash_pet) //Probably redundant, but it's nice to be safe
		UnregisterSignal(mobhook_leash_pet, COMSIG_MOVABLE_MOVED)
		return

	//The pet has escaped. There is no DOM. GO PET RUN.
	if(leash_pet.has_status_effect(/datum/status_effect/leash_freepet))//If the pet is free, break
		return
	//If the pet gets too far away, they get tugged back
	addtimer(CALLBACK(src, PROC_REF(after_pet_move)), 0.3 SECONDS) //A short timer so the pet kind of bounces back after they make the step

/obj/item/rope/leash/proc/after_pet_move()
	if(!leash_master)
		return
	if(!leash_pet)
		return
	for(var/i in 2 to get_dist(leash_pet, leash_master)) // Move the pet to a minimum of 1 tiles away from the master, so the pet trails behind them.
		step_towards(leash_pet, leash_master)

/obj/item/rope/leash/proc/on_freepet_move()
	SIGNAL_HANDLER
	//Pet is on the run. Let's drag the leash behind them.
	if(leash_master) //If there is a master, don't do this
		return
	if(!leash_pet) //If there is no pet, don't do this
		return
	if(leash_pet.is_holding(src)) //If the pet is holding the leash, don't do this
		return

	//If the pet gets too far away, we get tugged to them.
	addtimer(CALLBACK(src, PROC_REF(after_freepet_move)), 0.1 SECONDS, TIMER_UNIQUE) //A short timer so the leash trails behind us.

/obj/item/rope/leash/proc/after_freepet_move()
	if(!leash_pet)
		return

	for(var/i in 2 to get_dist(src, leash_pet)) // Move us to a minimum of 1 tiles away from the pet, so we trail behind them.
		step_towards(src, leash_pet)

	sleep(1)
	//Just to prevent error messages
	if(!leash_pet)
		return
	if(get_dist(src, leash_pet) > 4)
		leash_pet.visible_message(span_warning("\The [src] snaps free from \the [leash_pet]!"), span_warning("Your leash pops free from your collar!"))
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)
		leash_pet.adjustOxyLoss(5)
		leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
		leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
		//QDEL_NULL(mobhook_leash_pet)
		UnregisterSignal(mobhook_leash_pet, COMSIG_MOVABLE_MOVED)
		//QDEL_NULL(mobhook_leash_freepet)
		UnregisterSignal(mobhook_leash_freepet, COMSIG_MOVABLE_MOVED)
		leash_pet = null

//The proc below in question is the one causing all the errors apparently

/obj/item/rope/leash/dropped(mob/user, silent)
	 //Drop the leash, and the leash effects stop
	. = ..()
	if(!leash_pet) //There is no pet. Stop this silliness
		return
	if(!leash_master)
		return
	//Dropping procs any time the leash changes slots. So, we will wait a tick and see if the leash was actually dropped
	addtimer(CALLBACK(src, PROC_REF(drop_effects), user, silent), 1)

/obj/item/rope/leash/proc/drop_effects(mob/user, silent)
	SIGNAL_HANDLER
	if(leash_master.is_holding(src) || leash_master.get_item_by_slot(ITEM_SLOT_BELT) == src)
		return  //Dom still has the leash as it turns out. Cancel the proc.
	leash_master.visible_message(span_notice("\The [leash_master] drops \the [src]."), span_notice("You drop \the [src]."))
	//DOM HAS DROPPED LEASH. PET IS FREE. SCP HAS BREACHED CONTAINMENT.
//	leash_pet.remove_movespeed_modifier(/datum/movespeed_modifier/leash)
	UnregisterSignal(leash_pet, COMSIG_MOVABLE_MOVED)
	mobhook_leash_freepet = leash_pet
	RegisterSignal(mobhook_leash_freepet, COMSIG_MOVABLE_MOVED, PROC_REF(on_freepet_move))
	leash_master.remove_status_effect(/datum/status_effect/leash_owner) //No dom with no leash. We will get a new dom if the leash is picked back up.
	leash_master = null
	//QDEL_NULL(mobhook_leash_master)
	UnregisterSignal(mobhook_leash_master, COMSIG_MOVABLE_MOVED)

/obj/item/rope/leash/equipped(mob/user)
	. = ..()
	if(!leash_pet) //Don't apply statuses with a petless leash.
		return
	addtimer(CALLBACK(src, PROC_REF(equip_effects), user), 2)

/obj/item/rope/leash/proc/equip_effects(mob/user)
	if(!leash_pet)
		return
	if(leash_master == user)
		return // Don't double-register.
	if(leash_pet == user) //Pet picked up their own leash.
		leash_master = null
		return
	leash_master = user
	leash_master.apply_status_effect(/datum/status_effect/leash_owner)
	RegisterSignal(leash_master, COMSIG_MOVABLE_MOVED, PROC_REF(on_master_move))
	mobhook_leash_master = leash_master
	leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
	//QDEL_NULL(mobhook_leash_freepet)
	if(mobhook_leash_freepet)
		UnregisterSignal(mobhook_leash_freepet, COMSIG_MOVABLE_MOVED)
//	leash_pet.add_movespeed_modifier(/datum/movespeed_modifier/leash)

/*/datum/movespeed_modifier/leash
	id = MOVESPEED_ID_LEASH
	multiplicative_slowdown = 5 */

//////////////////////////////////////////ROPE STUFF////////////////////////////////
