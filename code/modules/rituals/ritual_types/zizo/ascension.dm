// Ascension, these are rituals that move us closer to "godhood"

/datum/ritual/zizo/firststep
	name = "First step towards Ascension"
	circle = "Ascension"
	difficulty = 3
	favor_cost = 300
	center_requirement = /mob/living/carbon/human 
	n_req = /obj/item/natural/voidstone
	s_req = /obj/item/reagent_containers/lux
	function = /proc/firststep

/proc/firststep(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H.mind.get_skill_level(/datum/skill/magic/unholy) < 4)
			H.mind.adjust_skillrank(/datum/skill/magic/unholy, 1, TRUE)
			to_chat(H.mind, span_danger("Zizos power courses through me, taking me one step further along her profane path!"))
		else
			to_chat(H.mind, span_danger("I can not ascend even further with this base ritual.."))
	

/datum/ritual/zizo/ascend
	name = "ASCEND!"
	circle = "Ascension"
	difficulty = 5
	favor_cost = 1000
	center_requirement = /mob/living/carbon/human // cult leader

	n_req = /mob/living/carbon/human // the ruler
	s_req = /mob/living/carbon/human // virgin

	function = /proc/ascend

/proc/ascend(mob/user, turf/C)
	var/datum/game_mode/chaosmode/CM = SSticker.mode

	for(var/mob/living/carbon/human/H in C.contents)
		if(!iszizocultist(H))
			return
		for(var/mob/living/carbon/human/Ruler in get_step(C, NORTH))
			if(Ruler != SSticker.rulermob && Ruler.stat != DEAD)
				break
			Ruler.gib()
		for(var/mob/living/carbon/human/VIRGIN in get_step(C, SOUTH))
			if(!VIRGIN.virginity && VIRGIN.stat != DEAD)
				break
			VIRGIN.gib()
		CM.cultascended = TRUE
		addomen("ascend")
		to_chat(user.mind, span_danger("I HAVE DONE IT! I HAVE REACHED A HIGHER FORM! SOON THERE WILL BE NO GODS. ONLY MASTERS!"))
		var/mob/living/trl = new /mob/living/simple_animal/hostile/retaliate/rogue/blood/ascended(C)
		trl.ckey = H.ckey
		H.gib()
		to_chat(world, "\n<font color='purple'>The fabric of reality begins to weep. Fifteen minutes remain until the end.</font>")
		for(var/mob/living/carbon/human/V in GLOB.human_list)
			if(V.mind in CM.cultists)
				V.add_stress(/datum/stressevent/lovezizo)
			else
				V.add_stress(/datum/stressevent/hatezizo)
		CM.roundvoteend = TRUE
		break
