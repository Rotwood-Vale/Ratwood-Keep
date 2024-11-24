

/datum/supply_pack/rogue/luxury
	group = "Luxury"
	crate_name = "merchant guild's crate"
	crate_type = /obj/structure/closet/crate/chest/merchant

/datum/supply_pack/rogue/luxury/sigs
	name = "Pipe Weed Zig"
	cost = 3
	contains = list(/obj/item/clothing/mask/cigarette/rollie/nicotine)

/datum/supply_pack/rogue/luxury/coolersigs
	name = "Swamp Weed Zig"
	cost = 8
	contains = list(/obj/item/clothing/mask/cigarette/rollie/cannabis)

/datum/supply_pack/rogue/luxury/perfume
	name = "Perfume"
	cost = 15
	contains = list(/obj/item/perfume/random)

/datum/supply_pack/rogue/luxury/ozium
	name = "Ozium"
	cost = 5
	contains = list(/obj/item/reagent_containers/powder/ozium)

/datum/supply_pack/rogue/luxury/moondust
	name = "Moon Dust"
	cost = 30
	contains = list(/obj/item/reagent_containers/powder/moondust)

/datum/supply_pack/rogue/luxury/spice
	name = "Spice"
	cost = 20
	contains = list(/obj/item/reagent_containers/powder/spice)

/*/datum/supply_pack/rogue/luxury/westspice
	name = "Western Herbs"
	cost = 50
	contains = list(/obj/item/reagent_containers/food/snacks/grown/westspice)

/datum/supply_pack/rogue/luxury/eastspice
	name = "Eastern Spices"
	cost = 200
	contains = list(/obj/item/reagent_containers/food/snacks/grown/eastspice)
*/
/datum/supply_pack/rogue/luxury/mbox
	name = "Music Box"
	cost = 500
	contains = list(/obj/item/dmusicbox)

/datum/supply_pack/rogue/luxury/flute
	name = "Flute"
	cost = 10
	contains = list(/obj/item/rogue/instrument/flute)

/datum/supply_pack/rogue/luxury/harp
	name = "Harp"
	cost = 20
	contains = list(/obj/item/rogue/instrument/harp)

/datum/supply_pack/rogue/luxury/guitar
	name = "Guitar"
	cost = 30
	contains = list(/obj/item/rogue/instrument/guitar)

/datum/supply_pack/rogue/luxury/accord
	name = "Accordion"
	cost = 30
	contains = list(/obj/item/rogue/instrument/accord)

/datum/supply_pack/rogue/luxury/lute
	name = "Lute"
	cost = 20
	contains = list(/obj/item/rogue/instrument/lute)

/datum/supply_pack/rogue/luxury/drum
	name = "Drum"
	cost = 10
	contains = list(/obj/item/rogue/instrument/drum)

/datum/supply_pack/rogue/luxury/nomag
	name = "Ring of Null Magic"
	cost = 300
	contains = list(/obj/item/clothing/ring/active/nomag)

/datum/supply_pack/rogue/luxury/scrying
	name = "Scrying Orb"
	cost = 300
	contains = list(/obj/item/scrying)

/datum/supply_pack/rogue/luxury/listenst
	name = "Gemerald Choker"
	cost = 250
	contains = list(/obj/item/listenstone)

/datum/supply_pack/rogue/luxury/riddleofsteel
	name = "Riddle of Steel"
	cost = 400
	contains = list(/obj/item/riddleofsteel)

/datum/supply_pack/rogue/luxury/lovepotion
	name = "Love Potion"
	cost = 600
	contains = list(/obj/item/lovepotion)

//Love potion - Charged Pink
/obj/item/lovepotion
	name = "love potion"
	desc = "A pink potion with a faintly sweet and fruity aroma emanating from the bottle. The label reads \"Love Potion\" and says it will make nearly anyone desire you."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "lovebottle"

/obj/item/slimepotion/lovepotion/attack(mob/living/carbon/human/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, span_warning("A love potion can only be metabolized by living beings. I'd best not waste it!"))
		return ..()
	if(istype(M, /mob/living/simple_animal/hostile/megafauna))
		to_chat(user, span_warning("Creatures of darkness cannot be affected by love potions. I'd best not waste it!"))
		return ..()
	if(user == M)
		to_chat(user, span_warning("It's too risky to consume this potion myself. Instead, I should feed it to someone I desire!"))
		return ..()
	if(M.has_status_effect(STATUS_EFFECT_INLOVE))
		to_chat(user, span_warning("[M] is already consumed by obsession for someone else!"))
		return ..()

	M.visible_message(span_danger("[user] starts to feed [M] a love potion!"),
		span_danger("[user] starts to feed you a love potion!"))

	if(!do_after(user, 50, target = M))
		return
	to_chat(user, span_notice("I feed [M] the love potion!"))
	to_chat(M, span_notice("I taste strawberries as the potion pours down my throat. My heart pounds against my chest as my mind becomes clouded with thoughts of [user]. Be this true love or be this obsession, it matters not. For I will have [user]."))
	if(M.mind)
		M.mind.store_memory("You are obsessed with [user].")
	M.faction |= "[REF(user)]"
	M.apply_status_effect(STATUS_EFFECT_INLOVE, user)
	qdel(src)
