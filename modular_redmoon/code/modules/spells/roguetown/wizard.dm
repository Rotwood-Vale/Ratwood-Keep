/obj/effect/proc_holder/spell/invoked/global_message
	name = "Global Message"
	desc = "Latch onto the mind of one who is familiar to you, whispering a message into their head."
	cost = 6
	xp_gain = TRUE
	releasedrain = 30
	chargedrain = 1
	chargetime = 15 SECONDS
	charge_max = 60 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "message"

/obj/effect/proc_holder/spell/invoked/global_message/cast(list/targets, mob/user)
	. = ..()
	var/inputty = input("Make an announcement", "ROGUETOWN") as text|null
	if(!inputty)
		return
	if(inputty)
		priority_announce("[inputty]", title = "The Magician Speaks", sound = 'sound/misc/surrender.ogg')
	else
		revert_cast()
