/datum/job/roguetown/archivist
	title = "Scholar"
	tutorial = "You've spent lots of time reading scrolls and tomes, gradually becoming a walking encyclopedia. \
	Scholars meticulously preserve and organize ancient texts, safeguarding the collective knowledge of the realm for generations to come. \
	Nobles and Peasants alike often seek the Scholars expertise on matters of history and fact."
	flag = ARCHIVIST
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_SHUNNED_UP
	allowed_ages = ALL_AGES_LIST
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/archivist
	spells = list(/obj/effect/proc_holder/spell/invoked/teach, /obj/effect/proc_holder/spell/invoked/learnspell, /obj/effect/proc_holder/spell/targeted/touch/prestidigitation, /obj/effect/proc_holder/spell/invoked/projectile/fetch, /obj/effect/proc_holder/spell/invoked/message)
	display_order = JDO_ARCHIVIST
	give_bank_account = 25
	min_pq = 5 //the player should actually have some experience to properly play the role
	max_pq = null

/datum/outfit/job/roguetown/archivist
	name = "Scholar"
	jobtype = /datum/job/roguetown/archivist
	allowed_patrons = list(/datum/patron/divine/noc)

/datum/outfit/job/roguetown/archivist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/nobledress/green
		pants = /obj/item/clothing/under/roguetown/tights/stockings/white
		head  = /obj/item/clothing/head/roguetown/roguehood/black
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/nightman
		pants = /obj/item/clothing/under/roguetown/tights/black
		head = /obj/item/clothing/head/roguetown/nightman
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/fancy/ifak = 1, /obj/item/reagent_containers/glass/alembic = 1, /obj/item/rogueweapon/huntingknife/idagger)
	beltl = /obj/item/storage/keyring/archivist
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	mask = /obj/item/clothing/mask/rogue/spectacles

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.grant_language(/datum/language/elvish)
		H.grant_language(/datum/language/dwarvish)
		H.grant_language(/datum/language/orcish)
		H.grant_language(/datum/language/canilunzt)
		H.grant_language(/datum/language/felid)
		ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("intelligence", 4)
		if(H.age == AGE_OLD)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
		H.mind.adjust_spellpoints(-2)

/datum/outfit/job/roguetown/archivist/post_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE

//A spell to teach other characters new skills
/obj/effect/proc_holder/spell/invoked/teach
	name = "The Tutor's Calling"
	overlay_state = "book1"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	antimagic_allowed = TRUE

/obj/effect/proc_holder/spell/invoked/teach/cast(list/targets, mob/user = usr)
	. = ..()
	var/list/choices = list()
	var/list/skill_choices = list(
    /datum/skill/misc/reading,
    /datum/skill/misc/lockpicking,
    /datum/skill/misc/riding,
    /datum/skill/misc/music,
    /datum/skill/misc/treatment,
    /datum/skill/misc/sewing,
    /datum/skill/magic/arcane,
    /datum/skill/labor/farming,
    /datum/skill/craft/crafting,
    /datum/skill/craft/blacksmithing,
    /datum/skill/craft/carpentry,
    /datum/skill/craft/masonry,
    /datum/skill/craft/cooking,
    /datum/skill/craft/engineering
    )
	for(var/i = 1, i <= skill_choices.len, i++)
		choices["[skill_choices[i].name]"] = skill_choices[i]

	var/teachingtime = 10 SECONDS

	if(isliving(targets[1]))
		var/mob/living/L = targets[1]
		if(L == usr)
			to_chat(L, span_warning("In teaching myself, I become both the question and the answer."))
			return
		else
			if(L in range(1, usr))
				var/chosen_skill = input(L, "Choose a skill") as null|anything in choices
				var/datum/skill/item = choices[chosen_skill]
				if(!item)
					return     // user canceled
				if(alert(L, "Are you sure you want to study [item.name]?", "learning", "Learn", "Cancel") == "Cancel")
					return
				if(HAS_TRAIT(L, TRAIT_STUDENT))
					to_chat(L, span_warning("There's no way I could handle all that knowledge!"))
					to_chat(usr, span_warning("My student cannot handle that much knowledge at once!"))
					return // cannot teach the same target twice
				if(L.mind?.get_skill_level(item) < SKILL_LEVEL_NOVICE)
					to_chat(L, span_warning("I am not skilled enough to understand what I am being taught!"))
					to_chat(usr, span_warning("I try teaching [L] but my student couldnt grasp the lesson!"))
					return
				if(L.mind?.get_skill_level(item) > SKILL_LEVEL_MASTER)
					to_chat(L, span_warning("There's nothing I can learn from that person!"))
					to_chat(usr, span_warning("Am I really supposed to be the teacher there?"))
					return // target must have the skill between novice and expert for the sake of balance
				else
					if(do_after(usr, teachingtime, target = L))
						user.visible_message("<font color='yellow'>[user] teaches [L] a lesson.</font>")
						L.mind?.adjust_skillrank(item, 1, FALSE)
						ADD_TRAIT(L, TRAIT_STUDENT, "[type]")
					else
						to_chat(usr, span_warning("[L] got distracted and wandered off!"))
						to_chat(L, span_warning("I must be more focused on my studies!"))
						return	
			else
				to_chat(usr, span_warning("My student can barely hear me from there."))
				return
	else
		revert_cast()
		return FALSE

