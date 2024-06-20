/datum/anvil_recipe/valuables
	appro_skill = /datum/skill/craft/blacksmithing
	craftdiff = 2

/datum/anvil_recipe/valuables/gold
	name = "Statue"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/roguestatue/gold
	i_type = "Valuables"

/datum/anvil_recipe/valuables/silver
	name = "Statue"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/roguestatue/silver
	i_type = "Valuables"

/datum/anvil_recipe/valuables/iron
	name = "Statue"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/roguestatue/iron
	i_type = "Valuables"

/datum/anvil_recipe/valuables/steel
	name = "Statue"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/roguestatue/steel
	i_type = "Valuables"

/*
/datum/anvil_recipe/valuables/eargol
	name = "gold earrings"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/rogueacc/eargold,
						/obj/item/rogueacc/eargold,
						/obj/item/rogueacc/eargold)
	type = "Valuables"

/datum/anvil_recipe/valuables/earsil
	name = "silver earrings"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/rogueacc/earsilver,
						/obj/item/rogueacc/earsilver,
						/obj/item/rogueacc/earsilver)*/
//	i_type = "Valuables"

/datum/anvil_recipe/valuables/ringg
	name = "Rings 3x"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/clothing/ring/gold, /obj/item/clothing/ring/gold, /obj/item/clothing/ring/gold)
	i_type = "Valuables"

/datum/anvil_recipe/valuables/rings
	name = "Rings 3x"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/clothing/ring/silver, /obj/item/clothing/ring/silver, /obj/item/clothing/ring/silver)
	i_type = "Valuables"

//Gold Rings
/datum/anvil_recipe/valuables/emeringg
	name = "Gemerald Ring (+1 Gemerald)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/green)	
	created_item = /obj/item/clothing/ring/emerald
	i_type = "Valuables"

/datum/anvil_recipe/valuables/rubyg
	name = "Rontz Ring (+1 Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem)	
	created_item = /obj/item/clothing/ring/ruby
	i_type = "Valuables"

/datum/anvil_recipe/valuables/topazg
	name = "Toper Ring (+1 Toper)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/yellow)	
	created_item = /obj/item/clothing/ring/topaz
	i_type = "Valuables"

/datum/anvil_recipe/valuables/quartzg
	name = "Blortz Ring (+1 Blortz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/blue)	
	created_item = /obj/item/clothing/ring/quartz
	i_type = "Valuables"

/datum/anvil_recipe/valuables/sapphireg
	name = "Saffira Ring (+1 Saffira)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/violet)	
	created_item = /obj/item/clothing/ring/sapphire
	i_type = "Valuables"

/datum/anvil_recipe/valuables/diamondg
	name = "Dorpel Ring (+1 Dorpel)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/diamond)	
	created_item = /obj/item/clothing/ring/diamond
	i_type = "Valuables"

//Steel rings
//BE AWARE THOSE RINGS SHOULD BE TURNED TO SILVER ONCE SILVER INGOTS ARE IN PLAY - Sarkness

/datum/anvil_recipe/valuables/emerings
	name = "Gemerald Ring (+1 Gemerald)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/green)	
	created_item = /obj/item/clothing/ring/emeralds
	i_type = "Valuables"

/datum/anvil_recipe/valuables/rubys
	name = "Rontz Ring (+1 Rontz)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem)	
	created_item = /obj/item/clothing/ring/rubys
	i_type = "Valuables"

/datum/anvil_recipe/valuables/topazs
	name = "Toper Ring (+1 Toper)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/yellow)	
	created_item = /obj/item/clothing/ring/topazs
	i_type = "Valuables"

/datum/anvil_recipe/valuables/quartzs
	name = "Blortz Ring (+1 Blortz)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/blue)	
	created_item = /obj/item/clothing/ring/quartzs
	i_type = "Valuables"

/datum/anvil_recipe/valuables/sapphires
	name = "Saffira Ring (+1 Saffira)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/violet)	
	created_item = /obj/item/clothing/ring/sapphires
	i_type = "Valuables"

/datum/anvil_recipe/valuables/diamonds
	name = "Dorpel Ring (+1 Dorpel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/diamond)	
	created_item = /obj/item/clothing/ring/diamonds
	i_type = "Valuables"

/datum/anvil_recipe/valuables/terminus
	name = "Terminus Est (+1 Gold Bar, +1 Steel, +1 Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/ingot/steel, /obj/item/roguegem)	
	created_item = /obj/item/rogueweapon/sword/long/exe/cloth
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/valuables/dragon
	name = "Dragon Ring (+ Secrets)"
	req_bar =  /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold, /obj/item/ingot/steel, /obj/item/roguegem/blue, /obj/item/roguegem/violet, /obj/item/clothing/neck/roguetown/psicross)	
	created_item = /obj/item/clothing/ring/dragon_ring
	i_type = "Valuables"
