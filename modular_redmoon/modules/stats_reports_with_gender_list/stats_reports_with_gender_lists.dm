// Check comments with "start_reports_with_gender_lists" for all related code.

SUBSYSTEM_DEF(round_end_statistics)
	name = "Round End Statistics"
	init_order = INIT_ORDER_PATH
	flags = SS_NO_FIRE
	var/males = 0
	var/females = 0
	var/males_with_vagina = 0
	var/females_with_penis = 0
	var/species_aasimar = 0 // изначально делалось через массив, но массив красиво не отправить в IRC, потому множество переменных
	var/species_anthromorph = 0
	var/species_anthromorphsmall = 0
	var/species_axian = 0
	var/species_demihuman = 0
	var/species_dracon = 0
	var/species_drow = 0
	var/species_dwarf = 0
	var/species_elf = 0
	var/species_goblinp = 0
	var/species_halfelf = 0
	var/species_halfork = 0
	var/species_humen = 0 
	var/species_kobold = 0
	var/species_lizardfolk = 0
	var/species_lupian = 0
	var/species_moth = 0
	var/species_seelie = 0
	var/species_tabaxi = 0
	var/species_tiefling = 0
	var/species_vulpkanin = 0

/mob/living/carbon/human/proc/add_gender_genitals_to_round_end_statistics()
	switch(gender)
		if(MALE)
			if(getorganslot(ORGAN_SLOT_VAGINA))
				SSround_end_statistics.males_with_vagina++
			else
				SSround_end_statistics.males++
		if(FEMALE)
			if(getorganslot(ORGAN_SLOT_PENIS))
				SSround_end_statistics.females_with_penis++
			else
				SSround_end_statistics.females++
	switch(dna.species.type) // Так как благородные разработчики ратвуда не используют дефайны для названий рас, это самый безопасный вариант
		if(/datum/species/aasimar) SSround_end_statistics.species_aasimar++
		if(/datum/species/anthromorph) SSround_end_statistics.species_anthromorph++
		if(/datum/species/anthromorphsmall) SSround_end_statistics.species_anthromorphsmall++
		if(/datum/species/axian) SSround_end_statistics.species_axian++
		if(/datum/species/demihuman) SSround_end_statistics.species_demihuman++
		if(/datum/species/dracon) SSround_end_statistics.species_dracon++
		if(/datum/species/dwarf/mountain) SSround_end_statistics.species_dwarf++
		if(/datum/species/elf/dark) SSround_end_statistics.species_drow++
		if(/datum/species/elf/wood) SSround_end_statistics.species_elf++
		if(/datum/species/goblinp) SSround_end_statistics.species_goblinp++
		if(/datum/species/halforc) SSround_end_statistics.species_halfork++
		if(/datum/species/human/halfelf) SSround_end_statistics.species_halfelf++
		if(/datum/species/human/northern) SSround_end_statistics.species_humen++
		if(/datum/species/kobold) SSround_end_statistics.species_kobold++
		if(/datum/species/lizardfolk) SSround_end_statistics.species_lizardfolk++
		if(/datum/species/lupian) SSround_end_statistics.species_lupian++
		if(/datum/species/moth) SSround_end_statistics.species_moth++
		if(/datum/species/seelie) SSround_end_statistics.species_seelie++
		if(/datum/species/tabaxi) SSround_end_statistics.species_tabaxi++
		if(/datum/species/tieberian) SSround_end_statistics.species_tiefling++
		if(/datum/species/vulpkanin) SSround_end_statistics.species_vulpkanin++
		else send2irc("ERROR - REPORT TO DEV!", "Не удалось добавить расу в статистику конца раунда. [dna.species.type]")
