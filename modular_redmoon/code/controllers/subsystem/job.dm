/datum/controller/subsystem/job/proc/get_all_garrison()
	. = list()
	for(var/i in GLOB.human_list)
		var/mob/living/carbon/human/player = i
		if(player.mind && (player.mind.assigned_role in GLOB.garrison_positions))
			. |= player.mind
