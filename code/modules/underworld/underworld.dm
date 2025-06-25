/obj/item/flashlight/lantern/shrunken
	name = "shrunken lamp"
	desc = "A beacon."
	icon_state = "shrunkenlamp"
	item_state = "shrunkenlamp"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	light_range = 4
	light_power = 20
	light_color = LIGHT_COLOR_BLOOD_MAGIC

/obj/item/flashlight/lantern/shrunken/update_brightness(mob/user = null)
	if(on)
		icon_state = "[initial(icon_state)]-on"
		set_light_on(TRUE)
	else
		icon_state = initial(icon_state)
		set_light_on(FALSE)


/obj/structure/underworld/carriageman
	name = "The Carriageman"
	desc = "They will take the reigns and lead the way. But only if the price I can pay."
	icon = 'icons/roguetown/underworld/enigma_carriageman.dmi'
	icon_state = "carriageman"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	density = TRUE

/obj/structure/underworld/carriage_normal
	name = "Carriage"
	desc = "The ride stopped here..."
	icon = 'icons/roguetown/underworld/enigma_carriage.dmi'
	icon_state = "carriage_normal"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	bound_width = 160
	bound_height = 96
	anchored = TRUE
	density = TRUE
	max_integrity = 9999

/obj/structure/underworld/carriage_normal/New(loc, ...)
	. = ..()
	var/pos = get_step(loc, EAST)
	pos = get_step(pos, EAST)
	new /obj/structure/carriagedoor(pos)

#define CANT_LEAVE_ITEMS \
	/obj/item/rogueweapon/woodstaff/aries, \
	/obj/item/clothing/head/roguetown/crown, \
	/obj/item/key/lord

/obj/structure/carriagedoor
	name = "carriage door"
	desc = "The wooden entrance to the carriage. It allows those who come to arrive and those who leave to depart."
	icon = 'icons/roguetown/misc/doors.dmi'
	icon_state = "carriage_door"
	layer = WALL_OBJ_LAYER
	plane = GAME_PLANE_UPPER
	pixel_y = 27
	max_integrity = 9999 // In case any maniac decides to hit it.


/*=====================
Carriage door attack by
=====================*/
// Handles leaving.
/obj/structure/carriagedoor/attack_hand(mob/user)
	var/mob/living/carbon/human/H
	if(ishuman(user))
		H = user

	if(!isliving(user) || user.incapacitated())
		return //No ghosts or incapacitated folk allowed to do this.

	if(user.get_active_held_item())
		to_chat(user, span_warn("I can't turn the handle. My hand has something in it!"))
		return
		
	var/datum/job/J = SSjob.name_occupations[user.job]
	if(J.can_leave_round == FALSE)
		to_chat(user, span_warning("You are too important to leave!!"))
		return

	// No important antags can leave!
	if(H.mind && H.mind.antag_datums)
		var/datum/mind/M = H.mind
		if(length(M.antag_datums)) // Fuck it we don't need to check at all. If you have any antag datums you can't leave!
			to_chat(user, span_warning("I still have work to do here..."))
			return

	//Checks for all items
	var/list/user_items = H.get_all_gear()
	for(var/forbidden_type in list(CANT_LEAVE_ITEMS))
		var/forbidden_item = locate(forbidden_type) in user_items
		if(forbidden_item)
			to_chat(user, span_notice("You can't leave with \the [forbidden_item]."))
			return
		
	switch(alert("Do you wish to leave town? (You cannot return.)",,"Yes","No"))
		if("Yes")
			to_chat(user, span_notice("You start climbing into the carriage to leave..."))
			if(do_after(user, 5 SECONDS))
				// Thank you Azure <3 I did not want to have to write this.
				// Logs everything on the mob
				var/dat = "[key_name(user)] has departed town via the carriage. job [user.job], at [AREACOORD(src)]. They had:"
				var/list/contained_items = H.get_all_gear()
				if(!length(contained_items))
					dat += " Nothing on them."
				else
					dat += " [english_list(H.get_all_gear())]"

				// Remove known person
				if(user.mind)
					user.mind.unknow_all_people()
					for(var/datum/mind/MF in get_minds())
						user.mind.become_unknown_to(MF)
					for(var/datum/bounty/removing_bounty in GLOB.head_bounties)
						if(removing_bounty.target == user.real_name)
							GLOB.head_bounties -= removing_bounty

				GLOB.chosen_names -= user.real_name
				LAZYREMOVE(GLOB.actors_list, user.mobid)
				
				//log player to admins
				message_admins(dat)
				log_admin(dat)

				// open up positions
				J.current_positions =  max(0, J.current_positions - 1)
				var/datum/subclass/subclass = SSrole_class_handler.get_subclass_by_name(user.advjob)
				if(subclass)
					SSrole_class_handler.adjust_class_amount(subclass, -1)

				for(var/obj/item/I in contained_items)
					qdel(I)
				qdel(user)
				return // You don't do anything else 
				//Technically with this sytem you can return with the same job later. I don't mind
				// I'm sure someone might throw a fit and it admin logs so if anyone out there
				// is insane enough to try and abuse this you'd find out pretty quickly.

			else
				to_chat(user, span_notice("You have to stand still do to this!"))
		if("No")
			to_chat(user, span_notice("You decide to stay..."))

	. = ..()

	
/obj/structure/underworld/carriageman/Initialize()
	. = ..()
	set_light(5, 30, LIGHT_COLOR_BLUE)

/obj/structure/underworld/carriageman/attack_hand(mob/living/carbon/spirit/user)
	if(!user.paid)
		user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)
		to_chat(user, "<br><font color=purple><span class='bold'>FETCH THE TOLL AND YOU MAY BOARD</span></font>")
	else
		to_chat(user, "<br><font color=purple><span class='bold'>HANDS EXCHANGE PAY, BE ON YOUR WAY</span></font>")
		user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)

/obj/structure/underworld/carriageman/attackby(obj/item/W, mob/living/user)
	var/mob/living/carbon/spirit/ghost = user
	if(istype(W, /obj/item/underworld/coin))
		if(!ghost.paid)
			qdel(W)
			to_chat(ghost, "<br><font color=purple><span class='bold'>THE TOLL IS PAID, THROUGH THE CARRIAGE THE UNDERMAIDEN WAITS.</span></font>")
			user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)
			ghost.paid = TRUE
			return
		if(ghost.paid)
			to_chat(ghost, "<br><font color=purple><span class='bold'>FURTHER PAYMENT WILL NOT CHANGE HER JUDGEMENT.</span></font>")
			user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)
	else
		to_chat(ghost, "<br><font color=purple><span class='bold'>ONLY THE TOLL WILL I ACCEPT</span></font>")
		user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)

/obj/structure/underworld/barrier //Blocks sprite locations
	name = "DONT STAND HERE"
	desc = "The Undermaiden awaits."
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"
	density = TRUE
	anchored = TRUE

/obj/structure/underworld/carriage
	name = "Carriage"
	desc = "The Undermaiden awaits."
	icon = 'icons/roguetown/underworld/enigma_carriage.dmi'
	icon_state = "carriage_lit"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	density = TRUE


/obj/structure/underworld/carriage/Initialize()
	. = ..()
	set_light(5, 30, LIGHT_COLOR_BLUE)

/obj/structure/underworld/carriage/attack_hand(mob/living/carbon/spirit/user)
	if(user.paid)
		switch(alert("Are you ready to be judged?",,"Yes","No"))
			if("Yes")
				playsound(user, 'sound/misc/deadbell.ogg', 50, TRUE, -2, ignore_walls = TRUE)
				user.returntolobby()
			if("No")
				usr << "You delay fate."
	else
		to_chat(user, "<B><font size=3 color=red>It's LOCKED.</font></B>")

GLOBAL_VAR_INIT(underworld_coins, 0)

/obj/item/underworld/coin
	name = "The Toll"
	desc = "This is more than just a coin."
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "soultoken_floor"
	var/should_track = TRUE

/obj/item/underworld/coin/Initialize()
	. = ..()
	if(should_track)
		GLOB.underworld_coins += 1

/obj/item/underworld/coin/Destroy()
	if(should_track)
		GLOB.underworld_coins -= 1
	coin_upkeep()
	return ..()

/obj/item/underworld/coin/pickup(mob/user)
	..()
	if(should_track)
		GLOB.underworld_coins -= 1
	coin_upkeep()
	icon_state = "soultoken"

/obj/item/underworld/coin/dropped(mob/user)
	..()
	if(should_track)
		GLOB.underworld_coins += 1
	icon_state = "soultoken_floor"

/obj/item/underworld/coin/notracking
	should_track = FALSE

/proc/coin_upkeep()
	if(GLOB.underworld_coins < 8)
		for(var/obj/effect/landmark/underworldcoin/B in GLOB.landmarks_list)
			new /obj/item/underworld/coin(B.loc)


// why not also some mob stuff too
/mob/living/simple_animal/hostile/rogue/dragger
	name = "dragger"
	desc = ""
	icon = 'icons/roguetown/underworld/enigma_dragger.dmi'
	icon_state = "dragger"
	icon_living = "dragger"
	icon_dead = "dragger_dead"
	mob_biotypes = MOB_UNDEAD|MOB_HUMANOID
	movement_type = FLYING
	environment_smash = ENVIRONMENT_SMASH_NONE
	pass_flags = PASSTABLE|PASSGRILLE
	base_intents = list(/datum/intent/simple/slash)
	gender = MALE
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "passes through"
	response_help_simple = "pass through"
	maxHealth = 215
	health = 215
	layer = 16
	plane = 16
	spacewalk = TRUE
	stat_attack = UNCONSCIOUS
	robust_searching = 1
	speed = 1
	move_to_delay = 5 //delay for the automated movement.
	harm_intent_damage = 1
	obj_damage = 1
	melee_damage_lower = 30
	melee_damage_upper = 45
	attack_same = FALSE
	attack_sound = 'sound/combat/wooshes/bladed/wooshmed (1).ogg'
	dodge_sound = 'sound/combat/dodge.ogg'
	parry_sound = "bladedmedium"
	d_intent = INTENT_PARRY
	speak_emote = list("growls")
	limb_destroyer = 1
	del_on_death = FALSE
	STALUC = 11
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	faction = list("undead")
	footstep_type = null
	defprob = 50 //decently skilled
	defdrain = 20
	canparry = TRUE
	retreat_health = null

/mob/living/simple_animal/hostile/rogue/dragger/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	return FALSE

/mob/living/simple_animal/hostile/rogue/dragger/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "head"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "head"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "hand"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "hand"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "tail"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "tail"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "body"
		if(BODY_ZONE_PRECISE_GROIN)
			return "body"
		if(BODY_ZONE_PRECISE_R_INHAND)
			return "body"
		if(BODY_ZONE_PRECISE_L_INHAND)
			return "body"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "tail"
		if(BODY_ZONE_L_LEG)
			return "tail"
		if(BODY_ZONE_R_ARM)
			return "arm"
		if(BODY_ZONE_L_ARM)
			return "arm"
		if(BODY_ZONE_CHEST)
			return "chest"

	return ..()

/mob/living/simple_animal/hostile/rogue/dragger/taunted(mob/user)
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/rogue/dragger/Initialize()
	. = ..()
	set_light(2, 2, "#c0523f")
	ADD_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAINSTUN, TRAIT_GENERIC)


/mob/living/simple_animal/hostile/rogue/dragger/death(gibbed)
	emote("death")
	..()

/mob/living/simple_animal/hostile/rogue/dragger/Life()
	. = ..()

/mob/living/simple_animal/hostile/rogue/dragger/get_sound(input)
	switch(input)
		if("laugh")
			return pick('sound/vo/mobs/ghost/laugh (1).ogg','sound/vo/mobs/ghost/laugh (2).ogg','sound/vo/mobs/ghost/laugh (3).ogg','sound/vo/mobs/ghost/laugh (4).ogg','sound/vo/mobs/ghost/laugh (5).ogg','sound/vo/mobs/ghost/laugh (6).ogg')
		if("moan")
			return pick('sound/vo/mobs/ghost/moan (1).ogg','sound/vo/mobs/ghost/laugh (2).ogg','sound/vo/mobs/ghost/laugh (3).ogg')
		if("death")
			return 'sound/vo/mobs/ghost/death.ogg'
		if("whisper")
			return pick('sound/vo/mobs/ghost/whisper (1).ogg','sound/vo/mobs/ghost/whisper (2).ogg','sound/vo/mobs/ghost/whisper (3).ogg')
		if("aggro")
			return pick('sound/vo/mobs/ghost/aggro (1).ogg','sound/vo/mobs/ghost/aggro (2).ogg','sound/vo/mobs/ghost/aggro (3).ogg','sound/vo/mobs/ghost/aggro (4).ogg','sound/vo/mobs/ghost/aggro (5).ogg','sound/vo/mobs/ghost/aggro (6).ogg')

/mob/living/simple_animal/hostile/rogue/dragger/AttackingTarget()
	. = ..()
	if(. && prob(8) && iscarbon(target))
		var/mob/living/carbon/C = target
		C.Immobilize(50)
		C.visible_message(span_danger("\The [src] paralyzes \the [C] in fear!"), \
				span_danger("\The [src] paralyzes me!"))
		emote("laugh")

/obj/effect/landmark/underworldsafe/Crossed(atom/movable/AM, oldloc)
	if(istype(AM, /mob/living/simple_animal/hostile/rogue/dragger))
		for(var/mob/living/carbon/human/A in view(4))
			to_chat(A, "The monster's form dematerializes as it nears the Carriage.")
		qdel(AM)

