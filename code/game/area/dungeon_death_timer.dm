/datum/component/dungeon_death_timer
    var/warning_time = 30 SECONDS
    var/timer_id

    /datum/component/dungeon_death_timer/Initialize()
        if(!ismob(parent))
            return COMPONENT_INCOMPATIBLE

        RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/check_location)

    /datum/component/dungeon_death_timer/proc/check_location()
        var/mob/M = parent
        var/area/current_area = get_area(M)

        if(istype(current_area, /area/rogue/under/cave/spider))
            if(!timer_id)
                to_chat(M, "<span class='danger'>A searing pain shoots through your skull as you enter the dungeon. You should leave!'</span>")
                timer_id = addtimer(CALLBACK(src, .proc/explode_brain), warning_time, TIMER_STOPPABLE)
        else if(timer_id)
            deltimer(timer_id)
            timer_id = null
            to_chat(M, "<span class='warning'>The pressure in your head subsides as you leave the dungeon. You've escaped... for now.</span>")

    /datum/component/dungeon_death_timer/proc/explode_brain()
        var/mob/M = parent
        to_chat(M, "<span class='userdanger'>Your mind shatters under the weight of incomprehensible horrors. Your last thoughts are a cacophony of madness as your very being is torn asunder!</span>")
        M.visible_message("<span class='danger'>[M]'s head suddenly explodes in a shower of gore!</span>")
        M.gib()

/mob/proc/add_dungeon_death_timer()
    AddComponent(/datum/component/dungeon_death_timer)

/mob/proc/remove_dungeon_death_timer()
    qdel(GetComponent(/datum/component/dungeon_death_timer))