/datum/special_trait/natural_talent
    name = "Natural Talent"
    greet_text = span_notice("Ever since I was little, with enough effort, I could do anything I put my mind to")

/datum/special_trait/natural_talent/on_apply(mob/living/carbon/human/character, silent)
    character.change_stat("strength", 1)
    character.change_stat("speed", 1)
    character.change_stat("perception", 1)
    character.change_stat("constitution", 1)
    character.change_stat("endurance", 1)
    character.change_stat("intelligence", 1)

/datum/special_trait/nimrod
    name = "Nimrod"
    greet_text = span_warning("In the past I learned slower than my peers, and I tend to be clumsy")

/datum/special_trait/nimrod/on_apply(mob/living/carbon/human/character, silent)
    character.change_stat("speed", -2)
    character.change_stat("intelligence", -4)

//positive

/datum/special_trait/duelist
	name = "Swordmaster Apprentice"
	greet_text = span_notice("You were the student of a legendary sword master, your skill is rivalled by few!")
	//allowed all
	
/datum/special_trait/duelist/on_apply(mob/living/carbon/human/character, silent)
	character.cmode_music = 'sound/music/combat_duelist.ogg'
	character.change_stat("speed", 2) //want to make this veteran/knight only
	character.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE) //will replace with a trait after above change
	//if(!character.beltr)	 ((code for me to keep here for now))
	//	character.equip_to_slot_or_del(new /obj/item/rogueweapon/sword/rapier(character), SLOT_BELT_R)
	//else
	//	new /obj/item/rogueweapon/sword/rapier(get_turf(character))

/datum/special_trait/languagesavant
	name = "Polyglot"
	greet_text = span_notice("You have always picked up on languages easily, even those that are forbidden to mortals.")
/datum/special_trait/languagesavant/on_apply(mob/living/carbon/human/character, silent)
	character.grant_language(/datum/language/dwarvish)
	character.grant_language(/datum/language/elvish)
	character.grant_language(/datum/language/hellspeak)
	character.grant_language(/datum/language/celestial)
	character.grant_language(/datum/language/orcish)
	character.grant_language(/datum/language/beast)
	
/datum/special_trait/civilizedbarbarian
	name = "Tavern Brawler"
	greet_text = span_notice("You are skilled at using Improvised Weapons and your fists feel heavier!")
	
/datum/special_trait/civilizedbarbarian/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC) //punches are slightly more deadly. Need to make trait also improve hitting people with chairs, mugs, goblets.	
	
//neutral
/datum/special_trait/trans
	name = "Secret Gender"
	greet_text = span_notice("You never really felt comfortable with your gender.")//I wanna keep this vague, but, also not too vague.
	
/datum/special_trait/trans/on_apply(mob/living/carbon/human/character, silent)
	//So. After alot of deliberation, I've decided this should only change genitals and MAYBE bodytype if it doesn't conflict with clothing too much.
	
/datum/special_trait/backproblems
	name = "Giant Amongst Humen"
	greet_text = span_notice("You've always been called a giant! You are valued for your stature, but, you've found these small doors and rooms quite a curse for your mobility!")
	//maybe I should lock this from short races (verminvolk, dwarves)

/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character)
    character.change_stat("strength", 2)
    character.change_stat("constitution", 1)
    character.change_stat("speed", -2)
	
/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character, silent)
	if(..())
		return
	character.transform = character.transform.Scale(1.15, 1.15)
	character.update_transform()
	
//negative (When adding these, be sure to give incentive for the player to not round end themselves instantly)
/datum/special_trait/hussite
	name = "Known Heretic"
	greet_text = span_notice("You've been denounced by the church for either reasons legitimate or not! A strange sympathetic noble from a nearby mountain manor has given you some coin to aid you in these times.")
	
/datum/special_trait/hussite/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.name
	//note to self, add pile of silver.