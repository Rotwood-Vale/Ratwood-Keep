
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


/mob/living/carbon/human/proc/draw_sigil_divine()
	set name = "Draw Divine Sigil"
	set category = "RITUALS"

	var/list/runes = list("Soulcrafting")

	var/input = input("Sigil Type", "RATWOOD") as null|anything in runes
	if(!input)
		return

	var/turf/open/floor/T = get_turf(src.loc)

	// Only one successfully drawn sigil per owner
	if(T.generateSigils(src, "DIVINE", input))
		verbs -= /mob/living/carbon/human/proc/draw_sigil_divine


