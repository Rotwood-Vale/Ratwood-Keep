/proc/init_loadout()
    var/list/L = list()
    for (var/path in subtypesof(/datum/loadout_item))
        var/datum/loadout_item/loadout_item = new path()
        L[path] = loadout_item
    return L

GLOBAL_LIST_INIT(loadout_items, init_loadout())

/datum/loadout_item
	var/name = "Parent loadout datum"
	var/desc
	var/path
	var/donoritem			//autoset on new if null
	var/list/ckeywhitelist

/datum/loadout_item/New()
	if(isnull(donoritem))
		if(ckeywhitelist)
			donoritem = TRUE

/datum/loadout_item/proc/donator_ckey_check(key)
	if(ckeywhitelist && ckeywhitelist.Find(key))
		return TRUE
	return

//Miscellaneous

/datum/loadout_item/card_deck
	name = "Card Deck"
	path = /obj/item/toy/cards/deck

//HATS
/datum/loadout_item/shalal
	name = "Keffiyeh"
	path = /obj/item/clothing/head/roguetown/roguehood/shalal

/datum/loadout_item/tricorn
	name = "Tricorn Hat"
	path = /obj/item/clothing/head/roguetown/helmet/tricorn


/datum/loadout_item/strawhat
	name = "Straw Hat"
	path = /obj/item/clothing/head/roguetown/strawhat

/datum/loadout_item/bardhat
	name = "Bard Hat"
	path = /obj/item/clothing/head/roguetown/bardhat

/datum/loadout_item/fancyhat
	name = "Fancy Hat"
	path = /obj/item/clothing/head/roguetown/fancyhat


/datum/loadout_item/headband
	name = "Headband"
	path = /obj/item/clothing/head/roguetown/headband

/datum/loadout_item/buckled_hat
	name = "Buckled Hat"
	path = /obj/item/clothing/head/roguetown/puritan

/datum/loadout_item/duelist_hat
	name = "Duelist's Hat"
	path = /obj/item/clothing/head/roguetown/duelhat

/datum/loadout_item/hood
	name = "Hood"
	path = /obj/item/clothing/head/roguetown/roguehood

/datum/loadout_item/heavyhood
	name = "Heavy Hood"
	path = /obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood

/datum/loadout_item/nunveil
	name = "Nun Veil"
	path = /obj/item/clothing/head/roguetown/nun
//CLOAKS
/datum/loadout_item/tabard
	name = "Tabard"
	path = /obj/item/clothing/cloak/tabard

/datum/loadout_item/surcoat
	name = "Surcoat"
	path = /obj/item/clothing/cloak/stabard

/datum/loadout_item/jupon
	name = "Jupon"
	path = /obj/item/clothing/cloak/stabard/surcoat

/datum/loadout_item/cape
	name = "Cape"
	path = /obj/item/clothing/cloak/cape

/datum/loadout_item/halfcloak
	name = "Halfcloak"
	path = /obj/item/clothing/cloak/half


/datum/loadout_item/raincloak
	name = "Rain Cloak"
	path = /obj/item/clothing/cloak/raincloak

/datum/loadout_item/furcloak
	name = "Fur Cloak"
	path = /obj/item/clothing/cloak/raincloak/furcloak

//SHOES
/datum/loadout_item/darkboots
	name = "Dark Boots"
	path = /obj/item/clothing/shoes/roguetown/boots

/datum/loadout_item/babouche
	name = "Babouche"
	path = /obj/item/clothing/shoes/roguetown/armor/shalal

/datum/loadout_item/nobleboots
	name = "Noble Boots"
	path = /obj/item/clothing/shoes/roguetown/armor/nobleboot

/datum/loadout_item/sandals
	name = "Sandals"
	path = /obj/item/clothing/shoes/roguetown/sandals

/datum/loadout_item/shortboots
	name = "Short Boots"
	path = /obj/item/clothing/shoes/roguetown/shortboots

/datum/loadout_item/gladsandals
	name = "Gladiatorial Sandals"
	path = /obj/item/clothing/shoes/roguetown/gladiator

/datum/loadout_item/ridingboots
	name = "Riding Boots"
	path = /obj/item/clothing/shoes/roguetown/ridingboots

/datum/loadout_item/ankletsfur
	name = "Fur Anklets"
	path = /obj/item/clothing/shoes/roguetown/boots/furlinedanklets

/datum/loadout_item/exoticanklets
	name = "Exotic Anklets"
	path = /obj/item/clothing/shoes/roguetown/anklets

//SHIRTS
/datum/loadout_item/longcoat
	name = "Longcoat"
	path = /obj/item/clothing/suit/roguetown/armor/longcoat

/datum/loadout_item/robe
	name = "Robe"
	path = /obj/item/clothing/suit/roguetown/shirt/robe

/datum/loadout_item/formalsilks
	name = "Formal Silks"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan

/datum/loadout_item/longshirt
	name = "Shirt"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/black

/datum/loadout_item/shortshirt
	name = "Short-sleeved Shirt"
	path = /obj/item/clothing/suit/roguetown/shirt/shortshirt

/datum/loadout_item/sailorshirt
	name = "Striped Shirt"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor

/datum/loadout_item/sailorjacket
	name = "Leather Jacket"
	path = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor

/datum/loadout_item/priestrobe
	name = "Undervestments"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest

/datum/loadout_item/exoticsilkbra
	name = "Exotic Silk Bra"
	path = /obj/item/clothing/suit/roguetown/shirt/exoticsilkbra

/datum/loadout_item/bottomtunic
	name = "Low-cut Tunic"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut

/datum/loadout_item/tunic
	name = "Tunic"
	path = /obj/item/clothing/suit/roguetown/shirt/tunic

/datum/loadout_item/dress
	name = "Dress"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen

/datum/loadout_item/bardress
	name = "Bar Dress"
	path = /obj/item/clothing/suit/roguetown/shirt/dress

/datum/loadout_item/chemise
	name = "Chemise"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress

/datum/loadout_item/sexydress
	name = "Sexy Dress"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy

/datum/loadout_item/straplessdress
	name = "Strapless Dress"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless

/datum/loadout_item/leathervest
	name = "Leather Vest"
	path = /obj/item/clothing/suit/roguetown/armor/leather/vest

/datum/loadout_item/nun_habit
	name = "Nun Habit"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/nun

//PANTS
/datum/loadout_item/tights
	name = "Cloth Tights"
	path = /obj/item/clothing/under/roguetown/tights/black

/datum/loadout_item/leathertights
	name = "Leather Tights"
	path = /obj/item/clothing/under/roguetown/trou/leathertights

/datum/loadout_item/trou
	name = "Work Trousers"
	path = /obj/item/clothing/under/roguetown/trou

/datum/loadout_item/leathertrou
	name = "Leather Trousers"
	path = /obj/item/clothing/under/roguetown/trou/leather

/datum/loadout_item/sailorpants
	name = "Seafaring Pants"
	path = /obj/item/clothing/under/roguetown/tights/sailor

/datum/loadout_item/skirt
	name = "Skirt"
	path = /obj/item/clothing/under/roguetown/skirt

//ACCESSORIES
/datum/loadout_item/stockings
	name = "Stockings"
	path = /obj/item/clothing/under/roguetown/tights/stockings

/datum/loadout_item/silkstockings
	name = "Silk Stockings"
	path = /obj/item/clothing/under/roguetown/tights/stockings/silk

/datum/loadout_item/fishnet
	name = "Fishnet Stockings"
	path = /obj/item/clothing/under/roguetown/tights/stockings/fishnet

/datum/loadout_item/wrappings
	name = "Handwraps"
	path = /obj/item/clothing/wrists/roguetown/wrappings

/datum/loadout_item/loincloth
	name = "Loincloth"
	path = /obj/item/clothing/under/roguetown/loincloth

/datum/loadout_item/spectacles
	name = "Spectacles"
	path = /obj/item/clothing/mask/rogue/spectacles

/datum/loadout_item/fingerless
	name = "Fingerless Gloves"
	path = /obj/item/clothing/gloves/roguetown/fingerless

/datum/loadout_item/exoticsilkbelt
	name = "Exotic Silk Belt"
	path = /obj/item/storage/belt/rogue/leather/exoticsilkbelt

/datum/loadout_item/ragmask
	name = "Rag Mask"
	path = /obj/item/clothing/mask/rogue/rag

/datum/loadout_item/halfmask
	name = "Halfmask"
	path = /obj/item/clothing/mask/rogue/shepherd

/datum/loadout_item/dendormask
	name = "Briar Mask"
	path = /obj/item/clothing/head/roguetown/dendormask

/datum/loadout_item/exoticsilkmask
	name = "Exotic Silk Mask"
	path = /obj/item/clothing/mask/rogue/exoticsilkmask


/datum/loadout_item/pipe
	name = "Pipe"
	path = /obj/item/clothing/mask/cigarette/pipe

/datum/loadout_item/pipewestman
	name = "Westman Pipe"
	path = /obj/item/clothing/mask/cigarette/pipe/westman

/datum/loadout_item/feather
	name = "Feather"
	path = /obj/item/natural/feather

/datum/loadout_item/bell_collar
	name = "Bell Collar"
	path = /obj/item/clothing/neck/roguetown/collar/leather/bell

/datum/loadout_item/cloth_blindfold
	name = "Cloth Blindfold"
	path = /obj/item/clothing/glasses/blindfold

/datum/loadout_item/psicross
	name = "Psydonian Cross"
	path = /obj/item/clothing/neck/roguetown/psicross

/datum/loadout_item/psicross/astrata
	name = "Amulet of Astrata"
	path = /obj/item/clothing/neck/roguetown/psicross/astrata

/datum/loadout_item/psicross/noc
	name = "Amulet of Noc"
	path = /obj/item/clothing/neck/roguetown/psicross/noc

/datum/loadout_item/psicross/abyssor
	name = "Amulet of Abyssor"
	path = /obj/item/clothing/neck/roguetown/psicross/abyssor

/datum/loadout_item/psicross/dendor
	name = "Amulet of Dendor"
	path = /obj/item/clothing/neck/roguetown/psicross/dendor

/datum/loadout_item/psicross/necra
	name = "Amulet of Necra"
	path = /obj/item/clothing/neck/roguetown/psicross/necra

/datum/loadout_item/psicross/pestra
	name = "Amulet of Pestra"
	path = /obj/item/clothing/neck/roguetown/psicross/pestra

/datum/loadout_item/psicross/ravox
	name = "Amulet of Ravox"
	path = /obj/item/clothing/neck/roguetown/psicross/ravox

/datum/loadout_item/psicross/malum
	name = "Amulet of Malum"
	path = /obj/item/clothing/neck/roguetown/psicross/malum

/datum/loadout_item/psicross/eora
	name = "Amulet of Eora"
	path = /obj/item/clothing/neck/roguetown/psicross/eora

/datum/loadout_item/chaperon
    name = "Chaperon (Normal)"
    path = /obj/item/clothing/head/roguetown/chaperon

/datum/loadout_item/chaperon/alt
    name = "Chaperon (Alt)"
    path = /obj/item/clothing/head/roguetown/chaperon/greyscale
