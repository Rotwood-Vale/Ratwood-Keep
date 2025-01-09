// FLESH CRAFTING

/datum/ritual/zizo/fleshmend
	name = "Fleshmend"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human
	n_req =  /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/fleshmend

/proc/fleshmend(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		H.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
		H.fully_heal(admin_revive = TRUE)
		to_chat(H.mind, span_notice("ZIZO EMPOWERS ME!"))
		break

/datum/ritual/zizo/bunnylegs
	name = "Saliendo Pedes"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/bodypart/l_leg
	e_req = /obj/item/bodypart/r_leg
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/bunnylegs

/proc/bunnylegs(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		ADD_TRAIT(H, TRAIT_ZJUMP, TRAIT_GENERIC)
		to_chat(H.mind, span_notice("I feel like my legs have become stronger."))
		break

/datum/ritual/zizo/darkeyes
	name = "Darkened Eyes"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/organ/eyes
	e_req = /obj/item/organ/eyes
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/darkeyes

/proc/darkeyes(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		to_chat(H.mind, span_notice("I no longer fear the dark."))
		break

/datum/ritual/zizo/nopain
	name = "Painless Battle"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/organ/heart
	e_req = /obj/item/organ/brain
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/nopain

/proc/nopain(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		ADD_TRAIT(user, TRAIT_NOPAIN, TRAIT_GENERIC)
		to_chat(H.mind, span_notice("I no longer feel pain, but it has come at a terrible cost."))
		H.change_stat("strength", -2)
		H.change_stat("constitution", -2)
		if(H.gender == FEMALE)
			H.change_stat("constitution", -1)
		else
			ADD_TRAIT(user, TRAIT_LIMPDICK, TRAIT_GENERIC)
		break

/datum/ritual/zizo/fleshform
	name = "Stronger Form"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/bodypart/l_arm
	e_req = /obj/item/bodypart/r_arm
	n_req = /obj/item/organ/eyes
	s_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/fleshform

/proc/fleshform(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(iszizocultist(H))
			to_chat(user.mind, span_danger("\"I'm not letting my strongest follower become a mindless brute.\""))
			return
		to_chat(H.mind, span_danger("SOON I WILL BECOME A HIGHER FORM!!!"))
		sleep(5 SECONDS)
		var/mob/living/trl = new /mob/living/simple_animal/hostile/retaliate/rogue/blood(H)
		trl.forceMove(H)
		trl.ckey = H.ckey
		H.gib()

/datum/ritual/zizo/gutted
	name = "Gutted Fish"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human // One to be gutted.human

	function = /proc/guttedlikeafish

/proc/guttedlikeafish(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H.stat == DEAD)
			H.take_overall_damage(500)
			C.visible_message(span_danger("[H.real_name] is lifted up into the air and multiple scratches, incisions and deep cuts start etching themselves into their skin as all of their internal organs spill on the floor below!"))

			var/atom/drop_location = H.drop_location()
			for(var/obj/item/organ/organ as anything in H.internal_organs)
				organ.Remove(H)
				organ.forceMove(drop_location)
			var/obj/item/bodypart/chest/cavity = H.get_bodypart(BODY_ZONE_CHEST)
			if(cavity.cavity_item)
				cavity.cavity_item.forceMove(drop_location)
				cavity.cavity_item = null

/datum/ritual/zizo/ascend
	name = "ASCEND!"
	circle = "Fleshcrafting"
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
