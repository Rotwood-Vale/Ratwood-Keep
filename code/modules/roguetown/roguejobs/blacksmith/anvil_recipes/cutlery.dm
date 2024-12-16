/datum/anvil_recipe/cutlery
	i_type = "Cutlery"

// Tin / Pewterware
// Possibly make those take quicksilver? Would probably make a niche recipe already too complicated - SunOYH

/datum/anvil_recipe/cutlery/tin
  name = "Pewter Bowl 3x"
  req_bar = /obj/item/ingot/tin
  created_item = list(/obj/item/reagent_containers/glass/bowl/pewter, /obj/item/reagent_containers/glass/bowl/pewter, /obj/item/reagent_containers/glass/bowl/pewter)
  skill_level = 1 // Pewter is v. easy to work with

/datum/anvil_recipe/cutlery/tin/plate
  name = "Pewter Platter 3x"
  req_bar = /obj/item/ingot/tin
  created_item = list(/obj/item/cooking/platter/pewter, /obj/item/cooking/platter/pewter, /obj/item/cooking/platter/pewter)

/datum/anvil_recipe/cutlery/tin/fork
  name = "Pewter Fork 3x"
  req_bar = /obj/item/ingot/tin
  created_item = list(/obj/item/kitchen/ironfork/pewter, /obj/item/kitchen/ironfork/pewter, /obj/item/kitchen/ironfork/pewter)

/datum/anvil_recipe/cutlery/tin/spoon
  name = "Pewter Spoon 3x"
  req_bar = /obj/item/ingot/tin
  created_item = list(/obj/item/kitchen/ironspoon/pewter, /obj/item/kitchen/ironspoon/pewter, /obj/item/kitchen/ironspoon/pewter)

/datum/anvil_recipe/cutlery/tin/cups
  name = "Pewter Tankards 3x"
  req_bar = /obj/item/ingot/tin
  created_item = list(/obj/item/reagent_containers/glass/cup/pewter, /obj/item/reagent_containers/glass/cup/pewter, /obj/item/reagent_containers/glass/cup/pewter)

// Silverware
// No one will bother wasting silver in those, I *know*. But it's here for completness.

/datum/anvil_recipe/cutlery/silver
  name = "Silver Bowl 3x"
  req_bar = /obj/item/ingot/silver
  created_item = list(/obj/item/reagent_containers/glass/bowl/silver, /obj/item/reagent_containers/glass/bowl/silver, /obj/item/reagent_containers/glass/bowl/silver)
  skill_level = 2

/datum/anvil_recipe/cutlery/silver/plate
  name = "Silver Platter 3x"
  req_bar = /obj/item/ingot/silver
  created_item = list(/obj/item/cooking/platter/silver, /obj/item/cooking/platter/silver, /obj/item/cooking/platter/silver)

/datum/anvil_recipe/cutlery/silver/fork
  name = "Silver Fork 3x"
  req_bar = /obj/item/ingot/silver
  created_item = list(/obj/item/kitchen/ironfork/silver, /obj/item/kitchen/ironfork/silver, /obj/item/kitchen/ironfork/silver)

/datum/anvil_recipe/cutlery/silver/spoon
  name = "Silver Spoon 3x"
  req_bar = /obj/item/ingot/silver
  created_item = list(/obj/item/kitchen/ironspoon/silver, /obj/item/kitchen/ironspoon/silver, /obj/item/kitchen/ironspoon/silver)

/datum/anvil_recipe/cutlery/silver/cups
  name = "Silver Goblets 3x"
  req_bar = /obj/item/ingot/silver
  created_item = list(/obj/item/reagent_containers/glass/cup/silver, /obj/item/reagent_containers/glass/cup/silver, /obj/item/reagent_containers/glass/cup/silver)

// Iron

/datum/anvil_recipe/cutlery/iron/cups
	name = "Iron Cups 3x"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/reagent_containers/glass/cup,/obj/item/reagent_containers/glass/cup,/obj/item/reagent_containers/glass/cup)

/datum/anvil_recipe/cutlery/iron/fork
	name = "Iron Fork x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/kitchen/ironfork
	skill_level = 1

/datum/anvil_recipe/cutlery/iron/spoon
	name = "Iron Spoon x3"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/kitchen/ironspoon,
						/obj/item/kitchen/ironspoon,
						/obj/item/kitchen/ironspoon
					)
	skill_level = 1

/datum/anvil_recipe/cutlery/iron/bowl
	name = "Iron Bowl x3"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/reagent_containers/glass/bowl/iron,
						/obj/item/reagent_containers/glass/bowl/iron,
						/obj/item/reagent_containers/glass/bowl/iron
					)
	skill_level = 1

// Steel
/datum/anvil_recipe/cutlery/steel/cups
	name = "Steel Goblets 3x"
	req_bar = /obj/item/ingot/steel
	created_item = list(/obj/item/reagent_containers/glass/cup/steel, /obj/item/reagent_containers/glass/cup/steel, /obj/item/reagent_containers/glass/cup/steel)

// Gold

/datum/anvil_recipe/general/cupsgold
	name = "Gold Goblets 3x"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/reagent_containers/glass/cup/golden, /obj/item/reagent_containers/glass/cup/golden, /obj/item/reagent_containers/glass/cup/golden)