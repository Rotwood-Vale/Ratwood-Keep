/datum/triumph_buy/on_buy()
	log_game("[usr] активирует [src].")
	message_admins("[usr] активирует [src].")
	. = ..()
