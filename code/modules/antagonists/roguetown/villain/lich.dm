/datum/antagonist/lich
	name = "Lich"
	roundend_category = "Lich"
	antagpanel_category = "Lich"
	job_rank = ROLE_LICH
	confess_lines = list(
		"I WILL LIVE ETERNAL!",
		"I AM BEHIND SEVEN PHYLACTERIES!",
		"YOU CANNOT KILL ME!",
	)
	rogue_enabled = TRUE
	var/list/phylacteries = list()
	var/out_of_lives = FALSE

	var/STASTR = 10
	var/STASPD = 10
	var/STAINT = 10
	var/STAEND = 10
	var/STAPER = 10

/datum/antagonist/lich/on_gain()
	var/datum/game_mode/C = SSticker.mode
	C.liches |= owner
	. = ..()
	owner.special_role = name
	skele_look()
	equip_lich()
	greet()
	save_stats()

	return ..()

/datum/antagonist/lich/greet()
	to_chat(owner.current, span_userdanger("The secret of immortality is mine, but this is not enough. The Azurean lands need a new ruler. One that will reign eternal."))
	owner.announce_objectives()
	..()

/datum/antagonist/lich/proc/save_stats()
	STASTR = owner.current.STASTR
	STAPER = owner.current.STAPER
	STAINT = owner.current.STAINT
	STASPD = owner.current.STASPD
	STAEND = owner.current.STAEND

/datum/antagonist/lich/proc/set_stats()
	owner.current.STASTR = src.STASTR
	owner.current.STAPER = src.STAPER
	owner.current.STAINT = src.STAINT
	owner.current.STASPD = src.STASPD
	owner.current.STAEND = src.STAEND

/datum/antagonist/lich/proc/skele_look()
	var/mob/living/carbon/human/L = owner.current
	L.hairstyle = "Bald"
	L.facial_hairstyle = "Shaved"
	L.update_body()
	L.update_hair()
	L.update_body_parts(redraw = TRUE)

/datum/antagonist/lich/proc/equip_lich()
	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	var/mob/living/carbon/human/L = owner.current
	ADD_TRAIT(L, TRAIT_NOROGSTAM, "[type]")
	ADD_TRAIT(L, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(L, TRAIT_NOBREATH, "[type]")
	ADD_TRAIT(L, TRAIT_NOPAIN, "[type]")
	ADD_TRAIT(L, TRAIT_TOXIMMUNE, "[type]")
	ADD_TRAIT(L, TRAIT_STEELHEARTED, "[type]")
	ADD_TRAIT(L, TRAIT_NOSLEEP, "[type]")
	ADD_TRAIT(L, TRAIT_VAMPMANSION, "[type]")
	ADD_TRAIT(L, TRAIT_NOMOOD, "[type]")
	ADD_TRAIT(L, TRAIT_NOLIMBDISABLE, "[type]")
	ADD_TRAIT(L, TRAIT_SHOCKIMMUNE, "[type]")
	ADD_TRAIT(L, TRAIT_LIMBATTACHMENT, "[type]")
	ADD_TRAIT(L, TRAIT_SEEPRICES, "[type]")
	ADD_TRAIT(L, TRAIT_CRITICAL_RESISTANCE, "[type]")
	ADD_TRAIT(L, TRAIT_HEAVYARMOR, "[type]")
	ADD_TRAIT(L, TRAIT_CABAL, "[type]")
	ADD_TRAIT(L, TRAIT_DEATHSIGHT, "[type]")
	L.cmode_music = 'sound/music/combat_cult.ogg'
	L.faction = list("undead")
	if(L.charflaw)
		QDEL_NULL(L.charflaw)
	L.mob_biotypes |= MOB_UNDEAD
	var/obj/item/organ/eyes/eyes = L.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(L,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(L)
	for(var/obj/item/bodypart/B in L.bodyparts)
		B.skeletonize(FALSE)
	L.equipOutfit(/datum/outfit/job/roguetown/lich)
	L.set_patron(/datum/patron/inhumen/zizo)

/datum/outfit/job/roguetown/lich/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	armor = /obj/item/clothing/suit/roguetown/armor/blacksteel/cuirass
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/ucolored
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	gloves = /obj/item/clothing/gloves/roguetown/chain
	belt = /obj/item/storage/belt/rogue/leather/black
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	r_hand = /obj/item/rogueweapon/woodstaff/wise

	H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)

	H.change_stat("strength", -1)
	H.change_stat("intelligence", 5)
	H.change_stat("constitution", 5)
	H.change_stat("endurance", -1)
	H.change_stat("speed", -1)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/bonechill)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_undead)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_lesser_undead)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodlightning)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/suicidebomb)
	H.ambushable = FALSE

	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "LICH"), 5 SECONDS)

/datum/outfit/job/roguetown/lich/post_equip(mob/living/carbon/human/H)
	..()
	var/datum/antagonist/lich/lichman = H.mind.has_antag_datum(/datum/antagonist/lich)
	for(var/i in 1 to 3)
		var/obj/item/phylactery/new_phylactery = new(H.loc)
		lichman.phylacteries += new_phylactery
		new_phylactery.possessor = lichman
		H.equip_to_slot_or_del(new_phylactery,SLOT_IN_BACKPACK, TRUE)

/datum/antagonist/lich/proc/consume_phylactery(timer = 10 SECONDS)
	if(phylacteries.len == 0)
		return FALSE
	else
		for(var/obj/item/phylactery/phyl in phylacteries)
			phyl.be_consumed(timer)
			phylacteries -= phyl
			return TRUE
	

///only called post death to equip new body with armour and stats
/datum/antagonist/lich/proc/post_death_equip()
	var/mob/living/carbon/human/body = owner.current 

	body.equip_to_slot_or_del(new /obj/item/clothing/under/roguetown/chainlegs, SLOT_PANTS, TRUE)
	body.equip_to_slot_or_del(new /obj/item/clothing/shoes/roguetown/boots, SLOT_SHOES, TRUE)
	body.equip_to_slot_or_del(new /obj/item/clothing/neck/roguetown/chaincoif, SLOT_NECK, TRUE)
	body.equip_to_slot_or_del(new /obj/item/clothing/cloak/raincloak/mortus, SLOT_CLOAK, TRUE)
	body.equip_to_slot_or_del(new /obj/item/clothing/suit/roguetown/armor/blacksteel/cuirass, SLOT_ARMOR, TRUE)
	body.equip_to_slot_or_del(new /obj/item/clothing/suit/roguetown/shirt/tunic/ucolored, SLOT_SHIRT, TRUE)
	body.equip_to_slot_or_del(new /obj/item/clothing/wrists/roguetown/bracers, SLOT_WRISTS, TRUE)
	body.equip_to_slot_or_del(new /obj/item/clothing/gloves/roguetown/chain, SLOT_GLOVES, TRUE)
	body.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/leather/black, SLOT_BELT, TRUE)
	body.equip_to_slot_or_del(new /obj/item/reagent_containers/glass/bottle/rogue/manapot, SLOT_BELT_R, TRUE)
	body.equip_to_slot_or_del(new /obj/item/rogueweapon/huntingknife/idagger/steel, SLOT_BELT_L, TRUE)
	body.equip_to_slot_or_del(new /obj/item/rogueweapon/woodstaff/wise, SLOT_HANDS, TRUE)

	ADD_TRAIT(body, TRAIT_NOROGSTAM, "[type]")
	ADD_TRAIT(body, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(body, TRAIT_NOBREATH, "[type]")
	ADD_TRAIT(body, TRAIT_NOPAIN, "[type]")
	ADD_TRAIT(body, TRAIT_TOXIMMUNE, "[type]")
	ADD_TRAIT(body, TRAIT_STEELHEARTED, "[type]")
	ADD_TRAIT(body, TRAIT_NOSLEEP, "[type]")
	ADD_TRAIT(body, TRAIT_VAMPMANSION, "[type]")
	ADD_TRAIT(body, TRAIT_NOMOOD, "[type]")
	ADD_TRAIT(body, TRAIT_NOLIMBDISABLE, "[type]")
	ADD_TRAIT(body, TRAIT_SHOCKIMMUNE, "[type]")
	ADD_TRAIT(body, TRAIT_LIMBATTACHMENT, "[type]")
	ADD_TRAIT(body, TRAIT_SEEPRICES, "[type]")
	ADD_TRAIT(body, TRAIT_CRITICAL_RESISTANCE, "[type]")
	ADD_TRAIT(body, TRAIT_HEAVYARMOR, "[type]")
	ADD_TRAIT(body, TRAIT_CABAL, "[type]")
	ADD_TRAIT(body, TRAIT_DEATHSIGHT, "[type]")
		
/datum/antagonist/lich/proc/rise_anew()

	// Ensure the mind exists before proceeding
	if (!owner.current.mind)
		CRASH("Lich: rise_anew called with no mind")
		// Save the old body and find a suitable spawn location
	var/mob/living/carbon/human/old_body = owner.current
	var/turf/phylactery_turf = get_turf(old_body)
		// Create a new body
	var/mob/living/carbon/human/new_body = new /mob/living/carbon/human/species/human/northern(phylactery_turf)
	//new(phylactery_turf)

		// Transfer the mind to the new body
	old_body.mind.transfer_to(new_body)
	// Apply lich-specific stats 


	if (new_body.charflaw)
		QDEL_NULL(new_body.charflaw)

	new_body.real_name = old_body.name
	new_body.dna.real_name = old_body.real_name

	new_body.mob_biotypes |= MOB_UNDEAD
	new_body.set_patron(/datum/patron/inhumen/zizo)

	for (var/obj/item/bodypart/body_part in new_body.bodyparts)
		body_part.skeletonize(FALSE)

	var/obj/item/organ/eyes/eyes = new_body.getorganslot(ORGAN_SLOT_EYES)
	if (eyes)
		eyes.Remove(new_body, TRUE)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(new_body)
	set_stats()
	skele_look()
	//equip armour and traits
	post_death_equip()

	// Delete the old body if it still exists
	if (!QDELETED(old_body))
		qdel(old_body)

/obj/item/phylactery
	name = "phylactery"
	desc = "Looks like it is filled with some intense power."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "soulstone"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	layer = HIGH_OBJ_LAYER
	w_class = WEIGHT_CLASS_TINY
	light_system = MOVABLE_LIGHT
	light_outer_range = 3
	light_color = "#e62424"

	var/datum/antagonist/lich/possessor

	var/datum/mind/mind

/obj/item/phylactery/Initialize(mapload, datum/mind/newmind)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))

/obj/item/phylactery/proc/be_consumed(timer)
	var/offset = prob(50) ? -2 : 2
	animate(src, pixel_x = pixel_x + offset, time = 0.2, loop = -1) //start shaking
	visible_message(span_warning("[src] begins to glow and shake violently!"))
	
	spawn(timer)
		possessor.owner.current.forceMove(get_turf(src))
		possessor.rise_anew()
		qdel(src)
