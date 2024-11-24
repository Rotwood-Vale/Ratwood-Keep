//Subtype of human
/datum/species/human/felinid
	name = "Felinid"
	id = "felinid"
	limbs_id = "human"

	default_features = MANDATORY_FEATURE_LIST

	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	var/original_felinid = TRUE //set to false for felinids created by mass-purrbation
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/cat,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/cat
		)

/datum/species/human/felinid/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/human/felinid/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/M)
	.=..()
	if(chem.type == /datum/reagent/consumable/coco || chem.type == /datum/reagent/consumable/hot_coco || chem.type ==/datum/reagent/consumable/milk/chocolate_milk)
		if(prob(20))
			M.adjust_disgust(20)
		if(prob(5))
			M.visible_message(span_warning("[M] [pick("dry heaves!","coughs!","splutters!")]"))
		if(prob(10))
			var/sick_message = pick("Your insides revolt at the presence of lethal chocolate!", "You feel nyauseous.", "You're nya't feeling so good.","You feel like your insides are melting.","You feel illsies.")
			to_chat(M, span_notice("[sick_message]"))
		if(prob(35))
			var/obj/item/organ/guts = pick(M.internal_organs)
			guts.applyOrganDamage(15)
		return FALSE


/proc/mass_purrbation()
	for(var/M in GLOB.mob_list)
		if(ishuman(M))
			purrbation_apply(M)
		CHECK_TICK

/proc/mass_remove_purrbation()
	for(var/M in GLOB.mob_list)
		if(ishuman(M))
			purrbation_remove(M)
		CHECK_TICK

/proc/purrbation_toggle(mob/living/carbon/human/H, silent = FALSE)
	if(!ishumanbasic(H))
		return
	if(!isfelinid(H))
		purrbation_apply(H, silent)
		. = TRUE
	else
		purrbation_remove(H, silent)
		. = FALSE

/proc/purrbation_apply(mob/living/carbon/human/H, silent = FALSE)
	if(!ishuman(H) || isfelinid(H))
		return
	if(ishumanbasic(H))
		H.set_species(/datum/species/human/felinid)
		var/datum/species/human/felinid/cat_species = H.dna.species
		cat_species.original_felinid = FALSE
	else
		var/obj/item/organ/ears/cat/kitty_ears = new
		var/obj/item/organ/tail/cat/kitty_tail = new
		kitty_ears.Insert(H, TRUE, FALSE) //Gives nonhumans cat tail and ears
		kitty_tail.Insert(H, TRUE, FALSE)
	if(!silent)
		to_chat(H, span_boldnotice("Something is nya~t right."))
		playsound(get_turf(H), 'sound/blank.ogg', 50, TRUE, -1)

/proc/purrbation_remove(mob/living/carbon/human/H, silent = FALSE)
	if(isfelinid(H))
		var/datum/species/human/felinid/cat_species = H.dna.species
		if(!cat_species.original_felinid)
			H.set_species(/datum/species/human)
	if(!silent)
		to_chat(H, span_boldnotice("I are no longer a cat."))
