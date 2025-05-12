/datum/triumph_buy/eora
	triumph_buy_id = "Благословение Эоры"
	desc = "Эора милоствует лишь высоких женщин, а иные же... получат проклятье..."
	triumph_cost = 50
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

// We fire this on activate, also DAMN is this nasty
/datum/triumph_buy/eora/on_activate(mob/living/carbon/human/H)
	if(!usr)
		return
	if(usr.client.prefs.next_special_trait)
		print_special_text(usr, usr.client.prefs.next_special_trait)
		return
	usr.client.prefs.next_special_trait = /datum/special_trait/eora
	if(usr.client.prefs.next_special_trait)
		log_game("SPECIALS: Rolled [usr.client.prefs.next_special_trait] for ckey: [usr.ckey]")
		print_special_text(usr, usr.client.prefs.next_special_trait)
		usr.playsound_local(usr, 'sound/misc/alert.ogg', 100)
		to_chat(usr, span_warning("This will be applied on your next game join. You cannot reroll this, and it will not carry over to other rounds"))
		to_chat(usr, span_warning("You may switch your character and choose any role, if you don't meet the requirements (if any are specified) it won't be applied"))
