/mob/living/carbon/human/species/seelie
	race = /datum/species/seelie
	gender = FEMALE

/datum/species/seelie
	name = "Seelie"
	id = "seelie"
	desc = "<b>Seelie</b><br>\
	The smallest of Fae-folk, Seelie are a mysterious race and not well understood. \
    Parentless creatures and unable to reproduce naturally, it is clear that they do not propogate in a typical human way. \
    Instead, Seelie tend to appear and gather in places of chaos and misfortune, thriving in such an environment. \
    Seelie are known to have Elemental Attunements, an influence of nature that mystically sprung them into existance. \
    Any tribalism or history regarding the race is scarce and uncommmon, and as such misconception and myth surrounds them. \
    The wary traveller should take heed of such beings, as both fortune and missery is said to accompany the little troublemakers."

	skin_tone_wording = "Elemental Connection"

	//gender = FEMALE
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)	//Default shit that ever race gets
	inherent_traits = list(TRAIT_NOMOBSWAP, TRAIT_NOFALLDAMAGE2, TRAIT_TINY)	//Use this to add custom Fae traits
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	possible_ages = ALL_AGES_LIST
	limbs_icon_m = 'icons/roguetown/mob/bodies/f/fm.dmi'		//CHANGE THESE TO NEW SPRITEWORK
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'		//All fairies are technically female in code, but are genderless in lore
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/female/elf
	soundpack_f = /datum/voicepack/female/elf
	offset_features = list(
		OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
		OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
		OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1), \
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list(
		"perception" = 4,
		"intelligence" = 2,
		"constitution" = -6,
		"endurance" = -1,
		"speed" = 7,
		"fortune" = 2
		)
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/elfw,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		//ADD WINGS HERE
		ORGAN_SLOT_WINGS = /obj/item/organ/wings/seelie,
		)
	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		///datum/bodypart_feature/hair/facial, //I think remove facial hair as all seelie are genderless female centric
	)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/tail/anthro,
		/datum/customizer/organ/tail_feature/anthro,
		/datum/customizer/organ/snout/anthro,
		/datum/customizer/organ/ears/anthro,
		/datum/customizer/organ/horns/anthro,
		/datum/customizer/organ/frills/anthro,
		/datum/customizer/organ/wings/seelie,
		/datum/customizer/organ/neck_feature/anthro,
		/datum/customizer/organ/testicles/anthro,
		/datum/customizer/organ/penis/anthro,
		/datum/customizer/organ/breasts/animal,
		/datum/customizer/organ/vagina/anthro,
	)

	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/belly,
		/datum/body_marking_set/bellysocks,
		/datum/body_marking_set/tiger,
		/datum/body_marking_set/tiger_dark,
	)

	body_markings = list(
		/datum/body_marking/flushed_cheeks,
		/datum/body_marking/eyeliner,
		/datum/body_marking/plain,
		/datum/body_marking/fox,
		/datum/body_marking/wolf,
		/datum/body_marking/tiger,
		/datum/body_marking/tiger/dark,
		/datum/body_marking/sock,
		/datum/body_marking/socklonger,
		/datum/body_marking/tips,
		/datum/body_marking/bellyscale,
		/datum/body_marking/bellyscaleslim,
		/datum/body_marking/bellyscalesmooth,
		/datum/body_marking/bellyscaleslimsmooth,
		/datum/body_marking/buttscale,
		/datum/body_marking/belly,
		/datum/body_marking/bellyslim,
		/datum/body_marking/butt,
		/datum/body_marking/tie,
		/datum/body_marking/tiesmall,
		/datum/body_marking/backspots,
		/datum/body_marking/front,
		/datum/body_marking/drake_eyes,
		/datum/body_marking/tonage,
		/datum/body_marking/spotted,
	)

	descriptor_choices = list(
		/datum/descriptor_choice/height,
		/datum/descriptor_choice/body,
		/datum/descriptor_choice/stature,
		/datum/descriptor_choice/face,
		/datum/descriptor_choice/face_exp,
		/datum/descriptor_choice/skin_all,
		/datum/descriptor_choice/voice,
		/datum/descriptor_choice/prominent_one_wild,
		/datum/descriptor_choice/prominent_two_wild,
		/datum/descriptor_choice/prominent_three_wild,
		/datum/descriptor_choice/prominent_four_wild,
	)

	languages = list(
		/datum/language/common,
		/datum/language/faexin,	//seelie speak here
	)
	stress_examine = TRUE
	stress_desc = span_red("A tiny seelie, mischievous in nature.")
	default_scale_x = 0.5
	default_scale_y = 0.5

/datum/species/seelie/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	RegisterSignal(C, COMSIG_LIVING_MOBILITY_UPDATED, PROC_REF(handle_mobility_update))
	passtable_on(C, SPECIES_TRAIT)
	C.pass_flags |= PASSMOB
	//C.movement_type = FLYING
	C.set_mob_offsets("pixie_hover", _x = 0, _y = 10)
	C.set_light(3, 1, "#d4fcac")

/datum/species/seelie/after_creation(mob/living/carbon/C)
	..()
	to_chat(C, "<span class='info'>I can speak Faexin with ,p before my speech.</span>")
	C.verbs |= (/mob/living/carbon/human/proc/Turnlight)
	C.verbs |= (/mob/living/carbon/proc/switchaura)

/datum/species/seelie/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	UnregisterSignal(C, COMSIG_LIVING_MOBILITY_UPDATED)
	C.update_transform()
	passtable_off(C, SPECIES_TRAIT)
	C.pass_flags &= ~PASSMOB
	C.reset_offsets("pixie_hover")
	//C.movement_type = (C.movement_type | ~FLYING)
	//C.Jitter(0)
	C.set_light(0, 0, null)

/datum/species/seelie/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/seelie/get_skin_list()
	return list(
		//Change all of this to new skin or element colors
		"Water" = SKIN_COLOR_WATER,
		"Soil" = SKIN_COLOR_SOIL,
		"Rock" = SKIN_COLOR_ROCK,
		"Air" = SKIN_COLOR_AIR,
		"Fire" = SKIN_COLOR_FIRE,
		"Flora" = SKIN_COLOR_FLORA,
		"Lightning" = SKIN_COLOR_ELECTRIC,
	)

/datum/species/seelie/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b"
	))

/datum/species/seelie/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/fairyf.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/fairyf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/fairyf.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/fairyf.txt") )
	return randname

/datum/species/seelie/random_surname()
	return " [pick(world.file2list("strings/rt/names/other/fairyf.txt"))]"

/datum/species/seelie/on_bitten(mob/living/carbon/human/victim, mob/living/carbon/human/biter)
	// Only Graggarites can bite a Seelie's head off.
	if(biter.patron.type != /datum/patron/inhumen/graggar)
		return FALSE
	// And the biter must have an aggressive grab on the Seelie.
	if(victim.pulledby != biter && biter.grab_state != GRAB_AGGRESSIVE)
		return FALSE
	victim.visible_message(span_danger("[biter] is putting [victim]'s head in [biter.p_their()] mouth!"), \
					span_userdanger("[biter] is putting my head in [biter.p_their()] mouth!"))
	if(do_mob(biter, victim, 8 SECONDS))
		var/obj/item/bodypart/head/head = victim.get_bodypart(BODY_ZONE_HEAD)
		head.dismember()
	return TRUE // Either way, cancel normal on-bite logic at this point, since we tried to bite their head off.

/datum/species/seelie/on_middle_click(mob/living/carbon/human/Target, mob/Ripper)
	if(isseelie(Ripper) || Target.pulledby != Ripper)
		return FALSE // Seelies can't rip other seelies' wings, and you have to be pulling someone to rip their wings.
	if(!has_wings(Target))
		to_chat(Ripper, span_notice("[Target] is missing their wings."))
		return FALSE
	Ripper.visible_message(span_danger("[Ripper] begins to rip [Target]'s wings..."), \
						span_danger("I begin to rip [Target]'s wings..."), ignored_mobs = Target)
	to_chat(Target, span_userdanger("[Ripper] begins to rip your wings off..."))
	if(!do_mob(Ripper, Target, 8 SECONDS))
		return TRUE // cancel base middle-click functionality
	//if(length(Target.grabbedby) != 0)
	// Make sure our grab wasn't interrupted.
	if(Target.pulledby != Ripper)
		to_chat(Ripper, span_notice("I have to keep ahold of [Target] to rip their wings off!"))
		return TRUE
	if(!has_wings(Target))
		to_chat(Ripper, span_notice("[Target] is already missing their wings."))
		return FALSE
	var/obj/item/organ/wings/seelie/Wing = Target.getorganslot(ORGAN_SLOT_WINGS)
	Wing.Remove(Target)
	Wing.forceMove(Target.drop_location())
	Ripper.put_in_hands(Wing)
	Target.update_body_parts(TRUE)
	//var/fracture_type = /datum/wound/fracture/neck
	var/obj/item/bodypart/BP = Target.get_bodypart(BODY_ZONE_PRECISE_NECK)
	BP.add_wound(/datum/wound/fracture/neck)
	Target.apply_damage(70, BRUTE, Target.get_bodypart(BODY_ZONE_CHEST))
	//var/datum/disease/Disease = new /datum/disease/heart_failure
	//Target.ForceContractDisease(Disease)	//Disease removed in favor of simply stopping the heart via heart attack
	Target.set_heartattack(TRUE)
	Target.visible_message(span_danger("[Target] clutches at [Target.p_their()] chest as if [Target.p_their()] heart stopped!"))
	Ripper.log_message("[key_name(Ripper)] ripped [key_name(Target)]'s wings.")
	Target.log_message("[key_name(Target)]'s wings got ripped by [key_name(Ripper)].")

	//CURSE OF THE SEELIE
	if(!isdead(Target))
		playsound(Target, 'sound/vo/female/gen/scream (2).ogg', 140)
		var/const/SEELIE_SCREAM_RANGE = 4
		Target.audible_message(span_userdanger("[Target] screams in agony, inflicting a curse on you for the vile deed done to [Target.p_them()]!"), null,
			SEELIE_SCREAM_RANGE, \
			span_danger("You scream in agony, inflicting a curse on those around you as punishment for their vile deeds!")
		)
		for(var/mob/living/carbon/C in view(SEELIE_SCREAM_RANGE, Target))
			if(C == Target)
				continue
			C.adjustEarDamage(0, 35)
			C.confused += 40
			C.Jitter(50)
			C.apply_status_effect(/datum/status_effect/debuff/seelie_wing_curse)

/datum/species/seelie/proc/has_wings(mob/living/carbon/human/owner)
	return !!owner?.getorganslot(ORGAN_SLOT_WINGS)

/datum/species/seelie/proc/regenerate_wings(mob/living/carbon/human/owner)
	owner.set_heartattack(FALSE)
	var/obj/item/organ/wings/wing = owner.getorganslot(ORGAN_SLOT_WINGS)
	if(!wing)
		var/wing_type = owner.dna.species.organs[ORGAN_SLOT_WINGS]
		var/obj/item/organ/wings/new_wings = new wing_type()
		new_wings.Insert(owner)

/// Apply the Seelie hovering animation
/datum/species/seelie/proc/fairy_hover(mob/living/carbon/human/owner)
	if(!owner.resting && !owner.wallpressed)
		animate(owner, pixel_y = owner.pixel_y + 2, time = 0.5 SECONDS, loop = -1)
	sleep(0.5 SECONDS)
	if(!owner.resting && !owner.wallpressed)
		animate(owner, pixel_y = owner.pixel_y - 2, time = 0.5 SECONDS, loop = -1)

/datum/species/seelie/spec_life(mob/living/carbon/human/owner)
	. = ..()
	if(is_seelie_floating(owner))
		fairy_hover(owner)

	if(!owner.IsSleeping())	
		//Seelie luck aura
		for(var/mob/living/carbon/human/victim in view(1, src))
			if(isseelie(victim))
				continue
			if(owner.aura)
				victim.apply_status_effect(/datum/status_effect/buff/seelie/happy)
				victim.remove_status_effect(/datum/status_effect/buff/seelie/sad)
			else
				victim.apply_status_effect(/datum/status_effect/buff/seelie/sad)
				victim.remove_status_effect(/datum/status_effect/buff/seelie/happy)

/datum/species/seelie/proc/is_seelie_floating(mob/living/carbon/human/owner)
	return !owner.incapacitated(ignore_restraints = TRUE) && (owner.mobility_flags & MOBILITY_STAND) && has_wings(owner) && !owner.buckled

/datum/species/seelie/is_floor_hazard_immune(mob/living/carbon/human/owner)
	return is_seelie_floating(owner)

/datum/species/seelie/proc/handle_mobility_update(mob/living/carbon/human/seelie)
	SIGNAL_HANDLER
	if(is_seelie_floating(seelie)) //Shift Seelie back 'up' from lying down on the ground
		seelie.set_mob_offsets("pixie_hover", _x = 0, _y = 10)
	else // If buckled or unable to stand, Seelies need to 'fall' to the ground by resetting position
		seelie.reset_offsets("pixie_hover")

/mob/living/carbon/human/proc/Turnlight()
	set name = "Seelie Glow"
	set category = "Seelie"
	if(light_power)
		set_light(0, 0, null)
		to_chat(src, span_notice("I stop glowing."))
	else
		to_chat(src, span_notice("I begin to glow once more."))
		set_light(3, 1, "#d4fcac")

/mob/living/carbon/proc/switchaura()
	set name = "Luck Aura"
	set category = "Seelie"
	aura = !aura
	if(aura)
		to_chat(src, span_warning("My aura is now one of blessing."))
		log_message("[key_name(src)] has switched their aura to apply good luck.", LOG_GAME)
	else
		to_chat(src, span_warning("My aura is now one of misery."))
		log_message("[key_name(src)] has switched their aura to apply bad luck.", LOG_GAME)
