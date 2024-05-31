/mob/living/Topic(href, href_list)
	var/observer_privilege = isobserver(usr)
	if(href_list["check_hb"] && (observer_privilege || usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)))
		if(!observer_privilege)
			usr.visible_message("<span class='info'>[usr] tries to hear [src]'s heartbeat.</span>")
			if(!do_after(usr, 30, needhand = TRUE, target = src))
				return
		var/list/following_my_heart = check_heartbeat(usr)
		if(following_my_heart)
			to_chat(usr, "<span class='info'>[following_my_heart.Join("\n")]</span>")
			
	return ..()

/mob/living/proc/check_heartbeat(mob/user)
	var/list/message = list()
	if(stat >= DEAD)
		message += "<B>No heartbeat...</B>"
	else
		message += "<B>The heart is still beating.</B>"
	var/list/soul_message = soul_examine(user)
	if(soul_message)
		message += soul_message
	return message

/mob/living/proc/soul_examine(mob/user)
	var/list/message = list()
	if(stat >= DEAD)
		if(suiciding)
			message += "<span class='deadsay'>[p_they(TRUE)] commited suicide... Nothing can be done..."
		if(isobserver(user) || HAS_TRAIT(user, TRAIT_SOUL_EXAMINE))
			if(!key && !get_ghost(FALSE, TRUE))
				message += "<span class='deadsay'>[p_their(TRUE)] soul has departed...</span>"
			else
				message += "<span class='deadsay'>[p_they(TRUE)] [p_are()] still earthbound.</span>"
	return message
