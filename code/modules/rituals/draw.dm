
// I could not bother to modularize these

/mob/living/carbon/human/proc/draw_sigil_zizo()
	set name = "Draw Zizoite Sigil"
	set category = "RITUALS"

	var/list/runes = list("Servantry", "Transmutation", "Fleshcrafting")

	if(!bloody_hands)
		to_chat(src, span_danger("My hands aren't bloody enough."))
		return

	var/input = input("Sigil Type", "RATWOOD") as null|anything in runes
	if(!input)
		return

	var/turf/open/floor/T = get_turf(src.loc)
	T.generateSigils(src, "ZIZO", input)

/mob/living/carbon/human
	COOLDOWN_DECLARE(draw_sigil_divine)

/mob/living/carbon/human/proc/draw_sigil_divine()
	set name = "Draw Divine Sigil"
	set category = "RITUALS"

	if(!COOLDOWN_FINISHED(src, draw_sigil_divine))
		to_chat(src, span_warning("I am not ready to draw another sigil."))
		return

	var/list/runes = list("Soulcrafting")

	var/input = input("Sigil Type", "RATWOOD") as null|anything in runes
	if(!input)
		return

	var/turf/open/floor/T = get_turf(src.loc)

	// Only one successfully drawn sigil per half hour
	if(T.generateSigils(src, "DIVINE", input))
		COOLDOWN_START(src, draw_sigil_divine, 30 MINUTES)
	


