GLOBAL_DATUM_INIT(ssd_indicator, /mutable_appearance, mutable_appearance('modular_hearthstone/icons/mob/ssd_indicator.dmi', "default0", FLY_LAYER))

/mob/living/proc/set_ssd_indicator(state)
	if(state && stat != DEAD)
		add_overlay(GLOB.ssd_indicator)
	else
		cut_overlay(GLOB.ssd_indicator)
	return state

