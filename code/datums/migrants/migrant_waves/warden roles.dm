//The wardens are NOT a tribe, they are former townfolk who have gone wild due to either losing their homes to rot or just feeling like they belong to the forest
//Treat them more like a military hospitaller clan who hate good living standards
//Please NOTE that wardens arent inherent enemies of the town. They loathe rockhillians but do not aim to kill them, the whole point of their expidition is not to spark a war, but protect the wildlife from towners.

/datum/migrant_role/warden/warden //leader of the wave, lorewise had to kill the previous leader, thus is so strong
	name = "Warden of the North"
	greet_text = "You are the champion of Dendor who swore to protect the forest and guide the pack. \
	Your authority is based on your strength, anyone who dares to challenge you must be shown their place. \
	You must make sure the pack doesnt do anything stupid, as much as you loathe Rockhill, you still better keep somewhat warm relations with them."
	outfit = /datum/outfit/job/roguetown/warden/warden
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE
/datum/outfit/job/roguetown/warden/warden
	allowed_patrons = list(/datum/patron/divine/dendor)
/datum/migrant_role/warden/warden/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/title = "Warden"
		H.real_name = "[title] [prev_real_name]"
		H.name = "[title] [prev_name]"
/datum/outfit/job/roguetown/warden/warden/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/volfplate
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	cloak = /obj/item/clothing/cloak/warden
	shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/neck/roguetown/psicross/wood
	neck = /obj/item/clothing/neck/roguetown/gorget/steel
	id = /obj/item/clothing/ring/silver
	belt = /obj/item/storage/belt/rogue/leather/steel
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/rogueweapon/stoneaxe/battle
	backr = /obj/item/rogueweapon/shield/tower/metal
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/mid = 1, /obj/item/flint = 1, /obj/item/ritualfeather = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.change_stat("strength", 4)
		H.change_stat("endurance", 3)
		H.change_stat("constitution", 3)
		H.change_stat("perception", 2)
		H.change_stat("speed", -1)
		if(istype(H.dna.species, /datum/species/lupian) || istype(H.dna.species, /datum/species/halforc) || istype(H.dna.species, /datum/species/lizardfolk) || istype(H.dna.species, /datum/species/dwarf/mountain))
			H.change_stat("strength", -1)
			H.change_stat("speed", 1) //to prevent balance-breaking 16 STR roll, 15 STR is alright
		if(istype(H.dna.species, /datum/species/anthromorphsmall) || istype(H.dna.species, /datum/species/kobold) || istype(H.dna.species, /datum/species/moth) || istype(H.dna.species, /datum/species/elf/wood))
			H.change_stat("strength", 1) //the wave prioritizes raw strength
		H.grant_language(/datum/language/beast)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NORTHERNWARDEN, TRAIT_GENERIC) //Allows to see other wardens on examine, gives a debuff inside the town, forbids shylocks
	H.cmode_music = 'sound/music/combat_warden.ogg'
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/migrant_role/warden/wraith //warrior
	name = "Wraith of the North"
	greet_text = "You are one of the best fighters in all of the north, trained to take down anyone who threatens the woods. \
	A lot of people deem you a heretic who perverts the dendorite phisolophy, while in reality, you are the true chosen of Psydon. \
	A true volf is a cautious hunter, not a reckless fool. Those towners may be of good use for the pack; they might respect your way of life as long as you dont slay them."
	outfit = /datum/outfit/job/roguetown/warden/wraith
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE
/datum/outfit/job/roguetown/warden/wraith
	allowed_patrons = list(/datum/patron/divine/dendor)
/datum/migrant_role/warden/wraith/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/title = "Warden"
		H.real_name = "[title] [prev_real_name]"
		H.name = "[title] [prev_name]"
/datum/outfit/job/roguetown/warden/wraith/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/volfplate
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	cloak = /obj/item/clothing/cloak/warden
	shoes = /obj/item/clothing/shoes/roguetown/armor
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/neck/roguetown/psicross/wood
	neck = /obj/item/clothing/neck/roguetown/gorget
	belt = /obj/item/storage/belt/rogue/leather/steel
	belt = /obj/item/rogueweapon/mace
	beltr = /obj/item/rogueweapon/stoneaxe/battle
	backr = /obj/item/rogueweapon/shield/wood
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1) //placing the pouch on the belt breaks the game for some reason
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("endurance", 3)
		H.change_stat("constitution", 2)
		H.change_stat("perception", 1)
		H.change_stat("speed", -1)
		if(istype(H.dna.species, /datum/species/lupian) || istype(H.dna.species, /datum/species/halforc) || istype(H.dna.species, /datum/species/lizardfolk) || istype(H.dna.species, /datum/species/dwarf/mountain))
			H.change_stat("strength", -1)
			H.change_stat("speed", 1)
		if(istype(H.dna.species, /datum/species/anthromorphsmall) || istype(H.dna.species, /datum/species/kobold) || istype(H.dna.species, /datum/species/moth) || istype(H.dna.species, /datum/species/elf/wood))
			H.change_stat("strength", 1)
		H.grant_language(/datum/language/beast)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NORTHERNWARDEN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/combat_warden.ogg'
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/migrant_role/warden/shaman //essentially a physician + acolyte class
	name = "Shaman of the North"
	greet_text = "You are the wisest volf in the pack, who's duty is to look after the others and perform rituals in the name of Dendor. \
	You must not let your pack go astray, they all are dependant on your teachings. The Warden is strong, but is still in need of your teachings. \
	Those filthy priests will try to turn everyone against your pack, knowing you are the one bearing the true word of Dendor."
	outfit = /datum/outfit/job/roguetown/warden/shaman
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE
/datum/outfit/job/roguetown/warden/shaman
	allowed_patrons = list(/datum/patron/divine/dendor)
/datum/migrant_role/warden/shaman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/title = "Shaman"
		H.real_name = "[title] [prev_real_name]"
		H.name = "[title] [prev_name]"
/datum/outfit/job/roguetown/warden/shaman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/volfplate
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/newmage/sorcerer
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	cloak = /obj/item/clothing/cloak/warden
	shoes = /obj/item/clothing/shoes/roguetown/armor
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/leather/advanced
	wrists = /obj/item/clothing/neck/roguetown/psicross/wood
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/huntingknife
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/rogueweapon/woodstaff
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/fancy/skit = 1, /obj/item/storage/fancy/ifak = 1, /obj/item/reagent_containers/glass/alembic = 1, /obj/item/ritualfeather = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/druidic, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("perception", 3)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)
		H.grant_language(/datum/language/beast)
		H.mind.AddSpell(new SPELL_DIAGNOSE)
		H.mind.AddSpell(new SPELL_CURE_ROT)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC) //needed for surgeries
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NORTHERNWARDEN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNEESTINGER_IMMUNITY, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/combat_warden.ogg'
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/migrant_role/warden/forager //hunter + knave class
	name = "Forager of the North"
	greet_text = "Being the most agile member of the pack, you are responsible for the scout duty, hunting and stealthy operations. \
	The pack relies on your information as well as they await you every night, expecting some fresh meat of your preys."
	outfit = /datum/outfit/job/roguetown/warden/forager
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE
/datum/outfit/job/roguetown/warden/forager
	allowed_patrons = list(/datum/patron/divine/dendor)
/datum/migrant_role/warden/forager/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/title = "Warden"
		H.real_name = "[title] [prev_real_name]"
		H.name = "[title] [prev_name]"
/datum/outfit/job/roguetown/warden/warden_shaman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/volfplate
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	cloak = /obj/item/clothing/cloak/warden
	shoes = /obj/item/clothing/shoes/roguetown/armor
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/leather/advanced
	wrists = /obj/item/clothing/neck/roguetown/psicross/wood
	neck = /obj/item/clothing/neck/roguetown/gorget
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/ammo_holder/quiver/bolts
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/flint = 1, /obj/item/rogueweapon/huntingknife)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.change_stat("perception", 3)
		H.change_stat("speed", 3)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
		H.grant_language(/datum/language/beast)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NORTHERNWARDEN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNEESTINGER_IMMUNITY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/combat_warden.ogg'
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/migrant_role/warden/sheep //de jure carpenter+mason class, de facto rapebait class
	name = "Slave"
	greet_text = "You've continiously refused to be a volf; on the contrary, you embraced your lyfe as a sheep. \
	 You were either enslaved by the pack during yet another raid or came willingly, now you live to please your new masters."
	outfit = /datum/outfit/job/roguetown/warden/sheep
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE
/datum/outfit/job/roguetown/warden/sheep/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/collar/leather/cursed
	armor = /obj/item/clothing/suit/roguetown/shirt/tunic/random
	pants = /obj/item/clothing/under/roguetown/tights/random
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/storage/belt/rogue/pouch
	beltr = /obj/item/flint
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.grant_language(/datum/language/beast)
		H.change_stat("intelligence", 2)
		H.change_stat("speed", 1)
		H.change_stat("strength", -2)
		H.change_stat("constitution", -2)
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/combat_warden.ogg'