/datum/wound/nose
	name = "rhinotomy"
	check_name = "<span class='warning'>NOSE</span>"
	crit_message = list(
		"The nose is mangled beyond recognition!",
		"The nose is destroyed!",
	)
	sound_effect = 'sound/combat/crit.ogg'
	whp = null
	woundpain = 20
	mob_overlay = "cut"
	can_sew = FALSE
	critical = TRUE

/datum/wound/nose/on_mob_gain(mob/living/affected)
	. = ..()
	ADD_TRAIT(affected, TRAIT_MISSING_NOSE, "[type]")
	ADD_TRAIT(affected, TRAIT_DISFIGURED, "[type]")
	if(HAS_TRAIT(affected, TRAIT_CRITICAL_WEAKNESS))
		affected.death()

/datum/wound/nose/on_mob_loss(mob/living/affected)
	. = ..()
	REMOVE_TRAIT(affected, TRAIT_MISSING_NOSE, "[type]")
	REMOVE_TRAIT(affected, TRAIT_DISFIGURED, "[type]")
	
/datum/wound/cbt
	name = "testicular torsion"
	check_name = "<span class='userdanger'><B>NUTCRACK</B></span>"
	crit_message = list(
		"The testicles are twisted!",
		"The testicles are torsioned!",
	)
	whp = 50
	woundpain = 100
	mob_overlay = ""
	sewn_overlay = ""
	can_sew = FALSE
	disabling = TRUE
	critical = TRUE

/datum/wound/cbt/can_stack_with(datum/wound/other)
	if(istype(other, /datum/wound/cbt))
		return FALSE
	return TRUE

/datum/wound/cbt/on_mob_gain(mob/living/affected)
	. = ..()
	affected.emote("groin", forced = TRUE)
	affected.Stun(20)
	to_chat(affected, "<span class='userdanger'>Something twists inside my groin!</span>")
	if(affected.gender != MALE)
		name = "ovarian torsion"
		check_name = "<span class='userdanger'><B>EGGCRACK</B></span>"
		crit_message = list(
			"The ovaries are twisted!",
			"The ovaries are torsioned!",
		)
	else
		name = "testicular torsion"
		check_name = "<span class='userdanger'><B>NUTCRACK</B></span>"
		crit_message = list(
			"The testicles are twisted!",
			"The testicles are torsioned!",
		)
	if(HAS_TRAIT(affected, TRAIT_CRITICAL_WEAKNESS))
		affected.death()

/datum/wound/cbt/on_life()
	. = ..()
	if(!iscarbon(owner))
		return
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner.stat && prob(5))
		carbon_owner.vomit(1, stun = TRUE)

/datum/wound/cbt/smite
	name = "testicular evisceration"
	crit_message = list(
		"The testicles are destroyed!",
		"The testicles are eviscerated!",
	)
	whp = null

/datum/wound/cbt/smite/on_mob_gain(mob/living/affected)
	. = ..()
	if(affected.gender != MALE)
		name = "ovarian evisceration"
		check_name = "<span class='userdanger'><B>EGGCRACK</B></span>"
		crit_message = list(
			"The ovaries are destroyed!",
			"The ovaries are eviscerated!",
		)
	else
		name = "testicular evisceration"
		check_name = "<span class='userdanger'><B>NUTCRACK</B></span>"
		crit_message = list(
			"The testicles are destroyed!",
			"The testicles are eviscerated!",
		)
