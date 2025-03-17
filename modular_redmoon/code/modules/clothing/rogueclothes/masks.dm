/obj/item/clothing/mask/rogue/woodspectacles
	name = "Wooden spectacles"
	desc = "Glasses made of wood will suit poor people or ascetic individuals."
	icon = 'modular_redmoon/icons/masks.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/masks_onmob.dmi'
	icon_state = "woodglasses"
	break_sound = "glassbreak"
	attacked_sound = 'sound/combat/hits/onglass/glasshit.ogg'
	max_integrity = 20
	integrity_failure = 0.5
	resistance_flags = FIRE_PROOF
	body_parts_covered = EYES
	anvilrepair = /datum/skill/craft/blacksmithing
//	block2add = FOV_BEHIND

/obj/item/clothing/mask/rogue/woodspectacles/Crossed(mob/crosser)
	if(isliving(crosser) && !obj_broken)
		take_damage(11, BRUTE, "blunt", 1)
	..()
