/mob/AddSpell(obj/effect/proc_holder/spell/S)
	if(!S)
		return
	if(has_spell(S))
		return
	. = ..()

/mob/proc/has_spell(spell_type, specific = FALSE)
	if(istype(spell_type, /obj/effect/proc_holder))
		var/obj/instanced_spell = spell_type
		spell_type = instanced_spell.type
	for(var/obj/effect/proc_holder/spell as anything in mob_spell_list)
		if((specific && spell.type == spell_type) || istype(spell, spell_type))
			return TRUE
	return FALSE
