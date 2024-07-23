/datum/mob_descriptor/prominent
	abstract_type = /datum/mob_descriptor/prominent
	slot = MOB_DESCRIPTOR_SLOT_PROMINENT

/datum/mob_descriptor/prominent/hunched_over
	name = "Hunched Over"
	verbage = "is"

/datum/mob_descriptor/prominent/crooked_nose
	name = "Crooked Nose"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/drooling
	name = "Drooling"
	verbage = "is"

/datum/mob_descriptor/prominent/lazy_eye
	name = "Lazy Eye"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/bloodshot_eye
	name = "Bloodshot Eyes"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/baggy_eye
	name = "Baggy Eyes"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/deadfish_eye
	name = "Dead Fish Eyes"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/twitchy
	name = "Twitchy"
	verbage = "is"

/datum/mob_descriptor/prominent/clumsy
	name = "Clumsy"
	verbage = "is"

/datum/mob_descriptor/prominent/unkempt
	name = "Unkempt"
	verbage = "is"

/datum/mob_descriptor/prominent/tidy
	name = "Tidy"
	verbage = "is"

/datum/mob_descriptor/prominent/eloquent
	name = "Eloquent"
	verbage = "is"

/datum/mob_descriptor/prominent/thick_tail
	name = "Thick Tail"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/thick_tail/can_describe(mob/living/described)
	if(!ishuman(described))
		return TRUE
	var/mob/living/carbon/human/human = described
	if(!human.getorganslot(ORGAN_SLOT_TAIL))
		return FALSE
	return TRUE

/datum/mob_descriptor/prominent/cleft_lip
	name = "Cleft Lip"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/physically_deformed
	name = "Physically Deformed"
	verbage = "is"

/datum/mob_descriptor/prominent/extensive_scars
	name = "Extensive Scarring"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/move_strange
	name = "Moves Strangely"

/datum/mob_descriptor/prominent/ghoulish_appearance
	name = "Ghoulish Appearance"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/prominent_chest
	name = "Prominent Chest"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/prominent_bottom
	name = "Prominent Posterior"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/prominent_potbelly
	name = "Prominent Potbelly"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/prominent_thighs
	name = "Prominent Thighs"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/prominent_shoulders
	name = "Prominent Shoulders"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/prominent_jawline
	name = "Prominent Jawline"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/cold_gaze
	name = "Cold Gaze"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/piercing_gaze
	name = "Piercing Gaze"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/innocent_gaze
	name = "Innocent Gaze"
	verbage = "%HAVE%"
	prefix = "an"

/datum/mob_descriptor/prominent/promiscuous_mannerisms
	name = "Sensual Manners"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/intimidating_presence
	name = "Intimidating Presence"
	verbage = "%HAVE%"
	prefix = "an"

/datum/mob_descriptor/prominent/meek_presence
	name = "Meek Presence"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/adorable_presence
	name = "Adorable Presence"
	verbage = "%HAVE%"
	prefix = "an"

/datum/mob_descriptor/prominent/lordly_presence
	name = "Lordly Presence"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/doting_presence
	name = "Doting Presence"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/aristocratic_haughtiness
	name = "Aristocratic Haughtiness"
	verbage = "%HAVE%"
	prefix = "an"

/datum/mob_descriptor/prominent/ghastly_pale
	name = "Ghastly Pale"
	verbage = "is"

/datum/mob_descriptor/prominent/elaborate_tattoos
	name = "Elaborate Tattoos"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/ritual_tattoos
	name = "Ritual Tattoos"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/tribal_tattoos
	name = "Tribal Tattoos"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/slave_tattoos
	name = "Slave Tattoos"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/enigmatic_tattoos
	name = "Enigmatic Tattoos"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/mean_look
	name = "Mean Look"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/haughty_atmosphere
	name = "Haughty Atmosphere"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/untrustworthy
	name = "Untrustworthy"
	verbage = "appears"

/datum/mob_descriptor/prominent/ratty_hair
	name = "Ratty Hair"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/predatory_look
	name = "Predatory Look"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/chaste_mannerism
	name = "Chaste Mannerisms"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/whimsy
	name = "Air of Whimsy"
	verbage = "%HAVE%"
	prefix = "an"
	suffix = "about %HIM%"

/datum/mob_descriptor/prominent/dim_look
	name = "Dim Look"
	verbage = "%HAVE%"
	prefix = "a"
