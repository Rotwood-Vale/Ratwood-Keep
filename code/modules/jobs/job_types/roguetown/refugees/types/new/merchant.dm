/datum/subclass/merchant
	name = "Merchant"
	tutorial = "You deserted your post and fled from the battlefield\
				after having witnessed first hand the horrors of war and the disastrous campaigns against the deadite hordes of the south.\
				You now seek refuge in a place where your past allegiance wont be recognized, hoping that the rot hasn't followed you.\ "

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)
	allowed_patrons = ALL_PATRONS

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/merchant

/datum/outfit/job/roguetown/refugee/merchant/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Peddler", "Spicer", "Hoaxer")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Peddler")

		if("Spicer")

		if("Hoaxer")

	H.set_blindness(0)
