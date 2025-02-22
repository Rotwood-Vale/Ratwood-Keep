/**
  * Spellbooks for learning arcane points.
  * Difficult to learn by default, has multipliers for weed, gems and rituals.
  * Inherits most of it's functionality from default granters, however also has some copy paste from roguebooks for parity.
  */

/obj/item/book/granter/spellbook
	var/open = FALSE
	icon = 'icons/roguetown/items/books.dmi'
	icon_state = "spellbookbrown_0"
	slot_flags = ITEM_SLOT_HIP
	var/base_icon_state = "spellbookbrown"
	unique = TRUE
	firefuel = 2 MINUTES
	dropshrink = 0.6
	drop_sound = 'sound/foley/dropsound/book_drop.ogg'
	force = 5
	associated_skill = /datum/skill/misc/reading
	name = "tome of the arcyne"
	desc = "A crackling, glowing book, filled with runes and symbols that hurt the mind to stare at."
	pages_to_mastery = 7
	remarks = list("Recall that place of white and black, so cold after its season of heat...", "Time slips away as I devour each pictograph and sigil...", "Noc is a shrewd God, and his followers� writings are no different...", "The smell of wet rain fills the room with every turned page...", "Helical text spans the page like a winding puzzle...", "Tracing a finger over one rune renders  my hand paralyzed, if only for a moment...", "The Sun-And-Moon theory implicates Astrata and Noc as the primary drivers of magick...", "The Sea-And-Moon theory connects Abyssor and Noc as the chief patrons of arcyne...", "This page clearly details the benefits of swampweed on one's capacity to conceptualize the arcyne...", "Conceptualize. Theorize. Feel. Flow. Manifest...", "Passion. Strength. Power. Victory. The tenets through which we break the chains of reality...", "Didn�t I just read this page...?", "A lone illustration of Noc�s visage fills this page, his stony gaze boring into my soul...", "My eyes begin to lid as I finish this chapter. These symbols cast a heavy fog over my mind...", "This chapter focuses on the scholars of Naledi, and their abstruse traditions on daemon-hunting...", "The book states Grenzelhoftian jesters are renowned for dabbling in the arcyne to please their lords. Is there something I could learn from fools...?", "Silver. Blade. Mana. Blood. These are the ingredients I�ll need to imbibe the very ground with arcyne abilities...", "Elysium incants speak to me in an extinct tongue immortalized on parchment...", "My mind wanders and waves. Z's temptations draw close, but I weather through as I finally finish this chapter...", "I close my eye's for but a moment, and the competing visages of Noc and Z stare into my very soul. I see them blink, and my eyelids open...", "I am the Root. The Root is me. I must reach it, and the Tree...", "I feel the arcyne circuits running through my body, empowered with each word I read...", "Am I reading? Are these words, symbols or inane scribbles? I cannot be sure, yet with each one my eyes glaze over, I can feel the arcyne pulse within me...", "A mystery is revealed before my very eyes. I do not read it, yet I am aware. Gems are the Root's natural arcyne energy, manifest. Perhaps I can use them to better my conceptualization...")
	oneuse = FALSE
	var/owner = null
	var/list/allowed_readers = list()
	var/stored_gem = FALSE
	var/picked // if the book has had it's style picked or not
	var/born_of_rock = FALSE // was a magical stone used to make it instead of a gem?
	var/bookquality = 3
/obj/item/book/granter/spellbook/getonmobprop(tag)
	. = ..()
	if(tag)
		if(open)
			switch(tag)
				if("gen")
					return list("shrink" = 0.4,
	"sx" = -2,
	"sy" = -3,
	"nx" = 10,
	"ny" = -2,
	"wx" = 1,
	"wy" = -3,
	"ex" = 5,
	"ey" = -3,
	"northabove" = 0,
	"southabove" = 1,
	"eastabove" = 1,
	"westabove" = 0,
	"nturn" = 0,
	"sturn" = 0,
	"wturn" = 0,
	"eturn" = 0,
	"nflip" = 0,
	"sflip" = 0,
	"wflip" = 0,
	"eflip" = 0)
				if("onbelt")
					return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
		else
			switch(tag)
				if("gen")
					return list("shrink" = 0.4,
	"sx" = -2,
	"sy" = -3,
	"nx" = 10,
	"ny" = -2,
	"wx" = 1,
	"wy" = -3,
	"ex" = 5,
	"ey" = -3,
	"northabove" = 0,
	"southabove" = 1,
	"eastabove" = 1,
	"westabove" = 0,
	"nturn" = 0,
	"sturn" = 0,
	"wturn" = 0,
	"eturn" = 0,
	"nflip" = 0,
	"sflip" = 0,
	"wflip" = 0,
	"eflip" = 0)
				if("onbelt")
					return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/book/granter/spellbook/attack_self(mob/user)
	if(!open)
		attack_right(user)
		return
	..()
	user.update_inv_hands()

/obj/item/book/granter/spellbook/rmb_self(mob/user)
	attack_right(user)
	return

/obj/item/book/granter/spellbook/read(mob/user)
	return FALSE

/obj/item/book/granter/spellbook/attack_right(mob/user)
	if(!picked)
		var/list/designlist = list("green", "yellow", "brown")
		var/mob/living/carbon/human/gamer = user
		if(gamer.job == "Court Magician")
			designlist = list("steel", "gem", "skin", "mimic")
		var/the_time = world.time
		var/design = input(user, "Select a design.","Spellbook Design") as null|anything in designlist
		if(!design)
			return
		if(world.time > (the_time + 30 SECONDS))
			return
		base_icon_state = "spellbook[design]"
		update_icon()
		picked = TRUE
		return
	if(owner == null)
		owner = user
	if(!open)
		slot_flags &= ~ITEM_SLOT_HIP
		open = TRUE
		playsound(loc, 'sound/items/book_open.ogg', 100, FALSE, -1)
	else
		slot_flags |= ITEM_SLOT_HIP
		open = FALSE
		playsound(loc, 'sound/items/book_close.ogg', 100, FALSE, -1)
	curpage = 1
	update_icon()
	user.update_inv_hands()

/obj/item/book/granter/spellbook/update_icon()
	icon_state = "[base_icon_state]_[open]"

/obj/item/book/granter/spellbook/on_reading_start(mob/user)
	to_chat(user, span_notice("Arcyne mysteries abound in this enigmatic tome, gift of Noc..."))

/obj/item/book/granter/spellbook/on_reading_finished(mob/user)
	var/mob/living/carbon/human/gamer = user
	if(gamer != owner && !allowed_readers.Find(gamer))
		to_chat(user, span_notice("What was that gibberish? Even for the arcyne it was completely illegible!"))
		return
	user.mind?.has_studied = TRUE
	var/mob/living/reader = user
	var/qualityoflearn = (reader.STAINT*2 + (user.mind?.get_skill_level(/datum/skill/misc/reading)*10) + (user.mind?.get_skill_level(/datum/skill/magic/arcane)*5))
	if(reader.has_status_effect(/datum/status_effect/buff/weed))
		to_chat(user, span_smallgreen("Swampweed truly does open one's third eye to the secrets of the arcyne..."))
		qualityoflearn += 10
	var/obj/effect/decal/cleanable/roguerune/rune = (locate(/obj/effect/decal/cleanable/roguerune) in range(1, user))
	if(rune)
		to_chat(user, span_cultsmall("The rune beneath my feet glows..."))
		qualityoflearn += rune.spellbonus
		rune.do_invoke_glow()
	if(stored_gem)
		to_chat(user, span_smallnotice("I can feel the magical energies imbued within the crystaline dust scattered upon my tome resonate with the arcyne..."))
		qualityoflearn += stored_gem
		stored_gem = FALSE
	if(!isarcyne(user))
		if (gamer != owner) // if you didn't make this book, get fucked.
			qualityoflearn = 1
		else
			qualityoflearn *= 0.5
			qualityoflearn = min(qualityoflearn, 15)
	if (born_of_rock)
		// the rock tomes are neat, and low quality. Might as well make them better to learn from!
		qualityoflearn *= 1.2
	testing("Quality of learning is [qualityoflearn]")
	user.visible_message(span_warning("[user] is filled with arcyne energy! You witness [user.p_their()] body convulse and spark brightly."), \
	span_notice("Noc blesses me. I have been granted knowledge and wisdom beyond my years, this tome's mysteries unveiled one at a time."))
	qualityoflearn = qualityoflearn / 100
	var/spellpoints = (src.bookquality * qualityoflearn)
	spellpoints = round(spellpoints)	//Rounds. 2.4 spellpoint level? too bad. You get 2, not 3.
	user.mind.adjust_spellpoints(spellpoints)
	user.log_message("successfully studied their spellbook and gained spellpoints", LOG_ATTACK, color="orange")
	onlearned(user)
	if(prob(55))
		to_chat(user, span_notice("Confounded arcyne mysteries, my notes has gone in circles. I must sleep before I can bring myself to open this damned thing again..."))
		user.mind?.add_sleep_experience(/datum/skill/misc/reading, reader.STAINT*10)
	to_chat(user, span_small("My notes include passages I've read before, but don't understand. I must sleep on their meaning..."))
/obj/item/book/granter/spellbook/onlearned(mob/user)
	used = FALSE

/obj/item/book/granter/spellbook/recoil(mob/user)
	user.visible_message(span_warning("[src] shoots out a spark of angry, arcyne energy at [user]!"))
	var/mob/living/gamer = user
	gamer.electrocute_act(5, src)

/obj/item/book/granter/spellbook/attack(mob/living/M, mob/living/carbon/human/user)
	var/mob/living/carbon/human/gamer = user
	if(gamer != owner)
		return
	if (M.stat != DEAD)
		if(user == M)
			to_chat(user, span_warning("I'm already chained to this tome!"))
			return
		if(ishuman(M))
			M.visible_message(span_danger("[user] beats [M] over the head with [src]!"), \
								span_danger("[user] beats [M] over the head with [src]!"))
			if(src.allowed_readers.len <= 2 && !src.allowed_readers.Find(user))
				src.allowed_readers += M
			else
				to_chat(user, span_smallnotice("I can't change this pleboid to my tome..."))
			playsound(src.loc, "punch", 25, TRUE, -1)
			log_combat(user, M, "attacked", src)
	else
		M.visible_message(span_danger("[user] smacks [M]'s lifeless corpse with [src]."))
		playsound(src.loc, "punch", 25, TRUE, -1)

/// Book Types:
/obj/item/book/granter/spellbook/horrible	//makeable with magic stones (bad quality ones)
	name = "poorly made tome of the arcyne"
	desc = "A poorly made book,  it barely glows with arcane and has only small notes on arcane symbols."
	bookquality = 1
	sellprice = 15
/obj/item/book/granter/spellbook/mid	//decent magic stones and basic crafting materials
	name = "beginners tome of the arcyne"
	desc = "An obviously handcrafted book, it glows occasionally with arcane and has a meager amount notes on arcane symbols."
	bookquality = 2
	sellprice = 30
/obj/item/book/granter/spellbook/apprentice	//apprentices get made with obsidian
	name = "apprentice tome of the arcyne"
	desc = "A carefully made book,  faintly glowing with arcane and half filled with notes and theory on arcane symbols."
	bookquality = 3
	sellprice = 75
/obj/item/book/granter/spellbook/adept	//refugee mages &normal loot
	name = "adept tome of the arcyne"
	desc = "A well made book,  it shines moderately with arcane light. It has been filled with notes of varying degrees on the arcane "
	bookquality = 4
	sellprice = 150
/obj/item/book/granter/spellbook/expert	//made from 2nd tier loot item
	name = "expert tome of the arcyne"
	desc = "A well cared for book, shining brightly with arcane. It has many runes and arcane symbols scribed within, with detailed notes."
	bookquality = 6
	sellprice = 200
/obj/item/book/granter/spellbook/master	// Court mage & made from 3rd tier loot item
	name = "masterful tome of the arcyne"
	desc = "A crackling, glowing book, filled with advanced arcane runes and symbols that hurt the mind to stare at. A true master of the arcane has left their mark behind."
	bookquality = 8
	sellprice = 250
/obj/item/book/granter/spellbook/legendary	//max tier lootmade item
	name = "legendary tome of the arcyne"
	desc = "An incredible book that gives off glowing arcane motes,  it is filled with runes and arcane theories that is hard for even masters of arcane to understand. The arcane script glows and practically whispers from the page.."
	bookquality = 12
	sellprice = 400

/obj/item/book/granter/spellbook/debug	//debug item to be used for testing and admin purposes
	name = "Ancient arcanic grimoire"
	desc = "An incredible book that gives off glowing arcane motes,  it is filled with runes and arcane theories that is hard for even masters of arcane to understand. The arcane script glows and practically whispers from the page.."
	bookquality = 99
	sellprice = 400

/// Book slapcrafting

/obj/item/spellbook_unfinished
	var/pages_left = 4
	name = "bound scrollpaper"
	dropshrink = 0.6
	icon = 'icons/roguetown/items/books.dmi'
	icon_state ="basic_book_0"
	desc = "Thick scroll paper bound at the spine. It lacks pages."
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL		 //upped to three because books are, y'know, pretty big. (and you could hide them inside eachother recursively forever)
	attack_verb = list("bashed", "whacked", "educated")
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/book_drop.ogg'
	pickup_sound =  'sound/blank.ogg'

/obj/item/spellbook_unfinished/pre_arcyne
	name = "tome in waiting"
	icon_state = "spellbook_unfinished"
	desc = "A fully bound tome of scroll paper. It's lacking a certain arcyne energy."

/obj/item/natural/hide/attackby(obj/item/P, mob/living/carbon/human/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/paper/scroll))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(loc, 'sound/items/book_close.ogg', 100, TRUE)
				to_chat(user, span_notice("I add the first few pages to the leather cover..."))
				new /obj/item/spellbook_unfinished(loc)
				qdel(P)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put the [src] on a table to work on it.</span>")
	else
		return ..()

/obj/item/spellbook_unfinished/attackby(obj/item/P, mob/living/carbon/human/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/paper/scroll))
		if(isturf(loc)&& (found_table))
			var/crafttime = (60 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				if(pages_left > 0)
					playsound(loc, 'sound/items/book_page.ogg', 100, TRUE)
					pages_left -= 1
					to_chat(user, span_notice("[pages_left+1] left..."))
					qdel(P)
				else
					playsound(loc, 'sound/items/book_open.ogg', 100, TRUE)
					if(isarcyne(user))
						to_chat(user, span_notice("The book is bound. I must find a catalyst to channel the arcyne into it now."))
					else
						to_chat(user, span_notice("I've made an empty book of thick, useless scroll paper. I can't even thumb through it!"))
					new /obj/item/spellbook_unfinished/pre_arcyne(loc)
					qdel(P)
					qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put the [src] on a table to work on it.</span>")
	else
		return ..()

/obj/item/spellbook_unfinished/pre_arcyne/attackby(obj/item/P, mob/living/carbon/human/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/roguegem/amethyst))
		user.visible_message(span_notice("I run my arcyne energy into the crystal. It's artifical lattices pulse and then fall dormant. It must not be strong enough to make a spellbook with!"))
		return
	if(istype(P, /obj/item/roguegem/violet))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				if(isarcyne(user))
					playsound(loc, 'sound/magic/crystal.ogg', 100, TRUE)
					user.visible_message(span_warning("[user] crushes [user.p_their()] [P]! Its powder seeps into the [src]."), \
						span_notice("I run my arcyne energy into the crystal. It shatters and seeps into the cover of the tome! Runes and symbols of an unknowable language cover it's pages now..."))
					var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/expert(loc)
					newbook.owner = user
					qdel(P)
					qdel(src)
				else
					to_chat(user, span_notice("I press the gem into the cover of the book. What a pretty design this would make!"))
					return ..()
		else
			to_chat(user, "<span class='warning'>You need to put the [src] on a table to work on it.</span>")

	if(istype(P, /obj/item/roguegem))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				if(isarcyne(user))
					playsound(loc, 'sound/magic/crystal.ogg', 100, TRUE)
					user.visible_message(span_warning("[user] crushes [user.p_their()] [P]! Its powder seeps into the [src]."), \
						span_notice("I run my arcyne energy into the crystal. It shatters and seeps into the cover of the tome! Runes and symbols of an unknowable language cover it's pages now..."))
					var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/adept(loc)
					newbook.owner = user
					qdel(P)
					qdel(src)
				else
					to_chat(user, span_notice("I press the gem into the cover of the book. What a pretty design this would make!"))
					return ..()
		else
			to_chat(user, "<span class='warning'>You need to put the [src] on a table to work on it.</span>")
	else if (istype(P, /obj/item/natural/stone))
		var/obj/item/natural/stone/the_rock = P
		if (the_rock.magic_power)
			if(isturf(loc) && (found_table))
				var/crafttime = ((130 - the_rock.magic_power) - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
				if(do_after(user, crafttime, target = src))
					if (isarcyne(user))
						playsound(loc, 'sound/magic/crystal.ogg', 100, TRUE)
						user.visible_message(span_warning("[user] crushes [user.p_their()] [P]! Its powder seeps into the [src]."), \
							span_notice("I join my arcyne energy with that of the magical stone in my hands, which shudders briefly before dissolving into motes of ash. Runes and symbols of an unknowable language cover its pages now..."))
						to_chat(user, span_notice("...yet even for an enigma of the arcyne, these characters are unlike anything I've seen before. They're going to be -much- harder to understand..."))
						if(the_rock.magic_power <=5)
							var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/horrible(loc)
							newbook.owner = user
							newbook.born_of_rock = TRUE
							newbook.desc += " Traces of multicolored stone limn its margins."
							qdel(P)
							qdel(src)
						else if(the_rock.magic_power >5 && the_rock.magic_power <=9)
							var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/mid(loc)
							newbook.owner = user
							newbook.born_of_rock = TRUE
							newbook.desc += " Traces of multicolored stone limn its margins."
							qdel(P)
							qdel(src)
						else if(the_rock.magic_power >=10)
							var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/apprentice(loc)
							newbook.owner = user
							newbook.born_of_rock = TRUE
							newbook.desc += " Traces of multicolored stone limn its margins."
							qdel(P)
							qdel(src)
					else
						if (prob(the_rock.magic_power)) // for reference, this is never higher than 15 and usually significantly lower
							playsound(loc, 'sound/magic/crystal.ogg', 100, TRUE)
							user.visible_message(span_warning("[user] carefully sets down [the_rock] upon [src]. Nothing happens for a moment or three, then suddenly, the glow surrounding the stone becomes as liquid, seeps down and soaks into the tome!"), \
							span_notice("I knew this stone was special! Its colourful magick has soaked into my tome and given me gift of mystery!"))
							to_chat(user, span_notice("...what in the world does any of this scribbling possibly mean?"))
							if(the_rock.magic_power <=5)
								var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/horrible(loc)
								newbook.owner = user
								newbook.born_of_rock = TRUE
								newbook.desc += " Traces of multicolored stone limn its margins."
								qdel(P)
								qdel(src)
							else if(the_rock.magic_power >5 && the_rock.magic_power <=9)
								var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/mid(loc)
								newbook.owner = user
								newbook.born_of_rock = TRUE
								newbook.desc += " Traces of multicolored stone limn its margins."
								qdel(P)
								qdel(src)
							else if(the_rock.magic_power >=10)
								var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/apprentice(loc)
								newbook.owner = user
								newbook.born_of_rock = TRUE
								newbook.desc += " Traces of multicolored stone limn its margins."
								qdel(P)
								qdel(src)
						else
							user.visible_message(span_warning("[user] sets down [the_rock] upon the surface of [src] and watches expectantly. Without warning, the rock violently pops like a squashed gourd!"), \
							span_notice("No! My precious stone! It musn't have wanted to share its mysteries with me..."))
							user.electrocute_act(5, src)
							qdel(P)
		else
			to_chat(user, span_notice("This is a mere rock - it has no arcyne potential. Bah!"))
			return ..()
	else if (istype(P, /obj/item/natural/melded/t1))
		if(isturf(loc) && (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				if (isarcyne(user))
					playsound(loc, 'sound/magic/crystal.ogg', 100, TRUE)
					user.visible_message(span_warning("[user] imbues [user.p_their()] [P]! It fuses into the [src]."), \
						span_notice("I join my arcyne energy with that of the [P] in my hands, which shudders briefly before dissolving into motes of energy. Runes and symbols of an unknowable language cover its pages now..."))
					to_chat(user, span_notice("...yet even for an enigma of the arcyne, these characters are unlike anything I've seen before. They're going to be -much- harder to understand..."))
					var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/adept(loc)
					newbook.owner = user
					qdel(P)
					qdel(src)
				else
					user.visible_message(span_warning("[user] sets down [P] upon the surface of [src] and watches expectantly. Without warning, the [P] lets out a burst of arcane energy!"), \
					span_notice("I should have known messing with the arcyne as dangerous!"))
					user.electrocute_act(20, src)
					qdel(P)
		return ..()
	else if (istype(P, /obj/item/natural/melded/t2))
		if(isturf(loc) && (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				if (isarcyne(user))
					playsound(loc, 'sound/magic/crystal.ogg', 100, TRUE)
					user.visible_message(span_warning("[user] crushes [user.p_their()] [P]! Its powder seeps into the [src]."), \
						span_notice("I join my arcyne energy with that of the [P] in my hands, which shudders briefly before dissolving into motes of energy. Runes and symbols of an unknowable language cover its pages now..."))
					to_chat(user, span_notice("...yet even for an enigma of the arcyne, these characters are unlike anything I've seen before. They're going to be -much- harder to understand..."))
					var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/expert(loc)
					newbook.owner = user
					qdel(P)
					qdel(src)
				else
					user.visible_message(span_warning("[user] sets down [P] upon the surface of [src] and watches expectantly. Without warning, the [P] violently explodes!"), \
					span_notice("I should have known messing with the arcyne as dangerous!"))
					user.electrocute_act(40, src)
					qdel(P)
	else if (istype(P, /obj/item/natural/melded/t3))
		if(isturf(loc) && (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				if (isarcyne(user))
					playsound(loc, 'sound/magic/crystal.ogg', 100, TRUE)
					user.visible_message(span_warning("[user] crushes [user.p_their()] [P]! Its powder seeps into the [src]."), \
						span_notice("I join my arcyne energy with that of the [P] in my hands, which shudders briefly before dissolving into motes of energy. Runes and symbols of an unknowable language cover its pages now..."))
					to_chat(user, span_notice("...yet even for an enigma of the arcyne, these characters are unlike anything I've seen before. They're going to be -much- harder to understand..."))
					var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/master(loc)
					newbook.owner = user
					qdel(P)
					qdel(src)
				else
					user.visible_message(span_warning("[user] sets down [P] upon the surface of [src] and watches expectantly. Without warning, the [P] violently explodes!"), \
					span_notice("I should have known messing with the arcyne as dangerous!"))
					user.electrocute_act(60, src)
					qdel(P)
	else if (istype(P, /obj/item/natural/melded/t4))
		if(isturf(loc) && (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				if (isarcyne(user))
					playsound(loc, 'sound/magic/crystal.ogg', 100, TRUE)
					user.visible_message(span_warning("[user] crushes [user.p_their()] [P]! Its powder seeps into the [src]."), \
						span_notice("I join my arcyne energy with that of the [P] in my hands, which shudders briefly before dissolving into motes of energy. Runes and symbols of an unknowable language cover its pages now..."))
					to_chat(user, span_notice("...yet even for an enigma of the arcyne, these characters are unlike anything I've seen before. They're going to be -much- harder to understand..."))
					var/obj/item/book/granter/spellbook/newbook = new /obj/item/book/granter/spellbook/legendary(loc)
					newbook.owner = user
					qdel(P)
					qdel(src)
				else
					user.visible_message(span_warning("[user] sets down [P] upon the surface of [src] and watches expectantly. Without warning, the [P] violently explodes!"), \
					span_notice("I should have known messing with the arcyne as dangerous!"))
					user.electrocute_act(80, src)
					qdel(P)
	else
		return ..()

// qualityoflearn buff shit

/obj/item/roguegem
	var/arcyne_potency = 20

/obj/item/roguegem/yellow
	arcyne_potency = 5

/obj/item/roguegem/green
	arcyne_potency = 7

/obj/item/roguegem/violet
	arcyne_potency = 10

/obj/item/roguegem/blue
	arcyne_potency = 25

/obj/item/roguegem/diamond
	arcyne_potency = 15



/obj/item/book/granter/spellbook/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/roguegem))
		if(!stored_gem)
			if(isarcyne(user))
				var/obj/item/roguegem/gem = P
				var/crafttime = (60 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
				if(do_after(user, crafttime, target = src))
					playsound(loc, 'sound/magic/glass.ogg', 100, TRUE)
					to_chat(user, span_notice("Running my arcyne energy through this crystal, I imbue the tome with my natural essence, attuning it to my state of mind..."))
					stored_gem = gem.arcyne_potency
					qdel(P)
			else
				to_chat(user, span_notice("Why am I jamming a gem into a book? I must look like a fool!"))
		else
			to_chat(user, span_notice("This tome is already coursing with arcyne energies..."))
	else
		return ..()


// helper proc


/obj/item/book/granter/spellbook/magician/Initialize()
	. = ..()
	var/mob/living/carbon/human/L = loc
	owner = L

