// /obj/item/antag_spawner
// 	throw_speed = 1
// 	throw_range = 5
// 	w_class = WEIGHT_CLASS_TINY

// /obj/item/antag_spawner/death_knight
// 	name = "Death Knight Summoner"
// 	desc = "A single-use summoner designed to quickly summon Death Knights in the field."
// 	icon_state = "bloodtooth"
// 	icon = 'icons/roguetown/clothing/neck.dmi'
// 	var/borg_to_spawn

// /obj/item/antag_spawner/nuke_ops/attack_self(mob/user)
// 	to_chat(user, "<span class='notice'>Вы активировали [src] и ждёте подходящую душу.</span>")
// 	var/list/nuke_candidates = pollGhostCandidates("Желаете ли вы сыграть за [borg_to_spawn ? "[lowertext(borg_to_spawn)] Борга ИнтеКью":"Оперативника ИнтеКью"]?", ROLE_OPERATIVE, null, ROLE_OPERATIVE, 150, POLL_IGNORE_SYNDICATE)
// 	if(LAZYLEN(nuke_candidates))
// 		if(QDELETED(src) || !check_usability(user))
// 			return
// 		used = TRUE
// 		var/mob/dead/observer/G = pick(nuke_candidates)
// 		spawn_antag(G.client, get_turf(src), "inteqborg", user.mind)
// 		do_sparks(4, TRUE, src)
// 		qdel(src)
// 	else
// 		to_chat(user, "<span class='warning'>Невозможно подключиться к штабу ИнтеКью. Пожалуйста, подождите и повторите попытку позже или воспользуйтесь возвратом через Аплинк.</span>")

// /obj/item/antag_spawner/nuke_ops/spawn_antag(client/C, turf/T, kind, datum/mind/user)
// 	var/mob/living/carbon/human/M = new/mob/living/carbon/human(T)
// 	C.prefs.copy_to(M)
// 	M.key = C.key

// 	var/datum/antagonist/nukeop/new_op = new()
// 	new_op.send_to_spawnpoint = FALSE
// 	new_op.nukeop_outfit = /datum/outfit/inteq/no_crystals

// 	var/datum/antagonist/nukeop/creator_op = user.has_antag_datum(/datum/antagonist/nukeop,TRUE)
// 	if(creator_op)
// 		M.mind.add_antag_datum(new_op,creator_op.nuke_team)
// 		M.mind.special_role = "Nuclear Operative"
