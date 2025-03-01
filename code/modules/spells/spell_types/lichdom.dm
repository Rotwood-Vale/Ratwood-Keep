/obj/effect/proc_holder/spell/targeted/lichdom
	name = "Bind Soul"
	desc = "A dark necromantic pact that can forever bind my soul to an \
	item of my choosing. So long as both my body and the item remain \
	intact and on the same plane you can revive from death, though the time \
	between reincarnations grows steadily with use, along with the weakness \
	that the new skeleton body will experience upon 'birth'. Note that \
	becoming a lich destroys all internal organs except the brain."
	school = "necromancy"
	charge_max = 10
	clothes_req = FALSE
	centcom_cancast = FALSE
	invocation = "NECREM IMORTIUM!"
	invocation_type = "shout"
	range = -1
	level_max = 0 //cannot be improved
	cooldown_min = 10
	include_user = TRUE

	action_icon = 'icons/mob/actions/actions_spells.dmi'
	action_icon_state = "skeleton"

/obj/effect/proc_holder/spell/targeted/lichdom/cast(list/targets,mob/user = usr)
	for(var/mob/M in targets)
		var/list/hand_items = list()
		if(iscarbon(M))
			hand_items = list(M.get_active_held_item(),M.get_inactive_held_item())
		if(!hand_items.len)
			to_chat(M, span_warning("I must hold an item you wish to make my phylactery!"))
			return
		if(!M.mind.hasSoul)
			to_chat(user, span_warning("I do not possess a soul!"))
			return

		var/obj/item/marked_item

		for(var/obj/item/item in hand_items)
			// I ensouled the nuke disk once. But it's probably a really
			// mean tactic, so probably should discourage it.
			if((item.item_flags & ABSTRACT) || HAS_TRAIT(item, TRAIT_NODROP) || SEND_SIGNAL(item, COMSIG_ITEM_IMBUE_SOUL, user))
				continue
			marked_item = item
			to_chat(M, span_warning("I begin to focus my very being into [item]..."))
			break

		if(!marked_item)
			to_chat(M, span_warning("None of the items you hold are suitable for emplacement of my fragile soul."))
			return

		playsound(user, 'sound/blank.ogg', 100)

		if(!do_after(M, 50, needhand=FALSE, target=marked_item))
			to_chat(M, span_warning("My soul snaps back to my body as you stop ensouling [marked_item]!"))
			return

		marked_item.name = "ensouled [marked_item.name]"
		marked_item.desc += "\nA terrible aura surrounds this item, its very existence is offensive to life itself..."
		marked_item.add_atom_colour("#003300", ADMIN_COLOUR_PRIORITY)

		new /obj/item/phylactery(marked_item, M.mind)

		to_chat(M, span_danger("With a hideous feeling of emptiness you watch in horrified fascination as skin sloughs off bone! Blood boils, nerves disintegrate, eyes boil in their sockets! As my organs crumble to dust in my fleshless chest you come to terms with my choice. You're a lich!"))
		M.mind.hasSoul = FALSE
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			H.dropItemToGround(H.wear_pants)
			H.dropItemToGround(H.wear_armor)
			H.dropItemToGround(H.head)
			
		// you only get one phylactery.
		M.mind.RemoveSpell(src)


/obj/item/phylactery
	name = "phylactery"
	desc = ""
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bluespace"
	color = "#003300"
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_color = "#003300"
	var/resurrections = 0
	var/datum/mind/mind
	var/respawn_time = 1800

	var/static/active_phylacteries = 0
	var/reported_about_respawn = FALSE // REDMOON ADD - lich_fixes - одиночное оповещение о скором возрождении некроманта

/obj/item/phylactery/Initialize(mapload, datum/mind/newmind)
	. = ..()
	mind = newmind
	name = "phylactery of [usr.mind.name]"

	active_phylacteries++
	GLOB.poi_list |= src
	START_PROCESSING(SSobj, src)
	if(initial(SSticker.mode.round_ends_with_antag_death))
		SSticker.mode.round_ends_with_antag_death = FALSE

/obj/item/phylactery/Destroy(force=FALSE)
	STOP_PROCESSING(SSobj, src)
	active_phylacteries--
	GLOB.poi_list -= src
	if(!active_phylacteries)
		SSticker.mode.round_ends_with_antag_death = initial(SSticker.mode.round_ends_with_antag_death)
	. = ..()

/obj/item/phylactery/process()
	if(QDELETED(mind))
		qdel(src)
		return

	if(!mind.current || mind.current?.stat == DEAD)
		// REDMOON ADD START - lich_fixes - убираем спам таймером и оповещением
		if(!reported_about_respawn) 
			reported_about_respawn = TRUE
			to_chat(mind, mind.current.client?.prefs.be_russian ? span_changeling("Моё тело сломлено, но не мои амбиции. Мой филактерий должен возрадить мою плоть в течении 3 минут.")  : span_changeling("My body was shattered, but not my ambitions. I shall rise again in 3 minutes."))
			// REDMOON ADD END
			addtimer(CALLBACK(src, PROC_REF(rise)), respawn_time, TIMER_UNIQUE)

/obj/item/phylactery/proc/rise()
	if(mind.current.stat != DEAD) // REDMOON EDIT - lich_fixes - оптимизация
		reported_about_respawn = FALSE // REDMOON ADD - lich_fixes - сбрасываем оповещение после возрождения
		return "[mind] already has a living body: [mind.current]"

	var/turf/item_turf = get_turf(src)
	if(!item_turf)
		reported_about_respawn = FALSE // REDMOON ADD - lich_fixes - сбрасываем оповещение после возрождения
		return "[src] is not at a turf? NULLSPACE!?"

	var/mob/old_body = mind.current
	var/mob/living/carbon/human/lich = new(item_turf)

	lich.real_name = mind.name
	mind.transfer_to(lich)
	mind.grab_ghost(force=TRUE)
	// REDMOON ADD START - lich_fixes - присвоение телу расы и его скелетизация, а также присвоение статов
	lich.client?.prefs.copy_to(lich)
	lich.dna.update_dna_identity()
	lich.hardset_dna(newreal_name = old_body.name)

	var/datum/antagonist/lich/possessor = lich.mind.has_antag_datum(/datum/antagonist/lich)
	possessor?.rise_anew()
	// REDMOON ADD END
	to_chat(lich, span_warning("My bones clatter and shudder as you are pulled back into this world!"))
	var/turf/body_turf = get_turf(old_body)
	lich.Paralyze(200 + 200*resurrections)
	to_chat(lich, mind.current.client?.prefs.be_russian ? span_changeling("Моему новому телу нужно время, чтобы впитать мой дух после вырывания из хватки Некры... Минуту или две.") : span_changeling("I need some time to recover after being pulled from Necra's grip... A minute or two.")) // REDMOON ADD - lich_fixes - оповещение для игрока, почему он в параличе
	resurrections++
	reported_about_respawn = FALSE // REDMOON ADD - lich_fixes - сбрасываем оповещение после возрождения
	if(old_body?.loc) // REDMOON EDIT - lich_fixes - оптимизация
		if(iscarbon(old_body))
			var/mob/living/carbon/C = old_body
			for(var/obj/item/W in C)
				C.dropItemToGround(W)
			for(var/obj/item/organ/I in C.internal_organs) // REDMOON EDIT - lich_fixes - оптимизация
//				var/obj/item/organ/I = X - REDMOON REMOVAL - lich_fixes - оптимизация
				I.Remove(C)
				I.forceMove(body_turf)
		var/wheres_wizdo = dir2text(get_dir(body_turf, item_turf))
		if(wheres_wizdo)
			old_body.visible_message(span_warning("Suddenly [old_body.name]'s corpse falls to pieces! You see a strange energy rise from the remains, and speed off towards the [wheres_wizdo]!"))
			body_turf.Beam(item_turf,icon_state="lichbeam",time=10+40*resurrections,maxdistance=INFINITY) // REDMOON EDIT - lich_fixes - слегка повышено время, с 10+10*возрождение до 10+40*возрождение
		old_body.dust()
