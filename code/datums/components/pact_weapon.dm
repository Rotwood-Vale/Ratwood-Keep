/datum/component/pact_weapon
	var/obj/item/rogueweapon/weapon
	var/mob/living/weapon_owner //who owns this pact weapon
	var/patronchoice
	var/weapons = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel //dagger
		/obj/item/rogueweapon/estoc, /obj/item/rogueweapon/sword/long, /obj/item/rogueweapon/sword/sabre, /obj/item/rogueweapon/greatsword, //sword
		/obj/item/rogueweapon/mace/steel, /obj/item/rogueweapon/mace/goden/steel, //blunt
		/obj/item/rogueweapon/stoneaxe/woodcut/steel, /obj/item/rogueweapon/stoneaxe/battle, //axes
		/obj/item/rogueweapon/whip, /obj/item/rogueweapon/flail/sflail, //flails
		/obj/item/rogueweapon/spear, /obj/item/rogueweapon/halberd, /obj/item/rogueweapon/eaglebeak,//polearms
		)

/datum/component/pact_weapon/Initialize(mob/living/L, pc)
	if(!istype(parent, /obj/item/rogueweapon))
		return COMPONENT_INCOMPATIBLE
	else
		patronchoice = pc
		weapon_owner = L
		weapon = parent
		weapon.name += " of the [patronchoice]"
		weapon.desc += " It is enchanted to use arcane skill rather than its regular skill. Right click with an empty hand to change this weapon's form."
		weapon.force *= 1.2
		weapon.max_blade_int *= 1.2
		weapon.blade_int = weapon.max_blade_int
		weapon.max_integrity *= 1.2
		weapon.obj_integrity = weapon.max_integrity
		weapon.minstr = 1
		weapon.associated_skill = /datum/skill/magic/arcane
		//var/mutable_appearance/magic_overlay = mutable_appearance('icons/effects/effects.dmi', "electricity")
		//item.add_overlay(magic_overlay)

/datum/component/pact_weapon/RegisterWithParent()
	if(istype(parent, /obj/item/rogueweapon))
		RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND_RIGHT, PROC_REF(attack_right))
		RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(equipped))
		RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(dropped))

/datum/component/pact_weapon/proc/attack_right(obj/item/source, mob/user)
	var/mob/living/target = user
	if(target == weapon_owner)
		var/obj/item/rogueweapon/weaponchoice = input("Choose your pact weapon", "Available weapons") as anything in weapons
		var/obj/item/item
		item = new weaponchoice
		item.AddComponent(/datum/component/pact_weapon, weapon_owner, patronchoice)
		item.AddComponent(/datum/component/singing_item, parent.GetComponent(/datum/component/singing_item).weapon_owner, parent.GetComponent(/datum/component/singing_item).personality)
		var/datum/mind/soul_to_bind = null
		if(parent.GetComponent(/datum/component/spirit_holding).bound_spirit)
			soul_to_bind = parent.GetComponent(/datum/component/spirit_holding).bound_spirit.mind
		item.AddComponent(/datum/component/spirit_holding, soul_to_bind, target)
		weapon_owner.put_in_hands(item, FALSE)
		qdel(parent)
	else
		to_chat(weapon_owner, span_warning("[target] tried to activate [weapon]!"))
		weapon.say("You are not my master...")

/datum/component/pact_weapon/proc/equipped(obj/item/source, mob/user, slot)
	var/mob/living/target = user
	if(target != weapon_owner) //you dont own the weapon
		to_chat(weapon_owner, span_warning("[target] has equipped [weapon]!")) //message the rightful owner
		to_chat(target, span_warning("[weapon] burns you as you equip it!")) //message the wielder
		target.apply_status_effect(/datum/status_effect/buff/pact_weapon_debuff) //apply debuff to wielder

/datum/component/pact_weapon/proc/dropped(obj/item/source, mob/user)
	var/mob/living/target = user
	if(target != weapon_owner) //you dont own the weapon
		target.remove_status_effect(/datum/status_effect/buff/pact_weapon_debuff) //remove the debuff

/datum/status_effect/buff/pact_weapon_debuff
	id = "pact weapon debuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/pact_weapon_debuff
	duration = -1

/datum/status_effect/buff/pact_weapon_debuff/tick()
	var/mob/living/target = owner
	var/prompt = pick(1,2,3,4,5)
	if(prompt == 1)
		target.adjustFireLoss(5)
		to_chat(target, span_warning("I am burned by an item I have equipped!"))
		owner.playsound_local(get_turf(owner), 'sound/combat/hits/burn (1).ogg', 35, FALSE, pressure_affected = FALSE)

/atom/movable/screen/alert/status_effect/buff/pact_weapon_debuff
	name = "Cursed Item"
	desc = "An item I have equipped burns me periodically."
	icon_state = "debuff"
