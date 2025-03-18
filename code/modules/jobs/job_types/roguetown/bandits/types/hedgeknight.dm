/datum/subclass/hedgeknight //heavy knight class - just like black knight refugee class. starts with heavy armor training and plate, but less weapon skills than brigand, sellsword and knave
	name = "Hedge Knight"
	tutorial = "A wanted noble fallen from grace, your tarnished armor sits upon your shoulders as a heavy reminder of the life you've lost. Take back what is rightfully yours. But watch out, the duke have made you wanted, as he knows about you."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/bandit/hedgeknight
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/combat_bandit2.ogg'
	maximum_possible_slots = 1
	min_pq = 20
	pickprob = 50

/datum/outfit/job/roguetown/bandit/hedgeknight/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/pigface
	gloves = /obj/item/clothing/gloves/roguetown/chain
	pants = /obj/item/clothing/under/roguetown/chainlegs
	cloak = /obj/item/clothing/cloak/tabard/blkknight
	if(prob(30))
		neck = /obj/item/clothing/neck/roguetown/bervor
	else
		neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/armor
	belt = /obj/item/storage/belt/rogue/leather
	r_hand = /obj/item/rogueweapon/greatsword/zwei
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger = 1)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
	H.mind.AddSpell(new SPELL_JOINCOMRADES)
	H.change_stat("strength", 4)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	H.change_stat("speed", -1)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC) //hey buddy you hear about roleplaying
	ADD_TRAIT(H, TRAIT_WANTED, TRAIT_GENERIC) //Hedgeknights are known around the area
	H.ambushable = FALSE

/obj/effect/proc_holder/spell/invoked/joincomrades
    name = "Recruit Comrade"
    desc = "Recruit someone to your cause and change their patron to Matthios."
    overlay_state = "recruit_bog"
    antimagic_allowed = TRUE
    charge_max = 100
    var/recruitment_message = "Join us, %RECRUIT!"
    var/recruitment_range = 1
    var/accept_message = "I will, comrade!"
    var/refuse_message = "I refuse."

/obj/effect/proc_holder/spell/invoked/joincomrades/cast(list/targets, mob/user = usr)
    . = ..()
    var/list/recruitment = list()
    for(var/mob/living/carbon/human/recruit in (get_hearers_in_view(recruitment_range, user) - user))
        if(!recruit.patron || recruit.patron.type == /datum/patron/inhumen/matthios)
            continue
        recruitment[recruit.name] = recruit
    if(!length(recruitment))
        to_chat(user, span_warning("There are no potential comrades in range."))
        return
    var/inputty = input(user, "Select a potential comrade!", "[name]") as anything in recruitment
    if(inputty)
        var/mob/living/carbon/human/recruit = recruitment[inputty]
        if(!QDELETED(recruit) && (recruit in get_hearers_in_view(recruitment_range, user)))
            if(recruit.patron && recruit.patron.type != /datum/patron/inhumen/matthios)
                var/garbaggio = alert(recruit, "Become our comrade!", "Warning", "Yes", "No")
                if(garbaggio == "Yes")
                    to_chat(user, span_blue("[recruit] joins the comrades!"))
                    recruit.set_patron(/datum/patron/inhumen/matthios)
                else
                    to_chat(recruit, span_danger("I reject the offer."))
                    to_chat(user, span_danger("[recruit] rejects the offer."))
            else
                user << "[recruit]'s patron is already Matthios."
