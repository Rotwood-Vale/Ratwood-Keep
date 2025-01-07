/mob/living/carbon/Life()
	set invisibility = 0

	if(notransform)
		return

	if(damageoverlaytemp)
		damageoverlaytemp = 0
		update_damage_hud()

	if(!IS_IN_STASIS(src))

		//Reagent processing needs to come before breathing, to prevent edge cases.
		handle_organs()

		. = ..()

		if (QDELETED(src))
			return
		
		handle_wounds()
		handle_embedded_objects()
		handle_blood()
		handle_roguebreath()
		handle_energy_recovery()
		handle_sleep()
		var/bprv = handle_bodyparts()
		if(bprv & BODYPART_LIFE_UPDATE_HEALTH)
			updatehealth()
		update_stress()
		handle_nausea()
		if((blood_volume > BLOOD_VOLUME_SURVIVE) || HAS_TRAIT(src, TRAIT_BLOODLOSS_IMMUNE))
			if(!heart_attacking)
				adjustOxyLoss(-1.5)
			else
				if(getOxyLoss() < 20)
					heart_attacking = FALSE
				
		if(!IsSleeping() && (mobility_flags & MOBILITY_STAND) && isseelie(src) && (haswings(src) == TRUE) && !(buckled)) //Very slop but dont know of another way
			fairy_hover()

		handle_brain_damage()

	else
		. = ..()


	check_cremation()

	//Seelie luck aura
	if(isseelie(src) && !IsSleeping())
		for(var/mob/living/carbon/human/H in view(1, src))
			if(!H || isseelie(H))
				continue
			switch(src.aura)
				if(FALSE)
					H.apply_status_effect(/datum/status_effect/buff/seelie/sad)
					H.remove_status_effect(/datum/status_effect/buff/seelie/happy)
				if(TRUE)
					H.apply_status_effect(/datum/status_effect/buff/seelie/happy)
					H.remove_status_effect(/datum/status_effect/buff/seelie/sad)

	if(stat != DEAD)
		return 1

/mob/living/carbon/DeadLife()
	set invisibility = 0

	if(notransform)
		return

	if(!IS_IN_STASIS(src))
		. = ..()
		if (QDELETED(src))
			return
		handle_wounds()
		handle_embedded_objects()
		handle_blood()

	check_cremation()

/mob/living/carbon/handle_random_events()//BP/WOUND BASED PAIN
	if(HAS_TRAIT(src, TRAIT_NOPAIN))
		return
	if(!stat)
		var/pain_threshold = STAEND * 10
		if(has_flaw(/datum/charflaw/masochist)) // Masochists handle pain better by about 1 endurance point
			pain_threshold += 10
		var/painpercent = get_complex_pain() / pain_threshold
		painpercent = painpercent * 100

		if(world.time > mob_timers["painstun"])
			mob_timers["painstun"] = world.time + 100
			var/probby = 40 - (STAEND * 2)
			probby = max(probby, 10)
			if(lying || IsKnockdown())
				if(prob(3) && (painpercent >= 80) )
					emote("painmoan")
			else
				if(painpercent >= 100)
					if(prob(probby) && !HAS_TRAIT(src, TRAIT_NOPAINSTUN))
						Immobilize(10)
						emote("painscream")
						stuttering += 5
						addtimer(CALLBACK(src, PROC_REF(Stun), 110), 10)
						addtimer(CALLBACK(src, PROC_REF(Knockdown), 110), 10)
						mob_timers["painstun"] = world.time + 160
					else
						emote("painmoan")
						stuttering += 5
				else
					if(painpercent >= 80)
						if(probby)
							emote("painmoan")

		if(painpercent >= 100)
			add_stress(/datum/stressevent/painmax)

/mob/living/carbon/proc/handle_roguebreath()
	return

/mob/living/carbon/human/handle_roguebreath()
	..()
	if(HAS_TRAIT(src, TRAIT_NOBREATH))
		return TRUE
	if(HAS_TRAIT(src, TRAIT_HOLDBREATH))
		adjustOxyLoss(5)
	if(istype(loc, /obj/structure/closet/dirthole))
		adjustOxyLoss(5)
	if(istype(loc, /obj/structure/closet/burial_shroud))
		var/obj/O = loc
		if(istype(O.loc, /obj/structure/closet/dirthole))
			adjustOxyLoss(5)
	if(isopenturf(loc))
		var/turf/open/T = loc
		if(reagents&& T.pollution)
			T.pollution.breathe_act(src)
			if(next_smell <= world.time)
				next_smell = world.time + 30 SECONDS
				T.pollution.smell_act(src)

/mob/living/proc/handle_inwater()
	ExtinguishMob()

/mob/living/carbon/handle_inwater()
	..()
	if(!(mobility_flags & MOBILITY_STAND))
		if(HAS_TRAIT(src, TRAIT_NOBREATH) || HAS_TRAIT(src, TRAIT_WATERBREATHING))
			return TRUE
		adjustOxyLoss(5)
		emote("drown")

/mob/living/carbon/human/handle_inwater()
	. = ..()
	if(!(mobility_flags & MOBILITY_STAND))
		if(istype(loc, /turf/open/water/bath))
			if(!wear_armor && !wear_shirt && !wear_pants)
				add_stress(/datum/stressevent/bathwater)

/mob/living/carbon/proc/get_complex_pain()
	var/amt = 0
	for(var/obj/item/bodypart/limb as anything in bodyparts)
		if(limb.status == BODYPART_ROBOTIC)
			continue
		var/bodypart_pain = ((limb.brute_dam + limb.burn_dam) / limb.max_damage) * 100
		for(var/datum/wound/wound as anything in limb.wounds)
			bodypart_pain += wound.woundpain
		bodypart_pain = min(bodypart_pain, 100) //tops out at 100 per limb
		amt += bodypart_pain
	return amt

///////////////
// BREATHING //
///////////////

//Start of a breath chain, calls breathe()
/mob/living/carbon/handle_breathing(times_fired)
	var/breath_effect_prob = 0
	var/turf/turf = get_turf(src)
	var/turf_temp = turf.temperature

	if(turf_temp <= T0C - 50)
		breath_effect_prob = 100
	else if(turf_temp <= T0C - 25)
		breath_effect_prob = 50
	else if(turf_temp <= T0C - 10)
		breath_effect_prob = 25
	else if(turf_temp <= T0C)
		breath_effect_prob = 15

	var/turf/snow_turf = get_turf(src)
	if(snow_shiver > world.time)
		breath_effect_prob += 50
	else if(snow_turf.snow)
		breath_effect_prob += 50

	if(prob(breath_effect_prob))
		// Breathing into your mask, no particle. We can add fogged up glasses later
		if(is_mouth_covered())
			return
		emit_breath_particle(/particles/fog/breath)

	return

/mob/living/proc/emit_breath_particle(particle_type)
	ASSERT(ispath(particle_type, /particles))

	var/obj/effect/abstract/particle_holder/holder = new(src, particle_type)
	var/particles/breath_particle = holder.particles
	var/breath_dir = dir

	var/list/particle_grav = list(0, 0.1, 0)
	var/list/particle_pos = list(0, 6, 0)
	if(breath_dir & NORTH)
		particle_grav[2] = 0.2
		breath_particle.rotation = pick(-45, 45)
		// Layer it behind the mob since we're facing away from the camera
		holder.pixel_w -= 4
		holder.pixel_y += 4
	if(breath_dir & WEST)
		particle_grav[1] = -0.2
		particle_pos[1] = -5
		breath_particle.rotation = -45
	if(breath_dir & EAST)
		particle_grav[1] = 0.2
		particle_pos[1] = 5
		breath_particle.rotation = 45
	if(breath_dir & SOUTH)
		particle_grav[2] = 0.2
		breath_particle.rotation = pick(-45, 45)
		// Shouldn't be necessary but just for parity
		holder.pixel_w += 4
		holder.pixel_y -= 4

	breath_particle.gravity = particle_grav
	breath_particle.position = particle_pos

	QDEL_IN(holder, breath_particle.lifespan)

/mob/living/carbon/proc/has_smoke_protection()
	if(HAS_TRAIT(src, TRAIT_NOBREATH))
		return TRUE
	return FALSE

/mob/living/carbon/proc/handle_bodyparts()
	var/stam_regen = FALSE
	if(stam_regen_start_time <= world.time)
		stam_regen = TRUE
		if(stam_paralyzed)
			. |= BODYPART_LIFE_UPDATE_HEALTH //make sure we remove the stamcrit
	for(var/I in bodyparts)
		var/obj/item/bodypart/BP = I
		if(BP.needs_processing)
			. |= BP.on_life(stam_regen)

/mob/living/carbon/proc/handle_organs()
	if(stat != DEAD)
		for(var/V in internal_organs)
			var/obj/item/organ/O = V
			O.on_life()
	else
		for(var/V in internal_organs)
			var/obj/item/organ/O = V
			O.on_death() //Needed so organs decay while inside the body.

/mob/living/carbon/handle_mutations_and_radiation()
	if(dna && dna.temporary_mutations.len)
		for(var/mut in dna.temporary_mutations)
			if(dna.temporary_mutations[mut] < world.time)
				if(mut == UI_CHANGED)
					if(dna.previous["UI"])
						dna.uni_identity = merge_text(dna.uni_identity,dna.previous["UI"])
						updateappearance(mutations_overlay_update=1)
						dna.previous.Remove("UI")
					dna.temporary_mutations.Remove(mut)
					continue
				if(mut == UE_CHANGED)
					if(dna.previous["name"])
						real_name = dna.previous["name"]
						name = real_name
						dna.previous.Remove("name")
					if(dna.previous["UE"])
						dna.unique_enzymes = dna.previous["UE"]
						dna.previous.Remove("UE")
					if(dna.previous["blood_type"])
						dna.blood_type = dna.previous["blood_type"]
						dna.previous.Remove("blood_type")
					dna.temporary_mutations.Remove(mut)
					continue

/mob/living/carbon/handle_embedded_objects()
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		for(var/obj/item/embedded as anything in bodypart.embedded_objects)
			if(embedded.on_embed_life(src, bodypart))
				continue

			if(prob(embedded.embedding.embedded_pain_chance))
				bodypart.receive_damage(embedded.w_class*embedded.embedding.embedded_pain_multiplier)
				to_chat(src, span_danger("[embedded] in my [bodypart.name] hurts!"))

			if(prob(embedded.embedding.embedded_fall_chance))
				bodypart.receive_damage(embedded.w_class*embedded.embedding.embedded_fall_pain_multiplier)
				bodypart.remove_embedded_object(embedded)
				to_chat(src,span_danger("[embedded] falls out of my [bodypart.name]!"))

/*
Alcohol Poisoning Chart
Note that all higher effects of alcohol poisoning will inherit effects for smaller amounts (i.e. light poisoning inherts from slight poisoning)
In addition, severe effects won't always trigger unless the drink is poisonously strong
All effects don't start immediately, but rather get worse over time; the rate is affected by the imbiber's alcohol tolerance

0: Non-alcoholic
1-10: Barely classifiable as alcohol - occassional slurring
11-20: Slight alcohol content - slurring
21-30: Below average - imbiber begins to look slightly drunk
31-40: Just below average - no unique effects
41-50: Average - mild disorientation, imbiber begins to look drunk
51-60: Just above average - disorientation, vomiting, imbiber begins to look heavily drunk
61-70: Above average - small chance of blurry vision, imbiber begins to look smashed
71-80: High alcohol content - blurry vision, imbiber completely shitfaced
81-90: Extremely high alcohol content - light brain damage, passing out
91-100: Dangerously toxic - swift death
*/
#define BALLMER_POINTS 5
GLOBAL_LIST_INIT(ballmer_good_msg, list("Hey guys, what if we rolled out a bluespace wiring system so mice can't destroy the powergrid anymore?",
										"Hear me out here. What if, and this is just a theory, we made R&D controllable from our PDAs?",
										"I'm thinking we should roll out a git repository for our research under the AGPLv3 license so that we can share it among the other stations freely.",
										"I dunno about you guys, but IDs and PDAs being separate is clunky as fuck. Maybe we should merge them into a chip in our arms? That way they can't be stolen easily.",
										"Why the fuck aren't we just making every pair of shoes into galoshes? We have the technology."))
GLOBAL_LIST_INIT(ballmer_windows_me_msg, list("Yo man, what if, we like, uh, put a webserver that's automatically turned on with default admin passwords into every PDA?",
												"So like, you know how we separate our codebase from the master copy that runs on our consumer boxes? What if we merged the two and undid the separation between codebase and server?",
												"Dude, radical idea: H.O.N.K mechs but with no bananium required.",
												"Best idea ever: Disposal pipes instead of hallways.",
												"We should store bank records in a webscale datastore, like /dev/null.",
												"You ever wonder if /dev/null supports sharding?",
												"Do you know who ate all the donuts?",
												"What if we use a language that was written on a napkin and created over 1 weekend for all of our servers?"))

//this updates all special effects: stun, sleeping, knockdown, druggy, stuttering, etc..
/mob/living/carbon/handle_status_effects()
	..()

	var/restingpwr = 1 + 4 * resting

	//Dizziness
	if(dizziness)
		var/client/C = client
		var/pixel_x_diff = 0
		var/pixel_y_diff = 0
		var/temp
		var/saved_dizz = dizziness
		if(C)
			var/oldsrc = src
			var/amplitude = dizziness*(sin(dizziness * world.time) + 1) // This shit is annoying at high strength
			src = null
			spawn(0)
				if(C)
					temp = amplitude * sin(saved_dizz * world.time)
					pixel_x_diff += temp
					C.pixel_x += temp
					temp = amplitude * cos(saved_dizz * world.time)
					pixel_y_diff += temp
					C.pixel_y += temp
					sleep(3)
					if(C)
						temp = amplitude * sin(saved_dizz * world.time)
						pixel_x_diff += temp
						C.pixel_x += temp
						temp = amplitude * cos(saved_dizz * world.time)
						pixel_y_diff += temp
						C.pixel_y += temp
					sleep(3)
					if(C)
						C.pixel_x -= pixel_x_diff
						C.pixel_y -= pixel_y_diff
			src = oldsrc
		dizziness = max(dizziness - restingpwr, 0)

	if(drowsyness)
		drowsyness = max(drowsyness - restingpwr, 0)
		blur_eyes(2)
		if(drowsyness >= 100)
			Sleeping(300)

	//Jitteriness
	if(jitteriness)
		do_jitter_animation(jitteriness)
		jitteriness = max(jitteriness - restingpwr, 0)
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "jittery", /datum/mood_event/jittery)
	else
		SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "jittery")

	if(stuttering)
		stuttering = max(stuttering-1, 0)

	if(slurring)
		slurring = max(slurring-1,0)

	if(cultslurring)
		cultslurring = max(cultslurring-1, 0)

	if(silent)
		silent = max(silent-1, 0)

	if(druggy)
		adjust_drugginess(-1)

	if(hallucination)
		handle_hallucinations()

	if(drunkenness)
		drunkenness = max(drunkenness - (drunkenness * 0.04) - 0.01, 0)
		if(drunkenness >= 3)
//			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "drunk", /datum/mood_event/drunk)
			if(prob(3))
				slurring += 2
			jitteriness = max(jitteriness - 3, 0)
			apply_status_effect(/datum/status_effect/buff/drunk)
			add_stress(/datum/stressevent/drunk)
		else
			remove_stress(/datum/stressevent/drunk)
		if(drunkenness >= 8.5) // Roughly 2 cups
			if(has_flaw(/datum/charflaw/addiction/alcoholic))
				sate_addiction()
		if(drunkenness >= 11 && slurring < 5)
			slurring += 1.2

		if(drunkenness >= 41)
			if(prob(25))
				confused += 2
			Dizzy(10)

		if(drunkenness >= 51)
			adjustToxLoss(1)
			if(prob(3))
				confused += 15
				vomit() // vomiting clears toxloss, consider this a blessing
			Dizzy(25)

		if(drunkenness >= 61)
			adjustToxLoss(1)
			if(prob(50))
				blur_eyes(5)

		if(drunkenness >= 71)
			adjustToxLoss(1)
			if(prob(10))
				blur_eyes(5)

		if(drunkenness >= 81)
			adjustToxLoss(3)
			if(prob(5) && !stat)
				to_chat(src, span_warning("Maybe I should lie down for a bit..."))

		if(drunkenness >= 91)
			adjustToxLoss(5)
//			adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.4)
			if(prob(20) && !stat)
				to_chat(src, span_warning("Just a quick nap..."))
				Sleeping(900)

		if(drunkenness >= 101)
			adjustToxLoss(5) //Let's be honest you shouldn't be alive by now

//used in human and monkey handle_environment()
/mob/living/carbon/proc/natural_bodytemperature_stabilization()
	var/body_temperature_difference = BODYTEMP_NORMAL - bodytemperature
	switch(bodytemperature)
		if(-INFINITY to BODYTEMP_COLD_DAMAGE_LIMIT) //Cold damage limit is 50 below the default, the temperature where you start to feel effects.
			return max((body_temperature_difference * metabolism_efficiency / BODYTEMP_AUTORECOVERY_DIVISOR), BODYTEMP_AUTORECOVERY_MINIMUM)
		if(BODYTEMP_COLD_DAMAGE_LIMIT to BODYTEMP_NORMAL)
			return max(body_temperature_difference * metabolism_efficiency / BODYTEMP_AUTORECOVERY_DIVISOR, min(body_temperature_difference, BODYTEMP_AUTORECOVERY_MINIMUM/4))
		if(BODYTEMP_NORMAL to BODYTEMP_HEAT_DAMAGE_LIMIT) // Heat damage limit is 50 above the default, the temperature where you start to feel effects.
			return min(body_temperature_difference * metabolism_efficiency / BODYTEMP_AUTORECOVERY_DIVISOR, max(body_temperature_difference, -BODYTEMP_AUTORECOVERY_MINIMUM/4))
		if(BODYTEMP_HEAT_DAMAGE_LIMIT to INFINITY)
			return min((body_temperature_difference / BODYTEMP_AUTORECOVERY_DIVISOR), -BODYTEMP_AUTORECOVERY_MINIMUM)	//We're dealing with negative numbers

/////////
//LIVER//
/////////

///Decides if the liver is failing or not.
/mob/living/carbon/proc/handle_liver()
	if(!dna)
		return
	var/obj/item/organ/liver/liver = getorganslot(ORGAN_SLOT_LIVER)
	if(!liver)
		liver_failure()

/mob/living/carbon/proc/undergoing_liver_failure()
	var/obj/item/organ/liver/liver = getorganslot(ORGAN_SLOT_LIVER)
	if(liver && (liver.organ_flags & ORGAN_FAILING))
		return TRUE

/mob/living/carbon/proc/liver_failure()
	reagents.end_metabolization(src, keep_liverless = TRUE) //Stops trait-based effects on reagents, to prevent permanent buffs
	reagents.metabolize(src, can_overdose=FALSE, liverless = TRUE)
	if(HAS_TRAIT(src, TRAIT_NOMETABOLISM))
		return
	adjustToxLoss(4, TRUE,  TRUE)
//	if(prob(30))
//		to_chat(src, span_warning("I feel a stabbing pain in your abdomen!"))

/////////////
//CREMATION//
/////////////
/mob/living/carbon/proc/check_cremation()
	//Only cremate while actively on fire
	if(!on_fire)
		return

	if(stat != DEAD)
		return

	//Only starts when the chest has taken full damage
	var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
	if(!(chest.get_damage() >= chest.max_damage))
		return

	//Burn off limbs one by one
	var/obj/item/bodypart/limb
	var/list/limb_list = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/still_has_limbs = FALSE
	var/should_update_body = FALSE
	for(var/zone in limb_list)
		limb = get_bodypart(zone)
		if(limb && !limb.skeletonized)
			still_has_limbs = TRUE
			if(limb.get_damage() >= limb.max_damage)
				limb.cremation_progress += rand(2,5)
				if(dna && dna.species && !(NOBLOOD in dna.species.species_traits))
					blood_volume = max(blood_volume - 10, 0)
				if(limb.cremation_progress >= 50)
					if(limb.status == BODYPART_ORGANIC) //Non-organic limbs don't burn
						limb.skeletonize()
						should_update_body = TRUE
//						limb.drop_limb()
//						limb.visible_message(span_warning("[src]'s [limb.name] crumbles into ash!"))
//						qdel(limb)
//					else
//						limb.drop_limb()
//						limb.visible_message(span_warning("[src]'s [limb.name] detaches from [p_their()] body!"))
	if(still_has_limbs)
		return

	//Burn the head last
	var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
	if(head && !head.skeletonized)
		if(head.get_damage() >= head.max_damage)
			head.cremation_progress += 999
			if(head.cremation_progress >= 20)
				if(head.status == BODYPART_ORGANIC) //Non-organic limbs don't burn
					limb.skeletonize()
					should_update_body = TRUE
//					head.drop_limb()
//					head.visible_message(span_warning("[src]'s head crumbles into ash!"))
//					qdel(head)
//				else
//					head.drop_limb()
//					head.visible_message(span_warning("[src]'s head detaches from [p_their()] body!"))
		return

	//Nothing left: dust the body, drop the items (if they're flammable they'll burn on their own)
	if(chest && !chest.skeletonized)
		if(chest.get_damage() >= chest.max_damage)
			chest.cremation_progress += 999
			if(chest.cremation_progress >= 19)
		//		visible_message(span_warning("[src]'s body crumbles into a pile of ash!"))
		//		dust(TRUE, TRUE)
				chest.skeletonized = TRUE
				if(ishuman(src))
					var/mob/living/carbon/human/H = src
					H.underwear = "Nude"
				should_update_body = TRUE
				if(dna && dna.species)
					if(dna && dna.species && !(NOBLOOD in dna.species.species_traits))
						blood_volume = 0
					dna.species.species_traits |= NOBLOOD

	if(should_update_body)
		update_body()

////////////////
//BRAIN DAMAGE//
////////////////

/mob/living/carbon/proc/handle_brain_damage()
	for(var/T in get_traumas())
		var/datum/brain_trauma/BT = T
		BT.on_life()

/////////////////////////////////////
//MONKEYS WITH TOO MUCH CHOLOESTROL//
/////////////////////////////////////

/mob/living/carbon/proc/can_heartattack()
	if(!needs_heart())
		return FALSE
	var/obj/item/organ/heart/heart = getorganslot(ORGAN_SLOT_HEART)
	if(!heart || (heart.organ_flags & ORGAN_SYNTHETIC))
		return FALSE
	return TRUE

/mob/living/carbon/proc/needs_heart()
	if(HAS_TRAIT(src, TRAIT_STABLEHEART))
		return FALSE
	if(dna && dna.species && (NOBLOOD in dna.species.species_traits)) //not all carbons have species!
		return FALSE
	return TRUE

/*
 * The mob is having a heart attack
 *
 * NOTE: this is true if the mob has no heart and needs one, which can be suprising,
 * you are meant to use it in combination with can_heartattack for heart attack
 * related situations (i.e not just cardiac arrest)
 */
/mob/living/carbon/proc/undergoing_cardiac_arrest()
	var/obj/item/organ/heart/heart = getorganslot(ORGAN_SLOT_HEART)
	if(istype(heart) && heart.beating)
		return FALSE
	else if(!needs_heart())
		return FALSE
	return TRUE

/mob/living/carbon/proc/set_heartattack(status)
	if(!can_heartattack())
		return FALSE

	var/obj/item/organ/heart/heart = getorganslot(ORGAN_SLOT_HEART)
	if(!istype(heart))
		return

	heart.beating = !status

/mob/living/carbon/proc/fairy_hover()
	//Fairy hovering animation
	/*
	anim_counter += 1
	if(anim_counter >= 50)
		animate(src, pixel_y = pixel_y + 2, time = 10, loop = -1)

	else if(amin_counter >= 70)
		animate(src, pixel_y = pixel_y - 2, time = 10, loop = -1)

	else if(anim_counter >= 100)
		anim_counter = 0
		*/

	//TODO: Check is animate stopping is causing weird visual glitch (it was, checking for sleep before calling fairy_hover fixed this)
	if(!resting && !wallpressed)
		animate(src, pixel_y = pixel_y + 2, time = 5, loop = -1)
	sleep(5)
	if(!resting && !wallpressed)
		animate(src, pixel_y = pixel_y - 2, time = 5, loop = -1)

	//animate(src, pixel_x = rand(-2, 2), pixel_y = rand(-2, 2), time = 20)

/// Handles sleep. Mobs with no_sleep trait cannot sleep.
/*
*	The mob tries to go to sleep or IS sleeping
*
*	Accounts for...
*	TRAIT_NOSLEEP
*	CANT_SLEEP_IN
*	TRAIT_NUDE_SLEEPER
*	Hunger and Hydration.
*/
/mob/living/carbon/proc/handle_sleep()
	if(HAS_TRAIT(src, TRAIT_NOSLEEP))
		return
	var/can_sleep = TRUE
	var/bleedrate
	var/cause = list("I can't sleep because...")
	for(var/obj/item/clothing/thing in get_equipped_items(FALSE))
		if(thing.clothing_flags & CANT_SLEEP_IN)
			can_sleep = FALSE
			cause += " \n\The [thing] bothers me..."

	if(HAS_TRAIT(src, TRAIT_NUDE_SLEEPER))
		if(length(get_equipped_items()))
			cause += "I need to be nude to be comfortable..."
			can_sleep = FALSE
	if(sleep_accumulation > 15 && eyesclosed && resting && !can_sleep)
		to_chat(src, span_boldwarning("[cause]"))
		return
	var/sleep_modifier // Modifier to multiply healing bonuses by and by how fast we fall asleep.
	if(buckled?.sleepy)
		sleep_modifier = buckled.sleepy
	else if(isturf(loc)) //No illegal tech.
		var/obj/structure/bed/rogue/bed = locate() in loc
		if(bed)
			sleep_modifier = bed.sleepy
	if(IsSleeping() && !InFullCritical())
		if(!sleep_modifier)
			sleep_modifier = 0.75
		var/requires_hydration = !HAS_TRAIT(src, TRAIT_NOHUNGER)
		if(hydration > 0 || !requires_hydration) // No hydration? No healing.
			if(!bleedrate)
				blood_volume = min(blood_volume + (4 * sleep_modifier), BLOOD_VOLUME_NORMAL)
			for(var/obj/item/bodypart/affecting as anything in bodyparts)
				//for context, it takes 5 small cuts (0.2 x 5) or 3 normal cuts (0.4 x 3) for a bodypart to not be able to heal itself
				if(affecting.heal_damage(sleep_modifier, sleep_modifier, required_status = BODYPART_ORGANIC))
					src.update_damage_overlays()
				for(var/datum/wound/wound as anything in affecting.wounds)
					if(!wound.sleep_healing)
						continue
					wound.heal_wound(wound.sleep_healing * sleep_modifier)
			adjustToxLoss(-sleep_modifier)
		if(eyesclosed && !HAS_TRAIT(src, TRAIT_NOSLEEP))
			Sleeping(300)
	else if((eyesclosed && resting) || (eyesclosed && InCritical()))
		var/sleep_bedless
		if(!sleep_modifier) // resting on ground
			sleep_modifier = 1
			sleep_bedless = ", although a bed would be more comfortable"
		if(!sleep_accumulation)
			to_chat(src, span_warning("I'll fall asleep soon[sleep_bedless]..."))
		if(HAS_TRAIT(src, TRAIT_FASTSLEEP))
			sleep_modifier += 2
		sleep_accumulation += sleep_modifier
		if(sleep_accumulation > 25)
			Sleeping(300)
	else if(sleep_accumulation)
		sleep_accumulation = 0

/*
*	Handles resting and recovery energy (Blue bar)
*
*	Recovery rate is determined by:
*		Whether or not you're resting on a bed.
*		Sleeping
*		Max energy
*/
/mob/living/carbon/proc/handle_energy_recovery()
	if(HAS_TRAIT(src, TRAIT_NOSTAMINA))
		energy = max_energy
		return
	if(nutrition <= 0 && !HAS_TRAIT(src, TRAIT_NOHUNGER)) // No food? No Stamina.
		to_chat(src, span_bad("I am too hungry to recover... "))
		return
	if(resting)
		var/recovery_amt
		var/bed_recovery_modifier = 1
		var/obj/structure/bed/rogue/bed = locate() in loc
		if(bed)
			bed_recovery_modifier = bed.sleepy
		if(IsSleeping())
			recovery_amt = (max_energy * 0.10) * bed_recovery_modifier // Example: max energy 1000 -> 100 energy on ground, 300 on bed
		else
			recovery_amt = (max_energy * 0.02) * bed_recovery_modifier // Example: max energy 1000 -> 20 energy on ground, 60 on bed
		
		energy_add(recovery_amt)
