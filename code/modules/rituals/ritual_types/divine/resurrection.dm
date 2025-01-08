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
	
	// Code mostly taken from the old revive, no guarantee it does everything it should
	var/mob/living/carbon/spirit/underworld_spirit = Dead.get_spirit()
	if(underworld_spirit)
		var/mob/dead/observer/ghost = underworld_spirit.ghostize()
		qdel(underworld_spirit)
		ghost.mind.transfer_to(Dead, TRUE)

	Dead.grab_ghost(force = TRUE) // even suicides
	Dead.emote("breathgasp")
	Dead.Jitter(100)
	Dead.revive(admin_revive = TRUE)

	// Seelie stuff
	if(isseelie(Dead))
		var/mob/living/carbon/human/fairy_target = Dead
		fairy_target.set_heartattack(FALSE)
		var/obj/item/organ/wings/Wing = fairy_target.getorganslot(ORGAN_SLOT_WINGS)
		if(Wing == null)
			var/wing_type = fairy_target.dna.species.organs[ORGAN_SLOT_WINGS]
			var/obj/item/organ/wings/seelie/new_wings = new wing_type()
			new_wings.Insert(fairy_target)

	Dead.update_body()
	Dead.visible_message(span_notice("[Dead] is revived!"), span_green("I awake from the void."))
	Dead.mind?.remove_antag_datum(/datum/antagonist/zombie)

