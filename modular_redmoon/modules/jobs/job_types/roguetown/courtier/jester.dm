/datum/job/roguetown/jester
	ru_title = "Шут"
	ru_tutorial = "Гренцельхофтcкая империя славилась своими Дворцовыми Шутами, мудрыми людьми с языком, который был таким же острым, \
	как и их ум и вы – один из них. Вы командуете позицией дураков, завидующих вам, ваших начальников. \
	Ваши дешевые трюки и иллюзии будут работать в зависимости от ваших слов, вашего интеллекта и ваших знаний, \
	и в какой-то момент вы найдете себя в конце чего-то более острого, чем ваш язык. А-А-АРЛЕКИНО."

/datum/outfit/job/roguetown/jester/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
	ADD_TRAIT(H, TRAIT_BARDIC_TRAINING, TRAIT_GENERIC)
