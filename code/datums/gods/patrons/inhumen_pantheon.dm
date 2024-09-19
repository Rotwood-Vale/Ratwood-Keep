/datum/patron/inhumen
	name = null
	associated_faith = /datum/faith/inhumen
	undead_hater = FALSE
	confess_lines = list(
		"PSYDON IS THE DEMIURGE!",
		"THE TEN ARE WORTHLESS COWARDS!",
		"THE TEN ARE DECEIVERS!",
	)

/datum/patron/inhumen/zizo
	name = "Zizo"
	domain = "God of Necromancy and Left Hand Magicks"
	desc = "The Dark Elves descended from a race of Elves known only as 'Snow Elves'. These elves are gone now, but there is one among them who lives on in infamy. \
		It was he who taught the early Dark Elves to bend the world to their will. Once a mortal, Zizo undertook the same method that Psydon did and descended into the deepest pits of hell. \
		However, alike Psydon and their Holy Children, the Divine Pantheon of The Ten, in Zizo's efforts to forcefully obtain Godhood he had created new Gods of his own, that being Gragger, Matthios and Baotha. \
		Further consequences of his forceful attempt of Godhood had also cursed the Snow Elves, creating the Dark Elves that were forced to be the first followers of Zizo and his unholy children creating the Inhuman Pantheon. \
		He is the God of Necromancy, and Left-Handed Magicks. Zizo is worshipped by necromancers, warlocks, and the undead. \
		His worshippers proclaim that one day, Zizo will ascend the trillion steps of hell and personally lead the damned and the dead to claim the world for himself. \
		It is said that the very utterance of his name will bring about misfortune. Zizo is depicted as a pale elf, the only piece of clothing on his body being a black cloak which wraps around his lithe form like darkness. \
		On his head is a hood, starting from the eyes and extending up like a steeple."
	worshippers = "Necromancers, Warlocks, and the Undead"
	confess_lines = list(
		"PRAISE ZIZO!",
		"LONG LIVE ZIZO!",
		"ZIZO IS KING!",
	)

/datum/patron/inhumen/graggar
	name = "Graggar"
	domain = "God of Conquest, Murder and Pillaging"
	desc = "Where there is bloodshed, there is Graggar. They say a puddle of blood will call to you, and that when you peer into it you will see the reflection of Graggar, come to coax the worst out of you. \
		Graggar is the God of Conquest, Murder and Pillaging. The Heartless One, The Black Sun, The Destroyer, Man's End, Dark Butcher, God of Unending Bloodshed, these are just a few of the titles he goes by. \
		Graggar taught the early Dark Elves that might makes right, and created Goblins in his own twisted image. Graggar is worshipped by prisoners, murderers and the cruel. \
		He is depicted as a man with spikes coming out of his grinning head, his right eye impaled on one of these spikes which came through the eyesocket, the other eye staring with malice, all above a mouth which never stops grinning. \
		A twisted set of armor covers him, covered in spikes and sporting a curved codpiece, in his hand is a single sword, which much like his own head had spikes covering the blade."
	worshippers = "Prisoners, Murderers and the Cruel"
	mob_traits = list(TRAIT_ORGAN_EATER)
	confess_lines = list(
		"GRAGGAR IS THE BEAST I WORSHIP!",
		"GRAGGAR BRINGS UNHOLY DESTRUCTION!",
		"THE BLACK SUN DEMANDS BLOOD!",
	)

/datum/patron/inhumen/matthios		// Removing 'class warfare' language in favor of 'uncivilized v civilized' language.
	name = "Matthios"
	domain = "God of Fire, Sacrifice and those who prey upon Civilization"
	desc = "The followers of Matthios take from others and give onto themselves. Matthios comes to you in a crowd just like any other man, his hood hiding his face, its with a single whisper that he inspires in you the confidence to take that which you want. \ 
		Matthios is the God of Thievery, Burglary, and Ransoming. He is worshipped by bandits, highwaymen and thieves. Unlike Graggar, to whom killing is the true prize and stealing an afterthought, Matthios is wholly dedicated to stealing. \ 
		If it is something which you can take, through strength, trickery or deception, then it should by rights belong to you. He is depicted as a man with a hood hiding his face, the rest of his body in simple dark clothing."
	worshippers = "Free-Men, Outlaws and Frontiersmen"
	mob_traits = list(TRAIT_COMMIE)
	confess_lines = list(
		"I SACRIFICE GLADLY TO THE GIVER!",
		"MATTHIOS'S GIFT CONSUME YOU!",
		"THE GIVER IS OWED HIS SACRIFICE!",
	)

/datum/patron/inhumen/baotha
    name = "Baotha"
    domain = "Goddess of Degeneracy, Debauchery and Addiction"
    desc = "Hedonism, that is the singular word which best defines Baotha. In more recent history Baotha managed to sink her talons deep into the very core of Dark Elf society, where once they raided for conquest and power, now they raid solely to please themselves. \
		She is the Goddess of Degeneracy, Debauchery, and Addiction. The slaves once brought down to their homes were used as fodder, fighting the creatures which often times attacked their home. Now these slaves are used in gladiatorial bouts and as servants in Dark Elf homes. \
		The Dark Elves have surrendered themselves to this hedonism, their slaves bringing them high shelf bottles of the finest alcohol ever made just so they can use it to wash down the chuckledust they've been snorting all day. \
		It is this same hedonism that Baotha attempts to spread across the world, those who worship her are perverts, gamblers, drunkards and bards. \
		Baotha is depicted as a snake in the form of a woman, and it is said that to stare into her eyes for too long will damn your soul for eternity."
    worshippers = "Perverts, Gamblers, Drunkards, and Bards"
    mob_traits = list(TRAIT_CRACKHEAD)
    confess_lines = list(
        "BAOTHA DEMANDS PLEASURE!",
        "LIVE, LAUGH, LOVE!",
        "BAOTHA IS MY JOY!",
	)


/* RATWOOD EDIT - Back to the main pantheon
/datum/patron/inhumen/eora
	name = "Eora"
	domain = "Goddess of Degeneracy, Debauchery and Addiction"
	desc = "The Fallen Daughter of Psydon, once used to be a goddess of love and family but has now fallen from grace as she leads mortals to hedonism."
	worshippers = "Drunkards, Junkies, Gamblers and Bards"
	confess_lines = list(
		"EORA BRINGS ME PLEASURE!",
		"EORA BRINGS ME LUCK!",
		"EORA IS MY HAPPINESS!",
	)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
*/
