

//Processing procs related to dreamer, so he hallucinates and shit
/datum/antagonist/serial_killer/process()
	if(!owner.current)
		STOP_PROCESSING(SSobj, src)
		return

	// The SK kills to get rid of the visions
	if (!prep_phase && !has_killed)
		handle_serialkiller_visions(owner.current, hallucinations)
		handle_serialkiller_hallucinations(owner.current)
		handle_serialkiller_floors(owner.current)
		handle_serialkiller_walls(owner.current)



/mutable_appearance/SK_hallucination
    name = "Serialkiller"
    var/timetodelete

/mutable_appearance/SK_hallucination/New()
    ..()
    timetodelete = world.time + rand(1 SECONDS, 4 SECONDS)

/mutable_appearance/SK_hallucination/process()
	// Doesn't work btw
    if(world.time >= timetodelete)
        QDEL_NULL(src)


/proc/handle_serialkiller_visions(mob/living/target, atom/movable/screen/fullscreen/serialkiller/hallucinations)
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

/proc/handle_serialkiller_hallucinations(mob/living/target)
	//Chasing mob
	if(prob(1))
		INVOKE_ASYNC(target, GLOBAL_PROC_REF(handle_serialkiller_mob_hallucination), target)
	//Talking objects
	else if(prob(4))
		INVOKE_ASYNC(target, GLOBAL_PROC_REF(handle_serialkiller_object_hallucination), target)

/proc/handle_serialkiller_object_hallucination(mob/living/target)
	var/static/list/speech_sounds = list(
		'sound/villain/male_talk1.ogg',
		'sound/villain/male_talk2.ogg',
		'sound/villain/male_talk3.ogg',
		'sound/villain/male_talk4.ogg',
		'sound/villain/male_talk5.ogg',
		'sound/villain/male_talk6.ogg',
		'sound/villain/female_talk1.ogg',
		'sound/villain/female_talk2.ogg',
		'sound/villain/female_talk3.ogg',
		'sound/villain/female_talk4.ogg',
		'sound/villain/female_talk5.ogg',
	)
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
	var/obj/speaker = pickweight(objects)
	var/speech
	if(prob(1))
		speech = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
	else
		speech = pick_list_replacements("serial_killer.json", "objects")
		speech = replacetext(speech, "%OWNER", "[target.real_name]")
	var/language = target.get_random_understood_language()
	var/message = target.compose_message(speaker, language, speech)
	target.playsound_local(target, pick(speech_sounds), vol = 60, vary = FALSE)
	if(target.client.prefs?.chat_on_map)
		target.create_chat_message(speaker, language, speech, spans = list(target.speech_span))
	to_chat(target, message)

/proc/handle_serialkiller_mob_hallucination(mob/living/target)
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
		var/datum/antagonist/serial_killer/SK = target.mind.has_antag_datum(/datum/antagonist/serial_killer)
		target.Stun(rand(2, 4) SECONDS)
		var/pain_message = pick("NO!", "THEY GOT ME!", "AGH!")
		to_chat(target, span_userdanger("[pain_message]"))
		if(!SK) //If they're a serial killer, they don't freak out and get knocked down, they still get stunned. 
			target.freak_out()
			target.Knockdown(10)
	sleep(chase_wait)
	if(!target?.client)
		return
	target.client.images -= mob_image

/proc/handle_serialkiller_floors(mob/living/target)
	if(!target.client)
		return
	//Floors go crazy go stupid
	for(var/turf/open/floor in view(target))
		if(!prob(7))
			continue
		INVOKE_ASYNC(target, GLOBAL_PROC_REF(handle_serialkiller_floor), floor, target)

/proc/handle_serialkiller_floor(turf/open/floor, mob/living/target)
	var/mutable_appearance/SK_hallucination/schizo_floor = image(floor.icon, floor, floor.icon_state, floor.layer + 0.01)
	target.client.images += schizo_floor
	var/offset = pick(-3,-2, -1, 1, 2, 3)
	var/disappearfirst = rand(1 SECONDS, 3 SECONDS) * abs(offset)
	animate(schizo_floor, pixel_y = offset, time = disappearfirst, flags = ANIMATION_RELATIVE)
	sleep(disappearfirst)
	var/disappearsecond = rand(1 SECONDS, 3 SECONDS) * abs(offset)
	animate(schizo_floor, pixel_y = -offset, time = disappearsecond, flags = ANIMATION_RELATIVE)
	sleep(disappearsecond)
	target.client?.images -= schizo_floor

/proc/handle_serialkiller_walls(mob/living/target)
	if(!target.client)
		return
	//Shit on THA walls
	for(var/turf/closed/wall in view(target))
		if(!prob(4))
			continue
		INVOKE_ASYNC(target, GLOBAL_PROC_REF(handle_serialkiller_wall), wall, target)

/proc/handle_serialkiller_wall(turf/closed/wall, mob/living/target)
	var/mutable_appearance/SK_hallucination/schizo_wall = image('icons/roguetown/maniac/shit.dmi', wall, "splat[rand(1,8)]")
	target.client?.images += schizo_wall
	var/offset = pick(-1, 1, 2)
	var/disappearfirst = rand(2 SECONDS, 4 SECONDS)
	animate(schizo_wall, pixel_y = offset, time = disappearfirst, flags = ANIMATION_RELATIVE)
	sleep(disappearfirst)
	var/disappearsecond = rand(2 SECONDS, 4 SECONDS)
	animate(schizo_wall, pixel_y = -offset, time = disappearsecond, flags = ANIMATION_RELATIVE)
	sleep(disappearsecond)
	target.client?.images -= schizo_wall
