/datum/antagonist/zombie
	name = "Deadite"
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "zombie"
	show_in_roundend = FALSE
	var/zombie_start
	var/revived = FALSE
	// CACHE VARIABLES SO ZOMBIFICATION CAN BE CURED
	var/was_i_undead = FALSE
	var/special_role
	var/ambushable = TRUE
	var/soundpack_m
	var/soundpack_f
	var/stored_skills
	var/stored_experience 

	var/STASTR
	var/STASPD
	var/STAINT
	var/STACON
	var/STAEND

	var/cmode_music
	var/datum/patron/patron
	var/list/base_intents
	/// Whether or not we have been turned
	var/has_turned = FALSE

	rogue_enabled = TRUE

/datum/antagonist/zombie/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/vampirelord))
		var/datum/antagonist/vampirelord/V = examined_datum
		if(!V.disguised)
			return span_boldnotice("Another deadite.")
	if(istype(examined_datum, /datum/antagonist/zombie))
		var/datum/antagonist/zombie/fellow_zombie = examined_datum
		return span_boldnotice("Another deadite. [fellow_zombie.has_turned ? "My ally." : span_warning("Hasn't turned yet.")]")
	if(istype(examined_datum, /datum/antagonist/skeleton))
		return span_boldnotice("Another deadite.")

/datum/antagonist/zombie/on_gain()
	var/mob/living/carbon/human/zombie = owner?.current
	if(zombie)
		var/obj/item/bodypart/head = zombie.get_bodypart(BODY_ZONE_HEAD)
		if(!head)
			qdel(src)
			return
	zombie_start = world.time
	was_i_undead = zombie.mob_biotypes & MOB_UNDEAD
	special_role = zombie.mind?.special_role
	ambushable = zombie.ambushable
	if(zombie.dna?.species)
		soundpack_m = zombie.dna.species.soundpack_m
		soundpack_f = zombie.dna.species.soundpack_f
	base_intents = zombie.base_intents
	cmode_music = zombie.cmode_music
	patron = zombie.patron

	STASTR = zombie.STASTR
	STASPD = zombie.STASPD
	STAINT = zombie.STAINT
	STACON = zombie.STACON
	STAEND = zombie.STAEND

	stored_skills = owner.known_skills.Copy()
	stored_experience = owner.skill_experience.Copy()
	owner.known_skills = list()
	owner.skill_experience = list()


	return ..()

/datum/antagonist/zombie/on_removal()

	if(!owner.current)
		return

	var/mob/living/carbon/human/zombie = owner.current

	zombie.mind?.special_role = special_role
	zombie.ambushable = ambushable
	if(zombie.dna?.species)
		zombie.dna.species.soundpack_m = soundpack_m
		zombie.dna.species.soundpack_f = soundpack_f
	zombie.base_intents = base_intents

	owner.known_skills = stored_skills
	owner.skill_experience = stored_experience

	zombie.update_a_intents()
	zombie.aggressive = FALSE
	zombie.mode = AI_OFF
	if(zombie.charflaw)
		zombie.charflaw.ephemeral = FALSE
	zombie.update_body()
	zombie.STASTR = STASTR
	zombie.STASPD = STASPD
	zombie.STAINT = STAINT
	zombie.STACON = STACON
	zombie.STAEND = STAEND
	zombie.cmode_music = cmode_music
	zombie.set_patron(patron)

	for(var/trait in GLOB.traits_deadite)
		REMOVE_TRAIT(zombie, trait, TRAIT_GENERIC)

	zombie.remove_client_colour(/datum/client_colour/monochrome)

	if(!was_i_undead)
		zombie.mob_biotypes &= ~MOB_UNDEAD
	zombie.faction -= "undead"
	zombie.faction += "station"
	zombie.faction += "neutral"
	zombie.regenerate_organs()
	if(has_turned)
		to_chat(zombie, span_green("I no longer crave for flesh..."))
		
	for(var/obj/item/bodypart/zombie_part as anything in zombie.bodyparts)
		zombie_part.rotted = FALSE
		zombie_part.update_disabled()
		zombie_part.update_limb()
	zombie.update_body()

	// Bandaid to fix the zombie ghostizing not allowing you to re-enter

	var/mob/dead/observer/ghost = zombie.get_ghost(TRUE)
	if(ghost)
		ghost.can_reenter_corpse = TRUE

	return ..()

/// Transform the player mob into a deadite
/datum/antagonist/zombie/proc/transform_deadite()

	if(owner)
		owner.skill_experience = list()

	var/mob/living/carbon/human/zombie = owner.current
	if(!zombie)
		qdel(src)
		return

	// decapitated corpses wont transform
	var/obj/item/bodypart/head = zombie.get_bodypart(BODY_ZONE_HEAD)
	if(!head)
		qdel(src)
		return

	revived = TRUE //so we can die for real later
	zombie.add_client_colour(/datum/client_colour/monochrome)
	
	if(zombie.mind)
		special_role = zombie.mind.special_role
		zombie.mind.special_role = name
		
	if(zombie.dna?.species)
		soundpack_m = zombie.dna.species.soundpack_m
		soundpack_f = zombie.dna.species.soundpack_f

	base_intents = zombie.base_intents
	ambushable = zombie.ambushable

	if(zombie.charflaw)
		zombie.charflaw.ephemeral = TRUE

	zombie.update_body()
	zombie.cmode_music = 'sound/music/combat_weird.ogg'

	has_turned = TRUE

	// zombies cant rp, thus shouldnt be playable
	zombie.ghostize(FALSE)

/datum/antagonist/zombie/greet()
	to_chat(owner.current, span_userdanger("Death is not the end..."))
	return ..()

/datum/antagonist/zombie/on_life(mob/user)
	var/mob/living/carbon/human/deadite = owner?.current
	deadite.try_do_deadite_bite()
	deadite.try_do_deadite_idle()
	
//Infected wake param is just a transition from living to zombie, via zombie_infect()
//Previously you just died without warning in 3 minutes, now you just become an antag
/datum/antagonist/zombie/proc/wake_zombie(infected_wake = FALSE)
	testing("WAKEZOMBIE")
	if(!owner.current)
		return
	var/mob/living/carbon/human/zombie = owner.current
	if(!zombie || !istype(zombie))
		return
	var/obj/item/bodypart/head = zombie.get_bodypart(BODY_ZONE_HEAD)
	if(!head)
		qdel(src)
		return
	if(zombie.stat != DEAD && !infected_wake)
		qdel(src)
		return
	if(istype(zombie.loc, /obj/structure/closet/dirthole) || istype(zombie.loc, /obj/structure/closet/crate/coffin))
		qdel(src)
		return

	zombie.can_do_sex = FALSE

	zombie.blood_volume = BLOOD_VOLUME_NORMAL
	zombie.setOxyLoss(0, updating_health = FALSE, forced = TRUE) //zombles dont breathe
	zombie.setToxLoss(0, updating_health = FALSE, forced = TRUE) //zombles are immune to poison
	if(!infected_wake) //if we died, heal all of this too
		zombie.adjustBruteLoss(-INFINITY, updating_health = FALSE, forced = TRUE)
		zombie.adjustFireLoss(-INFINITY, updating_health = FALSE, forced = TRUE)
		zombie.heal_wounds(INFINITY) //Heal every wound that is not permanent
	zombie.stat = UNCONSCIOUS //Start unconscious
	zombie.updatehealth() //then we check if the mob should wake up
	zombie.update_mobility()
	zombie.update_sight()
	zombie.reload_fullscreen()
	transform_deadite()
	zombie.make_deadite()
	if(zombie.stat >= DEAD)
		//could not revive
		qdel(src)
