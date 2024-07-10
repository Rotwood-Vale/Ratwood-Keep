/mob/living/simple_animal/hostile/retaliate/rogue/wolf/poison
	name = "giftig-volf"
	color = "#9AA97F" //this is even worse than a codersprite lol
	retreat_health = 0.1 //go ham - these are meant for dungeons so them running away is just annoying and doesn't rly work.
	del_on_deaggro = 0 //ditto.

//str will show this is a bit more dangerous than usual and increases dmg
	STASTR = 14

/mob/living/simple_animal/hostile/retaliate/rogue/wolf/poison/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(L.reagents)
			L.reagents.add_reagent(/datum/reagent/toxin/venom, 2)
			L.reagents.add_reagent(/datum/reagent/toxin/itching_powder, 6)
