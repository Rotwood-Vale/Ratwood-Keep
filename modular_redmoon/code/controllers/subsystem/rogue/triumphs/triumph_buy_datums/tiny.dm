/datum/triumph_buy/tiny
	triumph_buy_id = "Tiny"
	desc = "Tiny! Not working on a kobold, seelie, verminvolk or a dwarf."
	triumph_cost = 10
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

// We fire this on activate, also DAMN is this nasty
/datum/triumph_buy/tiny/on_activate(mob/living/carbon/human/H)
	if(!usr)
		return
	if(usr.client.prefs.next_special_trait)
		print_special_text(usr, usr.client.prefs.next_special_trait)
		return
	var/result = alert(usr, "You'll receive a unique trait for one round\nDo I really want become Tiny?", "Be Tiny", "Yes", "No")
	if(result != "Yes")
		return
	if(usr.client.prefs.next_special_trait)
		return
	usr.client.prefs.next_special_trait = /datum/special_trait/tiny
	if(usr.client.prefs.next_special_trait)
		log_game("SPECIALS: Rolled [usr.client.prefs.next_special_trait] for ckey: [usr.ckey]")
		print_special_text(usr, usr.client.prefs.next_special_trait)
		usr.playsound_local(usr, 'sound/misc/alert.ogg', 100)
		to_chat(usr, span_warning("This will be applied on your next game join. You cannot reroll this, and it will not carry over to other rounds"))
		to_chat(usr, span_warning("You may switch your character and choose any role, if you don't meet the requirements (if any are specified) it won't be applied"))
