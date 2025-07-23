// Basic intents polearms.

/datum/intent/spear/thrust
	name = "thrust"
	desc = "Thrusting and stabbing motions making them slightly more accurate than cuts while also having a way easier time penetrating armor."
	blade_class = BCLASS_STAB
	attack_verb = list("thrusts")
	animname = "stab"
	icon_state = "instab"
	reach = 2
	chargetime = 1.5
	warnie = "mobwarning"
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 40 // Matches a dagger stab, but the raw damage makes up for it.
	item_d_type = "stab"

/datum/intent/spear/thrust/steel
	penfactor = 50

/datum/intent/spear/bash
	name = "bash"
	desc = "Hilt pommeling and blunt-front bashing motions making blunting through armor easier."
	blade_class = BCLASS_BLUNT
	icon_state = "inbash"
	attack_verb = list("bashes", "clubs", "strikes")
	penfactor = 15
	damfactor = 0.8
	item_d_type = "blunt"

/datum/intent/spear/bash/woodstaff
	damfactor = 1
	icon_state = "instrike"
	attack_verb = list("strikes", "whacks")

/datum/intent/spear/cut
	name = "cut"
	desc = "Poke-slashing and cutting-across motions making this both slower and less damaging than proper stabs."
	blade_class = BCLASS_CUT
	attack_verb = list("cuts", "slashes")
	icon_state = "incut"
	damfactor = 0.8
	swingdelay = 5 // Half a second to land, it has no charge up after all. (This delay is intent for pointy spears, not ones with blades)
	hitsound = list('sound/combat/hits/bladed/genslash (1).ogg', 'sound/combat/hits/bladed/genslash (2).ogg', 'sound/combat/hits/bladed/genslash (3).ogg')
	reach = 2
	item_d_type = "slash"

/obj/item/rogueweapon/woodstaff
	force = 10
	force_wielded = 15
	throwforce = 10
	throw_range = 5
	throw_speed = 1
	possible_item_intents = list(/datum/intent/spear/bash/woodstaff, /datum/intent/spear/bash) // The bash intent is kept for those that wish to train polearms, go easier on others or humiliate them.
	gripped_intents = list(/datum/intent/spear/bash/woodstaff, /datum/intent/mace/smash/wood, /datum/intent/spear/bash)
	name = "wooden staff"
	desc = "Not so heavy, perfect for beggars, Refugees and mages."
	icon_state = "woodstaff"
	icon = 'icons/roguetown/weapons/64.dmi'
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	wdefense = 3
	wieldedwdefense = 7
	bigboy = TRUE
	gripsprite = TRUE
	associated_skill = /datum/skill/combat/polearms
	metalizer_result = /obj/item/rogueweapon/spear/bronze

// Allows blind carbons to examine if they click on an object using a wooden staff.
/obj/item/rogueweapon/woodstaff/pre_attack(atom/A, mob/living/user, params)
	if(HAS_TRAIT(user, TRAIT_BLIND) && !user.cmode) // If is not used by a blind mob in combat mode it won't examine.
		var/list/exam = A.examine(user) // Directly extracts the examine string without using the examinate proc.
		if(A != user) // Avoids the message of user poking themselves.
			src.visible_message(span_notice("[user] pokes [A] with [user.p_their()] wooden staff"))
		if(exam)
			to_chat(user, exam.Join("\n")) // Relays the examine string to the user.
		return TRUE

/obj/item/rogueweapon/woodstaff/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = -1,"nx" = 8,"ny" = 0,"wx" = -4,"wy" = 0,"ex" = 2,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/woodstaff/wise
	name = "wise staff"
	desc = "A staff for keeping the volfs at bay..."

/obj/item/rogueweapon/woodstaff/aries
	name = "staff of the shepherd"
	desc = "A blessed long silver staff adorned with an reinforced gold ornament atop. It is adorned with symbolism and icons of the Successors atop."
	force = 25
	force_wielded = 28
	throwforce = 20 // It's a stick, but it's a fancy stick.
	max_integrity = 300 // It's a one of a kind holy staff, no doubt Malum workshippers would go above and beyond to craft this thing to near perfection.
	smeltresult = /obj/item/ingot/silver
	icon_state = "aries"
	icon = 'icons/roguetown/weapons/64.dmi'
	resistance_flags = FIRE_PROOF
	pixel_y = 0
	pixel_x = 0
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	sellprice = 460
	bigboy = TRUE
	gripsprite = TRUE
	gripped_intents = list(SPEAR_BASH,/datum/intent/mace/smash/wood)
	var/last_used = 0

/obj/item/rogueweapon/woodstaff/aries/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = -1,"nx" = 8,"ny" = 0,"wx" = -4,"wy" = 0,"ex" = 2,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/rogueweapon/woodstaff/aries/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_CHOSEN))
		to_chat(user, "<font color='yellow'>UNWORTHY HANDS TOUCH THE STAFF, CEASE OR BE PUNISHED</font>")
		spawn(30)
			if(loc == user)
				user.adjust_fire_stacks(5)
				user.IgniteMob()

/obj/item/rogueweapon/woodstaff/aries/funny_attack_effects(mob/living/target, mob/living/user = usr, nodmg)
	if(world.time < src.last_used + 100)
		to_chat(user, span_notice("The silver effect is on cooldown."))
		return

	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
		var/datum/antagonist/vampirelord/lesser/V = H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		if(V)
			if(V.disguised)
				H.Knockdown(10)
				H.Paralyze(10)
				H.visible_message("<font color='white'>The silver weapon manifests the [H] curse!</font>")
				to_chat(H, span_userdanger("I'm hit by BLESSED SILVER!"))
				H.adjustFireLoss(25)
				H.fire_act(1,10)
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
			else
				H.Stun(20)
				to_chat(H, span_userdanger("I'm hit by BLESSED SILVER!"))
				H.Knockdown(10)
				H.Paralyze(10)
				H.adjustFireLoss(25)
				H.fire_act(1,10)
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
		if(V_lord)
			H.Knockdown(10)
			H.Paralyze(10)
			to_chat(H, span_userdanger("I'm hit by BLESSED SILVER!"))
			H.adjustFireLoss(25)
			H.fire_act(1,10)
			src.last_used = world.time
		if(W && W.transformed == TRUE)
			H.adjustFireLoss(25)
			H.Paralyze(10)
			H.Stun(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
			to_chat(H, span_userdanger("I'm hit by my BANE!"))
			src.last_used = world.time



/obj/item/rogueweapon/woodstaff/aries/Initialize()
	. = ..()
	var/datum/magic_item/mundane/silver/effect = new
	AddComponent(/datum/component/magic_item, effect)

/obj/item/rogueweapon/spear // TODO: Make a steel version that is more durable with penfactor 50, no, the billhook doesn't count.
	force = 18
	force_wielded = 25
	throwforce = 30
	throw_range = 7
	throw_speed = 1
	thrown_bclass = BCLASS_STAB
	possible_item_intents = list(SPEAR_THRUST, SPEAR_BASH) // Bash is for non-lethal takedowns, aim for the limbs for best effect. (Or aim for a lucky knockout to the head)
	gripped_intents = list(SPEAR_THRUST, SPEAR_CUT, SPEAR_BASH)
	name = "spear"
	desc = "This iron spear is great to impale goblins."
	icon_state = "spear"
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 8
	max_blade_int = 100
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	wdefense = 3
	thrown_bclass = BCLASS_STAB
	throwforce = 25

/obj/item/rogueweapon/spear/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/rogueweapon/spear/billhook
	name = "billhook"
	desc = "A neat, steel hook."
	icon_state = "billhook"
	force_wielded = 30
	throwforce = 25
	throw_range = 5
	possible_item_intents = list(/datum/intent/spear/thrust/steel, SPEAR_BASH)
	gripped_intents = list(/datum/intent/spear/thrust/steel, SPEAR_CUT, SPEAR_BASH)
	smeltresult = /obj/item/ingot/steel
	max_blade_int = 200
	minstr = 8
	wdefense = 3
	wieldedwdefense = 5
	throwforce = 15

/obj/item/rogueweapon/spear/improvisedbillhook
	force = 12
	force_wielded = 25
	throwforce = 18
	throw_range = 5
	name = "improvised billhook"
	desc = "Looks hastily made. \ It is made of iron."
	icon_state = "billhook"
	smeltresult = /obj/item/ingot/iron
	max_blade_int = 100
	throwforce = 10

/obj/item/rogueweapon/spear/stone
	force = 15
	force_wielded = 18
	throwforce = 20
	name = "stone spear"
	desc = "This handmade spear is simple, but does the job."
	icon_state = "stonespear"
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	minstr = 6
	max_blade_int = 50
	smeltresult = null
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	wdefense = 3
	max_integrity = 100
	throwforce = 20

/obj/item/rogueweapon/halberd
	force = 15
	force_wielded = 30
	throwforce = 30
	throw_range = 5
	throw_speed = 0.5
	thrown_bclass = BCLASS_CUT
	possible_item_intents = list(/datum/intent/spear/thrust/steel, SPEAR_BASH) // Bash is for non-lethal takedowns, aim for the limbs for best effect. (Or aim for a lucky knockout to the head)
	gripped_intents = list(/datum/intent/spear/thrust/steel, /datum/intent/spear/cut/halberd, /datum/intent/sword/chop, SPEAR_BASH)
	name = "halberd"
	desc = "A steel halberd, mostly used by town guards."
	icon_state = "halberd"
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 9
	max_blade_int = 200
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	wdefense = 3
	wieldedwdefense = 6

/datum/intent/spear/cut/halberd
	damfactor = 0.9
	swingdelay = 2.5

/obj/item/rogueweapon/halberd/attack_right(mob/user)
	if(locate(/obj/machinery/anvil) in (loc))
		return ..()
	if(!overlays.len)
		if(!('icons/roguetown/weapons/halberdherald.dmi' in GLOB.IconStates_cache))
			var/icon/J = new('icons/roguetown/weapons/halberdherald.dmi')
			var/list/istates = J.IconStates()
			GLOB.IconStates_cache |= icon
			GLOB.IconStates_cache['icons/roguetown/weapons/halberdherald.dmi'] = istates

		var/picked_name = input(user, "Choose thy Weapon", "Halberds...", name) as null|anything in sortList(GLOB.IconStates_cache['icons/roguetown/weapons/halberdherald.dmi'])
		if(!picked_name)
			picked_name = "none"
		var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/halberdherald.dmi', picked_name)
		M.alpha = 255
		alpha = 255
		var/old_bigboy = bigboy
		bigboy = 0
		var/old_gripsprite = gripsprite
		gripsprite = FALSE
		var/old_icon_state = icon_state
		icon_state = picked_name
		icon = 'icons/roguetown/weapons/halberdherald.dmi'
		if(alert("Are you pleased with your weapon?", "Heraldry", "Yes", "No") != "Yes")
			icon_state = old_icon_state
			gripsprite = old_gripsprite
			bigboy = old_bigboy
	else
		..()

/obj/item/rogueweapon/halberd/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/halberd/bardiche
	possible_item_intents = list(/datum/intent/spear/thrust/eaglebeak, SPEAR_BASH) // Bash is for non-lethal takedowns, aim for the limbs for best effect. (Or aim for a lucky knockout to the head)
	gripped_intents = list(/datum/intent/spear/thrust/eaglebeak, /datum/intent/spear/cut/halberd/bardiche, /datum/intent/axe/chop, SPEAR_BASH)
	name = "bardiche"
	desc = "A beautiful, better suited for cutting and chopping variant of an halberd."
	icon_state = "bardiche"
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron
	max_blade_int = 200
	max_integrity = 150

/datum/intent/spear/cut/halberd/bardiche
	damfactor = 1
	swingdelay = 2

/obj/item/rogueweapon/eaglebeak
	force = 15
	force_wielded = 30
	throwforce = 20
	throw_range = 3
	throw_speed = 0.5
	possible_item_intents = list(/datum/intent/spear/thrust/eaglebeak, SPEAR_BASH) // Bash is for non-lethal takedowns, aim for the limbs for best effect. (Or aim for a lucky knockout to the head)
	gripped_intents = list(/datum/intent/spear/thrust/eaglebeak, /datum/intent/mace/smash/eaglebeak, SPEAR_BASH)
	name = "eagle's beak"
	desc = "A heavy polearm with a hammer on its end, topped with a spike. \ It is made of sturdy steel."
	icon_state = "eaglebeak"
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 11
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	wdefense = 2 // It's a heavy tipped weapon, it's hard to parry with.
	wieldedwdefense = 5
	max_integrity = 175 // Protecting this thing with safe parries is difficult.

/datum/intent/spear/thrust/eaglebeak
	penfactor = 20
	damfactor = 0.9

/datum/intent/mace/smash/eaglebeak
	clickcd = 16 // Cool-down of 16 might seem cruel, but it is required considering the swift stance's ability to bypass parries and dodges if spammed on the previous 14 cool-down.
	swingdelay = 12
	reach = 2

/obj/item/rogueweapon/eaglebeak/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/eaglebeak/lucerne
	name = "lucerne"
	desc = "A polehammer with a sharp pointy end. \ It is made of iron."
	icon_state = "polehammer"
	force_wielded = 30
	smeltresult = /obj/item/ingot/iron
	max_blade_int = 200
	max_integrity = 115

/datum/intent/spear/thrust/eaglebeak
	penfactor = 20
	damfactor = 0.9

/datum/intent/mace/smash/eaglebeak
	reach = 2
	swingdelay = 12
	clickcd = 14

// BRONZE SPEARS
// Design goal: Bronze on par with Iron integrity wise, with low defense. However, it has high AP.

/obj/item/rogueweapon/spear/bronze
	name = "Bronze Spear"
	desc = "A spear forged of bronze. Expensive but more durable than a regular iron one."
	icon_state = "bronzespear"
	max_blade_int = 100
	possible_item_intents = list(/datum/intent/spear/thrust/bronze, SPEAR_BASH) // Bash is for non-lethal takedowns, aim for the limbs for best effect. (Or aim for a lucky knockout to the head)
	smeltresult = /obj/item/ingot/bronze
	force = 20
	force_wielded = 25
	gripsprite = FALSE /// TODO: Make a grip sprite for the bronze spear.
	wdefense = 2

/datum/intent/spear/thrust/bronze
	penfactor = 60

/obj/item/rogueweapon/greatsword
	force = 12
	force_wielded = 30
	throwforce = 20
	throw_range = 3
	throw_speed = 0.5
	possible_item_intents = list(/datum/intent/sword/chop/onehanded, /datum/intent/sword/strike/onehanded) // Strike is for non-lethal takedowns, aim for the limbs for best effect. (Or aim for a lucky knockout to the head)
	gripped_intents = list(/datum/intent/sword/cut/zwei, /datum/intent/sword/thrust/zwei, /datum/intent/sword/strike, /datum/intent/sword/chop)
	name = "greatsword"
	desc = "Might be able to chop anything in half! \ It is made of sturdy steel."
	icon_state = "gsw"
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 9
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/swords
	max_blade_int = 300
	wdefense = 5

/datum/intent/sword/cut/zwei
	reach = 2

/datum/intent/sword/thrust/zwei
	reach = 2

/obj/item/rogueweapon/greatsword/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/greatsword/zwei
	name = "zweihander"
	desc = "This is much longer than a common greatsword, and well balanced too! \ It is made of iron."
	icon_state = "zwei"
	smeltresult = /obj/item/ingot/iron
	max_blade_int = 200 // Less because it's made of iron.
	wdefense = 4

/obj/item/rogueweapon/estoc
	name = "estoc"
	desc = "A sword possessed of a quite long and tapered blade that is intended to be thrust between the \
	gaps in an opponent's armor. The hilt is wrapped tight in black leather. \ It is made of sturdy steel."
	icon_state = "estoc"
	force = 14
	force_wielded = 25
	throwforce = 20
	throw_range = 3
	throw_speed = 0.5
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	possible_item_intents = list(/datum/intent/sword/strike/onehanded, /datum/intent/sword/thrust/onehanded)
	gripped_intents = list(/datum/intent/sword/thrust/estoc, /datum/intent/sword/lunge, /datum/intent/sword/estoc_halfsword, /datum/intent/sword/strike)
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 8
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/swords
	max_integrity = 235
	max_blade_int = 300
	wdefense = 5.5

/datum/intent/sword/thrust/estoc
    name = "thrust"
    penfactor = 60
    recovery = 10 /// Notice: It isn't coded fully, does nothing as a result, can be found in intents.dm
    clickcd = 11

/datum/intent/sword/lunge
    name = "lunge"
    icon_state = "inimpale"
    attack_verb = list("lunges")
    animname = "stab"
    blade_class = BCLASS_STAB
    hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
    penfactor = 40
    damfactor = 1.3
    chargetime = 10
    recovery = 20 /// Notice: It isn't coded fully, does nothing as a result, can be found in intents.dm
    clickcd = 8

/datum/intent/sword/estoc_halfsword
    name = "half-sword"
    icon_state = "inpick"
    attack_verb = list("picks", "impales")
    animname = "strike"
    blade_class = BCLASS_STAB
    hitsound = list('sound/combat/hits/pick/genpick (1).ogg', 'sound/combat/hits/pick/genpick (2).ogg')
    penfactor = 60
    damfactor = 1.2
    clickcd = 15
    swingdelay = 10

/obj/item/rogueweapon/estoc/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list(
					"shrink" = 0.6,
					"sx" = -6,
					"sy" = 7,
					"nx" = 6,
					"ny" = 8,
					"wx" = 0,
					"wy" = 6,
					"ex" = -1,
					"ey" = 8,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 0,
					"nturn" = -50,
					"sturn" = 40,
					"wturn" = 50,
					"eturn" = -50,
					"nflip" = 0,
					"sflip" = 8,
					"wflip" = 8,
					"eflip" = 0,
					)
			if("wielded")
				return list(
					"shrink" = 0.6,
					"sx" = 3,
					"sy" = 5,
					"nx" = -3,
					"ny" = 5,
					"wx" = -9,
					"wy" = 4,
					"ex" = 9,
					"ey" = 1,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 0,
					"nturn" = 0,
					"sturn" = 0,
					"wturn" = 0,
					"eturn" = 15,
					"nflip" = 8,
					"sflip" = 0,
					"wflip" = 8,
					"eflip" = 0,
					)
