SUBSYSTEM_DEF(traumas)
	name = "Traumas"
	flags = SS_NO_FIRE
	var/list/phobia_types
	var/list/phobia_words
	var/list/phobia_mobs
	var/list/phobia_objs
	var/list/phobia_turfs
	var/list/phobia_species

#define PHOBIA_FILE "phobia.json"

/datum/controller/subsystem/traumas/Initialize()
	//phobia types is to pull from randomly for brain traumas, e.g. conspiracies is for special assignment only
	phobia_types = sortList(list("spiders", "lizards",
						"skeletons", "snakes",
						"strangers", "birds", "falling", "anime"))

	phobia_words = list(
		"spiders"   = strings(PHOBIA_FILE, "spiders"),
		"lizards"   = strings(PHOBIA_FILE, "lizards"),
		"skeletons" = strings(PHOBIA_FILE, "skeletons"),
		"snakes"	= strings(PHOBIA_FILE, "snakes"),
		"strangers"	= strings(PHOBIA_FILE, "strangers"),
		"conspiracies" = strings(PHOBIA_FILE, "conspiracies"),
		"birds" = strings(PHOBIA_FILE, "birds"),
		"falling" = strings(PHOBIA_FILE, "falling"),
	)

	phobia_mobs = list(
		"spiders"          = typecacheof(list(/mob/living/simple_animal/hostile/poison/giant_spider)),

		"lizards"          = typecacheof(list(/mob/living/simple_animal/hostile/lizard)),
		"skeletons"        = typecacheof(list(/mob/living/simple_animal/hostile/skeleton)),
		"snakes"           = typecacheof(list(/mob/living/simple_animal/hostile/retaliate/poison/snake)),
		"the supernatural" = typecacheof(list(/mob/living/simple_animal/hostile/construct,
												/mob/living/simple_animal/revenant, /mob/living/simple_animal/shade)),
		"conspiracies"     = typecacheof(list(/mob/living/simple_animal/drone,
												/mob/living/simple_animal/pet/penguin)),
		"birds"            = typecacheof(list(/mob/living/simple_animal/parrot, /mob/living/simple_animal/chick, /mob/living/simple_animal/chicken,
												/mob/living/simple_animal/pet/penguin))
	)

	phobia_objs = list(
		"snakes" = typecacheof(list(/obj/item/rod_of_asclepius)),
		"spiders"   = typecacheof(list(/obj/structure/spider)),

		"lizards"   = typecacheof(list(/obj/item/toy/plush/lizardplushie, /obj/item/reagent_containers/food/snacks/kebab/tail,
									/obj/item/organ/tail/lizard, /obj/item/reagent_containers/food/drinks/bottle/lizardwine)),

		"skeletons" = typecacheof(list(/obj/item/organ/tongue/bone, /obj/item/clothing/suit/armor/bone, /obj/item/stack/sheet/bone,
										/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/skeleton,
										/obj/effect/decal/remains/human)),


		"birds" = typecacheof(list(/obj/item/clothing/mask/gas/plaguedoctor, /obj/item/reagent_containers/food/snacks/cracker,
									/obj/item/clothing/suit/chickensuit, /obj/item/clothing/head/chicken,
									/obj/item/clothing/suit/toggle/owlwings, /obj/item/clothing/under/costume/owl, /obj/item/clothing/mask/gas/owl_mask,
									/obj/item/clothing/under/costume/griffin, /obj/item/clothing/shoes/griffin, /obj/item/clothing/head/griffin)),

	)

	phobia_turfs = list(
		"the supernatural" = typecacheof(list(/turf/open/floor/plasteel/cult, /turf/closed/wall/mineral/cult)),
		"falling" = typecacheof(list(/turf/open/chasm, /turf/open/floor/fakepit))
	)

	phobia_species = list(
		"lizards" = typecacheof(list(/datum/species/lizard)),
		"skeletons" = typecacheof(list(/datum/species/skeleton, /datum/species/plasmaman)),
		"the supernatural" = typecacheof(list(/datum/species/golem/runic)),
	)

	return ..()

#undef PHOBIA_FILE
