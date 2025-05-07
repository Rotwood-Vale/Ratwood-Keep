#define ANTAGCOIN_LICH_COST			150
#define ANTAGCOIN_WEREWOLF_COST		75
#define ANTAGCOIN_MANIAC_COST		50
#define ANTAGCOIN_GIFT_COST			50
#define ANTAGCOIN_CULT_COST			25
#define ANTAGCOIN_REVOLUTION_COST	10

/datum/triumph_buy/antagcoin
	var/owner_ckey

/datum/triumph_buy/antagcoin/lich
	triumph_buy_id = "Antagcoin: Lich"
	desc = "Antagcoin: Lich! (Minimum 60 players)"
	triumph_cost = ANTAGCOIN_LICH_COST
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

/datum/triumph_buy/antagcoin/lich/on_buy()
	owner_ckey = usr.ckey
	SStriumphs.post_equip_calls[triumph_buy_id] = src

/datum/triumph_buy/antagcoin/werewolf
	triumph_buy_id = "Antagcoin: Werewolf"
	desc = "Antagcoin: Werewolf! (Minimum 40 players)"
	triumph_cost = ANTAGCOIN_WEREWOLF_COST
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

/datum/triumph_buy/antagcoin/werewolf/on_buy()
	owner_ckey = usr.ckey
	SStriumphs.post_equip_calls[triumph_buy_id] = src

/datum/triumph_buy/antagcoin/maniac
	triumph_buy_id = "Antagcoin: Maniac"
	desc = "Antagcoin: Maniac! (Minimum 40 players)"
	triumph_cost = ANTAGCOIN_MANIAC_COST
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

/datum/triumph_buy/antagcoin/maniac/on_buy()
	owner_ckey = usr.ckey
	SStriumphs.post_equip_calls[triumph_buy_id] = src

/datum/triumph_buy/antagcoin/cult
	triumph_buy_id = "Antagcoin: Cult"
	desc = "Antagcoin: Cult! (Minimum 40 players)"
	triumph_cost = ANTAGCOIN_CULT_COST
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

/datum/triumph_buy/antagcoin/cult/on_buy()
	owner_ckey = usr.ckey
	SStriumphs.post_equip_calls[triumph_buy_id] = src

/datum/triumph_buy/antagcoin/revolution
	triumph_buy_id = "Antagcoin: Revolution"
	desc = "Antagcoin: Revolution! (Minimum 40 players)"
	triumph_cost = ANTAGCOIN_REVOLUTION_COST
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

/datum/triumph_buy/antagcoin/revolution/on_buy()
	owner_ckey = usr.ckey
	SStriumphs.post_equip_calls[triumph_buy_id] = src

/datum/triumph_buy/antagcoin/triumph
	triumph_buy_id = "Antagcoin: 50 Triumphs"
	desc = "Antagcoin: 50 Triumphs!"
	triumph_cost = ANTAGCOIN_GIFT_COST
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

/datum/triumph_buy/antagcoin/triumph/on_buy()
	owner_ckey = usr.ckey
	SStriumphs.post_equip_calls[triumph_buy_id] = src

// We fire this on activate, also DAMN is this nasty
/datum/triumph_buy/antagcoin/lich/on_activate(mob/living/carbon/human/H)
	if(H.ckey != owner_ckey)
		return
	H.mind.special_items["Antagcoin: Lich"] = /obj/item/antagcoin/lich
	SStriumphs.post_equip_calls.Remove(triumph_buy_id)

/datum/triumph_buy/antagcoin/werewolf/on_activate(mob/living/carbon/human/H)
	if(H.ckey != owner_ckey)
		return
	H.mind.special_items["Antagcoin: Werewolf"] = /obj/item/antagcoin/werewolf
	SStriumphs.post_equip_calls.Remove(triumph_buy_id)

/datum/triumph_buy/antagcoin/maniac/on_activate(mob/living/carbon/human/H)
	if(H.ckey != owner_ckey)
		return
	H.mind.special_items["Antagcoin: Maniac"] = /obj/item/antagcoin/maniac
	SStriumphs.post_equip_calls.Remove(triumph_buy_id)

/datum/triumph_buy/antagcoin/cult/on_activate(mob/living/carbon/human/H)
	if(H.ckey != owner_ckey)
		return
	H.mind.special_items["Antagcoin: Cult"] = /obj/item/antagcoin/zizocultist
	SStriumphs.post_equip_calls.Remove(triumph_buy_id)

/datum/triumph_buy/antagcoin/revolution/on_activate(mob/living/carbon/human/H)
	if(H.ckey != owner_ckey)
		return
	H.mind.special_items["Antagcoin: Revolution"] = /obj/item/antagcoin/revolution
	SStriumphs.post_equip_calls.Remove(triumph_buy_id)

/datum/triumph_buy/antagcoin/triumph/on_activate(mob/living/carbon/human/H)
	if(H.ckey != owner_ckey)
		return
	H.mind.special_items["Antagcoin: 50 Triumphs"] = /obj/item/antagcoin/triumph
	SStriumphs.post_equip_calls.Remove(triumph_buy_id)

/obj/item/antagcoin
	name = "Flip Me"
	desc = "Зло, которое нужно привнести в этот мир. (RMB)"
	icon_state = "coin_valid"
	icon = 'modular_redmoon/icons/economy.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/antagcoin_role
	var/sideslist = list("valid", "salad")
	var/coinflip
	var/cooldown = 0
	var/minimum_players = 40
	var/revert_sum = 0

/obj/item/antagcoin/lich
	name = "Flip Me: Lich Energy"
	antagcoin_role = /datum/antagonist/lich
	minimum_players = 60
	revert_sum = ANTAGCOIN_LICH_COST

/obj/item/antagcoin/werewolf
	name = "Flip Me: Werewolf Energy"
	antagcoin_role = /datum/antagonist/werewolf
	minimum_players = 40
	revert_sum = ANTAGCOIN_WEREWOLF_COST

/obj/item/antagcoin/maniac
	name = "Flip Me: Maniac Energy"
	antagcoin_role = /datum/antagonist/maniac
	minimum_players = 40
	revert_sum = ANTAGCOIN_MANIAC_COST

/obj/item/antagcoin/zizocultist
	name = "Flip Me: Zizo Energy"
	antagcoin_role = /datum/antagonist/zizocultist
	minimum_players = 40
	revert_sum = ANTAGCOIN_CULT_COST

/obj/item/antagcoin/revolution
	name = "Flip Me: Rebel Energy"
	antagcoin_role = /datum/antagonist/prebel/head
	minimum_players = 40
	revert_sum = ANTAGCOIN_REVOLUTION_COST

/obj/item/antagcoin/triumph
	name = "Flip Me: Triumph Energy"
	minimum_players = 0
	revert_sum = ANTAGCOIN_GIFT_COST

/obj/item/antagcoin/Initialize(mapload)
	. = ..()
	coinflip = pick(sideslist)
	icon_state = "coin_[coinflip]"

/obj/item/antagcoin/attack_self(mob/user)
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

/obj/item/antagcoin/attack_right(mob/user)
	if(!antagcoin_role)
		return
	if(GLOB.player_list.len < minimum_players)
		to_chat(user, span_warning("Кажется, эта земля пока не готова к таким угрозам... (Стоимость в триумфах возвращена)"))
		user.adjust_triumphs(revert_sum)
		qdel(src)
		return
	var/mob/living/pre_antag = user
	pre_antag.mind.add_antag_datum(antagcoin_role)
	playsound(src, 'sound/ravein/small/hello_my_friend.ogg', 100, 1)
	qdel(src)

/obj/item/antagcoin/triumph/attack_right(mob/user)
	var/mob/living/pre_antag = user
	pre_antag.adjust_triumphs(50)
	playsound(src, 'sound/ravein/small/hello_my_friend.ogg', 100, 1)
	qdel(src)

#undef ANTAGCOIN_LICH_COST
#undef ANTAGCOIN_WEREWOLF_COST
#undef ANTAGCOIN_MANIAC_COST
#undef ANTAGCOIN_CULT_COST
#undef ANTAGCOIN_REVOLUTION_COST
#undef ANTAGCOIN_GIFT_COST
