/obj/item/roguegear
	name = "debug шестерня"
	desc = "вы не должны это видеть."
	icon_state = "gear"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/obj/structure/linking

/obj/item/roguegear/Destroy()
	if(linking)
		linking = null
	. = ..()

/obj/item/roguegear/attack_self(mob/user)
	if(linking)
		linking = null
		to_chat(user, span_warning("Соединение прервано."))
		return

/obj/item/roguegear/attack_obj(obj/O, mob/living/user)
	if(!istype(O, /obj/structure))
		return ..()
	var/obj/structure/S = O
	if(linking)
		if(linking == O)
			to_chat(user, span_warning("Нельзя соединить меня с собой."))
			return
		if(linking in S.redstone_attached)
			to_chat(user, span_warning("Уже соединено."))
			linking = null
			return
		S.redstone_attached |= linking
		linking.redstone_attached |= S
		linking = null
		to_chat(user, span_notice("Соединение установлено."))
		return
	else
		linking = S
		to_chat(user, span_info("Соединеяем..."))
		return
	..()

/obj/item/roguegear/bronze
	name = "шестерня"
	desc = "Шестерня с зубцами, тщательно выкованными для плотного сцепления."
	smeltresult = /obj/item/ingot/bronze

/obj/item/roguegear/wood
	var/cart_capacity = 0
	var/misfire_modification
	var/name_prefix

/obj/item/roguegear/wood/basic
	name = "деревянная шестерня"
	desc = "Простая шестерня, способная увеличить грузоподъёмность деревянной телеги."
	icon_state = "wcog"
	metalizer_result = /obj/item/roguegear/bronze
	cart_capacity = 90

/obj/item/roguegear/wood/reliable
	name = "надёжная деревянная шестерня"
	desc = "Шестерня, пропитанная особой эссенцией, делающей её весьма надёжной. Используется в телегах и механизмах."
	icon_state = "wcog2"
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(32, 196, 218, 200))
	cart_capacity = 120
	misfire_modification = 0
	name_prefix = "прочная"

/obj/item/roguegear/wood/unstable
	name = "нестабильная деревянная шестерня"
	desc = "Шестерня, пропитанная особой эссенцией, из-за которой может сломаться в любой момент. Используется в телегах и механизмах."
	icon_state = "wcog2"
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(167, 17, 17, 200))
	cart_capacity = 140
	misfire_modification = 100
