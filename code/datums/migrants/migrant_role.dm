/datum/migrant_role
	abstract_type = /datum/migrant_role
	/// Name of the role
	var/name = "MIGRANT ROLE"
	/// Restricts species if the list is not null
	var/list/allowed_species
	/// Restricts sexes if list is not null
	var/list/allowed_sexes
	/// Restricts ages if list is not null
	var/list/allowed_ages
	/// Typepath of outfit for the migrant role
	var/outfit
	/// Typepath of the antag datum for the migrant role
	var/antag_datum
	/// If defined they'll get adv class rolls
	var/list/advclass_cat_rolls
	/// Text to greet player of this role in the wave
	var/greet_text

/datum/migrant_role/proc/after_spawn(mob/living/carbon/human/character)
	return

/datum/migrant_role/test
	name = "Tester"
	greet_text = "You are the tester. Don't break anything"
	outfit = /datum/outfit/job/roguetown/mercenary/desert_rider
	antag_datum = /datum/antagonist/bandit

/datum/migrant_role/test/after_spawn(mob/living/carbon/human/character)
	to_chat(character, span_notice("Epic"))

/datum/migrant_role/pilgrim
	name = "Pilgrim"
	advclass_cat_rolls = list(CTAG_PILGRIM = 10)

/datum/migrant_role/adventurer
	name = "Adventurer"
	advclass_cat_rolls = list(CTAG_ADVENTURER = 5)

/datum/migrant_role/bandit
	name = "Bandit"
	antag_datum = /datum/antagonist/bandit

/datum/migrant_role/bandit/after_spawn(mob/living/carbon/human/character)
	grant_lit_torch(character)

/datum/migrant_role/heartfelt_lord
	name = "Lord of Heartfelt"
	outfit = /datum/outfit/job/roguetown/adventurer/heartfeltlord
	greet_text = "You are Lord of the ailing, neighbouring barony of Heartfelt. On the advice of your Magos, you set out for Rockhill in hopes of restoring your lands to their glory. Your retinue hopes to find assistance here... Or perhaps a new throne."
	allowed_sexes = list(MALE)

/datum/migrant_role/heartfelt_lady
	name = "Lady of Heartfelt"
	outfit = /datum/outfit/job/roguetown/adventurer/heartfeltlord
	greet_text = "You are the Lady of Heartfelt, once a respected noblewoman, now reduced to begging for scraps in this boggy hellscape. Your home lies in tatters, but perhaps you can find a new place in Rockhill?"
	allowed_sexes = list(FEMALE)

/datum/migrant_role/heartfelt_hand
	name = "Hand of Heartfelt"
	outfit = /datum/outfit/job/roguetown/adventurer/heartfelthand
	greet_text = "You are the Hand of Heartfelt. Some would say that you failed in your duties in allowing your Lord's domain to falter. Even if the others doubt you, you're loyal to a fault."

/datum/migrant_role/heartfelt_knight
	name = "Knight of Heartfelt"
	outfit = /datum/outfit/job/roguetown/adventurer/heartfeltlord
	greet_text = "You are a Knight of Heartfelt. You had a brother in arms once, but now you fight alone in service to your lord. Your destination is Rockhill. Ensure those left of the court arrives in one piece."

/datum/migrant_role/heartfelt_magos
	name = "Magos of Heartfelt"
	outfit = /datum/outfit/job/roguetown/adventurer/heartfeltlord
	greet_text = "You are supposedly a great Magos, called to Heartfelt for your knowledge of the arcane arts. You didn't see the fate that would befall your home in the tapestry of night, yet one bright star calls you to Rockhill."

/datum/migrant_role/heartfelt_prior
	name = "Prior of Heartfelt"
	outfit = /datum/outfit/job/roguetown/adventurer/heartfeltlord
	greet_text = "Your ascension through the ranks of the Church came too late for Heartfelt, arranged for a few daes after the barony fell. You'll do what you can, with the blessings you can muster. Astrata guides you still!"
