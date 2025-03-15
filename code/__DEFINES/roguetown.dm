//used in various places
#define ALL_RACES_TYPES list(\
	/datum/species/human/northern,\
	/datum/species/human/halfelf,\
	/datum/species/elf/dark,\
	/datum/species/elf/wood,\
	/datum/species/dwarf/mountain,\
	/datum/species/tieberian,\
	/datum/species/aasimar,\
	/datum/species/lizardfolk,\
	/datum/species/lupian,\
	/datum/species/tabaxi,\
	/datum/species/vulpkanin,\
	/datum/species/axian,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/anthromorphsmall,\
	/datum/species/demihuman,\
	/datum/species/halforc,\
	/datum/species/kobold,\
	/datum/species/goblinp,\
	/datum/species/seelie,\
)

#define RACES_RESPECTED \
	/datum/species/human/northern,\
	/datum/species/elf/wood,\
	/datum/species/human/halfelf,\
	/datum/species/dwarf/mountain,\
	/datum/species/aasimar,\
	/datum/species/lupian,\
	/datum/species/vulpkanin,\
	/datum/species/moth,\
	/datum/species/dracon,

#define RACES_TOLERATED \
	/datum/species/lizardfolk,\
	/datum/species/tabaxi,\
	/datum/species/axian,\
	/datum/species/anthromorph,\
	/datum/species/demihuman

#define RACES_SHUNNED \
	/datum/species/elf/dark,\
	/datum/species/tieberian,\
	/datum/species/anthromorphsmall,\
	/datum/species/kobold

#define RACES_VERY_SHUNNED \
	/datum/species/halforc

#define RACES_GOBLIN \
	/datum/species/goblinp

#define RACES_SEELIE \
	/datum/species/seelie	//Seelie having its own global define and nothing else will prevent allowing it via RACES_ALL_KINDS

#define RACES_SMOLFOLK \
	/datum/species/anthromorphsmall,\
	/datum/species/kobold

#define RACES_ALL_KINDS list(RACES_SHUNNED, RACES_TOLERATED, RACES_VERY_SHUNNED, RACES_RESPECTED)

#define RACES_NEARLY_ALL_PLUS_SEELIE list(RACES_SHUNNED, RACES_TOLERATED, RACES_VERY_SHUNNED, RACES_RESPECTED, RACES_SEELIE)

#define RACES_VERY_SHUNNED_UP list(RACES_SHUNNED, RACES_TOLERATED, RACES_VERY_SHUNNED, RACES_RESPECTED)

#define RACES_SHUNNED_UP list(RACES_SHUNNED, RACES_TOLERATED, RACES_RESPECTED)

#define RACES_SHUNNED_UP_PLUS_SEELIE list(RACES_SHUNNED, RACES_TOLERATED, RACES_RESPECTED, RACES_SEELIE)

#define RACES_TOLERATED_UP list(RACES_TOLERATED, RACES_RESPECTED)

#define RACES_TOLERATED_UP_PLUS_SMOLFOLK list(RACES_TOLERATED, RACES_SMOLFOLK, RACES_RESPECTED)

#define NOBLE_RACES_TYPES list(\
	/datum/species/human/northern,\
	/datum/species/human/halfelf,\
	/datum/species/elf/dark,\
	/datum/species/elf/wood,\
	/datum/species/dwarf/mountain,\
	/datum/species/tieberian,\
	/datum/species/aasimar,\
	/datum/species/lizardfolk,\
	/datum/species/lupian,\
	/datum/species/tabaxi,\
	/datum/species/vulpkanin,\
	/datum/species/axian,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/anthromorphsmall,\
	/datum/species/demihuman,\
	/datum/species/kobold,\
	/datum/species/goblinp,\
	/datum/species/seelie,\
)

#define CLOTHED_RACES_TYPES list(\
	/datum/species/human/northern,\
	/datum/species/human/halfelf,\
	/datum/species/elf/dark,\
	/datum/species/elf/wood,\
	/datum/species/dwarf/mountain,\
	/datum/species/tieberian,\
	/datum/species/aasimar,\
	/datum/species/lizardfolk,\
	/datum/species/lupian,\
	/datum/species/tabaxi,\
	/datum/species/vulpkanin,\
	/datum/species/axian,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/anthromorphsmall,\
	/datum/species/demihuman,\
	/datum/species/halforc,\
	/datum/species/kobold,\
	/datum/species/goblinp,\
	/datum/species/seelie,\
)
// Non-dwarf non-kobold non-goblin mostly
#define NON_DWARVEN_RACE_TYPES list(\
	/datum/species/human/northern,\
	/datum/species/human/halfelf,\
	/datum/species/elf/dark,\
	/datum/species/elf/wood,\
	/datum/species/tieberian,\
	/datum/species/aasimar,\
	/datum/species/lizardfolk,\
	/datum/species/lupian,\
	/datum/species/tabaxi,\
	/datum/species/vulpkanin,\
	/datum/species/axian,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/demihuman,\
	/datum/species/halforc,\
	/datum/species/seelie,\
)
// Non-elf non-dwarf non-kobold non-goblin mostly
#define HUMANLIKE_RACE_TYPES list(\
	/datum/species/human/northern,\
	/datum/species/tieberian,\
	/datum/species/aasimar,\
	/datum/species/lizardfolk,\
	/datum/species/lupian,\
	/datum/species/tabaxi,\
	/datum/species/vulpkanin,\
	/datum/species/axian,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/demihuman,\
)
// For their armour sets. Shouldn't need to define the sub species, but oh well.
#define GOBLIN_RACE_TYPES list(\
	/datum/species/goblinp,\
	/datum/species/goblin,\
	/datum/species/goblin/hell,\
	/datum/species/goblin/cave,\
	/datum/species/goblin/sea,\
	/datum/species/goblin/moon,\
)



#define ALL_CLERIC_PATRONS list(\
	/datum/patron/divine/astrata,\
	/datum/patron/divine/noc,\
	/datum/patron/divine/dendor,\
	/datum/patron/divine/necra,\
	/datum/patron/divine/pestra,\
	/datum/patron/divine/malum,\
	/datum/patron/divine/ravox,\
	/datum/patron/divine/eora,\
)

#define ALL_ACOLYTE_PATRONS list(\
	/datum/patron/divine/astrata,\
	/datum/patron/divine/noc,\
	/datum/patron/divine/dendor,\
	/datum/patron/divine/pestra,\
	/datum/patron/divine/malum,\
	/datum/patron/divine/eora,\
)

#define ALL_DIVINE_PATRONS list(\
	/datum/patron/divine/astrata,\
	/datum/patron/divine/noc,\
	/datum/patron/divine/dendor,\
	/datum/patron/divine/abyssor,\
	/datum/patron/divine/ravox,\
	/datum/patron/divine/necra,\
	/datum/patron/divine/xylix,\
	/datum/patron/divine/pestra,\
	/datum/patron/divine/malum,\
	/datum/patron/divine/eora\
)

#define ALL_PATRONS list(\
	/datum/patron/divine/astrata,\
	/datum/patron/divine/noc,\
	/datum/patron/divine/dendor,\
	/datum/patron/divine/abyssor,\
	/datum/patron/divine/ravox,\
	/datum/patron/divine/necra,\
	/datum/patron/divine/xylix,\
	/datum/patron/divine/pestra,\
	/datum/patron/divine/malum,\
	/datum/patron/divine/eora,\
	/datum/patron/psydon,\
	/datum/patron/zizo,\
	/datum/patron/inhumen/matthios,\
	/datum/patron/inhumen/baotha,\
	/datum/patron/inhumen/graggar\
)

#define TEN_CURSES list(\
	/datum/curse/astrata,\
	/datum/curse/noc,\
	/datum/curse/ravox,\
	/datum/curse/necra,\
	/datum/curse/xylix,\
	/datum/curse/pestra,\
	/datum/curse/eora\
)

#define INHUMEN_CURSES list(\
	/datum/curse/zizo,\
	/datum/curse/graggar,\
	/datum/curse/matthios,\
	/datum/curse/baotha\
)

#define SPECIAL_CURSES list(\
	/datum/curse/atheism\
)

#define ALL_CURSES list(\
	SPECIAL_CURSES,\
	TEN_CURSES,\
	INHUMEN_CURSES\
)

#define ALL_NON_INHUMEN_PATRONS list(/datum/patron/divine/astrata, /datum/patron/divine/noc, /datum/patron/divine/dendor, /datum/patron/divine/abyssor, /datum/patron/divine/ravox, /datum/patron/divine/necra, /datum/patron/divine/xylix, /datum/patron/divine/pestra, /datum/patron/divine/malum, /datum/patron/divine/eora, /datum/patron/psydon)

#define PLATEHIT "plate"
#define CHAINHIT "chain"
#define SOFTHIT "soft"
#define SOFTUNDERHIT "softunder" // This is just for the soft underarmors like gambesons and arming jackets so they can be worn with light armors that use the same sound like studded leather

/proc/get_armor_sound(blocksound, blade_dulling)
	switch(blocksound)
		if(PLATEHIT)
			if(blade_dulling == BCLASS_CUT||blade_dulling == BCLASS_CHOP)
				return pick('sound/combat/hits/armor/plate_slashed (1).ogg','sound/combat/hits/armor/plate_slashed (2).ogg','sound/combat/hits/armor/plate_slashed (3).ogg','sound/combat/hits/armor/plate_slashed (4).ogg')
			if(blade_dulling == BCLASS_STAB||blade_dulling == BCLASS_PICK||blade_dulling == BCLASS_BITE)
				return pick('sound/combat/hits/armor/plate_stabbed (1).ogg','sound/combat/hits/armor/plate_stabbed (2).ogg','sound/combat/hits/armor/plate_stabbed (3).ogg')
			else
				return pick('sound/combat/hits/armor/plate_blunt (1).ogg','sound/combat/hits/armor/plate_blunt (2).ogg','sound/combat/hits/armor/plate_blunt (3).ogg')
		if(CHAINHIT)
			if(blade_dulling == BCLASS_BITE||blade_dulling == BCLASS_STAB||blade_dulling == BCLASS_PICK||blade_dulling == BCLASS_CUT||blade_dulling == BCLASS_CHOP)
				return pick('sound/combat/hits/armor/chain_slashed (1).ogg','sound/combat/hits/armor/chain_slashed (2).ogg','sound/combat/hits/armor/chain_slashed (3).ogg','sound/combat/hits/armor/chain_slashed (4).ogg')
			else
				return pick('sound/combat/hits/armor/chain_blunt (1).ogg','sound/combat/hits/armor/chain_blunt (2).ogg','sound/combat/hits/armor/chain_blunt (3).ogg')
		if(SOFTHIT)
			if(blade_dulling == BCLASS_BITE||blade_dulling == BCLASS_STAB||blade_dulling == BCLASS_PICK||blade_dulling == BCLASS_CUT||blade_dulling == BCLASS_CHOP)
				return pick('sound/combat/hits/armor/light_stabbed (1).ogg','sound/combat/hits/armor/light_stabbed (2).ogg','sound/combat/hits/armor/light_stabbed (3).ogg')
			else
				return pick('sound/combat/hits/armor/light_blunt (1).ogg','sound/combat/hits/armor/light_blunt (2).ogg','sound/combat/hits/armor/light_blunt (3).ogg')
		if(SOFTUNDERHIT)
			if(blade_dulling == BCLASS_BITE||blade_dulling == BCLASS_STAB||blade_dulling == BCLASS_PICK||blade_dulling == BCLASS_CUT||blade_dulling == BCLASS_CHOP)
				return pick('sound/combat/hits/armor/light_stabbed (1).ogg','sound/combat/hits/armor/light_stabbed (2).ogg','sound/combat/hits/armor/light_stabbed (3).ogg')
			else
				return pick('sound/combat/hits/armor/light_blunt (1).ogg','sound/combat/hits/armor/light_blunt (2).ogg','sound/combat/hits/armor/light_blunt (3).ogg')

GLOBAL_LIST_INIT(lockhashes, list())
GLOBAL_LIST_INIT(lockids, list())
GLOBAL_LIST_EMPTY(credits_icons)
GLOBAL_LIST_EMPTY(confessors)

//preference stuff
#define FAMILY_NONE 1
#define FAMILY_PARTIAL 2
#define FAMILY_FULL 3


GLOBAL_LIST_EMPTY(head_bounties)
GLOBAL_LIST_EMPTY(job_respawn_delays)



/*
	Formerly bitflags, now we are strings
	Currently used for classes
*/

//General
#define CTAG_ALLCLASS		"CAT_ALLCLASS"		// jus a define for allclass to not deal with actively typing strings
#define CTAG_DISABLED		"CAT_DISABLED"		// Disabled, aka don't make it fuckin APPEAR
#define CTAG_CHALLENGE		"CAT_CHALLENGE"		// Challenge class - Meant to be free for everyone

//City
#define CTAG_TOWNER			"CAT_TOWNER"		// Villager class - Villagers can use it
#define CTAG_MERCENARY		"CAT_MERCENARY"		// Mercs
#define CTAG_HENCH			"CAT_HENCH"			// Whitevein Guards

//Courtiers
#define CTAG_SERVANT		"CAT_SERVANT"		// Maids and butlers
#define CTAG_CLERK			"CAT_CLERK"			// Clerks

//Garrison
#define CTAG_BOG			"CAT_BOG"			// Vanguard
#define CTAG_SQUIRE			"CAT_SQUIRE"		// Squires
#define CTAG_MAA			"CAT_MAA"			// Man-At-Arms

//Nobles			Eventually all of them will get their subclasses
#define CTAG_HEIR			"CAT_HEIR"			// Heirs
#define CTAG_KNIGHT			"CAT_KNIGHT"		// Knights

//Antags
#define CTAG_BANDIT			"CAT_BANDIT"		// Bandit class - Tied to the bandit antag really
#define CTAG_ANTAG			"CAT_ANTAG"			// Antag class - results in an antag
#define CTAG_GOBS			"CAT_GOBS"			// Goblin Guards

//Other
#define CTAG_REFUGEE		"CAT_REFUGEE"		// Refugee classes

/*
	Defines for the triumph buy datum categories
*/
#define TRIUMPH_CAT_ROUND_EFX "ROUND-EFX"
#define TRIUMPH_CAT_CHARACTER "CHARACTER"
#define TRIUMPH_CAT_MISC "MISC!"
#define TRIUMPH_CAT_ACTIVE_DATUMS "ACTIVE"

/*	........   Nutrition defines   ................ */
#define MEAL_FILLING 30
#define MEAL_GOOD 24
#define MEAL_AVERAGE 18
#define MEAL_MEAGRE 15
#define SNACK_CHUNKY 12
#define SNACK_NUTRITIOUS 9
#define SNACK_DECENT 6
#define SNACK_POOR 3

//DOUGH
#define DOUGH_NUTRITION MEAL_MEAGRE
#define SMALLDOUGH_NUTRITION MEAL_MEAGRE/2 //7.5
#define BUTTERDOUGH_NUTRITION DOUGH_NUTRITION+BUTTERSLICE_NUTRITION //17
#define BUTTERDOUGHSLICE_NUTRITION 8.5 //This should be butterdough_nutrition/2, but for some reason it returns 16 if you do that. So...
//DAIRY
#define BUTTER_NUTRITION SNACK_CHUNKY
#define BUTTERSLICE_NUTRITION BUTTER_NUTRITION/6 //2
#define FRESHCHEESE_NUTRITION SNACK_DECENT
//MEAT
#define MEATSLAB_NUTRITION SNACK_NUTRITIOUS
#define SAUSAGE_NUTRITION SNACK_NUTRITIOUS
#define MINCE_NUTRITION MEATSLAB_NUTRITION/2 //4.5

/*	........   Rotting defines   ................ */
#define SHELFLIFE_EXTREME 270 MINUTES
#define SHELFLIFE_LONG 135 MINUTES
#define SHELFLIFE_DECENT 75 MINUTES
#define SHELFLIFE_SHORT 45 MINUTES
#define SHELFLIFE_TINY 30 MINUTES
