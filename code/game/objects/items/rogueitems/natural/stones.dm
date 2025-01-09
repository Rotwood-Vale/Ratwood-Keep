GLOBAL_LIST_INIT(stone_sharpness_names, list(
	"Sharp",
	"Vicious",
	"Cutthroat",
	"Keen",
	"Acute",
	"Edged",
	"Fierce",
	"Stinging",
))

GLOBAL_LIST_INIT(stone_sharpness_descs, list(
	"It has a vicious edge.",
	"This stone is akin to a knife.",
	"It has a pointed side.",
	"It has a serrated edge.",
))

GLOBAL_LIST_INIT(stone_bluntness_names, list(
	"Blunt",
	"Rotund",
	"Heavy",
	"Solid",
	"Chubby",
	"Portly",
	"Meaty",
	"Dumpy",
	"Stout",
	"Plump",
))

GLOBAL_LIST_INIT(stone_bluntness_descs, list(
	"It is very blunt.",
	"It is kinda hefty.",
	"It fills the hand.",
	"It is quite a handfull",
	"This stone feels like it was made for ME!",
))

GLOBAL_LIST_INIT(stone_magic_names, list(
	"Shimmering",
	"Glowing",
	"Enchanted",
	"Ancient",
	"Mystic",
	"Enhanced",
	"Magic",
	"Mysterious",
	"Radiant",
	"Singing",
	"Beautiful",
	"Tantalizing",
	"Allurring",
	"Wicked",
	"Mythical",
	"Baleful",
	"Heavenly",
	"Angelic",
	"Demonic",
	"Devilish",
	"Mischievous",
))

GLOBAL_LIST_INIT(stone_magic_descs, list(
	"It hums with internal energy.",
	"It has a faint aura.",
	"It has an odd sigil on it.",
	"It has a small red stone pressed into it.",
	"It is covered in tiny cracks.",
	"It looks unsafe.",
))

GLOBAL_LIST_INIT(stone_personalities, list(
	"Hatred",
	"Idiocy",
	"Mourning",
	"Glory",
	"Rock-Solidness",
	"Calmness",
	"Anger",
	"Rage",
	"Vainglory",
	"Risk-aversedness",
	"Daredevil",
	"Barbarics",
	"Fanciness",
	"Relaxing",	
	"Blacked",
	"Greed",
	"Evil",
	"Good",
	"Neutrality",
	"Pride",
	"Lust",
	"Sloth",
	"Victory",
	"Defeat",
	"Recoil",
	"Impact",
	"Goring",
	"Destruction",
	"Hell",
	"Zizo",
	"Flames",
	"Darkness",
	"Light",
	"Heroism",
	"Heaven",
	"Cowards",
	"Conquerors",
	"Conquest",
	"Horripilation",
	"Terror",
	"Earthquakes",
	"Thunder",
))

GLOBAL_LIST_INIT(stone_personality_descs, list(
	"This stone is full of personality!",
	"They say the intelligent races built their foundations with stones.",
	"One must think, where did this stone come from?",
	"If all stones were like this, then they would be some pretty great stones.",
	"I wish my personality was like this stone's...",
	"I could sure do a whole lot with this stone.", 
	"I love stones!",
))

/obj/item/natural/stone
	name = "stone"
	desc = "A piece of rough ground stone."
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	icon_state = "stone1"
	item_state = "stone"
	experimental_inhand = FALSE
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 15
	slot_flags = ITEM_SLOT_MOUTH
	w_class = WEIGHT_CLASS_SMALL
	mill_result = /obj/item/reagent_containers/powder/alch/stone

/obj/item/natural/stone/Initialize()
	. = ..()
	stone_lore()

/*
	This right here is stone lore,
	Yakub from BBC lore has inspired me
*/
/obj/item/natural/stone/proc/stone_lore()
	var/stone_title = "stone" // Our stones title
	var/stone_desc = "[desc]" // Total Bonus desc the stone will be getting

	icon_state = "stone[rand(1,5)]" 

	var/bonus_force = 0 // Total bonus force the rock will be getting
	var/list/given_intent_list = list(/datum/intent/hit) // By default you get this at least
	var/list/extra_intent_list = list() // List of intents that we can possibly give it by the end of this
	var/list/blunt_intents = list(/datum/intent/mace/strike/wood, /datum/intent/mace/smash/wood)
	var/list/sharp_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust, /datum/intent/dagger/chop)

	var/bluntness_rating = rand(0,10)
	var/sharpness_rating = rand(0,10)

	var/stone_personality_rating = rand(0,25)

	//This is so sharpness and bluntness's name and descs come in randomly before or after each other
	//Magic will always be in front for now, and personality will be after magic.
	var/list/name_jumbler = list()
	var/list/desc_jumbler = list()

	switch(bluntness_rating)
		if(2 to 9)
			extra_intent_list += pick(blunt_intents) // Add one
		if(10)
			for(var/muhdik in blunt_intents) // add all intent to possible things
				extra_intent_list += muhdik

			name_jumbler += pick(GLOB.stone_bluntness_names)
			desc_jumbler += pick(GLOB.stone_bluntness_descs)

	switch(sharpness_rating)
		if(2 to 9)
			extra_intent_list += pick(sharp_intents) // Add one
		if(10)
			for(var/mofugga in sharp_intents) // add all intent to possible things
				extra_intent_list += mofugga

			name_jumbler += pick(GLOB.stone_sharpness_names)
			desc_jumbler += pick(GLOB.stone_sharpness_descs)

	if(name_jumbler.len) // Both name jumbler and desc jumbler should be symmetrical in insertions conceptually anyways.
		for(var/i in 1 to name_jumbler.len) //Theres only two right now 
			if(!name_jumbler.len) // If list somehow empty get the hell out! Now~!
				break
			//Remove so theres no repeats
			var/picked_name = pick(name_jumbler)
			name_jumbler -= picked_name
			var/picked_desc = pick(desc_jumbler)
			desc_jumbler -= picked_desc

			stone_title = "[picked_name] [stone_title]" // Prefix and then stone
			stone_desc += " [picked_desc]" // We put the descs after the original one

	switch(stone_personality_rating)
		if(10 to 23)
			if(prob(2)) // Stone has a 2 percent chance to have a personality despite missing its roll
				stone_title = "[stone_title] of [pick(GLOB.stone_personalities)]"
				stone_desc += " [pick(GLOB.stone_personality_descs)]"
				bonus_force += rand(1,5) // Personality gives a stone some more power too
		if(24 to 25)
			stone_title = "[stone_title] of [pick(GLOB.stone_personalities)]"
			stone_desc += " [pick(GLOB.stone_personality_descs)]"
			bonus_force += rand(1,5) // Personality gives a stone some more power too

	var/max_force_range = sharpness_rating + bluntness_rating // Add them together
	//max_force_range = round(max_force_range/2) // Divide by 2 and round jus incase

	bonus_force = rand(0, max_force_range) // Your total bonus force is now between 1 and your sharpness/bluntness totals

	if(prob(2)) // We hit the jackpot, a magical stone! JUST FOR ME!
		filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		var/magic_force = rand(1,10) //Roll, we need this seperate for now otherwise people will know the blunt/sharp boosts too
		stone_title = "[pick(GLOB.stone_magic_names)] [stone_title] +[magic_force]"
		stone_desc += " [pick(GLOB.stone_magic_descs)]"
		bonus_force += magic_force // Add on the magic force modifier

	if(extra_intent_list.len)
		for(var/i in 1 to min(4, extra_intent_list.len))
			// No more than 4 bro, and if we are empty on intents just stop here
			if(!length(extra_intent_list))
				break
			var/cock = pick(extra_intent_list) // We pick one
			given_intent_list += cock // Add it to the list
			extra_intent_list -= cock // Remove it from the prev list
	
	//Now that we have built the history and lore of this stone, we apply it to the main vars.
	name = stone_title
	desc = stone_desc
	force += bonus_force // This will result in a stone that has only 40 max at a extremely low chance damage at this time of this PR.
	throwforce += bonus_force // It gets added to throw damage too
	possible_item_intents = given_intent_list // And heres ur new extra intents too

/obj/item/natural/stone/attackby(obj/item/W, mob/living/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	var/skill_level = user.mind.get_skill_level(/datum/skill/craft/masonry)
	var/work_time = (35 - (skill_level * 5))
	if(istype(W, /obj/item/natural/stone))
		playsound(src.loc, pick('sound/items/stonestone.ogg'), 100)
		user.visible_message(span_info("[user] strikes the stones together."))
		if(prob(10))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_step(user,user.dir)
			S.set_up(1, 1, front)
			S.start()
	if( user.used_intent.type == /datum/intent/chisel )
		playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
		user.visible_message("<span class='info'>[user] chisels the stone into a block.</span>")
		if(do_after(user, work_time))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/effect/decal/cleanable/debris/stony(get_turf(src))
			playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
			qdel(src)
			user.mind.add_sleep_experience(/datum/skill/craft/masonry, (user.STAINT*0.2))
		return
	else if(istype(W, /obj/item/rogueweapon/chisel/assembly))
		to_chat(user, span_warning("You most use both hands to chisel blocks."))
	else
		..()

/obj/item/natural/rock
	name = "rock"
	desc = "A rock protudes from the ground."
	icon_state = "stonebig1"
	dropshrink = 0
	throwforce = 25
	throw_range = 2
	force = 18
	obj_flags = CAN_BE_HIT
	force_wielded = 15
	gripped_intents = list(INTENT_GENERIC)
	w_class = WEIGHT_CLASS_HUGE
	twohands_required = TRUE
	var/obj/item/rogueore/mineralType = null
	var/mineralAmt = 1
	blade_dulling = DULLING_BASH
	max_integrity = 90
	destroy_sound = 'sound/foley/smash_rock.ogg'
	attacked_sound = 'sound/foley/hit_rock.ogg'


/obj/item/natural/rock/Initialize()
	icon_state = "stonebig[rand(1,2)]"
	. = ..()


/obj/item/natural/rock/Crossed(mob/living/L)
	if(istype(L) && !L.throwing)
		if(L.m_intent == MOVE_INTENT_RUN)
			L.visible_message(span_warning("[L] trips over the rock!"),span_warning("I trip over the rock!"))
			L.Knockdown(10)
			L.consider_ambush()
	..()

/obj/item/natural/rock/deconstruct(disassembled = FALSE)
	if(!disassembled)
		if(mineralType && mineralAmt)
			new mineralType(src.loc, mineralAmt)
		for(var/i in 1 to rand(1,4))
			var/obj/item/S = new /obj/item/natural/stone(src.loc)
			S.pixel_x = rand(25,-25)
			S.pixel_y = rand(25,-25)
	qdel(src)

/obj/item/natural/rock/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(.) //damage received
		if(damage_amount > 10)
			if(prob(10))
				var/datum/effect_system/spark_spread/S = new()
				var/turf/front = get_turf(src)
				S.set_up(1, 1, front)
				S.start()

/obj/item/natural/rock/attackby(obj/item/W, mob/living/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	var/skill_level = user.mind.get_skill_level(/datum/skill/craft/masonry)
	var/work_time = (120 - (skill_level * 15))
	if(istype(W, /obj/item/natural/stone))
		user.visible_message(span_info("[user] strikes the stone against the rock."))
		playsound(src.loc, 'sound/items/stonestone.ogg', 100)
		if(prob(35))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_turf(src)
			S.set_up(1, 1, front)
			S.start()
		return
	if(istype(W, /obj/item/natural/rock))
		playsound(src.loc, pick('sound/items/stonestone.ogg'), 100)
		user.visible_message(span_info("[user] strikes the rocks together."))
		if(prob(10))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_turf(src)
			S.set_up(1, 1, front)
			S.start()
		return
	if( user.used_intent.type == /datum/intent/chisel )
		playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
		user.visible_message("<span class='info'>[user] chisels the rock into blocks.</span>")
		if(do_after(user, work_time))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/effect/decal/cleanable/debris/stony(get_turf(src))
			playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
			user.mind.add_sleep_experience(/datum/skill/craft/masonry, (user.STAINT*0.5))
			qdel(src)
		return
	else if(istype(W, /obj/item/rogueweapon/chisel/assembly))
		to_chat(user, span_warning("You most use both hands to chisel blocks."))
	..()


/obj/item/natural/whet
	name = "whet stone"
	icon_state = "whet"
	desc = "A piece of rough smoothed down stone, better blade maintenance"
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 15
	slot_flags = ITEM_SLOT_MOUTH
	w_class = WEIGHT_CLASS_TINY
	mill_result = /obj/item/reagent_containers/powder/alch/stone

/obj/item/attackby(obj/item/I, mob/user, params)
	user.changeNext_move(user.used_intent.clickcd)
	if(max_blade_int)
		if(istype(I, /obj/item/natural/whet))
			playsound(src.loc, pick('sound/items/sharpen_long1.ogg','sound/items/sharpen_long2.ogg'), 100)
			user.visible_message(span_notice("[user] sharpens [src]!"))
			degrade_bintegrity(0.5)
			add_bintegrity(max_blade_int * 0.3) 
			if(blade_int >= max_blade_int)
				to_chat(user, span_info("Fully sharpened."))
			if(prob(35))
				var/datum/effect_system/spark_spread/S = new()
				var/turf/front = get_step(user,user.dir)
				S.set_up(1, 1, front)
				S.start()
			return
	. = ..()

//begin ore loot rocks
/obj/item/natural/rock/gold
	mineralType = /obj/item/rogueore/gold

/obj/item/natural/rock/silver
	mineralType = /obj/item/rogueore/silver

/obj/item/natural/rock/iron
	mineralType = /obj/item/rogueore/iron

/obj/item/natural/rock/copper
	mineralType = /obj/item/rogueore/copper

/obj/item/natural/rock/tin
	mineralType = /obj/item/rogueore/tin

/obj/item/natural/rock/coal
	mineralType = /obj/item/rogueore/coal

/obj/item/natural/rock/salt
	mineralType = /obj/item/reagent_containers/powder/salt

/obj/item/natural/rock/cinnabar
	mineralType = /obj/item/rogueore/cinnabar

/obj/item/natural/rock/gem
	mineralType = /obj/item/roguegem/random


//................	Stone blocks	............... //
/obj/item/natural/stoneblock
	name = "stone block"
	desc = "A rectangular stone block for building."
	icon = 'icons/roguetown/items/crafting.dmi'
	icon_state = "stoneblock"
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	item_state = "block"
	experimental_inhand = FALSE
	drop_sound = 'sound/foley/brickdrop.ogg'
	hitsound = 'sound/foley/brickdrop.ogg'
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 18 //brick is valid weapon
	w_class = WEIGHT_CLASS_SMALL
	bundletype = /obj/item/natural/bundle/stoneblock
	sellprice = 2
/obj/item/natural/stoneblock/attackby(obj/item, mob/living/user)
	if(item_flags & IN_STORAGE)
		return
	. = ..()
/obj/item/natural/stoneblock/attack_right(mob/user)
	. = ..()
	if(user.get_active_held_item())
		return
	to_chat(user, span_warning("I start to collect [src]..."))
	if(move_after(user, 4 SECONDS, target = src))
		var/stackcount = 0
		for(var/obj/item/natural/stoneblock/F in get_turf(src))
			stackcount++
		while(stackcount > 0)
			if(stackcount == 1)
				var/obj/item/natural/stoneblock/S = new(get_turf(user))
				user.put_in_hands(S)
				stackcount--
			else if(stackcount >= 2)
				var/obj/item/natural/bundle/stoneblock/B = new(get_turf(user))
				B.amount = clamp(stackcount, 2, 4)
				B.update_bundle()
				stackcount -= clamp(stackcount, 2, 4)
				user.put_in_hands(B)
		for(var/obj/item/natural/stoneblock/F in get_turf(src))
			playsound(get_turf(user.loc), 'sound/foley/stone_scrape.ogg', 100)
			qdel(F)

//................ Stone block stack	............... //
/obj/item/natural/bundle/stoneblock
	name = "stack of stone blocks"
	desc = "A stack of stone blocks."
	icon_state = "stoneblockbundle1"
	icon = 'icons/roguetown/items/crafting.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	item_state = "block"
	experimental_inhand = FALSE
	grid_width = 64
	grid_height = 64
	base_width = 64
	base_height = 64
	drop_sound = 'sound/foley/brickdrop.ogg'
	hitsound = list('sound/combat/hits/blunt/shovel_hit.ogg', 'sound/combat/hits/blunt/shovel_hit2.ogg', 'sound/combat/hits/blunt/shovel_hit3.ogg')
	pickup_sound = 'sound/foley/brickdrop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 2
	throwforce = 0	// useless for throwing unless solo
	throw_range = 2
	w_class = WEIGHT_CLASS_NORMAL
	stackname = "stone blocks"
	stacktype = /obj/item/natural/stoneblock
	maxamount = 4
	icon1 = "stoneblockbundle2"
	icon1step = 3
	icon2 = "stoneblockbundle3"
	icon2step = 4

/obj/structure/roguerock/attackby(obj/item/W, mob/living/user, params)
	. = ..()
	if( user.used_intent.type == /datum/intent/chisel )
		playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
		user.visible_message("<span class='info'>[user] chisels the rock into blocks.</span>")
		if(do_after(user, 10 SECONDS))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/effect/decal/cleanable/debris/stony(get_turf(src))
			playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
			user.mind.add_sleep_experience(/datum/skill/craft/masonry, (user.STAINT*1))
			qdel(src)
		return
	else if(istype(W, /obj/item/rogueweapon/chisel/assembly))
		to_chat(user, span_warning("You most use both hands to chisel blocks."))

