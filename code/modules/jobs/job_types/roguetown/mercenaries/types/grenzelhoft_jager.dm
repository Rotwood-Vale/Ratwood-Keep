/datum/subclass/grenzelhoft_jager
	name = "Grenzelhoft Jäger"
	tutorial = "Trackers, Huntsmen, Marksmen. Those are the first words that describe a Jäger of the Free Corps. \
	Jägers are skilled handgonners and scouts of the Companies of the Grenzel Emperiate. Beastmen and elves are commonly found to \
	fill the Auxiliary ranks, however you are one of the lucky few that was allowed to join the Free Corps. \
	You are expected to provide the Guild with your expertise in tracking, and scouting. Alongside your marksmanship."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/axian,
		/datum/species/vulpkanin,
		/datum/species/lupian,
		/datum/species/moth, //grenzelmoft?
		/datum/species/dwarf/mountain,
		/datum/species/human/northern,
		/datum/species/demihuman,
		/datum/species/anthromorph,
		/datum/species/tabaxi,
		/datum/species/kobold,
		/datum/species/elf/wood,
		/datum/species/elf/dark,
	)
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft_jager
	maximum_possible_slots = 3
	min_pq = 18
	torch = FALSE
	cmode_music = 'sound/music/combat_grenzelhoft.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/grenzelhoft_jager/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/ammo_holder/bullet/lead
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/powderflask
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel
	backl = /obj/item/storage/backpack/rogue/backpack
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	pants = /obj/item/clothing/under/roguetown/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/armor/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/grenzelgloves
	backr = /obj/item/gun/ballistic/flintgonne
	backpack_contents = list(/obj/item/storage/keyring/mercenary = 1, /obj/item/rogueweapon/huntingknife = 1, /obj/item/flint = 1, /obj/item/bedroll = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1)


	//Humie grenzelhofts are always set to be, well, grenzelhoft
	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(isdemihuman(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(iswoodelf(H))
		H.change_stat("strength", 1)
		H.change_stat("speed", -1)
	if(isdwarfmountain(H))
		H.change_stat("speed", 1)
		H.change_stat("endurance", -1)


	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 2)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 1)
