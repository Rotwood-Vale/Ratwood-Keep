//This datum is quite close to the sprite accessory one, containing a bit of copy pasta code
//Those DO NOT have a customizable cases for rendering, or any special stuff, and are meant to be simpler than accessories
//One definition can stand for a whole set of accessories, make sure to set affected bodyparts
/datum/body_marking
	///The icon file the body markign is located in
	var/icon
	///The icon_state of the body marking
	var/icon_state
	///The preview name of the body marking. NEEDS A UNIQUE NAME
	var/name
	///The color the marking defaults to, important for randomisations. either a hex color ie."FFF" or a define like DEFAULT_PRIMARY
	var/default_color
	///Which bodyparts does the marking affect in BITFLAGS!! (HEAD, CHEST, ARM_LEFT, ARM_RIGHT, HAND_LEFT, HAND_RIGHT, LEG_RIGHT, LEG_LEFT)
	var/affected_bodyparts
	///Whether the body marking sprite is the same for both sexes or not. Only relevant for chest right now.
	var/gendered = TRUE
	/// Whether the gendering affects only the chest bodypart
	var/gender_only_chest = FALSE
	/// Whether the chest marking covers the chest, for purposes of color derriving for features
	var/covers_chest = FALSE

/datum/body_marking/New()
	if(!default_color)
		default_color = "FFF"

/datum/body_marking/proc/get_default_color(list/features, datum/species/pref_species) //Needs features for the color information
	var/list/colors
	switch(default_color)
		if(DEFAULT_PRIMARY)
			colors = features["mcolor"]
		if(DEFAULT_SECONDARY)
			colors = features["mcolor2"]
		if(DEFAULT_TERTIARY)
			colors = features["mcolor3"]
		if(DEFAULT_SKIN_OR_PRIMARY)
			if(pref_species && pref_species.use_skintones)
				colors = features["skin_color"]
			else
				colors = features["mcolor"]
		else
			colors = default_color

	return colors

/datum/body_marking/plain
	icon = 'icons/mob/body_markings/plain_markings.dmi'
	name = "Plain"
	icon_state = "plain"
	affected_bodyparts = HEAD | CHEST | HAND_LEFT | HAND_RIGHT | ARM_LEFT | ARM_RIGHT | LEG_LEFT | LEG_RIGHT
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/tiger
	icon = 'icons/mob/body_markings/tiger_markings.dmi'
	name = "Tiger"
	icon_state = "ltiger"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | LEG_LEFT | LEG_RIGHT
	default_color = DEFAULT_SECONDARY

/datum/body_marking/tiger/dark
	name = "Tiger (Dark)"
	default_color = "444444"

/datum/body_marking/sock
	icon = 'icons/mob/body_markings/sock_markings.dmi'
	name = "Sock"
	icon_state = "sock"
	affected_bodyparts = HAND_LEFT | HAND_RIGHT | LEG_LEFT | LEG_RIGHT
	default_color = DEFAULT_SECONDARY

/datum/body_marking/sock/tertiary
	name = "Sock (Tertiary)"
	default_color = DEFAULT_TERTIARY

/datum/body_marking/socklonger
	icon = 'icons/mob/body_markings/sock_markings.dmi'
	name = "Sock (Longer)"
	icon_state = "socklonger"
	affected_bodyparts = ARM_LEFT | ARM_RIGHT | LEG_LEFT | LEG_RIGHT
	default_color = DEFAULT_SECONDARY

/datum/body_marking/tips
	icon = 'icons/mob/body_markings/tips_markings.dmi'
	name = "Tips"
	icon_state = "tips"
	affected_bodyparts = HAND_LEFT | HAND_RIGHT | LEG_LEFT | LEG_RIGHT
	default_color = DEFAULT_SECONDARY

/datum/body_marking/bellyscale
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Belly Scales"
	icon_state = "bellyscale"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/kobold_scale
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Kobold Scales"
	icon_state = "kobold_scale"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/bellyscaleslim
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Belly Scales (Slim)"
	icon_state = "bellyscaleslim"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/bellyscalesmooth
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Belly Scales (Smooth)"
	icon_state = "bellyscalesmooth"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/bellyscaleslimsmooth
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Belly Scales (Slim, Smooth)"
	icon_state = "bellyscaleslimsmooth"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/buttscale
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Butt Scales"
	icon_state = "buttscale"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY

/datum/body_marking/belly
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Belly"
	icon_state = "belly"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/bellyslim
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Belly (Slim)"
	icon_state = "bellyslim"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/butt
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Butt"
	icon_state = "butt"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY

/datum/body_marking/tie
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Tie"
	icon_state = "tie"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/tiesmall
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Tie (Small)"
	icon_state = "tiesmall"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/backspots
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Back Spots"
	icon_state = "backspots"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY

/datum/body_marking/front
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Front"
	icon_state = "front"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE

/datum/body_marking/tonage
	icon = 'icons/mob/body_markings/other_markings.dmi'
	name = "Tonage"
	icon_state = "tonage"
	affected_bodyparts = CHEST
	default_color = "555555"

/datum/body_marking/drake_eyes
	icon = 'icons/mob/body_markings/other_markings.dmi'
	name = "Drake Eyes"
	icon_state = "drake_eyes"
	affected_bodyparts = HEAD
	default_color = "FF0000"
