/datum/job/roguetown/seamster
	ru_title = "Портной"
	ru_f_title = "Швея"
	ru_tutorial = "Вы - тот, кто шьёт хорошую одежду. Вы берётесь за любую работу, будь то ремонт кожаную броню грабителей, штопанье одежду простых людей, \
				одежды священников или даже плаща Герцога. \
				Спустя многочисленные бессонные ночи и реки пота с вашего лба, вы смогли приобрести свою мастерскую. \
				Что вы делаете теперь, зависит от вас, а также от вашей иголки и нитки..."

/datum/outfit/job/roguetown/seamster/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/craft/hunting, 3, TRUE)
