/datum/triumph_buy/remove_special_trait
	triumph_buy_id = "RemoveSpecialTrait"
	desc = "Remove Special Trait!"
	triumph_cost = 25
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

// We fire this on activate, also DAMN is this nasty
/datum/triumph_buy/remove_special_trait/on_activate(mob/living/carbon/human/H)
	if(!usr)
		return
	usr.client.prefs.next_special_trait = null
	usr.playsound_local(usr, 'sound/misc/alert.ogg', 100)
	to_chat(usr, span_warning("Special Trait removed."))
