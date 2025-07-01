/datum/round_aspect/magic_town
	name = "Magic Town"
	description = "All characters know a little magic and have the Arcane skill."
	start_or_apply_text = "Nowhere is better than us when it comes to the arcyne!"
	weight = 25
	var/const/spells_per_person = 2
	var/const/max_spell_level = 2
	var/list/valid_spells = list(
		// Exclude the 13-cost spells and Prestidigitation
		SPELL_FIREBALL,				// 3 cost	combat, damaging AOE + damages worn/held things
		SPELL_LIGHTNINGBOLT,		// 3 cost	combat, single target damage, knockdown
		SPELL_SPITFIRE,				// 3 cost	combat, burstfire single target damage
		SPELL_ARCANEBOLT,			// 3 cost	combat, single target single shot damage
		SPELL_FROSTBOLT,			// 3 cost	combat, single target, single shot lesser damage w/ slow
		SPELL_LIGHTNINGLURE,		// 3 cost	combat, ranged single target hard stun w/ time requirement.
		SPELL_SLOWDOWN_SPELL_AOE,	// 3 cost	utility hold spell. Target unable to move, but can fight.
		SPELL_FINDFAMILIAR,			// 3 cost	combat, summon spell.
		SPELL_PUSH_SPELL,			// 3 cost	localized AOE knockback spell. Knocksdown/disarms victims
		SPELL_ARCYNE_STORM,			// 2 cost	combat, light damaging AOE, stall/area denial spell
		SPELL_DARKVISION,			// 2 cost	utility, dark sight
		SPELL_HASTE,				// 2 cost	utility/combatbuff, faster mve speed.
		SPELL_ENLARGE,				// 2 cost 	utility/combatbuff, less spd more str and con
		SPELL_SUMMON_WEAPON,		// 2 cost	utility/combat, summons a marked weapon to caster.
		SPELL_MENDING,				// 2 cost	utility, repairs items
		SPELL_MESSAGE,				// 2 cost	utility, messages anyone you know the name of.
		SPELL_BLADE_BURST,			// 2 cost	combat, single target damage localized on rndm leg. possible bone break.
		SPELL_FETCH,				// 2 cost	utility/combat, pulls single target closer
		SPELL_REPEL,				// 2 cost	utility/combat, flings single target away
		SPELL_FORCEWALL_WEAK,		// 2 cost	utility/combat, places walls caster can walk through. stall spell.
		SPELL_NONDETECTION,			// 1 cost	utility, no scrying your location.
		SPELL_FEATHERFALL,			// 1 cost	utility, no fall damage from 1 zlevel drop
	)

/datum/round_aspect/magic_town/on_job_finalised(mob/living/carbon/human/H)
	give_spells(H)

/datum/round_aspect/magic_town/proc/give_spells(mob/living/carbon/human/victim)
	var/already_had_magic = FALSE
	if (victim.get_skill_level(/datum/skill/magic/arcane) > 0)
		already_had_magic = TRUE
	victim.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)

	if (already_had_magic || !victim.mind)
		return

	victim.mind.AddSpell(new SPELL_PRESTIDIGITATION)
	var/list/choices = valid_spells.Copy()
	for(var/i in 1 to spells_per_person)
		var/path = pick_n_take(choices)
		victim.mind.AddSpell(new path)
