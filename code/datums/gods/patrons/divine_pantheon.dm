/datum/patron/divine
	name = null
	associated_faith = /datum/faith/divine
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/divine/astrata
	name = "Astrata"
	domain = "Goddess of the Sun, Day, and Order"
	desc = "The Firstborn of Psydon, twin of Noc, gifted man the Sun as her divine gift."
	worshippers = "The Noble Hearted, Zealots and Farmers"
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/revive

/datum/patron/divine/noc
	name = "Noc"
	domain = "God of the Moon, Night, and Knowledge"
	desc = "The Firstborn of Psydon, twin of Astrata, gifted man divine knowledge."
	worshippers = "Wizards and Scholars"
	t1 = /obj/effect/proc_holder/spell/invoked/blindness
	t2 = /obj/effect/proc_holder/spell/invoked/invisibility

/datum/patron/divine/dendor
	name = "Dendor"
	domain = "God of the Earth and Nature"
	desc = "The Primordial Son of Psydon, patron of beasts and the wood. Gone mad with time."
	worshippers = "Druids, Beasts, Madmen"
	mob_traits = list(TRAIT_KNEESTINGER_IMMUNITY)
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/targeted/beasttame
	t3 = /obj/effect/proc_holder/spell/targeted/conjure_glowshroom

/datum/patron/divine/abyssor
	name = "Abyssor"
	domain = "God of the Ocean, Storms and the Tide"
	desc = "The Beloved Son, gifted primordial men food and water."
	worshippers = "Men of the Sea, Primitive Aquatics"

/datum/patron/divine/ravox
	name = "Ravox"
	domain = "God of War, Justice and Strength"
	desc = "The strongest of Psydon's children, he watches man from afar."
	worshippers = "Warriors, Sellswords & those who seek Justice"

/datum/patron/divine/necra
	name = "Necra"
	domain = "Goddess of Death and the Afterlife"
	desc = "The Veiled Lady, a feared but respected God who leads the dead."
	worshippers = "The Dead, Gravekeepers"
	mob_traits = list(TRAIT_SOUL_EXAMINE)
	t1 = /obj/effect/proc_holder/spell/targeted/burialrite
	t2 = /obj/effect/proc_holder/spell/targeted/churn
	t3 = /obj/effect/proc_holder/spell/targeted/soulspeak

/datum/patron/divine/xylix
	name = "Xylix"
	domain = "God of Trickery, Freedom and Inspiration"
	desc = "The Mad-God, gifted man wanderlust and a thousand tricks."
	worshippers = "Cheats, Frauds, Silver-Tongued devils and Roguish Types"

/datum/patron/divine/pestra
	name = "Pestra"
	domain = "Goddess of Decay, Disease and Medicine"
	desc = "The Loving Daughter of Psydon, gifted man medicine."
	worshippers = "The Sick, Phyicians, Apothecaries"
	mob_traits = list(TRAIT_ROT_EATER)
	t1 = /obj/effect/proc_holder/spell/invoked/attach_bodypart
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/cure_rot

/datum/patron/divine/malum
	name = "Malum"
	domain = "God of Fire, Destruction and Rebirth"
	desc = "The Opinionless God, his children hold no malice in their actions."
	worshippers = "Smiths, Miners, Artists"
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
