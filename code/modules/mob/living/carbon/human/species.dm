// This code handles different species in the game.

GLOBAL_LIST_EMPTY(roundstart_races)

/datum/species
	var/id	// if the game needs to manually check my race to do something not included in a proc here, it will use this
	var/limbs_id		//this is used if you want to use a different species limb sprites. Mainly used for angels as they look like humans.
	var/clothes_id //id for clothes
	var/name	// this is the fluff name. these will be left generic (such as 'Lizardperson' for the lizard race) so servers can change them to whatever
	var/desc
	var/default_color = "#FFF"	// if alien colors are disabled, this is the color that will be used by that race
	var/limbs_icon_m
	var/limbs_icon_f
	var/icon_override
	var/icon_override_m
	var/icon_override_f
	var/list/possible_ages = ALL_AGES_LIST
	var/sexes = 1		// whether or not the race has sexual characteristics. at the moment this is only 0 for skeletons and shadows
	var/patreon_req = 0
	var/max_age = 75
	var/list/offset_features = list(OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0),\
	OFFSET_CLOAK = list(0,0), OFFSET_FACEMASK = list(0,0), OFFSET_HEAD = list(0,0), \
	OFFSET_FACE = list(0,0), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,0), \
	OFFSET_NECK = list(0,0), OFFSET_MOUTH = list(0,0), OFFSET_PANTS = list(0,0), \
	OFFSET_SHIRT = list(0,0), OFFSET_ARMOR = list(0,0), OFFSET_HANDS = list(0,0), \
	OFFSET_ID_F = list(0,0), OFFSET_GLOVES_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
	OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,0), OFFSET_HEAD_F = list(0,0), \
	OFFSET_FACE_F = list(0,0), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,0), \
	OFFSET_NECK_F = list(0,0), OFFSET_MOUTH_F = list(0,0), OFFSET_PANTS_F = list(0,0), \
	OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES = list(0,0), OFFSET_UNDIES_F = list(0,0))

	var/dam_icon
	var/dam_icon_f

	var/hairyness = null

	var/custom_clothes = FALSE //append species id to clothing sprite name
	var/use_f = FALSE //males use female clothes. for elves DO NOT TURN BOTH ON EVER
	var/use_m = FALSE //females use male clothes. for half orcs DO NOT TURN BOTH ON

	var/datum/voicepack/soundpack_m = /datum/voicepack/male
	var/datum/voicepack/soundpack_f = /datum/voicepack/female

	var/hair_color	// this allows races to have specific hair colors... if null, it uses the H's hair/facial hair colors. if "mutcolor", it uses the H's mutant_color
	var/hair_alpha = 255	// the alpha used by the hair. 255 is completely solid, 0 is transparent.

	var/use_skintones = 0	// does it use skintones or not? (spoiler alert this is only used by humans)
	var/exotic_blood = ""	// If my race wants to bleed something other than bog standard blood, change this to reagent id.
	var/exotic_bloodtype = "" //If my race uses a non standard bloodtype (A+, O-, AB-, etc)
	var/meat = /obj/item/reagent_containers/food/snacks/meat/slab/human //What the species drops on gibbing
	var/skinned_type
	var/liked_food = NONE
	var/disliked_food = GROSS
	var/toxic_food = TOXIC
	var/list/no_equip = list()	// slots the race can't equip stuff to
	var/nojumpsuit = 0	// this is sorta... weird. it basically lets you equip stuff that usually needs jumpsuits without one, like belts and pockets and ids
	var/say_mod = "says"	// affects the speech message
	var/list/default_features = MANDATORY_FEATURE_LIST // Default mutant bodyparts for this species. Don't forget to set one for every mutant bodypart you allow this species to have.
	var/speedmod = 0	// this affects the race's speed. positive numbers make it move slower, negative numbers make it move faster
	var/armor = 0		// overall defense for the race... or less defense, if it's negative.
	var/brutemod = 1	// multiplier for brute damage
	var/burnmod = 1		// multiplier for burn damage
	var/coldmod = 1		// multiplier for cold damage
	var/heatmod = 1		// multiplier for heat damage
	var/stunmod = 1		// multiplier for stun duration
	var/attack_type = BRUTE //Type of damage attack does
	var/punchdamagelow = 10      //lowest possible punch damage. if this is set to 0, punches will always miss
	var/punchdamagehigh = 10      //highest possible punch damage
	var/punchstunthreshold = 0//damage at which punches from this race will stun //yes it should be to the attacked race but it's not useful that way even if it's logical
	var/siemens_coeff = 1 //base electrocution coefficient
	var/damage_overlay_type = "human" //what kind of damage overlays (if any) appear on our species when wounded?
	var/fixed_mut_color = "" //to use MUTCOLOR with a fixed color that's independent of dna.feature["mcolor"]
	var/inert_mutation 	= DWARFISM //special mutation that can be found in the genepool. Dont leave empty or changing species will be a headache
	var/deathsound //used to set the mobs deathsound on species change
	var/grab_sound //Special sound for grabbing
	var/datum/outfit/outfit_important_for_life /// A path to an outfit that is important for species life e.g. plasmaman outfit

	var/flying_species = FALSE //is a flying species, just a check for some things
	var/datum/action/innate/flight/fly //the actual flying ability given to flying species
	var/wings_icon = "Angel" //the icon used for the wings

	// species-only traits. Can be found in DNA.dm
	var/list/species_traits = list()
	// generic traits tied to having the species
	var/list/inherent_traits = list()
	var/inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	///List of factions the mob gain upon gaining this species.
	var/list/inherent_factions

	var/attack_verb = "punch"	// punch-specific attack verb
	var/sound/attack_sound = 'sound/combat/hits/punch/punch (1).ogg'
	var/sound/miss_sound = 'sound/blank.ogg'

	var/enflamed_icon = "Standing"

	//Breathing!
	var/obj/item/organ/lungs/mutantlungs = null
	var/breathid = "o2"
	var/override_float = FALSE

	//Bitflag that controls what in game ways can select this species as a spawnable source
	//Think magic mirror and pride mirror, slime extract, ERT etc, see defines
	//in __DEFINES/mobs.dm, defaults to NONE, so people actually have to think about it
	var/changesource_flags = NONE

	/// Wording for skin tone on examine and on character setup
	var/skin_tone_wording = "Skin Tone"

	/// List of organs this species has.
	var/list/organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/testicles,
		ORGAN_SLOT_PENIS = /obj/item/organ/penis,
		ORGAN_SLOT_BREASTS = /obj/item/organ/breasts,
		ORGAN_SLOT_VAGINA = /obj/item/organ/vagina,
		)
	/// List of bodypart features of this species
	var/list/bodypart_features

	var/obj/item/mutanthands

	/// List of organ customizers for preferences to customize organs.
	var/list/customizers
	/// List of possible body marking sets that the player can choose from in customization
	var/list/body_marking_sets = list(
		/datum/body_marking_set/none,
	)
	/// List all of body markings that the player can choose from in customization. Body markings from sets get added to here
	var/list/body_markings
	var/list/languages = list(/datum/language/common)
	/// Some species have less than standard gender locks
	var/gender_swapping = FALSE 

///////////
// PROCS //
///////////

/datum/species/proc/is_organ_slot_allowed(mob/living/carbon/human/human, organ_slot)
	switch(organ_slot)
		if(ORGAN_SLOT_VAGINA)
			return (human.gender == FEMALE)
		if(ORGAN_SLOT_BREASTS)
			return (human.gender == FEMALE)
		if(ORGAN_SLOT_PENIS)
			return (human.gender == MALE)
		if(ORGAN_SLOT_TESTICLES)
			return (human.gender == MALE)
	return TRUE

/datum/species/proc/is_bodypart_feature_slot_allowed(mob/living/carbon/human/human, feature_slot)
	switch(feature_slot)
		if(BODYPART_FEATURE_FACIAL_HAIR)
			return (human.gender == MALE)
	return TRUE

/datum/species/proc/add_marking_sets_to_markings()
	if(!body_marking_sets)
		return
	if(!body_markings)
		body_markings = list()
	var/datum/body_marking_set/bodyset
	for(var/set_type in body_marking_sets)
		bodyset = GLOB.body_marking_sets_by_type[set_type]
		for(var/body_marking_type in bodyset.body_marking_list)
			body_markings |= body_marking_type

/datum/species/New()
	add_marking_sets_to_markings()
	if(!limbs_id)	//if we havent set a limbs id to use, just use our own id
		limbs_id = name
	if(!clothes_id)
		clothes_id = id
	..()

/datum/species/proc/after_creation(mob/living/carbon/human/H)
	return TRUE


/proc/get_selectable_species()
	if(!GLOB.roundstart_races.len)
		generate_selectable_species()
	return GLOB.roundstart_races

/proc/generate_selectable_species()
	for(var/species_type in subtypesof(/datum/species))
		var/datum/species/species = new species_type
		if(species.check_roundstart_eligible())
			GLOB.roundstart_races += species.name
		qdel(species)
	if(!GLOB.roundstart_races.len)
		GLOB.roundstart_races += "Humen"
	sortList(GLOB.roundstart_races, GLOBAL_PROC_REF(cmp_text_dsc))

/datum/species/proc/check_roundstart_eligible()
	if(name && id && (id in (CONFIG_GET(keyed_list/roundstart_races))))
		return TRUE
	return FALSE

/datum/species/proc/random_name(gender,unique,lastname)
	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/human/humnorm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/human/humnorf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/human/humnorm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/human/humnorf.txt") )
	return randname

/datum/species/proc/random_surname()
	return " [pick(world.file2list("strings/rt/names/human/humnorlast.txt"))]"

/datum/species/proc/regenerate_icons(mob/living/carbon/human/H)
	return FALSE

/datum/species/proc/update_damage_overlays(mob/living/carbon/human/H)
	return FALSE

/datum/species/proc/get_hexcolor(list/L)
	return L

/datum/species/proc/get_skin_list()
	return GLOB.skin_tones

/datum/species/proc/get_hairc_list()
	return GLOB.haircolor

/datum/species/proc/get_oldhc_list()
	return GLOB.oldhc

/datum/species/proc/oldhc2color(oldhc)
	var/list/L = get_oldhc_list()
	return L[oldhc]

//Called when cloning, copies some vars that should be kept
/datum/species/proc/copy_properties_from(datum/species/old_species)
	return

//Please override this locally if you want to define when what species qualifies for what rank if human authority is enforced.
/datum/species/proc/qualifies_for_rank(rank, list/features)
	if(rank in GLOB.command_positions)
		return 0
	return 1

/datum/species/proc/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	returned["mcolor"] = random_color()
	returned["mcolor2"] = random_color()
	returned["mcolor3"] = random_color()
	return returned

//Will regenerate missing organs
/datum/species/proc/regenerate_organs(mob/living/carbon/C, datum/species/old_species, replace_current=TRUE, list/excluded_zones, datum/preferences/pref_load)
	/// Add DNA and create organs from prefs
	if(pref_load)
		/// Clear the dna
		C.dna.organ_dna = list()
		var/list/organ_dna_list = pref_load.get_organ_dna_list()
		for(var/organ_slot in organ_dna_list)
			C.dna.organ_dna[organ_slot] = organ_dna_list[organ_slot]

	//what should be put in if there is no mutantorgan (brains handled seperately)
	var/list/slot_mutantorgans = organs

	var/list/slots_to_iterate = list()
	for(var/slot in C.dna.organ_dna)
		slots_to_iterate |= slot
	for(var/slot in slot_mutantorgans)
		if(!is_organ_slot_allowed(C, slot))
			continue
		slots_to_iterate |= slot

	// Remove the organs from the slots they should have nothing in
	for(var/obj/item/organ/organ in C.internal_organs)
		if(organ.slot in slots_to_iterate)
			continue
		organ.Remove(C, TRUE)
		QDEL_NULL(organ)
	var/list/source_key_list = color_key_source_list_from_carbon(C)
	for(var/slot in slots_to_iterate)
		var/obj/item/organ/oldorgan = C.getorganslot(slot) //used in removing
		var/obj/item/organ/neworgan

		if(C.dna.organ_dna[slot])
			var/datum/organ_dna/organ_dna = C.dna.organ_dna[slot]
			if(organ_dna.can_create_organ())
				neworgan = organ_dna.create_organ()
				if(pref_load)
					pref_load.customize_organ(neworgan)
		else
			var/new_type = slot_mutantorgans[slot]
			if(new_type)
				neworgan = new new_type()
				neworgan.build_colors_for_accessory(source_key_list)

		var/used_neworgan = FALSE
		var/should_have
		if(neworgan)
			should_have = neworgan.get_availability(src)
		else
			should_have = TRUE

		if(oldorgan && (!should_have || replace_current) && !(oldorgan.zone in excluded_zones))
			if(slot == ORGAN_SLOT_BRAIN)
				var/obj/item/organ/brain/brain = oldorgan
				if(!brain.decoy_override)//"Just keep it if it's fake" - confucius, probably
					brain.Remove(C,TRUE, TRUE) //brain argument used so it doesn't cause any... sudden death.
					QDEL_NULL(brain)
					oldorgan = null //now deleted
			else
				oldorgan.Remove(C,TRUE)
				QDEL_NULL(oldorgan) //we cannot just tab this out because we need to skip the deleting if it is a decoy brain.


		if(oldorgan)
			oldorgan.setOrganDamage(0)
		else if(should_have && !(initial(neworgan.zone) in excluded_zones))
			used_neworgan = TRUE
			if(neworgan)
				neworgan.Insert(C, TRUE, FALSE)

		if(!used_neworgan)
			if(neworgan)
				qdel(neworgan)
		else if (!C.dna.organ_dna[slot] && neworgan)
			var/datum/organ_dna/new_dna = neworgan.create_organ_dna()
			C.dna.organ_dna[slot] = new_dna

/datum/species/proc/random_character(mob/living/carbon/human/H)
	H.real_name = random_name(H.gender,1)
//	H.age = pick(possible_ages)
	var/list/hairs
	if((H.age == AGE_OLD) && (OLDGREY in species_traits))
		hairs = get_oldhc_list()
	else
		hairs = get_hairc_list()
	H.hair_color = hairs[pick(hairs)]
	H.facial_hair_color = H.hair_color
	var/list/skins = get_skin_list()
	H.skin_tone = skins[pick(skins)]
	H.eye_color = random_eye_color()
	H.accessory = "Nothing"
	if(H.dna)
		H.dna.real_name = H.real_name
		H.dna.features = get_random_features()
		H.dna.body_markings = get_random_body_markings(H.dna.features)
	H.update_body()
	H.update_hair()
	H.update_body_parts()


/datum/species/proc/on_species_gain(mob/living/carbon/C, datum/species/old_species, datum/preferences/pref_load)
	// Drop the items the new species can't wear
	if((AGENDER in species_traits))
		C.gender = PLURAL
	for(var/slot_id in no_equip)
		var/obj/item/thing = C.get_item_by_slot(slot_id)
		if(thing && (!thing.species_exception || !is_type_in_list(src,thing.species_exception)))
			C.dropItemToGround(thing)
	if(C.hud_used)
		C.hud_used.update_locked_slots()

	// this needs to be FIRST because qdel calls update_body which checks if we have DIGITIGRADE legs or not and if not then removes DIGITIGRADE from species_traits
	if(C.dna.features["legs"] == "Digitigrade Legs")
		species_traits += DIGITIGRADE
	if(DIGITIGRADE in species_traits)
		C.Digitigrade_Leg_Swap(FALSE)

	C.mob_biotypes = inherent_biotypes

	regenerate_organs(C,old_species, pref_load=pref_load)
	if(ishuman(C))
		apply_markings_to_body_parts(C.dna.body_markings, C)

	if(exotic_bloodtype && C.dna.blood_type != exotic_bloodtype)
		C.dna.blood_type = exotic_bloodtype

	if(old_species.mutanthands)
		for(var/obj/item/I in C.held_items)
			if(istype(I, old_species.mutanthands))
				qdel(I)

	if(mutanthands)
		// Drop items in hands
		// If you're lucky enough to have a TRAIT_NODROP item, then it stays.
		for(var/V in C.held_items)
			var/obj/item/I = V
			if(istype(I))
				C.dropItemToGround(I)
			else	//Entries in the list should only ever be items or null, so if it's not an item, we can assume it's an empty hand
				C.put_in_hands(new mutanthands())

	for(var/X in inherent_traits)
		ADD_TRAIT(C, X, SPECIES_TRAIT)

	if(TRAIT_VIRUSIMMUNE in inherent_traits)
		for(var/datum/disease/A in C.diseases)
			A.cure(FALSE)

	if(TRAIT_TOXIMMUNE in inherent_traits)
		C.setToxLoss(0, TRUE, TRUE)

	if(TRAIT_NOMETABOLISM in inherent_traits)
		C.reagents.end_metabolization(C, keep_liverless = TRUE)

	if(TRAIT_RADIMMUNE in inherent_traits)
		C.dna.remove_all_mutations() // Radiation immune mobs can't get mutations normally

	if(inherent_factions)
		for(var/i in inherent_factions)
			C.faction += i //Using +=/-= for this in case you also gain the faction from a different source.

	if(flying_species && isnull(fly))
		fly = new
		fly.Grant(C)

	soundpack_m = new soundpack_m()
	soundpack_f = new soundpack_f()

	C.add_movespeed_modifier(MOVESPEED_ID_SPECIES, TRUE, 100, override=TRUE, multiplicative_slowdown=speedmod, movetypes=(~FLYING))

	C.remove_all_bodypart_features()
	for(var/bodypart_feature_type in bodypart_features)
		var/datum/bodypart_feature/feature = new bodypart_feature_type()
		if(!is_bodypart_feature_slot_allowed(C, feature.feature_slot))
			continue
		C.add_bodypart_feature(feature)
	if(pref_load)
		pref_load.apply_customizers_to_character(C)
	
	for(var/language_type in languages)
		C.grant_language(language_type)

	SEND_SIGNAL(C, COMSIG_SPECIES_GAIN, src, old_species)


/datum/species/proc/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	if(C.dna.species.exotic_bloodtype)
		C.dna.blood_type = random_blood_type()
	if(DIGITIGRADE in species_traits)
		C.Digitigrade_Leg_Swap(TRUE)
	for(var/X in inherent_traits)
		REMOVE_TRAIT(C, X, SPECIES_TRAIT)

	//If their inert mutation is not the same, swap it out
	if((inert_mutation != new_species.inert_mutation) && LAZYLEN(C.dna.mutation_index) && (inert_mutation in C.dna.mutation_index))
		C.dna.remove_mutation(inert_mutation)
		//keep it at the right spot, so we can't have people taking shortcuts
		var/location = C.dna.mutation_index.Find(inert_mutation)
		C.dna.mutation_index[location] = new_species.inert_mutation
		C.dna.mutation_index[new_species.inert_mutation] = create_sequence(new_species.inert_mutation)

	if(inherent_factions)
		for(var/i in inherent_factions)
			C.faction -= i

	if(flying_species)
		fly.Remove(C)
		QDEL_NULL(fly)
		if(C.movement_type & FLYING)
			ToggleFlight(C)

	C.remove_movespeed_modifier(MOVESPEED_ID_SPECIES)

	for(var/language_type in languages)
		C.remove_language(language_type)
	
	// Clear organ DNA since it wont match as we're changing the species
	C.dna.organ_dna = list()

	SEND_SIGNAL(C, COMSIG_SPECIES_LOSS, src)

/datum/species/proc/handle_body(mob/living/carbon/human/H)
	H.remove_overlay(BODY_LAYER)
	H.remove_overlay(ABOVE_BODY_FRONT_LAYER)

	var/list/standing = list()

	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)

	if(HD && !(HAS_TRAIT(H, TRAIT_HUSK)) && !HD.skeletonized)
		// lipstick
		if(H.lip_style && (LIPS in species_traits))
			var/mutable_appearance/lip_overlay = mutable_appearance('icons/mob/human_face.dmi', "lips_[H.lip_style]", -BODY_LAYER)
			lip_overlay.color = H.lip_color
			if(H.gender == MALE)
				if(OFFSET_FACE in H.dna.species.offset_features)
					lip_overlay.pixel_x += H.dna.species.offset_features[OFFSET_FACE][1]
					lip_overlay.pixel_y += H.dna.species.offset_features[OFFSET_FACE][2]
			else
				if(OFFSET_FACE_F in H.dna.species.offset_features)
					lip_overlay.pixel_x += H.dna.species.offset_features[OFFSET_FACE_F][1]
					lip_overlay.pixel_y += H.dna.species.offset_features[OFFSET_FACE_F][2]
			standing += lip_overlay


#ifdef MATURESERVER
		if(H.dna.species.hairyness)
			var/mutable_appearance/bodyhair_overlay
			if(H.gender == MALE)
				bodyhair_overlay = mutable_appearance(H.dna.species.limbs_icon_m, "[H.dna.species.hairyness]", -BODY_LAYER)
			else
				bodyhair_overlay = mutable_appearance(H.dna.species.limbs_icon_f, "[H.dna.species.hairyness]", -BODY_LAYER)
			bodyhair_overlay.color = "#" + H.hair_color
			standing += bodyhair_overlay
#endif

	if(standing.len)
		H.overlays_standing[BODY_LAYER] = standing

	H.apply_overlay(BODY_LAYER)
	H.apply_overlay(ABOVE_BODY_FRONT_LAYER)

//This exists so sprite accessories can still be per-layer without having to include that layer's
//number in their sprite name, which causes issues when those numbers change.
/datum/species/proc/mutant_bodyparts_layertext(layer)
	switch(layer)
		if(BODY_BEHIND_LAYER)
			return "BEHIND"
		if(BODY_ADJ_LAYER)
			return "ADJ"
		if(BODY_FRONT_LAYER)
			return "FRONT"


/datum/species/proc/spec_life(mob/living/carbon/human/H)
	if(HAS_TRAIT(H, TRAIT_NOBREATH))
		H.setOxyLoss(0)
		H.losebreath = 0

		var/takes_crit_damage = (!HAS_TRAIT(H, TRAIT_NOCRITDAMAGE))
		if((H.health < H.crit_threshold) && takes_crit_damage)
			H.adjustBruteLoss(1)
	if(flying_species)
		HandleFlight(H)

/datum/species/proc/spec_death(gibbed, mob/living/carbon/human/H)
	return

/datum/species/proc/auto_equip(mob/living/carbon/human/H)
	// handles the equipping of species-specific gear
	return

/datum/species/proc/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self = FALSE)
	if(slot in no_equip)
		if(!I.species_exception || !is_type_in_list(src, I.species_exception))
			return FALSE

	var/is_nudist = HAS_TRAIT(H, TRAIT_NUDIST)
	var/is_retarded = HAS_TRAIT(H, TRAIT_RETARD_ANATOMY)
	var/num_arms = H.get_num_arms(FALSE)
	var/num_legs = H.get_num_legs(FALSE)

	switch(slot)
		if(SLOT_HANDS)
			if(H.get_empty_held_indexes())
				return TRUE
			return FALSE
		if(SLOT_WEAR_MASK)
			if(H.wear_mask)
				return FALSE
			if(is_retarded)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_MASK))
				return FALSE
			if(!H.get_bodypart(BODY_ZONE_HEAD))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_MOUTH)
			if(H.mouth)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_MOUTH))
				return FALSE
			if(!H.get_bodypart(BODY_ZONE_HEAD))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_NECK)
			if(H.wear_neck)
				return FALSE
			if( !(I.slot_flags & ITEM_SLOT_NECK) )
				return FALSE
			return TRUE
		if(SLOT_BACK)
			if(H.back)
				return FALSE
			if( !(I.slot_flags & ITEM_SLOT_BACK) )
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_BACK_R)
			if(H.backr)
				return FALSE
			if( (I.slot_flags & ITEM_SLOT_CLOAK) )
				if(H.cloak)
					if((H.cloak.slot_flags & ITEM_SLOT_BACK_R) )
						return FALSE
			if( !(I.slot_flags & ITEM_SLOT_BACK_R) )
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_BACK_L)
			if(H.backl)
				return FALSE
			if( !(I.slot_flags & ITEM_SLOT_BACK_L) )
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_ARMOR)
			if(H.wear_armor)
				return FALSE
			if(is_nudist)
				return FALSE
			if(I.blocking_behavior & BULKYBLOCKS)
				if(H.cloak)
					return FALSE
				if(istype(H.cloak, I.type))
					return FALSE
			if(H.wear_shirt)
				if(H.wear_shirt.blocking_behavior & BULKYBLOCKS)
					return FALSE
				if(istype(H.wear_shirt, I.type))
					return FALSE
				if(I.blocksound)
					if(I.blocksound == H.wear_shirt.blocksound)
						return FALSE
			if( !(I.slot_flags & ITEM_SLOT_ARMOR) )
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_GLOVES)
			if(H.gloves)
				return FALSE
			if(is_nudist)
				return FALSE
			if( !(I.slot_flags & ITEM_SLOT_GLOVES) )
				return FALSE
			if(num_arms < 1)
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_SHOES)
			if(H.shoes)
				return FALSE
			if(is_nudist || is_retarded)
				return FALSE
			if( !(I.slot_flags & ITEM_SLOT_SHOES) )
				return FALSE
			if(num_legs < 1)
				return FALSE
			if(DIGITIGRADE in species_traits)
				if(!disable_warning)
					to_chat(H, span_warning("The footwear around here isn't compatible with my feet!"))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_BELT)
			if(H.belt)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_BELT))
				return
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_BELT_R)
			if(H.beltr)
				return FALSE
			if(!H.belt)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_HIP))
				return
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_BELT_L)
			if(H.beltl)
				return FALSE
			if(!H.belt)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_HIP))
				return
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_HEAD)
			if(H.head)
				return FALSE
			if(is_retarded)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_HEAD))
				return FALSE
			if(!H.get_bodypart(BODY_ZONE_HEAD))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_PANTS)
			if(H.wear_pants)
				return FALSE
			if(is_nudist)
				return FALSE
			if( !(I.slot_flags & ITEM_SLOT_PANTS) )
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_SHIRT)
			if(H.wear_shirt)
				return FALSE
			if(is_nudist)
				return FALSE
			if(I.blocking_behavior & BULKYBLOCKS)
				if(H.cloak)
					return FALSE
				if(H.wear_armor)
					return FALSE
			if(H.wear_armor)
				if(istype(H.wear_armor, I.type))
					return FALSE
				if(I.blocksound)
					if(I.blocksound == H.wear_armor.blocksound)
						return FALSE
			if( !(I.slot_flags & ITEM_SLOT_SHIRT) )
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_CLOAK)
			if(H.cloak)
				return FALSE
			if(is_nudist)
				return FALSE
			if( (I.slot_flags & ITEM_SLOT_BACK_R) )
				if(H.backr)
					if((H.backr.slot_flags & ITEM_SLOT_CLOAK) )
						return FALSE
			if(H.wear_shirt)
				if(H.wear_shirt.blocking_behavior & BULKYBLOCKS)
					return FALSE
				if(istype(H.wear_shirt, I.type))
					return FALSE
			if(H.wear_armor)
				if(H.wear_armor.blocking_behavior & BULKYBLOCKS)
					return FALSE
				if(istype(H.wear_armor, I.type))
					return FALSE
			if( !(I.slot_flags & ITEM_SLOT_CLOAK) )
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_RING)
			if(H.wear_ring)
				return FALSE
			if( !(I.slot_flags & ITEM_SLOT_RING) )
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_WRISTS)
			if(H.wear_wrists)
				return FALSE
			if(is_nudist)
				return FALSE
			if( !(I.slot_flags & ITEM_SLOT_WRISTS) )
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(SLOT_L_STORE)
			if(HAS_TRAIT(I, TRAIT_NODROP)) //Pockets aren't visible, so you can't move TRAIT_NODROP items into them.
				return FALSE
			if(H.l_store)
				return FALSE

			var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_L_LEG)

			if(!H.wear_pants && !nojumpsuit && (!O || O.status != BODYPART_ROBOTIC))
				if(!disable_warning)
					to_chat(H, span_warning("I need a jumpsuit before you can attach this [I.name]!"))
				return FALSE
			if(I.slot_flags & ITEM_SLOT_DENYPOCKET)
				return FALSE
			if( I.w_class <= WEIGHT_CLASS_SMALL || (I.slot_flags & ITEM_SLOT_POCKET) )
				return TRUE
		if(SLOT_R_STORE)
			if(HAS_TRAIT(I, TRAIT_NODROP))
				return FALSE
			if(H.r_store)
				return FALSE

			var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_R_LEG)

			if(!H.wear_pants && !nojumpsuit && (!O || O.status != BODYPART_ROBOTIC))
				if(!disable_warning)
					to_chat(H, span_warning("I need a jumpsuit before you can attach this [I.name]!"))
				return FALSE
			if(I.slot_flags & ITEM_SLOT_DENYPOCKET)
				return FALSE
			if( I.w_class <= WEIGHT_CLASS_SMALL || (I.slot_flags & ITEM_SLOT_POCKET) )
				return TRUE
			return FALSE
		if(SLOT_S_STORE)
			if(HAS_TRAIT(I, TRAIT_NODROP))
				return FALSE
			if(H.s_store)
				return FALSE
			if(!H.wear_armor)
				if(!disable_warning)
					to_chat(H, span_warning("I need a suit before you can attach this [I.name]!"))
				return FALSE
			if(!H.wear_armor.allowed)
				if(!disable_warning)
					to_chat(H, span_warning("I somehow have a suit with no defined allowed items for suit storage, stop that."))
				return FALSE
			if(I.w_class > WEIGHT_CLASS_BULKY)
				if(!disable_warning)
					to_chat(H, span_warning("The [I.name] is too big to attach!")) //should be src?
				return FALSE
			if( istype(I, /obj/item/pda) || istype(I, /obj/item/pen) || is_type_in_list(I, H.wear_armor.allowed) )
				return TRUE
			return FALSE
		if(SLOT_HANDCUFFED)
			if(H.handcuffed)
				return FALSE
			if(!I.breakouttime)
				return FALSE
//			if(num_arms < 2)
//				return FALSE
			return TRUE
		if(SLOT_LEGCUFFED)
			if(H.legcuffed)
				return FALSE
			if(!I.breakouttime)
				return FALSE
			if(num_legs < 2)
				return FALSE
			return TRUE
		if(SLOT_IN_BACKPACK)
			testing("STARTYES")
			if(H.backr)
				if(SEND_SIGNAL(H.backr, COMSIG_TRY_STORAGE_CAN_INSERT, I, H, TRUE))
					return TRUE
			if(H.backl)
				if(SEND_SIGNAL(H.backl, COMSIG_TRY_STORAGE_CAN_INSERT, I, H, TRUE))
					return TRUE
			if(H.beltr)
				if(SEND_SIGNAL(H.beltr, COMSIG_TRY_STORAGE_CAN_INSERT, I, H, TRUE))
					return TRUE
			if(H.beltl)
				if(SEND_SIGNAL(H.beltl, COMSIG_TRY_STORAGE_CAN_INSERT, I, H, TRUE))
					return TRUE
			if(H.belt)
				if(SEND_SIGNAL(H.belt, COMSIG_TRY_STORAGE_CAN_INSERT, I, H, TRUE))
					return TRUE
			testing("NONONO")
			return FALSE
	return FALSE //Unsupported slot

/datum/species/proc/equip_delay_self_check(obj/item/I, mob/living/carbon/human/H, bypass_equip_delay_self)
	if(!I.equip_delay_self || bypass_equip_delay_self)
		return TRUE
	if(HAS_TRAIT(H, TRAIT_CHUNKYFINGERS))
		return do_after(H, 5 MINUTES, target = H)
//	H.visible_message(span_notice("[H] start putting on [I]..."), span_notice("I start putting on [I]..."))
	if(I.edelay_type)
		return move_after(H, minone(I.equip_delay_self-H.STASPD), target = H)
	else
		return do_after(H, minone(I.equip_delay_self-H.STASPD), target = H)

/datum/species/proc/before_equip_job(datum/job/J, mob/living/carbon/human/H)
	return

/datum/species/proc/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	return

/datum/species/proc/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == exotic_blood)
		H.blood_volume = min(H.blood_volume + round(chem.volume, 0.1), BLOOD_VOLUME_MAXIMUM)
		H.reagents.del_reagent(chem.type)
		return TRUE
	if(chem.overdose_threshold && chem.volume >= chem.overdose_threshold)
		chem.overdosed = TRUE

/datum/species/proc/check_species_weakness(obj/item, mob/living/attacker)
	return 0 //This is not a boolean, it's the multiplier for the damage that the user takes from the item.It is added onto the check_weakness value of the mob, and then the force of the item is multiplied by this value

/**
 * Equip the outfit required for life. Replaces items currently worn.
 */
/datum/species/proc/give_important_for_life(mob/living/carbon/human/human_to_equip)
	if(!outfit_important_for_life)
		return

	outfit_important_for_life= new()
	outfit_important_for_life.equip(human_to_equip)

////////
//LIFE//
////////

/datum/species/proc/handle_digestion(mob/living/carbon/human/H)
	if(HAS_TRAIT(H, TRAIT_NOHUNGER))
		return //hunger is for BABIES

	//The fucking TRAIT_FAT mutation is the dumbest shit ever. It makes the code so difficult to work with
//	if(HAS_TRAIT_FROM(H, TRAIT_FAT, OBESITY))//I share my pain, past coder.
//		if(H.overeatduration < 100)
//			to_chat(H, span_notice("I feel fit again!"))
//			REMOVE_TRAIT(H, TRAIT_FAT, OBESITY)
//			H.remove_movespeed_modifier(MOVESPEED_ID_FAT)
//			H.update_inv_w_uniform()
//			H.update_inv_wear_suit()
//	else
//		if(H.overeatduration >= 100)
//			to_chat(H, span_danger("I suddenly feel blubbery!"))
//			ADD_TRAIT(H, TRAIT_FAT, OBESITY)
//			H.add_movespeed_modifier(MOVESPEED_ID_FAT, multiplicative_slowdown = 1.5)
//			H.update_inv_w_uniform()
//			H.update_inv_wear_suit()

	// nutrition decrease and satiety
	if (H.nutrition > 0 && H.stat != DEAD && !HAS_TRAIT(H, TRAIT_NOHUNGER))
		// THEY HUNGER
		var/hunger_rate = HUNGER_FACTOR
/*		if(H.satiety > MAX_SATIETY)
			H.satiety = MAX_SATIETY
		else if(H.satiety > 0)
			H.satiety--
		else if(H.satiety < -MAX_SATIETY)
			H.satiety = -MAX_SATIETY
		else if(H.satiety < 0)
			H.satiety++
			if(prob(round(-H.satiety/40)))
				H.Jitter(5)
			hunger_rate = 10 * HUNGER_FACTOR*/
//		hunger_rate *= H.physiology.hunger_mod
		H.adjust_nutrition(-hunger_rate)


	if (H.hydration > 0 && H.stat != DEAD && !HAS_TRAIT(H, TRAIT_NOHUNGER))
		// THEY HUNGER
		var/hunger_rate = HUNGER_FACTOR
//		hunger_rate *= H.physiology.hunger_mod
		H.adjust_hydration(-hunger_rate)


	if (H.nutrition > NUTRITION_LEVEL_FULL)
		if(H.overeatduration < 600) //capped so people don't take forever to unfat
			H.overeatduration++
	else
		if(H.overeatduration > 1)
			H.overeatduration -= 2 //doubled the unfat rate

	//metabolism change
//	if(H.nutrition > NUTRITION_LEVEL_FAT)
//		H.metabolism_efficiency = 1
//	else if(H.nutrition > NUTRITION_LEVEL_FED && H.satiety > 80)
//		if(H.metabolism_efficiency != 1.25 && !HAS_TRAIT(H, TRAIT_NOHUNGER))
//			to_chat(H, span_notice("I feel vigorous."))
//			H.metabolism_efficiency = 1.25
//	else if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
//		if(H.metabolism_efficiency != 0.8)
//			to_chat(H, span_notice("I feel sluggish."))
//		H.metabolism_efficiency = 0.8
//	else
//		if(H.metabolism_efficiency == 1.25)
//			to_chat(H, span_notice("I no longer feel vigorous."))
//		H.metabolism_efficiency = 1

	//Hunger slowdown for if mood isn't enabled
//	if(CONFIG_GET(flag/disable_human_mood))
//		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
//			var/hungry = (500 - H.nutrition) / 5 //So overeat would be 100 and default level would be 80
//			if(hungry >= 70)
//				H.add_movespeed_modifier(MOVESPEED_ID_HUNGRY, override = TRUE, multiplicative_slowdown = (hungry / 50))
//			else if(isethereal(H))
//				var/datum/species/ethereal/E = H.dna.species
//				if(E.get_charge(H) <= ETHEREAL_CHARGE_NORMAL)
//					H.add_movespeed_modifier(MOVESPEED_ID_HUNGRY, override = TRUE, multiplicative_slowdown = (1.5 * (1 - E.get_charge(H) / 100)))
//			else
//				H.remove_movespeed_modifier(MOVESPEED_ID_HUNGRY)

	switch(H.nutrition)
//		if(NUTRITION_LEVEL_FAT to INFINITY) //currently disabled/999999 define
//			if(H.rogstam >= H.maxrogstam)
//				H.apply_status_effect(/datum/status_effect/debuff/fat)
		if(NUTRITION_LEVEL_FAT to INFINITY)
			H.add_stress(/datum/stressevent/stuffed)
			H.remove_stress(list(/datum/stressevent/peckish,/datum/stressevent/hungry,/datum/stressevent/starving))
		if(NUTRITION_LEVEL_FED to NUTRITION_LEVEL_FAT)
			H.remove_stress(list(/datum/stressevent/peckish,/datum/stressevent/hungry,/datum/stressevent/starving))
		if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FED)
			H.add_stress(/datum/stressevent/peckish)
			H.remove_stress(list(/datum/stressevent/stuffed,/datum/stressevent/hungry,/datum/stressevent/starving))
			H.apply_status_effect(/datum/status_effect/debuff/hungryt1)
		if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
			H.add_stress(/datum/stressevent/hungry)
			H.remove_stress(list(/datum/stressevent/stuffed,/datum/stressevent/peckish,/datum/stressevent/starving))
			H.apply_status_effect(/datum/status_effect/debuff/hungryt2)
		if(0 to NUTRITION_LEVEL_STARVING)
			H.add_stress(/datum/stressevent/starving)
			H.remove_stress(list(/datum/stressevent/stuffed,/datum/stressevent/peckish,/datum/stressevent/hungry))
			H.apply_status_effect(/datum/status_effect/debuff/hungryt3)
			if(prob(3))
				playsound(get_turf(H), pick('sound/vo/hungry1.ogg','sound/vo/hungry2.ogg','sound/vo/hungry3.ogg'), 100, TRUE, -1)

	switch(H.hydration)
//		if(HYDRATION_LEVEL_WATERLOGGED to INFINITY)
//			H.apply_status_effect(/datum/status_effect/debuff/waterlogged)
		if(HYDRATION_LEVEL_SMALLTHIRST to HYDRATION_LEVEL_FULL)
			H.remove_stress(list(/datum/stressevent/drym,/datum/stressevent/thirst,/datum/stressevent/parched))
		if(HYDRATION_LEVEL_THIRSTY to HYDRATION_LEVEL_SMALLTHIRST)
			H.add_stress(/datum/stressevent/drym)
			H.remove_stress(list(/datum/stressevent/parched,/datum/stressevent/thirst))
			H.apply_status_effect(/datum/status_effect/debuff/thirstyt1)
		if(HYDRATION_LEVEL_DEHYDRATED to HYDRATION_LEVEL_THIRSTY)
			H.add_stress(/datum/stressevent/thirst)
			H.remove_stress(list(/datum/stressevent/parched,/datum/stressevent/drym))
			H.apply_status_effect(/datum/status_effect/debuff/thirstyt2)
		if(0 to HYDRATION_LEVEL_DEHYDRATED)
			H.add_stress(/datum/stressevent/parched)
			H.remove_stress(list(/datum/stressevent/thirst,/datum/stressevent/drym))
			H.apply_status_effect(/datum/status_effect/debuff/thirstyt3)


/datum/species/proc/update_health_hud(mob/living/carbon/human/H)
	return 0

/datum/species/proc/handle_mutations_and_radiation(mob/living/carbon/human/H)
	. = FALSE
	var/radiation = H.radiation

	if(HAS_TRAIT(H, TRAIT_RADIMMUNE))
		radiation = 0
		return TRUE

	if(radiation > RAD_MOB_KNOCKDOWN && prob(RAD_MOB_KNOCKDOWN_PROB))
		if(!H.IsParalyzed())
			H.emote("collapse", TRUE)
		H.Paralyze(RAD_MOB_KNOCKDOWN_AMOUNT)
		to_chat(H, span_danger("I feel weak."))

	if(radiation > RAD_MOB_VOMIT && prob(RAD_MOB_VOMIT_PROB))
		H.vomit(10, TRUE)

	if(radiation > RAD_MOB_MUTATE)
		if(prob(1))
			to_chat(H, span_danger("I mutate!"))
			H.easy_randmut(NEGATIVE+MINOR_NEGATIVE)
			H.emote("gasp")
			H.domutcheck()

	if(radiation > RAD_MOB_HAIRLOSS)
		if(prob(15) && !(H.hairstyle == "Bald") && (HAIR in species_traits))
			to_chat(H, span_danger("My hair starts to fall out in clumps..."))
			addtimer(CALLBACK(src, PROC_REF(go_bald), H), 50)

/datum/species/proc/go_bald(mob/living/carbon/human/H)
	if(QDELETED(H))	//may be called from a timer
		return
	if(H.gender == MALE)
		H.facial_hairstyle = "Shaved"
	if(H.gender == FEMALE)
		H.facial_hairstyle = "Nothing"
	H.hairstyle = "Bald"
	H.update_hair()

//////////////////
// ATTACK PROCS //
//////////////////

/datum/species/proc/spec_updatehealth(mob/living/carbon/human/H)
	return

/datum/species/proc/spec_fully_heal(mob/living/carbon/human/H)
	return

/datum/species/proc/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
//	if(!((target.health < 0 || HAS_TRAIT(target, TRAIT_FAKEDEATH)) && !(target.mobility_flags & MOBILITY_STAND)))
	if(!(target.mobility_flags & MOBILITY_STAND))
		target.help_shake_act(user)
		if(target != user)
			log_combat(user, target, "shaken")
		return 1
/*	else
		var/we_breathe = !HAS_TRAIT(user, TRAIT_NOBREATH)
		var/we_lung = user.getorganslot(ORGAN_SLOT_LUNGS)

		if(we_breathe && we_lung)
			user.do_cpr(target)
		else if(we_breathe && !we_lung)
			to_chat(user, span_warning("I have no lungs to breathe with, so you cannot perform CPR!"))
		else
			to_chat(user, span_warning("I do not breathe, so you cannot perform CPR!"))*/

/datum/species/proc/grab(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(target.check_block())
		target.visible_message(span_warning("[target] blocks [user]'s grab!"), \
						span_danger("I block [user]'s grab!"), span_hear("I hear a swoosh!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_warning("My grab at [target] was blocked!"))
		return FALSE
	if(attacker_style && attacker_style.grab_act(user,target))
		return TRUE
	else
/*		//Steal them shoes
		if(!(target.mobility_flags & MOBILITY_STAND) && (user.zone_selected == BODY_ZONE_L_LEG || user.zone_selected == BODY_ZONE_R_LEG) && user.used_intent.type == INTENT_GRAB && target.shoes)
			var/obj/item/I = target.shoes
			user.visible_message(span_warning("[user] starts stealing [target]'s [I.name]!"),
							span_danger("I start stealing [target]'s [I.name]..."), null, null, target)
			to_chat(target, span_danger("[user] starts stealing my [I.name]!"))
			if(do_after(user, I.strip_delay, TRUE, target, TRUE))
				target.dropItemToGround(I, TRUE)
				user.put_in_hands(I)
				user.visible_message(span_warning("[user] stole [target]'s [I.name]!"),
								span_notice("I stole [target]'s [I.name]!"), null, null, target)
				to_chat(target, span_danger("[user] stole my [I.name]!"))*/
		target.grabbedby(user)
		return TRUE

///This proc handles punching damage. IMPORTANT: Our owner is the TARGET and not the USER in this proc. For whatever reason...
/datum/species/proc/harm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to harm [target]!"))
		return FALSE
	if(target.check_block())
		target.visible_message(span_warning("[target] blocks [user]'s attack!"), \
						span_danger("I block [user]'s attack!"), span_hear("I hear a swoosh!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_warning("My attack at [target] was blocked!"))
		return FALSE
	if(attacker_style && attacker_style.harm_act(user,target))
		return TRUE
	else

//		var/atk_verb = user.dna.species.attack_verb
//		if(!(target.mobility_flags & MOBILITY_STAND))
//			atk_verb = ATTACK_EFFECT_KICK

//	switch(atk_verb)//this code is really stupid but some genius apparently made "claw" and "slash" two attack types but also the same one so it's needed i guess
//		if(ATTACK_EFFECT_KICK)
//			user.do_attack_animation(target, ATTACK_EFFECT_KICK)
//		if(ATTACK_EFFECT_SLASH || ATTACK_EFFECT_CLAW)//smh
//			user.do_attack_animation(target, ATTACK_EFFECT_CLAW)
//		if(ATTACK_EFFECT_SMASH)
//			user.do_attack_animation(target, ATTACK_EFFECT_SMASH)
///			else
//				user.do_attack_animation(target, ATTACK_EFFECT_PUNCH)

		var/cached_intent = user.used_intent
		sleep(user.used_intent.swingdelay)
		if(user.a_intent != cached_intent)
			return FALSE
		if(!target.Adjacent(user))
			return
		if(user.incapacitated())
			return

		var/damage = user.get_punch_dmg()

/*		var/miss_chance = 100//calculate the odds that a punch misses entirely. considers stamina and brute damage of the puncher. punches miss by default to prevent weird cases
		if(user.dna.species.punchdamagelow)
			if(atk_verb == ATTACK_EFFECT_KICK) //kicks never miss (provided my species deals more than 0 damage)
				miss_chance = 0
			else
				miss_chance = min((user.dna.species.punchdamagehigh/user.dna.species.punchdamagelow) + user.getStaminaLoss() + (user.getBruteLoss()*0.5), 100) //old base chance for a miss + various damage. capped at 100 to prevent weirdness in prob()

		if(!damage || !affecting || prob(miss_chance))//future-proofing for species that have 0 damage/weird cases where no zone is targeted
			playsound(target.loc, user.dna.species.miss_sound, 25, TRUE, -1)
			target.visible_message(span_danger("[user]'s [atk_verb] misses [target]!"), \
							span_danger("I avoid [user]'s [atk_verb]!"), span_hear("I hear a swoosh!"), COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_warning("My [atk_verb] misses [target]!"))
			log_combat(user, target, "attempted to punch")
			return FALSE
*/
		var/selzone = accuracy_check(user.zone_selected, user, target, /datum/skill/combat/unarmed, user.used_intent)

		var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(selzone))

		if(!affecting)
			to_chat(user, span_warning("Unfortunately, there's nothing there."))
			return 0

		if(!target.lying_attack_check(user))
			return 0

		var/armor_block = target.run_armor_check(selzone, "blunt", blade_dulling = user.used_intent.blade_class)

		target.lastattacker = user.real_name
		if(target.mind)
			target.mind.attackedme[user.real_name] = world.time
		target.lastattackerckey = user.ckey
		user.dna.species.spec_unarmedattacked(user, target)

		target.next_attack_msg.Cut()

		var/nodmg = FALSE

		if(!target.apply_damage(damage, user.dna.species.attack_type, affecting, armor_block))
			nodmg = TRUE
			target.next_attack_msg += " <span class='warning'>Armor stops the damage.</span>"
		else
			affecting.bodypart_attacked_by(user.used_intent.blade_class, damage, user, selzone, crit_message = TRUE)
		log_combat(user, target, "punched")

		if(!nodmg)
			if(user.limb_destroyer)
				var/easy_dismember = HAS_TRAIT(target, TRAIT_EASYDISMEMBER) || affecting.rotted
				var/probability = damage / (2 - easy_dismember)
				if(HAS_TRAIT(target, TRAIT_HARDDISMEMBER) && !easy_dismember)
					probability = min(probability, 5)
				if(prob(probability) && affecting.dismember())
					playsound(get_turf(target), "desecration", 80, TRUE)

/*		if(user == target)
			target.visible_message(span_danger("[user] [atk_verb]ed themself![target.next_attack_msg.Join()]"), COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_userdanger("I [atk_verb] myself![target.next_attack_msg.Join()]"))
		else
			target.visible_message(span_danger("[user] [atk_verb]ed [target]![target.next_attack_msg.Join()]"), \
							span_userdanger("I'm [atk_verb]ed by [user]![target.next_attack_msg.Join()]"), span_hear("I hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_danger("I [atk_verb] [target]![target.next_attack_msg.Join()]"))
*/
		var/message_verb = "punched"
		if(user.used_intent)
			message_verb = "[pick(user.used_intent.attack_verb)]"
		var/message_hit_area = ""
		if(selzone)
			message_hit_area = " in the [parse_zone(selzone)]"
		var/attack_message = "[user] [message_verb] [target][message_hit_area]!"
		var/attack_message_local = "[user] [message_verb] me[message_hit_area]!"
		target.visible_message(span_danger("[attack_message][target.next_attack_msg.Join()]"),\
			span_danger("[attack_message_local][target.next_attack_msg.Join()]"), null, COMBAT_MESSAGE_RANGE)
		target.next_attack_msg.Cut()

		target.retaliate(user)

/*		if((target.stat != DEAD) && damage >= user.dna.species.punchstunthreshold)
			target.visible_message(span_danger("[user] knocks [target] down!"), \
							span_danger("You're knocked down by [user]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_danger("I knock [target] down!"))
			var/knockdown_duration = 40 + (target.getStaminaLoss() + (target.getBruteLoss()*0.5))*0.8 //50 total damage = 40 base stun + 40 stun modifier = 80 stun duration, which is the old base duration
			target.apply_effect(knockdown_duration, EFFECT_KNOCKDOWN, armor_block)
			target.forcesay(GLOB.hit_appends)
			log_combat(user, target, "got a stun punch with their previous punch")*/
		if(!(target.mobility_flags & MOBILITY_STAND))
			target.forcesay(GLOB.hit_appends)
		if(!nodmg)
			playsound(target.loc, user.used_intent.hitsound, 100, FALSE)


/datum/species/proc/spec_unarmedattacked(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return

/datum/species/proc/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(target.check_block())
		target.visible_message(span_warning("[user]'s shove is blocked by [target]!"), \
						span_danger("I block [user]'s shove!"), span_hear("I hear a swoosh!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_warning("My shove at [target] was blocked!"))
		return FALSE
	if(attacker_style && attacker_style.disarm_act(user,target))
		return TRUE
	if(!(user.mobility_flags & MOBILITY_STAND) || user.IsKnockdown())
		return FALSE
//	if(!(target.mobility_flags & MOBILITY_STAND))
//		to_chat(user, span_warning("."))
//		return FALSE
	if(user == target)
		return FALSE
	if(user.loc == target.loc)
		return FALSE
	else
		user.do_attack_animation(target, ATTACK_EFFECT_DISARM)
		playsound(target, 'sound/combat/shove.ogg', 100, TRUE, -1)

		if(target.wear_pants)
			target.wear_pants.add_fingerprint(user)
		SEND_SIGNAL(target, COMSIG_HUMAN_DISARM_HIT, user, user.zone_selected)

		var/turf/target_oldturf = target.loc
		var/shove_dir = get_dir(user.loc, target_oldturf)
		var/turf/target_shove_turf = get_step(target.loc, shove_dir)
		var/mob/living/target_collateral_mob
		var/obj/structure/table/target_table
//		var/obj/machinery/disposal/bin/target_disposal_bin
		var/shove_blocked = FALSE //Used to check if a shove is blocked so that if it is knockdown logic can be applied

		if(prob(30 + generic_stat_comparison(user.STASTR, target.STACON) ))//check if we actually shove them
			//Thank you based whoneedsspace
			target_collateral_mob = locate(/mob/living) in target_shove_turf.contents
			if(target_collateral_mob)
				shove_blocked = TRUE
			else
				target.Move(target_shove_turf, shove_dir)
				if(get_turf(target) == target_oldturf)
					target_table = locate(/obj/structure/table) in target_shove_turf.contents
	//				target_disposal_bin = locate(/obj/machinery/disposal/bin) in target_shove_turf.contents
					if(target_table)
						shove_blocked = TRUE

/*		if(target.IsKnockdown() && !target.IsParalyzed())
			target.Paralyze(SHOVE_CHAIN_PARALYZE)
			target.visible_message(span_danger("[user.name] kicks [target.name] onto their side!"),
							span_danger("You're kicked onto my side by [user.name]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_danger("I kick [target.name] onto their side!"))
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living, SetKnockdown), 0), SHOVE_CHAIN_PARALYZE)
			log_combat(user, target, "kicks", "onto their side (paralyzing)")*/

		if(shove_blocked && !target.is_shove_knockdown_blocked() && !target.buckled)
			var/directional_blocked = FALSE
			if(shove_dir in GLOB.cardinals) //Directional checks to make sure that we're not shoving through a windoor or something like that
				var/target_turf = get_turf(target)
				for(var/obj/O in target_turf)
					if(O.flags_1 & ON_BORDER_1 && O.dir == shove_dir && O.density)
						directional_blocked = TRUE
						break
				if(target_turf != target_shove_turf) //Make sure that we don't run the exact same check twice on the same tile
					for(var/obj/O in target_shove_turf)
						if(O.flags_1 & ON_BORDER_1 && O.dir == turn(shove_dir, 180) && O.density)
							directional_blocked = TRUE
							break
			if((!target_table && !target_collateral_mob) || directional_blocked)
				target.Knockdown(SHOVE_KNOCKDOWN_SOLID)
				target.visible_message(span_danger("[user.name] shoves [target.name], knocking them down!"),
								span_danger("You're knocked down from a shove by [user.name]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
				to_chat(user, span_danger("I shove [target.name], knocking them down!"))
				log_combat(user, target, "shoved", "knocking them down")
			else if(target_table)
				target.Knockdown(SHOVE_KNOCKDOWN_TABLE)
				target.visible_message(span_danger("[user.name] shoves [target.name] onto \the [target_table]!"),
								span_danger("I'm shoved onto \the [target_table] by [user.name]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
				to_chat(user, span_danger("I shove [target.name] onto \the [target_table]!"))
				target.throw_at(target_table, 1, 1, null, FALSE) //1 speed throws with no spin are basically just forcemoves with a hard collision check
				log_combat(user, target, "shoved", "onto [target_table] (table)")
			else if(target_collateral_mob)
				target.Knockdown(SHOVE_KNOCKDOWN_HUMAN)
				target_collateral_mob.Knockdown(SHOVE_KNOCKDOWN_COLLATERAL)
				target.visible_message(span_danger("[user.name] shoves [target.name] into [target_collateral_mob.name]!"),
					span_danger("I'm shoved into [target_collateral_mob.name] by [user.name]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
				to_chat(user, span_danger("I shove [target.name] into [target_collateral_mob.name]!"))
				log_combat(user, target, "shoved", "into [target_collateral_mob.name]")
		else
			target.visible_message(span_danger("[user.name] shoves [target.name]!"),
							span_danger("I'm shoved by [user.name]!"), span_hear("I hear aggressive shuffling!"), COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_danger("I shove [target.name]!"))
			var/target_held_item = target.get_active_held_item()
			var/knocked_item = FALSE
			if(!is_type_in_typecache(target_held_item, GLOB.shove_disarming_types))
				target_held_item = null
			if(!target.has_movespeed_modifier(MOVESPEED_ID_SHOVE))
				target.add_movespeed_modifier(MOVESPEED_ID_SHOVE, multiplicative_slowdown = SHOVE_SLOWDOWN_STRENGTH)
				if(target_held_item)
					target.visible_message(span_danger("[target.name]'s grip on \the [target_held_item] loosens!"),
						span_warning("My grip on \the [target_held_item] loosens!"), null, COMBAT_MESSAGE_RANGE)
				addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, clear_shove_slowdown)), SHOVE_SLOWDOWN_LENGTH)
			else if(target_held_item)
				target.dropItemToGround(target_held_item)
				knocked_item = TRUE
				target.visible_message(span_danger("[target.name] drops \the [target_held_item]!"),
					span_warning("I drop \the [target_held_item]!"), null, COMBAT_MESSAGE_RANGE)
			var/append_message = ""
			if(target_held_item)
				if(knocked_item)
					append_message = "causing them to drop [target_held_item]"
				else
					append_message = "loosening their grip on [target_held_item]"
			log_combat(user, target, "shoved", append_message)

//shameless copypaste
/datum/species/proc/kicked(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to harm [target]!"))
		return FALSE
	if(user.IsKnockdown())
		return FALSE
	if(user == target)
		return FALSE
	if(user.check_leg_grabbed(1) || user.check_leg_grabbed(2))
		to_chat(user, span_notice("I can't move my leg!"))
		return
	if(user.rogfat >= user.maxrogfat)
		return FALSE
	if(!(user.mobility_flags & MOBILITY_STAND))
		return FALSE
	var/stander = TRUE
	if(!(target.mobility_flags & MOBILITY_STAND))
		stander = FALSE
	if(!get_dist(user, target))
		if(!stander && (user.mobility_flags & MOBILITY_STAND))
			target.lastattacker = user.real_name
			target.lastattackerckey = user.ckey
			if(target.mind)
				target.mind.attackedme[user.real_name] = world.time
			var/selzone = accuracy_check(user.zone_selected, user, target, /datum/skill/combat/unarmed, user.used_intent)
			var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(selzone))
			var/armor_block = target.run_armor_check(selzone, "blunt", blade_dulling = BCLASS_BLUNT)
			var/damage = user.get_punch_dmg() * 1.4
			target.next_attack_msg.Cut()
			var/nodmg = FALSE
			if(!target.apply_damage(damage, user.dna.species.attack_type, affecting, armor_block))
				nodmg = TRUE
				target.next_attack_msg += " <span class='warning'>Armor stops the damage.</span>"
			else
				if(affecting)
					affecting.bodypart_attacked_by(BCLASS_BLUNT, damage, user, user.zone_selected, crit_message = TRUE)
			target.visible_message(span_danger("[user] stomps [target]![target.next_attack_msg.Join()]"), \
							span_danger("I'm stomped by [user]![target.next_attack_msg.Join()]"), span_hear("I hear a sickening kick!"), COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_danger("I stomp on [target]![target.next_attack_msg.Join()]"))
			target.next_attack_msg.Cut()
			log_combat(user, target, "kicked")
			user.do_attack_animation(target, ATTACK_EFFECT_DISARM)
			if(!nodmg)
				playsound(target, 'sound/combat/hits/kick/stomp.ogg', 100, TRUE, -1)
			return TRUE
		else
			to_chat(user, span_warning("I'm too close to get a good kick in."))
			return FALSE
	else
		if(!target.kick_attack_check(user))
			return 0

		user.do_attack_animation(target, ATTACK_EFFECT_DISARM)
		playsound(target, 'sound/combat/hits/kick/kick.ogg', 100, TRUE, -1)

		var/turf/target_oldturf = target.loc
		var/shove_dir = get_dir(user.loc, target_oldturf)
		var/turf/target_shove_turf = get_step(target.loc, shove_dir)
		var/mob/living/target_collateral_mob
		var/obj/structure/table/target_table
		var/shove_blocked = FALSE //Used to check if a shove is blocked so that if it is knockdown logic can be applied

		target_collateral_mob = locate(/mob/living) in target_shove_turf.contents
		if(target_collateral_mob)
			if(stander)
				shove_blocked = TRUE
		else
			target.Move(target_shove_turf, shove_dir)
			if(get_turf(target) == target_oldturf)
				if(stander)
					target_table = locate(/obj/structure/table) in target_shove_turf.contents
					shove_blocked = TRUE
			else
				if(stander && target.rogfat >= target.maxrogfat) //if you are kicked while fatigued, you are knocked down no matter what
					target.Knockdown(100)

		if(shove_blocked && !target.is_shove_knockdown_blocked() && !target.buckled)
			var/directional_blocked = FALSE
			if(shove_dir in GLOB.cardinals) //Directional checks to make sure that we're not shoving through a windoor or something like that
				var/target_turf = get_turf(target)
				for(var/obj/O in target_turf)
					if(O.flags_1 & ON_BORDER_1 && O.dir == shove_dir && O.density)
						directional_blocked = TRUE
						break
				if(target_turf != target_shove_turf) //Make sure that we don't run the exact same check twice on the same tile
					for(var/obj/O in target_shove_turf)
						if(O.flags_1 & ON_BORDER_1 && O.dir == turn(shove_dir, 180) && O.density)
							directional_blocked = TRUE
							break
			if((!target_table && !target_collateral_mob) || directional_blocked)
				target.Knockdown(SHOVE_KNOCKDOWN_SOLID)
				target.visible_message(span_danger("[user.name] kicks [target.name], knocking them down!"),
								span_danger("I'm knocked down from a kick by [user.name]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
				to_chat(user, span_danger("I kick [target.name], knocking them down!"))
				log_combat(user, target, "kicked", "knocking them down")
			else if(target_table)
				target.Knockdown(SHOVE_KNOCKDOWN_TABLE)
				target.visible_message(span_danger("[user.name] kicked [target.name] onto \the [target_table]!"),
								span_danger("I'm kicked onto \the [target_table] by [user.name]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
				to_chat(user, span_danger("I kick [target.name] onto \the [target_table]!"))
				target.throw_at(target_table, 1, 1, null, FALSE) //1 speed throws with no spin are basically just forcemoves with a hard collision check
				log_combat(user, target, "kicked", "onto [target_table] (table)")
			else if(target_collateral_mob)
				target.Knockdown(SHOVE_KNOCKDOWN_HUMAN)
				target_collateral_mob.Knockdown(SHOVE_KNOCKDOWN_COLLATERAL)
				target.visible_message(span_danger("[user.name] kicks [target.name] into [target_collateral_mob.name]!"),
					span_danger("I'm kicked into [target_collateral_mob.name] by [user.name]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
				to_chat(user, span_danger("I kick [target.name] into [target_collateral_mob.name]!"))
				log_combat(user, target, "kicked", "into [target_collateral_mob.name]")
		else
			target.visible_message(span_danger("[user.name] kicks [target.name]!"),
							span_danger("I'm kicked by [user.name]!"), span_hear("I hear aggressive shuffling!"), COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_danger("I kick [target.name]!"))
			log_combat(user, target, "kicked")

		var/selzone = accuracy_check(user.zone_selected, user, target, /datum/skill/combat/unarmed, user.used_intent)
		var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(selzone))
		if(!affecting)
			affecting = target.get_bodypart(BODY_ZONE_CHEST)
		var/armor_block = target.run_armor_check(selzone, "blunt", blade_dulling = BCLASS_BLUNT)
		var/damage = user.get_punch_dmg()
		if(!target.apply_damage(damage, user.dna.species.attack_type, affecting, armor_block))
			target.next_attack_msg += " <span class='warning'>Armor stops the damage.</span>"
		else
			affecting.bodypart_attacked_by(BCLASS_BLUNT, damage, user, selzone)
		playsound(target, 'sound/combat/hits/kick/kick.ogg', 100, TRUE, -1)
		target.lastattacker = user.real_name
		target.lastattackerckey = user.ckey
		if(target.mind)
			target.mind.attackedme[user.real_name] = world.time
		user.rogfat_add(15)
		target.forcesay(GLOB.hit_appends)

/datum/species/proc/spec_hitby(atom/movable/AM, mob/living/carbon/human/H)
	return

/datum/species/proc/spec_attack_hand(mob/living/carbon/human/M, mob/living/carbon/human/H, datum/martial_art/attacker_style)
	if(!istype(M))
		return
	CHECK_DNA_AND_SPECIES(M)
	CHECK_DNA_AND_SPECIES(H)

	if(!istype(M)) //sanity check for drones.
		return
	if(M.mind)
		attacker_style = M.mind.martial_art
	if((M != H) && M.used_intent.type != INTENT_HELP && H.check_shields(M, 0, M.name, attack_type = UNARMED_ATTACK))
		log_combat(M, H, "attempted to touch")
		H.visible_message(span_warning("[M] attempts to touch [H]!"), \
						span_danger("[M] attempts to touch you!"), span_hear("I hear a swoosh!"), COMBAT_MESSAGE_RANGE, M)
		to_chat(M, span_warning("I attempt to touch [H]!"))
		return 0
	SEND_SIGNAL(M, COMSIG_MOB_ATTACK_HAND, M, H, attacker_style)
	switch(M.used_intent.type)
		if(INTENT_HELP)
			help(M, H, attacker_style)
			return

		if(INTENT_GRAB)
			if(!M.has_hand_for_held_index(M.active_hand_index, TRUE)) //we obviously have a hadn, but we need to check for fingers/prosthetics
				to_chat(M, span_warning("I can't move the fingers."))
				return
			grab(M, H, attacker_style)
			return

		if(INTENT_DISARM)
			disarm(M, H, attacker_style)
			return
	if(istype(M.used_intent, /datum/intent/unarmed))
		harm(M, H, attacker_style)

/datum/species/proc/spec_attacked_by(obj/item/I, mob/living/user, obj/item/bodypart/affecting, intent, mob/living/carbon/human/H, selzone)
	// Allows you to put in item-specific reactions based on species
	if(user != H)
		if(H.check_shields(I, I.force, "the [I.name]", MELEE_ATTACK, I.armor_penetration))
			return 0
	if(H.check_block())
		H.visible_message(span_warning("[H] blocks [I]!"), \
						span_danger("I block [I]!"))
		return 0

	var/hit_area

	selzone = accuracy_check(user.zone_selected, user, H, I.associated_skill, user.used_intent, I)
	affecting = H.get_bodypart(check_zone(selzone))

	if(!affecting)
		return

	hit_area = affecting.name
	var/def_zone = affecting.body_zone

	var/pen = I.armor_penetration
	if(user.used_intent?.penfactor)
		pen = I.armor_penetration + user.used_intent.penfactor

//	var/armor_block = H.run_armor_check(affecting, "I.d_type", span_notice("My armor has protected my [hit_area]!"), span_warning("My armor has softened a hit to my [hit_area]!"),pen)

	var/Iforce = get_complex_damage(I, user) //to avoid runtimes on the forcesay checks at the bottom. Some items might delete themselves if you drop them. (stunning yourself, ninja swords)
	var/armor_block = H.run_armor_check(selzone, I.d_type, "", "",pen, damage = Iforce, blade_dulling=user.used_intent.blade_class)

	var/nodmg = FALSE

	if(Iforce)
		H.retaliate(user)

		var/weakness = H.check_weakness(I, user)
		H.next_attack_msg.Cut()
		if(!apply_damage(Iforce * weakness, I.damtype, def_zone, armor_block, H))
			nodmg = TRUE
			H.next_attack_msg += " <span class='warning'>Armor stops the damage.</span>"
			if(I)
				I.take_damage(1, BRUTE, I.d_type)
		if(!nodmg)
			var/datum/wound/crit_wound = affecting.bodypart_attacked_by(user.used_intent.blade_class, (Iforce * weakness) * ((100-(armor_block+armor))/100), user, selzone, crit_message = TRUE)
			if(should_embed_weapon(crit_wound, I))
				var/can_impale = TRUE
				if(!affecting)
					can_impale = FALSE
				else if(I.wlength > WLENGTH_SHORT && (affecting.body_zone != BODY_ZONE_CHEST))
					can_impale = FALSE
				if(can_impale && user.Adjacent(H))
					affecting.add_embedded_object(I, silent = FALSE, crit_message = TRUE)
					H.emote("embed")
					H.grabbedby(user, 1, item_override = I)
//		if(H.used_intent.blade_class == BCLASS_BLUNT && I.force >= 15 && affecting.body_zone == "chest")
//			var/turf/target_shove_turf = get_step(H.loc, get_dir(user.loc,H.loc))
//			H.throw_at(target_shove_turf, 1, 1, H, spin = FALSE)

	I.funny_attack_effects(H, user, nodmg)

	H.send_item_attack_message(I, user, parse_zone(selzone))

	if(nodmg)
		return FALSE //dont play a sound

	//dismemberment
	var/bloody = 0
	var/probability = I.get_dismemberment_chance(affecting, user)
	if(affecting.brute_dam && prob(probability) && affecting.dismember(I.damtype, user.used_intent?.blade_class, user, selzone))
		bloody = 1
		I.add_mob_blood(H)
		user.update_inv_hands()
		playsound(get_turf(H), I.get_dismember_sound(), 80, TRUE)

	if(((I.damtype == BRUTE) && I.force && prob(25 + (I.force * 2))))
		if(affecting.status == BODYPART_ORGANIC)
			I.add_mob_blood(H)	//Make the weapon bloody, not the person.
			user.update_inv_hands()
			if(prob(I.force * 2) || bloody)	//blood spatter!
				bloody = 1
				var/turf/location = H.loc
				var/splatter_dir = get_dir(H, user)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(H.loc, splatter_dir)
				if(istype(location))
					H.add_splatter_floor(location)
				if(get_dist(user, H) <= 1)	//people with TK won't get smeared with blood
					user.add_mob_blood(H)

		switch(hit_area)
			if(BODY_ZONE_HEAD)
				if(!I.get_sharpness() && armor_block < 50)
//					if(prob(I.force))
//						H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
//						if(H.stat == CONSCIOUS)
//							H.visible_message(span_danger("[H] is knocked senseless!"), span_danger("You're knocked senseless!"))
//							H.confused = max(H.confused, 20)
//							H.adjust_blurriness(10)
//						if(prob(10))
//							H.gain_trauma(/datum/brain_trauma/mild/concussion)
//					else
//						H.adjustOrganLoss(ORGAN_SLOT_BRAIN, I.force * 0.2)

					if(H.mind && H.stat == CONSCIOUS && H != user && prob(I.force + ((100 - H.health) * 0.5))) // rev deconversion through blunt trauma.
						var/datum/antagonist/rev/rev = H.mind.has_antag_datum(/datum/antagonist/rev)
						if(rev)
							rev.remove_revolutionary(FALSE, user)

				if(bloody)	//Apply blood
					if(H.wear_mask)
						H.wear_mask.add_mob_blood(H)
						H.update_inv_wear_mask()
					if(H.head)
						H.head.add_mob_blood(H)
						H.update_inv_head()
					if(H.glasses && prob(33))
						H.glasses.add_mob_blood(H)
						H.update_inv_glasses()

			if(BODY_ZONE_CHEST)
//				if(H.stat == CONSCIOUS && !I.get_sharpness() && armor_block < 50)
//					if(prob(I.force))
//						H.visible_message(span_danger("[H] is knocked down!"), span_danger("You're knocked down!"))
//						H.apply_effect(60, EFFECT_KNOCKDOWN, armor_block)

				if(bloody)
					if(H.wear_armor)
						H.wear_armor.add_mob_blood(H)
						H.update_inv_armor()
					if(H.wear_shirt)
						H.wear_shirt.add_mob_blood(H)
						H.update_inv_shirt()
					if(H.wear_pants)
						H.wear_pants.add_mob_blood(H)
						H.update_inv_pants()

		if(Iforce > 10 || Iforce >= 5 && prob(Iforce))
			H.forcesay(GLOB.hit_appends)	//forcesay checks stat already.
	return TRUE

/datum/species/proc/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked, mob/living/carbon/human/H, forced = FALSE, spread_damage = FALSE)
	SEND_SIGNAL(H, COMSIG_MOB_APPLY_DAMGE, damage, damagetype, def_zone)
	var/hit_percent = 1
	damage = max(damage-blocked+armor,0)
//	var/hit_percent =  (100-(blocked+armor))/100
	hit_percent = (hit_percent * (100-H.physiology.damage_resistance))/100
	if(!damage || (!forced && hit_percent <= 0))
		return 0

	var/obj/item/bodypart/BP = null
	if(!spread_damage)
		if(isbodypart(def_zone))
			BP = def_zone
		else
			if(!def_zone)
				def_zone = ran_zone(def_zone)
			BP = H.get_bodypart(check_zone(def_zone))
			if(!BP)
				BP = H.bodyparts[1]

	switch(damagetype)
		if(BRUTE)
			H.damageoverlaytemp = 20
			var/damage_amount = forced ? damage : damage * hit_percent * brutemod * H.physiology.brute_mod
			if(!HAS_TRAIT(H, TRAIT_NOPAIN))
				if(damage_amount > 5)
					H.AdjustSleeping(-50)
					if(prob(damage_amount * 3))
						if(damage_amount > ((H.STACON*10) / 3))
							H.emote("painscream")
						else
							H.emote("pain")
				if(damage_amount > ((H.STACON*10) / 3) && !HAS_TRAIT(H, TRAIT_NOPAINSTUN))
					H.Immobilize(8)
					shake_camera(H, 2, 2)
					H.stuttering += 5
				if(damage_amount > 10 && !HAS_TRAIT(H, TRAIT_NOPAINSTUN))
					H.Slowdown(clamp(damage_amount/10, 1, 5))
					shake_camera(H, 1, 1)
				if(damage_amount < 10)
					H.flash_fullscreen("redflash1")
				else if(damage_amount < 20)
					H.flash_fullscreen("redflash2")
				else if(damage_amount >= 20)
					H.flash_fullscreen("redflash3")
			if(BP)
				if(BP.receive_damage(damage_amount, 0))
					H.update_damage_overlays()
			else//no bodypart, we deal damage with a more general method.
				H.adjustBruteLoss(damage_amount)
		if(BURN)
			H.damageoverlaytemp = 20
			var/damage_amount = forced ? damage : damage * hit_percent * burnmod * H.physiology.burn_mod
			if(damage_amount > 10 && prob(damage_amount))
				H.emote("pain")
			if(damage_amount < 10)
				H.flash_fullscreen("redflash1")
			else if(damage_amount < 20)
				H.flash_fullscreen("redflash2")
			else if(damage_amount >= 20)
				H.flash_fullscreen("redflash3")
			if(BP)
				if(BP.receive_damage(0, damage_amount))
					H.update_damage_overlays()
			else
				H.adjustFireLoss(damage_amount)
		if(TOX)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.tox_mod
			H.adjustToxLoss(damage_amount)
		if(OXY)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.oxy_mod
			H.adjustOxyLoss(damage_amount)
		if(CLONE)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.clone_mod
			H.adjustCloneLoss(damage_amount)
		if(STAMINA)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.stamina_mod
			if(BP)
				if(BP.receive_damage(0, 0, damage_amount))
					H.update_stamina()
			else
				H.adjustStaminaLoss(damage_amount)
		if(BRAIN)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.brain_mod
			H.adjustOrganLoss(ORGAN_SLOT_BRAIN, damage_amount)
	return 1

/datum/species/proc/on_hit(obj/projectile/P, mob/living/carbon/human/H)
	// called when hit by a projectile
	switch(P.type)
		if(/obj/projectile/energy/floramut) // overwritten by plants/pods
			H.show_message(span_notice("The radiation beam dissipates harmlessly through my body."))
		if(/obj/projectile/energy/florayield)
			H.show_message(span_notice("The radiation beam dissipates harmlessly through my body."))

/datum/species/proc/bullet_act(obj/projectile/P, mob/living/carbon/human/H, def_zone = BODY_ZONE_CHEST)
	// called before a projectile hit
	if(def_zone == "head")
		if(H.head)
			var/obj/item/I = H.head
			if(I.blockproj(H))
				return 1
	return 0

/obj/item/proc/blockproj(mob/living/carbon/human/H)
	return

/////////////
//BREATHING//
/////////////

/datum/species/proc/breathe(mob/living/carbon/human/H)
	if(HAS_TRAIT(H, TRAIT_NOBREATH))
		return TRUE


/datum/species/proc/handle_environment(datum/gas_mixture/environment, mob/living/carbon/human/H)
	if(!environment)
		return
	if(istype(H.loc, /obj/machinery/atmospherics/components/unary/cryo_cell))
		return

	var/loc_temp = H.get_temperature(environment)

	//Body temperature is adjusted in two parts: first there my body tries to naturally preserve homeostasis (shivering/sweating), then it reacts to the surrounding environment
	//Thermal protection (insulation) has mixed benefits in two situations (hot in hot places, cold in hot places)
	if(!H.on_fire) //If you're on fire, you do not heat up or cool down based on surrounding gases
		var/natural = 0
		if(H.stat != DEAD)
			natural = H.natural_bodytemperature_stabilization()
		var/thermal_protection = 1
		if(loc_temp < H.bodytemperature) //Place is colder than we are
			thermal_protection -= H.get_cold_protection(loc_temp) //This returns a 0 - 1 value, which corresponds to the percentage of protection based on what you're wearing and what you're exposed to.
			if(H.bodytemperature < BODYTEMP_NORMAL) //we're cold, insulation helps us retain body heat and will reduce the heat we lose to the environment
				H.adjust_bodytemperature((thermal_protection+1)*natural + max(thermal_protection * (loc_temp - H.bodytemperature) / BODYTEMP_COLD_DIVISOR, BODYTEMP_COOLING_MAX))
			else //we're sweating, insulation hinders our ability to reduce heat - and it will reduce the amount of cooling you get from the environment
				H.adjust_bodytemperature(natural*(1/(thermal_protection+1)) + max((thermal_protection * (loc_temp - H.bodytemperature) + BODYTEMP_NORMAL - H.bodytemperature) / BODYTEMP_COLD_DIVISOR , BODYTEMP_COOLING_MAX)) //Extra calculation for hardsuits to bleed off heat
	if (loc_temp > H.bodytemperature) //Place is hotter than we are
		var/natural = 0
		if(H.stat != DEAD)
			natural = H.natural_bodytemperature_stabilization()
		var/thermal_protection = 1
		thermal_protection -= H.get_heat_protection(loc_temp) //This returns a 0 - 1 value, which corresponds to the percentage of protection based on what you're wearing and what you're exposed to.
		if(H.bodytemperature < BODYTEMP_NORMAL) //and we're cold, insulation enhances our ability to retain body heat but reduces the heat we get from the environment
			H.adjust_bodytemperature((thermal_protection+1)*natural + min(thermal_protection * (loc_temp - H.bodytemperature) / BODYTEMP_HEAT_DIVISOR, BODYTEMP_HEATING_MAX))
		else //we're sweating, insulation hinders out ability to reduce heat - but will reduce the amount of heat we get from the environment
			H.adjust_bodytemperature(natural*(1/(thermal_protection+1)) + min(thermal_protection * (loc_temp - H.bodytemperature) / BODYTEMP_HEAT_DIVISOR, BODYTEMP_HEATING_MAX))

	// +/- 50 degrees from 310K is the 'safe' zone, where no damage is dealt.
	if(H.bodytemperature > BODYTEMP_HEAT_DAMAGE_LIMIT && !HAS_TRAIT(H, TRAIT_RESISTHEAT))
		//Body temperature is too hot.

		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "cold")
		SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "hot", /datum/mood_event/hot)

		H.remove_movespeed_modifier(MOVESPEED_ID_COLD)

		var/burn_damage
		var/firemodifier = H.fire_stacks / 50
		if (H.on_fire)
			burn_damage = 20
			if(H.fire_stacks >= HUMAN_FIRE_STACK_ICON_NUM)
				burn_damage = 200
		else
			firemodifier = min(firemodifier, 0)
			burn_damage = max(log(2-firemodifier,(H.bodytemperature-BODYTEMP_NORMAL))-5,0) // this can go below 5 at log 2.5
		if (burn_damage)
			switch(burn_damage)
				if(0 to 2)
					H.throw_alert("temp", /atom/movable/screen/alert/hot, 1)
				if(2 to 4)
					H.throw_alert("temp", /atom/movable/screen/alert/hot, 2)
				else
					H.throw_alert("temp", /atom/movable/screen/alert/hot, 3)
		burn_damage = burn_damage * heatmod * H.physiology.heat_mod
		if (H.stat < UNCONSCIOUS && (prob(burn_damage) * 10) / 4) //40% for level 3 damage on humans
			H.emote("pain")
		H.apply_damage(burn_damage, BURN, spread_damage = TRUE)

	else if(H.bodytemperature < BODYTEMP_COLD_DAMAGE_LIMIT && !HAS_TRAIT(H, TRAIT_RESISTCOLD))
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "hot")
		SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "cold", /datum/mood_event/cold)
		//Sorry for the nasty oneline but I don't want to assign a variable on something run pretty frequently
		H.add_movespeed_modifier(MOVESPEED_ID_COLD, override = TRUE, multiplicative_slowdown = ((BODYTEMP_COLD_DAMAGE_LIMIT - H.bodytemperature) / COLD_SLOWDOWN_FACTOR), blacklisted_movetypes = FLOATING)
		switch(H.bodytemperature)
			if(200 to BODYTEMP_COLD_DAMAGE_LIMIT)
				H.throw_alert("temp", /atom/movable/screen/alert/cold, 1)
				H.apply_damage(COLD_DAMAGE_LEVEL_1*coldmod*H.physiology.cold_mod, BURN)
			if(120 to 200)
				H.throw_alert("temp", /atom/movable/screen/alert/cold, 2)
				H.apply_damage(COLD_DAMAGE_LEVEL_2*coldmod*H.physiology.cold_mod, BURN)
			else
				H.throw_alert("temp", /atom/movable/screen/alert/cold, 3)
				H.apply_damage(COLD_DAMAGE_LEVEL_3*coldmod*H.physiology.cold_mod, BURN)

	else
		H.clear_alert("temp")
		H.remove_movespeed_modifier(MOVESPEED_ID_COLD)
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "cold")
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "hot")

	var/pressure = environment.return_pressure()
	var/adjusted_pressure = H.calculate_affecting_pressure(pressure) //Returns how much pressure actually affects the mob.
	switch(adjusted_pressure)
		if(HAZARD_HIGH_PRESSURE to INFINITY)
			if(!HAS_TRAIT(H, TRAIT_RESISTHIGHPRESSURE))
				H.adjustBruteLoss(min(((adjusted_pressure / HAZARD_HIGH_PRESSURE) -1 ) * PRESSURE_DAMAGE_COEFFICIENT, MAX_HIGH_PRESSURE_DAMAGE) * H.physiology.pressure_mod)
				H.throw_alert("pressure", /atom/movable/screen/alert/highpressure, 2)
			else
				H.clear_alert("pressure")
		if(WARNING_HIGH_PRESSURE to HAZARD_HIGH_PRESSURE)
			H.throw_alert("pressure", /atom/movable/screen/alert/highpressure, 1)
		if(WARNING_LOW_PRESSURE to WARNING_HIGH_PRESSURE)
			H.clear_alert("pressure")
		if(HAZARD_LOW_PRESSURE to WARNING_LOW_PRESSURE)
			H.throw_alert("pressure", /atom/movable/screen/alert/lowpressure, 1)
		else
			if(HAS_TRAIT(H, TRAIT_RESISTLOWPRESSURE))
				H.clear_alert("pressure")
			else
				H.adjustBruteLoss(LOW_PRESSURE_DAMAGE * H.physiology.pressure_mod)
				H.throw_alert("pressure", /atom/movable/screen/alert/lowpressure, 2)

//////////
// FIRE //
//////////

/datum/species/proc/handle_fire(mob/living/carbon/human/H, no_protection = FALSE)
	if(!CanIgniteMob(H))
		return TRUE
	if(H.on_fire)
		//the fire tries to damage the exposed clothes and items
		var/list/burning_items = list()
		var/list/obscured = H.check_obscured_slots(TRUE)
		//HEAD//

		if(H.glasses && !(SLOT_GLASSES in obscured))
			burning_items += H.glasses
		if(H.wear_mask && !(SLOT_WEAR_MASK in obscured))
			burning_items += H.wear_mask
		if(H.wear_neck && !(SLOT_NECK in obscured))
			burning_items += H.wear_neck
		if(H.head && !(SLOT_HEAD in obscured))
			burning_items += H.head

		//CHEST//
		if(H.wear_pants && !(SLOT_PANTS in obscured))
			burning_items += H.wear_pants
		if(H.wear_shirt && !(SLOT_SHIRT in obscured))
			burning_items += H.wear_shirt
		if(H.wear_armor && !(SLOT_ARMOR in obscured))
			burning_items += H.wear_armor

		//ARMS & HANDS//
		var/obj/item/clothing/arm_clothes = null
		if(H.gloves && !(SLOT_GLOVES in obscured))
			arm_clothes = H.gloves
		else if(H.wear_armor && ((H.wear_armor.body_parts_covered & HANDS) || (H.wear_armor.body_parts_covered & ARMS)))
			arm_clothes = H.wear_armor
		else if(H.wear_pants && ((H.wear_pants.body_parts_covered & HANDS) || (H.wear_pants.body_parts_covered & ARMS)))
			arm_clothes = H.wear_pants
		if(arm_clothes)
			burning_items |= arm_clothes

		//LEGS & FEET//
		var/obj/item/clothing/leg_clothes = null
		if(H.shoes && !(SLOT_SHOES in obscured))
			leg_clothes = H.shoes
		else if(H.wear_armor && ((H.wear_armor.body_parts_covered & FEET) || (H.wear_armor.body_parts_covered & LEGS)))
			leg_clothes = H.wear_armor
		else if(H.wear_pants && ((H.wear_pants.body_parts_covered & FEET) || (H.wear_pants.body_parts_covered & LEGS)))
			leg_clothes = H.wear_pants
		if(leg_clothes)
			burning_items |= leg_clothes

		for(var/X in burning_items)
			var/obj/item/I = X
			I.fire_act((H.fire_stacks * 50)) //damage taken is reduced to 2% of this value by fire_act()

		var/thermal_protection = H.get_thermal_protection()

		if(thermal_protection >= FIRE_IMMUNITY_MAX_TEMP_PROTECT && !no_protection)
			return
		if(thermal_protection >= FIRE_SUIT_MAX_TEMP_PROTECT && !no_protection)
			H.adjust_bodytemperature(11)
		else
			H.adjust_bodytemperature(BODYTEMP_HEATING_MAX + (H.fire_stacks * 12))
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "on_fire", /datum/mood_event/on_fire)

/datum/species/proc/CanIgniteMob(mob/living/carbon/human/H)
	if(HAS_TRAIT(H, TRAIT_NOFIRE))
		return FALSE
	return TRUE

/datum/species/proc/ExtinguishMob(mob/living/carbon/human/H)
	return

/datum/species/proc/get_random_body_markings(list/features) //Needs features to base the colour off of
	return list()


////////////
//  Stun  //
////////////

/datum/species/proc/spec_stun(mob/living/carbon/human/H,amount)
	if(flying_species && H.movement_type & FLYING)
		ToggleFlight(H)
		flyslip(H)
	. = stunmod * H.physiology.stun_mod * amount

//////////////
//Space Move//
//////////////

/datum/species/proc/space_move(mob/living/carbon/human/H)
	if(H.movement_type & FLYING)
		return TRUE
	return FALSE

/datum/species/proc/negates_gravity(mob/living/carbon/human/H)
	if(H.movement_type & FLYING)
		return TRUE
	return FALSE

////////////////
//Tail Wagging//
////////////////

/datum/species/proc/can_wag_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/obj/item/organ/tail/T = H.getorganslot(ORGAN_SLOT_TAIL)
	if(!T)
		return FALSE
	if(T.can_wag)
		return TRUE
	return FALSE

/datum/species/proc/is_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/obj/item/organ/tail/T = H.getorganslot(ORGAN_SLOT_TAIL)
	if(!T)
		return FALSE
	return T.wagging

/datum/species/proc/start_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return
	var/obj/item/organ/tail/T = H.getorganslot(ORGAN_SLOT_TAIL)
	if(!T)
		return FALSE
	T.wagging = TRUE
	H.update_body()

/datum/species/proc/stop_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return
	var/obj/item/organ/tail/T = H.getorganslot(ORGAN_SLOT_TAIL)
	if(!T)
		return
	T.wagging = FALSE
	H.update_body()

///////////////
//FLIGHT SHIT//
///////////////

/datum/species/proc/GiveSpeciesFlight(mob/living/carbon/human/H)
	if(flying_species) //species that already have flying traits should not work with this proc
		return
	flying_species = TRUE
	if(isnull(fly))
		fly = new
		fly.Grant(H)

/datum/species/proc/HandleFlight(mob/living/carbon/human/H)
	if(H.movement_type & FLYING)
		if(!CanFly(H))
			ToggleFlight(H)
			return FALSE
		return TRUE
	else
		return FALSE

/datum/species/proc/CanFly(mob/living/carbon/human/H)
	if(H.stat || !(H.mobility_flags & MOBILITY_STAND))
		return FALSE
	if(H.wear_armor && ((H.wear_armor.flags_inv & HIDEJUMPSUIT) && (!H.wear_armor.species_exception || !is_type_in_list(src, H.wear_armor.species_exception))))	//Jumpsuits have tail holes, so it makes sense they have wing holes too
		to_chat(H, span_warning("My suit blocks my wings from extending!"))
		return FALSE
	var/turf/T = get_turf(H)
	if(!T)
		return FALSE

	var/datum/gas_mixture/environment = T.return_air()
	if(environment && !(environment.return_pressure() > 30))
		to_chat(H, span_warning("The atmosphere is too thin for you to fly!"))
		return FALSE
	else
		return TRUE

/datum/species/proc/flyslip(mob/living/carbon/human/H)
	var/obj/buckled_obj
	if(H.buckled)
		buckled_obj = H.buckled

	to_chat(H, span_notice("My wings spazz out and launch you!"))

	playsound(H.loc, 'sound/blank.ogg', 100, TRUE, -3)

	for(var/obj/item/I in H.held_items)
		H.accident(I)

	var/olddir = H.dir

	H.stop_pulling()
	if(buckled_obj)
		buckled_obj.unbuckle_mob(H)
		step(buckled_obj, olddir)
	else
		new /datum/forced_movement(H, get_ranged_target_turf(H, olddir, 4), 1, FALSE, CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon, spin), 1, 1))
	return TRUE

//UNSAFE PROC, should only be called through the Activate or other sources that check for CanFly
/datum/species/proc/ToggleFlight(mob/living/carbon/human/H)
	if(!(H.movement_type & FLYING))
		stunmod *= 2
		speedmod -= 0.35
		H.setMovetype(H.movement_type | FLYING)
		override_float = TRUE
		passtable_on(H, SPECIES_TRAIT)
		H.OpenWings()
		H.update_mobility()
	else
		stunmod *= 0.5
		speedmod += 0.35
		H.setMovetype(H.movement_type & ~FLYING)
		override_float = FALSE
		passtable_off(H, SPECIES_TRAIT)
		H.CloseWings()

/datum/action/innate/flight
	name = "Toggle Flight"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_STUN
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "flight"

/datum/action/innate/flight/Activate()
	var/mob/living/carbon/human/H = owner
	var/datum/species/S = H.dna.species
	if(S.CanFly(H))
		S.ToggleFlight(H)
		if(!(H.movement_type & FLYING))
			to_chat(H, span_notice("I settle gently back onto the ground..."))
		else
			to_chat(H, span_notice("I beat my wings and begin to hover gently above the ground..."))
			H.set_resting(FALSE, TRUE)

/datum/species/proc/knockback(obj/item/I, mob/living/target, mob/living/user, nodmg)
	if(!istype(I))
		if(!target.resting)
			var/chungus_str = target.STASTR
			var/knockback_tiles = 0
			var/damage = user.get_punch_dmg()
			if(chungus_str >= 3)
				knockback_tiles = FLOOR(damage/((chungus_str - 2) * 2.5), 1)
			else
				knockback_tiles = FLOOR(damage/2, 1)
			if(knockback_tiles >= 1)
				var/turf/edge_target_turf = get_edge_target_turf(target, get_dir(user, target))
				if(istype(edge_target_turf))
					target.safe_throw_at(edge_target_turf, \
										knockback_tiles, \
										knockback_tiles, \
										user, \
										spin = FALSE, \
										force = target.move_force, \
										callback = CALLBACK(target, TYPE_PROC_REF(/mob/living, handle_knockback), get_turf(target)))
	else
		if(!I.force)
			return
		if(!I.sharpness)
			if(!target.resting)
				var/endurance = target.STAEND
				var/knockback_tiles = 0
				var/newforce = get_complex_damage(I, user)
				if(endurance >= 3)
					knockback_tiles = FLOOR(newforce/((endurance - 2) * 2.5), 1)
				else
					knockback_tiles = FLOOR(newforce/2, 1)
				if(knockback_tiles >= 1)
					var/turf/edge_target_turf = get_edge_target_turf(target, get_dir(user, target))
					if(istype(edge_target_turf))
						target.safe_throw_at(edge_target_turf, \
											knockback_tiles, \
											knockback_tiles, \
											user, \
											spin = FALSE, \
											force = target.move_force, \
											callback = CALLBACK(target, TYPE_PROC_REF(/mob/living, handle_knockback), get_turf(target)))

/mob/living/proc/handle_knockback(turf/starting_turf)
	var/distance = 0
	var/skill_modifier = 10
	if(istype(starting_turf) && !QDELETED(starting_turf))
		distance = get_dist(starting_turf, src)
	if(mind)
		skill_modifier = mind.get_skill_level(/datum/skill/misc/athletics)
	var/modifier = -distance
	if(!prob(STASPD+skill_modifier+modifier))
		Paralyze(15)
