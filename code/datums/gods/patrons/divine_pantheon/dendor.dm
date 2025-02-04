/datum/patron/divine/dendor
	name = "Dendor"
	domain = "God of the Earth and Nature"
	desc = "The Primordial Son of Psydon, patron of beasts and the wood. Gone mad with time."
	worshippers = "Druids, Beasts, Madmen"
	mob_traits = list(TRAIT_VINE_WALKER, TRAIT_KNEESTINGER_IMMUNITY, TRAIT_WILD_EATER)
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/targeted/beasttame
	t3 = /obj/effect/proc_holder/spell/targeted/conjure_vines
	confess_lines = list(
		"DENDOR PROVIDES!",
		"THE TREEFATHER BRINGS BOUNTY!",
		"I ANSWER THE CALL OF THE WILD!",
	)

