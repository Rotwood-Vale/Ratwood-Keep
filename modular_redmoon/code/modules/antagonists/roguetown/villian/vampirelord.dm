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

// vampire_skin_color_fix
/datum/antagonist/vampirelord
	var/cache_breasts // Нужно для запоминания цветов
	var/cache_penis
	var/cache_testicles
	var/cache_butt
	var/cache_ears
	var/cache_tail
	var/cache_tail_feature
	var/cache_head_feature
	var/cache_frills
	var/cache_antennas
	var/cache_wings
	var/cache_snout

// vampire_skin_color_fix
/datum/antagonist/vampirelord/vamp_look()
	var/mob/living/carbon/human/vampire = owner.current

	var/obj/item/organ/breasts/breasts = vampire.getorganslot(ORGAN_SLOT_BREASTS)
	if(breasts)
		cache_breasts = breasts.accessory_colors

	var/obj/item/organ/penis/penis = vampire.getorganslot(ORGAN_SLOT_PENIS)
	if(penis)
		cache_penis = penis.accessory_colors

	var/obj/item/organ/testicles/testicles = vampire.getorganslot(ORGAN_SLOT_TESTICLES)
	if(testicles)
		cache_testicles = testicles.accessory_colors

	var/obj/item/organ/butt/butt = vampire.getorganslot(ORGAN_SLOT_BUTT)
	if(butt)
		cache_butt = butt.accessory_colors

	var/obj/item/organ/ears/ears = vampire.getorganslot(ORGAN_SLOT_EARS)
	if(ears)
		cache_ears = ears.accessory_colors

	var/obj/item/organ/tail/tail = vampire.getorganslot(ORGAN_SLOT_TAIL)
	if(tail)
		cache_tail = tail.accessory_colors

	var/obj/item/organ/tail_feature/tail_feature = vampire.getorganslot(ORGAN_SLOT_TAIL_FEATURE)
	if(tail_feature)
		cache_tail_feature = tail_feature.accessory_colors

	var/obj/item/organ/head_feature/head_feature = vampire.getorganslot(ORGAN_SLOT_HEAD_FEATURE)
	if(head_feature)
		cache_head_feature = head_feature.accessory_colors

	var/obj/item/organ/frills/frills = vampire.getorganslot(ORGAN_SLOT_FRILLS)
	if(frills)
		cache_frills = frills.accessory_colors

	var/obj/item/organ/antennas/antennas = vampire.getorganslot(ORGAN_SLOT_ANTENNAS)
	if(antennas)
		cache_antennas = antennas.accessory_colors

	var/obj/item/organ/wings/wings = vampire.getorganslot(ORGAN_SLOT_WINGS)
	if(wings)
		cache_wings = wings.accessory_colors

	var/obj/item/organ/snout/snout = vampire.getorganslot(ORGAN_SLOT_SNOUT)
	if(snout)
		cache_snout = snout.accessory_colors

	..()

/obj/item/clothing/suit/roguetown/armor/chainmail/iron/vampire
	icon = 'modular_redmoon/icons/armor.dmi'
