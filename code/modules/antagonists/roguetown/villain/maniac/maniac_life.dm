

//Processing procs related to dreamer, so he hallucinates and shit
/datum/antagonist/maniac/process()
	if(!owner.current || triumphed)
		STOP_PROCESSING(SSobj, src)
		return
	handle_maniac_visions(owner.current, hallucinations)
	if(waking_up)
		handle_waking_up(owner.current)
	else
		handle_maniac_hallucinations(owner.current)
	handle_maniac_floors(owner.current)
	handle_maniac_walls(owner.current)


/proc/handle_maniac_visions(mob/living/target, atom/movable/screen/fullscreen/maniac/hallucinations)
	if(prob(4))
		hallucinations.jumpscare(target)
	//Random laughter
	else if(prob(2))
		var/static/list/funnies = list(
			'sound/villain/comic1.ogg',
			'sound/villain/comic2.ogg',
			'sound/villain/comic3.ogg',
			'sound/villain/comic4.ogg',
		)
		target.playsound_local(target, pick(funnies), vol = 100, vary = FALSE)

/proc/handle_maniac_hallucinations(mob/living/target)
	//Chasing mob
	if(prob(1))
		INVOKE_ASYNC(target, GLOBAL_PROC_REF(handle_maniac_mob_hallucination), target)
	//Talking objects
	else if(prob(4))
		INVOKE_ASYNC(target, GLOBAL_PROC_REF(handle_maniac_object_hallucination), target)

/proc/handle_maniac_object_hallucination(mob/living/target)
	var/list/objects = list()
	for(var/obj/object in view(target))
		if((object.invisibility > target.see_invisible) || !object.loc || !object.name)
			continue
		var/weight = 1
		if(isitem(object))
			weight = 3
		else if(isstructure(object))
			weight = 2
		else if(ismachinery(object))
			weight = 2
		objects[object] = weight
	objects -= target.contents
	if(!length(objects))
		return
	var/static/list/speech_sounds = list(
		'sound/villain/female_talk1.ogg',
		'sound/villain/female_talk2.ogg',
		'sound/villain/female_talk3.ogg',
		'sound/villain/female_talk4.ogg',
		'sound/villain/female_talk5.ogg',
		'sound/villain/male_talk1.ogg',
		'sound/villain/male_talk2.ogg',
		'sound/villain/male_talk3.ogg',
		'sound/villain/male_talk4.ogg',
		'sound/villain/male_talk5.ogg',
		'sound/villain/male_talk6.ogg',
	)
	var/obj/speaker = pickweight(objects)
	var/speech
	if(prob(1))
		speech = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
	else
		speech = pick_list_replacements("maniac.json", "dreamer_object")
		speech = replacetext(speech, "%OWNER", "[target.real_name]")
	var/language = target.get_random_understood_language()
	var/message = target.compose_message(speaker, language, speech)
	target.playsound_local(target, pick(speech_sounds), vol = 60, vary = FALSE)
	if(target.client.prefs?.chat_on_map)
		target.create_chat_message(speaker, language, speech, spans = list(target.speech_span))
	to_chat(target, message)

/proc/handle_maniac_mob_hallucination(mob/living/target)
	if(!target.client)
		return
	var/mob_message = pick("It's mom!", "I have to HURRY UP!", "They are CLOSE!","They are NEAR!")
	var/turf/spawning_turf
	var/list/turf/spawning_turfs = list()
	for(var/turf/turf in view(target))
		spawning_turfs += turf
	if(length(spawning_turfs))
		spawning_turf = pick(spawning_turfs)
	if(!spawning_turf)
		return
	var/mob_state = pick("mom", "shadow", "deepone")
	if(mob_message == "It's mom!")
		mob_state = "mom"
	var/image/mob_image = image('icons/roguetown/maniac/dreamer_mobs.dmi', spawning_turf, mob_state, FLOAT_LAYER, get_dir(spawning_turf, target))
	mob_image.plane = GAME_PLANE_UPPER
	target.client.images += mob_image
	to_chat(target, span_userdanger("<span class='big'>[mob_message]</span>"))
	sleep(5)
	if(!target?.client)
		return
	var/static/list/spookies = pick(
		'sound/villain/hall_attack1.ogg',
		'sound/villain/hall_attack2.ogg',
		'sound/villain/hall_attack3.ogg',
		'sound/villain/hall_attack4.ogg',
	)
	target.playsound_local(target, pick(spookies), 100)
	var/chase_tiles = 7
	var/chase_wait = rand(4,6)
	var/caught_dreamer = FALSE
	var/turf/current_turf = spawning_turf
	while(chase_tiles > 0)
		if(!target?.client)
			return
		var/face_direction = get_dir(current_turf, target)
		current_turf = get_step(current_turf, face_direction)
		if(!current_turf)
			break
		mob_image.dir = face_direction
		mob_image.loc = current_turf
		if(current_turf == get_turf(target))
			caught_dreamer = TRUE
			break
		chase_tiles--
		sleep(chase_wait)
	if(!target?.client)
		return
	if(caught_dreamer)
		target.Stun(rand(2, 4) SECONDS)
		var/pain_message = pick("NO!", "THEY GOT ME!", "AGH!")
		to_chat(target, span_userdanger("[pain_message]"))
		target.freak_out()
		target.Knockdown(10)
	sleep(chase_wait)
	if(!target?.client)
		return
	target.client.images -= mob_image

/proc/handle_maniac_floors(mob/living/target)
	if(!target.client)
		return
	//Floors go crazy go stupid
	for(var/turf/open/floor in view(target))
		if(!prob(7))
			continue
		INVOKE_ASYNC(target, GLOBAL_PROC_REF(handle_maniac_floor), floor, target)

/proc/handle_maniac_floor(turf/open/floor, mob/living/target)
	var/mutable_appearance/fake_floor = image(floor.icon, floor, floor.icon_state, floor.layer + 0.01)
	target.client.images += fake_floor
	var/offset = pick(-3,-2, -1, 1, 2, 3)
	var/disappearfirst = rand(1 SECONDS, 3 SECONDS) * abs(offset)
	animate(fake_floor, pixel_y = offset, time = disappearfirst, flags = ANIMATION_RELATIVE)
	sleep(disappearfirst)
	var/disappearsecond = rand(1 SECONDS, 3 SECONDS) * abs(offset)
	animate(fake_floor, pixel_y = -offset, time = disappearsecond, flags = ANIMATION_RELATIVE)
	sleep(disappearsecond)
	target.client?.images -= fake_floor

/proc/handle_maniac_walls(mob/living/target)
	if(!target.client)
		return
	//Shit on THA walls
	for(var/turf/closed/wall in view(target))
		if(!prob(4))
			continue
		INVOKE_ASYNC(target, GLOBAL_PROC_REF(handle_maniac_wall), wall, target)

/proc/handle_maniac_wall(turf/closed/wall, mob/living/target)
	var/image/shit = image('icons/roguetown/maniac/shit.dmi', wall, "splat[rand(1,8)]")
	target.client?.images += shit
	var/offset = pick(-1, 1, 2)
	var/disappearfirst = rand(2 SECONDS, 4 SECONDS)
	animate(shit, pixel_y = offset, time = disappearfirst, flags = ANIMATION_RELATIVE)
	sleep(disappearfirst)
	var/disappearsecond = rand(2 SECONDS, 4 SECONDS)
	animate(shit, pixel_y = -offset, time = disappearsecond, flags = ANIMATION_RELATIVE)
	sleep(disappearsecond)
	target.client?.images -= shit

/datum/antagonist/maniac/proc/handle_waking_up(mob/living/dreamer)
	if(!dreamer.client)
		return
	if(prob(2.5))
		dreamer.emote("laugh")
	//Floors go crazier go stupider
	for(var/turf/open/floor in view(dreamer))
		if(!prob(20))
			continue
		INVOKE_ASYNC(src, PROC_REF(handle_waking_up_floor), floor, dreamer)

/datum/antagonist/maniac/proc/handle_waking_up_floor(turf/open/floor, mob/living/dreamer)
	var/mutable_appearance/fake_floor = image('icons/roguetown/maniac/dreamer_floors.dmi', floor,  pick("rcircuitanim", "gcircuitanim"), floor.layer + 0.1)
	dreamer.client.images += fake_floor
	var/offset = pick(-1, 1, 2)
	var/disappearfirst = 3 SECONDS
	animate(fake_floor, pixel_y = offset, time = disappearfirst, flags = ANIMATION_RELATIVE)
	sleep(disappearfirst)
	var/disappearsecond = 3 SECONDS
	animate(fake_floor, pixel_y = -offset, time = disappearsecond, flags = ANIMATION_RELATIVE)
	sleep(disappearsecond)
	dreamer.client?.images -= fake_floor
