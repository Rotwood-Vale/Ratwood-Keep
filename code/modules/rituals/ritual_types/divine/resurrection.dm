/datum/ritual/divine/resurrection
	name = "Transference"
	circle = "Soulcrafting"

	center_requirement = /obj/item/roguecoin
	w_req = /mob/living/carbon/human
	e_req = /mob/living/carbon/human

	function = /proc/resurrect

/proc/resurrect(mob/user, turf/C)

	var/mob/living/carbon/human/Dead = null
	var/mob/living/carbon/human/Alive = null

	// Identify the dead human and the living human
	for(var/mob/living/carbon/human/H in get_step(C, EAST))
		if(H.stat != DEAD || H.client) // We dont want people to sacrifice npcs
			Alive = H
			break
		
	for(var/mob/living/carbon/human/H in get_step(C, WEST))
		if(H.stat == DEAD)
			Dead = H
			break

	if(!Dead || !Alive)
		return

	Alive.death(FALSE)
	ADD_TRAIT(Alive, TRAIT_RITUALIZED, TRAIT_GENERIC)
	
	// Code mostly taken from the old revive, no guarantee it does everything it should
	var/mob/living/carbon/spirit/underworld_spirit = Dead.get_spirit()
	if(underworld_spirit)
		var/mob/dead/observer/ghost = underworld_spirit.ghostize()
		qdel(underworld_spirit)
		ghost.mind.transfer_to(Dead, TRUE)

	Dead.grab_ghost(force = TRUE) // even suicides
	Dead.revive(admin_revive = TRUE)
	Dead.emote("breathgasp")
	Dead.Jitter(100)

	// Remove the ritualized trait from the resurrected person, in case they died to the same ritual. This also makes sure cpr will work on them if they die after the ritual.
	if(HAS_TRAIT(Dead, TRAIT_RITUALIZED))
		REMOVE_TRAIT(Dead, TRAIT_RITUALIZED, TRAIT_GENERIC)

	// Seelie stuff
	if(isseelie(Dead))
		var/datum/species/seelie/seelie = Dead.dna.species
		seelie.regenerate_wings()

	Dead.update_body()
	Dead.visible_message(span_notice("[Dead] is revived!"), span_green("I awake from the void."))
	Dead.playsound_local(Dead, 'sound/misc/vampirespell.ogg', 100)
	Dead.mind?.remove_antag_datum(/datum/antagonist/zombie)

