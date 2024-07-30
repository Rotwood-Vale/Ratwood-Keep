/datum/job/roguetown/tribalshaman
	title = "Tribal Shaman"
	flag = TRIBALSHAMAN
	department_flag = TRIBAL
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	tutorial = "A tribal druidic shaman that works with shaman magic to heal the wounded and bring the dead back. They also take care of the farming on the side."
	display_order = JDO_TRIBALSHAMAN
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/tribal)
	outfit = /datum/outfit/job/roguetown/tribalshaman
	min_pq = 0
	max_pq = null
	cmode_music = 'sound/music/combat_tribal.ogg'

/datum/outfit/job/roguetown/tribalshaman
	name = "Tribal Shaman"
	jobtype = /datum/job/roguetown/tribalshaman
	allowed_patrons = list(/datum/patron/divine/dendor)

/obj/effect/proc_holder/spell/invoked/heal/shaman
	name = "Mend Wounds"

/obj/effect/proc_holder/spell/invoked/revive/shaman
	name = "Restore Life"

/datum/outfit/job/roguetown/tribalshaman/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.verbs |= /mob/living/carbon/human/proc/tribalannouncement
	H.verbs |= /mob/living/carbon/human/proc/tribalopenslot
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/clothing/mask/rogue/facemask
	neck = /obj/item/clothing/neck/roguetown/psicross/dendor
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/dendor
	shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	head = /obj/item/clothing/head/roguetown/antlerhood
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	r_hand = /obj/item/rogueweapon/woodstaff

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/druidic, 2, TRUE) //This does nothing, but maybe one day it will.
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/druidic, 1, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("endurance", 1)
		H.change_stat("perception", -1)

	ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/cure_rot)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/heal/shaman)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/revive/shaman)
	C.grant_spells_priest(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/obj/effect/proc_holder/spell/self/convertrole/tribal
	name = "Recruit Tribemember"
	new_role = "Tribe Member"
	recruitment_faction = "Tribals"
	recruitment_message = "Serve the tribe, %RECRUIT!"
	accept_message = "FOR THE TRIBE!"
	refuse_message = "I refuse."
