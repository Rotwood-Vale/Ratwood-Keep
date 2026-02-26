
GLOBAL_LIST_INIT(character_flaws, list(
	"Alcoholic"=/datum/charflaw/addiction/alcoholic,
	"Annoying Face"=/datum/charflaw/annoying_face,
	"Asundered Mind (+1 TRI)"=/datum/charflaw/mind_broken,
	"Bad Sight (+1 TRI)"=/datum/charflaw/badsight,
	"Blindness (+1 TRI)"=/datum/charflaw/noeyeall,
	"Clingy"=/datum/charflaw/clingy,
	"Colorblind (+1 TRI)"=/datum/charflaw/colorblind,
	"Critical Weakness (+1 TRI)"=/datum/charflaw/critweakness,
	"Cyclops (L) (+1 TRI)"=/datum/charflaw/noeyel,
	"Cyclops (R) (+1 TRI)"=/datum/charflaw/noeyer,
	"Devout Follower"=/datum/charflaw/addiction/godfearing,
	"Greedy"=/datum/charflaw/greedy,
	"Hunted (+1 TRI)"=/datum/charflaw/hunted,
	"Isolationist"=/datum/charflaw/isolationist,
	"Junkie"=/datum/charflaw/addiction/junkie,
	"Leper (+1 TRIUMPHS)"=/datum/charflaw/leprosy,
	"Marked by Baotha" =/datum/charflaw/marked_by_baotha,
	"Leper (+1 TRI)"=/datum/charflaw/leprosy,
	"Masochist"=/datum/charflaw/addiction/masochist,
	"Missing Nose"=/datum/charflaw/missing_nose,
	"Mute (+1 TRI)"=/datum/charflaw/mute,
	"Narcoleptic (+1 TRI)"=/datum/charflaw/narcoleptic,
	"No Flaw (-3 TRI)"=/datum/charflaw/noflaw,
	"Nude Sleeper"=/datum/charflaw/nude_sleeper,
	"Nudist"=/datum/charflaw/nudist,
	"Nymphomaniac"=/datum/charflaw/addiction/lovefiend,
	"Pacifism"=/datum/charflaw/pacifism,
	"Paranoid"=/datum/charflaw/paranoid,
	"Random or No Flaw"=/datum/charflaw/randflaw,
	"Sadist"=/datum/charflaw/addiction/sadist,
	"Scarred"=/datum/charflaw/scarred,
	"Silver Weakness"=/datum/charflaw/silverweakness,
	"Sleepless (+1 TRI)"=/datum/charflaw/sleepless,
	"Smoker"=/datum/charflaw/addiction/smoker,
	"Ugly"=/datum/charflaw/ugly,
	"Unintelligible (+1 TRI)"=/datum/charflaw/unintelligible,
	"Unsettling Beauty"=/datum/charflaw/unsettling_beauty,
	"Wood Arm (L) (+1 TRI)"=/datum/charflaw/limbloss/arm_l,
	"Wood Arm (R) (+1 TRI)"=/datum/charflaw/limbloss/arm_r,
	"Hemophage (+1 TRI)"=/datum/charflaw/hemophage,
	))

/datum/charflaw
	var/name
	var/desc
	var/ephemeral = FALSE // This flaw is currently disabled and will not process

/datum/charflaw/proc/on_mob_creation(mob/user)
	return

/datum/charflaw/proc/apply_post_equipment(mob/user)
	return

/datum/charflaw/proc/flaw_on_life(mob/user)
	return

// Called when a vice is removed from a character to clean up persistent effects
/datum/charflaw/proc/on_removal(mob/user)
	return

/mob/proc/has_flaw(flaw)
	return

/mob/living/carbon/human/has_flaw(flaw)
	if(!flaw)
		return
	// Check new multiple vices system
	if(length(vices))
		for(var/datum/charflaw/vice in vices)
			if(istype(vice, flaw))
				return TRUE
	// Legacy single vice check
	if(istype(charflaw, flaw))
		return TRUE
	return FALSE

/mob/proc/get_flaw(flaw_type)
	return

/mob/living/carbon/human/get_flaw(flaw_type)
	if(!flaw_type)
		return
	// Check new multiple vices system
	if(length(vices))
		for(var/datum/charflaw/vice in vices)
			if(istype(vice, flaw_type))
				return vice
	// Legacy single vice check
	if(istype(charflaw, flaw_type))
		return charflaw
	return

/datum/charflaw/randflaw
	name = "Random or None"
	desc = "A 50% chance to be given a random flaw, or a 50% chance to have NO flaw."

/datum/charflaw/randflaw/apply_post_equipment(mob/user)
	var/mob/living/carbon/human/H = user
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
	name = "No Flaw (-3 TRI)"
	desc = "I'm a normal person, how rare! (Consumes 3 triumphs or gives a random flaw.)"

/datum/charflaw/noflaw/apply_post_equipment(mob/user)
	var/mob/living/carbon/human/H = user
	if(H.get_triumphs() < 3)
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
		H.adjust_triumphs(-3)

/datum/charflaw/badsight
	name = "Bad Eyesight"
	desc = "I need spectacles to see normally from my years spent reading books."

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
	effectedstats = list(STATKEY_PER = -20, STATKEY_SPD = -5)
	duration = 10 SECONDS

/datum/charflaw/badsight/on_mob_creation(mob/user)
	..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(!H.wear_mask)
		H.equip_to_slot_or_del(new /obj/item/clothing/mask/rogue/spectacles(H), SLOT_WEAR_MASK)
	else
		new /obj/item/clothing/mask/rogue/spectacles(get_turf(H))

	// we don't seem to have a mind when on_mob_creation fires, so set up a timer to check when we probably will
	addtimer(CALLBACK(src, PROC_REF(apply_reading_skill), H), 5 SECONDS)

/datum/charflaw/badsight/proc/apply_reading_skill(mob/living/carbon/human/H)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_triumphs(1)

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
		if(L == user)
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
		if(L == user)
			continue
		if(L.stat)
			continue
		if(L.dna.species)
			cnt++
		if(cnt > 1)
			break
	var/mob/living/carbon/P = user
	if(cnt < 1)
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
	H.adjust_triumphs(1)

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
	H.adjust_triumphs(1)

/datum/charflaw/noeyeall
	name = "Blindness"
	desc = "I lost both of my eyes long ago."

/datum/charflaw/noeyeall/on_mob_creation(mob/user)
	..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	var/obj/item/woodstaff = new /obj/item/rogueweapon/woodstaff(get_turf(H))
	H.put_in_hands(woodstaff, forced = TRUE)
	if(!H.wear_mask)
		H.equip_to_slot_or_del(new /obj/item/clothing/glasses/blindfold(H), SLOT_WEAR_MASK)
	var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
	head?.add_wound(/datum/wound/facial/eyes/left/permanent)
	head?.add_wound(/datum/wound/facial/eyes/right/permanent)
	H.update_fov_angles()
	H.adjust_triumphs(1)

/datum/charflaw/colorblind
	name = "Colorblind"
	desc = "I was cursed with flawed eyesight from birth, and can't discern things others can. Incompatible with Night-eyed virtue."

/datum/charflaw/colorblind/on_mob_creation(mob/user)
	..()
	user.add_client_colour(/datum/client_colour/monochrome)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.adjust_triumphs(1)

/datum/charflaw/hunted
	name = "Hunted"
	desc = "Something in my past has made me a target. I'm always looking over my shoulder."
	var/logged = FALSE

/datum/charflaw/hunted/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.adjust_triumphs(1)

/datum/charflaw/ugly
	name = "Ugly"
	desc = "My face is ugly and makes everyone who looks at me miserable. Incompatible with Beautiful virtue."

/datum/charflaw/ugly/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_UNSEEMLY, TRAIT_GENERIC)

/datum/charflaw/ugly/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_UNSEEMLY, TRAIT_GENERIC)

/datum/charflaw/nudist
	name = "Nudist"
	desc = "I refuse to wear clothes. They are a hindrance to my freedom."

/datum/charflaw/nudist/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_NUDIST, TRAIT_GENERIC)

/datum/charflaw/nudist/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_NUDIST, TRAIT_GENERIC)

/datum/charflaw/inhumen_anatomy
	name = "Inhumen Anatomy"
	desc = "My anatomy is inhumen, preventing me from wearing hats and shoes."

/datum/charflaw/inhumen_anatomy/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_INHUMEN_ANATOMY, TRAIT_GENERIC)

/datum/charflaw/inhumen_anatomy/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_INHUMEN_ANATOMY, TRAIT_GENERIC)

/datum/charflaw/missing_nose
	name = "Missing Nose"
	desc = "I struggle to breathe. My stamina regeneration is halved."

/datum/charflaw/missing_nose/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_MISSING_NOSE, TRAIT_GENERIC)

/datum/charflaw/missing_nose/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_MISSING_NOSE, TRAIT_GENERIC)

/datum/charflaw/disfigured
	name = "Disfigured"
	desc = "No one can recognize me. My face has been permanently altered."

/datum/charflaw/disfigured/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_DISFIGURED, TRAIT_GENERIC)

/datum/charflaw/disfigured/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_DISFIGURED, TRAIT_GENERIC)

/datum/charflaw/pacifism
	name = "Pacifism"
	desc = "I cannot harm another living being."

/datum/charflaw/pacifism/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_PACIFISM, TRAIT_GENERIC)

/datum/charflaw/pacifism/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_PACIFISM, TRAIT_GENERIC)

/datum/charflaw/annoying_face
	name = "Annoying Face"
	desc = "I am cursed with an odd voice and appearance."

/datum/charflaw/annoying_face/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_COMICSANS, TRAIT_GENERIC)

/datum/charflaw/annoying_face/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_COMICSANS, TRAIT_GENERIC)

/datum/charflaw/eerie_beauty
	name = "Eerie Beauty"
	desc = "Some would say my visage is an artwork created by the gods themselves; others call me an unsettling abomination. Incompatible with Socialite virtue."

/datum/charflaw/eerie_beauty/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_BEAUTIFUL_UNCANNY, TRAIT_GENERIC)

/datum/charflaw/eerie_beauty/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_BEAUTIFUL_UNCANNY, TRAIT_GENERIC)

/datum/charflaw/nude_sleeper
	name = "Nude Sleeper"
	desc = "I can't fall asleep unless I'm nude and in bed."

/datum/charflaw/nude_sleeper/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_NUDE_SLEEPER, TRAIT_GENERIC)

/datum/charflaw/nude_sleeper/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_NUDE_SLEEPER, TRAIT_GENERIC)

/datum/charflaw/unsettling_beauty
	name = "Unsettling Beauty"
	desc = "My appearance is deeply unsettling to most. There's something profoundly wrong about my features that disturbs those who look upon me. Incompatible with Socialite virtue."

/datum/charflaw/unsettling_beauty/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_UNSETTLING_BEAUTY, TRAIT_GENERIC)

/datum/charflaw/unsettling_beauty/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_UNSETTLING_BEAUTY, TRAIT_GENERIC)

/datum/charflaw/scarred
	name = "Scarred"
	desc = "My face bears terrible scars that make identification difficult, but not impossible."

/datum/charflaw/scarred/on_mob_creation(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ADD_TRAIT(H, TRAIT_SCARRED, TRAIT_GENERIC)

/datum/charflaw/scarred/on_removal(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		REMOVE_TRAIT(H, TRAIT_SCARRED, TRAIT_GENERIC)

/datum/charflaw/hunted/flaw_on_life(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(logged == FALSE)
		if(H.name) // If you don't check this, the log entry wont have a name as flaw_on_life is checked at least once before the name is set.
			log_hunted("[H.ckey] playing as [H.name] had the hunted flaw by vice.")
			logged = TRUE

/datum/charflaw/unintelligible
	name = "Unintelligible"
	desc = "I cannot speak the common tongue!"

/datum/charflaw/unintelligible/on_mob_creation(mob/user)
	var/mob/living/carbon/human/recipient = user
	addtimer(CALLBACK(src, .proc/unintelligible_apply, recipient), 5 SECONDS)

/datum/charflaw/unintelligible/proc/unintelligible_apply(mob/living/carbon/human/user)
	if(user.advsetup)
		addtimer(CALLBACK(src, .proc/unintelligible_apply, user), 5 SECONDS)
		return
	user.remove_language(/datum/language/common)
	user.adjust_skillrank(/datum/skill/misc/reading, -6, TRUE)
	user.adjust_triumphs(1)

/datum/charflaw/greedy
	name = "Greedy"
	desc = "I can't get enough of mammons, I need more and more! I've also become good at knowing how much things are worth"
	var/last_checked_mammons = 0
	var/required_mammons = 0
	var/next_mammon_increase = 0
	var/last_passed_check = 0
	var/first_tick = FALSE
	var/extra_increment_value = 0

/datum/charflaw/greedy/on_mob_creation(mob/user)
	next_mammon_increase = world.time + rand(15 MINUTES, 25 MINUTES)
	last_passed_check = world.time
	ADD_TRAIT(user, TRAIT_SEEPRICES_SHITTY, "[type]")

/datum/charflaw/greedy/flaw_on_life(mob/user)
	if(!first_tick)
		determine_starting_mammons(user)
		first_tick = TRUE
		return
	if(world.time >= next_mammon_increase)
		mammon_increase(user)
	mammon_check(user)

/datum/charflaw/greedy/proc/determine_starting_mammons(mob/living/carbon/human/user)
	var/starting_mammons = get_mammons_in_atom(user)
	required_mammons = round(starting_mammons * 0.7)
	extra_increment_value = round(starting_mammons * 0.15)

/datum/charflaw/greedy/proc/mammon_increase(mob/living/carbon/human/user)
	if(last_passed_check + (50 MINUTES) < world.time) //If we spend a REALLY long time without being able to satisfy, then pity downgrade
		required_mammons -= rand(10, 20)
		to_chat(user, span_blue("Maybe a little less mammons is enough..."))
	else
		required_mammons += rand(25, 35) + extra_increment_value
	required_mammons = min(required_mammons, 250) //Cap at 250 coins maximum
	next_mammon_increase = world.time + rand(35 MINUTES, 40 MINUTES)
	var/current_mammons = get_mammons_in_atom(user)
	if(current_mammons >= required_mammons)
		to_chat(user, span_blue("I'm quite happy with the amount of mammons I have..."))
	else
		to_chat(user, span_boldwarning("I need more mammons, what I have is not enough..."))

	last_checked_mammons = current_mammons

/datum/charflaw/greedy/proc/mammon_check(mob/living/carbon/human/user)
	var/new_mammon_amount = get_mammons_in_atom(user)
	var/ascending = (new_mammon_amount > last_checked_mammons)

	var/do_update_msg = TRUE
	if(new_mammon_amount >= required_mammons)
		// Feel better
		if(user.has_stress_event(/datum/stressevent/vice/greedy))
			to_chat(user, span_blue("[new_mammon_amount] mammons... That's more like it.."))
		user.remove_stress(/datum/stressevent/vice/greedy)
		user.remove_status_effect(/datum/status_effect/debuff/addiction)
		last_passed_check = world.time
		do_update_msg = FALSE
	else
		// Feel bad
		user.add_stress(/datum/stressevent/vice/greedy)
		user.apply_status_effect(/datum/status_effect/debuff/addiction)

	if(new_mammon_amount == last_checked_mammons)
		do_update_msg = FALSE

	if(do_update_msg)
		if(ascending)
			to_chat(user, span_warning("Only [new_mammon_amount] mammons.. I need more..."))
		else
			to_chat(user, span_boldwarning("No! My precious mammons..."))

	last_checked_mammons = new_mammon_amount

/datum/charflaw/narcoleptic
	name = "Narcoleptic"
	desc = "I get drowsy during the day and tend to fall asleep suddenly, but I can sleep easier if I want to, and moon dust can help me stay awake."
	var/last_unconsciousness = 0
	var/next_sleep = 0
	var/concious_timer = (10 MINUTES)
	var/do_sleep = FALSE
	var/pain_pity_charges = 3
	var/drugged_up = FALSE

/datum/charflaw/narcoleptic/on_mob_creation(mob/user)
	ADD_TRAIT(user, TRAIT_FASTSLEEP, "[type]")
	reset_timer()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.adjust_triumphs(1)

/datum/charflaw/narcoleptic/proc/reset_timer()
	do_sleep = FALSE
	last_unconsciousness = world.time
	concious_timer = rand(7 MINUTES, 15 MINUTES)
	pain_pity_charges = rand(2,4)

/datum/charflaw/narcoleptic/flaw_on_life(mob/living/carbon/human/user)
	if(user.stat != CONSCIOUS)
		reset_timer()
		return
	if(do_sleep)
		if(next_sleep <= world.time)
			var/pain = user.get_complex_pain()
			if(pain >= 40 && pain_pity_charges > 0)
				pain_pity_charges--
				concious_timer = rand(1 MINUTES, 2 MINUTES)
				to_chat(user, span_warning("The pain keeps me awake..."))
			else
				if(prob(40) || drugged_up)
					drugged_up = FALSE
					concious_timer = rand(4 MINUTES, 6 MINUTES)
					to_chat(user, span_info("The feeling has passed."))
				else
					concious_timer = rand(7 MINUTES, 15 MINUTES)
					to_chat(user, span_boldwarning("I can't keep my eyes open any longer..."))
					user.Sleeping(rand(30 SECONDS, 50 SECONDS))
					user.visible_message(span_warning("[user] suddenly collapses!"))
			do_sleep = FALSE
			last_unconsciousness = world.time
	else
		// Been conscious for ~10 minutes (whatever is the conscious timer)
		if(last_unconsciousness + concious_timer < world.time)
			drugged_up = FALSE
			to_chat(user, span_blue("I'm getting drowsy..."))
			user.emote("yawn", forced = TRUE)
			next_sleep = world.time + rand(7 SECONDS, 11 SECONDS)
			do_sleep = TRUE

/proc/narcolepsy_drug_up(mob/living/living)
	var/datum/charflaw/narcoleptic/narco = living.get_flaw(/datum/charflaw/narcoleptic)
	if(!narco)
		return
	narco.drugged_up = TRUE

/proc/get_mammons_in_atom(atom/movable/movable)
	var/static/list/coins_types = typecacheof(/obj/item/roguecoin)
	var/mammons = 0
	if(coins_types[movable.type])
		var/obj/item/roguecoin/coin = movable
		mammons += coin.quantity * coin.sellprice
	for(var/atom/movable/content in movable.contents)
		mammons += get_mammons_in_atom(content)
	return mammons

/datum/charflaw/sleepless
	name = "Insomnia"
	desc = "I do not sleep. I cannot sleep. I've tried everything."

/datum/charflaw/sleepless/on_mob_creation(mob/user)
	ADD_TRAIT(user, TRAIT_NOSLEEP, TRAIT_GENERIC)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.adjust_triumphs(1)

/datum/charflaw/mute
	name = "Mute"
	desc = "I was born without the ability to speak."

/datum/charflaw/mute/on_mob_creation(mob/user)
	ADD_TRAIT(user, TRAIT_PERMAMUTE, TRAIT_GENERIC)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.adjust_triumphs(1)

/datum/charflaw/critweakness
	name = "Critical Weakness"
	desc = "My body is as fragile as an eggshell. A critical strike is like to end me then and there."

/datum/charflaw/critweakness/on_mob_creation(mob/user)
	ADD_TRAIT(user, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.adjust_triumphs(1)

/datum/charflaw/silverweakness
	name = "Silver Weakness"
	desc = "I'm sensitive to silver — it burns and injures me more than it should."

/datum/charflaw/silverweakness/on_mob_creation(mob/user)
	ADD_TRAIT(user, TRAIT_SILVER_WEAK, TRAIT_GENERIC)

/datum/charflaw/leprosy
	name = "Leper (+1 TRI)"
	desc = "I am cursed with leprosy! Too poor to afford treatment, my skin now lays violated by lesions, my extremities are numb, and my presence disturbs even the most stalwart men."

/datum/charflaw/leprosy/apply_post_equipment(mob/user)
	var/mob/living/carbon/human/H = user
	to_chat(user, "I am afflicted. I am outcast and weak. I am a pox on this world.")
	ADD_TRAIT(user, TRAIT_LEPROSY, TRAIT_GENERIC)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_INT, -1)
	H.change_stat(STATKEY_PER, -1)
	H.change_stat(STATKEY_CON, -1)
	H.change_stat(STATKEY_WIL, -1)
	H.change_stat(STATKEY_SPD, -1)
	H.change_stat(STATKEY_LCK, -1)
	H.adjust_triumphs(1)

/datum/charflaw/mind_broken
	name = "Asundered Mind (+1 TRI)"
	desc = "My mind is asundered, wether it was by own means or an unfortunate accident. Nothing seems real to me..."

/datum/charflaw/mind_broken/apply_post_equipment(mob/living/carbon/human/insane_fool)
	insane_fool.hallucination = INFINITY
	ADD_TRAIT(insane_fool, TRAIT_PSYCHOSIS, TRAIT_GENERIC)
	insane_fool.adjust_triumphs(1)

/datum/charflaw/marked_by_baotha
	name = "Marked by Baotha"
	desc = "Whether through intentionally seeking out heretical ritualists or against my will, I have been marked by Baotha. I am branded visibly on my groin and am able to be impregnated regardless of physical states that would usually prevent this. I will need to sate my new urges often to avoid stress..."

/datum/charflaw/marked_by_baotha/on_mob_creation(mob/user)

	var/mutable_appearance/marking_overlay = mutable_appearance('icons/roguetown/misc/baotha_marking.dmi', "marking_[user.gender == "male" ? "m" : "f"]", -BODY_LAYER)
	user.add_overlay(marking_overlay)

	spawn(40)

	ADD_TRAIT(user, TRAIT_BAOTHA_FERTILITY_BOON, TRAIT_GENERIC)

	var/obj/item/organ/vagina/vagina = user.getorganslot(ORGAN_SLOT_VAGINA)
	if(vagina && !vagina.fertility)
		vagina.fertility = TRUE

	if(ishuman(user))
		var/mob/living/carbon/human/H = user

		// Add the adjusted Nymphomaniac addiction flaw
		if(!H.has_flaw(/datum/charflaw/addiction/lovefiend))
			var/datum/charflaw/addiction/lovefiend/L = new
			L.time = 45
			H.vices += L
			L.on_mob_creation(H)

/datum/charflaw/hemophage
	name = "Hemophage (+1 TRI)"
	desc = "Whether by curse or my people, blood is the only thing to keep me alive. Normal sources of nutrition and hydration will make me ill. <br>\
	<small>Any element of a virtue that modifies eating will be canceled out by Hemophage.</small>"

/datum/charflaw/hemophage/on_mob_creation(mob/living/carbon/human/vamp_wannabe)
	ADD_TRAIT(vamp_wannabe, TRAIT_HEMOPHAGE, TRAIT_GENERIC)
	ADD_TRAIT(vamp_wannabe, TRAIT_VAMPBITE, TRAIT_GENERIC)
	vamp_wannabe.adjust_triumphs(1)
