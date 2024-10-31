/datum/anvil_recipe/armor
	appro_skill = /datum/skill/craft/blacksmithing
	craftdiff = 1

/datum/anvil_recipe/armor/ichainmail
	name = "Chainmail"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	i_type = "Armor"

/datum/anvil_recipe/armor/ichaincoif
	name = "Chain Coif"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/chaincoif/iron
	i_type = "Armor"

/datum/anvil_recipe/armor/gorget
	name = "Gorget"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/gorget
	i_type = "Armor"

/datum/anvil_recipe/armor/ibreastplate
	name = "Breastplate (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	i_type = "Armor"

/datum/anvil_recipe/armor/ichainglove
	name = "Chain Gauntlets"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/roguetown/chain/iron
	i_type = "Armor"

/datum/anvil_recipe/armor/ichainleg
	name = "Chain Chausses"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/under/roguetown/chainlegs/iron
	i_type = "Armor"

/datum/anvil_recipe/armor/platemask
	name = "Mask"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/facemask
	i_type = "Armor"

/datum/anvil_recipe/armor/platemask/hound
	name = "Mask (Hound)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/facemask/hound
	i_type = "Armor"

/datum/anvil_recipe/armor/skullcap
	name = "Skullcap"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/skullcap
	i_type = "Armor"

/datum/anvil_recipe/armor/studded
	name = "Studded Leather Armor (+Leather Armor)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded
	i_type = "Armor"

/datum/anvil_recipe/armor/lbrigandine
	name = "Light Brigandine (+1 Cloth)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine/light
	i_type = "Armor"

/datum/anvil_recipe/armor/splintarms
	name = "Brigandine Rerebraces (+1 Cloth)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/wrists/roguetown/splintarms
	i_type = "Armor"

/datum/anvil_recipe/armor/splintlegs
	name = "Brigandine Chausses (+1 Cloth)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/under/roguetown/splintlegs
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetgoblin
	name = "Goblin Helmet (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/roguetown/helmet/goblin
	craftdiff = 2
	i_type = "Armor"
	
/datum/anvil_recipe/armor/plategoblin
	name = "Goblin Mail (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/goblin
	craftdiff = 2
	i_type = "Armor"

// --------- STEEL -----------

/datum/anvil_recipe/armor/haubergeon
	name = "Haubergeon"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail
	i_type = "Armor"

/datum/anvil_recipe/armor/hauberk
	name = "Hauberk (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/plate
	name = "Half-Plate Armour (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/platefull
	name = "Full-Plate Armour (+3 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full
	craftdiff = 4
	i_type = "Armor"

/datum/anvil_recipe/armor/coatplates
	name = "Coat Of Plates (+1 Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/brigandine
	name = "Brigandine (+1 Steel +2 Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/cloth, /obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/chaincoif
	name = "Chain Coif"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/chaincoif
	i_type = "Armor"

/datum/anvil_recipe/armor/chainglove
	name = "Chain Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/chain
	i_type = "Armor"

/datum/anvil_recipe/armor/plateglove
	name = "Plate Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/plate
	i_type = "Armor"

/datum/anvil_recipe/armor/chainleg
	name = "Chain Chausses"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/chainlegs
	i_type = "Armor"

/datum/anvil_recipe/armor/brayette
	name = "Brayette"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/brayette
	i_type = "Armor"

/datum/anvil_recipe/armor/platelegs
	name = "Plated Chausses (+1 Steel)"
	req_bar = /obj/item/ingot/steel 
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/under/roguetown/platelegs
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/hplate
	name = "Cuirass (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/scalemail
	name = "Scalemail"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/scale
	i_type = "Armor"

/datum/anvil_recipe/armor/platebracer
	name = "Plate Bracers"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/wrists/roguetown/bracers
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetnasal
	name = "Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet
	i_type = "Armor"

/datum/anvil_recipe/armor/bervor
	name = "Bervor"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/bervor
	i_type = "Armor"

/datum/anvil_recipe/armor/kettle
	name = "Kettle"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/kettle
	i_type = "Armor"

/datum/anvil_recipe/armor/winged
	name = "Winged cap"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/winged
	i_type = "Armor"

/datum/anvil_recipe/armor/horned
	name = "Horned cap"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/horned
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetsall
	name = "Sallet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetsallv
	name = "Sallet Visored (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet/visored
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetbuc
	name = "Bucket Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetpig
	name = "Pigface Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/pigface
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetvolf
	name = "Volf Face Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/volfplate
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/bascinet
	name = "Bascinet Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetknight
	name = "Knight's Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/knight
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/plateboot
	name = "Plated Boots"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/shoes/roguetown/armor/steel
	i_type = "Armor"

/datum/anvil_recipe/armor/platemask/steel
	name = "Mask"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/mask/rogue/facemask/steel
	i_type = "Armor"

/datum/anvil_recipe/armor/platemask/steel/hound
	name = "Mask (Hound)"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/mask/rogue/facemask/steel/hound
	i_type = "Armor"

/datum/anvil_recipe/armor/astratahelm
	name = "Astratan Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/astratahelm
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/astratahelm_alt
	name = "Astratan Helmet Alt (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/astratahelm_alt
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/malumhelm
	name = "Malummite Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/malumhelm
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/necrahelm
	name = "Necran Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/necrahelm
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/necrahelm_alt
	name = "Necran Helmet Alt (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/necrahelm_alt
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/nochelm
	name = "Noctian Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/nochelm
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/dendorhelm
	name = "Dendorite Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/dendorhelm
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/belt_steel
	name = "Steel Belt"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/storage/belt/rogue/leather/hand
	i_type = "Armor"

// --------- SILVER -----------

/datum/anvil_recipe/armor/belt_silver
	name = "Silver Belt"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/storage/belt/rogue/leather/plaquesilver
	i_type = "Armor"


// --------- GOLD -----------

/datum/anvil_recipe/armor/belt_gold
	name = "Gold Belt"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/storage/belt/rogue/leather/plaquegold
	i_type = "Armor"
