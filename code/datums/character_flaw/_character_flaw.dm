
GLOBAL_LIST_INIT(character_flaws, list("Alcoholic"=/datum/charflaw/addiction/alcoholic,
	"Devout Follower"=/datum/charflaw/addiction/godfearing,
	"Nymphomaniac"=/datum/charflaw/addiction/lovefiend,
	"Smoker"=/datum/charflaw/addiction/smoker,
	"Junkie"=/datum/charflaw/addiction/junkie,
	"Leper"=/datum/charflaw/rotten,
	"Cyclops (R)"=/datum/charflaw/noeyer,
	"Cyclops (L)"=/datum/charflaw/noeyel,
	"Wood Arm (R)"=/datum/charflaw/limbloss/arm_r,
	"Wood Arm (L)"=/datum/charflaw/limbloss/arm_l,
	"Bad Sight"=/datum/charflaw/badsight,
	"Paranoid"=/datum/charflaw/paranoid,
	"Clingy"=/datum/charflaw/clingy,
	"Isolationist"=/datum/charflaw/isolationist,
	"Fire Servant"=/datum/charflaw/addiction/pyromaniac,
	"Thief-Borne"=/datum/charflaw/addiction/kleptomaniac,
	"Pain Freek"=/datum/charflaw/addiction/masochist,
	"Random or No Flaw"=/datum/charflaw/randflaw,
	"No Flaw (3 TRIUMPHS)"=/datum/charflaw/noflaw))

/datum/charflaw
	var/name
	var/desc
	var/ephemeral = FALSE // This flaw is currently disabled and will not process

/datum/charflaw/proc/on_mob_creation(mob/user)
	return

/datum/charflaw/proc/flaw_on_life(mob/user)
	return

/mob/proc/has_flaw(flaw)
	return

/mob/living/carbon/human/has_flaw(flaw)
	if(!flaw)
		return
	if(istype(charflaw, flaw))
		return TRUE

/datum/charflaw/randflaw
	name = "Random or None"
	desc = "A 50% chance to be given a random flaw, or a 50% chance to have NO flaw."
	var/nochekk = TRUE

/datum/charflaw/randflaw/flaw_on_life(mob/user)
	if(!nochekk)
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.ckey)
			nochekk = FALSE
			if(prob(50))
				var/flawz = GLOB.character_flaws.Copy()
				var/charflaw = pick_n_take(flawz)
				charflaw = GLOB.character_flaws[charflaw]
				if((charflaw == type) || (charflaw == /datum/charflaw/noflaw))
					charflaw = pick_n_take(flawz)
					charflaw = GLOB.character_flaws[charflaw]
				if((charflaw == type) || (charflaw == /datum/charflaw/noflaw))
					charflaw = pick_n_take(flawz)
					charflaw = GLOB.character_flaws[charflaw]
				H.charflaw = new charflaw()
				H.charflaw.on_mob_creation(H)
			else
				H.charflaw = new /datum/charflaw/eznoflaw()
				H.charflaw.on_mob_creation(H)


/datum/charflaw/eznoflaw
	name = "No Flaw"
	desc = "I'm a normal person, how rare!"

/datum/charflaw/noflaw
	name = "No Flaw (3 TRI)"
	desc = "I'm a normal person, how rare! (Consumes 3 triumphs or gives a random flaw.)"
	var/nochekk = TRUE

/datum/charflaw/noflaw/flaw_on_life(mob/user)
	if(!nochekk)
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.ckey)
			if(H.get_triumphs() < 3)
				nochekk = FALSE
				var/flawz = GLOB.character_flaws.Copy()
				var/charflaw = pick_n_take(flawz)
				charflaw = GLOB.character_flaws[charflaw]
				if((charflaw == type) || (charflaw == /datum/charflaw/randflaw))
					charflaw = pick_n_take(flawz)
					charflaw = GLOB.character_flaws[charflaw]
				if((charflaw == type) || (charflaw == /datum/charflaw/randflaw))
					charflaw = pick_n_take(flawz)
					charflaw = GLOB.character_flaws[charflaw]
				H.charflaw = new charflaw()
				H.charflaw.on_mob_creation(H)
			else
				nochekk = FALSE
				H.adjust_triumphs(-3)

/datum/charflaw/badsight
	name = "Bad Eyesight"
	desc = "I need spectacles to see normally from my years spent reading books."

/datum/charflaw/badsight/on_mob_creation(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)

/datum/charflaw/badsight/flaw_on_life(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.wear_mask)
		if(isclothing(H.wear_mask))
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/spectacles))
				var/obj/item/I = H.wear_mask
				if(!I.obj_broken)
					return
	H.blur_eyes(2)
	H.apply_status_effect(/datum/status_effect/debuff/badvision)

/datum/status_effect/debuff/badvision
	id = "badvision"
	alert_type = null
	effectedstats = list("perception" = -20, "speed" = -5)
	duration = 100

/datum/charflaw/badsight/on_mob_creation(mob/user)
	..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(!H.wear_mask)
		H.equip_to_slot_or_del(new /obj/item/clothing/mask/rogue/spectacles(H), SLOT_WEAR_MASK)
	else
		new /obj/item/clothing/mask/rogue/spectacles(get_turf(H))

/datum/charflaw/paranoid
	name = "Paranoid"
	desc = "I'm even more anxious than most people. I'm extra paranoid of other races and the sight of blood."
	var/last_check = 0

/datum/charflaw/paranoid/flaw_on_life(mob/user)
	if(world.time < last_check + 10 SECONDS)
		return
	if(!user)
		return
	last_check = world.time
	var/cnt = 0
	for(var/mob/living/carbon/human/L in hearers(7, user))
		if(L == src)
			continue
		if(L.stat)
			continue
		if(L.dna?.species)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				if(L.dna.species.id != H.dna.species.id)
					cnt++
		if(cnt > 2)
			break
	if(cnt > 2)
		user.add_stress(/datum/stressevent/paracrowd)
	cnt = 0
	for(var/obj/effect/decal/cleanable/blood/B in view(7, user))
		cnt++
		if(cnt > 3)
			break
	if(cnt > 6)
		user.add_stress(/datum/stressevent/parablood)

/datum/charflaw/isolationist
	name = "Isolationist"
	desc = "I don't like being near people. They might be trying to do something to me..."
	var/last_check = 0

/datum/charflaw/isolationist/flaw_on_life(mob/user)
	. = ..()
	if(world.time < last_check + 10 SECONDS)
		return
	if(!user)
		return
	last_check = world.time
	var/cnt = 0
	for(var/mob/living/carbon/human/L in hearers(7, user))
		if(L == src)
			continue
		if(L.stat)
			continue
		if(L.dna.species)
			cnt++
		if(cnt > 3)
			break
	var/mob/living/carbon/P = user
	if(cnt > 3)
		P.add_stress(/datum/stressevent/crowd)

/datum/charflaw/clingy
	name = "Clingy"
	desc = "I like being around people, it's just so lively..."
	var/last_check = 0

/datum/charflaw/clingy/flaw_on_life(mob/user)
	. = ..()
	if(world.time < last_check + 10 SECONDS)
		return
	if(!user)
		return
	last_check = world.time
	var/cnt = 0
	for(var/mob/living/carbon/human/L in hearers(7, user))
		if(L == src)
			continue
		if(L.stat)
			continue
		if(L.dna.species)
			cnt++
		if(cnt > 2)
			break
	var/mob/living/carbon/P = user
	if(cnt < 2)
		P.add_stress(/datum/stressevent/nopeople)

/datum/charflaw/noeyer
	name = "Cyclops (R)"
	desc = "I lost my right eye long ago."

/datum/charflaw/noeyer/on_mob_creation(mob/user)
	..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(!H.wear_mask)
		H.equip_to_slot_or_del(new /obj/item/clothing/mask/rogue/eyepatch(H), SLOT_WEAR_MASK)
	var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
	head?.add_wound(/datum/wound/facial/eyes/right/permanent)
	H.update_fov_angles()

/datum/charflaw/noeyel
	name = "Cyclops (L)"
	desc = "I lost my left eye long ago."

/datum/charflaw/noeyel/on_mob_creation(mob/user)
	..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(!H.wear_mask)
		H.equip_to_slot_or_del(new /obj/item/clothing/mask/rogue/eyepatch/left(H), SLOT_WEAR_MASK)
	var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
	head?.add_wound(/datum/wound/facial/eyes/left/permanent)
	H.update_fov_angles()

/datum/charflaw/rotten
    name = "Leprosy"
    desc = "I am cursed, or blessed as some would say, with leprosy. Sometimes I lose control of my limbs, and suffer with constant sickness. Society shuns me for the disease riddled creature I have devolved into."
/datum/charflaw/rotten/on_mob_creation(mob/user)
	..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(!H.wear_mask)
		H.equip_to_slot_or_del(new /obj/item/clothing/mask/rogue/lepermask(H), SLOT_WEAR_MASK)
 H.apply_status_effect(STATUS_EFFECT_SPASMS)
 H.apply_status_effect(STATUS_EFFECT_FAKE_VIRUS)
