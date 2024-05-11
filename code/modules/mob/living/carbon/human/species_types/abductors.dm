/datum/species/abductor
	name = "Abductor"
	id = "abductor"
	say_mod = "gibbers"
	sexes = FALSE
	species_traits = list(NOBLOOD,NOEYESPRITES)
	inherent_traits = list(TRAIT_VIRUSIMMUNE,TRAIT_CHUNKYFINGERS,TRAIT_NOHUNGER,TRAIT_NOBREATH)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/abductor,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		)

/datum/species/abductor/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.add_hud_to(C)

/datum/species/abductor/on_species_loss(mob/living/carbon/C)
	. = ..()
	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.remove_hud_from(C)
