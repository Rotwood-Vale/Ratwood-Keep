// Currently calls maniac hallucinations/datum/curse/graggar
	name = "Graggar's Curse"
	description = "I am engulfed by unspeakable rage. I cannot stop myself from harming others. When that's not an option, my rage is directed inward."
	trait = TRAIT_GRAGGAR_CURSE

/datum/curse/graggar/on_life(mob/living/carbon/human/owner)
	. = ..()
	if(owner.mob_timers["graggar_curse"])
		if(world.time < owner.mob_timers["graggar_curse"] + rand(15,60)SECONDS)
			return
	owner.mob_timers["graggar_curse"] = world.time

	for(var/mob/living/carbon/human in view(1, owner))
		owner.emote("rage")
		human.attacked_by(owner.get_active_held_item(), owner)
		owner.cursed_freak_out()
		break


