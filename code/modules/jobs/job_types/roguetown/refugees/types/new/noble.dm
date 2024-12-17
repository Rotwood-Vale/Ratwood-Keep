/datum/subclass/noble
	name = "Noble"
	tutorial = "You deserted your post and fled from the battlefield\
				after having witnessed first hand the horrors of war and the disastrous campaigns against the deadite hordes of the south.\
				You now seek refuge in a place where your past allegiance wont be recognized, hoping that the rot hasn't followed you.\ "

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)
	allowed_patrons = ALL_PATRONS

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/noble

/datum/outfit/job/roguetown/refugee/noble/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Fallen Baron", "Disinherited Heir", "Widowed Lady", "Condottiero")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Fallen Baron")

		if("Disinherited Heir")

		if("Widowed Lady")

		if("Condottiero")

	H.set_blindness(0)
