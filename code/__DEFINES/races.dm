//used in various places
#define ALL_RACES_TYPES \
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
	/datum/species/akula,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/anthromorphsmall,\
	/datum/species/demihuman,\
	/datum/species/halforc,\
	/datum/species/kobold,\
	/datum/species/goblinp,\
	/datum/species/seelie,

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
	/datum/species/akula,\
	/datum/species/anthromorph,\
	/datum/species/demihuman

#define RACES_SHUNNED \
	/datum/species/elf/dark,\
	/datum/species/tieberian,\
	/datum/species/anthromorphsmall,\
	/datum/species/kobold, \
	/datum/species/halforc

// Seelies need their own category because they're special snowflakes and have only specific jobs they can take.
#define RACES_SEELIE \
	/datum/species/seelie

// Lists for roundstart job restrictions
// Basis for the dynamic lists in the social pyramid subsystem
#define RACES_RESPECTED_UP list(RACES_RESPECTED)

#define RACES_TOLERATED_UP list(RACES_RESPECTED, RACES_TOLERATED)

#define RACES_SHUNNED_UP list(RACES_RESPECTED, RACES_TOLERATED, RACES_SHUNNED)

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
	/datum/species/akula,\
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
	/datum/species/akula,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/demihuman,\
	/datum/species/halforc,\
	/datum/species/seelie,\
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

