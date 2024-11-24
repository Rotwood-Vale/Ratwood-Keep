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
	phobia_types = sortList(list("spiders", "space", "security", "clowns", "greytide", "lizards",
						"skeletons", "snakes", "doctors", "authority", "the supernatural",
						"strangers", "birds", "falling", "anime"))

	phobia_words = list("spiders"   = strings(PHOBIA_FILE, "spiders"),
						"space"     = strings(PHOBIA_FILE, "space"),
						"security"  = strings(PHOBIA_FILE, "security"),
						"clowns"    = strings(PHOBIA_FILE, "clowns"),
						"greytide"  = strings(PHOBIA_FILE, "greytide"),
						"lizards"   = strings(PHOBIA_FILE, "lizards"),
						"skeletons" = strings(PHOBIA_FILE, "skeletons"),
						"snakes"	= strings(PHOBIA_FILE, "snakes"),
						"doctors"	= strings(PHOBIA_FILE, "doctors"),
						"authority"	= strings(PHOBIA_FILE, "authority"),
						"the supernatural"	= strings(PHOBIA_FILE, "the supernatural"),
						"strangers"	= strings(PHOBIA_FILE, "strangers"),
						"conspiracies" = strings(PHOBIA_FILE, "conspiracies"),
						"birds" = strings(PHOBIA_FILE, "birds"),
						"falling" = strings(PHOBIA_FILE, "falling"),
						"anime" = strings(PHOBIA_FILE, "anime"),
						"religion" = strings(PHOBIA_FILE, "religion")
					   )

	phobia_mobs = list("spiders"  = typecacheof(list(/mob/living/simple_animal/hostile/poison/giant_spider)),
					   "security" = typecacheof(list(/mob/living/simple_animal/bot/secbot)),
					   "lizards"  = typecacheof(list(/mob/living/simple_animal/hostile/lizard)),
					   "skeletons" = typecacheof(list(/mob/living/simple_animal/hostile/skeleton)),
					   "snakes"   = typecacheof(list(/mob/living/simple_animal/hostile/retaliate/poison/snake)),
					   "doctors"   = typecacheof(list(/mob/living/simple_animal/bot/medbot)),
					   "the supernatural"   = typecacheof(list(/mob/living/simple_animal/hostile/construct,
					   /mob/living/simple_animal/revenant, /mob/living/simple_animal/shade)),
					   "birds" = typecacheof(list(/mob/living/simple_animal/parrot, /mob/living/simple_animal/chick, /mob/living/simple_animal/chicken,
					   /mob/living/simple_animal/pet/penguin)),
					   "anime" = typecacheof(list(/mob/living/simple_animal/hostile/guardian))
					   )

	phobia_objs = list("snakes" = typecacheof(list(/obj/item/rod_of_asclepius)),

						"spiders"   = typecacheof(list(/obj/structure/spider)),

					   "security"  = typecacheof(list(/obj/item/clothing/under/rank/security/officer, /obj/item/clothing/under/rank/security/warden,
											 	 /obj/item/clothing/under/rank/security/head_of_security, /obj/item/clothing/under/rank/security/detective,
												 /obj/item/melee/baton, /obj/item/gun/energy/taser, /obj/item/restraints/handcuffs,
												 /obj/machinery/door/airlock/security, /obj/effect/hallucination/simple/securitron)),

					  "clowns"    = typecacheof(list(/obj/item/clothing/under/rank/civilian/clown, /obj/item/clothing/shoes/clown_shoes,
												 /obj/item/clothing/mask/gas/clown_hat, /obj/item/instrument/bikehorn,
												 /obj/item/pda/clown, /obj/item/grown/bananapeel, /obj/item/reagent_containers/food/snacks/cheesiehonkers,
												 /obj/item/trash/cheesie)),

					  "greytide"  = typecacheof(list(/obj/item/clothing/under/color/grey, /obj/item/melee/baton/cattleprod,
												 /obj/item/twohanded/spear, /obj/item/clothing/mask/gas)),

					  "lizards"   = typecacheof(list(/obj/item/toy/plush/lizardplushie, /obj/item/reagent_containers/food/snacks/kebab/tail,
												 /obj/item/organ/tail/lizard, /obj/item/reagent_containers/food/drinks/bottle/lizardwine)),

					  "skeletons" = typecacheof(list(/obj/item/organ/tongue/bone, /obj/item/clothing/suit/armor/bone, /obj/item/stack/sheet/bone,
												 /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/skeleton,
												 /obj/effect/decal/remains/human)),

						"doctors"   = typecacheof(list(/obj/item/clothing/under/rank/medical,
						/obj/item/reagent_containers/syringe, /obj/item/reagent_containers/pill/, /obj/item/reagent_containers/hypospray,
						/obj/item/storage/firstaid, /obj/item/storage/pill_bottle, /obj/item/healthanalyzer,
						/obj/structure/sign/departments/medbay, /obj/machinery/door/airlock/medical, /obj/machinery/sleeper, /obj/machinery/stasis,
						/obj/machinery/dna_scannernew, /obj/machinery/atmospherics/components/unary/cryo_cell, /obj/item/surgical_drapes,
						/obj/item/retractor, /obj/item/hemostat, /obj/item/cautery, /obj/item/surgicaldrill, /obj/item/scalpel, /obj/item/circular_saw,
						/obj/item/clothing/suit/bio_suit/plaguedoctorsuit, /obj/item/clothing/head/plaguedoctorhat, /obj/item/clothing/mask/gas/plaguedoctor)),

						"authority"   = typecacheof(list(/obj/item/clothing/under/rank/captain,  /obj/item/clothing/under/rank/civilian/head_of_personnel,
						/obj/item/clothing/under/rank/security/head_of_security, /obj/item/clothing/under/rank/rnd/research_director,
						/obj/item/clothing/under/rank/medical/chief_medical_officer, /obj/item/clothing/under/rank/engineering/chief_engineer,
						/obj/item/clothing/under/rank/centcom/officer, /obj/item/clothing/under/rank/centcom/commander,
						/obj/item/melee/classic_baton/telescopic, /obj/item/card/id/silver, /obj/item/card/id/gold,
						/obj/item/card/id/captains_spare, /obj/item/card/id/centcom, /obj/machinery/door/airlock/command)),

						"the supernatural"  = typecacheof(list(/obj/structure/destructible/cult, /obj/item/tome,
						/obj/item/melee/cultblade, /obj/item/twohanded/required/cult_bastard,
						/obj/item/restraints/legcuffs/bola/cult, /obj/item/clothing/suit/space/hardsuit/cult,
						/obj/item/clothing/suit/hooded/cultrobes, /obj/item/clothing/head/hooded/cult_hoodie, /obj/effect/rune,
						/obj/item/stack/sheet/runed_metal, /obj/machinery/door/airlock/cult, /obj/singularity/narsie,
						/obj/item/soulstone,
						/obj/item/clothing/suit/wizrobe, /obj/item/clothing/head/wizard, /obj/item/spellbook, /obj/item/staff,
						/obj/item/clothing/suit/space/hardsuit/shielded/wizard, /obj/item/clothing/suit/space/hardsuit/wizard,
						/obj/item/gun/magic/staff, /obj/item/gun/magic/wand,
						/obj/item/nullrod, /obj/item/clothing/under/rank/civilian/chaplain)),

						"birds" = typecacheof(list(/obj/item/clothing/mask/gas/plaguedoctor, /obj/item/reagent_containers/food/snacks/cracker,
						/obj/item/clothing/suit/chickensuit, /obj/item/clothing/head/chicken,
						/obj/item/clothing/suit/toggle/owlwings, /obj/item/clothing/under/costume/owl, /obj/item/clothing/mask/gas/owl_mask,
						/obj/item/clothing/under/costume/griffin, /obj/item/clothing/shoes/griffin, /obj/item/clothing/head/griffin,
						/obj/item/clothing/head/helmet/space/freedom, /obj/item/clothing/suit/space/freedom)),

					   "anime" = typecacheof(list(/obj/item/clothing/under/costume/schoolgirl, /obj/item/katana, /obj/item/reagent_containers/food/snacks/sashimi, /obj/item/reagent_containers/food/snacks/chawanmushi,
					   /obj/item/reagent_containers/food/drinks/bottle/sake, /obj/item/throwing_star, /obj/item/clothing/head/kitty/genuine, /obj/item/clothing/suit/space/space_ninja,
					   /obj/item/clothing/mask/gas/space_ninja, /obj/item/clothing/shoes/space_ninja, /obj/item/clothing/gloves/space_ninja, /obj/item/twohanded/vibro_weapon,
					   /obj/item/nullrod/scythe/vibro, /obj/item/energy_katana, /obj/item/toy/katana, /obj/item/nullrod/claymore/katana, /obj/structure/window/paperframe, /obj/structure/mineral_door/paperframe))
						)

	phobia_turfs = list("space" = typecacheof(list(/turf/open/space, /turf/open/floor/holofloor/space, /turf/open/floor/fakespace)),
						"the supernatural" = typecacheof(list(/turf/open/floor/plasteel/cult, /turf/closed/wall/mineral/cult)),
						"falling" = typecacheof(list(/turf/open/chasm, /turf/open/floor/fakepit))
						)

	phobia_species = list("lizards" = typecacheof(list(/datum/species/lizard)),
						  "skeletons" = typecacheof(list(/datum/species/skeleton, /datum/species/plasmaman)),
						  "the supernatural" = typecacheof(list(/datum/species/golem/runic)),
						  "anime" = typecacheof(list(/datum/species/human/felinid))
						 )

	return ..()

#undef PHOBIA_FILE
