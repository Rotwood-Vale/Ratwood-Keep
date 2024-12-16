/datum/subclass/healer
	name = "Healer"
	tutorial = "You deserted your post and fled from the battlefield\
				after having witnessed first hand the horrors of war and the disastrous campaigns against the deadite hordes of the south.\
				You now seek refuge in a place where your past allegiance wont be recognized, hoping that the rot hasn't followed you.\ "

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)
	allowed_patrons = ALL_PATRONS

	outfit = /datum/outfit/job/roguetown/refugee/healer

/datum/outfit/job/roguetown/refugee/healer/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Herbalist", "War Surgeon")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Herbalist")


		if("War Surgeon")


	H.set_blindness(0)
