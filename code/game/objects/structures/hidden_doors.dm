//HIDDENDOOR
/obj/structure/mineral_door/secret
	name = "wall"
	desc = ""
	icon_state = "woodhandle" //change me
	openSound = 'sound/foley/doors/creak.ogg'
	closeSound = 'sound/foley/doors/shut.ogg'
	sheetType = null
	resistance_flags = FLAMMABLE
	max_integrity = 9999
	damage_deflection = 30
	layer = ABOVE_MOB_LAYER
	keylock = FALSE
	locked = TRUE
	icon = 'icons/roguetown/misc/doors.dmi'
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	flags_1 = HEAR_1
	var/over_state = "woodover"

	var/speaking_distance = 2
	var/open_phrase = "open sesame"
	var/close_phrase = "close sesame"
	var/language = null
	var/list/vip

/obj/structure/mineral_door/secret/vault
	vip = list("King", "Queen", "Steward", "Hand")

/obj/structure/mineral_door/secret/merchant
	vip = list("Merchant", "Shop Hand")

/obj/structure/mineral_door/secret/wizard //for wizard tower
	vip = list("Court Magician", "Magicians Apprentice")
	//make me look like an arcane door

/obj/structure/mineral_door/secret/rogue //for seedy sewer bar / black market?
	vip = list("Vagabond", "Thug", "Rogue", "Nightmaster", "Nightmistress")
	//make me look like a wall

/obj/structure/mineral_door/secret/Initialize()
	//set password
	open_phrase = open_word() + " " + magic_word()
	close_phrase = close_word() + " " + magic_word()
	. = ..()

/obj/structure/mineral_door/secret/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	var/mob/living/carbon/human/H = speaker
	if(speaker == src) //door speaking to itself
		return
	var/distance = get_dist(speaker, src)
	if(distance > speaking_distance)
		return
	if(obj_broken) //door is broken
		return
	if(!ishuman(speaker))
		return
	
	var/message2recognize = sanitize_hear_message(original_message)

	if(findtext(message2recognize, open_phrase))
		if(locked)
			locked = FALSE
			force_open()
			say("The way is now open, "+flavor_name()+".")

	if(findtext(message2recognize, close_phrase))
		if(!locked)
			force_closed()
			locked = TRUE
			say("The way is now closed, "+flavor_name()+".")

	if(findtext(message2recognize, "say phrases"))
		if(vip.Find(H.job) || vip.Find(H.get_role_title()))
			say("Open: [open_phrase], Close: [close_phrase].")
		else
			say("I don't know you, "+flavor_name()+".")

	if(findtext(message2recognize, "help"))
		if(!locked)
			say("My commands are: Set Open, Set Close, Say Phrases")
		else
			say("Unlock me for help, "+flavor_name()+".")

	if(findtext(message2recognize, "set open"))
		if(!locked)
			var/new_pass = stripped_input(H, "What should the new open phrase be?")
			open_phrase = new_pass
			say("Open phrase has been set, "+flavor_name()+".")
		

	if(findtext(message2recognize, "set close"))
		if(!locked)
			var/new_pass = stripped_input(H, "What should the new close phrase be?")
			close_phrase = new_pass
			say("Close phrase has been set, "+flavor_name()+".")
	
proc/open_word()
	var/list/open_word = list(
		"open", 
		"pass", 
		"part", 
		"break", 
		"reveal", 
		"unbar", 
		"gape", 
		"extend", 
		"widen", 
		"unfold", 
		"rise"
		)
	return pick(open_word)

proc/close_word()
	var/list/close_word = list(
		"close", 
		"seal", 
		"still", 
		"fade", 
		"retreat", 
		"consume", 
		"envelope", 
		"hide", 
		"halt", 
		"cease", 
		"vanish", 
		"end" 
		)
	return pick(close_word)

proc/magic_word()
	var/list/magic_word = list(
		"sesame", 
		"abyss", 
		"fire", 
		"wind", 
		"earth", 
		"shadow", 
		"night", 
		"oblivion", 
		"void", 
		"time", 
		"dead", 
		"decay", 
		"gods", 
		"ancient", 
		"twisted", 
		"corrupt", 
		"secrets", 
		"lore", 
		"text", 
		"ritual", 
		"sacrifice", 
		"deal", 
		"pact", 
		"bargain", 
		"ritual", 
		"dream", 
		"nightmare", 
		"vision", 
		"hunger", 
		"lust", 
		"necra", 
		"noc", 
		"psydon", 
		"zizo"
		)
	return pick(magic_word)

proc/flavor_name()
	var/list/flavor_name = list(
		"my friend", 
		"love", 
		"my love", 
		"honey", 
		"darling", 
		"stranger", 
		"habibi", 
		"companion", 
		"mate", 
		"you cunt", 
		"comrade", 
		"fellow", 
		"chum", 
		"dickhead"
		)
	return pick(flavor_name)
