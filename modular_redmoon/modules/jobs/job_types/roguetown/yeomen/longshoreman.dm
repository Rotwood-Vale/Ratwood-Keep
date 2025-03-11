/datum/job/roguetown/longshoreman
	ru_title = "Капер"
	ru_tutorial = "Вы откликнулись на призыв Абиссора еще в юности, хотя и не без труда, \
	выманивая ценности у всех, кто попадался вам на пути. Теперь бывший капитан отошел от преступной жизни и, \
	как и он, вы служите ему с нерушимой преданностью, пусть и под другим знаменем. Вам предстоит найти себе место в этом городе под предводительством своего капитана, \
	постаравшись не сгинуть в канаве после очередной драки с сухопутной крысой."

/datum/outfit/job/roguetown/longshoreman/pre_equip(mob/living/carbon/human/H)
	..()
	backr = /obj/item/rogueweapon/sword/cutlass
	beltr = /obj/item/gun/ballistic/firearm/arquebus_pistol
	beltl = /obj/item/ammo_holder/bullet/lead
	backpack_contents = list(/obj/item/storage/keyring/harbormaster = 1, /obj/item/reagent_containers/glass/bottle/rogue/wine = 1, /obj/item/powderflask/artificer = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 5, TRUE)
