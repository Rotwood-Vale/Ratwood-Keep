
// HUMAN

/obj/effect/mob_spawn/human/searaider

	mob_name = "northman"
	mob_type = /mob/living/carbon/human/species/human/northern
	mob_species = /datum/species/human/northern
	brute_damage = 80

/obj/effect/mob_spawn/human/searaider/archer
	skin_tone = SKIN_COLOR_GRENZELHOFT
	outfit = /datum/outfit/searaider

/datum/outfit/searaider
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants =	/obj/item/clothing/under/roguetown/trou/plainpants
	shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	head = /obj/item/clothing/head/roguetown/helmet/leather
	neck = /obj/item/clothing/neck/roguetown/psicross/skull

// ORC

/obj/effect/mob_spawn/human/orc

	mob_name = "Orc"
	mob_type = /mob/living/carbon/human/species/halforc
	mob_species = /datum/species/halforc
	brute_damage = 80

/obj/effect/mob_spawn/human/orc/corpse/savageorc
	mob_name = "Savage Orc"
	name = "Savage Orc"
	skin_tone = SKIN_COLOR_GROONN
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/savageorc

/obj/effect/mob_spawn/human/orc/corpse/savageorc2
	mob_name = "Savage Orc"
	name = "Savage Orc"
	skin_tone = SKIN_COLOR_GROONN
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/savageorc2

/datum/outfit/savageorc
	shirt = /obj/item/clothing/suit/roguetown/shirt/tribalrag
	pants =	/obj/item/clothing/under/roguetown/loincloth/brown
	shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedanklets

/datum/outfit/savageorc2
	shirt = /obj/item/clothing/suit/roguetown/shirt/tribalrag
	pants =	/obj/item/clothing/under/roguetown/loincloth/brown
	shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedanklets
	head = /obj/item/clothing/head/roguetown/helmet/leather

/obj/effect/mob_spawn/human/orc/corpse/orcmarauder
	mob_name = "Orc Marauder"
	name = "Orc Marauder"
	skin_tone = SKIN_COLOR_GROONN
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/orcmarauder

/datum/outfit/orcmarauder
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants =	/obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	head = /obj/item/clothing/head/roguetown/helmet/leather

/obj/effect/mob_spawn/human/orc/corpse/orcravager
	mob_name = "Orc Ravager"
	name = "Orc Ravager"
	skin_tone = SKIN_COLOR_GROONN
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/orcravager

/datum/outfit/orcravager
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants =	/obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/armoriron
	head = /obj/item/clothing/head/roguetown/helmet/skullcap
	gloves = /obj/item/clothing/gloves/roguetown/chain
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	mask = /obj/item/clothing/mask/rogue/skullmask


// GOBLIN

/obj/effect/mob_spawn/human/goblin

	mob_name = "goblin"
	mob_type = /mob/living/carbon/human/species/goblin/unarmed
	mob_species = /datum/species/goblin
	brute_damage = 80

/obj/effect/mob_spawn/human/goblin_cave

	mob_name = "goblin"
	mob_type = /mob/living/carbon/human/species/goblin/cave/unarmed
	mob_species = /datum/species/goblin/cave
	brute_damage = 80


// SKELETONS

//Mob

/mob/living/carbon/human/species/skeleton/dead

/mob/living/carbon/human/species/skeleton/dead/after_creation()
	..()
	death()

/mob/living/carbon/human/species/skeleton/dead/footman
	skel_outfit = /datum/outfit/job/roguetown/npc/skeleton/dead/footman

/mob/living/carbon/human/species/skeleton/dead/footman2
	skel_outfit = /datum/outfit/job/roguetown/npc/skeleton/dead/footman2

/mob/living/carbon/human/species/skeleton/dead/knight
	skel_outfit = /datum/outfit/job/roguetown/npc/skeleton/dead/knight

/mob/living/carbon/human/species/skeleton/dead/noble
	skel_outfit = /datum/outfit/job/roguetown/npc/skeleton/dead/noble


// OUTFIT FOOTMAN
/datum/outfit/job/roguetown/npc/skeleton/dead/footman/pre_equip(mob/living/carbon/human/H)
	if(prob(30))
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
		if(prob(30))
			head = /obj/item/clothing/head/roguetown/helmet/bascinet
			if(prob(30))
				head = /obj/item/clothing/head/roguetown/helmet/sallet
				if(prob(30))
					head = /obj/item/clothing/head/roguetown/helmet/kettle
	if(prob(50))
		cloak = /obj/item/clothing/cloak/stabard/bog
		if(prob(50))
			cloak = /obj/item/clothing/cloak/stabard/guard
	if(prob(70))
		neck = /obj/item/clothing/neck/roguetown/coif
		if(prob(50))
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			if(prob(50))
				neck = /obj/item/clothing/neck/roguetown/gorget
	if(prob(80))
		armor = /obj/item/clothing/suit/roguetown/armor/armordress
		if(prob(80))
			armor = /obj/item/clothing/suit/roguetown/armor/armordress/alt
			if(prob(80))
				armor = /obj/item/clothing/suit/roguetown/armor/leather
				if(prob(20))
					armor =	/obj/item/clothing/suit/roguetown/armor/leather/hide
					if(prob(20))
						armor =	/obj/item/clothing/suit/roguetown/armor/leather/studded
	if(prob(70))
		gloves = /obj/item/clothing/gloves/roguetown/leather
		if(prob(10))
			gloves = /obj/item/clothing/gloves/roguetown/chain
			if(prob(30))
				gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	if(prob(70))
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(70))
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		if(prob(30))
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/bog
			if(prob(30))
				shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
	if(prob(70))
		pants = /obj/item/clothing/under/roguetown/trou/leather
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			if(prob(10))
				pants = /obj/item/clothing/under/roguetown/chainlegs
	if(prob(70))
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		if(prob(30))
			shoes = /obj/item/clothing/shoes/roguetown/boots/armoriron
			if(prob(70))
				shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	if(prob(70))
		belt = /obj/item/storage/belt/rogue/leather

/datum/outfit/job/roguetown/npc/skeleton/dead/footman2/pre_equip(mob/living/carbon/human/H)
	if(prob(30))
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
		if(prob(30))
			head = /obj/item/clothing/head/roguetown/helmet/bascinet
			if(prob(30))
				head = /obj/item/clothing/head/roguetown/helmet/sallet
				if(prob(30))
					head = /obj/item/clothing/head/roguetown/helmet/kettle
	if(prob(50))
		cloak = /obj/item/clothing/cloak/stabard/bog
		if(prob(50))
			cloak = /obj/item/clothing/cloak/stabard/guard
	if(prob(70))
		neck = /obj/item/clothing/neck/roguetown/coif
		if(prob(50))
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			if(prob(50))
				neck = /obj/item/clothing/neck/roguetown/gorget
	if(prob(80))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
		if(prob(80))
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			if(prob(80))
				armor = /obj/item/clothing/suit/roguetown/armor/carapace/cuirass
				if(prob(80))
					armor = /obj/item/clothing/suit/roguetown/armor/brigandine
	if(prob(70))
		gloves = /obj/item/clothing/gloves/roguetown/leather
		if(prob(10))
			gloves = /obj/item/clothing/gloves/roguetown/chain
			if(prob(30))
				gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	if(prob(70))
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(70))
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		if(prob(30))
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/bog
			if(prob(30))
				shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
	if(prob(70))
		pants = /obj/item/clothing/under/roguetown/trou/leather
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			if(prob(10))
				pants = /obj/item/clothing/under/roguetown/chainlegs
	if(prob(70))
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		if(prob(30))
			shoes = /obj/item/clothing/shoes/roguetown/boots/armoriron
			if(prob(70))
				shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	if(prob(70))
		belt = /obj/item/storage/belt/rogue/leather






// OUTFIT KNIGHT

/datum/outfit/job/roguetown/npc/skeleton/dead/knight/pre_equip(mob/living/carbon/human/H)

	if(prob(80))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/guard
		if(prob(70))
			head = /obj/item/clothing/head/roguetown/helmet/heavy/knight
			if(prob(30))
				head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet
	if(prob(80))
		armor = /obj/item/clothing/suit/roguetown/armor/plate/scaled
		if(prob(70))
			armor = /obj/item/clothing/suit/roguetown/armor/plate/full
			if(prob(40))
				armor = /obj/item/clothing/suit/roguetown/armor/plate/fancycuirass
	if(prob(70))
		pants = /obj/item/clothing/under/roguetown/chainlegs
		if(prob(30))
			pants = /obj/item/clothing/under/roguetown/platelegs
	if(prob(80))
		cloak = /obj/item/clothing/cloak/cape/knight
	if(prob(70))
		gloves = /obj/item/clothing/gloves/roguetown/plate
		if(prob(30))
			gloves = /obj/item/clothing/gloves/roguetown/chain
	if(prob(70))
		shoes = /obj/item/clothing/shoes/roguetown/boots/armoriron
		if(prob(30))
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor


/datum/outfit/job/roguetown/npc/skeleton/dead/noble/pre_equip(mob/living/carbon/human/H)

	if(H.gender == MALE)
		if(prob(20))
			head = /obj/item/clothing/head/roguetown/fancyhat
			if(prob(20))
				head = /obj/item/clothing/head/roguetown/chaperon/old
				if(prob(20))
					head = /obj/item/clothing/head/roguetown/bardhat
					if(prob(20))
						head = /obj/item/clothing/head/roguetown/puritan
		if(prob(60))
			pants = /obj/item/clothing/under/roguetown/trou
			if(prob(40))
				pants = /obj/item/clothing/under/roguetown/tights/random
		if(prob(60))
			shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random
			if(prob(50))
				shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
		if(prob(50))
			shoes = /obj/item/clothing/shoes/roguetown/nobleboot
			if(prob(50))
				shoes = /obj/item/clothing/shoes/roguetown/ridingboots
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		if(prob(50))
			cloak = /obj/item/clothing/cloak/half
	else
		if(prob(20))
			head = /obj/item/clothing/head/roguetown/fancyhat
			if(prob(20))
				head = /obj/item/clothing/head/roguetown/chaperon/old
				if(prob(20))
					head = /obj/item/clothing/head/roguetown/bardhat
					if(prob(70))
						head = /obj/item/clothing/head/roguetown/hennin
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/random
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/random
			if(prob(50))
				shirt = /obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/random
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		if(prob(50))
			cloak = /obj/item/clothing/cloak/half
