/datum/advclass/mercenary/atgervi
	name = "Atgervi"
	tutorial = "Fear. What more can you feel when a stranger tears apart your friend with naught but hand and maw? What more can you feel when your warriors fail to slay an invader? What more could you ask for, when hiring a mercenary?"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/atgervi
	category_tags = list(CTAG_MERCENARY)
	cmode_music = 'sound/music/combat_gronn.ogg'
	traits_applied = list(TRAIT_OUTLANDER)

/datum/outfit/job/roguetown/mercenary/atgervi
	allowed_patrons = ALL_INHUMEN_PATRONS

/datum/outfit/job/roguetown/mercenary/atgervi/pre_equip(mob/living/carbon/human/H)
	..()

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Varangian","Shaman")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Varangian")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a Varangian of the Gronn Highlands. Warrior-Traders whose exploits into the Zybantine Empire will be forever remembered by historians."))
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)	
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)	

			H.change_stat("strength", 2)	
			H.change_stat("endurance", 3)
			H.change_stat("constitution", 3)
			H.change_stat("perception", 1)
			H.change_stat("speed", -2)	

			head = /obj/item/clothing/head/roguetown/helmet/bascinet/atgervi
			gloves = /obj/item/clothing/gloves/roguetown/angle/atgervi
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/atgervi
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			pants = /obj/item/clothing/under/roguetown/trou/leather/atgervi
			wrists = /obj/item/clothing/wrists/roguetown/bracers
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather/atgervi
			backr = /obj/item/rogueweapon/shield/atgervi
			backl = /obj/item/storage/backpack/rogue/satchel/black
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel/atgervi
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/flashlight/flare/torch

			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)	
		if("Shaman")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a Shaman of the Northern Empty. Savage combatants who commune with their gods through gut-wrenching violence, rather than idle prayer."))
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)

			H.change_stat("strength", 3) 
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 2)
			H.change_stat("speed", 1)

			head = /obj/item/clothing/head/roguetown/helmet/leather/saiga/atgervi
			gloves = /obj/item/clothing/gloves/roguetown/plate/atgervi
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/atgervi
			pants = /obj/item/clothing/under/roguetown/trou/leather/atgervi
			wrists = /obj/item/clothing/wrists/roguetown/bracers
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather/atgervi
			backr = /obj/item/storage/backpack/rogue/satchel/black
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/flashlight/flare/torch

			ADD_TRAIT(H, TRAIT_STRONGBITE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC) //No weapons. Just beating them to death as God intended.
			ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC) //Their entire purpose is to rip people apart with their hands and teeth. I don't think they'd be too preturbed to see someone lose a limb.
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC) //Either no armor, or light armor.
	backpack_contents = list(/obj/item/roguekey/mercenary, /obj/item/rogueweapon/huntingknife)


/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/atgervi
	name = "Vagarian hauberk"
	desc = "The pride of the Hammerhold mercenaries a well crafted blend of chain and leather into a dense protective coat."
	icon_state = "atgervi_raider_mail"
	item_state = "atgervi_raider_mail"

/obj/item/clothing/suit/roguetown/armor/leather/heavy/atgervi
	name = "Shamanic coat"
	desc = "A lightly protective coat, It embodies the second trial of the Northern shamans. To honor the leopard is too desire for more."
	icon_state = "atgervi_shaman_coat"
	item_state = "atgervi_shaman_coat"

/obj/item/clothing/under/roguetown/trou/leather/atgervi
	name = "fur pants"
	desc = "Thick fur pants made to endure the coldest winds, offering a share of protection from fang and claw of beast or men alike."
	icon_state = "atgervi_pants"
	item_state = "atgervi_pants"
	
/obj/item/clothing/gloves/roguetown/angle/atgervi
	name = "fur-lined leather gloves"
	desc = "Thick, padded gloves made for the harshest of climates, and wildest of beasts encountered in the untamed lands."
	icon_state = "atgervi_raider_gloves"
	item_state = "atgervi_raider_gloves"

/obj/item/clothing/gloves/roguetown/plate/atgervi
	name = "Beast claws"
	desc = "A menacing pair of plated claws, A closely protected tradition of the Shamans. The four claws embodying the four great beasts. Decorated with symbols of the gods they praise and the Gods they reject."
	icon_state = "atgervi_shaman_gloves"
	item_state = "atergvi_shaman_gloves"

/obj/item/clothing/head/roguetown/helmet/bascinet/atgervi
	name = "Owl helmet"
	desc = "A carefully forged steel helmet in the shape of an owl's face, with added chain to cover the face and neck against many blows."
	icon_state = "atgervi_raider"
	item_state = "atgervi_raider"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/32x48/atgervi.dmi'
	worn_x_dimension = 32
	worn_y_dimension = 48

/obj/item/clothing/head/roguetown/helmet/leather/saiga/atgervi
	name = "moose hood"
	desc = "A deceptively strong hood of hide with a pair of large heavy antlers. It is the fourth and final trial of the Shamans, To slay a Grinning moose with naught but metal claw and teeth."
	icon_state = "atgervi_shaman"
	item_state = "atgervi_shaman"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/32x48/atgervi.dmi'
	flags_inv = HIDEEARS
	worn_x_dimension = 32
	worn_y_dimension = 48

/obj/item/clothing/shoes/roguetown/boots/leather/atgervi
	name = "heavy leather boots"
	desc = "A pair of strong leather boots, designed to endure battle and the chill of the north both."
	icon_state = "atgervi_boots"
	item_state = "atgervi_boots"

/obj/item/rogueweapon/shield/atgervi
	name = "kite shield"
	desc = "A large but light wooden shield with a steel boss in the center to deflect blows more easily."
	icon_state = "atgervi_shield"
	item_state = "atgervi_shield"
	lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
	force = 15
	throwforce = 10
	dropshrink = 0.8
	coverage = 60
	attacked_sound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	parrysound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	max_integrity = 250

/obj/item/rogueweapon/shield/atgervi/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/rogueweapon/stoneaxe/woodcut/steel/atgervi
	name = "Bearded Axe"
	desc = "A large axe easily wielded in one hand or two, With a large hooked axehead to tearing into flesh and armor and ripping it away brutally."
	icon_state = "atgervi_axe"
	item_state = "atgervi_axe"
	lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
	wlength = WLENGTH_LONG
