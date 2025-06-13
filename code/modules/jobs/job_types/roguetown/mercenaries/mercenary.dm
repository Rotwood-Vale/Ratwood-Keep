/datum/job/roguetown/mercenary
	title = "Mercenary"
	flag = MERCENARY
	department_flag = MERCENARIES
	tutorial = "You've travelled the lands and plied your sword and skill for mammon and blood. You are loyal only to the highest bidder and yourself, not to a lord like a common soldier. Perhaps you've enlisted with a guild, perhaps you're a member of a holy order, perhaps you're just a cut above the typical bandit."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	outfit = null
	outfit_female = null
	display_order = JDO_MERCENARY
	selection_color = JCOLOR_MERCENARY
	faction = "Station"
	total_positions = 10
	spawn_positions = 10 //subject to change, was originally 6
	min_pq = 0
	max_pq = null
	subclass_cat_rolls = list(CTAG_MERCENARY = 20)
	PQ_boost_divider = 10
	wanderer_examine = FALSE
	foreign_examine = TRUE
	advjob_examine = TRUE
	mercenary_examine = TRUE
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 15 MINUTES

/datum/job/roguetown/mercenary/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	var/mob/living/carbon/human/H = L
	if(L)
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
	if(H.charflaw)
		if(H.charflaw.type == /datum/charflaw/noeyer)
			var/obj/item/eyepatch = new /obj/item/clothing/mask/rogue/eyepatch(get_turf(H))
			H.put_in_hands(eyepatch, forced = TRUE)
			H.equip_to_slot_if_possible(eyepatch, SLOT_WEAR_MASK, FALSE, TRUE, FALSE, TRUE, TRUE)
		if(H.charflaw.type == /datum/charflaw/noeyel)
			var/obj/item/eyepatch_l = new /obj/item/clothing/mask/rogue/eyepatch/left(get_turf(H))
			H.put_in_hands(eyepatch_l, forced = TRUE)
			H.equip_to_slot_if_possible(eyepatch_l, SLOT_WEAR_MASK, FALSE, TRUE, FALSE, TRUE, TRUE)
		if(H.charflaw.type != /datum/charflaw/greedy)
			if(H.charflaw.type == /datum/charflaw/dead_or_alive)
				return
			else
				H.charflaw = new /datum/charflaw/greedy
