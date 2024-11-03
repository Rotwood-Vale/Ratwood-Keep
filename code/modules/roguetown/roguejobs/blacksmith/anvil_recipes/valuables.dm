
/datum/anvil_recipe/valuables/special/ringf/obj/item/clothing/neck/roguetown/psicross
	name = "flame ring (+1 Fat, +1 Ftone, +1 Fiber)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/ring/lantern
	additional_items = list(/obj/item/reagent_containers/food/snacks/fat, /obj/item/natural/stone, /obj/item/natural/fibers)
	i_type = "Valuables"

/datum/anvil_recipe/valuables/special/ringp
	name = "blessed ring (+1 Psicross)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/psicross/ring
	additional_items = list(/obj/item/clothing/neck/roguetown/psicross)
	i_type = "Valuables"

/datum/anvil_recipe/valuables/silver/rings
	name = "Rings 3x"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/clothing/ring/silver, /obj/item/clothing/ring/silver, /obj/item/clothing/ring/silver)
	i_type = "Valuables"


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

/datum/anvil_recipe/valuables/gold/rings
	name = "Rings 3x"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/clothing/ring/gold, /obj/item/clothing/ring/gold, /obj/item/clothing/ring/gold)
	i_type = "Valuables"

/datum/anvil_recipe/valuables/silver/rings
	name = "Rings 3x"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/clothing/ring/silver, /obj/item/clothing/ring/silver, /obj/item/clothing/ring/silver)
	i_type = "Valuables"

//Gold Rings
/datum/anvil_recipe/valuables/gold/emering
	name = "Gemerald Ring (+1 Gemerald)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/green)	
	created_item = /obj/item/clothing/ring/emerald
	i_type = "Valuables"

/datum/anvil_recipe/valuables/gold/ruby
	name = "Rontz Ring (+1 Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem)	
	created_item = /obj/item/clothing/ring/ruby
	i_type = "Valuables"

/datum/anvil_recipe/valuables/gold/topaz
	name = "Toper Ring (+1 Toper)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/yellow)	
	created_item = /obj/item/clothing/ring/topaz
	i_type = "Valuables"

/datum/anvil_recipe/valuables/gold/quartz
	name = "Blortz Ring (+1 Blortz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/blue)	
	created_item = /obj/item/clothing/ring/quartz
	i_type = "Valuables"

/datum/anvil_recipe/valuables/gold/sapphire
	name = "Saffira Ring (+1 Saffira)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/violet)	
	created_item = /obj/item/clothing/ring/sapphire
	i_type = "Valuables"

/datum/anvil_recipe/valuables/gold/diamond
	name = "Dorpel Ring (+1 Dorpel)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/diamond)	
	created_item = /obj/item/clothing/ring/diamond
	i_type = "Valuables"

//Steel rings

/datum/anvil_recipe/valuables/silver/emering
	name = "Gemerald Ring (+1 Gemerald)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/green)	
	created_item = /obj/item/clothing/ring/emeralds
	i_type = "Valuables"

/datum/anvil_recipe/valuables/silver/ruby
	name = "Rontz Ring (+1 Rontz)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/roguegem)	
	created_item = /obj/item/clothing/ring/rubys
	i_type = "Valuables"

/datum/anvil_recipe/valuables/silver/topaz
	name = "Toper Ring (+1 Toper)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/roguegem/yellow)	
	created_item = /obj/item/clothing/ring/topazs
	i_type = "Valuables"

/datum/anvil_recipe/valuables/silver/quartz
	name = "Blortz Ring (+1 Blortz)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/roguegem/blue)	
	created_item = /obj/item/clothing/ring/quartzs
	i_type = "Valuables"

/datum/anvil_recipe/valuables/silver/sapphire
	name = "Saffira Ring (+1 Saffira)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/roguegem/violet)	
	created_item = /obj/item/clothing/ring/sapphires
	i_type = "Valuables"

/datum/anvil_recipe/valuables/silver/diamond
	name = "Dorpel Ring (+1 Dorpel)"
	req_bar = /obj/item/ingot/silver
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
	additional_items = list(/obj/item/ingot/gold, /obj/item/ingot/silver, /obj/item/roguegem/blue, /obj/item/roguegem/violet, /obj/item/clothing/neck/roguetown/psicross)	
	created_item = /obj/item/clothing/ring/dragon_ring
	i_type = "Valuables"
