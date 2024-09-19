/datum/patron/divine
	name = null
	associated_faith = /datum/faith/divine
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/divine/astrata
	name = "Astrata"
	domain = "Goddess of the Sun, Day, and Order"
	desc = "Astrata, the Firstborn of Psydon. She is the goddess of the Sun, the Day and of Order. She is Twin to Noc, Goddess of the Moon. \
		She is worshipped by noble hearted men, as well as zealous fanatics and farmers. She is said to have gifted man the sun, the source of all life, without it crops would wither and man would freeze to death. \
		Astrata is depicted as a women with golden skin, two large wings on her back, one hand holding up the sun itself, the other holding up a sword." 
	worshippers = "The Noble Hearted, Zealots and Farmers"
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/revive
	confess_lines = list(
		"ASTRATA IS MY LIGHT!",
		"ASTRATA BRINGS LAW!",
		"I SERVE THE GLORY OF THE SUN!",
	)

/datum/patron/divine/noc
	name = "Noc"
	domain = "Goddess of the Moon, Night, and Knowledge"
	desc = "Noc, the Firstborn of Psydon. She is the goddess of the Moon, Night and of Knowledge. She is Twin to Astrata, Goddess of the Sun. \
		She is worshipped by Wizards and Scholars, and is said to have gifted man both knowledge, and an insight into the magic that permeates all reality. \
		Noc worshippers argue with Astratans over which of the two is more powerful, for they claim it is Noc herself that can block out the sun even during the day. \
		Noc is depicted as a woman with silver skin, a blindfold around her eyes, a third eye open on her forehead, and a large book in both hands."
	worshippers = "Wizards and Scholars"
	mob_traits = list(TRAIT_NOCSIGHT)
	t1 = /obj/effect/proc_holder/spell/invoked/blindness
	t2 = /obj/effect/proc_holder/spell/invoked/invisibility
	confess_lines = list(
		"NOC IS NIGHT!",
		"NOC SEES ALL!",
		"I SEEK THE MYSTERIES OF THE MOON!",
	)

/datum/patron/divine/dendor
	name = "Dendor"
	domain = "God of the Earth and Nature"
	desc = "Dendor, the Primordial Son of Psydon. He is the God of the Earth and Nature. The patron of beasts, and of the woods, those that follow him are druids, beasts, and madmen. \
		Dendor was once a proud son of Psydon, but millenia in the forest drove him mad. Less man than beast, as they are depicted with the body of a centaur, long, wiry hair hides his face, two antlers protruding from either side of his head. \
		It is believed by some Dendorites that when Dendor blows his horn, the Wild Hunt will finally begin, and Dendor himself will lead them to the stars to hunt the watchers that bother him so. \
		For Man, Dendor represents nature and its generosity. For Wild-Kin, Dendor represents their greatest fear, that perhaps one day they will awake and realize that they truly are just animals on two feet."
	worshippers = "Druids, Beasts, Madmen"
	mob_traits = list(TRAIT_KNEESTINGER_IMMUNITY)
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/targeted/beasttame
	t3 = /obj/effect/proc_holder/spell/targeted/conjure_glowshroom
	t4 = /obj/effect/proc_holder/spell/invoked/cure_rot
	confess_lines = list(
		"DENDOR PROVIDES!",
		"THE TREEFATHER BRINGS BOUNTY!",
		"I ANSWER THE CALL OF THE WILD!",
	)

/datum/patron/divine/abyssor
	name = "Abyssor"
	domain = "God of the Ocean, Storms and the Tide"
	desc = "Abyssor, the Beloved son of Psydon. He is the God of the Ocean, Storms, and Tide. Abyssor is worshipped by men who make a living at sea and aquatic races. \
		Abyssor, beloved of Psydon, believed that his title alone as most loved of Psydon's children that he had the right to rule the world alone. \
		With all his might he attempted to drown Grimoria under the ocean, but his siblings stopped him. Shackled in the deepest, darkest depths of the ocean, Abyssor slumbers. \
		It is said when he moves in his sleep that the act of doing so is what creates storms, and that tidal waves are formed when he rolls over in his sleep. \
		Those who worship Abyssor sometimes debate among themselves what would happen if ever their God was to awaken, if he could truly drown the world, dragging everything into the abyss that is his tomb. \
		Abyssor is depicted as a large creature, more maw than man, it is as though Abyssor is a mouth given arms, and if ever he opened his mouth to its fullest he could devour the world itself."
	worshippers = "Men of the Sea, Primitive Aquatics"
	mob_traits = list(TRAIT_ABYSSOR_SWIM, TRAIT_WATERBREATHING)
	confess_lines = list(
		"ABYSSOR COMMANDS THE WAVES!",
		"THE OCEAN'S FURY IS ABYSSOR'S WILL!",
		"I AM DRAWN BY THE PULL OF THE TIDE!",
	)

/datum/patron/divine/ravox
	name = "Ravox"
	domain = "God of War, Justice and Strength"
	desc = "Ravox, the Strongest of Psydon's Children. He is the God of War, Justice and Strength. Ravox is worshipped by warriors, sellswords, and those who seek out justice. \
		Ravox is the god of soldiers across the world, with many uttering a prayer and litanies to him moments before charging headfirst into carnage. \
		A humble God, it is said that Ravox, although the strongest of Psydon's children, does not gloat about this fact, and merely lets his swordsmanship speak for him. \
		Ravox is depicted as a man with the head of a bull, wearing nothing on his body and wielding a sword."
	worshippers = "Warriors, Sellswords & those who seek Justice"
	confess_lines = list(
		"RAVOX IS JUSTICE!",
		"THROUGH STRIFE, GRACE!",
		"THE DRUMS OF WAR BEAT IN MY CHEST!",
	)

/datum/patron/divine/necra
	name = "Necra"
	domain = "Goddess of Death and the Afterlife"
	desc = "Necra, the Veiled Lady. She is the Goddess of Death and the Afterlife. She is worshipped by the dead, mourners, and gravekeepers. \
		When a man dies, his soul travels down to meet none other than the Carriageman, considered a saint by some Necrans. \
		He is an assistant to Necra, and separates those souls who are ready to move on from those who are not. \
		Access to the carriage which brings the dead on to the afterlife is not allowed until the deceased can present to the Carriageman a coin. \
		This coin represents a single deed the deceased has committed to allow them to pass on. Once the toll is paid, the carriage door is open, and the deceased meet with Necra herself to be put to rest. \
		Necra is depicted as a woman cloaked in darkness, a shadowy veil covering her flesh."
	worshippers = "The Dead, Mourners, Gravekeepers"
	mob_traits = list(TRAIT_SOUL_EXAMINE)
	t1 = /obj/effect/proc_holder/spell/targeted/burialrite
	t2 = /obj/effect/proc_holder/spell/targeted/churn
	t3 = /obj/effect/proc_holder/spell/targeted/soulspeak
	confess_lines = list(
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"THE UNDERMAIDEN IS OUR FINAL REPOSE!",
		"I FEAR NOT DEATH, MY LADY AWAITS ME!",
	)

/datum/patron/divine/xylix
	name = "Xylix"
	domain = "God of Trickery, Freedom and Inspiration"
	desc = "Xylix, the Mad-God. He is the God of Trickery, Freedom and Inspiration. He is worshipped by cheats, fraudsters, silver-tongued devils and roguish types. An outcast among his kin, Xylix had done plenty to earn their anger. \
		It was he who once attempted to wake Abyssor with a feather, it was he who cooked one of Dendor's most favored animal companions into a meal for the God, something a few suspect to be the reason for his own madness. \
		Xylix is neither wholly good nor wholly evil, he represents the purity of freedom, to do whatever one wants, even at the expense of others. \
		Xylix is depicted as a man with two faces, both with different expressions, both of his hands at his sides, thumbs touching his index fingers. \
		A third arm can be seen behind him with its fingers crossed. "
	worshippers = "Cheats, Frauds, Silver-Tongued devils and Roguish Types"
	t1 = /obj/effect/proc_holder/spell/invoked/Joy_takes_flight
	t2 = /obj/effect/proc_holder/spell/invoked/Laughing_god
	t3 = /obj/effect/proc_holder/spell/invoked/Smokebomb
	confess_lines = list(
		"ASTRATA IS MY LIGHT!",
		"NOC IS NIGHT!",
		"DENDOR PROVIDES!",
		"ABYSSOR COMMANDS THE WAVES!",
		"RAVOX IS JUSTICE!",
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"HAHAHAHA! AHAHAHA! HAHAHAHA!",
		"PESTRA SOOTHES ALL ILLS!",
		"MALUM IS MY MUSE!",
		"EORA BRINGS US TOGETHER!",
	)

/datum/patron/divine/pestra
	name = "Pestra"
	domain = "Goddess of Decay, Disease and Medicine"
	desc = "Pestra, the Loving daughter of Psydon whom gifted man medicine. She is the Goddess of Decay, Disease and Medicine. \
		She is worshipped by the sick, physicians and apothecaries. It is said that Pestra was born sickly and disfigured, one of the weakest among her kin. \
		It was when she too saw man suffering as she did that she gifted him medicine to soothe his ills. She is venerated above all others by the ill and those who cure them. \
		Pestra is depicted as a woman with a walking cane, the left side of her face rotten and diseased while the right side of her face is clear and smiling. On her is a long set of robes with her sigil on its front."
	worshippers = "The Sick, Phyicians, Apothecaries"
	mob_traits = list(TRAIT_EMPATH, TRAIT_ROT_EATER)
	t1 = /obj/effect/proc_holder/spell/invoked/heal
	t2 = /obj/effect/proc_holder/spell/invoked/attach_bodypart
	t3 = /obj/effect/proc_holder/spell/invoked/cure_rot
	confess_lines = list(
		"PESTRA SOOTHES ALL ILLS!",
		"DECAY IS A CONTINUATION OF LIFE!",
		"MY AFFLICTION IS MY TESTAMENT!",
	)

/datum/patron/divine/malum
	name = "Malum"
	domain = "God of Fire, Destruction and Rebirth"
	desc = "The Opinionless God, who's children hold no malice in their actions. He is the God of Fire, Destruction and Rebirth. \
		He is worshipped by smiths, miners and artists. Malum is said to live in the very center of the world, where the heat is so great that any mortal man would be burned to ash in seconds. \
		There, Malum slowly crafts a sword, each strike of his hammer causing the world itself to shake. \
		Placed there by Psydon, the shackles around Malum's ankles are long broken, and he does nothing but do what he was told to by his father, craft the sword, and deliver it to Psydon. \
		Malum is depicted as a hunchbacked man, shackles around his ankles, wearing singed rags and sporting a large beard and long, unkempt hair. In his right hand is a hammer, in the left hand a chisel."
	worshippers = "Smiths, Miners, Artists"
	mob_traits = list(TRAIT_MALUMSGRACE)
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	confess_lines = list(
		"MALUM IS MY MUSE!",
		"TRUE VALUE IS IN THE TOIL!",
		"I AM AN INSTRUMENT OF CREATION!",
	)

//Eora content from Stonekeep

/datum/patron/divine/eora
	name = "Eora"
	domain = "Saint of the Love, Life and Beauty"
	desc = "The Goddess of Blind Love for All, Without a Shred of Hate in her Heart. Eora is the Goddess of Love, Life, and Beauty. \
		She is worshipped by lovers, harlots and doting grandparents. Eora is the kindest of all of Psydon's children, who loves all things unconditionally. \
		It is said that the beauty of the world is her doing, and that Eora personally ensures the right two people fall in love. \
		She is depicted as a woman in a dress with long brown hair, a constant smile on her lips and a flower in her hands."
	worshippers = "Lovers, Harlots, Doting Grandparents"
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/invoked/bud
	t2 = /obj/effect/proc_holder/spell/invoked/eoracurse
	t3 = /obj/effect/proc_holder/spell/invoked/enrapture
	confess_lines = list(
		"EORA BRINGS US TOGETHER!",
		"HER BEAUTY IS EVEN IN THIS TORMENT!",
		"I LOVE YOU, EVEN AS YOU TRESPASS AGAINST ME!",
	)
