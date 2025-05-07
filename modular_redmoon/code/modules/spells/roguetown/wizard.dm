/obj/effect/proc_holder/spell/invoked/global_message
	name = "Global Message"
	desc = "Latch onto the mind of one who is familiar to you, whispering a message into their head."
	cost = 6
	xp_gain = TRUE
	releasedrain = 30
	chargedrain = 1
	chargetime = 15 SECONDS
	charge_max = 60 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "message"

/obj/effect/proc_holder/spell/invoked/global_message/cast(list/targets, mob/user)
	. = ..()
	var/inputty = input("Make an announcement", "ROGUETOWN") as text|null
	if(!inputty)
		return
	if(inputty)
		priority_announce("[inputty]", title = "The Magician Speaks", sound = 'sound/misc/surrender.ogg')
	else
		revert_cast()
/obj/effect/proc_holder/spell/targeted/lightninglure
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "lure"
/obj/effect/proc_holder/spell/invoked/projectile/frostbolt
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "frostbolt"
/obj/effect/proc_holder/spell/invoked/findfamiliar
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "familiar"
/obj/effect/proc_holder/spell/invoked/mending
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "mend"
/obj/effect/proc_holder/spell/invoked/sundering_lightning
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "lightning"
/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "lightningbolt"
/obj/effect/proc_holder/spell/invoked/haste
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "haste"
/obj/effect/proc_holder/spell/invoked/meteor_storm
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "meteorstorm"
/obj/effect/proc_holder/spell/targeted/touch/darkvision
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "darkvision"
/obj/effect/proc_holder/spell/targeted/summonweapon
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "summonweapon"
/obj/effect/proc_holder/spell/invoked/projectile/repel
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "repel"
/obj/effect/proc_holder/spell/targeted/touch/nondetection
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "nondetection"
/obj/effect/proc_holder/spell/invoked/push_spell
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "repulsewiz"
/obj/effect/proc_holder/spell/invoked/enlarge
	action_icon = 'modular_redmoon/icons/redmoon_spells/redmoonspells.dmi'
	overlay_state = "enlarge"
/obj/projectile/magic/frostbolt
	range = 20
	speed = 3 
/obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe
	charge_max = 40 SECONDS
	duration = 10 SECONDS
/obj/effect/temp_visual/slowdown_spell_aoe/long
	duration = 10 SECONDS
/obj/effect/proc_holder/spell/invoked/mageblindness
	charge_max = 30 SECONDS
