/datum/job/roguetown/harbormaster
	ru_title = "Пират Каперов"
	ru_tutorial = "Вы отошли от своего пиратского прошлого и считаете, что видели всё, что могут предложить многочисленные порты известного мира. \
	Если ваше прошлое и научило вас чему-то важному, то в первую очередь необходимости всегда находить себе работу, будь то доставка грузов или каперская \
	служба... Впрочем, среди этой деревенщины и городской бедноты, вы пожалуй в первую очередь выделяетесь готовностью браться за работу, на которую \
	обычно согласны только бандиты. Главное только не подвести матросов, которые доверились вам и тоже сошли на берег. И проклянёт вас Аббисор, \
	если с парнями что-то случится."

/datum/outfit/job/roguetown/harbormaster/pre_equip(mob/living/carbon/human/H)
	..()
	backr = /obj/item/rogueweapon/sword/cutlass
	beltr = /obj/item/gun/ballistic/firearm/arquebus_pistol
	beltl = /obj/item/ammo_holder/bullet/lead
	backpack_contents = list(/obj/item/storage/keyring/harbormaster = 1, /obj/item/reagent_containers/glass/bottle/rogue/wine = 1, /obj/item/powderflask/artificer = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 5, TRUE)
