/datum/triumph_buy/lich
	triumph_buy_id = "Antagcoin: Lich"
	desc = "Antagcoin: Lich!"
	triumph_cost = 300
	category = TRIUMPH_CAT_ROUND_EFX
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

/datum/triumph_buy/werewolf
	triumph_buy_id = "Antagcoin: Werewolf"
	desc = "Antagcoin: Werewolf!"
	triumph_cost = 150
	category = TRIUMPH_CAT_ROUND_EFX
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

/datum/triumph_buy/maniac
	triumph_buy_id = "Antagcoin: Maniac"
	desc = "Antagcoin: Maniac!"
	triumph_cost = 75
	category = TRIUMPH_CAT_ROUND_EFX
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

/datum/triumph_buy/cult
	triumph_buy_id = "Antagcoin: Cult"
	desc = "Antagcoin: Cult!"
	triumph_cost = 50
	category = TRIUMPH_CAT_ROUND_EFX
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

// We fire this on activate, also DAMN is this nasty
/datum/triumph_buy/lich/on_activate(mob/living/carbon/human/H)
	if(!usr)
		return
	H.mind.special_items["Antagcoin: Lich"] = /obj/item/flip_me/lich

/datum/triumph_buy/werewolf/on_activate(mob/living/carbon/human/H)
	if(!usr)
		return
	H.mind.special_items["Antagcoin: Werewolf"] = /obj/item/flip_me/werewolf

/datum/triumph_buy/maniac/on_activate(mob/living/carbon/human/H)
	if(!usr)
		return
	H.mind.special_items["Antagcoin: Maniac"] = /obj/item/flip_me/maniac

/datum/triumph_buy/cult/on_activate(mob/living/carbon/human/H)
	if(!usr)
		return
	H.mind.special_items["Antagcoin: Cult"] = /obj/item/flip_me/zizocultist

/obj/item/flip_me
	name = "Flip Me"
	desc = "Xylix's gift."
	icon_state = "coin_valid"
	icon = 'icons/roguetown/items/valuable.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/antagcoin_role
	var/sideslist = list("valid", "salad")
	var/coinflip
	var/cooldown = 0

/obj/item/flip_me/lich
	antagcoin_role = /datum/antagonist/lich

/obj/item/flip_me/werewolf
	antagcoin_role = /datum/antagonist/werewolf

/obj/item/flip_me/maniac
	antagcoin_role = /datum/antagonist/maniac

/obj/item/flip_me/zizocultist
	antagcoin_role = /datum/antagonist/zizocultist

/obj/item/flip_me/Initialize(mapload)
	. = ..()
	coinflip = pick(sideslist)
	icon_state = "coin_[coinflip]"

/obj/item/flip_me/attack_self(mob/user)
	if(cooldown < world.time)
		cooldown = world.time + 15
		flick("coin_[coinflip]_flip", src)
		coinflip = pick(sideslist)
		icon_state = "coin_[coinflip]"
		playsound(user.loc, 'sound/foley/coinphy (1).ogg', 100, FALSE)
		var/oldloc = loc
		sleep(15)
		if(loc == oldloc && user && !user.incapacitated())
			user.visible_message("<span class='notice'>[user] flips [src]. It lands on [coinflip].</span>", \
				"<span class='notice'>You flip [src]. It lands on [coinflip].</span>", \
				"<span class='hear'>You hear the clattering of loose change.</span>")
	return TRUE//did the coin flip? useful for suicide_act

/obj/item/flip_me/attack_right(mob/user)
	if(!antagcoin_role)
		return
	var/mob/living/pre_antag = user
	pre_antag.mind.add_antag_datum(antagcoin_role)
	playsound(src, 'sound/ravein/small/hello_my_friend.ogg', 100, 1)
	qdel(src)
