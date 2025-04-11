

/obj/item/rogueweapon/huntingknife
	force = 12
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust, /datum/intent/dagger/chop)
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	name = "hunting knife"
	desc = "This survival knife might be able to get you through the wild."
	icon_state = "huntingknife"
	icon = 'icons/roguetown/weapons/32.dmi'
	item_state = "bone_dagger"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	gripsprite = FALSE
	//dropshrink = 0.75
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	max_blade_int = 100
	max_integrity = 175
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	associated_skill = /datum/skill/combat/knives
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	throwforce = 12
	wdefense = 3
	wbalance = 1
	thrown_bclass = BCLASS_CUT
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron
	can_cdg = TRUE

/obj/item/rogueweapon/huntingknife/attack_right(mob/user)
	if(locate(/obj/machinery/anvil) in (loc))
		return ..()
	if(!overlays.len)
		if(!('icons/roguetown/weapons/idaggerherald.dmi' in GLOB.IconStates_cache))
			var/icon/J = new('icons/roguetown/weapons/idaggerherald.dmi')
			var/list/istates = J.IconStates()
			GLOB.IconStates_cache |= icon
			GLOB.IconStates_cache['icons/roguetown/weapons/idaggerherald.dmi'] = istates

		var/picked_name = input(user, "Choose thy Weapon", "Hunting Knives...", name) as null|anything in sortList(GLOB.IconStates_cache['icons/roguetown/weapons/idaggerherald.dmi'])
		if(!picked_name)
			picked_name = "none"
		var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/idaggerherald.dmi', picked_name)
		M.alpha = 255
		alpha = 255
		icon_state = picked_name
		icon = 'icons/roguetown/weapons/idaggerherald.dmi'
		lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
		righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
		if(alert("Are you pleased with your weapon?", "Heraldry", "Yes", "No") != "Yes")
			icon_state = "Hunting Knife"
	else
		..()

/obj/item/rogueweapon/huntingknife/Initialize()
	. = ..()
	AddElement(/datum/element/tipped_item)

/datum/intent/dagger
	clickcd = 8

/datum/intent/dagger/cut
	name = "cut"
	icon_state = "incut"
	attack_verb = list("cuts", "slashes")
	animname = "cut"
	blade_class = BCLASS_CUT
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	penfactor = 0
	chargetime = 0
	swingdelay = 0
	clickcd = 10
	item_d_type = "slash"
	ican_cdg = TRUE
	ican_assin = TRUE

/datum/intent/dagger/thrust
	name = "thrust"
	icon_state = "instab"
	attack_verb = list("thrusts", "stabs")
	animname = "stab"
	blade_class = BCLASS_STAB
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 40
	chargetime = 0
	clickcd = 8
	item_d_type = "stab"
	ican_cdg = TRUE
	ican_assin = TRUE

/datum/intent/dagger/thrust/pick
	name = "icepick stab"
	icon_state = "inpick"
	attack_verb = list("picks", "impales")
	blade_class = BCLASS_STAB
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 70
	clickcd = 14
	swingdelay = 12
	damfactor = 1.5
	ican_cdg = TRUE
	ican_assin = TRUE

/obj/item/rogueweapon/huntingknife/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -10,"sy" = 0,"nx" = 11,"ny" = 0,"wx" = -4,"wy" = 0,"ex" = 2,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/datum/intent/dagger/chop
	name = "chop"
	icon_state = "inchop"
	attack_verb = list("chops",)
	animname = "chop"
	blade_class = BCLASS_CHOP
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	penfactor = 10
	damfactor = 1.5
	swingdelay = 5
	clickcd = 10
	item_d_type = "slash"

/obj/item/rogueweapon/huntingknife/cleaver
	force = 15
	name = "cleaver"
	desc = "A big, heavy knife designed to chop through meat with ease."
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/chop/cleaver)
	icon_state = "cleav"
	parrysound = list('sound/combat/parry/bladed/bladedmedium (1).ogg','sound/combat/parry/bladed/bladedmedium (2).ogg','sound/combat/parry/bladed/bladedmedium (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshmed (1).ogg','sound/combat/wooshes/bladed/wooshmed (2).ogg','sound/combat/wooshes/bladed/wooshmed (3).ogg')
	throwforce = 15
	slot_flags = ITEM_SLOT_HIP
	thrown_bclass = BCLASS_CHOP
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = /obj/item/ingot/steel
	can_cdg = FALSE

/obj/item/rogueweapon/huntingknife/cleaver/combat
	force = 16
	name = "combat knife"
	desc = "A swift and deadly combat knife."
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/chop/cleaver, /datum/intent/dagger/thrust)
	icon_state = "combatknife"
	throwforce = 16
	can_cdg = TRUE
	can_assin = TRUE

/obj/item/rogueweapon/huntingknife/cleaver/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,
"sx" = -10,
"sy" = 0,
"nx" = 13,
"ny" = 2,
"wx" = -8,
"wy" = 2,
"ex" = 5,
"ey" = 2,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 21,
"sturn" = -18,
"wturn" = -18,
"eturn" = 21,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/datum/intent/dagger/chop/cleaver
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')
	penfactor = 30

/obj/item/rogueweapon/huntingknife/scissors
	possible_item_intents = list(/datum/intent/dagger/thrust, /datum/intent/dagger/cut, /datum/intent/snip)
	max_integrity = 100
	name = "iron scissors"
	desc = "Scissors made of iron that may be used to salvage usable materials from clothing."
	icon_state = "iscissors"

/datum/intent/snip // The salvaging intent! Used only for the scissors for now!
	name = "snip"
	icon_state = "insnip"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	canparry = FALSE
	misscost = 0
	no_attack = TRUE
	releasedrain = 0
	blade_class = BCLASS_PUNCH

/obj/item/rogueweapon/huntingknife/scissors/attack_obj(obj/O, mob/living/user) //This is scissor action! We're putting this here not to lose sight of it!
	if(user.used_intent.type == /datum/intent/snip && istype(O, /obj/item))
		var/obj/item/item = O
		if(item.sewrepair && item.salvage_result) // We can only salvage objects which can be sewn!
			var/salvage_time = 70
			var/skill_level = user.mind.get_skill_level(/datum/skill/misc/sewing)
			salvage_time = (70 - (skill_level * 10))
			if(!do_after(user, salvage_time, target = user))
				return
			if(item.fiber_salvage) //We're getting fiber as base if fiber is present on the item
				new /obj/item/natural/fibers(get_turf(item))
			if(istype(item, /obj/item/storage))
				var/obj/item/storage/bag = item
				bag.emptyStorage()
			var/probability = max(0, 50 - (skill_level * 10))
			if(prob(probability)) // We are dumb and we failed!
				to_chat(user, span_info("I ruined some of the materials due to my lack of skill..."))
				playsound(item, 'sound/foley/cloth_rip.ogg', 50, TRUE)
				qdel(item)
				user.mind.add_sleep_experience(/datum/skill/misc/sewing, (user.STAINT)) //Getting exp for failing
				return //We are returning early if the skill check fails!
			item.salvage_amount -= item.torn_sleeve_number
			for(var/i = 1; i <= item.salvage_amount; i++) // We are spawning salvage result for the salvage amount minus the torn sleves!
				var/obj/item/Sr = new item.salvage_result(get_turf(item))
				Sr.color = item.color
			user.visible_message(span_notice("[user] salvages [item] into usable materials."))
			playsound(item, 'sound/items/flint.ogg', 100, TRUE) //In my mind this sound was more fitting for a scissor
			qdel(item)
			user.mind.add_sleep_experience(/datum/skill/misc/sewing, (user.STAINT)) //We're getting experience for salvaging!
	..()

/obj/item/rogueweapon/huntingknife/scissors/steel
	force = 14
	max_integrity = 150
	name = "steel scissors"
	desc = "Scissors made of solid steel that may be used to salvage usable materials from clothing, more durable and a tad more deadly than their iron conterpart."
	icon_state = "sscissors"

/obj/item/rogueweapon/huntingknife/idagger
	possible_item_intents = list(/datum/intent/dagger/thrust,/datum/intent/dagger/cut, /datum/intent/dagger/thrust/pick)
	force = 15
	max_integrity = 100
	name = "iron dagger"
	desc = "This is a common dagger of iron."
	icon_state = "idagger"
	can_cdg = TRUE
	can_assin = TRUE

/obj/item/rogueweapon/huntingknife/idagger/attack_right(mob/user)
	if(locate(/obj/machinery/anvil) in (loc))
		return ..()
	if(!overlays.len)
		if(!('icons/roguetown/weapons/idaggerherald.dmi' in GLOB.IconStates_cache))
			var/icon/J = new('icons/roguetown/weapons/idaggerherald.dmi')
			var/list/istates = J.IconStates()
			GLOB.IconStates_cache |= icon
			GLOB.IconStates_cache['icons/roguetown/weapons/idaggerherald.dmi'] = istates

		var/picked_name = input(user, "Choose thy Weapon", "Iron Daggers...", name) as null|anything in sortList(GLOB.IconStates_cache['icons/roguetown/weapons/idaggerherald.dmi'])
		if(!picked_name)
			picked_name = "none"
		var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/idaggerherald.dmi', picked_name)
		M.alpha = 255
		alpha = 255
		icon_state = picked_name
		icon = 'icons/roguetown/weapons/idaggerherald.dmi'
		lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
		righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
		if(alert("Are you pleased with your weapon?", "Heraldry", "Yes", "No") != "Yes")
			icon_state = "Regular Dagger"
	else
		..()

/obj/item/rogueweapon/huntingknife/idagger/steel
	name = "steel dagger"
	desc = "This is a dagger made of solid steel, more durable."
	icon_state = "sdagger"
	max_integrity = 150
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/huntingknife/idagger/steel/attack_right(mob/user)
	if(locate(/obj/machinery/anvil) in (loc))
		return ..()
	if(!overlays.len)
		if(!('icons/roguetown/weapons/daggerherald.dmi' in GLOB.IconStates_cache))
			var/icon/J = new('icons/roguetown/weapons/daggerherald.dmi')
			var/list/istates = J.IconStates()
			GLOB.IconStates_cache |= icon
			GLOB.IconStates_cache['icons/roguetown/weapons/daggerherald.dmi'] = istates

		var/picked_name = input(user, "Choose thy Weapon", "Steel Daggers...", name) as null|anything in sortList(GLOB.IconStates_cache['icons/roguetown/weapons/daggerherald.dmi'])
		if(!picked_name)
			picked_name = "none"
		var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/daggerherald.dmi', picked_name)
		M.alpha = 255
		alpha = 255
		icon_state = picked_name
		icon = 'icons/roguetown/weapons/daggerherald.dmi'
		lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
		righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
		if(alert("Are you pleased with your weapon?", "Heraldry", "Yes", "No") != "Yes")
			icon_state = "Regular Dagger"
	else
		..()

/obj/item/rogueweapon/huntingknife/idagger/steel/special
	icon_state = "sdaggeralt"

/obj/item/rogueweapon/huntingknife/idagger/silver
	name = "silver dagger"
	desc = "This silver dagger can be the banishment of vampires and werewolves."
	icon_state = "sildagger"
	sellprice = 50
	smeltresult = /obj/item/ingot/silver
	var/last_used = 0

/obj/item/rogueweapon/huntingknife/idagger/silver/Initialize()
	. = ..()
	var/datum/magic_item/mundane/silver/effect = new
	AddComponent(/datum/component/magic_item, effect)

/obj/item/rogueweapon/huntingknife/stoneknife
	possible_item_intents = list(/datum/intent/dagger/cut,/datum/intent/dagger/chop)
	name = "stone knife"
	desc = "A crudely crafted knife made of stone."
	icon_state = "stone_knife"
	smeltresult = null
	max_integrity = 50
	max_blade_int = 50
	wdefense = 1

/obj/item/rogueweapon/huntingknife/elvish
	possible_item_intents = list(/datum/intent/dagger/thrust,/datum/intent/dagger/cut)
	name = "elvish dagger"
	desc = "This beautiful dagger is of intricate, elvish design. Sharper, too."
	force = 19
	icon_state = "elfdagger"
	item_state = "elfdag"
	smeltresult = /obj/item/ingot/silver
	can_cdg = TRUE
	can_assin = TRUE
	var/last_used = 0

/obj/item/rogueweapon/huntingknife/elvish/pickup(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	if(ishuman(H))
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
				H.Knockdown(10)
				H.Paralyze(10)
		if(W && W.transformed == TRUE)
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)


/obj/item/rogueweapon/huntingknife/elvish/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
				H.Knockdown(10)
				H.Paralyze(10)
		if(W && W.transformed == TRUE)
			to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)


/obj/item/rogueweapon/huntingknife/elvish/funny_attack_effects(mob/living/target, mob/living/user = usr, nodmg)
	if(world.time < src.last_used + 100)
		to_chat(user, span_notice("The silver effect is on cooldown."))
		return

	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/s_user = user
		var/mob/living/carbon/human/H = target
		var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
		var/datum/antagonist/vampirelord/lesser/V = H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		if(V)
			if(V.disguised)
				H.Knockdown(10)
				H.Paralyze(10)
				H.visible_message("<font color='white'>The silver weapon manifests the [H] curse!</font>")
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.adjustFireLoss(25)
				H.fire_act(1,10)
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
			else
				H.Stun(20)
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.Knockdown(10)
				H.Paralyze(10)
				H.adjustFireLoss(25)
				H.fire_act(1,10)
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
		if(V_lord)
			if(V_lord.vamplevel < 4 && !V)
				H.Knockdown(10)
				H.Paralyze(10)
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.adjustFireLoss(25)
				H.fire_act(1,10)
				src.last_used = world.time
			if(V_lord.vamplevel == 4 && !V)
				s_user.Stun(10)
				s_user.Paralyze(10)
				s_user.adjustFireLoss(25)
				s_user.fire_act(1,10)
				to_chat(s_user, "<font color='red'> The silver weapon fails!</font>")
				H.visible_message(H, span_userdanger("This feeble metal can't hurt me, I AM THE ANCIENT!"))
		if(W && W.transformed == TRUE)
			H.adjustFireLoss(25)
			H.Paralyze(10)
			H.Stun(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
			to_chat(H, span_userdanger("I'm hit by my BANE!"))
			src.last_used = world.time

/obj/item/rogueweapon/huntingknife/elvish/Initialize()
	. = ..()
	var/datum/magic_item/mundane/silver/effect = new
	AddComponent(/datum/component/magic_item, effect)

/obj/item/rogueweapon/huntingknife/elvish/drow
	name = "nite elf dagger"
	desc = "This ominous, dark handled dagger was crafted by the assassin race of nite elves."
	force = 25
