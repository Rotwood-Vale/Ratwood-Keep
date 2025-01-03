
/obj/item/roguestatue
	icon = 'icons/roguetown/items/valuable.dmi'
	name = "статуя"
	icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null

/obj/item/roguestatue/gold
	name = "золотая статуя"
	desc = "Сделана из тяжелого, сверкающего золота!"
	icon_state = "gstatue1"
	smeltresult = /obj/item/ingot/gold
	sellprice = 120

/obj/item/roguestatue/gold/Initialize()
	. = ..()
	icon_state = "gstatue[pick(1,2)]"

/obj/item/roguestatue/gold/loot
	name = "золотая статуэтка"
	desc = "Сделана из тяжелого, сверкающего золота!"
	icon_state = "lstatue1"
	sellprice = 45

/obj/item/roguestatue/gold/loot/Initialize()
	. = ..()
	sellprice = rand(45,100)
	icon_state = "lstatue[pick(1,2)]"

/obj/item/roguestatue/silver
	name = "серебряная статуя"
	desc = "Сделана из чистого, мерцающего серебра!"
	icon_state = "sstatue1"
	smeltresult = /obj/item/ingot/silver
	sellprice = 90

/obj/item/roguestatue/silver/Initialize()
	. = ..()
	icon_state = "sstatue[pick(1,2)]"

/obj/item/roguestatue/steel
	name = "стальная статуя"
	desc = "Непреклонная статуя из закаленной стали."
	icon_state = "ststatue1"
	smeltresult = /obj/item/ingot/steel
	sellprice = 60

/obj/item/roguestatue/steel/Initialize()
	. = ..()
	icon_state = "ststatue[pick(1,2)]"

/obj/item/roguestatue/iron
	name = "железная статуя"
	desc = "Кованая статуя из чугуна!"
	icon_state = "istatue1"
	smeltresult = /obj/item/ingot/iron
	sellprice = 40

/obj/item/roguestatue/iron/Initialize()
	. = ..()
	icon_state = "istatue[pick(1,2)]"

/obj/item/roguestatue/iron/deformed
	name = "деформированная железная статуя"
	desc = "В этой статуе есть что-то странное..."
	icon_state = "istatue1"
	smeltresult = /obj/item/rogueore/iron
	sellprice = 10
