/datum/anvil_recipe/armor
	appro_skill = /datum/skill/craft/armorsmithing
	craftdiff = 1

/datum/anvil_recipe/armor/ichainmail
	name = "Chainmail"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	i_type = "Armor"

/datum/anvil_recipe/armor/ichaincoif
	name = "Iron Chain Coif"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/chaincoif/iron
	i_type = "Armor"

/datum/anvil_recipe/armor/gorget
	name = "Gorget"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/gorget
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/ibreastplate
	name = "Breastplate (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/footmanchestplate
	name = "Footman Cuirass (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/footmanchestplate
	i_type = "Armor"	

/datum/anvil_recipe/armor/katefractoiichestplate
	name = "Katefractoii Lamellar (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/katefractoiichestplate
	i_type = "Armor"		

/datum/anvil_recipe/armor/ichainglove
	name = "Chain Gauntlets"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/roguetown/chain/iron
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/footmangauntlets
	name = "Footman Gauntlets"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/roguetown/footmangauntlets
	i_type = "Armor"	

/datum/anvil_recipe/armor/katefractoiigauntlets
	name = "Katefractoii Gauntlets"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/roguetown/katefractoiigauntlets
	i_type = "Armor"		

/datum/anvil_recipe/armor/ichainleg
	name = "Chain Chausses"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/under/roguetown/chainlegs/iron
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/footmangreaves
	name = "Footman Greaves"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/shoes/roguetown/boots/footmangreaves
	i_type = "Armor"	

/datum/anvil_recipe/armor/katefractoiigreaves
	name = "Katefractoii Greaves"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/shoes/roguetown/boots/katefractoiigreaves
	i_type = "Armor"		

/datum/anvil_recipe/armor/platemask
	name = "Mask"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/facemask
	i_type = "Armor"

/datum/anvil_recipe/armor/skullcap
	name = "Skullcap"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/skullcap
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/footmanhelmet
	name = "Footman Helmet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/footmanhelmet
	i_type = "Armor"	

/datum/anvil_recipe/armor/katefractoiihelmet
	name = "Katefractoii Helmet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/katefractoiihelmet
	i_type = "Armor"		

/datum/anvil_recipe/armor/studded
	name = "Studded Leather Armor (+Leather Armor)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded
	i_type = "Armor"

/datum/anvil_recipe/armor/studdedbikini
	name = "Studded Leather Bikini (+Leather Bikini)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather/bikini)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded/bikini
	i_type = "Armor"

/datum/anvil_recipe/armor/studdedbikinitwo
	name = "Studded Leather Bikini (+Leather Armor)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded/bikini
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
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/chainkini
	name = "Chainmail Bikini (+1 Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/bikini
	craftdiff = 2
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

/datum/anvil_recipe/armor/darkelfchestplate
	name = "Raider Armour (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/darkelfchestplate
	craftdiff = 3
	i_type = "Armor"	

/datum/anvil_recipe/armor/platefull
	name = "Full-Plate Armour (+3 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full
	craftdiff = 4
	i_type = "Armor"

/datum/anvil_recipe/armor/dwarffull
	name = "Full-Dwarven Armour (+3 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/dwarffull
	craftdiff = 4
	i_type = "Armor"	

/datum/anvil_recipe/armor/platebikini
	name = "Half-Plate Bikini (+2 Steel +1 Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/bikini
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/platefullbikini
	name = "Full-Plate Bikini (+3 Steel +1 Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full/bikini
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
	name = "Steel chain Coif"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/chaincoif
	craftdiff = 2	//steel v iron
	i_type = "Armor"

/datum/anvil_recipe/armor/chainglove
	name = "Chain Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/chain
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/plateglove
	name = "Plate Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/plate
	craftdiff = 4	//It's plate
	i_type = "Armor"

/datum/anvil_recipe/armor/roguetown/darkelfbracers
	name = "Raider Bracers"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/darkelfbracers
	i_type = "Armor"

/datum/anvil_recipe/armor/roguetown/darkelfhelmet
	name = "Raider Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/darkelfhelmet
	craftdiff = 2
	i_type = "Armor"		

/datum/anvil_recipe/armor/dwarfgauntlets
	name = "Dwarven Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/dwarfgauntlets
	i_type = "Armor"	

/datum/anvil_recipe/armor/chainleg
	name = "Chain Chausses"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/chainlegs
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/chainskirt
	name = "Chain Skirt"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/chainlegs/skirt
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/plateskirt
	name = "Plated Skirt (+1 Steel)"
	req_bar = /obj/item/ingot/steel 
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/under/roguetown/platelegs/skirt
	craftdiff = 4	//It's plate, no easy craft.
	i_type = "Armor"
	
/datum/anvil_recipe/armor/brayette
	name = "Brayette"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/brayette
	craftdiff = 2
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
	craftdiff = 3	//It's plate but medium armor style; slightly lower crafting than plate proper.
	i_type = "Armor"

/datum/anvil_recipe/armor/platebracer
	name = "Plate Bracers"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/wrists/roguetown/bracers
	craftdiff = 4
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetnasal
	name = "Nasal Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetsavoyard
	name = "Savoyard Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/guard
	craftdiff = 3	//Heavy helm
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetbarred
	name = "Barred Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/sheriff
	craftdiff = 3	//Heavy helm
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetkettle
	name = "Kettle Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/kettle
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetbarbute
	name = "Barbute Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy
	craftdiff = 3	//Heavy helm
	i_type = "Armor"

/datum/anvil_recipe/armor/dwarfhelm
	name = "Dwarven Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/dwarfhelm
	craftdiff = 2
	i_type = "Armor"	

/datum/anvil_recipe/armor/bervor
	name = "Bervor"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/bervor
	craftdiff = 4	//Better gorget, so more skill
	i_type = "Armor"

/datum/anvil_recipe/armor/winged
	name = "Winged cap"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/winged
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/horned
	name = "Horned cap"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/horned
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetsall
	name = "Sallet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetsallv
	name = "Sallet Visored (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet/visored
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetbuc
	name = "Bucket Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/bascinet
	name = "Bascinet Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetpig
	name = "Bascinet Pigface Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface
	craftdiff = 3	//Good helmet, but not heavy-helmet good.
	i_type = "Armor"

/datum/anvil_recipe/armor/helmetbars
	name = "Barred Bascinet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/helmetbars
	craftdiff = 3	//Almost as good as heavy helm
	i_type = "Armor"

/datum/anvil_recipe/armor/heavy/beakhelmet
	name = "Beak Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/beakhelmet
	craftdiff = 4	//One of the best helms in the game.
	i_type = "Armor"	

/datum/anvil_recipe/armor/helmetknight
	name = "Knight's Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/knight
	craftdiff = 4	//ONe of the best helms in the game
	i_type = "Armor"

/datum/anvil_recipe/armor/plateironboot
	name = "Iron Plated Boots"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/shoes/roguetown/boots/armoriron
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/platesteelboot
	name = "Steel Plated Boots"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/shoes/roguetown/boots/armor
	craftdiff = 4
	i_type = "Armor"

/datum/anvil_recipe/armor/darkelfboots
	name = "Raider Boots"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/shoes/roguetown/boots/darkelfboots
	i_type = "Armor"	

/datum/anvil_recipe/armor/dwarfboots
	name = "Dwarven Boots"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/shoes/roguetown/boots/dwarfboots
	i_type = "Armor"	

/datum/anvil_recipe/armor/platemask/steel
	name = "Mask"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/mask/rogue/facemask/steel
	craftdiff = 2
	i_type = "Armor"

/datum/anvil_recipe/armor/astratahelm
	name = "Astrata Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/astratahelm
	craftdiff = 4	//Heavy helm
	i_type = "Armor"

/datum/anvil_recipe/armor/eorahelm
	name = "Eora Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/eorahelm
	craftdiff = 4	//Heavy helm
	i_type = "Armor"

/datum/anvil_recipe/armor/necrahelm
	name = "Necra Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/necrahelm
	craftdiff = 4	//Heavy helm
	i_type = "Armor"

/datum/anvil_recipe/armor/nochelm
	name = "Noc Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/nochelm
	craftdiff = 4 	//Heavy helm
	i_type = "Armor"

/datum/anvil_recipe/armor/dendorhelm
	name = "Dendor Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
	craftdiff = 4	//Heavy helm
	i_type = "Armor"
