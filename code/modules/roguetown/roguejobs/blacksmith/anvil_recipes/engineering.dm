/datum/anvil_recipe/engineering
	i_type = "Engineering"
	appro_skill = /datum/skill/craft/engineering
	craftdiff = 1
	
// --------- BRONZE RECIPES -----------

/datum/anvil_recipe/engineering/bronze/locks
	name = "Lock"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/customlock
	craftdiff = 1

/datum/anvil_recipe/engineering/bronze/keys
	name = "Keys 2x"
	req_bar = /obj/item/ingot/bronze
	created_item = list(/obj/item/key_custom_blank, /obj/item/key_custom_blank)
	craftdiff = 1

/datum/anvil_recipe/engineering/bronze/cog
	name = "Cog"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/roguegear
	craftdiff = 0

/datum/anvil_recipe/engineering/bronze/lamptern
	name = "Bronze Lamptern"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/flashlight/flare/torch/lantern/bronzelamptern
	craftdiff = 3

/datum/anvil_recipe/engineering/bronze/prosthetic/arm_left
	name = "Bronze Left Arm"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/l_arm/prosthetic/bronze
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/prosthetic/arm_right
	name = "Bronze Right Arm"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/r_arm/prosthetic/bronze
	craftdiff = 4


// --------- GOLD RECIPES -----------

/datum/anvil_recipe/engineering/gold/prosthetic/arm_left
	name = "Gold Left Arm"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/bodypart/l_arm/prosthetic/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/roguegear,/obj/item/roguegear)
	i_type = "General"

/datum/anvil_recipe/engineering/gold/prosthetic/arm_right
	name = "Gold Right Arm"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/bodypart/r_arm/prosthetic/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/roguegear,/obj/item/roguegear)
	i_type = "General"

/datum/anvil_recipe/engineering/gold/prosthetic/leg_left
	name = "Gold Left Leg"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/bodypart/l_leg/prosthetic/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/roguegear,/obj/item/roguegear)
	i_type = "General"

/datum/anvil_recipe/engineering/gold/prosthetic/leg_right
	name = "Gold Right Leg"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/bodypart/r_leg/prosthetic/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/roguegear,/obj/item/roguegear)
	i_type = "General"


// --------- STEEL RECIPES -----------

/datum/anvil_recipe/engineering/steel/prosthetic/arm_left
	name = "Steel Left Arm"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/bodypart/l_arm/prosthetic/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/roguegear, /obj/item/roguegear)
	i_type = "General"

/datum/anvil_recipe/engineering/steel/prosthetic/arm_right
	name = "Steel Right Arm"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/bodypart/r_arm/prosthetic/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/roguegear, /obj/item/roguegear)
	i_type = "General"

/datum/anvil_recipe/engineering/steel/prosthetic/leg_left
	name = "Steel Left Leg"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/bodypart/l_leg/prosthetic/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/roguegear, /obj/item/roguegear)
	i_type = "General"

/datum/anvil_recipe/engineering/steel/prosthetic/leg_right
	name = "Steel Right Leg"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/bodypart/r_leg/prosthetic/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/roguegear, /obj/item/roguegear)
	i_type = "General"


// --------- IRON RECIPES -----------

datum/anvil_recipe/engineering/iron/prosthetic/arm_left
	name = "Iron Left Arm"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/bodypart/l_arm/prosthetic/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/roguegear, /obj/item/roguegear)
	i_type = "General"

/datum/anvil_recipe/engineering/iron/prosthetic/arm_right
	name = "Iron Right Arm"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/bodypart/r_arm/prosthetic/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/roguegear, /obj/item/roguegear)
	i_type = "General"

/datum/anvil_recipe/engineering/iron/prosthetic/leg_left
	name = "Iron Left Leg"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/bodypart/l_leg/prosthetic/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/roguegear, /obj/item/roguegear)
	i_type = "General"

/datum/anvil_recipe/engineering/iron/prosthetic/leg_right
	name = "Iron Right Leg"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/bodypart/r_leg/prosthetic/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/roguegear, /obj/item/roguegear)
	i_type = "General"
