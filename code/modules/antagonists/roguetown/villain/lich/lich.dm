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
	var/traits_lich = list(
		TRAIT_NOSTAMINA,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_NOPAIN,
		TRAIT_BLOODLOSS_IMMUNE,
		TRAIT_NO_BLOOD,
		TRAIT_TOXIMMUNE,
		TRAIT_STEELHEARTED,
		TRAIT_NOSLEEP,
		TRAIT_LIMPDICK,
		TRAIT_VAMPMANSION,
		TRAIT_NOMOOD,
		TRAIT_NOLIMBDISABLE,
		TRAIT_SHOCKIMMUNE,
		TRAIT_LIMBATTACHMENT,
		TRAIT_SEEPRICES,
		TRAIT_CRITICAL_RESISTANCE,
		TRAIT_HEAVYARMOR,
		TRAIT_SPECIALUNDEAD
		)

	var/STASTR = 10
	var/STASPD = 10
	var/STAINT = 10
	var/STAEND = 10
	var/STAPER = 10

/mob/living/carbon/human
	/// List of minions that this mob has control over. Used for things like the Lich's "Command Undead" spell.
	var/list/mob/minions = list()

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
	to_chat(owner.current, span_userdanger("The secret of immortality is mine, but this is not enough. A thousand lichdoms have risen and fallen over the eras. Mine will be the one to last."))
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

	L.cmode_music = 'sound/music/combat_cult.ogg'
	L.faction = list("undead")
	if(L.charflaw)
		QDEL_NULL(L.charflaw)
	L.mob_biotypes |= MOB_UNDEAD
	replace_eyes(L)
	for(var/obj/item/bodypart/B in L.bodyparts)
		B.skeletonize(FALSE)

	equip_and_traits()
	L.equipOutfit(/datum/outfit/job/roguetown/lich)
	L.set_patron(/datum/patron/zizo)

/datum/outfit/job/roguetown/lich/pre_equip(mob/living/carbon/human/H)
	..()

	H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 6, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/magic/arcane, 5, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/magic/blood, 5, TRUE)	// Lich has some bloodmagic spells
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/riding, 4, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/swimming, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 5, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/medicine, 4, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/alchemy, 4, TRUE)

	H.change_stat("strength", -1)
	H.change_stat("intelligence", 5)
	H.change_stat("constitution", 5)
	H.change_stat("endurance", -1)
	H.change_stat("speed", -1)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/command_undead)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/strengthen_undead)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_undead)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodlightning)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/eyebite)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/sickness)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/revoke_unlife)
	H.ambushable = FALSE

	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "LICH"), 5 SECONDS)

/datum/antagonist/lich/proc/replace_eyes(mob/living/carbon/human/L)
	var/obj/item/organ/eyes/eyes = L.getorganslot(ORGAN_SLOT_EYES)
	if (eyes)
		eyes.Remove(L, TRUE)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(L)

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

/datum/antagonist/lich/proc/equip_and_traits()
	var/mob/living/carbon/human/body = owner.current
	var/list/equipment_slots = list(
		SLOT_PANTS,
		SLOT_SHOES,
		SLOT_NECK,
		SLOT_CLOAK,
		SLOT_ARMOR,
		SLOT_SHIRT,
		SLOT_WRISTS,
		SLOT_GLOVES,
		SLOT_BELT,
		SLOT_BELT_R,
		SLOT_BELT_L,
		SLOT_HANDS,
		SLOT_BACK_L,
		)

	var/list/equipment_items = list(
		/obj/item/clothing/under/roguetown/chainlegs,
		/obj/item/clothing/shoes/roguetown/boots,
		/obj/item/clothing/neck/roguetown/chaincoif,
		/obj/item/clothing/cloak/raincloak/mortus,
		/obj/item/clothing/suit/roguetown/shirt/robe/necromancer,
		/obj/item/clothing/suit/roguetown/shirt/tunic/ucolored,
		/obj/item/clothing/wrists/roguetown/bracers,
		/obj/item/clothing/gloves/roguetown/chain,
		/obj/item/storage/belt/rogue/leather/black,
		/obj/item/reagent_containers/glass/bottle/rogue/manapot,
		/obj/item/rogueweapon/huntingknife/idagger/steel,
		/obj/item/rogueweapon/woodstaff/wise,
		/obj/item/storage/backpack/rogue/satchel,
	)
	for (var/i = 1, i <= equipment_slots.len, i++)
		var/slot = equipment_slots[i]
		var/item_type = equipment_items[i]
		body.equip_to_slot_or_del(new item_type, slot, TRUE)

	for (var/trait in traits_lich)
		ADD_TRAIT(body, trait, "[type]")

/datum/antagonist/lich/proc/rise_anew()
	if (!owner.current.mind)
		CRASH("Lich: rise_anew called with no mind")

	var/mob/living/carbon/human/old_body = owner.current
	var/turf/phylactery_turf = get_turf(old_body)
	var/mob/living/carbon/human/new_body = new /mob/living/carbon/human/species/human/northern(phylactery_turf)

	old_body.mind.transfer_to(new_body)

	if (new_body.charflaw)
		QDEL_NULL(new_body.charflaw)

	new_body.real_name = old_body.name
	new_body.dna.real_name = old_body.real_name
	new_body.mob_biotypes |= MOB_UNDEAD
	new_body.set_patron(/datum/patron/zizo)
	new_body.mind.grab_ghost(force = TRUE)
	new_body.faction = list("undead")

	for (var/obj/item/bodypart/body_part in new_body.bodyparts)
		body_part.skeletonize(FALSE)

	replace_eyes(new_body)
	set_stats()
	skele_look()
	equip_and_traits()

	// Delete the old body if it still exists
	if (!QDELETED(old_body))
		qdel(old_body)
