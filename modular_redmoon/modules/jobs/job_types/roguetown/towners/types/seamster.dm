/datum/subclass/seamstress
	ru_name = "Портной"
	ru_tutorial = "Вы швея или швец и вы умеете шить одежду и коврики. \
	Присоединяйтесь к местной мастерской или создайте свою собственную маленькую швейную мастерскую."

/datum/outfit/job/roguetown/towner/seamstress/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/doublet/random
	else
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/doublet/random
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 3, TRUE)
