GLOBAL_LIST_INIT(character_accents, list("No accent"=/datum/char_accent/none,
	"Dwarf accent"=/datum/char_accent/dwarf,
	"Dwarf Gibberish accent"=/datum/char_accent/dwarf_gibberish,
	"Dark Elf accent"=/datum/char_accent/dark_elf,
	"Elf accent"=/datum/char_accent/elf,
	"Grenzelhoft accent"=/datum/char_accent/grenzelhoft,
	"Hammerhold accent"=/datum/char_accent/hammerhold,
	"Assimar accent"=/datum/char_accent/assimar,
	"Lizard accent"=/datum/char_accent/lizard,
	"Tiefling accent"=/datum/char_accent/tiefling,
	"Half Orc accent"=/datum/char_accent/half_orc))

/datum/char_accent
	var/name

/mob/living/carbon/human
	var/char_accent = "No accent"

/datum/char_accent/none
	name = "No accent"

/datum/char_accent/dwarf
	name = "Dwarf accent"

/datum/char_accent/dwarf_gibberish
	name = "Dwarf Gibberish accent"

/datum/char_accent/dark_elf
	name = "Dark Elf accent"

/datum/char_accent/elf
	name = "Elf accent"

/datum/char_accent/grenzelhoft
	name = "Grenzelhoft accent"

/datum/char_accent/hammerhold
	name = "Hammerhold accent"

/datum/char_accent/assimar
	name = "Assimar accent"

/datum/char_accent/lizard
	name = "Lizard accent"

/datum/char_accent/tiefling
	name = "Tiefling accent"

/datum/char_accent/half_orc
	name = "Half Orc accent"
