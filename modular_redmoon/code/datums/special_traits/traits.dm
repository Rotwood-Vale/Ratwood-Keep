/datum/special_trait/tiny
	name = "Tiny"
	greet_text = span_notice("I've always been called a tiny. I am valued for my stature, but, this world made for smaller folk has forced me to move cautiously.")
	req_text = "Not a kobold, seelie, verminvolk or a dwarf"
	restricted_races = list(/datum/species/anthromorphsmall, /datum/species/dwarf/mountain, /datum/species/kobold, /datum/species/seelie)
	weight = 50

/datum/special_trait/tiny/on_apply(mob/living/carbon/human/character)
	character.mob_size -= 1
	character.change_stat("strength", -2)
	character.change_stat("constitution", -2)
	character.change_stat("speed", 4)
	character.transform = character.transform.Scale(0.75, 0.75)
	character.transform = character.transform.Translate(0, (-0.25 * 16))
	character.update_transform()

/datum/special_trait/eora
	name = "Благословение Эоры"
	greet_text = span_notice("Вас благословила богиня любви!")
	req_text = "Эора милоствует лишь высоких женщин, а иные же... получат проклятье..."
	weight = 40

/datum/special_trait/eora/on_apply(mob/living/carbon/human/character, silent)
	if(character.gender == "female")
		if(!(character.dna.species.clothes_id == "dwarf"))
			ADD_TRAIT(character, TRAIT_EORA, "[type]")
			character.dna.species.limbs_icon_f = 'modular_redmoon/code/modules/eora_bless/icons/eora_f.dmi'
			character.dna.species.dam_icon_f = 'modular_redmoon/code/modules/eora_bless/icons/dam_female_eora.dmi'
			character.dna.species.custom_clothes = TRUE
			character.dna.species.clothes_id = "eora"
			character.update_body_parts(TRUE)
		else
			ADD_TRAIT(character, TRAIT_EORA_CURSE, "[type]")
			to_chat(character, span_warning("ВЫ НИЗКАЯ."))
	else
		ADD_TRAIT(character, TRAIT_EORA_CURSE, "[type]")
		to_chat(character, span_warning("ВЫ МУЖИК."))
