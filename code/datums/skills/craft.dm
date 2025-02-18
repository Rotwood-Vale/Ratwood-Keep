/datum/skill/craft
	abstract_type = /datum/skill/craft
	name = "Craft"
	desc = ""

/datum/skill/craft/crafting
	name = "Crafting"
	desc = ""
	dreams = list(
		"...you feel grass under you feet as you peer onto a meadow, you prepare a campfire and a tent and drift off into deeper slumber.."
	)

/datum/skill/craft/blacksmithing
	name = "Blacksmithing"

/datum/skill/craft/carpentry
	name = "Carpentry"

/datum/skill/craft/masonry
	name = "Masonry"

/datum/skill/craft/cooking
	name = "Cooking"

/datum/skill/craft/engineering
	name = "Engineering"

/datum/skill/craft/hunting
	name = "Hunting"
	desc = ""
	dreams = list(
		"...you feel the forest's embrace as you drift into dreams, visions of stalking prey and the thrill of the hunt filling your mind.."
	)
	
/datum/skill/craft/alchemy
	name = "Alchemy"
	dreams = list(
		"...the smell of sulfur singes your nostrils... you taste iron... the smoke clears as you stare down at the reflection in your cauldron... the Queen stares back at you... she looks like she's crying..."
	)

/datum/skill/craft/alchemy/skill_level_effect(level, datum/mind/mind)
	if(level > SKILL_LEVEL_MASTER)
		ADD_TRAIT(mind?.current, TRAIT_LEGENDARY_ALCHEMIST, type)
		//SEND_GLOBAL_SIGNAL(COMSIG_ATOM_ADD_TRAIT, (mind?.current, TRAIT_LEGENDARY_ALCHEMIST)
	else if(HAS_TRAIT(mind?.current, TRAIT_LEGENDARY_ALCHEMIST))
		REMOVE_TRAIT(mind?.current, TRAIT_LEGENDARY_ALCHEMIST, type)
		//SEND_GLOBAL_SIGNAL(COMSIG_ATOM_ADD_TRAIT, (mind?.current, TRAIT_LEGENDARY_ALCHEMIST)
