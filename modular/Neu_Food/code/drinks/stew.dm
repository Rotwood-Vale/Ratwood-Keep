/*	........   Reagents   ................ */// These are for the pot, if more vegetables are added and need to be integrated into the pot brewing you need to add them here
/datum/reagent/consumable/soup // so you get hydrated without the flavor system messing it up. Works like water with less hydration
	var/hydration = 6
/datum/reagent/consumable/soup/on_mob_life(mob/living/carbon/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
			H.adjust_hydration(hydration)
		if(M.blood_volume < BLOOD_VOLUME_NORMAL)
			M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_NORMAL)
	..()

/datum/reagent/consumable/soup/porridge
	name = "porridge"
	description = "Softened grain boiled in water. Suitable for peasants."
	reagent_state = LIQUID
	color = "#F8F0E3"
	nutriment_factor = 15
	metabolization_rate = 0.5 // half as fast as normal, last twice as long
	taste_description = "porridge"
	taste_mult = 3
	hydration = 2

/datum/reagent/consumable/soup/porridge/oatmeal
	name = "oatmeal"
	description = "Fitting for a peasant."
	color = "#c38553"

/datum/reagent/consumable/soup/porridge/congee
	name = "congee"
	description = "Rice boiled in water until it is softened. Eaten by the poor and sick in the east. Here, it is considered a medicinal food."
	color = "#F8F0E3"

/datum/reagent/consumable/soup/veggie
	name = "vegetable soup"
	description = ""
	reagent_state = LIQUID
	nutriment_factor = 10
	taste_mult = 4
	hydration = 8

/datum/reagent/consumable/soup/veggie/potato
	name = "potato soup"
	color = "#869256"
	taste_description = "potato broth"

/datum/reagent/consumable/soup/veggie/onion
	name = "onion soup"
	color = "#a6b457"
	taste_description = "boiled onions"

/datum/reagent/consumable/soup/veggie/cabbage
	name = "cabbage soup"
	color = "#859e56"
	taste_description = "watery cabbage"

/datum/reagent/consumable/soup/stew
	name = "thick stew"
	description = "All manners of edible bits went into this."
	reagent_state = LIQUID
	nutriment_factor = 20
	taste_mult = 4

/datum/reagent/consumable/soup/stew/chicken
	name = "chicken stew"
	color = "#baa21c"
	taste_description = "chicken"

/datum/reagent/consumable/soup/stew/meat
	name = "meat stew"
	color = "#80432a"
	taste_description = "meat"

/datum/reagent/consumable/soup/stew/fish
	name = "fish stew"
	color = "#c7816e"
	taste_description = "fish"

/datum/reagent/consumable/soup/stew/rabbit
	name = "cabbit stew"
	color = "#c59182"
	taste_description = "cabbit"

/datum/reagent/consumable/soup/stew/bisque
	name = "bisque"
	color = "#ffb74f" // Bisque like color I know bisque's more complicated than that 
	taste_description = "shellfish"

/datum/reagent/consumable/soup/stew/yucky
	name = "yucky stew"
	color = "#9e559c"
	taste_description = "something rancid"

/datum/reagent/consumable/soup/stew/berry
	name = "berry stew"
	color = "#863333"
	taste_description = "sweet berries"

/datum/reagent/consumable/soup/stew/berry_poisoned
	name = "berry stew"
	color = "#863333"
	taste_description = "suspiciously bitter berries"

/datum/reagent/consumable/soup/oatmeal
	name = "oatmeal"
	description = "Fitting for a peasant."
	reagent_state = LIQUID
	color = "#c38553"
	nutriment_factor = 7
	metabolization_rate = 0.5 // half as fast as normal, last twice as long
	taste_description = "oatmeal"
	taste_mult = 5
	hydration = 2

/datum/reagent/consumable/soup/veggie/beet
	color = "#8E3A59"
	taste_description = "watery beets"

// Copy pasted from berry poison, but stew metabolizes much faster so it is less deadly. You CAN use it as a source of hydration / nutrition if you are desperate enough???
/datum/reagent/consumable/soup/stew/berry_poisoned/on_mob_life(mob/living/carbon/M)
	if(volume > 0.09)
		if(isdwarf(M))
			M.add_nausea(1)
			M.adjustToxLoss(0.5)
		else
			M.add_nausea(3) // so one berry or one dose (one clunk of extracted poison, 5u) will make you really sick and a hair away from crit.
			M.adjustToxLoss(2)
	return ..()
