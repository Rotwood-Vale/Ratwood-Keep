// Barbarian
/obj/effect/proc_holder/spell/invoked/barbarian_rage
	name = "Rage"
	desc = "Fly into a rage increasing your physical stats."
	range = 1
	overlay_state = "null"
	releasedrain = 30
	cast_without_targets = TRUE
	charge_max = 60 SECONDS
	movement_interrupt = FALSE
	sound = 'sound/vo/male/warrior/rage (3).ogg' //change for gender later or do warcry which I don't know how to do rn.
	associated_skill = /datum/skill/magic/druidic
	invocation = "RAAAAAAAAAAAAAA!!"
	miracle = FALSE
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/barbarian_rage/cast(list/targets, mob/user)
	if(user && user.mind)
		var/mob/living/target = user
		user.visible_message("<span class='info'>[user]'s muscles tense up beyond imagination.</span>", "<span class='notice'>My muscles tense up beyond imagination.</span>")
		user.add_stress(/datum/stressevent/barbarian_rage)
		target.apply_status_effect(/datum/status_effect/buff/barbarian_rage)
		ADD_TRAIT(target, TRAIT_NOPAIN, TRAIT_GENERIC)
		return TRUE
	return FALSE

/datum/status_effect/buff/barbarian_rage
	id = "barbarian rage"
	alert_type = /atom/movable/screen/alert/status_effect/buff/barbarian_rage
	effectedstats = list("speed" = 2, "endurance" = 2, "strength" = 4)
	duration = 45 SECONDS

/atom/movable/screen/alert/status_effect/buff/barbarian_rage
	name = "Rage"
	desc = "Rage fills my heart and my muscles."
	icon_state = "buff"

/datum/status_effect/buff/barbarian_rage/on_remove()
	var/mob/living/carbon/M = owner
	var/mob/living/target = owner
	M.rogfat_add(100)
	M.rogstam_add(100)
	target.adjustOxyLoss(50)
	target.visible_message("<span class='info'>[owner]'s rage subsides.</span>", "<span class='notice'>My rage subsides.</span>")
	target.apply_status_effect(/datum/status_effect/debuff/trainsleep)
	REMOVE_TRAIT(target, TRAIT_NOPAIN, TRAIT_GENERIC)
	. = ..()

/datum/stressevent/barbarian_rage
	timer = 10 MINUTES
	stressadd = 8
	max_stacks = 10 //don't rage spam or you WILL have a heart attack

//claws for the ravager
/obj/effect/proc_holder/spell/self/rav_claws
	name = "Ravager Claws"
	desc = "!"
	overlay_state = "claws"
	antimagic_allowed = TRUE
	charge_max = 20 //2 seconds
	var/extended = FALSE

/obj/effect/proc_holder/spell/self/rav_claws/cast(mob/user = usr)
	..()
	var/obj/item/rogueweapon/rav_claw/left/l
	var/obj/item/rogueweapon/rav_claw/right/r

	l = user.get_active_held_item()
	r = user.get_inactive_held_item()
	if(extended)
		if(istype(user.get_active_held_item(), /obj/item/rogueweapon/rav_claw))
			user.dropItemToGround(l, TRUE)
			user.dropItemToGround(r, TRUE)
			user.visible_message("<span class='info'>[user]'s claws retract.</span>", "<span class='notice'>Claws retract back into [user]'s hands.</span>")
			extended = FALSE
	else
		l = new(user,1)
		r = new(user,2)
		user.put_in_hands(l, TRUE, FALSE, TRUE)
		user.put_in_hands(r, TRUE, FALSE, TRUE)
		user.visible_message("<span class='info'>[user]'s claws extend.</span>", "<span class='notice'>Claws extend from [user]'s hands.</span>")
		extended = TRUE
	
/obj/item/rogueweapon/rav_claw //this is essentially a hunting knife that uses unarmed. Not that op
	name = "Claw"
	desc = ""
	item_state = null
	lefthand_file = null
	righthand_file = null
	icon = 'icons/roguetown/weapons/32.dmi'
	max_blade_int = 900
	max_integrity = 900
	force = 12
	block_chance = 0
	wdefense = 3
	armor_penetration = 8
	associated_skill = /datum/skill/combat/unarmed
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	can_parry = TRUE
	sharpness = IS_SHARP
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_MED
	possible_item_intents = list(/datum/intent/simple/werewolf)
	parrysound = list('sound/combat/parry/parrygen.ogg')
	embedding = list("embedded_pain_multiplier" = 0, "embed_chance" = 0, "embedded_fall_chance" = 0)
	item_flags = DROPDEL

/obj/item/rogueweapon/rav_claw/right
	icon_state = "claw_r"

/obj/item/rogueweapon/rav_claw/left
	icon_state = "claw_l"
