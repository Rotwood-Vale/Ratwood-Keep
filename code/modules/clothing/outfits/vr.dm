/datum/outfit/vr
	name = "Basic VR"
	uniform = /obj/item/clothing/under/color/random
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id

/datum/outfit/vr/pre_equip(mob/living/carbon/human/H)
	H.dna.species.before_equip_job(null, H)

/datum/outfit/vr/post_equip(mob/living/carbon/human/H)
	var/obj/item/card/id/id = H.wear_ring
	if (istype(id))
		id.access |= get_all_accesses()

/datum/outfit/vr/syndicate
	name = "Syndicate VR Operative - Basic"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack
	belt = /obj/item/gun/ballistic/automatic/pistol
	l_pocket = /obj/item/paper/fluff/vr/fluke_ops
	backpack_contents = list(/obj/item/kitchen/knife/combat/survival)

/obj/item/paper/fluff/vr/fluke_ops
	name = "Where is my uplink?"
	info = "Use the radio in your backpack."
