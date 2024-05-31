/datum/stressevent/vice
	timer = 5 MINUTES
	stressadd = 3
	desc = list("<span class='red'>I don't indulge my vice.</span>","<span class='red'>I need to sate my vice.</span>")

/*
/datum/stressevent/failcraft
	timer = 15 SECONDS
	stressadd = 1
	max_stacks = 10
	desc = "<span class='red'>I've failed to craft something.</span>"
*/

/datum/stressevent/miasmagas
	timer = 10 SECONDS
	stressadd = 1
	desc = "<span class='red'>Smells like death here.</span>"

/datum/stressevent/peckish
	timer = 10 MINUTES
	stressadd = 1
	desc = "<span class='red'>I'm peckish.</span>"

/datum/stressevent/hungry
	timer = 10 MINUTES
	stressadd = 2
	desc = "<span class='red'>I'm hungry.</span>"

/datum/stressevent/starving
	timer = 10 MINUTES
	stressadd = 3
	desc = "<span class='red'>I'm starving.</span>"

/datum/stressevent/drym
	timer = 10 MINUTES
	stressadd = 1
	desc = "<span class='red'>I'm a little thirsty.</span>"

/datum/stressevent/thirst
	timer = 10 MINUTES
	stressadd = 2
	desc = "<span class='red'>I'm thirsty.</span>"

/datum/stressevent/parched
	timer = 10 MINUTES
	stressadd = 3
	desc = "<span class='red'>I'm going to die of thirst.</span>"

/datum/stressevent/dismembered
	timer = 40 MINUTES
	stressadd = 5
	//desc = "<span class='red'>I've lost a limb.</span>"
	desc = null

/datum/stressevent/dwarfshaved
	timer = 40 MINUTES
	stressadd = 6
	desc = "<span class='red'>I'd rather cut my own throat than my beard.</span>"

/datum/stressevent/viewdeath
	timer = 1 MINUTES
	stressadd = 1
//	desc = "<span class='red'>Death...</span>"

/datum/stressevent/viewdeath/get_desc(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.dna?.species)
			return "<span class='red'>Another [H.dna.species.id] perished.</span>"
	return desc

/datum/stressevent/viewdismember
	timer = 20 MINUTES
	max_stacks = 10
	stressadd = 2
//	desc = "<span class='red'>Butchery.</span>"


/datum/stressevent/fviewdismember
	timer = 1 MINUTES
	max_stacks = 10
	stressadd = 1
//	desc = "<span class='red'>I saw something horrible!</span>"

/datum/stressevent/viewgib
	timer = 5 MINUTES
	stressadd = 2
//	desc = "<span class='red'>I saw something ghastly.</span>"

/datum/stressevent/bleeding
	timer = 2 MINUTES
	stressadd = 1
	desc = list("<span class='red'>I think I'm bleeding.</span>","<span class='red'>I'm bleeding.</span>")

/datum/stressevent/painmax
	timer = 1 MINUTES
	stressadd = 2
	desc = "<span class='red'>THE PAIN!</span>"

/datum/stressevent/freakout
	timer = 15 SECONDS
	stressadd = 2
	desc = "<span class='red'>I'm panicking!</span>"

/datum/stressevent/felldown
	timer = 1 MINUTES
	stressadd = 1
//	desc = "<span class='red'>I fell. I'm a fool.</span>"

/datum/stressevent/burntmeal
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>YUCK!</span>"

/datum/stressevent/rotfood
	timer = 2 MINUTES
	stressadd = 4
	desc = "<span class='red'>YUCK!</span>"

/datum/stressevent/psycurse
	timer = 5 MINUTES
	stressadd = 5
	desc = "<span class='red'>Oh no! I've received divine punishment!</span>"

/datum/stressevent/virginchurch
	timer = 999 MINUTES
	stressadd = 10
	desc = "<span class='red'>I have broken my oath of chastity to The Gods!</span>"

/datum/stressevent/badmeal
	timer = 3 MINUTES
	stressadd = 2
	desc = "<span class='red'>It tastes VILE!</span>"

/datum/stressevent/vomit
	timer = 3 MINUTES
	stressadd = 2
	max_stacks = 3
	desc = "<span class='red'>I puked!</span>"

/datum/stressevent/vomitself
	timer = 3 MINUTES
	stressadd = 2
	max_stacks = 3
	desc = "<span class='red'>I puked on myself!</span>"

/datum/stressevent/cumbad
	timer = 5 MINUTES
	stressadd = 5
	desc = "<span class='red'>I was violated.</span>"

/datum/stressevent/cumcorpse
	timer = 1 MINUTES
	stressadd = 20
	desc = "<span class='red'>What have I done?</span>"

/datum/stressevent/blueb
	timer = 1 MINUTES
	stressadd = 2
	desc = "<span class='red'>My loins ache!</span>"

/datum/stressevent/delf
	timer = 1 MINUTES
	stressadd = 1
	desc = "<span class='red'>A loathesome dark elf.</span>"

/datum/stressevent/tieb
	timer = 1 MINUTES
	stressadd = 1
	desc = "<span class='red'>Helldweller... better stay away.</span>"

/datum/stressevent/brazillian
	timer = 1 MINUTES
	stressadd = 1
	desc = "<span class='red'>A vile lizard.</span>"

/datum/stressevent/paracrowd
	timer = 15 SECONDS
	stressadd = 2
	desc = "<span class='red'>There are too many people who don't look like me here.</span>"

/datum/stressevent/parablood
	timer = 15 SECONDS
	stressadd = 3
	desc = "<span class='red'>There is so much blood here.. it's like a battlefield!</span>"

/datum/stressevent/parastr
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>That beast is stronger.. and might easily kill me!</span>"

/datum/stressevent/paratalk
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>They are plotting against me in evil tongues..</span>"

/datum/stressevent/coldhead
	timer = 60 SECONDS
	stressadd = 1
//	desc = "<span class='red'>My head is cold and ugly.</span>"

/datum/stressevent/sleeptime
	timer = 0
	stressadd = 1
	desc = "<span class='red'>I'm tired.</span>"

/datum/stressevent/trainsleep
	timer = 0
	stressadd = 1
	desc = "<span class='red'>My muscles ache.</span>"

/datum/stressevent/tortured
	stressadd = 3
	max_stacks = 5
	desc = "<span class='red'>I'm broken.</span>"
	timer = 60 SECONDS

/datum/stressevent/confessed
	stressadd = 3
	desc = "<span class='red'>I've confessed to sin.</span>"
	timer = 15 MINUTES

/datum/stressevent/confessedgood
	stressadd = 1
	desc = "<span class='red'>I've confessed to sin, it feels good.</span>"
	timer = 15 MINUTES

/datum/stressevent/saw_wonder
	stressadd = 4
	desc = "<span class='dead'><B>I have seen something nightmarish, and I fear for my life!</B></span>"
	timer = null

/datum/stressevent/maniac_woke_up
	stressadd = 10
	desc = "<span class='danger'>No... I want to go back...</span>"

/datum/stressevent/drankrat
	stressadd = 1
	desc = "<span class='red'>I drank from a lesser creature.</span>"
	timer = 1 MINUTES

/datum/stressevent/lowvampire
	stressadd = 1
	desc = "<span class='red'>I'm dead... what comes next?</span>"

/datum/stressevent/oziumoff
	stressadd = 20
	desc = "<span class='blue'>I need another hit.</span>"
	timer = 1 MINUTES

/datum/stressevent/ooc_ic
	stressadd = 6
	desc = "<span class='red'>Bad omen! I've broken some kind of wall...</span>"
	timer = 5 MINUTES
