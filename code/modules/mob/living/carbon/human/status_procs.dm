
/mob/living/carbon/human/Stun(amount, updating = TRUE, ignore_canstun = FALSE)
	amount = dna.species.spec_stun(src,amount)
	return ..()

/mob/living/carbon/human/Knockdown(amount, updating = TRUE, ignore_canstun = FALSE)
	amount = dna.species.spec_stun(src,amount)
	return ..()

/mob/living/carbon/human/Paralyze(amount, updating = TRUE, ignore_canstun = FALSE)
	amount = dna.species.spec_stun(src, amount)
	return ..()

/mob/living/carbon/human/Immobilize(amount, updating = TRUE, ignore_canstun = FALSE)
	amount = dna.species.spec_stun(src, amount)
	return ..()

/mob/living/carbon/human/Unconscious(amount, updating = 1, ignore_canstun = 0)
	amount = dna?.species?.spec_stun(src,amount)
	return ..()

/mob/living/carbon/human/Sleeping(amount, updating = 1, ignore_canstun = 0)
	return ..()

/mob/living/carbon/human/cure_husk(list/sources)
	. = ..()
	if(.)
		update_hair()

/mob/living/carbon/human/become_husk(source)
	. = ..()
	if(.)
		update_hair()

/mob/living/carbon/human/set_drugginess(amount)
	..()

/mob/living/carbon/human/adjust_drugginess(amount)
	..()
