/*
Within this file:
 - Burden
 - Divine Smite
 - Hellish Rebuke
*/

//Burden - Intended to allow a Ravox Paladin/Templar to slow someone enough to catch them if they flee.
//Might need to tweak how long this lasts. Twelve seconds.
/obj/effect/proc_holder/spell/invoked/burden
	name = "Burden"
	overlay_state = "hierophant"
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/timestop.ogg'
	invocation = "In Ravox's name, stand and fight, coward!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	miracle = TRUE
	charge_max = 30 SECONDS
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/burden/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	spelltarget.apply_status_effect(/datum/status_effect/debuff/ravox_burden)

	if(spelltarget != user)
		user.visible_message("[user] shouts an incantation, causing [spelltarget] to go stiff!")
	else
		user.visible_message("[user] shouts an incantation as they slow to a crawl.")

	return TRUE

//Divine Smite - Allows the user to imbue their weapon with hellfire briefly.
//Stronger strikes, basically. Two seconds.

//Hellish Rebuke - Enables the user to shield themselves, causing anyone striking them to burst into flames.
//A stupid strong shielding spell, balanced by the fact that it only lasts two seconds.
