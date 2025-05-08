// Sacrifice

	/* //Use to notifiy
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		to_chat(HL.mind, "<span class='notice'>A dark ritual has been completed...</span>")
	*/



/datum/ritual/zizo/lesserwildsacrifice
	name = "Lesser wild Sacrifice"
	circle = "Sacrifice"
	center_requirement = /obj/item/reagent_containers/food/snacks/rogue/meat
	difficulty = 1
	favor_cost = 0

	function = /proc/lesserwildsacrifice


/proc/lesserwildsacrifice(mob/user, turf/C)
	user.mind.zizofavor += 10;
	user.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	to_chat(user.mind, span_notice("Lady Zizo accepts my meagre gift!"))
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		to_chat(HL.mind, "<span class='notice'>A dark ritual has been completed...</span>")



/datum/ritual/zizo/greaterwildsacrifice
	name = "Greater wild Sacrifice"
	circle = "Sacrifice"
	center_requirement = /obj/item/reagent_containers/food/snacks/rogue/meat
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat
	s_req = /obj/item/reagent_containers/food/snacks/rogue/meat
	e_req = /obj/item/reagent_containers/food/snacks/rogue/meat
	w_req = /obj/item/reagent_containers/food/snacks/rogue/meat
	difficulty = 3
	favor_cost = 0
	function = /proc/greaterwildsacrifice


/proc/greaterwildsacrifice(mob/user, turf/C)
	user.mind.zizofavor += 75;
	user.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	to_chat(user.mind, span_notice("Lady Zizo accepts my gift!"))

/datum/ritual/zizo/giftofpain
	name = "Gift of Pain"
	circle = "Sacrifice"
	center_requirement = /mob/living/carbon/human
	difficulty = 2
	favor_cost = 0

	function = /proc/giftofpain

/proc/giftofpain(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H.has_status_effect(/datum/status_effect/debuff/zizoagony))
			to_chat(user.mind, span_notice("This one has suffered enough for the moment.."))
			return
		H.take_overall_damage(150)
		H.Paralyze(30)
		H.apply_status_effect(/datum/status_effect/debuff/zizoagony)
		C.visible_message(span_danger("[H.real_name] is lifted up into the air and multiple scratches, incisions and shallow cuts start etching themselves into their skin!"))
		user.mind.zizofavor += 25
		to_chat(user.mind, span_notice("She smiles upon the suffering I cause!"))
		to_chat(H.mind, span_notice("THE PAIN!! IT'S TOO MUCH!!!"))
		playsound(C,pick('sound/combat/hits/bladed/genslash (1).ogg','sound/combat/hits/bladed/genslash (2).ogg','sound/combat/hits/bladed/genslash (3).ogg'), 100, FALSE)
