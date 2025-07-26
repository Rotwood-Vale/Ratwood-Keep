////click cooldowns, in tenths of a second, used for various combat actions
//#define CLICK_CD_EXHAUSTED 35
//#define CLICK_CD_MELEE 12
//#define CLICK_CD_RANGE 4
//#define CLICK_CD_RAPID 2

/datum/intent
	var/name = "intent" // The name of the intent, be it cut/stab/thrust/chop/strike when examined.
	var/desc = "" // Description of the item/intent/object itself when examined.
	var/icon_state = "instrike" // The icon of the intent itself.
	var/list/attack_verb = list("hits", "strikes") // Basically x hits or strikes y with their item.
	var/obj/item/masteritem
	var/mob/living/mastermob
	var/unarmed = FALSE
	var/intent_type
	var/animname = "strike" // The animation type of the attack itself.
	var/blade_class = BCLASS_BLUNT // What type of attack is it?; Is it blunt/slash or stab?
	var/list/hitsound = list('sound/combat/hits/blunt/bluntsmall (1).ogg', 'sound/combat/hits/blunt/bluntsmall (2).ogg')
	var/canparry = TRUE // Can this action be parried?; True = Yes | False = No.
	var/candodge = TRUE // Can this action be dodged?; True = Yes | False = No.
	var/chargetime = 0 		// If above 0, this attack must be charged to reach full damage.
	var/chargedrain = 0		// How much stamina is removed every second when at max charge.
	var/releasedrain = 1 	// Drain when we go off, regardless.
	var/misscost = 1 // Extra drain from missing only, ALSO APPLIED IF ENEMY DODGES
	var/tranged = 0
	var/noaa = FALSE // Turns off auto aiming while also turning off the 'swooshes'.
	var/warnie = "" // Gives a warning message that they are charging up an attack, usually on ranged weapons.
	var/pointer = 'icons/effects/mousemice/human_attack.dmi'
	var/clickcd = CLICK_CD_MELEE // The cd (cool-down) invoked clicking on stuff with this intent.
	var/recovery = 0 // RTD (Probably attacker) unable to move for this duration after an attack without becoming off balance. (Problem this was never coded fully, so it does literally nothing)
	var/list/charge_invocation // List of stuff to say while charging.
	var/no_early_release = FALSE // We can't shoot off early. (Until fully charged no release of this attack)
	var/movement_interrupt = FALSE // We cancel charging when changing mob direction, for concentration spells.
	var/rmb_ranged = FALSE // We execute a proc with the same name when right-clicking at range with no off-hand intent selected.
	var/tshield = FALSE // Probably needed or something. (Don't question it)
	var/datum/looping_sound/chargedloop = null
	var/keep_looping = TRUE
	var/damfactor = 1 // Multiplied by weapon's force for damage. (Example 10 damage on damfactor = 1.1 means 10% which is 11, so, 20 + 10% would be 22, yes damfactor 1.05 is +5% and damfactor 0.9 is -10%)
	var/penfactor = 0 // See armor_penetration. (Or just read this, [rough and partially inaccurate oversimplified explanation] it basically ignores the matching type of damage, be it blunt/slash/stab, for example if they had armor protection to blunt 20, and the thing does 10 raw damage but it has protection 5 to blunt it would deal 5 damage instead, however if penfactor was 4 it would deal 9 damage because it ignores 4 out of 5 of the damage, if it was penfactor -4 it would be 1 damage going through)
	var/item_d_type = "blunt" // Changes the item's attack type ("blunt" - area-pressure attack, "slash" - line-pressure attack, "stab" - point-pressure attack)
	var/charging_slowdown = 0 // The bigger the number the worse the slowdown. (For example war dirt gives a slowdown of 2)
	var/warnoffset = 0
	var/swingdelay = 0 // Swing-delay works in 10 = 1 second, 15 = 1.5 second, 20 = 2 seconds, and so on, and so forth. (This isn't an attack cool-down but a delay before the confirmed attack lands)
	var/no_attack = FALSE // Causes a return in /attack() but still allows to be used in attackby(
	var/reach = 1 // In tiles, how far this weapon can reach; 1 for adjacent, which is default, great length weapons usually have two, the whip on "crack" intent has 3.
	var/miss_text 	// These are for unarmed missing attacks.
	var/miss_sound 	// These are for unarmed missing attacks.
	var/ican_assin = FALSE	// Intent: Can Assassinate - Special flag for backstabbing weapons (Extra small, like daggers)
	var/ican_cdg = FALSE	// Intent: Can Coup de Grace - Special flag for weapons that can be wedged under armor in a fight (short and portable)
	var/ican_grf = FALSE	// Intent: Can Grapplefu - Special flag to denote a weapon capable of being used in grapple combat. They're given flat 80% AP on a grab, and assassin blade class. (Rondel daggers, ideally.)

/datum/intent/Destroy()
	if(chargedloop)
		chargedloop.stop()
	if(mastermob.curplaying == src)
		mastermob.curplaying = null
	return ..()

/datum/intent/proc/examine(mob/user)
	var/list/inspec = list("----------------------")
	inspec += "<br><span class='notice'><b>[name]</b> intent</span>"
	if(desc)
		inspec += "\n[desc]"
	if(reach != 1)
		inspec += "\n<b>Reach:</b> [reach]"
	if(damfactor != 1)
		inspec += "\n<b>Damage:</b> [damfactor]"
	if(penfactor)
		inspec += "\n<b>Armor Penetration:</b> [penfactor]"
	if(get_chargetime())
		inspec += "\n<b>Charge Time</b>"
	if(movement_interrupt)
		inspec += "\n<b>Interrupted by Movement</b>"
	if(no_early_release)
		inspec += "\n<b>No Early Release</b>"
	if(chargedrain)
		inspec += "\n<b>Drain While Charged:</b> [chargedrain]"
	if(releasedrain)
		inspec += "\n<b>Drain On Release:</b> [releasedrain]"
	if(misscost)
		inspec += "\n<b>Drain On Miss:</b> [misscost]"
	if(clickcd != CLICK_CD_MELEE)
		inspec += "\n<b>Recovery Time:</b> "
		if(clickcd < CLICK_CD_MELEE)
			inspec += "Quick"
		if(clickcd > CLICK_CD_MELEE)
			inspec += "Slow"

	inspec += "<br>----------------------"

	to_chat(user, "[inspec.Join()]")

/datum/intent/proc/get_chargetime()
	if(chargetime)
		return chargetime
	else
		return 0

/datum/intent/proc/get_chargedrain()
	if(chargedrain)
		return chargedrain
	else
		return 0

/datum/intent/proc/get_releasedrain()
	if(releasedrain)
		return releasedrain
	else
		return 0

/datum/intent/proc/parrytime()
	return 0

/datum/intent/proc/prewarning()
	return

/datum/intent/proc/rmb_ranged(atom/target, mob/user)
	return

/datum/intent/proc/can_charge()
	return TRUE

/datum/intent/proc/afterchange()
	if(masteritem)
		masteritem.d_type = item_d_type
		var/list/benis = hitsound
		if(benis)
			masteritem.hitsound = benis
	return

/datum/intent/proc/height2limb(height as num)
	var/list/returned
	switch(height)
		if(2)
			returned += list(BODY_ZONE_HEAD)
		if(1)
			returned += list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_CHEST)
		if(0)
			returned += list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	return returned

/datum/intent/New(Mastermob, Masteritem)
	..()
	if(Mastermob)
		if(isliving(Mastermob))
			mastermob = Mastermob
			if(chargedloop)
				update_chargeloop()
	if(Masteritem)
		masteritem = Masteritem

/datum/intent/proc/update_chargeloop() // Wonder what this does.
	if(mastermob)
		if(chargedloop)
			if(!istype(chargedloop))
				chargedloop = new chargedloop(mastermob)

/datum/intent/proc/on_charge_start() // Wonder what this does.
	if(mastermob.curplaying)
		mastermob.curplaying.chargedloop.stop()
		mastermob.curplaying = null
	if(chargedloop)
		if(!istype(chargedloop, /datum/looping_sound))
			chargedloop = new chargedloop(mastermob)
		else
			chargedloop.stop()
		chargedloop.start(chargedloop.parent)
		mastermob.curplaying = src

/datum/intent/proc/on_mouse_up()
	if(chargedloop)
		chargedloop.stop()
	if(mastermob.curplaying == src)
		mastermob.curplaying = null

/datum/intent/use
	name = "use"
	icon_state = "inuse"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	canparry = FALSE
	misscost = 0
	no_attack = TRUE
	releasedrain = 0
	blade_class = BCLASS_PUNCH

/datum/intent/kick
	name = "kick"
	candodge = TRUE
	canparry = TRUE
	chargetime = 0
	chargedrain = 0
	noaa = FALSE
	swingdelay = 5
	misscost = 20
	unarmed = TRUE
	animname = "kick"
	pointer = 'icons/effects/mousemice/human_kick.dmi'

/datum/intent/bite
	name = "bite"
	candodge = TRUE
	canparry = TRUE
	chargedrain = 0
	chargetime = 0
	swingdelay = 0
	unarmed = TRUE
	noaa = FALSE
	animname = "bite"
	attack_verb = list("bites")

/datum/intent/jump
	name = "jump"
	candodge = FALSE
	canparry = FALSE
	chargedrain = 0
	chargetime = 0
	noaa = TRUE
	pointer = 'icons/effects/mousemice/human_jump.dmi'

/datum/intent/steal
	name = "steal"
	candodge = FALSE
	canparry = FALSE
	chargedrain = 0
	chargetime = 0
	noaa = TRUE

/datum/intent/give
	name = "give"
	candodge = FALSE
	canparry = FALSE
	chargedrain = 0
	chargetime = 0
	noaa = TRUE
	pointer = 'icons/effects/mousemice/human_give.dmi'

/datum/intent/spell
	name = "spell"
	tranged = 1
	chargedrain = 0
	chargetime = 0
	warnie = "aimwarn"
	warnoffset = 0

/datum/looping_sound/invokegen
	mid_sounds = list('sound/magic/charging.ogg')
	mid_length = 130
	volume = 100
	extra_range = 3

/datum/looping_sound/invokeholy
	mid_sounds = list('sound/magic/holycharging.ogg')
	mid_length = 320
	volume = 100
	extra_range = 3

/datum/looping_sound/flailswing
	mid_sounds = list('sound/combat/wooshes/flail_swing.ogg')
	mid_length = 7
	volume = 100

/datum/looping_sound/drill
	mid_sounds = list('sound/combat/drill_loop.ogg')
	mid_length = 85
	volume = 100

/datum/intent/hit
	name = "hit"
	icon_state = "instrike"
	attack_verb = list("hit", "strike")
	item_d_type = "blunt"
	chargetime = 0
	swingdelay = 0

/datum/intent/stab
	name = "stab"
	icon_state = "instab"
	attack_verb = list("stab")
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	animname = "stab"
	item_d_type = "stab"
	blade_class = BCLASS_STAB
	chargetime = 0
	swingdelay = 0

/datum/intent/pick
	name = "pick"
	icon_state = "inpick"
	attack_verb = list("picks","impales")
	hitsound = list('sound/combat/hits/pick/genpick (1).ogg', 'sound/combat/hits/pick/genpick (2).ogg')
	animname = "strike"
	item_d_type = "stab"
	blade_class = BCLASS_PICK
	chargetime = 0
	swingdelay = 3

/datum/intent/drill
	name = "drill"
	icon_state = "inpick"
	attack_verb = list("drills","augers")
	hitsound = list('sound/combat/hits/pick/genpick (1).ogg', 'sound/combat/hits/pick/genpick (2).ogg')
	animname = "strike"
	item_d_type = "stab"
	blade_class = BCLASS_DRILL
	chargetime = 0.3
	swingdelay = 3

/datum/intent/shoot // Shooting crossbows or other guns, no parry-drain.
	name = "shoot"
	icon_state = "inshoot"
	tranged = 1
	warnie = "aimwarn"
	item_d_type = "stab"
	chargetime = 0.1
	no_early_release = FALSE
	noaa = TRUE
	charging_slowdown = 3
	warnoffset = 20

/datum/intent/shoot/prewarning()
	if(masteritem && mastermob)
		mastermob.visible_message(span_warning("[mastermob] aims [masteritem]!"))

/datum/intent/arc
	name = "arc"
	icon_state = "inarc"
	tranged = 1
	warnie = "aimwarn"
	item_d_type = "blunt"
	chargetime = 0
	no_early_release = FALSE
	noaa = TRUE
	charging_slowdown = 3
	warnoffset = 20

/datum/intent/proc/arc_check()
	return FALSE

/datum/intent/arc/arc_check()
	return TRUE

/datum/intent/arc/prewarning()
	if(masteritem && mastermob)
		mastermob.visible_message(span_warning("[mastermob] aims [masteritem]!"))


/datum/intent/unarmed
	unarmed = TRUE

/datum/intent/unarmed/punch
	name = "punch"
	icon_state = "inpunch"
	attack_verb = list("punches", "jabs", "clocks")
	chargetime = 0
	animname = "blank22"
	hitsound = list('sound/combat/hits/punch/punch (1).ogg', 'sound/combat/hits/punch/punch (2).ogg', 'sound/combat/hits/punch/punch (3).ogg')
	misscost = 5
	releasedrain = 5
	swingdelay = 0
	rmb_ranged = TRUE
	candodge = TRUE
	canparry = TRUE
	blade_class = BCLASS_PUNCH
	miss_text = "swings a fist at the air!"
	miss_sound = "punchwoosh"
	item_d_type = "blunt"

/datum/intent/unarmed/punch/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message(span_warning("[user] taunts [M]!"), span_warning("I taunt [M]!"), ignored_mobs = targetl)
		user.emote("taunt")
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, span_danger("[user] taunts me!"))
		else
			M.taunted(user)
	return

/datum/intent/unarmed/claw
	blade_class = BCLASS_CUT
	item_d_type = "slash"

/datum/intent/unarmed/shove
	name = "shove"
	icon_state = "inshove"
	attack_verb = list("shoves")
	chargetime = 0
	noaa = TRUE
	rmb_ranged = TRUE
	misscost = 5
	item_d_type = "blunt"

/datum/intent/unarmed/shove/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message(span_blue("[user] shoos [M] away."), span_blue("I shoo [M] away."), ignored_mobs = targetl)
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, span_blue("[user] shoos me away."))
		else
			M.shood(user)
	return

/datum/intent/unarmed/grab
	name = "grab"
	icon_state = "ingrab"
	attack_verb = list("grabs")
	chargetime = 0
	noaa = TRUE
	rmb_ranged = TRUE
	releasedrain = 8
	misscost = 6.5
	candodge = TRUE
	canparry = TRUE
	item_d_type = "blunt"

/datum/intent/unarmed/grab/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message(span_green("[user] beckons [M] to come closer."), span_green("I beckon [M] to come closer."), ignored_mobs = targetl)
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, span_green("[user] beckons me to come closer."))
		else
			M.beckoned(user)
	return

/datum/intent/unarmed/help
	name = "touch"
	icon_state = "intouch"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0
	releasedrain = 0
	rmb_ranged = TRUE

/datum/intent/unarmed/help/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message(span_green("[user] waves friendly at [M]."), span_green("I wave friendly at [M]."), ignored_mobs = targetl)
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, span_green("[user] gives me a friendly wave."))
	return

/datum/intent/simple/headbutt
	name = "headbutt"
	icon_state = "instrike"
	attack_verb = list("headbutts", "rams")
	animname = "blank22"
	blade_class = BCLASS_BLUNT
	hitsound = "punch_hard"
	chargetime = 0
	penfactor = 10
	swingdelay = 0
	candodge = TRUE
	canparry = TRUE
	item_d_type = "blunt"

/datum/intent/simple/claw
	name = "claw"
	icon_state = "instrike"
	attack_verb = list("claws", "pecks")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 0
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"
	item_d_type = "slash"

/datum/intent/simple/bite
	name = "bite"
	icon_state = "instrike"
	attack_verb = list("bites")
	noaa = FALSE
	animname = "bite"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 0
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE

/datum/intent/unarmed/claw
	name = "claw"
	icon_state = "instrike"
	attack_verb = list("claws", "tears", "rips")
	animname = "cut"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	penfactor = 20
	candodge = TRUE
	canparry = TRUE
	miss_text = "claws the air!"
	miss_sound = "bluntwooshmed"

/datum/intent/unarmed/wwolf
	name = "claw"
	icon_state = "inchop"
	attack_verb = list("claws", "mauls", "eviscerates")
	animname = "cut"
	blade_class = BCLASS_CHOP
	hitsound = "genslash"
	penfactor = 40
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"
	miss_sound = "bluntwooshlarge"

/datum/intent/unarmed/ascendedclaw
	name = "claw"
	icon_state = "inchop"
	attack_verb = list("claws", "mauls", "eviscerates")
	animname = "cut"
	blade_class = BCLASS_CHOP
	hitsound = "genslash"
	penfactor = 230
	damfactor = 40
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"
	miss_sound = "bluntwooshlarge"

/datum/intent/simple/sting
	name = "sting"
	icon_state = "instrike"
	attack_verb = list("stings")
	animname = "blank22"
	blade_class = BCLASS_STAB
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 1
	swingdelay = 0
	candodge = FALSE
	canparry = FALSE
	miss_text = "stings the air!"

/datum/intent/simple/bigbite
	name = "big bite"
	icon_state = "instrike"
	attack_verb = list("gnashes", "viciously bites")
	animname = "blank22"
	blade_class = BCLASS_CHOP
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 20
	swingdelay = 1
	candodge = TRUE
	canparry = TRUE

/datum/intent/simple/stab
	name = "stab"
	icon_state = "instrike"
	attack_verb = list("impales", "stabs")
	animname = "blank22"
	blade_class = BCLASS_STAB
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 25
	swingdelay = 1
	candodge = TRUE
	canparry = TRUE
	miss_text = "stabs the air!"

// Chicken. (Cluckly cluck)
/datum/intent/simple/peck
	name = "peck"
	icon_state = "instrike"
	attack_verb = list("pecks", "scratches")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 2
	swingdelay = 1
	candodge = TRUE
	canparry = TRUE
	miss_text = "pecks the air!"
