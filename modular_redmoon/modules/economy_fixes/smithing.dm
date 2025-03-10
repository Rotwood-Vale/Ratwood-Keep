/datum/anvil_recipe
	// Сообщение, выдающееся юзеру, если ему не хватает навыка персонажа для крафта на наковальне
	var/low_skill_message = "This recipe is too hard for me... I need to be more skilled."

/*
* ЗОЛОТО - Золотым вещам в среднем пятый навык, если они идут на продажу из города или стоят 120+
*/

/datum/anvil_recipe/cutlery
	low_skill_message = "This recipe is too hard for me... I need to be more skilled to craft golden cutlery."
	skill_level = 5 // Роскошь

/datum/anvil_recipe/valuables/gold
	low_skill_message = "This recipe is too hard for me... I need to be more skilled to craft golden valuables."
	skill_level = 5 // Роскошь

/datum/anvil_recipe/gold_dildo
	low_skill_message = "This recipe is too hard for me... I need to be more skilled to craft it."
	skill_level = 5 // Псайдона четвертовали за вас

/datum/anvil_recipe/weapons/decsword
	skill_level = 4 // Оружие продаётся за себестоимость

/datum/anvil_recipe/weapons/decsaber
	skill_level = 4 // Оружие продаётся за себестоимость

/datum/anvil_recipe/weapons/decrapier
	skill_level = 4 // Оружие продаётся за себестоимость

/datum/anvil_recipe/weapons/terminus
	skill_level = 5 // 2 слитка золота

/*
* СЕРЕБРО - Серебрянным вещам, если они идут на продажу или как драгоценности, четвертый навык
*/

/datum/anvil_recipe/valuables/silver
	skill_level = 4 // Роскошь

/datum/anvil_recipe/cutlery/silver
	skill_level = 4 // Роскошь

/datum/anvil_recipe/silver_dildo
	skill_level = 4 // Псайдона четвертовали за вас

/datum/anvil_recipe/weapons/silver
	skill_level = 3  // Оружие продаётся за себестоимость
