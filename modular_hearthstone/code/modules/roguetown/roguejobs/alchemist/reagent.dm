/datum/reagent/medicine/paralysispot                           // This is a tool of a hot topic. This may be removed entirely if people can abuse it in one way or another. 
	name = "Paralysis Potion"
	description = "Paralyzes those it enters."
	reagent_state = LIQUID
	color = "#fcefa8"
	taste_description = "stiffness"
	overdose_threshold = 5
	metabolization_rate = 1 * REAGENTS_METABOLISM
	alpha = 225

/datum/reagent/medicine/paralysispot/overdose_process(mob/living/L)
	L.Paralyze(500)
	..()
	. = 1 

/datum/reagent/medicine/soporpot
	name = "Soporific Potion"
	description = "Weakens those it enters."
	reagent_state = LIQUID
	color = "#fcefa8"
	taste_description = "drowsyness"
	overdose_threshold = 0
	metabolization_rate = 1 * REAGENTS_METABOLISM
	alpha = 225

/datum/reagent/medicine/soporpot/on_mob_life(mob/living/carbon/M)
	M.confused += 1
	M.dizziness += 1
	M.rogstam_add(-25)
	if(M.rogfat > 75)
		M.drowsyness += 2
	else
		M.rogfat_add(15)
	..()
	. = 1

/datum/reagent/medicine/tranquilizer // Unique to bolt soporific application. More intense effect for 5x cost.
	name = "Tranquilizer"
	description = "Weakens those it enters."
	reagent_state = LIQUID
	color = "#fcefa8"
	taste_description = "drowsyness"
	overdose_threshold = 0
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 225

/datum/reagent/medicine/tranquilizer/on_mob_life(mob/living/carbon/M)
	M.confused += 2
	M.dizziness += 2
	M.rogstam_add(-50)
	if(M.rogfat > 75)
		M.drowsyness += 4
	else
		M.rogfat_add(20)
	..()
	. = 1

/datum/reagent/medicine/fortitudepot
	name = "Strength Potion"
	description = "Increases one's Strength."
	reagent_state = LIQUID
	color = "#d46000"
	taste_description = "raw fortitude"
	overdose_threshold = 16
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	alpha = 200

/datum/reagent/medicine/fortitudepot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/fortitudebuff)
	if(holder.has_reagent(/datum/reagent/medicine/fortitudepot))
		holder.remove_reagent(/datum/reagent/medicine/fortitudepot, 20)
	..()
	. = 1 

/datum/reagent/medicine/swiftnesspot
	name = "Swiftness Potion"
	description = "Increases one's Speed."
	reagent_state = LIQUID
	color = "#7efff9"
	taste_description = "fleeting swirls"
	overdose_threshold = 16
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/swiftnesspot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/swiftnessbuff)
	if(holder.has_reagent(/datum/reagent/medicine/swiftnesspot))
		holder.remove_reagent(/datum/reagent/medicine/swiftnesspot, 20)
	..()
	. = 1 

/datum/reagent/medicine/alacritypot
	name = "Alacrity Potion"
	description = "Increases one's Perception."
	reagent_state = LIQUID
	color = "#93c420"
	taste_description = "carrots..?"
	overdose_threshold = 16
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/alacritypot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/alacritybuff)
	if(holder.has_reagent(/datum/reagent/medicine/alacritypot))
		holder.remove_reagent(/datum/reagent/medicine/alacritypot, 20)
	..()
	. = 1 

/datum/reagent/medicine/luckpot
	name = "Luck Potion"
	description = "Increases one's Luck."
	reagent_state = LIQUID
	color = "#ceb328"
	taste_description = "gold"
	overdose_threshold = 16
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/luckpot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/luckbuff)
	if(holder.has_reagent(/datum/reagent/medicine/luckpot))
		holder.remove_reagent(/datum/reagent/medicine/luckpot, 20)
	..()
	. = 1 

/datum/reagent/medicine/endurancepot
	name = "Endurance Potion"
	description = "Increases one's Endurance."
	reagent_state = LIQUID
	color = "#2ab182"
	taste_description = "strangely savory cider"
	overdose_threshold = 16
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/endurancepot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/endurancebuff)
	if(holder.has_reagent(/datum/reagent/medicine/endurancepot))
		holder.remove_reagent(/datum/reagent/medicine/endurancepot, 20)
	..()
	. = 1 

/datum/reagent/medicine/constitutionpot
	name = "Ironskin Potion"
	description = "Increases one's Constitution."
	reagent_state = LIQUID
	color = "#775c55"
	taste_description = "iron and blood"
	overdose_threshold = 16
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/constitutionpot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/constitutionbuff)
	if(holder.has_reagent(/datum/reagent/medicine/constitutionpot))
		holder.remove_reagent(/datum/reagent/medicine/constitutionpot, 20)
	..()
	. = 1 

/datum/reagent/medicine/invispot
	name = "Invisibility Potion"
	description = "Makes one invisible."
	reagent_state = LIQUID
	color = "#775c55"
	taste_description = "my skin burning"
	overdose_threshold = 16
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/invispot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/invisbuff)
	if(holder.has_reagent(/datum/reagent/medicine/invispot))
		holder.remove_reagent(/datum/reagent/medicine/invispot, 20)
	..()
	. = 1 

/datum/reagent/medicine/nullmagicpot
	name = "Null Magic Potion"
	description = "Makes one immune to magic."
	reagent_state = LIQUID
	color = "#cea4f6"
	taste_description = "fizzing oil"
	overdose_threshold = 16
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/nullmagicpot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/nullmagicbuff)
	if(holder.has_reagent(/datum/reagent/medicine/nullmagicpot))
		holder.remove_reagent(/datum/reagent/medicine/nullmagicpot, 20)
	..()
	. = 1 

/datum/reagent/medicine/intellectpot
	name = "Intellect Potion"
	description = "Increases one's Intelligence and Perception."
	reagent_state = LIQUID
	color = "#922296"
	taste_description = "whispering insight"
	overdose_threshold = 19
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/intellectpot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/intellectbuff)
	if(holder.has_reagent(/datum/reagent/medicine/intellectpot))
		holder.remove_reagent(/datum/reagent/medicine/intellectpot, 20)
	..()
	. = 1 

/datum/reagent/medicine/virilitypot
	name = "Virlity Potion"
	description = "Increases one's virility."
	reagent_state = LIQUID
	color = "#ffa6f8"
	taste_description = "aching virility"
	overdose_threshold = 9
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/virilitypot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/virilitybuff)
	if(holder.has_reagent(/datum/reagent/medicine/virilitypot))
		holder.remove_reagent(/datum/reagent/medicine/virilitypot, 10)
	.. ()
	. = 1 
