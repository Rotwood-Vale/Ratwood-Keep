/datum/job/roguetown/puritan
	ru_title = "Инквизитор"
	ru_tutorial = "Впопыхах созданная в связи с возрождением культа Псайдона, \
	Инквизиция отправила своих людей в Рокхилл с целью искоренить культистов и проклятых в виде оборотней, \
	вампиров и прочих тварей в этих землях. Руководствуясь религиозным рвением и паранойей, инквизитор надеется, \
	что непростой и шаткий союз с Церковью Десяти устоит."

/datum/job/roguetown/puritan/pre_equip(mob/living/carbon/human/H)
	..()\
	backpack_contents = list(/obj/item/storage/keyring/puritan = 1, /obj/item/rogueweapon/huntingknife/idagger/silver, /obj/item/lockpick = 1, /obj/item/storage/belt/rogue/pouch/coins/rich)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
