/datum/charflaw/notongue
	name = "No tongue"
	desc = "I lost my tongue long ago."

/datum/charflaw/notongue/on_mob_creation(mob/user)
	..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
	head?.add_wound(/datum/wound/facial/tongue)
	H.update_fov_angles()
