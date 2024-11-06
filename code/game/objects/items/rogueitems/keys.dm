
/obj/item/key
	name = "key"
	desc = "An unremarkable iron key."
	icon_state = "iron"
	icon = 'icons/roguetown/items/keys.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	var/lockhash = 0
	var/lockid = null
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH|ITEM_SLOT_NECK
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/key/Initialize()
	. = ..()
	if(lockid)
		if(GLOB.lockids[lockid])
			lockhash = GLOB.lockids[lockid]
		else
			lockhash = rand(100,999)
			while(lockhash in GLOB.lockhashes)
				lockhash = rand(100,999)
			GLOB.lockhashes += lockhash
			GLOB.lockids[lockid] = lockhash

//custom key
/obj/item/key/custom
	name = "custom key"
	desc = "A custom key designed by a blacksmith."
	icon_state = "brownkey"

/obj/item/key/custom/attackby(obj/item/I, mob/user, params)

	if(!istype(I, /obj/item/rogueweapon/hammer))
		return
	
	var/input = (input(user, "What would you name this key?", "", "") as text)

	if(!input)
		return

	name = input + " key"
	to_chat(user, span_notice("You rename the key to [name]."))

//custom key blank
/obj/item/key_custom_blank//i'd prefer not to make a seperate item for this honestly
	name = "blank custom key"
	desc = "A key without its teeth carved in. Endless possibilities..."
	icon = 'icons/roguetown/items/keys.dmi'
	icon_state = "brownkey"
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	var/lockhash = 0

/obj/item/key_custom_blank/attackby(obj/item/I, mob/user, params)

	if(!istype(I, /obj/item/rogueweapon/hammer))
		return 

	var/input = input(user, "What would you like to set the key ID to?", "", 0) as num

	if(!input)
		return

	input = max(0, input)
	to_chat(user, span_notice("You set the key ID to [input]."))
	lockhash = 10000 + input //having custom lock ids start at 10000 leaves it outside the range that opens normal doors, so you can't make a key that randomly unlocks existing key ids like the church

/obj/item/key_custom_blank/attack_right(mob/user)

	if(istype(user.get_active_held_item(), /obj/item/key))
		var/obj/item/key/held = user.get_active_held_item()
		src.lockhash = held.lockhash
		to_chat(user, span_notice("You trace the teeth from [held] to [src]."))
	else if(istype(user.get_active_held_item(), /obj/item/customlock))
		var/obj/item/customlock/held = user.get_active_held_item()
		src.lockhash = held.lockhash
		to_chat(user, span_notice("You fine-tune [src] to the lock's internals."))
	else if(istype(user.get_active_held_item(), /obj/item/rogueweapon/hammer) && src.lockhash != 0)
		var/obj/item/key/custom/F = new (get_turf(src))
		F.lockhash = src.lockhash
		F.lockid = lockhash
		to_chat(user, span_notice("You finish [F]."))
		qdel(src)


/obj/item/key/lord
	name = "master key"
	desc = "The Lord's key."
	icon_state = "bosskey"
	lockid = "lord"

/obj/item/key/lord/pre_attack(target, user, params)
	. = ..()
	if(istype(target, /obj/structure/closet))
		var/obj/structure/closet/C = target
		if(C.masterkey)
			lockhash = C.lockhash
	if(istype(target, /obj/structure/mineral_door))
		var/obj/structure/mineral_door/D = target
		if(D.masterkey)
			lockhash = D.lockhash

/obj/item/key/royal
	name = "Royal Key"
	desc = "The Key to the royal chambers. It even feels pretentious."
	icon_state = "ekey"
	lockid = "royal"

/obj/item/key/prince_rooms
	name = "Princely Key"
	desc = "The Key to the heirs chambers."
	icon_state = "ekey"
	lockid = "prince"

/obj/item/key/vault
	name = "vault key"
	desc = "This key opens the mighty vault."
	icon_state = "cheesekey"
	lockid = "vault"

/obj/item/key/councillor_rooms
	name = "councillor rooms key"
	desc = "This key opens the councillor's rooms."
	icon_state = "cheesekey"
	lockid = "councillor"

/obj/item/key/merchant
	name = "merchant's key"
	desc = "A merchant's key."
	icon_state = "cheesekey"
	lockid = "merchant"

/obj/item/key/shop
	name = "shop key"
	desc = "This key opens and closes a shop door."
	icon_state = "ekey"
	lockid = "shop"

/obj/item/key/townie // For use in round-start available houses in town. Do not use default lockID.
	name = "town dwelling Key"
	desc = "The key of some townie's home. Hope it's not lost."
	icon_state ="brownkey"
	lockid = "townie"

/obj/item/key/tavern
	name = "tavern key"
	desc = "This key should open and close any tavern door."
	icon_state = "hornkey"
	lockid = "tavern"

/obj/item/key/velder
	name = "elder's key"
	desc = "This key should open and close the elder's home."
	icon_state = "brownkey"
	lockid = "velder"

/obj/item/key/tavern/village
	lockid = "vtavern"

/obj/item/key/roomi/village
	lockid = "vroomi"

/obj/item/key/roomii/village
	lockid = "vroomii"

/obj/item/key/roomiii/village
	lockid = "vroomiii"

/obj/item/key/roomiv/village
	lockid = "vroomiv"

/obj/item/key/roomv/village
	lockid = "vroomv"

/obj/item/key/roomvi/village
	lockid = "vroomvi"

/obj/item/key/roomi
	name = "room I key"
	desc = "The key to the first room."
	icon_state = "brownkey"
	lockid = "roomi"

/obj/item/key/roomii
	name = "room II key"
	desc = "The key to the second room."
	icon_state = "brownkey"
	lockid = "roomii"

/obj/item/key/roomiii
	name = "room III key"
	desc = "The key to the third room."
	icon_state = "brownkey"
	lockid = "roomiii"

/obj/item/key/roomiv
	name = "room IV key"
	desc = "The key to the fourth room."
	icon_state = "brownkey"
	lockid = "roomiv"

/obj/item/key/roomv
	name = "room V key"
	desc = "The key to the fifth room."
	icon_state = "brownkey"
	lockid = "roomv"

/obj/item/key/roomvi
	name = "room VI key"
	desc = "The key to the sixth room."
	icon_state = "brownkey"
	lockid = "roomvi"

/obj/item/key/roomhunt
	name = "room HUNT key"
	desc = "This is the HUNT key!"
	icon_state = "brownkey"
	lockid = "roomhunt"

//vampire mansion//
/obj/item/key/vampire
	name = "mansion key"
	desc = "The key to a vampire lord's castle."
	icon_state = "vampkey"
	lockid = "mansionvampire"
//

/obj/item/key/blacksmith
	name = "blacksmith key"
	desc = "This key opens a blacksmith's workshop."
	icon_state = "brownkey"
	lockid = "blacksmith"

/obj/item/key/blacksmith/town
	name = "town blacksmith key"
	lockid = "townblacksmith"

/obj/item/key/seamster
	name = "workshop key"
	desc = "This key opens the door to the tailor workshop."
	icon_state = "brownkey"
	lockid = "seamster"

/obj/item/key/walls
	name = "walls key"
	desc = "This is a rusty key."
	icon_state = "rustkey"
	lockid = "walls"

/obj/item/key/farm
	name = "farm key"
	desc = "This is a rusty key that'll open farm doors."
	icon_state = "rustkey"
	lockid = "farm"

/obj/item/key/butcher
	name = "butcher key"
	desc = "This is a rusty key that'll open butcher doors."
	icon_state = "rustkey"
	lockid = "butcher"

/obj/item/key/church
	name = "church key"
	desc = "This bronze key should open almost all doors in the church."
	icon_state = "brownkey"
	lockid = "church"

/obj/item/key/priest
	name = "priest's key"
	desc = "This is the master key of the church."
	icon_state = "cheesekey"
	lockid = "priest"

/obj/item/key/tower
	name = "tower key"
	desc = "This key should open anything within the tower."
	icon_state = "greenkey"
	lockid = "tower"

/obj/item/key/mage
	name = "magicians's key"
	desc = "This is the court wizard's key. It watches you..."
	icon_state = "eyekey"
	lockid = "mage"

/obj/item/key/graveyard
	name = "crypt key"
	desc = "This rusty key belongs to the gravekeeper."
	icon_state = "rustkey"
	lockid = "graveyard"

/obj/item/key/artificer
	name = "artificer's key"
	desc = "This bronze key should open the Artificer's guild."
	icon_state = "brownkey"
	lockid = "artificer"

/obj/item/key/nightman
	name = "nightmaster's key"
	desc = "This regal key opens a few doors within the castle."
	icon_state = "greenkey"
	lockid = "nightman"

/obj/item/key/nightmaiden
	name = "nightmaiden's key"
	desc = "This regal key opens a few doors within the castle."
	icon_state = "brownkey"
	lockid = "nightmaiden"

/obj/item/key/mercenary
	name = "mercenary key"
	desc = "Why, a mercenary would not kick doors down."
	icon_state = "greenkey"
	lockid = "merc"

/obj/item/key/mercenary_boss
	name = "mercenary captain key"
	desc = "Why, a mercenary would not kick doors down."
	icon_state = "greenkey"
	lockid = "merc_boss"

/obj/item/key/physician
	name = "physician key"
	desc = "The key smells of herbs, feeling soothing to the touch."
	icon_state = "greenkey"
	lockid = "physician"

/obj/item/key/puritan
	name = "puritan's key"
	desc = "This is an intricate key." // i have no idea what is this key about
	icon_state = "mazekey"
	lockid = "puritan"

/obj/item/key/confession
	name = "confessional key"
	desc = "This key opens the doors of the confessional."
	icon_state = "brownkey"
	lockid = "confession"

/obj/item/key/hand
	name = "hand's key"
	desc = "This regal key belongs to the Duke's Right Hand."
	icon_state = "cheesekey"
	lockid = "hand"

/obj/item/key/steward
	name = "steward's key"
	desc = "This key belongs to the court's greedy steward."
	icon_state = "cheesekey"
	lockid = "steward"

/obj/item/key/archive
	name = "archive key"
	desc = "This key looks barely used."
	icon_state = "ekey"
	lockid = "archive"

/obj/item/key/manor
	name = "manor key"
	desc = "This key will open any manor doors."
	icon_state = "mazekey"
	lockid = "manor"

/obj/item/key/bog_gatehouse
	name = "bog gatehouse key"
	desc = "This key opens the bog gatehouse."
	icon_state = "spikekey"
	lockid = "bog_gatehouse"

/obj/item/key/bog_barracks
	name = "bog barracks key"
	desc = "This key opens the bog barracks."
	icon_state = "spikekey"
	lockid = "bog_barracks"

/obj/item/key/bog_dungeon
	name = "bog dungeon key"
	desc = "This key opens the bog dungeon."
	icon_state = "spikekey"
	lockid = "bog_dungeon"

/obj/item/key/bog_armory
	name = "bog armory key"
	desc = "This key opens the bog armory."
	icon_state = "spikekey"
	lockid = "bog_armory"

/obj/item/key/town_barracks
	name = "town barracks key"
	desc = "This key opens the town barracks."
	icon_state = "spikekey"
	lockid = "town_barracks"

/obj/item/key/town_dungeon
	name = "town dungeon key"
	desc = "This key opens the town dungeon."
	icon_state = "spikekey"
	lockid = "town_dungeon"

/obj/item/key/town_armory
	name = "town armory key"
	desc = "This key opens the town armory."
	icon_state = "spikekey"
	lockid = "town_armory"

/obj/item/key/sheriff_office
	name = "sheriff's office key"
	desc = "This key opens the sheriff's office."
	icon_state = "spikekey"
	lockid = "sheriff_office"

/obj/item/key/keep_gatehouse
	name = "keep gatehouse key"
	desc = "This key opens the keep gatehouse."
	icon_state = "spikekey"
	lockid = "keep_gatehouse"

/obj/item/key/keep_barracks
	name = "keep barracks key"
	desc = "This key opens the keep barracks."
	icon_state = "spikekey"
	lockid = "keep_barracks"

/obj/item/key/keep_dungeon
	name = "keep dungeon key"
	desc = "This key opens the keep dungeon."
	icon_state = "spikekey"
	lockid = "keep_dungeon"

/obj/item/key/keep_dungeon_torture
	name = "keep dungeon torture room key"
	desc = "This key opens the keep dungeon torture room."
	icon_state = "spikekey"
	lockid = "keep_dungeon_torture"

/obj/item/key/keep_armory
	name = "keep armory key"
	desc = "This key opens the keep armory."
	icon_state = "spikekey"
	lockid = "keep_armory"

//grenchensnacker
/obj/item/key/porta
	name = "strange key"
	desc = "Was this key enchanted by a wizard locksmith...?"//what is grenchensnacker.
	icon_state = "eyekey"
	lockid = "porta"

// Towner homes keys
