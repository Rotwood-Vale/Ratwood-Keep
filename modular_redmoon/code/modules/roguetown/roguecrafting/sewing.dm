
//original file from code\modules\roguetown\roguecrafting

/datum/crafting_recipe/roguetown/sewing
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage_simple = "sew"
	verbage = "sews"

/* craftdif of 3 = JOURNEYMAN */

/datum/crafting_recipe/roguetown/sewing/kaftan
	name = "kaftan - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/kaftan)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/abyssorhood
	name = "hood (abyssor) - (2 cloths, silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/roguehood/abyssor)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/abyssorrobe
	name = "robes (Abyssor) - (3 cloths, silk; LOOM, EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/abyssor)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/cgorget
	name = "padded gorget - (4 cloths, 2 fibers; EXPERT)"
	result = list(/obj/item/clothing/neck/roguetown/cloth)
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/silk = 2)
	skill_level = 4
