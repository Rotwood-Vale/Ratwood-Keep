
/obj/item/roguestatue
	icon = 'icons/roguetown/items/valuable.dmi'
	name = "statue"
	icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null

/obj/item/roguestatue/gold
	name = "gold statue"
	desc = "Made of heavy, gleaming gold!"
	icon_state = "gstatue1"
	smeltresult = /obj/item/ingot/gold
	sellprice = 120

/obj/item/roguestatue/gold/Initialize()
	. = ..()
	icon_state = "gstatue[pick(1,2)]"

/obj/item/roguestatue/gold/loot
	name = "gold statuette"
	desc = "Made of heavy, gleaming gold!"
	icon_state = "lstatue1"
	sellprice = 45

/obj/item/roguestatue/gold/loot/Initialize()
	. = ..()
	sellprice = rand(45,100)
	icon_state = "lstatue[pick(1,2)]"

/obj/item/roguestatue/silver
	name = "silver statue"
	desc = "Made of pure, shimmering silver!"
	icon_state = "sstatue1"
	smeltresult = /obj/item/ingot/silver
	sellprice = 90

/obj/item/roguestatue/silver/Initialize()
	. = ..()
	icon_state = "sstatue[pick(1,2)]"

/obj/item/roguestatue/steel
	name = "steel statue"
	desc = "An unyielding statue of resilient steel."
	icon_state = "ststatue1"
	smeltresult = /obj/item/ingot/steel
	sellprice = 60

/obj/item/roguestatue/steel/Initialize()
	. = ..()
	icon_state = "ststatue[pick(1,2)]"

/obj/item/roguestatue/iron
	name = "iron statue"
	desc = "A forged statue of cast iron!"
	icon_state = "istatue1"
	smeltresult = /obj/item/ingot/iron
	sellprice = 40

/obj/item/roguestatue/iron/Initialize()
	. = ..()
	icon_state = "istatue[pick(1,2)]"

/obj/item/roguestatue/iron/deformed
	name = "deformed iron statue"
	desc = "Theres something strange about this statue..."
	icon_state = "istatue1"
	smeltresult = /obj/item/rogueore/iron
	sellprice = 10
