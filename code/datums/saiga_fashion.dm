
//reproduces /datum/dog_fashion as /datum/saiga_fashion so that we're futureproof against someone nuking iancode in future debloats. \
it preserves the function of changing the saiga's names, description, and emotes in case some future dev wants to make use of that.

/datum/saiga_fashion
	var/name
	var/desc
	var/emote_see
	var/emote_hear
	var/speak
	var/speak_emote

	// This isn't applied to the SAIGA, but stores the icon_state of the
	// sprite that the associated item uses
	var/icon_file
	var/obj_icon_state
	var/obj_alpha
	var/obj_color

/datum/saiga_fashion/New(mob/M)
	name = replacetext(name, "REAL_NAME", M.real_name)
	desc = replacetext(desc, "NAME", name)

/datum/saiga_fashion/proc/apply(/mob/living/simple_animal/hostile/retaliate/rogue/saiga/S)
	if(name)
		S.name = name
	if(desc)
		S.desc = desc
	if(emote_see)
		S.emote_see = emote_see
	if(emote_hear)
		S.emote_hear = emote_hear
	if(speak)
		S.speak = speak
	if(speak_emote)
		S.speak_emote = speak_emote

/datum/saiga_fashion/proc/get_overlay(dir)
	if(icon_file && obj_icon_state)
		var/image/saIga = image(icon_file, obj_icon_state, dir = dir)
		saIga.alpha = obj_alpha
		saIga.color = obj_color
		return saIga
