var/last_howl_sound_time = -99999 // Set to a time far in the past so the initial howl can play immediately
var/sound_cooldown = 10 * 60 * 10 // cooldown in deciseconds (15 minutes)

/obj/effect/proc_holder/spell/self/howl
	name = "Howl"
	desc = "!"
	overlay_state = "howl"
	antimagic_allowed = TRUE
	charge_max = 600 // 1 minute

/obj/effect/proc_holder/spell/self/howl/cast(mob/user = usr)
	..()
	var/message = input("Howl at the hidden moon", "WEREWOLF") as text|null
	if (!message) return

	var/datum/antagonist/werewolf/werewolf_player = user.mind.has_antag_datum(/datum/antagonist/werewolf)
	
	// sound played for owner
	playsound(src, pick('sound/vo/mobs/wwolf/howl (1).ogg','sound/vo/mobs/wwolf/howl (2).ogg'), 100, TRUE)

	for (var/mob/player in GLOB.player_list)
		if (!player.mind) continue
		if (player.stat == DEAD) continue
		if (isbrain(player)) continue

		// Announcement to other werewolves
		if (player.mind.has_antag_datum(/datum/antagonist/werewolf))
			to_chat(player, span_boldannounce("[werewolf_player.wolfname] howls: [message]"))

		// sound played for other players
		var/current_time = world.time // Define current_time

		if (player == src) continue
		if (get_dist(player, src) > 7) continue

		if (current_time - last_howl_sound_time < sound_cooldown) // stop ear spamming
			continue

		last_howl_sound_time = current_time
		player.playsound_local(get_turf(player), pick('sound/vo/mobs/wwolf/howldist (1).ogg','sound/vo/mobs/wwolf/howldist (2).ogg'), 100, FALSE, pressure_affected = FALSE)

	user.log_message("howls: [message] (WEREWOLF)")

/obj/effect/proc_holder/spell/self/claws
	name = "Lupine Claws"
	desc = "!"
	overlay_state = "claws"
	antimagic_allowed = TRUE
	charge_max = 20 // 2 seconds
	var/extended = FALSE

/obj/effect/proc_holder/spell/self/claws/cast(mob/user = usr)
	..()
	var/obj/item/rogueweapon/werewolf_claw/left/l
	var/obj/item/rogueweapon/werewolf_claw/right/r
	l = user.get_active_held_item()
	r = user.get_inactive_held_item()

	if (extended)
		if (istype(l, /obj/item/rogueweapon/werewolf_claw))
			user.dropItemToGround(l, TRUE)
			user.dropItemToGround(r, TRUE)
			qdel(l)
			qdel(r)
			// user.visible_message("Your claws retract.", "You feel your claws retracting.", "You hear a sound of claws retracting.")
			extended = FALSE
	else
		user.drop_all_held_items(force = TRUE)
		l = new(user)
		r = new(user)
		user.put_in_hands(l, TRUE, FALSE, TRUE)
		user.put_in_hands(r, TRUE, FALSE, TRUE)
		// user.visible_message("Your claws extend.", "You feel your claws extending.", "You hear a sound of claws extending.")
		extended = TRUE

/obj/effect/proc_holder/spell/targeted/woundlick
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Lick the wounds!"
	overlay_state = "woundlick"
	range = 1
	sound = 'sound/gore/flesh_eat_03.ogg'
	associated_skill = /datum/skill/misc/climbing
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/woundlick/cast(list/targets, mob/user)
	if(!ishuman(targets[1]))
		return
	var/mob/living/carbon/human/target = targets[1]
	if(target.mind)
		if(target.mind.has_antag_datum(/datum/antagonist/zombie))
			to_chat(src, span_warning("I shall not lick it..."))
			return
		if(target.mind.has_antag_datum(/datum/antagonist/vampirelord))
			to_chat(src, span_warning("... What? It's an elder vampire!"))
			return
	if(!do_after(user, 7 SECONDS, target = target))
		return
	target.reagents.add_reagent(/datum/reagent/medicine/healthpot, 20)
	target.reagents.add_reagent(/datum/reagent/medicine/stimu, 10)
	if(target.mind.has_antag_datum(/datum/antagonist/werewolf))
		target.visible_message(span_green("[user] is licking [target]'s wounds with its tongue!"), span_notice("My kin has covered my wounds..."))
		target.reagents.add_reagent(/datum/reagent/water, 20)
	else
		target.visible_message(span_green("[user] is licking [target]'s wounds with its tongue!"), span_notice("That thing... Did it lick my wounds?"))
		target.reagents.add_reagent(/datum/reagent/water/gross, 5)
		target.reagents.add_reagent(/datum/reagent/water, 10)
		if(prob(10))
			target.werewolf_infect_attempt(CHEST)
