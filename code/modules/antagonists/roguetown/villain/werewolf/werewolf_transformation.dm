/mob/living/carbon/human
	var/mob/stored_mob = null

/datum/antagonist/werewolf/on_life(mob/user)
    if(!user) return
    var/mob/living/carbon/human/H = user
    if(H.stat == DEAD) return
    if(H.advsetup) return

    // Werewolf transforms at night AND under the sky
    if(!transformed && !transforming)
        if(GLOB.tod == "night")
            if(isturf(H.loc))
                var/turf/loc = H.loc
                if(loc.can_see_sky())
                    to_chat(H, span_userdanger("The moonlight scorns me... It is too late."))
                    owner.current.playsound_local(get_turf(owner.current), 'sound/music/wolfintro.ogg', 80, FALSE, pressure_affected = FALSE)
                    H.flash_fullscreen("redflash3")
                    transforming = world.time // timer

    // Begin transformation
    else if(transforming)
        if (world.time >= transforming + 35 SECONDS) // Stage 3
            H.werewolf_transform()
            transforming = FALSE
            transformed = TRUE // Mark as transformed

        else if (world.time >= transforming + 25 SECONDS) // Stage 2
            H.flash_fullscreen("redflash3")
            H.emote("agony", forced = TRUE)
            to_chat(H, span_userdanger("UNIMAGINABLE PAIN!"))
            H.Stun(30)
            H.Knockdown(30)

        else if (world.time >= transforming + 10 SECONDS) // Stage 1
            H.emote("")
            to_chat(H, span_warning("I can feel my muscles aching, it feels HORRIBLE..."))


    // Werewolf reverts to human form during the day
    else if(transformed)
        H.real_name = wolfname
        H.name = wolfname

        if(GLOB.tod != "night" && !untransforming) // Is it day and we arnt already turning back.
            if(isturf(H.loc))
                var/turf/loc = H.loc
                if(loc.can_see_sky())
                    untransforming = world.time // Start untransformation phase

        if(untransforming)
            if (world.time >= untransforming + 25 SECONDS) // Untransform
                H.emote("rage", forced = TRUE)
                H.werewolf_untransform()
                transformed = FALSE
                untransforming = FALSE // Reset untransforming phase

            else if (world.time >= untransforming + 10 SECONDS) // Alert player
                H.flash_fullscreen("redflash1")
                to_chat(H, span_warning("Daylight shines around me... the curse begins to fade."))


/mob/living/carbon/human/species/werewolf/death(gibbed)
	werewolf_untransform(TRUE, gibbed)

/mob/living/carbon/human/proc/werewolf_transform()
	if(!mind)
		log_runtime("NO MIND ON [src.name] WHEN TRANSFORMING")
	Paralyze(1, ignore_canstun = TRUE)
	for(var/obj/item/W in src)
		dropItemToGround(W)
	regenerate_icons()
	icon = null
	var/oldinv = invisibility
	invisibility = INVISIBILITY_MAXIMUM
	cmode = FALSE
	if(client)
		SSdroning.play_area_sound(get_area(src), client)
//	stop_cmusic()

	src.fully_heal(FALSE)

	var/mob/living/carbon/human/species/werewolf/W = new (loc)

	W.set_patron(src.patron)
	W.gender = gender
	W.regenerate_icons()
	W.stored_mob = src
	W.limb_destroyer = TRUE
	W.ambushable = FALSE
	W.cmode_music = 'sound/music/combat_werewolf.ogg'
	W.skin_armor = new /obj/item/clothing/suit/roguetown/armor/skin_armor/werewolf_skin(W)
	playsound(W.loc, pick('sound/combat/gib (1).ogg','sound/combat/gib (2).ogg'), 200, FALSE, 3)
	W.spawn_gibs(FALSE)
	apply_status_effect(STATUS_EFFECT_STASIS, null, TRUE)
	src.forceMove(W)

	W.after_creation()
	W.stored_language = new
	W.stored_language.copy_known_languages_from(src)
	W.stored_skills = mind.known_skills.Copy()
	W.stored_experience = mind.skill_experience.Copy()
	mind.transfer_to(W)
	W.mind.known_skills = list()
	W.mind.skill_experience = list()
	W.grant_language(/datum/language/beast)

	W.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB)
	W.update_a_intents()

	to_chat(W, span_userdanger("I transform into a horrible beast!"))
	W.emote("rage")

	W.stress = stress

	W.mind.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE)
	W.mind.adjust_skillrank(/datum/skill/combat/unarmed, 6, TRUE)
	W.mind.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)

	W.AddSpell(new /obj/effect/proc_holder/spell/self/howl)
	W.AddSpell(new /obj/effect/proc_holder/spell/self/claws)

	ADD_TRAIT(src, TRAIT_NOSLEEP, TRAIT_GENERIC)

	ADD_TRAIT(W, TRAIT_STRONGBITE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_ZJUMP, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_NOFALLDAMAGE1, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_BASHDOORS, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_ORGAN_EATER, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_NASTY_EATER, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_IGNOREDAMAGESLOWDOWN, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_IGNORESLOWDOWN, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_HARDDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_PIERCEIMMUNE, TRAIT_GENERIC)

	invisibility = oldinv

	if(getorganslot(ORGAN_SLOT_PENIS))
		W.internal_organs_slot[ORGAN_SLOT_PENIS] = /obj/item/organ/penis/internal
	if(getorganslot(ORGAN_SLOT_TESTICLES))
		W.internal_organs_slot[ORGAN_SLOT_TESTICLES] = /obj/item/organ/testicles
	if(getorganslot(ORGAN_SLOT_BREASTS))
		W.internal_organs_slot[ORGAN_SLOT_BREASTS] = /obj/item/organ/breasts/internal
	if(getorganslot(ORGAN_SLOT_BELLY))
		W.internal_organs_slot[ORGAN_SLOT_BELLY] = /obj/item/organ/belly/internal
	if(getorganslot(ORGAN_SLOT_VAGINA))
		W.internal_organs_slot[ORGAN_SLOT_VAGINA] = /obj/item/organ/vagina/internal

	W.client.prefs.sexable = client.prefs.sexable

/mob/living/carbon/human/proc/werewolf_untransform(dead,gibbed)
	if(!stored_mob)
		return
	if(!mind)
		log_runtime("NO MIND ON [src.name] WHEN UNTRANSFORMING")
	Paralyze(1, ignore_canstun = TRUE)
	for(var/obj/item/W in src)
		dropItemToGround(W)
	icon = null
	invisibility = INVISIBILITY_MAXIMUM

	var/mob/living/carbon/human/W = stored_mob
	stored_mob = null
	REMOVE_TRAIT(W, TRAIT_NOSLEEP, TRAIT_GENERIC)
	if(dead)
		W.death(gibbed)

	W.forceMove(get_turf(src))
	W.remove_status_effect(STATUS_EFFECT_STASIS)

	REMOVE_TRAIT(W, TRAIT_NOMOOD, TRAIT_GENERIC)
	stress = W.stress

	mind.transfer_to(W)

	var/mob/living/carbon/human/species/werewolf/WA = src
	W.copy_known_languages_from(WA.stored_language)
	W.mind.known_skills = WA.stored_skills.Copy()
	W.mind.skill_experience = WA.stored_experience.Copy()

	W.RemoveSpell(new /obj/effect/proc_holder/spell/self/howl)
	W.RemoveSpell(new /obj/effect/proc_holder/spell/self/claws)

	W.regenerate_icons()

	to_chat(W, span_userdanger("I return to my facade."))
	playsound(W.loc, pick('sound/combat/gib (1).ogg','sound/combat/gib (2).ogg'), 200, FALSE, 3)
	W.spawn_gibs(FALSE)
	W.Knockdown(30)
	W.Stun(30)

	qdel(src)
